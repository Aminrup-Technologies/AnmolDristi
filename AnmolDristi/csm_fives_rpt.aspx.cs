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
            int p1r2_value = 0;

            if (p1r1_value == 1)
            {
                p1r1_tick.Visible = true;
            }
            else
            {
                p1r1_cross.Visible = true;
            }

            if (p1r2_value == 1)
            {
                p1r2_tick.Visible = true;
            }
            else
            {
                p1r2_cross.Visible = true;
            }
        }
    }
}