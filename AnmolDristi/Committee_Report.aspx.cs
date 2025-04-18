using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Committee_Report : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMeetingData(); // Load meeting data on initial page load
            }
        }

        private void LoadMeetingData()
        {
            // Get connection string from Web.config
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;


            // SQL Query to load meeting data
            string query = @"SELECT [Date], [Time], [Venue], [MeetingNo], [ChairedBy]
                             FROM [CSMS].[dbo].[Committee_MeetingAttendance]";

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    RepeaterMeeting.DataSource = dt;
                    RepeaterMeeting.DataBind();
                }
            }
            catch (SqlException ex)
            {
                // Log the exception (consider using a logging framework)
                // Display a user-friendly message
                Response.Write("An error occurred while loading meeting data: " + ex.Message);
            }
        }

        protected void RepeaterMeeting_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Get the Meeting ID from the current item
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                int meetingId = Convert.ToInt32(rowView["MeetingNo"]); // Assuming MeetingNo is the ID

                // Load attendees for the current meeting
                Repeater repeaterAttendees = e.Item.FindControl("RepeaterAttendees") as Repeater;
                if (repeaterAttendees != null)
                {
                    LoadAttendanceData(meetingId, repeaterAttendees);
                }
            }
        }

        private void LoadAttendanceData(int meetingId, Repeater repeater)
        {
            // Get connection string from Web.config (corrected to use "DbConn")
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;


            // SQL Query to load attendance data for the specific meeting
            string query = @"SELECT [AttendanceID], [MeetingID], [Name], [Designation], 
                             [AttendeeCode], [Attendee_Type], [Image_upload], [AttendanceStatus]
                             FROM [CSMS].[dbo].[Committee_MeetingAttendance]
                             WHERE MeetingID = @MeetingID";

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@MeetingID", meetingId);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    repeater.DataSource = dt;
                    repeater.DataBind();
                }
            }
            catch (SqlException ex)
            {
                // Log the exception (consider using a logging framework)
                // Display a user-friendly message
                Response.Write("An error occurred while loading attendance data: " + ex.Message);
            }
        }
    }
}