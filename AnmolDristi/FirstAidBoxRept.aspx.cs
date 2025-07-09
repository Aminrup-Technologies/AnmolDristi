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
    public partial class FirstAidBoxRept : System.Web.UI.Page
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
            string meetingId = Request.QueryString["InspectionID"];
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
                using (SqlCommand cmd = new SqlCommand(@"SELECT InspectionID, Location, InspectionDate,InspectedBy,EmployeeName,Remarks,TotalItemCount,PhotoPath
                                                  FROM FirstAidInspectionHeader
                                                  WHERE InspectionID = @InspectionID", con))
                {
                    cmd.Parameters.AddWithValue("@InspectionID", meetingId);
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
                    string meetingId = drv["InspectionID"].ToString();

                    Repeater repeaterAttendees = e.Item.FindControl("RepeaterChecklist") as Repeater;
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
                using (SqlCommand cmd = new SqlCommand("SELECT QuestionNumber,description,IsOk,ItemName,PhotoPath FROM FirstAidChecklist WHERE InspectionID = @InspectionID", con))
                {
                    cmd.Parameters.AddWithValue("@InspectionID", meetingId);
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
                using (SqlCommand cmd = new SqlCommand("SELECT ItemName,Quantity,ExpiryDate,LastRefilledDate,NextRefillDueDate FROM  FirstAidItemDetails WHERE InspectionID = @InspectionID", con))
                {
                    cmd.Parameters.AddWithValue("@InspectionID", meetingId);
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }



    }
}