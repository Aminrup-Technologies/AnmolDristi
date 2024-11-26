using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Mail;
using System.Configuration;

namespace AnmolDristi
{
    public class EmailNotifier
    {
        public static void Notify(string subject, string body, List<string> recipients)
        {
            try
            {
                var smtpSettings = new
                {
                    //Host = ConfigurationManager.AppSettings["SmtpSettings:Host"],
                    //Port = int.Parse(ConfigurationManager.AppSettings["SmtpSettings:Port"]),
                    //EnableSsl = bool.Parse(ConfigurationManager.AppSettings["SmtpSettings:EnableSsl"]),
                    //Username = ConfigurationManager.AppSettings["SmtpSettings:Username"],
                    //Password = ConfigurationManager.AppSettings["SmtpSettings:Password"],
                    //FromEmail = ConfigurationManager.AppSettings["SmtpSettings:FromEmail"]

                    Host = "smtp-mail.outlook.com",
                    Port = 587,
                    EnableSsl = true,
                    Username = "symphonymis@anmolindustries.com",
                    Password = "Welc0meB@ckSymp2024",
                    FromEmail = "symphonymis@anmolindustries.com"

                };

                using (var client = new SmtpClient(smtpSettings.Host, smtpSettings.Port))
                {
                    client.Credentials = new NetworkCredential(smtpSettings.Username, smtpSettings.Password);
                    client.EnableSsl = smtpSettings.EnableSsl;

                    var mailMessage = new MailMessage
                    {
                        From = new MailAddress(smtpSettings.FromEmail),
                        Subject = subject,
                        Body = body,
                        IsBodyHtml = true
                    };

                    // Add recipients
                    foreach (var recipient in recipients)
                    {
                        mailMessage.To.Add(recipient);
                    }

                    client.Send(mailMessage);
                }
            }
            catch (Exception ex)
            {
                // Log errors in case email sending fails
                System.IO.File.AppendAllText("EmailErrorLog.txt", $"Failed to send email: {ex.Message}\n");
            }
        }
    }
}