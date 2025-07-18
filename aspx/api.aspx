<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Net.Http" %>
<%@ Import Namespace="System.Net.Http.Headers" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Http" %>
<%@ Import Namespace="Portal.Models" %>
<%@ Import Namespace="Portal.Models.Data" %>

<script runat="server">

    string authorizationToken = string.Empty;
    string ip = string.Empty;
    string authorizationTokenCookieName = ConfigModel.WebApiCookieName;

    protected void Page_Load(object sender, EventArgs e)
    {
        //IPHostEntry IPHost = Dns.GetHostEntry(Dns.GetHostName());
        //string externalIP = IPHost.AddressList[0].ToString();

        string ip = GetUserIp();

        string json = "{\"ip\":\"" + ip + "\"}";
        Response.Clear();
        Response.ContentType = "application/json; charset=utf-8";
        Response.Write(json);
        Response.End();
    }

    public string GetUserIp()
    {
        string ipList = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

        if (!string.IsNullOrEmpty(ipList))
        {
            return ipList.Split(',')[0];
        }

        return HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
    }

    private bool IsAuthorized()
    {
        string cookieValue = string.Empty;

        if(Request.Cookies[authorizationTokenCookieName]!=null)
        {
            cookieValue = Request.Cookies[authorizationTokenCookieName].Value;
        }

        // CookieHeaderValue authorizationTokenCookie =  Request.Cookies[authorizationTokenCookieName].Value.FirstOrDefault();

        if (cookieValue != null && !string.IsNullOrEmpty(ip))
        {
            // authorizationToken = authorizationTokenCookie[authorizationTokenCookieName].Value;
            authorizationToken = cookieValue;
            if (!string.IsNullOrEmpty(authorizationToken) && !string.IsNullOrEmpty(ip))
            {
                UserDataModel _user = new UserDataModel();
                return _user.IsAuthorizationTokenAndIpAuthorized(authorizationToken, ip);
            }
        }
        return false;
    }

</script>




