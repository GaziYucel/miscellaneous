<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="MyProject.Models" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%=output %>
        </div>
    </form>
</body>
</html>

<script runat="server">

    string output = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        output += Helper.GetCookieValue(ConfigModel.appCookieName) + "<br/>";
    }

</script>