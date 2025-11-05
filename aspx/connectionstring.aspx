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
    <h3>Connection String</h3>
    <hr />
        <a href="default.aspx">INDEX</a> &nbsp; <a href="">RESET</a>
    <hr />
</div>
<div class="row">
    <form method="post">
        <p>
            cryptKey (exact 32 karakters / 256bit):<br />
            <input type="text" name="cKey" value="<%=cKey%>" style="width: 100%;" maxlength="32" placeholder="12345678901234567890123456789012" />
            </p>
        <p>
            authKey (exact 32 karakters / 256bit):<br />
            <input type="text" name="aKey" value="<%=aKey%>" style="width: 100%;"maxlength="32"  placeholder="12345678901234567890123456789012" />
        </p>
        <p>
            connection string: <br />
            <input type="text" name="connString" value="<%=connString%>" style="width: 100%;"  placeholder="server='server-adres';uid='gebruikersnaam';database='database';pwd='wachtwoord';" />
        </p>
        <p>
        <input type="submit" value="submit" name="submit" />
        </p>
    </form>
</div>
<div class="row">
    <p class="alert alert-info">
        <%=message %>
    </p>
    <p class="alert alert-info">
        Models.Data.DataModel char[] _c1 (Base64 Encoded)<br /> 
        <%=outputCKey%><br />
    </p>
    <p class="alert alert-info">
        Models.Data.DataModel char[] _c2 (Base64 Encoded)<br /> 
        <%=outputAKey%><br />
    </p>   
    <p class="alert alert-info">
        Web.config app key applicationid (Base64 Encoded)<br />
        <%=outputConn%><br />
    </p>
</div>

</body>
</html>

<script runat="server">

    string message = string.Empty;

    string cKey = string.Empty;
    string aKey = string.Empty;
    string connString = string.Empty;

    string cKeyB64 = string.Empty;
    string aKeyB64 = string.Empty;

    byte[] cKeyB;
    byte[] aKeyB;

    string connE = string.Empty;
    string connD = string.Empty;

    string outputCKey = string.Empty;
    string outputAKey = string.Empty;
    string outputConn = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        cKeyB64 = Base64Encode(cKey);
        aKeyB64 = Base64Encode(aKey);

        cKeyB = Convert.FromBase64String(cKeyB64);
        aKeyB = Convert.FromBase64String(aKeyB64);

        if (!string.IsNullOrEmpty(Request.Form["submit"]))
        {
            if (!string.IsNullOrEmpty(Request.Form["cKey"])) { cKey = Request.Form["cKey"]; }
            if (!string.IsNullOrEmpty(Request.Form["aKey"])) { aKey = Request.Form["aKey"]; }
            if (!string.IsNullOrEmpty(Request.Form["connString"])) { connString = Request.Form["connString"]; }

            if(cKey.Length == 32 && aKey.Length == 32)
            {
                cKeyB64 = Base64Encode(cKey);
                aKeyB64 = Base64Encode(aKey);

                cKeyB = Convert.FromBase64String(cKeyB64);
                aKeyB = Convert.FromBase64String(aKeyB64);

                connE = Encrypt(connString, cKeyB, aKeyB);
                connD = Decrypt(connE, cKeyB, aKeyB);

                outputCKey = ConvertStringToCharVarString(cKeyB64);
                outputAKey = ConvertStringToCharVarString(aKeyB64);
                outputConn = Base64Encode(connE);
            }
            else
            {
                message += "<strong>cryptKey en authKey moeten precies 32 karakters lang zijn</strong>" + Environment.NewLine;
            }
        }

        message = message.Replace(Environment.NewLine, "<br>");
    }

    public  string Base64Encode(string plainText)
    {
        var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
        return System.Convert.ToBase64String(plainTextBytes);
    }
    public  string Base64Decode(string base64String)
    {
        var base64EncodedBytes = System.Convert.FromBase64String(base64String);
        return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
    }
    public string ConvertStringToCharVarString(string input)
    {
        string output = string.Empty;
        if (!string.IsNullOrEmpty(input))
        {
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

            return output.Trim(',');
        }
        return input;
    }

    // encryption logic
    private static readonly RandomNumberGenerator Random = RandomNumberGenerator.Create();
    private int BlockBitSize = 128;
    private int KeyBitSize = 256;
    public byte[] NewKey()
    {
        var key = new byte[KeyBitSize / 8];
        Random.GetBytes(key);

        return key;
    }
    public string NewKeyBase64Encoded()
    {
        return Convert.ToBase64String(NewKey());
    }
    public string Encrypt(string secretMessage, byte[] cryptKey, byte[] authKey)
    {
        if (string.IsNullOrEmpty(secretMessage))
        {
            //throw new ArgumentException("Secret Message Required!", nameof(secretMessage));
        }

        var plainText = Encoding.UTF8.GetBytes(secretMessage);
        var cipherText = Encrypt(plainText, cryptKey, authKey);

        return Convert.ToBase64String(cipherText);
    }
    public byte[] Encrypt(byte[] secretMessage, byte[] cryptKey, byte[] authKey)
    {
        if (cryptKey == null || cryptKey.Length != KeyBitSize / 8)
        {
            //throw new ArgumentException($"Key needs to be {KeyBitSize} bit!", nameof(cryptKey));
        }

        if (authKey == null || authKey.Length != KeyBitSize / 8)
        {
            // throw new ArgumentException($"Key needs to be {KeyBitSize} bit!", nameof(authKey));
        }

        if (secretMessage == null || secretMessage.Length < 1)
        {
            // throw new ArgumentException("Secret Message Required!", nameof(secretMessage));
        }

        byte[] cipherText;
        byte[] iv;

        using (var aes = CreateAes())
        {
            // Use random IV
            aes.GenerateIV();
            iv = aes.IV;

            using (var encrypter = aes.CreateEncryptor(cryptKey, iv))
            {
                using (var cipherStream = new MemoryStream())
                {
                    using (var cryptoStream = new CryptoStream(cipherStream, encrypter, CryptoStreamMode.Write))
                    {
                        using (var binaryWriter = new BinaryWriter(cryptoStream))
                        {
                            binaryWriter.Write(secretMessage);
                        }
                    }

                    cipherText = cipherStream.ToArray();
                }
            }
        }

        // Assemble encrypted message and add authentication
        using (var hmac = new HMACSHA256(authKey))
        {
            using (var encryptedStream = new MemoryStream())
            {
                using (var binaryWriter = new BinaryWriter(encryptedStream))
                {
                    // Prepend IV
                    binaryWriter.Write(iv);

                    // Write Ciphertext
                    binaryWriter.Write(cipherText);
                    binaryWriter.Flush();

                    // Authenticate all data
                    var tag = hmac.ComputeHash(encryptedStream.ToArray());

                    // Postpend tag
                    binaryWriter.Write(tag);
                }

                return encryptedStream.ToArray();
            }
        }
    }
    public string Decrypt(string encryptedMessage, byte[] cryptKey, byte[] authKey)
    {
        if (string.IsNullOrWhiteSpace(encryptedMessage))
        {
            //throw new ArgumentException("Encrypted Message Required!", nameof(encryptedMessage));
        }

        var cipherText = Convert.FromBase64String(encryptedMessage);
        var plainText = Decrypt(cipherText, cryptKey, authKey);

        return plainText == null ? null : Encoding.UTF8.GetString(plainText);
    }
    public byte[] Decrypt(byte[] encryptedMessage, byte[] cryptKey, byte[] authKey)
    {
        if (cryptKey == null || cryptKey.Length != KeyBitSize / 8)
        {
            //throw new ArgumentException($"CryptKey needs to be {KeyBitSize} bit!", nameof(cryptKey));
        }

        if (authKey == null || authKey.Length != KeyBitSize / 8)
        {
            //throw new ArgumentException($"AuthKey needs to be {KeyBitSize} bit!", nameof(authKey));
        }

        if (encryptedMessage == null || encryptedMessage.Length == 0)
        {
            //throw new ArgumentException("Encrypted Message Required!", nameof(encryptedMessage));
        }

        using (var hmac = new HMACSHA256(authKey))
        {
            var sentTag = new byte[hmac.HashSize / 8];

            var calcTag = hmac.ComputeHash(encryptedMessage, 0, encryptedMessage.Length - sentTag.Length);
            var ivLength = (BlockBitSize / 8);

            if (encryptedMessage.Length < sentTag.Length + ivLength)
            {
                return null;
            }

            Array.Copy(encryptedMessage, encryptedMessage.Length - sentTag.Length, sentTag, 0, sentTag.Length);

            // Compare Tag with constant time comparison
            var compare = 0;
            for (var i = 0; i < sentTag.Length; i++)
            {
                compare |= sentTag[i] ^ calcTag[i];
            }

            // If message doesn't authenticate return null
            if (compare != 0)
            {
                return null;
            }

            using (var aes = CreateAes())
            {
                // Grab IV from message
                var iv = new byte[ivLength];
                Array.Copy(encryptedMessage, 0, iv, 0, iv.Length);

                using (var decrypter = aes.CreateDecryptor(cryptKey, iv))
                {
                    using (var plainTextStream = new MemoryStream())
                    {
                        using (var decrypterStream = new CryptoStream(plainTextStream, decrypter, CryptoStreamMode.Write))
                        {
                            using (var binaryWriter = new BinaryWriter(decrypterStream))
                            {
                                binaryWriter.Write(
                                    encryptedMessage,
                                    iv.Length,
                                    encryptedMessage.Length - iv.Length - sentTag.Length
                                );
                            }
                        }

                        return plainTextStream.ToArray();
                    }
                }
            }
        }
    }
    private Aes CreateAes()
    {
        var aes = Aes.Create();
        aes.KeySize = KeyBitSize;
        aes.BlockSize = BlockBitSize;
        aes.Mode = CipherMode.CBC;
        aes.Padding = PaddingMode.PKCS7;

        return aes;
    }

</script>