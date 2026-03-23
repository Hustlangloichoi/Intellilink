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

// Global variable: Assigned by IntelliLink.
// DO NOT EDIT!!!
string _linkerName = "";

public Dictionary<string, string> InitializeMapper(Dictionary<string, string> mapper, string message = "")
{
    return mapper;
}

public Dictionary<string, string> SourceToDestination(Dictionary<string, string> mapper, string message)
{
    return mapper;
}

public Dictionary<string, string> DestinationToSource(Dictionary<string, string> mapper, string message)
{
    return mapper;
}