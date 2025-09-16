using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;


namespace AnmolDristi
{
    public partial class housekeeping_audit : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (IsPostBack)
            {
                // Rebind name fetched via JS to server-side textbox so it's not lost
                //txtOpenBy.Text = hfEmployeeName.Value.Trim();
            }
        }


        [System.Web.Services.WebMethod]
        public static string GetEmployeeName(string empCode)
        {
            string empName = "";
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT EmployeeName FROM MST_UserMaster WHERE EmployeeCode = @EmployeeCode";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeCode", empCode);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        empName = result.ToString();
                    }
                }
            }

            return empName;
        }


        //[WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        //public static string GetEmployeeName(string inspectionId)
        //{
        //    string employeeName = string.Empty;
        //    string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //    string query = "SELECT TOP 1 OpenBy FROM [CSMS].[dbo].[AuditObservations] WHERE ObserverID = @ObserverID";

        //    using (SqlConnection conn = new SqlConnection(connStr))
        //    {
        //        SqlCommand cmd = new SqlCommand(query, conn);
        //        cmd.Parameters.AddWithValue("@ObserverID", inspectionId);

        //        try
        //        {
        //            conn.Open();
        //            var result = cmd.ExecuteScalar();
        //            if (result != null)
        //            {
        //                employeeName = result.ToString();
        //            }
        //            else
        //            {
        //                employeeName = "Invalid Observer ID";
        //            }
        //        }
        //        catch
        //        {
        //            employeeName = "Error occurred while fetching data";
        //        }
        //    }

        //    return employeeName;
        //}








        protected void btnAddObservation_Click(object sender, EventArgs e)
        {
            lblMsg1.Text = "";
            DataTable dt;
            

            // Check if ViewState already holds data
            if (ViewState["Observations"] == null)
            {
                dt = new DataTable();
                dt.Columns.Add("SNo");
                dt.Columns.Add("ObserverID");
                dt.Columns.Add("OpeningDate");
                dt.Columns.Add("OpenBy");               
                dt.Columns.Add("Observation");
                dt.Columns.Add("CorrectiveAction");
                dt.Columns.Add("Capa_Report");
                dt.Columns.Add("ClosingDate");
                dt.Columns.Add("CloseBy");
                dt.Columns.Add("TargetDate");
                dt.Columns.Add("OpenByWorkman");
                dt.Columns.Add("Status");
                dt.Columns.Add("AssignedTo");
                dt.Columns.Add("PhotoAfter");
                dt.Columns.Add("PhotoBefore");
            }
            else
            {
                dt = (DataTable)ViewState["Observations"];
               
            }
            //for two image upload in gridview.
            string imagePath1 = "";
            
            if (fileBeforePhoto.HasFile)
            {
                string fileExtension = Path.GetExtension(fileBeforePhoto.FileName).ToLower();
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblMsg1.Text = "Error: Only JPG, JPEG, and PNG files are allowed.";
                    lblMsg1.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                //string folderPath = Server.MapPath("~/Uploads/");
                string folderPath = Server.MapPath("~/images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
                
                string uniqueFileName = Guid.NewGuid().ToString() + "_Before" + fileExtension;
                imagePath1 = "~/images/" + uniqueFileName;
                fileBeforePhoto.SaveAs(folderPath + uniqueFileName);
            }
            string imagePath2 = "";
            if (fileAfterPhoto.HasFile)
            {
                string fileExtension = Path.GetExtension(fileAfterPhoto.FileName).ToLower();
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblMsg1.Text = "Error: Only JPG, JPEG, and PNG files are allowed.";
                    lblMsg1.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string folderPath = Server.MapPath("~/images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
                
                string uniqueFileName = Guid.NewGuid().ToString() + "_After" + fileExtension;
                imagePath2 = "~/images/" + uniqueFileName;
                fileAfterPhoto.SaveAs(folderPath + uniqueFileName);
            }

            // Generating SNo dynamically
            int serialNo = dt.Rows.Count + 1;

            // ✅ Set Capa_Report as "Checked" or empty string
            string capaStatus = chkQ3CAPA.Checked ? "Checked" : "";


            // Create a new row and add data
            DataRow dr = dt.NewRow();
            dr["SNo"] = serialNo;
            dr["ObserverID"]=txtObserverID.Text.Trim();
            dr["OpeningDate"] = txtOpeningDate.Text.Trim();
            dr["OpenBy"] = hfEmployeeName.Value.Trim();


            dr["Observation"] = txtObservation.Text.Trim();
            dr["CorrectiveAction"] = txtCorrectiveAction.Text.Trim();
            dr["Capa_Report"] = capaStatus; // ✅ Apply checkbox value
            dr["ClosingDate"] = txtClosingDate.Text.Trim();
            dr["TargetDate"] = txtTargetDate.Text.Trim();
            dr["CloseBy"] = txtCloseBy.Text.Trim();
            dr["OpenByWorkman"] = txtOpenByWorkman.Text.Trim();
            dr["AssignedTo"] = txtAssignedTo.Text.Trim();
            dr["Status"] = ddlStatus.SelectedValue;
            dr["PhotoBefore"] = imagePath1;  // Assign Image Path
            dr["PhotoAfter"] = imagePath2;   // Assign Image Path

            dt.Rows.Add(dr);

            // Save data in ViewState and bind to GridView
            ViewState["Observations"] = dt;
            gvObservations.DataSource = dt;
            gvObservations.DataBind();

            // Clear input fields after adding an observation
            txtObserverID.Text = "";
            txtOpenByWorkman.Text = "";
            txtOpeningDate.Text = "";
            txtTargetDate.Text = "";
            txtOpenBy.Text = "";
            txtObservation.Text = "";
            txtCorrectiveAction.Text = "";
            txtClosingDate.Text = "";
            txtCloseBy.Text = "";
            txtAssignedTo.Text = "";
            ddlStatus.SelectedIndex = 0;
            //ScriptManager.RegisterStartupScript(this, GetType(), "clearFileInputs", "clearFileInputs();", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "showSuccessMessage();", true);
        }

        protected void BtnDelObservation_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            if (gvObservations.DataKeys.Count == 0 || row.RowIndex < 0 || row.RowIndex >= gvObservations.DataKeys.Count)
            {
                return; // Prevent out-of-range errors
            }

            int sNo = Convert.ToInt32(gvObservations.DataKeys[row.RowIndex].Value);
            DataTable dt = ViewState["Observations"] as DataTable;

            if (dt != null)
            {
                DataRow[] rows = dt.Select("SNo=" + sNo);
                if (rows.Length > 0)
                {
                    dt.Rows.Remove(rows[0]);
                    dt.AcceptChanges();
                }

                // **Renumber SNo** after deletion
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SNo"] = i + 1; // Reset SNo from 1 to N
                }

                if (dt.Rows.Count == 0)
                {
                    ViewState["Observations"] = null;
                    gvObservations.DataSource = null;
                    gvObservations.DataBind();
                }
                else
                {
                    ViewState["Observations"] = dt;
                    gvObservations.DataSource = dt;
                    gvObservations.DataBind();
                }
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            lblMsg.Text = "";
            if (ViewState["Observations"] == null)
            {
                lblMsg.Text = "No observations to save.Please Add Observations";
                lblMsg1.Text= "Please Add Observations";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg1.ForeColor = System.Drawing.Color.Red;
                BtnSubmit.Enabled = true; // Re-enable button
                return;
            }

           

            DataTable dt = (DataTable)ViewState["Observations"];

            
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();
                try
                {
                    //int auditID;

                    if (!string.IsNullOrEmpty(hfEmployeeName.Value))
                        txtOpenBy.Text = hfEmployeeName.Value.Trim();

                    int auditID = InsertAuditInfo(txtLocation.Text.Trim(), Convert.ToDateTime(txtdate.Text.Trim()), txtjobID.Text.Trim(), conn, transaction);


                    if (auditID == 0)
                    {
                        transaction.Rollback();
                        lblMsg.Text = "Error: Audit ID not generated.";
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                        return;
                    }
                    object capaReportID = DBNull.Value;
                    string customid = "HKM-" + auditID;
                    

                    // Step 2: Insert into AuditObservations Table
                    foreach (DataRow row in dt.Rows)
                    {
                        capaReportID = DBNull.Value;
                        string finalStatus = row["Status"].ToString();// Reset for each row

                        if (row["Capa_Report"].ToString() == "Checked")
                        {
                            // Insert into CAPA Master table
                            SqlCommand cmdCAPA = new SqlCommand(@"
INSERT INTO tbl_CAPAMaster (HeaderID, AssignedBy, AssignedDate, Description,CorrectiveAction,CA_Photo,PhotoPath,CA_ActionBy,CA_Date,TargetCompletionDate,ResponsiblePerson,SourceTable)
OUTPUT INSERTED.CAPAID
VALUES (@HeaderID, @AssignedBy, @AssignedDate, @Description,@CorrectiveAction,@CA_Photo,@PhotoPath,@CA_ActionBy,@CA_Date,@TargetCompletionDate,@ResponsiblePerson,@SourceTable)", conn, transaction);

                            cmdCAPA.Parameters.AddWithValue("@HeaderID", customid);
                            cmdCAPA.Parameters.AddWithValue("@AssignedBy", row["ObserverID"].ToString());
                            cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                            cmdCAPA.Parameters.AddWithValue("@Description", row["Observation"].ToString());
                            cmdCAPA.Parameters.AddWithValue("@CorrectiveAction", row["CorrectiveAction"].ToString());
                            //cmdCAPA.Parameters.AddWithValue("@CA_Photo",
                            //    row["PhotoAfter"] == DBNull.Value || row["PhotoAfter"] == null ? (object)DBNull.Value : row["PhotoAfter"].ToString());
                            cmdCAPA.Parameters.AddWithValue("@CA_Photo",
                                                    row["PhotoAfter"] == DBNull.Value || row["PhotoAfter"] == null
                                                        ? (object)DBNull.Value
                                                        : Path.GetFileName(row["PhotoAfter"].ToString()));

                            cmdCAPA.Parameters.AddWithValue("@PhotoPath",
                                row["PhotoBefore"] == DBNull.Value || row["PhotoBefore"] == null ? (object)DBNull.Value : row["PhotoBefore"].ToString());
                            cmdCAPA.Parameters.AddWithValue("@CA_ActionBy", row["ObserverID"].ToString());
                            cmdCAPA.Parameters.AddWithValue("@CA_Date", row["OpeningDate"].ToString());
                            cmdCAPA.Parameters.AddWithValue("@TargetCompletionDate", row["TargetDate"].ToString());
                            cmdCAPA.Parameters.AddWithValue("@ResponsiblePerson", row["AssignedTo"].ToString());
                            cmdCAPA.Parameters.AddWithValue("@SourceTable", "Housekeeping Audit(5S)");

                            capaReportID = cmdCAPA.ExecuteScalar();

                            // Fetch status from CAPA table
                            SqlCommand cmdStatus = new SqlCommand("SELECT Status FROM tbl_CAPAMaster WHERE CAPAID = @CAPAID", conn, transaction);
                            cmdStatus.Parameters.AddWithValue("@CAPAID", capaReportID);
                            object result = cmdStatus.ExecuteScalar();
                            if (result != null)
                            {
                                finalStatus = result.ToString(); // overwrite with CAPA status
                            }

                        }


                        System.Diagnostics.Debug.WriteLine($"PhotoBefore: {row["PhotoBefore"]}");
                        System.Diagnostics.Debug.WriteLine($"PhotoAfter: {row["PhotoAfter"]}");

                        using (SqlCommand cmd = new SqlCommand("InsertAuditObservation", conn, transaction))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@AuditID", auditID);
                            cmd.Parameters.AddWithValue("@HeaderID", customid);
                            cmd.Parameters.AddWithValue("@ObserverID",row["ObserverID"].ToString());
                            cmd.Parameters.AddWithValue("@ObservationText",row["Observation"].ToString());
                            cmd.Parameters.AddWithValue("@CorrectiveAction",row["CorrectiveAction"].ToString());
                            cmd.Parameters.AddWithValue("@Status", finalStatus);
                            cmd.Parameters.AddWithValue("@OpenBy",row["OpenBy"].ToString());
                            cmd.Parameters.AddWithValue("@CloseBy",row["CloseBy"].ToString());
                            cmd.Parameters.AddWithValue("@AssignedTo", row["AssignedTo"].ToString());
                            cmd.Parameters.AddWithValue("@OpenByWorkman", row["OpenByWorkman"].ToString());
                            cmd.Parameters.AddWithValue("@Capa_Report", capaReportID ?? DBNull.Value); // Use DBNull if null



                            cmd.Parameters.AddWithValue("@ClosingDate",
                                string.IsNullOrEmpty(row["ClosingDate"].ToString()) ? DBNull.Value : (object)Convert.ToDateTime(row["ClosingDate"]));

                            cmd.Parameters.AddWithValue("@OpeningDate",
                                string.IsNullOrEmpty(row["OpeningDate"].ToString()) ? DBNull.Value : (object)Convert.ToDateTime(row["OpeningDate"]));

                            cmd.Parameters.AddWithValue("@TargetDate",
                                string.IsNullOrEmpty(row["TargetDate"].ToString()) ? DBNull.Value : (object)Convert.ToDateTime(row["TargetDate"]));


                            cmd.Parameters.AddWithValue("@PhotoBefore",
                                row["PhotoBefore"] == DBNull.Value || row["PhotoBefore"] == null ? (object)DBNull.Value : row["PhotoBefore"].ToString());

                            cmd.Parameters.AddWithValue("@PhotoAfter",
                                row["PhotoAfter"] == DBNull.Value || row["PhotoAfter"] == null ? (object)DBNull.Value : row["PhotoAfter"].ToString());

                            cmd.ExecuteNonQuery();
                        }
                    }


                    transaction.Commit();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotify",
                                "new PNotify({ " +
                                    "title: 'Success', " +
                                    "text: 'Record Submitted successfully!', " +
                                    "type: 'success', " +
                                    "styling: 'bootstrap3', " +
                                    "delay: 2000 " + // closes after 2 seconds
                                "});", true);

                    // Clear observations to prevent duplicate submission
                    ViewState["Observations"] = null;
                    gvObservations.DataSource = null;
                    gvObservations.DataBind();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotifyError",
                                    "new PNotify({ " +
                                        "title: 'Error', " +
                                        "text: 'Transaction failed: " + ex.Message.Replace("'", "\\'") + "', " + // escape single quotes
                                        "type: 'error', " +
                                        "styling: 'bootstrap3', " +
                                        "delay: 2000 " + // closes after 2 seconds
                                    "});", true);

                }
            }


        }


        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("housekeeping_audit.aspx");
        }


        private int InsertAuditInfo(string location, DateTime auditDate, string jobID, SqlConnection conn, SqlTransaction transaction)
        {
            using (SqlCommand cmd = new SqlCommand("InsertAuditInfo", conn, transaction))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter outputAuditID = new SqlParameter("@AuditID", SqlDbType.Int)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(outputAuditID);
                cmd.Parameters.AddWithValue("@Location", location);
                cmd.Parameters.AddWithValue("@AuditDate", auditDate);
                cmd.Parameters.AddWithValue("@JobID", jobID);

                cmd.ExecuteNonQuery();
                return Convert.ToInt32(outputAuditID.Value);
            }
        }


    }

}