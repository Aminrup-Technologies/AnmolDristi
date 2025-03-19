using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient; // Add this line
using System.Configuration; // Add this line
using System.Data; // Add this line

namespace AnmolDristi
{
    public partial class KYT : System.Web.UI.Page
    {

        //protected System.Web.UI.WebControls.Label lblMessage; 

        //protected System.Web.UI.WebControls.TextBox txtWorksite;
        //protected System.Web.UI.WebControls.TextBox txtDepartment;
        //protected System.Web.UI.WebControls.TextBox txtLocation;
        //protected System.Web.UI.WebControls.TextBox txtDate;
        //protected System.Web.UI.WebControls.TextBox txtJobID;
        //protected System.Web.UI.WebControls.TextBox txtActivity;
        //protected System.Web.UI.WebControls.TextBox txtSOPNo;
        //protected System.Web.UI.WebControls.TextBox txtVender;
        //protected System.Web.UI.WebControls.TextBox txtSlNo;
        //protected System.Web.UI.WebControls.TextBox txtHiddenHazards;
        //protected System.Web.UI.WebControls.TextBox txtConsequence;
        //protected System.Web.UI.WebControls.TextBox txtCounterMeasures;
        //protected System.Web.UI.WebControls.DropDownList ddlPriority;
        //protected System.Web.UI.WebControls.FileUpload fuPhotograph;




        protected void Page_Load_KYT(object sender, EventArgs e)  
        {
            if (!IsPostBack)
            {
                LoadKYTIncidentDetails(); 
            }
        }

        private void LoadKYTIncidentDetails()  
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                SELECT 
                    kyt.ID, kyt.KYT_WorksiteName, kyt.KYT_Department, kyt.KYT_Location, kyt.KYT_Date, kyt.KYT_JobID, 
                    kyt.KYT_Activity, kyt.KYT_SOPNo, kyt.KYT_Vendor,
                    hkyt.KYT_SlNo, hkyt.KYT_HiddenHazards, hkyt.KYT_Consequence, hkyt.KYT_CounterMeasures, 
                    hkyt.KYT_PriorityValue, hkyt.KYT_PhotographPath
                FROM KYT_Table1 kyt
                LEFT JOIN KYT_Table2 hkyt ON kyt.ID = hkyt.ID
                ORDER BY kyt.ID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                    }
                }
            }
        }

        protected void SubmitKYTIncidentData_Click(object sender, EventArgs e)
        {
            try
            {
                SaveKYTIncidentData(); // Save form data
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "KYT Incident data saved successfully!";

                LoadKYTIncidentDetails(); // Refresh GridView
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }


        private void SaveKYTIncidentData()  // Renamed
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            int kytIncidentID;

            // Fixing variable names to match ASPX controls
            string kytWorksiteName = string.IsNullOrWhiteSpace(txtWorksite.Text) ? null : txtWorksite.Text;

            string kytDepartment = txtDepartment.Text;

            string kytLocation = txtLocation.Text;
            string kytDate = txtDate.Text;
            string kytJobID = txtJobID.Text;
            string kytActivity = txtActivity.Text;
            string kytSOPNo = txtSOPNo.Text;
            string kytVendor = txtVender.Text;

            string kytSlNo = txtSlNo.Text;
            string kytHiddenHazards = txtHiddenHazards.Text;
            string kytConsequence = txtConsequence.Text;
            string kytCounterMeasures = txtCounterMeasures.Text;
            string kytPriorityValue = ddlPriority.Text;

            string kytPhotographPath = fuPhotograph.HasFile ? fuPhotograph.FileName : null;



            //DateTime? kytDate = null;
            //if (!string.IsNullOrWhiteSpace(txtDate.Text))
            //{
            //    kytDate = DateTime.Parse(txtDate.Text);
            //}

            //DateTime? kytDate = null;
            //if (!string.IsNullOrWhiteSpace(txtDate.Text))
            //{
            //    if (DateTime.TryParse(txtDate.Text, out DateTime parsedDate))
            //    {
            //        kytDate = parsedDate; 
            //    }
            //}


            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    using (SqlCommand cmd = new SqlCommand(@"
                        INSERT INTO KYT_Table1 (KYT_WorksiteName, KYT_Department, KYT_Location, KYT_Date, KYT_JobID, KYT_Activity, KYT_SOPNo, KYT_Vendor) 
                        VALUES (@KYTWorksiteName, @KYTDepartment, @KYTLocation, @KYTDate, @KYTJobID, @KYTActivity, @KYTSOPNo, @KYTVendor);
                        SELECT SCOPE_IDENTITY();", conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@KYTWorksiteName", kytWorksiteName ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@KYTDepartment", kytDepartment);
                        cmd.Parameters.AddWithValue("@KYTLocation", kytLocation);
                        cmd.Parameters.AddWithValue("@KYTDate", kytDate ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@KYTJobID", kytJobID);
                        cmd.Parameters.AddWithValue("@KYTActivity", kytActivity);
                        cmd.Parameters.AddWithValue("@KYTSOPNo", kytSOPNo);
                        cmd.Parameters.AddWithValue("@KYTVendor", kytVendor);

                        kytIncidentID = Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    using (SqlCommand cmd = new SqlCommand(@"
                        INSERT INTO KYT_Table2 (ID, KYT_SlNo, KYT_HiddenHazards, KYT_Consequence, KYT_CounterMeasures, KYT_PriorityValue, KYT_PhotographPath) 
                        VALUES (@ID, @KYTSLNo, @KYTHiddenHazards, @KYTConsequence, @KYTCounterMeasures, @KYTPriorityValue, @KYTPhotographPath)", conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@ID", kytIncidentID);
                        cmd.Parameters.AddWithValue("@KYTSLNo", kytSlNo);
                        cmd.Parameters.AddWithValue("@KYTHiddenHazards", kytHiddenHazards);
                        cmd.Parameters.AddWithValue("@KYTConsequence", kytConsequence);
                        cmd.Parameters.AddWithValue("@KYTCounterMeasures", kytCounterMeasures);
                        cmd.Parameters.AddWithValue("@KYTPriorityValue", kytPriorityValue);
                        cmd.Parameters.AddWithValue("@KYTPhotographPath", kytPhotographPath ?? (object)DBNull.Value);

                        cmd.ExecuteNonQuery();
                    }

                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    throw new Exception("Transaction failed: " + ex.Message);
                }
            }
        }

        protected void ResetKYTIncidentForm_Click(object sender, EventArgs e) // Renamed
        {
            // Matching the ASPX control names
            txtWorksite.Text = "";
            txtDepartment.Text = "";
            txtLocation.Text = "";
            txtDate.Text = "";
            txtJobID.Text = "";
            txtActivity.Text = "";
            txtSOPNo.Text = "";
            txtVender.Text = "";
            txtSlNo.Text = "";
            txtHiddenHazards.Text = "";
            txtConsequence.Text = "";
            txtCounterMeasures.Text = "";
            ddlPriority.Text = "";
            //fuPhotograph.Text = "";
            string fileName = fuPhotograph.HasFile ? fuPhotograph.FileName : "";


            lblMessage.Text = "KYT Form reset successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Blue;
        }
    }
}
