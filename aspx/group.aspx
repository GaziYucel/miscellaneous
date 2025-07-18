<%@ Page Language="C#" AutoEventWireup="true" %>
<%@Import Namespace="System"%>
<%@Import Namespace="System.IO"%>
<%@Import Namespace="System.Security.Cryptography"%>
<%@Import Namespace="System.Text"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" href="style.css"/>
</head>
<body>

<div class="row">
    <h3>Group String In Blocks</h3>
    <hr />
        <a href="default.aspx">INDEX</a> &nbsp; <a href="">RESET</a>
    <hr />
</div>
<div class="row">
    <form method="post">
        <p>
            <input type="text" name="input" value="<%=input%>" style="width: 100%;"/>
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
    string output = string.Empty;
    string Debug = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.Form["submit"]))
        {
            if (!string.IsNullOrEmpty(Request.Form["input"])) { input = Request.Form["input"]; }
            output = GroupStringInBlocks(input);
        }
        Debug = Debug.Replace(Environment.NewLine, "<br/>");
    }

    public string GroupStringInBlocks(string myString, int blockSize = 4)
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
                debug += i + "-" + (i+blockSize) + ":" + myString.Substring(i, blockSize) + Environment.NewLine;
            }

            if (restLength > 0)
            {
                local += myString.Substring(dividableNumber, restLength) + " ";
                debug += dividableNumber + "-" + length + ":" + myString.Substring(dividableNumber, restLength) + Environment.NewLine;
            }
        }
        else
        {
            return myString;
        }

        Debug += debug + Environment.NewLine;
        return local.Trim();
    }

</script>