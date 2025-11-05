<%@ Page Language="C#" AutoEventWireup="true" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Xml.Linq" %>

<textarea style="width: 100%; height: 100%;">
<%=output%>
</textarea>

<script runat="server">

    string output;

    Configuration configuration;
    CustomErrorsSection section;

    protected void Page_Load(object sender, EventArgs e)
    {
        Configuration webConfig = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
        ConfigurationSection cs = webConfig.GetSection("system.webServer");
        if (cs != null)
        {
            XDocument xml = XDocument.Load(new StringReader(cs.SectionInformation.GetRawXml()));
            IEnumerable<XElement> rules = from c in xml.Descendants("rule") select c;

            foreach (XElement rule in rules)
            {
                output += rule.ToString() + Environment.NewLine;
            }
        }

        /*
        configuration = WebConfigurationManager.OpenWebConfiguration("~");
        section = (CustomErrorsSection)configuration.GetSection("system.web/customErrors");
        output += section.DefaultRedirect.ToString() + "<br/>";
        section.DefaultRedirect = "/error";
        configuration.Save();

        output += section.DefaultRedirect.ToString() + "<br/>";
        */
    }

</script>

