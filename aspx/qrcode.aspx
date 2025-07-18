<%@ Page Language="C#" AutoEventWireup="true" %>
<%@Import Namespace="System"%>
<%@Import Namespace="System.IO"%>
<%@Import Namespace="System.Drawing"%>
<%@Import Namespace="System.Security.Cryptography"%>
<%@Import Namespace="System.Text"%>
<%@Import Namespace="QRCoder" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="style.css"/>
</head>
<body>

<div class="row">
    <h3>QR Code</h3>
    <hr />
        <a href="default.aspx">INDEX</a> &nbsp; <a href="">RESET</a>
    <hr />
</div>
<div class="row">
    <form method="post">
        <p>
            <input type="text" name="input" value="<%=inputOut%>" style="width: 100%;"/>
            </p>
        <p>
        <input type="submit" value="submit" name="submit" />
        </p>
    </form>
</div>
<div class="row">
    <p class="alert alert-info">
        <%=output %>
    </p>
    <p class="alert alert-info">
        <%=Debug %>
    </p>   
</div>

</body>
</html>

<script runat="server">

    string input = string.Empty;
    string inputOut = string.Empty;
    string otp = string.Empty;
    string output = string.Empty;
    string Debug = string.Empty;

    string ApplicationName = "Portal";
    string username = @"a bcdefghijklmnopqrstuvwxyz~!@#$%^&*()_+=-`|,./;'\[]{}:""|<>?";
    // string username = "bart uijttenboogaart jeffrey.willemsen";
    string SecretBase32 = "M5RGSZSKN5WEW6DE";
    string qrCodeString = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        otp =
            "otpauth://totp/" +
            ApplicationName + ":" +
            username +
            "?secret=" + SecretBase32 +
            "&issuer=" + ApplicationName +
            "&algorithm=SHA1&digits=6&period=30";
        output += otp + Environment.NewLine;

        ApplicationName = Uri.EscapeDataString(ApplicationName);
        username = Uri.EscapeDataString(username);

        otp =
            "otpauth://totp/" +
            ApplicationName + ":" +
            username +
            "?secret=" + SecretBase32 +
            "&issuer=" + ApplicationName +
            "&algorithm=SHA1&digits=6&period=30";

        output += otp + Environment.NewLine;
        output += ApplicationName + Environment.NewLine;
        output += username + Environment.NewLine;
        output += GroupStringInBlocks(SecretBase32).ToUpper() + Environment.NewLine;

        if (!string.IsNullOrEmpty(Request.Form["submit"]))
        {
            if (!string.IsNullOrEmpty(Request.Form["input"]))
            {
                input = Request.Form["input"];
                
                input = Uri.EscapeDataString(input);
                inputOut = input;
            }
            else
            {
                input = otp;
            }            
            output += Uri.EscapeUriString(input) + Environment.NewLine;
            GenerateQrCode();
            //ManyQrCodeTest();
        }

        input = HttpUtility.UrlDecode(input);
        output = output.Replace(Environment.NewLine, "<br/>");
        Debug = Debug.Replace(Environment.NewLine, "<br/>");
    }

    protected void GenerateQrCode()
    {
        if (!string.IsNullOrEmpty(SecretBase32))
        {
            output += "<img src=\"" + GenerateQrImageInMemory(input) + "\" style=\"width: 166px;\" />" + Environment.NewLine;
        }
    }
    protected string GenerateQrImageInMemory(string code)
    {
        string local = string.Empty;
        QRCodeGenerator qrGenerator = new QRCodeGenerator();
        QRCodeData qrCodeData = qrGenerator.CreateQrCode(code, QRCodeGenerator.ECCLevel.Q);
        QRCode qrCode = new QRCode(qrCodeData);
        Bitmap qrCodeImage = qrCode.GetGraphic(20);

        using (MemoryStream ms = new MemoryStream())
        {
            qrCodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
            byte[] byteImage = ms.ToArray();
            local = "data:image/png;base64," + Convert.ToBase64String(byteImage);
        }

        qrGenerator = null;
        qrCodeData = null;
        qrCode = null;
        qrCodeImage = null;

        return local;
    }
    protected string GroupStringInBlocks(string myString, int blockSize = 4)
    {
        string local = string.Empty;
        string debug = string.Empty;

        if (!string.IsNullOrEmpty(myString))
        {
            int length = myString.Length;
            debug += "length:" + length + Environment.NewLine;

            int number = Math.Abs(myString.Length / blockSize);
            debug += "number:" + number + Environment.NewLine;

            int dividableNumber = number * blockSize;
            debug += "dividableNumber" + dividableNumber + Environment.NewLine;

            int restLength = length - dividableNumber;
            debug += "restLength:" + restLength + Environment.NewLine;

            for (int i = 0; i < number * blockSize; i = i + blockSize)
            {
                local += myString.Substring(i, blockSize) + " ";
                debug += i + "-" + (i + blockSize) + ":" + myString.Substring(i, blockSize) + Environment.NewLine;
            }

            if (restLength > 0)
            {
                local += myString.Substring(dividableNumber, restLength) + " ";
                debug += dividableNumber + "-" + length + ":" + myString.Substring(dividableNumber, restLength) + Environment.NewLine;
            }
        }
        else
        {
            local = myString;
        }

        // Debug += debug + Environment.NewLine;
        return local.Trim();
    }

    protected void ManyQrCodeTest()
    {
        string debug = string.Empty;
        int start = 10;
        int end = 20;
        for (int i = start; i < end; i++)
        {
            byte[] buffer = new byte[i];
            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(buffer);
            }

            string sI = Convert.ToBase64String(buffer).Substring(0, i).Replace('/', '0').Replace('+', '1');

            var sB = new Base32Encoder().Encode(Encoding.ASCII.GetBytes(sI));

            byte[] sBytes = new Base32Encoder().Decode(sB);
            string sO = string.Empty;
            foreach (char ch in sBytes)
            {
                sO += ch;
            }

            input =
                "otpauth://totp/" +
                sI + ":" +
                username +
                "?secret=" + sB +
                "&issuer=" + sI +
                "&algorithm=SHA1&digits=6&period=30";
            input = Uri.EscapeUriString(input);

            debug += input + Environment.NewLine;
            debug += "<img src=\"" + GenerateQrImageInMemory(input) + "\" style=\"width: 166px;\" />" + Environment.NewLine;
            debug += Environment.NewLine;
            debug += Environment.NewLine;

            // output += i + ": " + sI.Length + " " + sB.Length + " " + sI + " > " + sB + " <br/>";
        }
        Debug += debug;
    }

</script>