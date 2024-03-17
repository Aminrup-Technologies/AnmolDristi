using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string PN_WelcomeBack_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Regular Success',
                                text: 'Welcome back to ATS Web Portal',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

            // RegisterStartupScript adds the JavaScript code to the page
            ClientScript.RegisterStartupScript(this.GetType(), "ShowWelcomeNotification", PN_WelcomeBack_script, false);
        }
    }
}