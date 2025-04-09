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
                // Example data
                string beforeImageUrl = "~/Images/before1.jpg";
                string afterImageUrl = "~/Images/after1.jpg";
                string observation = "Found unused materials stored in the workspace.";
                string action = "It should be kept in the designated place.";

                // Set image URLs
                imgBefore_1.ImageUrl = beforeImageUrl;
                imgAfter_1.ImageUrl = afterImageUrl;

                // Set observation and action text
                lblObservation_1.Text = observation;
                lblAction_1.Text = action;

                // Optional: show/hide elements
                imgBefore_1.Visible = !string.IsNullOrEmpty(beforeImageUrl);
                imgAfter_1.Visible = !string.IsNullOrEmpty(afterImageUrl);
                lblObservation_1.Visible = !string.IsNullOrEmpty(observation);
                lblAction_1.Visible = !string.IsNullOrEmpty(action);
            }
        }


    }
}
