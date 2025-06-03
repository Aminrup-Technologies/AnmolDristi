using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Newtonsoft.Json;


namespace AnmolDristi
{
    public partial class KYT : System.Web.UI.Page
    {
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
            kyt.ID, 
            kyt.KYT_WorksiteName, 
            kyt.KYT_Department, 
            kyt.KYT_Location, 
            kyt.KYT_Date, 
            kyt.KYT_JobID, 
            
            kyt.KYT_SOPNo, 
            kyt.KYT_Vendor,
hkyt.KYT_Activity, 
            hkyt.KYT_HiddenHazards, 
            hkyt.KYT_Consequence, 
            hkyt.KYT_CounterMeasures, 
            hkyt.KYT_PriorityValue,
            hkyt.SubmissionDate,
            hkyt.SubmissionTime
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
                btnSubmit.Enabled = false;
                btnSubmit.Text = "Saved";
                btnSubmit.CssClass = "btn btn-success";

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

            //string kytSlNo = txtSlNo.Text;
            string kytHiddenHazards = txtHiddenHazards.Text;
            string kytConsequence = txtConsequence.Text;
            string kytCounterMeasures = txtCounterMeasures.Text;
            string kytPriorityValue = ddlPriority.Text;

            string kytPhotographPath = fuPhotograph.HasFile ? fuPhotograph.FileName : null;

            //string kytJson = hfKYTGridData.Value;


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
                    // Insert into KYT_Table1 using SP
                    using (SqlCommand cmd = new SqlCommand("usp_InsertKYTData", conn, transaction))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@KYTWorksiteName", (object)kytWorksiteName ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@KYTDepartment", (object)kytDepartment ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@KYTLocation", (object)kytLocation ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@KYTDate", (object)kytDate ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@KYTJobID", (object)kytJobID ?? DBNull.Value);
                        
                        cmd.Parameters.AddWithValue("@KYTSOPNo", (object)kytSOPNo ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@KYTVendor", (object)kytVendor ?? DBNull.Value);

                        SqlParameter outputParam = new SqlParameter("@KYTIncidentID", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputParam);

                        cmd.ExecuteNonQuery();
                        kytIncidentID = (int)outputParam.Value;
                    }

                    // Insert into KYT_Table2 using SP
                    string kytGridJson = hfKYTGridData.Value;
                    List<KYTGridRow> observations = new List<KYTGridRow>();
                    if (!string.IsNullOrWhiteSpace(kytGridJson))
                    {
                        observations = Newtonsoft.Json.JsonConvert.DeserializeObject<List<KYTGridRow>>(kytGridJson);

                        foreach (var row in observations)
                        {
                            if (string.IsNullOrWhiteSpace(row.HiddenHazards) &&
                                string.IsNullOrWhiteSpace(row.Consequence) &&
                                string.IsNullOrWhiteSpace(row.CounterMeasures) &&
                                string.IsNullOrWhiteSpace(row.PriorityValue) &&
                                string.IsNullOrWhiteSpace(row.PhotographPath))
                            {
                                continue; // to skip empty row
                            }
                            using (SqlCommand cmd = new SqlCommand("usp_InsertKYTDetails", conn, transaction))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@ID", kytIncidentID);
                                //  cmd.Parameters.AddWithValue("@KYTSLNo", (object)row.SlNo ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@KYTActivity", (object)row.Activity ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@KYTHiddenHazards", (object)row.HiddenHazards ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@KYTConsequence", (object)row.Consequence ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@KYTCounterMeasures", (object)row.CounterMeasures ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@KYTPriorityValue", (object)row.PriorityValue ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@KYTPhotographPath", (object)row.PhotographPath ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@SubmissionDate", DateTime.Now.Date);    
                                cmd.Parameters.AddWithValue("@SubmissionTime", DateTime.Now.TimeOfDay); 

                                cmd.ExecuteNonQuery();
                            }
                        }

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

        public class KYTGridRow
        {
            public string Activity { get; set; }
            public string HiddenHazards { get; set; }
            public string Consequence { get; set; }
            public string CounterMeasures { get; set; }
            public string PriorityValue { get; set; }
            public string PhotographPath { get; set; }
        }


        protected void BtnReset_Click(object sender, EventArgs e) // Renamed
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
            //txtSlNo.Text = "";
            txtHiddenHazards.Text = "";
            txtConsequence.Text = "";
            txtCounterMeasures.Text = "";
            ddlPriority.Text = "";
            //fuPhotograph.Text = "";
            string fileName = fuPhotograph.HasFile ? fuPhotograph.FileName : null;



            lblMessage.Text = "KYT Form reset successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Blue;
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {

        }

        protected void btn_panel1_Click(object sender, EventArgs e)
        {

        }
    }
}
