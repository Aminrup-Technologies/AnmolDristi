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
    public partial class housekeeping_Rpt : System.Web.UI.Page
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
            string meetingId = Request.QueryString["AuditID"];
            if (!string.IsNullOrEmpty(meetingId))
            {
                DataTable dtMeetings = GetAuditById(meetingId);
                if (dtMeetings.Rows.Count > 0)
                {
                    RepeaterMeeting.DataSource = dtMeetings;
                    RepeaterMeeting.DataBind();
                }
            }
        }

        private DataTable GetAuditById(string meetingId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand(@"SELECT AuditID,Location,AuditDate,JobID
                                                  FROM AuditInfo 
                                                  WHERE AuditID = @AuditID", con))
                {
                    cmd.Parameters.AddWithValue("@AuditID", meetingId);
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        private DataTable GetObservationsById(string meetingId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT ObserverID,PhotoBefore,ObservationText,CorrectiveAction,PhotoAfter, Status,OpenBy,CloseBy,ClosingDate,OpeningDate,OpenByWorkman,TargetDate,AssignedTo, CAPA_Report FROM AuditObservations WHERE AuditID = @AuditID", con))
                {
                    cmd.Parameters.AddWithValue("@AuditID", meetingId);
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
                    string meetingId = drv["AuditID"].ToString();

                    Repeater repeaterAttendees = e.Item.FindControl("RepeaterObservations") as Repeater;
                    if (repeaterAttendees != null)
                    {
                        DataTable dtAttendees = GetObservationsById(meetingId);
                        repeaterAttendees.DataSource = dtAttendees;
                        repeaterAttendees.DataBind();
                    }
                    
                }
            }
        }



    }
}