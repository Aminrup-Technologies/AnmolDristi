using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class csm_fives_rpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int p1r1_value = 1;
            lbl_p1r1_txt.Text = "is this floor area free of unwanted items?";
            if (p1r1_value == 1) //Yes or Ok
            {
                p1r1_tick.Visible = true;
                p1r1_cross.Visible = false;
                lbl_p1r1_rmrks.Visible = false;
                lbl_p1r1_rmrks.Text = "";
            }
            else
            {//Not Ok
                p1r1_tick.Visible = false;
                p1r1_cross.Visible = true;
                lbl_p1r1_rmrks.Visible = true;
                lbl_p1r1_rmrks.Text = "Floor was untidy and water clogs were there";
            }
        }
    }
}