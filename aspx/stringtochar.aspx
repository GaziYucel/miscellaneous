<%@ Page Language="C#" AutoEventWireup="true" %>

<html>
<head>
    
</head>
    <body>
        <form id="form1" runat="server">
            Input string <br/>
            <asp:TextBox ID="txtInput" runat="server" Width="300px"></asp:TextBox><br/>
            Output char<br/>
            <asp:Literal ID="ltlOutput" runat="server"></asp:Literal>
            <br/>
            <asp:Button ID="btnConvert" runat="server" Text="Convert" OnClick="btnConvert_Click" />
        </form>
    </body>
</html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnConvert_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtInput.Text))
        {
            string input = txtInput.Text;
            string output = string.Empty;
            char[] charArr = input.ToCharArray();

            foreach (char ch in charArr)
            {
                if (ch == '\'')
                {
                    output += "'" + "\\'" + "'" + ",";
                }
                else
                {
                    output += "'" + ch + "'" + ",";    
                }
            }

            output = output.Trim(',');
            ltlOutput.Text = "{" + output + "}";
        }
    }
</script>

