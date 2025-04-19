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

namespace AnmolDristi
{
    public partial class Committee_meeting_update : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["MeetingID"] != null)
                {
                    int meetingID = Convert.ToInt32(Request.QueryString["MeetingID"]);
                    LoadMeetingDetails(meetingID);
                    LoadAttendance(meetingID);
                    LoadIssues(meetingID);
                }
            }
        }

        private void LoadMeetingDetails(int meetingID)
        {
            string query = @"SELECT MeetingNo, Title, MeetingDate, MeetingTime, Venue, ChairedBy 
                     FROM Committee_MeetingReview 
                     WHERE MeetingID = @MeetingID";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtMeetingNo.Text = reader["MeetingNo"].ToString();
                    txtdate.Text = Convert.ToDateTime(reader["MeetingDate"]).ToString("yyyy-MM-dd");
                    txtTime.Text = TimeSpan.Parse(reader["MeetingTime"].ToString()).ToString(@"hh\:mm");
                    txtVenue.Text = reader["Venue"].ToString();
                    txtChairedBy.Text = reader["ChairedBy"].ToString();
                }
            }
        }
       

        private void LoadAttendance(int meetingID)
        {
            string query = @"SELECT Name , Designation, AttendeeCode, Attendee_Type , 
                            Image_upload AS ImagePath, AttendanceStatus , AttendanceID
                     FROM Committee_MeetingAttendance 
                     WHERE MeetingID = @MeetingID";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvAttendees.DataSource = dt;
                    gvAttendees.DataBind();
                }
            }
        }
        private void LoadIssues(int meetingID)
        {
            string query = @"SELECT IssueID , AgendaTitle, IssueDescription AS IssuesDiscussed, 
                            ResponsiblePerson AS ActionBy, TargetDate, ReviewDate, ReviewBy, Status 
                     FROM Committee_MeetingIssues 
                     WHERE MeetingID = @MeetingID";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvIssues.DataSource = dt;
                    gvIssues.DataBind();
                }
            }
        }
        
        protected void BtnDelAttendees_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            
            string attendeeId = gvAttendees.DataKeys[row.RowIndex].Value.ToString();

            if (!string.IsNullOrEmpty(attendeeId))
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Committee_MeetingAttendance WHERE AttendanceID = @AttendanceID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@AttendanceID", attendeeId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                if (Request.QueryString["MeetingID"] != null)
                {
                    int meetingID = Convert.ToInt32(Request.QueryString["MeetingID"]);
                    LoadAttendance(meetingID);  
                }
            }
        }

        protected void BtnDelIssues_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            // Use DataKeys to get the SNo (IssueID)
            string issueId = gvIssues.DataKeys[row.RowIndex].Value.ToString();

            if (!string.IsNullOrEmpty(issueId))
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Committee_MeetingIssues WHERE IssueID = @IssueID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@IssueID", issueId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                // Reload issues
                if (Request.QueryString["MeetingID"] != null)
                {
                    int meetingID = Convert.ToInt32(Request.QueryString["MeetingID"]);
                    LoadIssues(meetingID);
                }
            }
        }
        protected void Btnback_Click(object sender, EventArgs e)
        {
            Response.Redirect("committee_meeting_report.aspx");
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int meetingID = Convert.ToInt32(Request.QueryString["MeetingID"]);

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    // 1. Update Committee_MeetingReview
                    SqlCommand cmdReview = new SqlCommand(@"UPDATE Committee_MeetingReview 
                                                     SET MeetingNo = @MeetingNo, 
                                                         MeetingDate = @MeetingDate, 
                                                         MeetingTime = @MeetingTime, 
                                                         Venue = @Venue, 
                                                         ChairedBy = @ChairedBy 
                                                     WHERE MeetingID = @MeetingID", con, transaction);
                    cmdReview.Parameters.AddWithValue("@MeetingNo", txtMeetingNo.Text);
                    cmdReview.Parameters.AddWithValue("@MeetingDate", txtdate.Text);
                    cmdReview.Parameters.AddWithValue("@MeetingTime", txtTime.Text);
                    cmdReview.Parameters.AddWithValue("@Venue", txtVenue.Text);
                    cmdReview.Parameters.AddWithValue("@ChairedBy", txtChairedBy.Text);
                    cmdReview.Parameters.AddWithValue("@MeetingID", meetingID);
                    cmdReview.ExecuteNonQuery();

                    // 2. Update Committee_MeetingAttendance
                    foreach (GridViewRow row in gvAttendees.Rows)
                    {
                        int attendanceID = Convert.ToInt32(gvAttendees.DataKeys[row.RowIndex].Value);

                        string name = ((TextBox)row.FindControl("txtEmployeeName")).Text;
                        string designation = ((TextBox)row.FindControl("txtDesignation")).Text;
                        string code = ((TextBox)row.FindControl("txtAttendeeCode")).Text;
                        string type = ((TextBox)row.FindControl("txtAttendeeType")).Text;
                        string status = ((DropDownList)row.FindControl("ddlAttendanceStatus")).SelectedValue;

                        FileUpload fu = (FileUpload)row.FindControl("fuimgPreview");
                        string imgPath = ((Label)row.FindControl("lblimgPreview")).Text;

                        if (fu.HasFile)
                        {
                            string folderPath = Server.MapPath("~/Uploads/");
                            if (!Directory.Exists(folderPath))
                                Directory.CreateDirectory(folderPath);

                            string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fu.FileName);
                            string fullPath = folderPath + fileName;
                            fu.SaveAs(fullPath);
                            imgPath = "~/Uploads/" + fileName;
                        }

                        SqlCommand cmdAtt = new SqlCommand(@"UPDATE Committee_MeetingAttendance 
                                                     SET Name = @Name, 
                                                         Designation = @Designation, 
                                                         AttendeeCode = @Code, 
                                                         Attendee_Type = @Type, 
                                                         AttendanceStatus = @Status, 
                                                         Image_upload = @Image 
                                                     WHERE AttendanceID = @ID", con, transaction);
                        cmdAtt.Parameters.AddWithValue("@Name", name);
                        cmdAtt.Parameters.AddWithValue("@Designation", designation);
                        cmdAtt.Parameters.AddWithValue("@Code", code);
                        cmdAtt.Parameters.AddWithValue("@Type", type);
                        cmdAtt.Parameters.AddWithValue("@Status", status);
                        cmdAtt.Parameters.AddWithValue("@Image", imgPath);
                        cmdAtt.Parameters.AddWithValue("@ID", attendanceID);
                        cmdAtt.ExecuteNonQuery();
                    }

                    // 3. Update Committee_MeetingIssues
                    foreach (GridViewRow row in gvIssues.Rows)
                    {
                        int issueID = Convert.ToInt32(gvIssues.DataKeys[row.RowIndex].Value);

                        string agenda = ((TextBox)row.FindControl("txtAgendaTitle")).Text;
                        string issues = ((TextBox)row.FindControl("txtIssuesDiscussed")).Text;
                        string actionBy = ((TextBox)row.FindControl("txtActionBy")).Text;
                        DateTime targetDate = Convert.ToDateTime(((TextBox)row.FindControl("txtTargetDate")).Text);
                        DateTime reviewDate = Convert.ToDateTime(((TextBox)row.FindControl("txtReviewDate")).Text);
                        string reviewBy = ((TextBox)row.FindControl("txtReviewBy")).Text;
                        string status = ((DropDownList)row.FindControl("ddlStattus")).SelectedValue;

                        SqlCommand cmdIssue = new SqlCommand(@"UPDATE Committee_MeetingIssues 
                               SET AgendaTitle = @Agenda, 
                                   IssueDescription = @IssueDesc, 
                                   ResponsiblePerson = @ActionBy, 
                                   TargetDate = @TargetDate, 
                                   ReviewDate = @ReviewDate, 
                                   ReviewBy = @ReviewBy, 
                                   Status = @Status 
                               WHERE IssueID = @IssueID", con, transaction);

                        cmdIssue.Parameters.AddWithValue("@Agenda", agenda);
                        cmdIssue.Parameters.AddWithValue("@IssueDesc", issues);
                        cmdIssue.Parameters.AddWithValue("@ActionBy", actionBy);
                        cmdIssue.Parameters.AddWithValue("@TargetDate", targetDate);
                        cmdIssue.Parameters.AddWithValue("@ReviewDate", reviewDate);
                        cmdIssue.Parameters.AddWithValue("@ReviewBy", reviewBy);
                        cmdIssue.Parameters.AddWithValue("@Status", status);
                        cmdIssue.Parameters.AddWithValue("@IssueID", issueID);
                        cmdIssue.ExecuteNonQuery();
                    }

                    transaction.Commit();

                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblMsg.Text = "Updated successfully!";
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = "Error: " + ex.Message;
                }
            }
        }








    }
}