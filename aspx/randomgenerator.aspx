<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="Portal.Models" %>
<%@ Import Namespace="Portal.Models.Lib" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<%@ Import Namespace="System.Text" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="style.css"/>
</head>
<body>

<div class="row">
    <h3>Random Generator</h3>    <p>
    <hr />
        <a href="default.aspx">INDEX</a> &nbsp; <a href="">RESET</a>
    <hr />
</div>
<div class="row">
    <form method="post">
        <p>
        <input type="submit" value="submit" name="submit" />
        </p>
    </form>
</div>
<div class="row">
    <pre><%=message %></pre>
</div>
</body>
</html>

<script runat="server">

    protected string message = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.Form["submit"]))
        {
            message += "RNGTest" + "<br/>";
            RNGTest();
            message += "<br/>";

            message += "RandomGeneratorLoop" + "<br/>";
            RandomGeneratorLoop();
            message += "<br/>";

            message += "GuidLoop" + "<br/>";
            GuidLoop();
            message += "<br/>";

            message += "SimpleTest" + "<br/>";
            SimpleTest();
            message += "<br/>";
        }
    }

    protected void RNGTest()
    {
        int i = 20;
        byte[] buffer = new byte[i];
        using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
        {
            rng.GetBytes(buffer);
        }

        string sR = Convert.ToBase64String(buffer).Replace('/', '0').Replace('+', '1');
        string sI = sR.Substring(0, i);

        var sB = new Base32Encoder().Encode(Encoding.ASCII.GetBytes(sI));

        byte[] sBytes = new Base32Encoder().Decode(sB);
        string sO = string.Empty;
        foreach (char ch in sBytes)
        {
            sO += ch;
        }
        message += i + ": " + sI.Length + " " + sB.Length + " " + sR.Length + " " + sI + ":" + sO + ":" + sR + " > " + sB + " <br/>";
    }

    protected void GuidLoop()
    {
        var guid = Guid.NewGuid().ToString("N") +
            Guid.NewGuid().ToString("N") +
            Guid.NewGuid().ToString("N");

        for (int i = 10; i < 30; i++)
        {
            byte[] buffer = new byte[i];
            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(buffer);
            }

            string sI = guid.Substring(0, i);

            var sB = new Base32Encoder().Encode(Encoding.ASCII.GetBytes(sI));

            byte[] sBytes = new Base32Encoder().Decode(sB);
            string sO = string.Empty;
            foreach (char ch in sBytes)
            {
                sO += ch;
            }
            message += i + ": " + sI.Length + " " + sB.Length + " " + sI + " > " + sB + " <br/>";
        }
    }

    protected void RandomGeneratorLoop()
    {
        for (int i = 10; i < 30; i++)
        {
            byte[] buffer = new byte[i];
            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(buffer);
            }

            string sRng = Encoding.UTF8.GetString(buffer);
            string sI = Convert.ToBase64String(buffer).Substring(0, i).Replace('/', '0').Replace('+', '1');

            var sB = new Base32Encoder().Encode(Encoding.ASCII.GetBytes(sI));

            byte[] sBytes = new Base32Encoder().Decode(sB);
            string sO = string.Empty;
            foreach (char ch in sBytes)
            {
                sO += ch;
            }
            message += i + ": " + sI.Length + " " + sB.Length + " " + sRng + " > " + sI + " > " + sB + " <br/>";
        }
    }

    protected void SimpleTest()
    {
        string sI = "helloworld!";

        var sB = new Base32Encoder().Encode(Encoding.ASCII.GetBytes(sI));

        byte[] sBytes = new Base32Encoder().Decode(sB);
        string sO = string.Empty;
        foreach (char ch in sBytes)
        {
            sO += ch;
        }
        message += "sI " + sI.Length + " " + sI + " <br/>";
        message += "sB " + sB.Length + " " + sB + " <br/>";
        message += "sO " + sO.Length + " " + sO + " <br/>";
    }

</script>
