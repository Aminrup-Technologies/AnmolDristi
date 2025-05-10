using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Data.Entity.Infrastructure.Design.Executor;

namespace AnmolDristi
{
    public partial class committee_meeting_report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMeetingData();
            }
        }

        private void LoadMeetingData()
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = @"
                    SELECT TOP 10
                     MeetingID, 
                     MeetingNo, 
                     Title, 
                     CONVERT(VARCHAR(10), MeetingDate, 23) AS MeetingDate, 
                     CONVERT(VARCHAR(8), MeetingTime, 108) AS MeetingTime,
                     Venue, 
                     ChairedBy 
                     FROM Committee_MeetingReview 
                     WHERE MeetingID IS NOT NULL
                     ORDER BY MeetingDate DESC";



                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                gvMeeting.DataSource = dt;
                                gvMeeting.DataBind();
                                //lblMsg.Text = $"{dt.Rows.Count} record(s) found.";
                                //lblMsg.ForeColor = System.Drawing.Color.Green;
                            }
                            else
                            {
                                gvMeeting.DataSource = null;
                                gvMeeting.DataBind();
                                lblMsg.Text = "No records found for the selected date range.";
                                lblMsg.ForeColor = System.Drawing.Color.OrangeRed;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        protected void BtnView_Click(object sender, EventArgs e)
        {
            Response.Redirect("Committee_Report.aspx");
        }
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string fromDate = txtFromDate.Text;
            string toDate = txtToDate.Text;

            if (string.IsNullOrEmpty(fromDate) || string.IsNullOrEmpty(toDate))
            {
                lblMsg.Text = "Please select both From Date and To Date.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
            SELECT 
            MeetingID, 
            MeetingNo, 
            Title, 
            CONVERT(VARCHAR(10), MeetingDate, 23) AS MeetingDate, 
            CONVERT(VARCHAR(8), MeetingTime, 108) AS MeetingTime,
            Venue, 
            ChairedBy 
            FROM Committee_MeetingReview
            WHERE MeetingDate BETWEEN @FromDate AND @ToDate";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@FromDate", SqlDbType.Date).Value = DateTime.ParseExact(fromDate, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);
                    cmd.Parameters.Add("@ToDate", SqlDbType.Date).Value = DateTime.ParseExact(toDate, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvMeeting.DataSource = dt;
                    gvMeeting.DataBind();
                }
            }
            txtFromDate.Text = "";
            txtToDate.Text = "";
        }
        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            
            Button btnEdit = (Button)sender;
            GridViewRow row = (GridViewRow)btnEdit.NamingContainer;
            int MeetingID = Convert.ToInt32(btnEdit.CommandArgument);
            Response.Redirect($"Committee_meeting_update.aspx?MeetingID={MeetingID}");
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the MeetingID of the selected row
                Button btn = (Button)sender;
                GridViewRow row = (GridViewRow)btn.NamingContainer;
                int meetingID = Convert.ToInt32(gvMeeting.DataKeys[row.RowIndex].Value);

                string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = "DELETE FROM Committee_MeetingReview WHERE MeetingID = @MeetingID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Refresh the GridView after deletion
                            LoadMeetingData();
                        }
                        else
                        {
                            Response.Write("<script>alert('Error: Unable to delete record.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("committee_meeting_report.aspx");
            //txtFromDate.Text = "";
            //txtToDate.Text = "";
            //LoadMeetingData();
        }
        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("committee_meeting.aspx");
           
        }




    }
}