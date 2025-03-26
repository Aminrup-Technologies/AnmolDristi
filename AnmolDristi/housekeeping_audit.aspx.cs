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


namespace AnmolDristi
{
    public partial class housekeeping_audit : System.Web.UI.Page
    {
        private int slNo = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
       
        protected void btnAddObservation_Click(object sender, EventArgs e)
        {
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
                dt.Columns.Add("ClosingDate");
                dt.Columns.Add("CloseBy");
                dt.Columns.Add("Status");
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

                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
                
                string uniqueFileName = Guid.NewGuid().ToString() + "_Before" + fileExtension;
                imagePath1 = "~/Uploads/" + uniqueFileName;
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

                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
                
                string uniqueFileName = Guid.NewGuid().ToString() + "_After" + fileExtension;
                imagePath2 = "~/Uploads/" + uniqueFileName;
                fileAfterPhoto.SaveAs(folderPath + uniqueFileName);
            }

            // Generating SNo dynamically
            int serialNo = dt.Rows.Count + 1;

            // Create a new row and add data
            DataRow dr = dt.NewRow();
            dr["SNo"] = serialNo;
            dr["ObserverID"]=txtObserverID.Text.Trim();
            dr["OpeningDate"] = txtOpeningDate.Text.Trim();
            dr["OpenBy"] = txtOpenBy.Text.Trim();
            //dr["ImagePath1"] = imagePath1;
            dr["Observation"] = txtObservation.Text.Trim();
            dr["CorrectiveAction"] = txtCorrectiveAction.Text.Trim();
            //dr["ImagePath2"] = imagePath2;
            dr["ClosingDate"] = txtClosingDate.Text.Trim();
            dr["CloseBy"] = txtCloseBy.Text.Trim();
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
            txtOpeningDate.Text = "";
            txtOpenBy.Text = "";
            txtObservation.Text = "";
            txtCorrectiveAction.Text = "";
            txtClosingDate.Text = "";
            txtCloseBy.Text = "";
            ddlStatus.SelectedIndex = 0;
            ScriptManager.RegisterStartupScript(this, GetType(), "clearFileInputs", "clearFileInputs();", true);
        }


        //protected void BtnSubmit_Click(object sender, EventArgs e)
        //{
        //    if (ViewState["Observations"] == null)
        //    {
        //        lblMsg1.Text = "No observations to save.";
        //        lblMsg1.ForeColor = System.Drawing.Color.Red;
        //        return;
        //    }

        //    DataTable dt = (DataTable)ViewState["Observations"];
        //    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        conn.Open();
        //        SqlTransaction transaction = conn.BeginTransaction();
        //        try
        //        {
        //            int auditID;

        //            // Step 1: Insert into AuditInfo Table
        //            using (SqlCommand cmd = new SqlCommand("InsertAuditInfo", conn, transaction))
        //            {
        //                cmd.CommandType = System.Data.CommandType.StoredProcedure;

        //                SqlParameter outputAuditID = new SqlParameter("@AuditID", System.Data.SqlDbType.Int)
        //                {
        //                    Direction = System.Data.ParameterDirection.Output
        //                };
        //                cmd.Parameters.Add(outputAuditID);
        //                cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
        //                cmd.Parameters.AddWithValue("@AuditDate", Convert.ToDateTime(txtdate.Text.Trim()));

        //                cmd.ExecuteNonQuery();
        //                auditID = Convert.ToInt32(outputAuditID.Value);

        //            }

        //            if (auditID == 0)
        //            {
        //                transaction.Rollback();
        //                lblMsg.Text = "Error: Audit ID not generated.";
        //                lblMsg.ForeColor = System.Drawing.Color.Red;
        //                return;
        //            }

        //            foreach (DataRow row in dt.Rows)
        //            {
        //                using (SqlCommand cmd = new SqlCommand("InsertAuditObservation", conn, transaction))
        //                {
        //                    cmd.CommandType = CommandType.StoredProcedure;
        //                    cmd.Parameters.AddWithValue("@AuditID", auditID);
        //                    cmd.Parameters.AddWithValue("@ObserverID", Convert.ToInt32(row["ObserverID"]));
        //                    cmd.Parameters.AddWithValue("@PhotoBefore", row["ImagePath1"].ToString()); // Store path
        //                    cmd.Parameters.AddWithValue("@ObservationText", row["Observation"].ToString());
        //                    cmd.Parameters.AddWithValue("@CorrectiveAction", row["CorrectiveAction"].ToString());
        //                    cmd.Parameters.AddWithValue("@PhotoAfter", row["ImagePath2"].ToString()); // Store path
        //                    cmd.Parameters.AddWithValue("@Status", row["Status"].ToString());
        //                    cmd.Parameters.AddWithValue("@OpenBy", row["OpenBy"].ToString());
        //                    cmd.Parameters.AddWithValue("@CloseBy", row["CloseBy"].ToString());

        //                    if (string.IsNullOrEmpty(row["ClosingDate"].ToString()))
        //                        cmd.Parameters.AddWithValue("@ClosingDate", DBNull.Value);
        //                    else
        //                        cmd.Parameters.AddWithValue("@ClosingDate", Convert.ToDateTime(row["ClosingDate"]));

        //                    if (string.IsNullOrEmpty(row["OpeningDate"].ToString()))
        //                        cmd.Parameters.AddWithValue("@OpeningDate", DBNull.Value);
        //                    else
        //                        cmd.Parameters.AddWithValue("@OpeningDate", Convert.ToDateTime(row["OpeningDate"]));

        //                    cmd.ExecuteNonQuery();
        //                }
        //            }
        //            transaction.Commit();
        //            lblMsg.Text = "Transaction completed successfully!";
        //        }
        //        catch (Exception ex)
        //        {
        //            transaction.Rollback();
        //            lblMsg.Text = "Transaction failed: " + ex.Message;
        //            throw new Exception("Transaction failed", ex);
        //        }
        //    }


        //}

        private bool CheckIfObservationExists(int auditID, string observationText, SqlConnection conn, SqlTransaction transaction)
        {
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM AuditObservations WHERE AuditID = @AuditID AND ObservationText = @ObservationText", conn, transaction))
            {
                cmd.Parameters.AddWithValue("@AuditID", auditID);
                cmd.Parameters.AddWithValue("@ObservationText", observationText);

                int count = Convert.ToInt32(cmd.ExecuteScalar());
                return count > 0; // Returns true if the record already exists
            }
        }


        //protected void BtnSubmit_Click(object sender, EventArgs e)
        //{
        //    if (ViewState["Observations"] == null)
        //    {
        //        lblMsg1.Text = "No observations to save.";
        //        lblMsg1.ForeColor = System.Drawing.Color.Red;
        //        BtnSubmit.Enabled = true; // Re-enable button
        //        return;
        //    }

        //    DataTable dt = (DataTable)ViewState["Observations"];

        //    // Remove duplicate rows before inserting
        //    dt = dt.DefaultView.ToTable(true, "ObserverID", "Observation", "CorrectiveAction", "Status", "OpenBy", "CloseBy", "ClosingDate", "OpeningDate");


        //    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        conn.Open();
        //        SqlTransaction transaction = conn.BeginTransaction();
        //        try
        //        {
        //            int auditID;

        //            // Step 1: Insert into AuditInfo Table
        //            using (SqlCommand cmd = new SqlCommand("InsertAuditInfo", conn, transaction)) // Assign transaction
        //            {
        //                cmd.CommandType = CommandType.StoredProcedure;

        //                SqlParameter outputAuditID = new SqlParameter("@AuditID", SqlDbType.Int)
        //                {
        //                    Direction = ParameterDirection.Output
        //                };
        //                cmd.Parameters.Add(outputAuditID);
        //                cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
        //                cmd.Parameters.AddWithValue("@AuditDate", Convert.ToDateTime(txtdate.Text.Trim()));

        //                cmd.ExecuteNonQuery();
        //                auditID = Convert.ToInt32(outputAuditID.Value);
        //            }

        //            if (auditID == 0)
        //            {
        //                transaction.Rollback();
        //                lblMsg.Text = "Error: Audit ID not generated.";
        //                lblMsg.ForeColor = System.Drawing.Color.Red;
        //                return;
        //            }


        //            // Step 2: Insert into AuditObservation Table
        //            foreach (DataRow row in dt.Rows)
        //            {

        //                    using (SqlCommand cmd = new SqlCommand("InsertAuditObservation", conn, transaction)) // Assign transaction here
        //                    {
        //                    cmd.CommandType = CommandType.StoredProcedure;
        //                    cmd.Parameters.AddWithValue("@AuditID", auditID);
        //                    //cmd.Parameters.AddWithValue("@PhotoBefore", GetImageBytes(row["ImagePath1"].ToString()));
        //                    //cmd.Parameters.AddWithValue("@PhotoAfter", GetImageBytes(row["ImagePath2"].ToString()));
        //                    cmd.Parameters.AddWithValue("@ObserverID", Convert.ToInt32(row["ObserverID"]));
        //                    //cmd.Parameters.AddWithValue("@PhotoBefore", row["ImagePath1"].ToString());  // GETTING TRANSACTION FAIL AT THIS POINT
        //                    cmd.Parameters.AddWithValue("@ObservationText", row["Observation"].ToString());
        //                    cmd.Parameters.AddWithValue("@CorrectiveAction", row["CorrectiveAction"].ToString());
        //                    //cmd.Parameters.AddWithValue("@PhotoAfter", row["ImagePath2"].ToString());
        //                    cmd.Parameters.AddWithValue("@Status", row["Status"].ToString());
        //                    cmd.Parameters.AddWithValue("@OpenBy", row["OpenBy"].ToString());
        //                    cmd.Parameters.AddWithValue("@CloseBy", row["CloseBy"].ToString());


        //                    cmd.Parameters.AddWithValue("@ClosingDate",
        //                        string.IsNullOrEmpty(row["ClosingDate"].ToString()) ? DBNull.Value : (object)Convert.ToDateTime(row["ClosingDate"]));

        //                    cmd.Parameters.AddWithValue("@OpeningDate",
        //                        string.IsNullOrEmpty(row["OpeningDate"].ToString()) ? DBNull.Value : (object)Convert.ToDateTime(row["OpeningDate"]));


        //                    cmd.Parameters.AddWithValue("@PhotoBefore",
        //                        string.IsNullOrEmpty(row["PhotoBefore"].ToString()) ? DBNull.Value : (object)row["PhotoBefore"].ToString());

        //                    cmd.Parameters.AddWithValue("@PhotoAfter",
        //                        string.IsNullOrEmpty(row["PhotoAfter"].ToString()) ? DBNull.Value : (object)row["PhotoAfter"].ToString());


        //                    // Ensure command runs only ONCE per row
        //                    if (!CheckIfObservationExists(auditID, row["Observation"].ToString(), conn, transaction))
        //                    {
        //                        cmd.ExecuteNonQuery();
        //                    }

        //                    //cmd.ExecuteNonQuery();
        //                    int slNo = Convert.ToInt32(cmd.ExecuteScalar());
        //                    lblMsg.Text += $"Inserted Observation with SlNo: {slNo}<br/>";

        //                    // Check if the observation already exists
        //                    using (SqlCommand checkCmd = new SqlCommand(@"
        //                       SELECT COUNT(1) FROM AuditObservations 
        //                       WHERE AuditID = @AuditID 
        //                       AND ObservationText = @ObservationText 
        //                       AND Status = @Status", conn, transaction))
        //                    {
        //                        checkCmd.Parameters.AddWithValue("@AuditID", auditID);
        //                        checkCmd.Parameters.AddWithValue("@ObservationText", row["Observation"].ToString());
        //                        checkCmd.Parameters.AddWithValue("@Status", row["Status"].ToString());

        //                        int count = Convert.ToInt32(checkCmd.ExecuteScalar());
        //                        if (count > 0)
        //                        {
        //                            System.Diagnostics.Debug.WriteLine("Skipping duplicate observation: " + row["Observation"].ToString());
        //                            continue; // Skip duplicate
        //                        }
        //                    }
        //                }
        //                System.Diagnostics.Debug.WriteLine("Inserting row: " + row["Observation"].ToString());
        //            }

        //            transaction.Commit();
        //            lblMsg.Text = "Transaction completed successfully!";
        //            lblMsg.ForeColor = System.Drawing.Color.Green;
        //        }
        //        catch (Exception ex)
        //        {
        //            transaction.Rollback();
        //            lblMsg.Text = "Transaction failed: " + ex.Message;
        //            lblMsg.ForeColor = System.Drawing.Color.Red;
        //        }
        //    }
        //}
        //private byte[] GetImageBytes(string filePath)
        //{
        //    if (string.IsNullOrEmpty(filePath) || !File.Exists(filePath))
        //        return null; // Return null instead of DBNull.Value as byte[]

        //    return File.ReadAllBytes(filePath);
        //}



        //private string SaveImageToUploadsFolder(string imagePath)
        //{
        //    try
        //    {
        //        if (!string.IsNullOrEmpty(imagePath) && File.Exists(imagePath))
        //        {
        //            string uploadsFolder = @"D:\AnmolDristi\AnmolDristi\AnmolDristi\Uploads\";
        //            string fileName = Path.GetFileName(imagePath); // Extract file name
        //            string newFilePath = Path.Combine(uploadsFolder, fileName);

        //            // Copy the file to the uploads folder (overwrite if exists)
        //            File.Copy(imagePath, newFilePath, true);

        //            return newFilePath; // Return the new saved path
        //        }
        //        else
        //        {
        //            System.Diagnostics.Debug.WriteLine("Image file not found: " + imagePath);
        //            return null; // Return null if the file doesn't exist
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        System.Diagnostics.Debug.WriteLine("Error saving image: " + ex.Message);
        //        return null;
        //    }
        //}




        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            if (ViewState["Observations"] == null)
            {
                lblMsg1.Text = "No observations to save.";
                lblMsg1.ForeColor = System.Drawing.Color.Red;
                BtnSubmit.Enabled = true; // Re-enable button
                return;
            }

            DataTable dt = (DataTable)ViewState["Observations"];

            // Remove duplicate rows before inserting
            dt = dt.DefaultView.ToTable(true, "ObserverID", "Observation", "CorrectiveAction", "Status", "OpenBy", "CloseBy", "ClosingDate", "OpeningDate", "PhotoBefore", "PhotoAfter");

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();
                try
                {
                    int auditID;

                    // Step 1: Insert into AuditInfo Table (Does NOT include PhotoBefore or PhotoAfter)
                    using (SqlCommand cmd = new SqlCommand("InsertAuditInfo", conn, transaction))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        SqlParameter outputAuditID = new SqlParameter("@AuditID", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputAuditID);
                        cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
                        cmd.Parameters.AddWithValue("@AuditDate", Convert.ToDateTime(txtdate.Text.Trim()));

                        cmd.ExecuteNonQuery();
                        auditID = Convert.ToInt32(outputAuditID.Value);
                    }

                    if (auditID == 0)
                    {
                        transaction.Rollback();
                        lblMsg.Text = "Error: Audit ID not generated.";
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    // Step 2: Insert into AuditObservations Table
                    foreach (DataRow row in dt.Rows)
                    {
                        System.Diagnostics.Debug.WriteLine($"PhotoBefore: {row["PhotoBefore"]}");
                        System.Diagnostics.Debug.WriteLine($"PhotoAfter: {row["PhotoAfter"]}");

                        using (SqlCommand cmd = new SqlCommand("InsertAuditObservation", conn, transaction))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@AuditID", auditID);
                            cmd.Parameters.AddWithValue("@ObserverID", row["ObserverID"].ToString());
                            cmd.Parameters.AddWithValue("@ObservationText", row["Observation"].ToString());
                            cmd.Parameters.AddWithValue("@CorrectiveAction", row["CorrectiveAction"].ToString());
                            cmd.Parameters.AddWithValue("@Status", row["Status"].ToString());
                            cmd.Parameters.AddWithValue("@OpenBy", row["OpenBy"].ToString());
                            cmd.Parameters.AddWithValue("@CloseBy", row["CloseBy"].ToString());
                            

                            cmd.Parameters.AddWithValue("@ClosingDate",
                                string.IsNullOrEmpty(row["ClosingDate"].ToString()) ? DBNull.Value : (object)Convert.ToDateTime(row["ClosingDate"]));

                            cmd.Parameters.AddWithValue("@OpeningDate",
                                string.IsNullOrEmpty(row["OpeningDate"].ToString()) ? DBNull.Value : (object)Convert.ToDateTime(row["OpeningDate"]));

                            cmd.Parameters.AddWithValue("@PhotoBefore",
                                row["PhotoBefore"] == DBNull.Value || row["PhotoBefore"] == null ? (object)DBNull.Value : row["PhotoBefore"].ToString());

                            cmd.Parameters.AddWithValue("@PhotoAfter",
                                row["PhotoAfter"] == DBNull.Value || row["PhotoAfter"] == null ? (object)DBNull.Value : row["PhotoAfter"].ToString());

                            cmd.ExecuteNonQuery();
                        }
                    }


                    transaction.Commit();
                    lblMsg.Text = "Transaction completed successfully!";
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lblMsg.Text = "Transaction failed: " + ex.Message;
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
        }


        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("housekeeping_audit.aspx");
        }
        
    }
    
}