using System;
using System.Collections.Generic;
using System.Xml;
using System.Xml.Linq;
using System.Text;
using System.Globalization;
using IntelliLink.IntelliLinkLibrary.Foundation.HL7;
using NLog;
using IntelliLink.IntelliLinkLibrary.Foundation.Logger;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using IntelliLink;
using IntelliLink.IntelliLinkLibrary;
using IntelliLink.IntelliLinkLibrary.Foundation;
using IntelliLink.ServiceManager;

// Global variable: Assigned by IntelliLink.
// DO NOT EDIT!!!
string _linkerName = "";
Hl7Service _hl7Service = null;

private Hl7Service GetHl7Service()
{
    if (_hl7Service != null)
    {
        return _hl7Service;
    }

    // 연동 설정 값 로드
    var linkerConfig = IntelliLinkConfig.Instance().GetLinker(_linkerName);
    var encoding = linkerConfig.encoding;
    
    // HL7 설정 가져오기
    var hl7Config = linkerConfig.DetailConfig.SourceConfig.TcpListenerConfig.MessageTypeConfig.Hl7Config;
    hl7Config.MshConfig.VersionId = "2.7";

    // Hl7Service 생성 및 캐싱
    _hl7Service = new Hl7Service(linkerConfig.DetailConfig.GeneralConfig, hl7Config, encoding);
    
    return _hl7Service;
}

public Dictionary<string, string> InitializeMapper(Dictionary<string, string> mapper, string message = "")
{
    // 초기화 시점에 미리 Service를 로드해둘 수 있음
    var service = GetHl7Service();
    return mapper;
}

public Dictionary<string, string> SourceToDestination(Dictionary<string, string> mapper, string message)
{
    try
    {
        // IntelliLink tự wrap thành <message>...</message>
        // XElement.Value tự decode &amp; → & 
        var xdoc = XDocument.Parse(message);
        var decodedText = xdoc.Root?.Value;

        if (string.IsNullOrEmpty(decodedText))
        {
            var errMsg = "HL7 message is null or empty.";
            Log.GetLogger(_linkerName).Error(errMsg);
            throw new Exception(errMsg);
        }

        Log.GetLogger(_linkerName).Info($"HL7 message:{Environment.NewLine}" + decodedText);

        var service = GetHl7Service();
        var status = service.ParseInboundHl7(decodedText);
        if (status != Hl7Parser.Status.Success)
        {
            var errMsg = $"ParseInboundHl7 failed with status: {status}";
            Log.GetLogger(_linkerName).Error(errMsg);
            throw new Exception(errMsg);
        }

        var xmlOut = service.Parser().GetHl7MessageContext().Inbound.OutXml;
        var newMapper = XmlMapper.GetMapper(xmlOut);
        mapper = XmlMapper.Concat(mapper, newMapper);
    }
    catch (Exception ex)
    {
        Log.GetLogger(_linkerName).Fatal($"{ex.Message}");
        throw;
    }

    return mapper;
}

public Dictionary<string, string> DestinationToSource(Dictionary<string, string> mapper, string message)
{
    try
    {
        var service = GetHl7Service();

        // DB 처리 결과에 따라 ACK 코드 결정
        var dbResult = mapper.ContainsKey("@IL_DB_RESULT") ? mapper["@IL_DB_RESULT"] : null;
        var bDbResult = Convert.ToBoolean(dbResult);
        var defaultHl7Ack = service.Parser().GetAck(bDbResult);

        // ERR 세그먼트 추가
        var err3 = bDbResult ? "0" : "207"; // 0	: Message accepted, 207	: Application internal error
        var err4 = bDbResult ? "I" : "E"; // I : Information, E : Error
        var err5 = bDbResult ? "0" : "1"; // 0 : Success 외 값 실패 - 병원 정의 값
        var errSegment = nameof(Hl7Standard.Segment.ERR) + $"|||{err3}|{err4}|{err5}" + Hl7Standard.Delimiter.SEGMENT_TERMINATOR;

        var hl7Ack = defaultHl7Ack + errSegment;
        Log.GetLogger(_linkerName).Info($"HL7 before Base64 encoding:{Environment.NewLine}" + hl7Ack);

        var encodedHl7Ack = Convert.ToBase64String(Encoding.UTF8.GetBytes(hl7Ack));
        mapper["@ACK"] = encodedHl7Ack;

        return mapper;
    }
    catch (Exception ex)
    {
        Log.GetLogger(_linkerName).Fatal($"{ex.Message}");
        throw;
    }
}