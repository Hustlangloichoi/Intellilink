using System;
using System.Collections.Generic;
using System.Xml.Linq;
using System.Text;
using IntelliLink.IntelliLinkLibrary.Foundation.HL7;
using NLog;
using IntelliLink.IntelliLinkLibrary.Foundation;
using IntelliLink.ServiceManager;

string _linkerName = "";
Hl7Service _hl7Service = null;

private Hl7Service GetHl7Service()
{
    if (_hl7Service != null) return _hl7Service;

    var linkerConfig = IntelliLinkConfig.Instance().GetLinker(_linkerName);
    var encoding = linkerConfig.encoding;
    var hl7Config = linkerConfig.DetailConfig.SourceConfig.TcpSenderConfig.MessageTypeConfig.Hl7Config;
    hl7Config.MshConfig.VersionId = "2.7";
    _hl7Service = new Hl7Service(linkerConfig.DetailConfig.GeneralConfig, hl7Config, encoding);
    return _hl7Service;
}

public Dictionary<string, string> InitializeMapper(Dictionary<string, string> mapper, string message = "")
{
    GetHl7Service();
    return mapper;
}

// PACS -> HIS: string message có thể là XML/JSON chứa root data, hoặc từ SQL/XSLT pipeline
public Dictionary<string, string> SourceToDestination(Dictionary<string, string> mapper, string message)
{
    try
    {
        // Nếu cần Receiver --> HIS, construct HL7 ở đây hoặc dùng XSLT path
        // 1. Hiện có để mapper từ dữ liệu trường (DB) sang message / route
        mapper["@ORC.ORDER_CONTROL"] = "OK";
        mapper["@PID.PATIENT_ID"] = mapper.ContainsKey("PATIENT_ID") ? mapper["PATIENT_ID"] : "";
        mapper["@OBR.ACCESSION_NUMBER"] = mapper.ContainsKey("ACCESS_NO") ? mapper["ACCESS_NO"] : "";
        // ... set thêm trường nếu cần
        mapper["@IL_IS_OUTBOUND"] = "true";
        return mapper;
    }
    catch (Exception ex)
    {
        Log.GetLogger(_linkerName).Fatal(ex.ToString());
        throw;
    }
}

// Response (hoặc ACK từ HIS)
public Dictionary<string, string> DestinationToSource(Dictionary<string, string> mapper, string message)
{
    try
    {
        // nếu sender nhận ack, lưu vào mapper
        mapper["@SEND_RESULT"] = "ACK_RECEIVED";
        return mapper;
    }
    catch (Exception ex)
    {
        Log.GetLogger(_linkerName).Fatal(ex.ToString());
        throw;
    }
}