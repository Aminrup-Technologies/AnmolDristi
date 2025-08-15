using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class FullBodyHarnessRpt : System.Web.UI.Page
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
            string meetingId = Request.QueryString["InspectionID"];
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
                using (SqlCommand cmd = new SqlCommand(@"SELECT InspectionID,DateOfInspection,Site,JobID,EmployeeName,InspectedBy,Remarks
                                                  FROM InspectionHeader 
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

        private DataTable GetObservationsById(string meetingId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Location,InspectionNo,QuestionNumber,IsOk,Remarks,PhotoPath,Capa_Report FROM InspectionChecklist WHERE InspectionID = @InspectionID", con))
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
                        DataTable dtAttendees = GetObservationsById(meetingId);
                        //repeaterAttendees.DataSource = dtAttendees;
                        //repeaterAttendees.DataBind();
                        repeaterAttendees.DataSource = dtAttendees;
                        repeaterAttendees.ItemDataBound += RepeaterChecklist_ItemDataBound; // Add this
                        repeaterAttendees.DataBind();

                    }

                }
            }
        }
        protected void RepeaterChecklist_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblDescription = (Label)e.Item.FindControl("lblDescription");
                if (lblDescription != null)
                {
                    int sno;
                    if (int.TryParse(DataBinder.Eval(e.Item.DataItem, "QuestionNumber").ToString(), out sno))
                    {
                        lblDescription.Text = GetDescriptionBySNo(sno);
                    }
                }
            }
        }
        private string GetDescriptionBySNo(int sno)
        {
            switch (sno)
            {
                case 1: return "Is the Harness conforming to IS: 3521 & also full body double lanyard type and length is not more than 1.8mtr?";
                case 2: return " Condition of Lanyard: A) No visible damage B) Burn C) Cut D) Worn/Torn out";
                case 3: return "Condition of thimble and snap hook: A) No visible damage B) Smooth working of hook";
                case 4: return "Condition of stitching and buckles: A) Stitching is ok B) Rust free buckles";
                case 5: return "Condition of D-RINGS: A) Distortion B) Cracks C) Sharp edges D) Break";
                default: return "N/A";
            }
        }




    }
}