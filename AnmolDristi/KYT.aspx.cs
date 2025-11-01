using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Collections.Specialized.BitVector32;


namespace AnmolDristi
{
    public partial class KYT : System.Web.UI.Page
    {
        protected void Page_Load_KYT(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadKYTIncidentDetails();
                if (ViewState["ObservationTable"] == null)
                    ViewState["ObservationTable"] = GetObservationTable();

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
                            hkyt.SubmissionTime,
                            hkyt.CAPAID
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
                SaveKYTIncidentData(); 
                //lblMessage.ForeColor = System.Drawing.Color.Green;
                //lblMessage.Text = "KYT Incident data saved successfully!";
                btnSubmit.Enabled = false;
                btnSubmit.Text = "Saved";
                btnSubmit.CssClass = "btn btn-success";

                LoadKYTIncidentDetails();

                ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-success", @"
                        new PNotify({
                            title: 'Success!',
                            text: 'KYT Incident data saved successfully!',
                            type: 'success',
                            styling: 'bootstrap3',
                            delay: 2500
                        });
                    ", true);

            }
            catch (Exception ex)
            {
                
                string safeMsg = ex.Message.Replace("'", " "); 
                ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-error", $@"
                                new PNotify({{
                                    title: 'Error!',
                                    text: 'Error: {safeMsg}',
                                    type: 'error',
                                    styling: 'bootstrap3',
                                    delay: 3000
                                }});
                            ", true);
            }
        }


        private DataTable GetObservationTable()
        {
            DataTable dt = ViewState["ObservationTable"] as DataTable;

            if (dt == null)
            {
                dt = new DataTable("ObservationTable");

                dt.Columns.Add("Activity", typeof(string));
                dt.Columns.Add("HiddenHazards", typeof(string));
                dt.Columns.Add("Consequence", typeof(string));
                dt.Columns.Add("CounterMeasures", typeof(string));
                dt.Columns.Add("Priority", typeof(string));         
                dt.Columns.Add("PhotographPath", typeof(string));
                dt.Columns.Add("GenerateCAPA", typeof(bool));

                // Optional extra columns
                dt.Columns.Add("IsCAPAChecked", typeof(bool));
                dt.Columns.Add("CAPAID", typeof(int));
                dt.Columns.Add("Custom_ID", typeof(string));

                ViewState["ObservationTable"] = dt;
            }

            return dt;
        }


        private void SaveKYTIncidentData()
        {
            //string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            //int kytIncidentID;

            //// Basic Fields
            //string kytWorksiteName = string.IsNullOrWhiteSpace(txtWorksite.Text) ? null : txtWorksite.Text;
            //string kytDepartment = txtDepartment.Text;
            //string kytLocation = txtLocation.Text;
            //string kytDate = txtDate.Text;
            //string kytJobID = txtJobID.Text;
            //string kytSOPNo = txtSOPNo.Text;
            //string kytVendor = txtVender.Text;
            ////string kytPhotographPath = fuPhotograph.HasFile ? fuPhotograph.FileName : null;


            //// 🧩 Save photograph with GUID filename
            //string kytPhotographPath = null;
            //if (fuPhotograph.HasFile)
            //{
            //    string uploadsFolder = Server.MapPath("~/Uploads/");
            //    if (!Directory.Exists(uploadsFolder))
            //        Directory.CreateDirectory(uploadsFolder);

            //    // Use GUID for unique filename
            //    string extension = Path.GetExtension(fuPhotograph.FileName);
            //    string uniqueFileName = Guid.NewGuid().ToString() + extension;
            //    string fullPath = Path.Combine(uploadsFolder, uniqueFileName);

            //    fuPhotograph.SaveAs(fullPath);

            //    // Save relative path to DB
            //    kytPhotographPath = "~/Uploads/" + uniqueFileName;
            //}

            //string kytGridJson = hfKYTGridData.Value;
            //List<KYTGridRow> observations = new List<KYTGridRow>();

            //if (!string.IsNullOrWhiteSpace(kytGridJson))
            //{
            //    observations = Newtonsoft.Json.JsonConvert.DeserializeObject<List<KYTGridRow>>(kytGridJson);
            //}

            //using (SqlConnection conn = new SqlConnection(connectionString))
            //{
            //    conn.Open();
            //    SqlTransaction transaction = conn.BeginTransaction();

            //    try
            //    {
            //        // STEP 1: Insert into KYT_Table1 and get Incident ID
            //        using (SqlCommand cmd = new SqlCommand("usp_InsertKYTData", conn, transaction))
            //        {
            //            cmd.CommandType = CommandType.StoredProcedure;
            //            cmd.Parameters.AddWithValue("@KYTWorksiteName", (object)kytWorksiteName ?? DBNull.Value);
            //            cmd.Parameters.AddWithValue("@KYTDepartment", (object)kytDepartment ?? DBNull.Value);
            //            cmd.Parameters.AddWithValue("@KYTLocation", (object)kytLocation ?? DBNull.Value);
            //            cmd.Parameters.AddWithValue("@KYTDate", (object)kytDate ?? DBNull.Value);
            //            cmd.Parameters.AddWithValue("@KYTJobID", (object)kytJobID ?? DBNull.Value);
            //            cmd.Parameters.AddWithValue("@KYTSOPNo", (object)kytSOPNo ?? DBNull.Value);
            //            cmd.Parameters.AddWithValue("@KYTVendor", (object)kytVendor ?? DBNull.Value);

            //            SqlParameter outputParam = new SqlParameter("@KYTIncidentID", SqlDbType.Int)
            //            {
            //                Direction = ParameterDirection.Output
            //            };
            //            cmd.Parameters.Add(outputParam);

            //            cmd.ExecuteNonQuery();
            //            kytIncidentID = (int)outputParam.Value;
            //        }

            //        // STEP 2: Generate CustomID like KY001
            //        string customID = "KY" + kytIncidentID.ToString("D3");

            //        // STEP 3: Insert each row from grid
            //        foreach (var row in observations)
            //        {
            //            if (string.IsNullOrWhiteSpace(row.HiddenHazards) &&
            //                string.IsNullOrWhiteSpace(row.Consequence) &&
            //                string.IsNullOrWhiteSpace(row.CounterMeasures) &&
            //                string.IsNullOrWhiteSpace(row.PriorityValue) &&
            //                string.IsNullOrWhiteSpace(row.kytPhotographPath))
            //            {
            //                continue;
            //            }

            //            int? capaId = null;


            //            if (row.RequiresCAPA)
            //            {
            //                capaId = GenerateKAPACAPAID(conn, transaction, customID, row.Consequence);
            //            }

            //            using (SqlCommand cmd = new SqlCommand("usp_InsertKYTDetails", conn, transaction))
            //            {
            //                cmd.CommandType = CommandType.StoredProcedure;
            //                cmd.Parameters.AddWithValue("@ID", kytIncidentID);
            //                cmd.Parameters.AddWithValue("@KYTActivity", (object)row.Activity ?? DBNull.Value);
            //                cmd.Parameters.AddWithValue("@KYTHiddenHazards", (object)row.HiddenHazards ?? DBNull.Value);
            //                cmd.Parameters.AddWithValue("@KYTConsequence", (object)row.Consequence ?? DBNull.Value);
            //                cmd.Parameters.AddWithValue("@KYTCounterMeasures", (object)row.CounterMeasures ?? DBNull.Value);
            //                cmd.Parameters.AddWithValue("@KYTPriorityValue", (object)row.PriorityValue ?? DBNull.Value);
            //                cmd.Parameters.AddWithValue("@KYTPhotographPath", (object)row.kytPhotographPath ?? DBNull.Value);
            //                cmd.Parameters.AddWithValue("@SubmissionDate", DateTime.Now.Date);
            //                cmd.Parameters.AddWithValue("@SubmissionTime", DateTime.Now.TimeOfDay);
            //                cmd.Parameters.AddWithValue("@CAPAID", (object)capaId ?? DBNull.Value);
            //                cmd.Parameters.AddWithValue("@Custom_ID", customID);
            //                cmd.Parameters.AddWithValue("@IsCAPAChecked", row.RequiresCAPA ? 1 : 0);



            //                cmd.ExecuteNonQuery();
            //            }
            //        }

            //        transaction.Commit();
            //    }
            //    catch (Exception ex)
            //    {
            //        transaction.Rollback();
            //        throw new Exception("Transaction failed: " + ex.Message);
            //    }
            //}


            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            int kytIncidentID;

            
            string kytWorksiteName = string.IsNullOrWhiteSpace(txtWorksite.Text) ? null : txtWorksite.Text;
            string kytDepartment = txtDepartment.Text;
            string kytLocation = txtLocation.Text;
            string kytDate = txtDate.Text;
            string kytJobID = txtJobID.Text;
            string kytSOPNo = txtSOPNo.Text;
            string kytVendor = txtVender.Text;

            

            if (ViewState["ObservationTable"] == null)
            {
                throw new Exception("Error: No observations found to save.");
            }





            DataTable dtObservations = ViewState["ObservationTable"] as DataTable;

            if (dtObservations == null || dtObservations.Rows.Count == 0)
            {
                throw new Exception("No observations found to save.");
            }

            if (dtObservations.Columns.Contains("Priority") == false)
            {
                throw new Exception("Priority column missing from observation table!");
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    
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

                    
                    string customID = "KY" + kytIncidentID.ToString("D3");

                    string formnme = "KYT";

                    foreach (DataRow row in dtObservations.Rows)
                    {
                        string activity = row["Activity"].ToString();
                        string hazards = row["HiddenHazards"].ToString();
                        string consequence = row["Consequence"].ToString();
                        string measures = row["CounterMeasures"].ToString();
                        string priority = row["Priority"].ToString();
                        string photoPath = row["PhotographPath"].ToString();

                        bool isCAPARequired = row.Table.Columns.Contains("GenerateCAPA") &&
                                                 row["GenerateCAPA"] != DBNull.Value &&
                                                 Convert.ToBoolean(row["GenerateCAPA"]);

                        int? capaId = null;
                        if (isCAPARequired)
                        {
                            using (SqlCommand cmdCAPA = new SqlCommand(@"
        INSERT INTO tbl_CAPAMaster (HeaderID, Description, AssignedBy, AssignedDate,SourceTable,PhotoPath)
        VALUES (@HeaderID, @Description, @AssignedBy, @AssignedDate, @SourceTable,@PhotoPath);
        SELECT SCOPE_IDENTITY();", conn, transaction))
                            {
                                cmdCAPA.Parameters.AddWithValue("@HeaderID", customID);
                                cmdCAPA.Parameters.AddWithValue("@Description", activity);
                                cmdCAPA.Parameters.AddWithValue("@AssignedBy", Session["UserName"] ?? "System");
                                cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                                cmdCAPA.Parameters.AddWithValue("@SourceTable", formnme);
                                cmdCAPA.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);

                                object result = cmdCAPA.ExecuteScalar();
                                capaId = Convert.ToInt32(result);
                            }
                        }



                        using (SqlCommand cmd = new SqlCommand("usp_InsertKYTDetails", conn, transaction))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@ID", kytIncidentID);
                            cmd.Parameters.AddWithValue("@KYTActivity", (object)activity ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@KYTHiddenHazards", (object)hazards ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@KYTConsequence", (object)consequence ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@KYTCounterMeasures", (object)measures ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@KYTPriorityValue", (object)priority ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@KYTPhotographPath", (object)photoPath ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@SubmissionDate", DateTime.Now.Date);
                            cmd.Parameters.AddWithValue("@SubmissionTime", DateTime.Now.TimeOfDay);
                            cmd.Parameters.AddWithValue("@CAPAID", (object)capaId ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@Custom_ID", customID);
                            //bool isCAPARequired = Convert.ToBoolean(row["GenerateCAPA"]);
                            cmd.Parameters.AddWithValue("@IsCAPAChecked", isCAPARequired ? 1 : 0);




                            cmd.ExecuteNonQuery();
                        }
                    }

                    
                    transaction.Commit();

               
                    ViewState["ObservationTable"] = null;
                    gvObservations.DataSource = null;
                    gvObservations.DataBind();

                    //ScriptManager.RegisterStartupScript(this, GetType(), "success",
                    //    "alert('KYT incident and all observations saved successfully!');", true);
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    //ScriptManager.RegisterStartupScript(this, GetType(), "error",
                    //    $"alert('Error: {ex.Message.Replace("'", " ")}');", true);
                }
            }

        }

        private int GenerateKAPACAPAID(SqlConnection conn, SqlTransaction transaction, string headerID, string remarks)
        {
            int insertedID = 0;

            using (SqlCommand cmdCAPA = new SqlCommand(@"
        INSERT INTO tbl_CAPAMaster (HeaderID, Remarks, AssignedBy, AssignedDate)
        VALUES (@HeaderID, @Remarks, @AssignedBy, @AssignedDate);
        SELECT SCOPE_IDENTITY();", conn, transaction))
            {
                cmdCAPA.Parameters.AddWithValue("@HeaderID", headerID);
                cmdCAPA.Parameters.AddWithValue("@Remarks", string.IsNullOrEmpty(remarks) ? (object)DBNull.Value : remarks);
                //✅ Fix: handle missing session value safely

                object assignedBy = Session["UserName"] ?? "System";
                cmdCAPA.Parameters.AddWithValue("@AssignedBy", assignedBy);

                cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                object result = cmdCAPA.ExecuteScalar();
                insertedID = Convert.ToInt32(result);  // This is your integer CAPAID
            }

            return insertedID; // Return the new CAPAID as integer
        }



        private void InitializeObservationTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("TempID", typeof(Guid));
            dt.Columns.Add("Activity");
            dt.Columns.Add("HiddenHazards");
            dt.Columns.Add("Consequence");
            dt.Columns.Add("CounterMeasures");
            dt.Columns.Add("PriorityValue");
            dt.Columns.Add("PhotographPath");
            ViewState["KYTObservations"] = dt;
        }


        protected void BtnReset_Click(object sender, EventArgs e) 
        {
           
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

        protected void btnSaveObservation_Click(object sender, EventArgs e)
        {

            if (string.IsNullOrWhiteSpace(txtActivity.Text) ||
                string.IsNullOrWhiteSpace(txtHiddenHazards.Text) ||
                string.IsNullOrWhiteSpace(txtConsequence.Text) ||
                string.IsNullOrWhiteSpace(txtCounterMeasures.Text) ||
                string.IsNullOrWhiteSpace(ddlPriority.SelectedValue) ||
                !fuPhotograph.HasFile)
            {
                
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('Please fill all fields before adding an observation.');", true);
                return; 
            }


            DataTable dtObservations;

            if (ViewState["ObservationTable"] == null)
            {
                dtObservations = GetObservationTable();
            }
            else
            {
                dtObservations = (DataTable)ViewState["ObservationTable"];
            }

            // Save photo 
            string filePath = null;
            if (fuPhotograph.HasFile)
            {
                string folder = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folder))
                    Directory.CreateDirectory(folder);

                string ext = Path.GetExtension(fuPhotograph.FileName);
                string fileName = Guid.NewGuid().ToString() + ext;
                fuPhotograph.SaveAs(Path.Combine(folder, fileName));
                filePath = "~/Uploads/" + fileName;
            }

            DataRow newRow = dtObservations.NewRow();
            newRow["Activity"] = txtActivity.Text.Trim();
            newRow["HiddenHazards"] = txtHiddenHazards.Text.Trim();
            newRow["Consequence"] = txtConsequence.Text.Trim();
            newRow["CounterMeasures"] = txtCounterMeasures.Text.Trim();
            newRow["Priority"] = ddlPriority.SelectedValue;
            newRow["PhotographPath"] = filePath ?? string.Empty;
            newRow["GenerateCAPA"] = chkGenerateCAPA.Checked;


            dtObservations.Rows.Add(newRow);

            ViewState["ObservationTable"] = dtObservations;
            gvObservations.DataSource = dtObservations;
            gvObservations.DataBind();

            // Clear inputs
            txtActivity.Text = "";
            txtHiddenHazards.Text = "";
            txtConsequence.Text = "";
            txtCounterMeasures.Text = "";
            ddlPriority.SelectedIndex = 0;
        }

       

       
    }
}
