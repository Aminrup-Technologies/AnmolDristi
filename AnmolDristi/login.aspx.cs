using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Img_CpLogo.ImageUrl = "WebData/Anmol_Logo.png";
            lbl_companyname.Text = "Anmol Industries Limited";
            lbl_currentyr.Text = DateTime.Now.Year.ToString();
            lbl_compfooter.Text = "Anmol Industries Limited";
            lbl_owner.Text = "IT Department";
        }

        protected void btn_signin_Click(object sender, EventArgs e)
        {

        }
    }
}