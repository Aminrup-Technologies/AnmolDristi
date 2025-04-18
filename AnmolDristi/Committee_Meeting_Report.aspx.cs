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
                lbl_1.Text = "01";
                lbl_Mahesh.Text = "Mahesh Chourasia";
                lbl_Proprietor.Text = "Proprietor";
                lbl_Attend.Text = "Present"; // or "Absent"
            }
            {
                // Second row values
                lbl_2.Text = "02";
                lbl_K.Text = "Kishor Kumar Ray";
                lbl_L.Text = "Location Head";
                lbl_Attend2.Text = "Present"; // or "Absent"
            }
            {
                // Third row values
                lbl_3.Text = "03";
                lbl_Kulamani.Text = "Kulamani Das";
                lbl_Hr.Text = "HR";
                lbl_Attend_3.Text = "Present"; // or "Absent"
            }
            {
                // Fourth row values
                lbl_4.Text = "04";
                lbl_Santosh.Text = "Santosh Singh";
                lbl_Site.Text = "Site Incharge";
                lbl_Attend_4.Text = "Present"; // or "Absent"
            }
            {
                // Fifth row values
                lbl_5.Text = "05";
                lbl_Ajay.Text = "Ajay Kumar Yadav";
                lbl_site1.Text = "Site Incharge";
                lbl_Attend_5.Text = "Present"; // or "Absent"
            }
            {
                // Sixth row values
                lbl_6.Text = "06";
                lbl_Biraja.Text = "Biraja Kumar Satpathy";
                lbl_Site2.Text = "Site Incharge";
                lbl_Attend_6.Text = "Present"; // or "Absent"
            }
            {
                // Seventh row values
                lbl_7.Text = "07";
                lbl_Shyam.Text = "Shyam Padhy";
                lbl_Safety_4.Text = "Safety Officer";
                lbl_Attend7.Text = "Present"; // or "Absent"
            }
            {
                // Eighth row values
                lbl_8.Text = "08";
                lbl_Amaresh.Text = "Amaresh Sahoo";
                lbl_Site3.Text = "Site Incharge";
                lbl_Attend8.Text = "Present"; // or "Absent"
            }
            {
                // Ninth row values
                lbl_9.Text = "09";
                lbl_Bipad.Text = "Bipad Jena";
                lbl_Site4.Text = "Site Incharge";
                lbl_Attend9.Text = "Present"; // or "Absent"
            }
            {
                // Tenth row values
                lbl_10.Text = "10";
                lbl_Subhranshu.Text = "Subhranshu Swain";
                lbl_Safety1.Text = "Safety Supervisor";
                lbl_Attend10.Text = "Present"; // or "Absent"
            }
            {
                // Eleventh row values
                lbl_11.Text = "11";
                lbl_Surya.Text = "Surya Adak";
                lbl_Safety2.Text = "Safety Supervisor";
                lbl_Attend11.Text = "Present"; // or "Absent"
            }
            {
                // Twelfth row values
                lbl_12.Text = "12";
                lbl_Rajesh.Text = "Rajesh Jena";
                lbl_Safety3.Text = "Safety Supervisor";
                lbl_Attend12.Text = "Present"; // or "Absent"
            }
            {
                // Thirteenth row values
                lbl_13.Text = "13";
                lbl_Jyotishree.Text = "Jyotishree Ojha";
                lbl_Safety4.Text = "Safety Supervisor";
                lbl_Attend13.Text = "Present"; // or "Absent"
            }
            {
                // Fourteenth row values
                lbl_14.Text = "14";
                lbl_Shasikant.Text = "Shasikant Ojha";
                lbl_site_4.Text = "Site Incharge";
                lbl_Attend14.Text = "Present"; // or "Absent"
            }
            {
                // Fifteenth row values
                lbl_15.Text = "15";
                lbl_Satyajit.Text = "Satyajit Mahanta";
                lbl_Safety_5.Text = "Safety Supervisor";
                lbl_Attend15.Text = "Present"; // or "Absent"
            }
            {
                // Sixteenth row values
                lbl_16.Text = "16";
                lbl_Mahendra.Text = "Mahendra Jena";
                lbl_Site6.Text = "Site Incharge";
                lbl_Attend16.Text = "Present"; // or "Absent"
            }
        }

    }
}