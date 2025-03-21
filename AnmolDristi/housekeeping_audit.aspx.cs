using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class housekeeping_audit : System.Web.UI.Page
    {
        private int slNo = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["SerialNumber"] = 1; // Initialize Serial Number
            }
        }
        protected void btnAddObservation_Click(object sender, EventArgs e)
        {
            // Retrieve Serial Number from ViewState
            int serialNo = (int)ViewState["SerialNumber"];

            TableRow row = new TableRow();

            // Sl. No (Auto-Increment)
            TableCell cell1 = new TableCell();
            cell1.Text = serialNo.ToString();
            row.Cells.Add(cell1);

            // Before Photo (Save & Show Filename)
            TableCell cell2 = new TableCell();
            if (fileBeforePhoto.HasFile)
            {
                string filePath = "~/Uploads/" + fileBeforePhoto.FileName;
                fileBeforePhoto.SaveAs(Server.MapPath(filePath));
                cell2.Text = $"<a href='{filePath}' target='_blank'>View</a>";
            }
            else
            {
                cell2.Text = "No File";
            }
            row.Cells.Add(cell2);

            // Observation
            TableCell cell3 = new TableCell();
            cell3.Text = txtObservation.Text;
            row.Cells.Add(cell3);


            // Corrective Action
            TableCell cell4 = new TableCell();
            cell4.Text = txtCorrectiveAction.Text;
            row.Cells.Add(cell4);

            // Status Photo (Save & Show Filename)
            TableCell cell5 = new TableCell();
            if (fileuploadStatus.HasFile)
            {
                string filePath = "~/Uploads/" + fileuploadStatus.FileName;
                fileuploadStatus.SaveAs(Server.MapPath(filePath));
                cell5.Text = $"<a href='{filePath}' target='_blank'>View</a>";
            }
            else
            {
                cell5.Text = "No File";
            }
            row.Cells.Add(cell5);

            // Add Row to Table
            tblObservations.Rows.Add(row);

            // Increment Serial Number and Store in ViewState
            serialNo++;
            ViewState["SerialNumber"] = serialNo;

            // Clear Fields
            txtObservation.Text = "";
            txtCorrectiveAction.Text = "";
        }
        //protected void BtnSubmit_Click(object sender, EventArgs e)
        //{
        //    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        //    string Title = "Housekeeping Audit (5S)";
        //    string Location = txtLocation.Text;
        //    DateTime AuditDate = Convert.ToDateTime(txtdate.Text);
        //    string ObservationText = txtObservation.Text;
        //    string CorrectiveAction = txtCorrectiveAction.Text;

        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        conn.Open();
        //        SqlTransaction transaction = conn.BeginTransaction();

        //        try
        //        {
        //            int AuditID;
        //            using (SqlCommand cmd = new SqlCommand("InsertAuditInfo", conn, transaction))
        //            {
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                SqlParameter outputAuditID = new SqlParameter("@AuditID", SqlDbType.Int)
        //                {
        //                    Direction = ParameterDirection.Output
        //                };

        //                cmd.Parameters.Add(outputAuditID);
        //                cmd.Parameters.AddWithValue("@Title", Title);
        //                cmd.Parameters.AddWithValue("@Location", Location);
        //                cmd.Parameters.AddWithValue("@AuditDate", AuditDate);

        //                cmd.ExecuteNonQuery();
        //                AuditID = Convert.ToInt32(outputAuditID.Value);
        //            }



        //             using (SqlCommand cmd = new SqlCommand("InsertAuditObservation", conn, transaction))
        //                {
        //                    cmd.CommandType = CommandType.StoredProcedure;

        //                    cmd.Parameters.AddWithValue("@AuditID", AuditID);
        //                    cmd.Parameters.AddWithValue("@ObserverID", 1); // Change as per actual observer ID
        //                    cmd.Parameters.AddWithValue("@ObservationText", );
        //                    cmd.Parameters.AddWithValue("@CorrectiveAction",);

        //                //Convert images to VARBINARY
        //                //    byte[] photoBefore = FileToByteArray(Server.MapPath());
        //                //byte[] statusPhoto = FileToByteArray(Server.MapPath(row.Cells[5].Text));

        //                //cmd.Parameters.AddWithValue("@PhotoBefore", photoBefore ?? (object)DBNull.Value);
        //                //cmd.Parameters.AddWithValue("@Status", statusPhoto ?? (object)DBNull.Value);

        //                cmd.ExecuteNonQuery();
        //             }


        //        transaction.Commit();
        //        lblMsg.Text = "Audit submitted successfully!";
        //        }
        //        catch (Exception ex)
        //        {
        //            transaction.Rollback();
        //            lblMsg.Text = "Transaction failed: " + ex.Message;
        //        }
        //    }

        //    // Clear form fields
        //    txtLocation.Text = string.Empty;
        //    txtdate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        //}

        //private byte[] FileToByteArray(string filePath)
        //{
        //    if (!string.IsNullOrEmpty(filePath) && File.Exists(filePath))
        //    {
        //        return File.ReadAllBytes(filePath);
        //    }
        //    return null;
        //}
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("housekeeping_audit.aspx");
        }
        //protected void btnaddObservation(object sender , EventArgs e)
        //{

        //}
    }
    
}