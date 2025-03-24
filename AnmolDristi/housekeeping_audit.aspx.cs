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
                dt.Columns.Add("ImagePath1");
                dt.Columns.Add("Observation");
                dt.Columns.Add("CorrectiveAction");
                dt.Columns.Add("ImagePath2");
                dt.Columns.Add("ClosingDate");
                dt.Columns.Add("CloseBy");
                dt.Columns.Add("Status");
            }
            else
            {
                dt = (DataTable)ViewState["Observations"];
            }

            string imagePath = "";
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
                string fileName = Path.GetFileName(fileBeforePhoto.FileName);
                imagePath = "~/Uploads/" + fileName;
                fileBeforePhoto.SaveAs(folderPath + fileName);
            }
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
                string fileName = Path.GetFileName(fileAfterPhoto.FileName);
                imagePath = "~/Uploads/" + fileName;
                fileAfterPhoto.SaveAs(folderPath + fileName);
            }



            // Generating SNo dynamically
            int serialNo = dt.Rows.Count + 1;

            // Create a new row and add data
            DataRow dr = dt.NewRow();
            dr["SNo"] = serialNo;
            dr["ObserverID"]=txtObserverID.Text.Trim();
            dr["OpeningDate"] = txtOpeningDate.Text.Trim();
            dr["OpenBy"] = txtOpenBy.Text.Trim();
            dr["ImagePath1"] = imagePath;
            dr["Observation"] = txtObservation.Text.Trim();
            dr["CorrectiveAction"] = txtCorrectiveAction.Text.Trim();
            dr["ImagePath2"] = imagePath;
            dr["ClosingDate"] = txtClosingDate.Text.Trim();
            dr["CloseBy"] = txtCloseBy.Text.Trim();
            dr["Status"] = ddlStatus.SelectedValue;

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

        private byte[] ConvertImageToByte(string imagePath)
        {
            if (string.IsNullOrEmpty(imagePath) || imagePath == "NULL")
                return null;

            string fullPath = Server.MapPath(imagePath); // Convert relative path to absolute

            if (File.Exists(fullPath))
            {
                return File.ReadAllBytes(fullPath); // Convert image to byte array
            }

            return null;
        }




        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();
                try
                {
                    int auditID;

                    // Step 1: Insert into AuditInfo Table
                    using (SqlCommand cmd = new SqlCommand("InsertAuditInfo", conn, transaction))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        SqlParameter outputAuditID = new SqlParameter("@AuditID", System.Data.SqlDbType.Int)
                        {
                            Direction = System.Data.ParameterDirection.Output
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


                    //using (SqlCommand cmd = new SqlCommand("InsertAuditObservation", conn, transaction))
                    //{
                    //    cmd.CommandType = CommandType.StoredProcedure;

                    //    cmd.Parameters.AddWithValue("@AuditID", auditID);
                    //    cmd.Parameters.AddWithValue("@ObserverID", txtObserverID);
                    //    cmd.Parameters.AddWithValue("@ObservationText",txtObservation ); 
                    //    cmd.Parameters.AddWithValue("@CorrectiveAction", txtCorrectiveAction); 
                    //    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);  
                    //    cmd.Parameters.AddWithValue("@OpenBy", txtOpenBy); 
                    //    cmd.Parameters.AddWithValue("@CloseBy", txtCloseBy);
                    //    cmd.Parameters.AddWithValue("@ClosingDate", txtClosingDate);
                    //    cmd.Parameters.AddWithValue("@OpeningDate", txtOpeningDate);
                    //    cmd.Parameters.AddWithValue("@PhotoBefore", fileBeforePhoto);
                    //    cmd.Parameters.AddWithValue("@PhotoAfter", fileAfterPhoto);

                    //    cmd.ExecuteNonQuery();
                    //}
                    foreach (GridViewRow row in gvObservations.Rows)
                    {
                        using (SqlCommand cmd = new SqlCommand("InsertAuditObservation", conn, transaction))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;

                            // Convert image paths to VARBINARY
                            byte[] photoBefore = ConvertImageToByte(row.Cells[4].Text);
                            byte[] photoAfter = ConvertImageToByte(row.Cells[7].Text);

                            cmd.Parameters.AddWithValue("@AuditID", auditID);
                            cmd.Parameters.AddWithValue("@ObserverID", row.Cells[1].Text);
                            cmd.Parameters.AddWithValue("@PhotoBefore", (object)photoBefore ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@ObservationText", row.Cells[5].Text);
                            cmd.Parameters.AddWithValue("@CorrectiveAction", row.Cells[6].Text);
                            cmd.Parameters.AddWithValue("@PhotoAfter", (object)photoAfter ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@Status", row.Cells[10].Text);
                            cmd.Parameters.AddWithValue("@OpenBy", row.Cells[3].Text);
                            cmd.Parameters.AddWithValue("@CloseBy", row.Cells[9].Text);
                            cmd.Parameters.AddWithValue("@ClosingDate", row.Cells[8].Text == "" ? DBNull.Value : (object)Convert.ToDateTime(row.Cells[8].Text));
                            cmd.Parameters.AddWithValue("@OpeningDate", row.Cells[2].Text == "" ? DBNull.Value : (object)Convert.ToDateTime(row.Cells[2].Text));

                            cmd.ExecuteNonQuery();
                        }
                    }




                    transaction.Commit();
                    lblMsg.Text = "Transaction completed successfully!";
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lblMsg.Text = "Transaction failed: " + ex.Message;
                    throw new Exception("Transaction failed", ex);
                }
            }


        }
        
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("housekeeping_audit.aspx");
        }
        
    }
    
}