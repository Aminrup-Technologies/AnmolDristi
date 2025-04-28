using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Committee_Meeting_Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Assigning values dynamically
                lbl_D.Text = "Date";
                lbl_Date.Text = DateTime.Now.ToString("dd/MM/yyyy"); // or any custom date
            }
            {
                // Set label texts dynamically
                lbl_T.Text = "Time";
                lbl_Time.Text = "2:00 PM"; // You can format this or pull from a database
            }
            {
                // Dynamically set label text
                lbl_V.Text = "Venue";
                lbl_Venus.Text = "Microsoft Teams"; // or any dynamic source
            }
            {
                lbl_M.Text = "Meeting No";
                lbl_MeetingNo.Text = "DOC/ATS/OSH/CM-06"; // or get this from database/config/session
            }
            {
                lbl_C.Text = "Chaired By";
                lblChairedBy.Text = "Mr. Mahesh Chourasia"; // You can replace this with a dynamic value
            }

            //< !--Attendance Row 1-- >
            {
                // Set values dynamically
                Label1AttendiID.Text = "1";
                Label2MeetingID.Text = "M456";
                lbl_Mahesh.Text = "Mahesh Kumar";
                Label3AttendiCode.Text = "ATD789";
                Label4Attenditype.Text = "Regular";
                lbl_Attend.Text = "Present";

                // Set image dynamically
                Image5.ImageUrl = "~/images/mahesh.jpg"; // Make sure this image exists in the folder
                Image5.AlternateText = "Mahesh Kumar Image";
            }
            {
                Label6AttendiID.Text = "2";
                Label7MeetingID.Text = "M789";
                Label8AttendiCode.Text = "ATD124";
                Label9Attenditype.Text = "Guest";
                lbl_Attend2.Text = "Present";

                // Dynamically set image
                Image6.ImageUrl = "~/images/.jpg";  // Make sure image exists
                
            }
            {
                // Kulamani Das - Row 3 data setup
                Label11AttendiID.Text = "A125";
                Label12MeetingID.Text = "M790";
                Label13AttendiCode.Text = "ATD125";
                Label14Attenditype.Text = "Employee";
                lbl_Attend_3.Text = "Present";

                // Optional: override name or role (already set in markup)
                // lbl_Kulamani.Text = "Kulamani Das";
                // lbl_Hr.Text = "HR";

                // Set profile image (ensure the image exists in /images/)
                Image7.ImageUrl = "~/images/kulamani.jpg";
                
            }
            {
                // Row 4 - Santosh Singh data
                Label16AttendiID.Text = "A126";
                Label17MeetingID.Text = "M791";
                Label18AttendiCode.Text = "ATD126";
                Label19Attenditype.Text = "Contractual";
                lbl_Attend_4.Text = "Present";

                // Optional - you can override if needed
                // lbl_Santosh.Text = "Santosh Singh";
                // lbl_Site.Text = "Site Incharge";

                // Profile image setup
                Image8.ImageUrl = "~/images";  // Ensure image exists
                
            }
            {
                // Fifth row values
                lbl_5.Text = "05";
                lbl_Ajay.Text = "Ajay Kumar Yadav";
                lbl_site1.Text = "Site Incharge";
                lbl_Attend_5.Text = "Present"; // or "Absent"
            }
            {
                // Row 5 - Ajay Kumar Yadav data
                Label21AttendiID.Text = "A127";
                Label22MeetingID.Text = "M792";
                Label23AttendiCode.Text = "ATD127";
                Label24Attenditype.Text = "Employee";
                lbl_Attend_5.Text = "Present";

                // Optional - you can override if needed
                // lbl_Ajay.Text = "Ajay Kumar Yadav";
                // lbl_site1.Text = "Site Incharge";

                // Profile image setup
                Image9.ImageUrl = "~/images/ajay.jpg";  // Ensure image exists
           
           
           

           
        }

    }
}
}