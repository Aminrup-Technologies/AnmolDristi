using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
	public partial class Audit_Report : System.Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Data for Row 2
                string beforeImageUrl = "~/WebData/img/photo-1.png"; // Replace with actual path
                string afterImageUrl = "~/WebData/img/photo-2.png";   // Replace with actual path
                string observation = "found unused Materials stored in the work pace.";
                string action = "it should be kept in designated place";

                // Assign to controls
                imgBefore_1.ImageUrl = beforeImageUrl;
                imgAfter_1.ImageUrl = afterImageUrl;

                lblObservation_1.Text = observation;
                lblAction_1.Text = action;

                // Optional visibility control
                imgBefore_1.Visible = !string.IsNullOrEmpty(beforeImageUrl);
                imgAfter_1.Visible = !string.IsNullOrEmpty(afterImageUrl);
                lblObservation_1.Visible = !string.IsNullOrEmpty(observation);
                lblAction_1.Visible = !string.IsNullOrEmpty(action);


                // Data for Row 2
                string beforeImageUrl2 = "~/WebData/img/photo-1.png"; // Replace with actual path
                string afterImageUrl2 = "~/WebData/img/photo-2.png";   // Replace with actual path
                string observation2 = "Few steel scraps laid under the conveyor.";
                string action2 = "It is to be removed.";

                // Assign to controls
                imgBefore_2.ImageUrl = beforeImageUrl2;
                imgAfter_2.ImageUrl = afterImageUrl2;

                lblObservation_2.Text = observation2;
                lblAction_2.Text = action2;

                // Optional visibility control
                imgBefore_2.Visible = !string.IsNullOrEmpty(beforeImageUrl2);
                imgAfter_2.Visible = !string.IsNullOrEmpty(afterImageUrl2);
                lblObservation_2.Visible = !string.IsNullOrEmpty(observation2);
                lblAction_2.Visible = !string.IsNullOrEmpty(action2);

            }
        }

    }
}
