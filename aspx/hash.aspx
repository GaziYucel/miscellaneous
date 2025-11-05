<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="MyProject.Models.Data" %>
<%@ Import Namespace="Chilkat" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Input: <asp:TextBox ID="TextBox1" runat="server" Width="600px"></asp:TextBox><br/><br/>
            Output: <asp:label ID="Label1" runat="server" Width="600px"></asp:label><br/><br/>
            <asp:Button ID="btnHash" runat="server" OnClick="btnHash_Click" Text="Hash" />
            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
        </div>
    </form>
</body>
</html>

<script runat="server">

    protected void btnHash_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(TextBox1.Text))
        {
            Label1.Text = HashString(TextBox1.Text);
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        TextBox1.Text = string.Empty;
        Label1.Text = string.Empty;
    }

    protected string HashString(string stringValue)
    {
        if (stringValue.Length > 0)
        {
            Crypt2 crypt = new Crypt2();
            crypt.UnlockComponent("license-code-goes-here");
            crypt.HashAlgorithm = "sha384";
            return crypt.HashStringENC(stringValue);
        }
        else
        {
            return stringValue;
        }
    }


</script>