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
    public partial class Committee_Report : Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMeetingData();
                RepeaterMeeting.DataBind();
            }

        }

        private void BindMeetingData()
        {
            string meetingId = Request.QueryString["MeetingID"];
            if (!string.IsNullOrEmpty(meetingId))
            {
                DataTable dtMeetings = GetMeetingById(meetingId);
                if (dtMeetings.Rows.Count > 0)
                {
                    RepeaterMeeting.DataSource = dtMeetings;
                    RepeaterMeeting.DataBind();
                }
            }
        }
        private DataTable GetMeetingById(string meetingId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand(@"SELECT MeetingID, MeetingDate, MeetingTime, Venue, MeetingNo, ChairedBy ,Image_upload
                                                  FROM Committee_MeetingReview 
                                                  WHERE MeetingID = @MeetingID", con))
                {
                    cmd.Parameters.AddWithValue("@MeetingID", meetingId);
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }



        protected void RepeaterMeeting_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                if (drv != null)
                {
                    string meetingId = drv["MeetingID"].ToString();

                    Repeater repeaterAttendees = e.Item.FindControl("RepeaterAttendees") as Repeater;
                    if (repeaterAttendees != null)
                    {
                        DataTable dtAttendees = GetAttendeesByMeetingId(meetingId);
                        repeaterAttendees.DataSource = dtAttendees;
                        repeaterAttendees.DataBind();
                    }
                    Repeater repeaterIssues = e.Item.FindControl("RepeaterIssues") as Repeater;
                    if (repeaterIssues != null)
                    {
                        DataTable dtIssues = GetIssuesByMeetingId(meetingId);
                        repeaterIssues.DataSource = dtIssues;
                        repeaterIssues.DataBind();
                    }
                }
            }
        }

        private DataTable GetAttendeesByMeetingId(string meetingId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Name,Designation,Attendee_Type,AttendanceStatus FROM Committee_MeetingAttendance WHERE MeetingID = @MeetingID", con))
                {
                    cmd.Parameters.AddWithValue("@MeetingID", meetingId);
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }
        private DataTable GetIssuesByMeetingId(string meetingId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT IssueDescription,ResponsiblePerson,TargetDate,AgendaTitle,ReviewDate,ReviewBy,Status,Capa_Report FROM  Committee_MeetingIssues WHERE MeetingID = @MeetingID", con))
                {
                    cmd.Parameters.AddWithValue("@MeetingID", meetingId);
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }



    }
}