using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace AnmolDristi
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        //protected void Application_Error(object sender, EventArgs e)
        //{
        //    Exception ex = Server.GetLastError();
        //    if (ex != null)
        //    {
        //        // Clear the error to prevent ASP.NET from showing its own error page
        //        Server.ClearError();

        //        HttpException httpEx = ex as HttpException;
        //        string redirectUrl;

        //        if (httpEx != null)
        //        {
        //            int httpCode = httpEx.GetHttpCode();

        //            // Handle 404 errors specifically
        //            if (httpCode == 404)
        //            {
        //                redirectUrl = "~/404.aspx";
        //            }
        //            else
        //            {
        //                // General error handling
        //                redirectUrl = "~/404.aspx";
        //            }
        //        }
        //        else
        //        {
        //            // General error page for non-HTTP exceptions
        //            redirectUrl = "~/404.aspx";
        //        }

        //        // Ensure no headers or content have been sent before redirecting
        //        if (!Response.HeadersWritten)
        //        {
        //            Response.Redirect(redirectUrl, false);
        //            Context.ApplicationInstance.CompleteRequest(); // End the request pipeline gracefully
        //        }
        //    }
        //}

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();

            if (ex != null)
            {
                // Clear the error to prevent ASP.NET from showing its own error page
                Server.ClearError();

                // Check if debugging is enabled
                if (HttpContext.Current.IsDebuggingEnabled)
                {
                    // In debug mode, let ASP.NET display detailed error information
                    Response.Write("<h1>Error Details</h1>");
                    Response.Write($"<p>{ex.Message}</p>");
                    Response.Write($"<pre>{ex.StackTrace}</pre>");
                    Response.End(); // Stop further processing
                    return;
                }

                HttpException httpEx = ex as HttpException;
                string redirectUrl;

                if (httpEx != null)
                {
                    int httpCode = httpEx.GetHttpCode();

                    // Handle 404 errors specifically
                    if (httpCode == 404)
                    {
                        redirectUrl = "~/404.aspx";
                    }
                    else
                    {
                        // General error handling
                        redirectUrl = "~/Error.aspx"; // Change this as per your error page
                    }
                }
                else
                {
                    // General error page for non-HTTP exceptions
                    redirectUrl = "~/Error.aspx"; // Change this as per your error page
                }

                // Ensure no headers or content have been sent before redirecting
                if (!Response.HeadersWritten)
                {
                    Response.Redirect(redirectUrl, false);
                    Context.ApplicationInstance.CompleteRequest(); // End the request pipeline gracefully
                }
            }
        }


        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}