using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Threading;
using System.Windows.Forms;
using System.Threading.Tasks;

namespace Zigt.Models.Lib
{
    public static class UrlToImage
    {
        /// <summary>
        /// Convert url to bitmap byte array
        /// </summary>
        /// <param name="url">Url to browse</param>
        /// <param name="width">width of page (if page contains frame, you need to pass this params)</param>
        /// <param name="height">heigth of page (if page contains frame, you need to pass this params)</param>
        /// <param name="htmlToManipulate">function to manipulate dom</param>
        /// <param name="timeout">in milliseconds, how long can you wait for page response?</param>
        /// <returns>bitmap byte[]</returns>
        /// <example>
        /// byte[] img = new Uri("http://www.uol.com.br").ToImage();
        /// </example>
        public static byte[] ToImage(
            this Uri url, 
            int? width = null,
            int? height = null, 
            Action<HtmlDocument> htmlToManipulate = null, 
            int timeout = -1)
        {
            byte[] toReturn = null;

            Task tsk = Task.Factory.StartNew(() =>
            {
                WebBrowser browser = new WebBrowser() { ScrollBarsEnabled = false };
                browser.Navigate(url);

                browser.DocumentCompleted += (s, e) =>
                {
                    var browserSender = (WebBrowser)s;

                    if (browserSender.ReadyState == WebBrowserReadyState.Complete)
                    {
                        if (htmlToManipulate != null) htmlToManipulate(browserSender.Document);

                        browserSender.ClientSize = new Size(width ?? browser.Document.Body.ScrollRectangle.Width, height ?? browser.Document.Body.ScrollRectangle.Bottom);
                        browserSender.ScrollBarsEnabled = false;
                        browserSender.BringToFront();

                        using (Bitmap bmp = new Bitmap(browserSender.Document.Body.ScrollRectangle.Width, browserSender.Document.Body.ScrollRectangle.Bottom))
                        {
                            browserSender.DrawToBitmap(bmp, browserSender.Bounds);
                            toReturn = (byte[])new ImageConverter().ConvertTo(bmp, typeof(byte[]));
                        }
                    }

                };

                while (browser.ReadyState != WebBrowserReadyState.Complete)
                {
                    Application.DoEvents();
                }

                browser.Dispose();

            }, CancellationToken.None, TaskCreationOptions.None, TaskScheduler.FromCurrentSynchronizationContext());

            tsk.Wait(timeout);

            return toReturn;
        }

    }

    public class WebsiteToImage
    {
        private Bitmap m_Bitmap;
        private string m_Url;
        private string m_FileName = string.Empty;

        public WebsiteToImage(string url)
        {
            // Without file 
            m_Url = url;
        }

        public WebsiteToImage(string url, string fileName)
        {
            // With file 
            m_Url = url;
            m_FileName = fileName;
        }

        public Bitmap Generate()
        {
            // Thread 
            var m_thread = new Thread(_Generate);
            m_thread.SetApartmentState(ApartmentState.STA);
            m_thread.Start();
            m_thread.Join();
            return m_Bitmap;
        }

        private void _Generate()
        {
            var browser = new WebBrowser { ScrollBarsEnabled = false };
            browser.Navigate(m_Url);
            browser.DocumentCompleted += WebBrowser_DocumentCompleted;

            while (browser.ReadyState != WebBrowserReadyState.Complete)
            {
                Application.DoEvents();
            }

            browser.Dispose();
        }

        private void WebBrowser_DocumentCompleted(object sender, WebBrowserDocumentCompletedEventArgs e)
        {
            // Capture 
            var browser = (WebBrowser)sender;
            // browser.ClientSize = new Size(browser.Document.Body.ScrollRectangle.Width, browser.Document.Body.ScrollRectangle.Bottom);
            browser.ClientSize = new Size(1000, browser.Document.Body.ScrollRectangle.Bottom);
            browser.ScrollBarsEnabled = false;
            m_Bitmap = new Bitmap(browser.Document.Body.ScrollRectangle.Width, browser.Document.Body.ScrollRectangle.Bottom);
            browser.BringToFront();
            browser.DrawToBitmap(m_Bitmap, browser.Bounds);

            // Save as file? 
            if (m_FileName.Length > 0)
            {
                // Save 
                m_Bitmap.SaveJPG100(m_FileName);
            }
        }
    }

    public static class BitmapExtensions
    {
        public static void SaveJPG100(this Bitmap bmp, string filename)
        {
            var encoderParameters = new EncoderParameters(1);
            encoderParameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
            bmp.Save(filename, GetEncoder(ImageFormat.Jpeg), encoderParameters);
        }

        public static void SaveJPG100(this Bitmap bmp, Stream stream)
        {
            var encoderParameters = new EncoderParameters(1);
            encoderParameters.Param[0] = new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
            bmp.Save(stream, GetEncoder(ImageFormat.Jpeg), encoderParameters);
        }

        public static ImageCodecInfo GetEncoder(ImageFormat format)
        {
            var codecs = ImageCodecInfo.GetImageDecoders();

            foreach (var codec in codecs)
            {
                if (codec.FormatID == format.Guid)
                {
                    return codec;
                }
            }

            // Return 
            return null;
        }
    }

}