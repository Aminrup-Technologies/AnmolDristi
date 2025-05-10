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
                string query = "SELECT AuditDate, Location FROM AuditInfo WHERE AuditID = @AuditID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@AuditID", auditID);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtdate.Text = Convert.ToDateTime(reader["AuditDate"]).ToString("yyyy-MM-dd");
                    txtLocation.Text = reader["Location"].ToString();
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

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                foreach (GridViewRow row in gvObservations.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        // Get ObserverID from DataKeys instead of the TextBox
                        string observerID = gvObservations.DataKeys[row.RowIndex].Value.ToString();

                        // Fetch all updated field values from controls
                        DateTime openingDate = DateTime.Parse(((TextBox)row.FindControl("txtOpeningDate")).Text);
                        string openBy = ((TextBox)row.FindControl("txtOpenBy")).Text;
                        string observation = ((TextBox)row.FindControl("txtObservation")).Text;
                        string correctiveAction = ((TextBox)row.FindControl("txtCorrectiveAction")).Text;
                        DateTime closingDate = DateTime.Parse(((TextBox)row.FindControl("txtClosingDate")).Text);
                        string closeBy = ((TextBox)row.FindControl("txtCloseBy")).Text;
                        string status = ((DropDownList)row.FindControl("ddlStatus")).SelectedValue;

                        // Update command
                        string query = @"UPDATE AuditObservations
                                 SET OpeningDate = @OpeningDate,
                                     OpenBy = @OpenBy,
                                     ObservationText = @ObservationText,
                                     CorrectiveAction = @CorrectiveAction,
                                     ClosingDate = @ClosingDate,
                                     CloseBy = @CloseBy,
                                     Status = @Status
                                 WHERE ObserverID = @ObserverID";

                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@ObserverID", observerID);
                            cmd.Parameters.AddWithValue("@OpeningDate", openingDate);
                            cmd.Parameters.AddWithValue("@OpenBy", openBy);
                            cmd.Parameters.AddWithValue("@ObservationText", observation);
                            cmd.Parameters.AddWithValue("@CorrectiveAction", correctiveAction);
                            cmd.Parameters.AddWithValue("@ClosingDate", closingDate);
                            cmd.Parameters.AddWithValue("@CloseBy", closeBy);
                            cmd.Parameters.AddWithValue("@Status", status);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                con.Close();
            }

            // Rebind updated data
            int auditID = Convert.ToInt32(ViewState["AuditID"]);
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
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblMsg.Text = "Failed to delete: ObserverID is empty.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }







    }

}