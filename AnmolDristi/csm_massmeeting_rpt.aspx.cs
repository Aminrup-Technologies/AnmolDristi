using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class csm_massmeeting_rpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Image1.Visible = true;
            Image2.Visible = true;

            lbl_mmid.Text = "ATS/DOC/MM/0010";
            lbl_report_title.Text = "MASS MEETING REPORT";
            lbl_mmdate.Text = "22-03-2025";
            Image1.ImageUrl = "WebData/Internal/tick-icon.png";
            Image2.ImageUrl = "WebData/Internal/cross_icon.png";

            int p1 = 1;
            if (p1==1)
            {
                Image1.Visible = true;
                Image2.Visible = false;
            }
            else
            {
                Image1.Visible = false;
                Image2.Visible = true;
            }
        }
    }
}