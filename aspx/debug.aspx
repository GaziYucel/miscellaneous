<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="MyProject.Models" %>
<div style="word-wrap: break-word;">
    <%=LogModel.Get()%>
</div>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        LogModel.CleanUpLog();
    }

</script>
