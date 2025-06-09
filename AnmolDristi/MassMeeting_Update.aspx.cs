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
    public partial class MassMeeting_Update : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["Id"];
                if (!string.IsNullOrEmpty(id))
                {
                    LoadMeetingData(id);
                }
                //LoadAttendees();
                //LoadMeetingMOM();

               


            }
        }

        private void LoadMeetingData(string meetingId)
        {
            string query = "SELECT Meeting_Date, Meeting_StartTime, Meeting_EndTime, " +
               "Duration, RegionCode, CompanyCode, DeptCode, LocationCode, ExactLocation, Coordinator_Name " +
               "FROM csm_massmeting_records WHERE Id = @MeetingID";


            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@MeetingID", Convert.ToInt32(meetingId)); // MM_Id is a VARCHAR

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtdate.Text = Convert.ToDateTime(reader["Meeting_Date"]).ToString("yyyy-MM-dd");
                        txtTime.Text = TimeSpan.Parse(reader["Meeting_StartTime"].ToString()).ToString(@"hh\:mm");
                        txtEndtime.Text = TimeSpan.Parse(reader["Meeting_EndTime"].ToString()).ToString(@"hh\:mm");
                        TB_Duration.Text = reader["Duration"].ToString();
                        DDL_WorkRegion.SelectedValue = reader["RegionCode"].ToString();
                        DDL_Company.SelectedValue = reader["CompanyCode"].ToString();
                        DDL_Department.SelectedValue = reader["DeptCode"].ToString();
                        DDL_Location.SelectedValue = reader["LocationCode"].ToString();
                        TB_ExactLocation.Text = reader["ExactLocation"].ToString();
                        TB_CoordinatorName.Text = reader["Coordinator_Name"].ToString();
                    }

                    reader.Close();
                }
            }
        }



        //private void LoadAttendees()
        //{
        //    if (!Guid.TryParse(Request.QueryString["MM_Id"], out Guid mmId))
        //        return;

        //    string query = @"SELECT EmployeeName, Designation, Attendee_Type, Gate_passno,Image_upload 
        //             FROM csm_massmeting_attendee 
        //             WHERE MM_Id = @MM_Id";

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@MM_Id", mmId);
        //        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
        //        {
        //            DataTable dt = new DataTable();
        //            da.Fill(dt);
        //            GV_Attendees.DataSource = dt;
        //            GV_Attendees.DataBind();
        //        }
        //    }
        //}

        //private void LoadMeetingMOM()
        //{
        //    if (!Guid.TryParse(Request.QueryString["MM_Id"], out Guid mmId))
        //        return;

        //    string query = @"SELECT AgendaTitle, PointBy, DiscussionType, 
        //                    DiscussionDescription1, Duration,Ref_PhotoBefore
        //             FROM csm_massmeting_mom 
        //             WHERE MM_Id = @MM_Id";

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@MM_Id", mmId);
        //        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
        //        {
        //            DataTable dt = new DataTable();
        //            da.Fill(dt);
        //            GV_MOM.DataSource = dt;
        //            GV_MOM.DataBind();
        //        }
        //    }
        //}



        //private void LoadAttendees()
        //{
        //    if (!Guid.TryParse(Request.QueryString["MM_Id"], out Guid mmId))
        //        return;

        //    string query = @"SELECT EmployeeName, Designation, Attendee_Type, Gate_passno 
        //             FROM csm_massmeting_attendee 
        //             WHERE MM_Id = @MM_Id";

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["YourConnectionStringName"].ConnectionString))
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@MM_Id", mmId);
        //        DataTable dt = new DataTable();
        //        SqlDataAdapter da = new SqlDataAdapter(cmd);
        //        da.Fill(dt);
        //        GV_Attendees.DataSource = dt;
        //        GV_Attendees.DataBind();
        //    }
        //}

        //private void LoadAttendees(int mmId)
        //{
        //    string query = @"SELECT EmployeeName, Designation, Attendee_Type, Gate_passno 
        //             FROM csm_massmeting_attendee 
        //             WHERE MM_Id = @MM_Id";

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@MM_Id", mmId);
        //        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
        //        {
        //            DataTable dt = new DataTable();
        //            da.Fill(dt);
        //            GV_Attendees.DataSource = dt;
        //            GV_Attendees.DataBind();
        //        }
        //    }
        //}

        //private void LoadMOM(int mmId)
        //{
        //    string query = @"SELECT AgendaTitle, PointBy, DiscussionType, 
        //                    DiscussionDescription1, DiscussionDescription2, Duration 
        //             FROM csm_massmeting_mom 
        //             WHERE MM_Id = @MM_Id";

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@MM_Id", mmId);
        //        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
        //        {
        //            DataTable dt = new DataTable();
        //            da.Fill(dt);
        //            GV_MOM.DataSource = dt;
        //            GV_MOM.DataBind();
        //        }
        //    }
        //}








        protected void BtnDelAttendees_Click(object sender, EventArgs e) { 

        }



    }
}