// To reference a DLL, use the '#r' directive and add a 'using' directive.
// e.g.)  #r "System.Windows.Forms"
//      using System.Windows.Forms;

#r "System.Text.Json"
#r "System.Xml"
#r "System.Xml.Linq"

using System.Collections.Generic;
using System.Text.Json;
using System.Xml;
using System.Xml.Linq;
using System.Text;
using System.Globalization;

// Global variable: Assigned by IntelliLink.
// DO NOT EDIT!!!
string _linkerName = "";

// 연동 시작 전 행위
public bool PreAction(Dictionary<string, string> mapper, string message = "")
{
    return true;
}

// 연동 끝난 후 행위
public bool PostAction(Dictionary<string, string> mapper, string message)
{
    return true;
}