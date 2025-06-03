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
using System.Web.Services;
using System.Web.Script.Services;
using System.Diagnostics;
using static System.Net.Mime.MediaTypeNames;

namespace AnmolDristi
{
    public partial class WeldingChecklistRpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMeetingData();
            }
        }
        private void BindMeetingData()
        {
            string meetingId = Request.QueryString["HeaderID"];
            if (!string.IsNullOrEmpty(meetingId))
            {
                DataTable dtMeetings = GetChecklistById(meetingId);
                if (dtMeetings.Rows.Count > 0)
                {
                    RepeaterMeeting.DataSource = dtMeetings;
                    RepeaterMeeting.DataBind();
                }
            }
        }
        private DataTable GetChecklistById(string meetingId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand(@"SELECT HeaderID,ChecklistDate,JobID,EmployeeName,InspectedBy,Remarks
                                                  FROM WeldingChecklistHeader 
                                                  WHERE HeaderID = @HeaderID", con))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", meetingId);
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
                using (SqlCommand cmd = new SqlCommand("SELECT QuestionNumber,IsOk,Remarks,PhotoPath,NA,description FROM WeldingChecklist WHERE HeaderID = @HeaderID", con))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", meetingId);
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
                    string meetingId = drv["HeaderID"].ToString();

                    Repeater repeaterAttendees = e.Item.FindControl("RepeaterChecklist") as Repeater;
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