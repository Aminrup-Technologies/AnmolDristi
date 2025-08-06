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
    public partial class HousekeepingUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["AuditID"] != null)
                {
                    int auditID = int.Parse(Request.QueryString["AuditID"]);
                    ViewState["AuditID"] = auditID; // Store for future use
                    LoadAuditInfo(auditID);
                    LoadObservations(auditID);
                }
            }
        }
        private void LoadAuditInfo(int auditID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT AuditDate,JobID, Location FROM AuditInfo WHERE AuditID = @AuditID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@AuditID", auditID);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtdate.Text = Convert.ToDateTime(reader["AuditDate"]).ToString("yyyy-MM-dd");
                    txtLocation.Text = reader["Location"].ToString();
                    txtjobID.Text = reader["JobID"].ToString();
                }
            }
        }
       

        private void LoadObservations(int auditID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT ObserverID, OpeningDate, OpenBy, 
                                ObservationText AS Observation, CorrectiveAction,
                                ClosingDate, CloseBy, Status,OpenByWorkman,TargetDate,AssignedTo,
                                PhotoBefore, PhotoAfter
                         FROM AuditObservations 
                         WHERE AuditID = @AuditID";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@AuditID", auditID);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvObservations.DataSource = dt;
                gvObservations.DataBind();
            }
        }



        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            int auditID = Convert.ToInt32(ViewState["AuditID"]);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Update AuditInfo (Date and Location)
                string updateAuditInfo = "UPDATE AuditInfo SET AuditDate = @AuditDate, Location = @Location , JobID=@JobID WHERE AuditID = @AuditID";
                using (SqlCommand cmd = new SqlCommand(updateAuditInfo, con))
                {
                    cmd.Parameters.AddWithValue("@AuditDate", DateTime.Parse(txtdate.Text));
                    cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
                    cmd.Parameters.AddWithValue("@JobID", txtjobID.Text.Trim());
                    cmd.Parameters.AddWithValue("@AuditID", auditID);
                    cmd.ExecuteNonQuery();
                }

                foreach (GridViewRow row in gvObservations.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        string observerID = gvObservations.DataKeys[row.RowIndex].Value.ToString();

                        DateTime openingDate = DateTime.Parse(((TextBox)row.FindControl("txtOpeningDate")).Text);
                        string openBy = ((TextBox)row.FindControl("txtOpenBy")).Text;
                        string openByWorkman = ((TextBox)row.FindControl("txtOpenByWorkman")).Text;
                        string observation = ((TextBox)row.FindControl("txtObservation")).Text;
                        string correctiveAction = ((TextBox)row.FindControl("txtCorrectiveAction")).Text;
                        DateTime closingDate = DateTime.Parse(((TextBox)row.FindControl("txtClosingDate")).Text);
                        string closeBy = ((TextBox)row.FindControl("txtCloseBy")).Text;
                        string status = ((DropDownList)row.FindControl("ddlStatus")).SelectedValue;
                        string assignedTo = ((TextBox)row.FindControl("txtAssignedTo")).Text;
                        DateTime targetDate = DateTime.Parse(((TextBox)row.FindControl("txtTargetDate")).Text);

                        // Handle PhotoBefore
                        FileUpload fuBefore = (FileUpload)row.FindControl("fuBeforePhoto");
                        Label lblBefore = (Label)row.FindControl("lblPhotoBefore");
                        string beforePhotoPath = lblBefore.Text;

                        if (fuBefore.HasFile)
                        {
                            string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuBefore.FileName);
                            string savePath = Server.MapPath("~/images/") + fileName;
                            fuBefore.SaveAs(savePath);
                            beforePhotoPath = "~/images/" + fileName;
                        }

                        // Handle PhotoAfter
                        FileUpload fuAfter = (FileUpload)row.FindControl("fuAfterPhoto");
                        Label lblAfter = (Label)row.FindControl("lblPhotoAfter");
                        string afterPhotoPath = lblAfter.Text;

                        if (fuAfter.HasFile)
                        {
                            string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuAfter.FileName);
                            string savePath = Server.MapPath("~/images/") + fileName;
                            fuAfter.SaveAs(savePath);
                            afterPhotoPath = "~/images/" + fileName;
                        }

                        // Update AuditObservations
                        string updateObservation = @"
                        UPDATE AuditObservations SET 
                        OpeningDate = @OpeningDate,
                        OpenBy = @OpenBy,
                        OpenByWorkman = @OpenByWorkman,
                        ObservationText = @ObservationText,
                        CorrectiveAction = @CorrectiveAction,
                        ClosingDate = @ClosingDate,
                        CloseBy = @CloseBy,
                        Status = @Status,
                        TargetDate = @TargetDate,
                        AssignedTo = @AssignedTo,
                        PhotoBefore = @PhotoBefore,
                        PhotoAfter = @PhotoAfter
                        WHERE ObserverID = @ObserverID";

                        using (SqlCommand cmd = new SqlCommand(updateObservation, con))
                        {
                            cmd.Parameters.AddWithValue("@ObserverID", observerID);
                            cmd.Parameters.AddWithValue("@OpeningDate", openingDate);
                            cmd.Parameters.AddWithValue("@OpenBy", openBy);
                            cmd.Parameters.AddWithValue("@OpenByWorkman", openByWorkman);
                            cmd.Parameters.AddWithValue("@ObservationText", observation);
                            cmd.Parameters.AddWithValue("@CorrectiveAction", correctiveAction);
                            cmd.Parameters.AddWithValue("@ClosingDate", closingDate);
                            cmd.Parameters.AddWithValue("@CloseBy", closeBy);
                            cmd.Parameters.AddWithValue("@Status", status);
                            cmd.Parameters.AddWithValue("@TargetDate", targetDate);
                            cmd.Parameters.AddWithValue("@AssignedTo", assignedTo);
                            cmd.Parameters.AddWithValue("@PhotoBefore", beforePhotoPath);
                            cmd.Parameters.AddWithValue("@PhotoAfter", afterPhotoPath);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                con.Close();
            }

            LoadObservations(auditID);

            lblMsg.Text = "Data updated successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;
        }



        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("housekeeping_audit_report.aspx");
        }

        protected void BtnDelObservation_Click(object sender, EventArgs e)
        {
            // Check if more than one row exists
            if (gvObservations.Rows.Count <= 1)
            {
                lblMsg.Text = "At least one observation must remain. Deletion cancelled.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Identify the clicked button and get its row
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            // Get the ObserverID from the row
            TextBox txtObserverID = (TextBox)row.FindControl("txtObserverID");
            string observerId = txtObserverID.Text;

            // Safety check
            if (!string.IsNullOrEmpty(observerId))
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM AuditObservations WHERE ObserverID = @ObserverID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ObserverID", observerId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                // Rebind the grid after deletion
                if (ViewState["AuditID"] != null)
                {
                    int auditID = Convert.ToInt32(ViewState["AuditID"]);
                    LoadObservations(auditID);
                }

                lblMsg.Text = "Observation deleted successfully!";
                lblMsg.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMsg.Text = "Failed to delete: ObserverID is empty.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }







    }

}