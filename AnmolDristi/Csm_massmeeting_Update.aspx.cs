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
    public partial class Csm_massmeeting_Update : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["MeetingID"] != null)
                {
                    int meetingID = Convert.ToInt32(Request.QueryString["MeetingID"]);
                    HiddenMeetingID.Value = meetingID.ToString();
                    LoadMeetingDetails(meetingID);
                   

                }
                else
                {
                    Response.Redirect("csm_massmeeting_report.aspx");
                }
            }
        }
        private void LoadMeetingDetails(int meetingID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT M.Meeting_Time, M.Meeting_Date, M.Location, 
                                    A.Employee_Name, A.Designation, A.RFID, 
                                    P.Points_Discussed
                                FROM Meeting M
                                INNER JOIN Attendees A ON M.Meeting_ID = A.Meeting_ID
                                INNER JOIN Points P ON A.Attendees_ID = P.Attendees_ID
                                WHERE M.Meeting_ID = @MeetingID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        TB_Date.Text = Convert.ToDateTime(reader["Meeting_Date"]).ToString("yyyy-MM-dd");
                        tb_time.Text = reader["Meeting_Time"].ToString();
                        tb_loc.Text = reader["Location"].ToString();
                        tb_name.Text = reader["Employee_Name"].ToString();
                        tb_des.Text = reader["Designation"].ToString();
                        tb_rfid.Text = reader["RFID"].ToString();
                        tb_points.Text = reader["Points_Discussed"].ToString();
                    }
                }
            }
        }
        
        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            int meetingID = Convert.ToInt32(HiddenMeetingID.Value);
            string meetingDate = TB_Date.Text;
            string meetingTime = tb_time.Text;
            string location = tb_loc.Text;
            string employeeName = tb_name.Text;
            string designation = tb_des.Text;
            string rfid = tb_rfid.Text;
            string pointsDiscussed = tb_points.Text;

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                    UPDATE Meeting 
                    SET Meeting_Time = @MeetingTime, Meeting_Date = @MeetingDate, Location = @Location 
                    WHERE Meeting_ID = @MeetingID;

                    UPDATE Attendees 
                    SET Employee_Name = @EmployeeName, Designation = @Designation, RFID = @RFID 
                    WHERE Meeting_ID = @MeetingID;

                    UPDATE Points 
                    SET Points_Discussed = @PointsDiscussed 
                    WHERE Attendees_ID IN (SELECT Attendees_ID FROM Attendees WHERE Meeting_ID = @MeetingID)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                    cmd.Parameters.AddWithValue("@MeetingDate", meetingDate);
                    cmd.Parameters.AddWithValue("@MeetingTime", meetingTime);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Parameters.AddWithValue("@EmployeeName", employeeName);
                    cmd.Parameters.AddWithValue("@Designation", designation);
                    cmd.Parameters.AddWithValue("@RFID", rfid);
                    cmd.Parameters.AddWithValue("@PointsDiscussed", pointsDiscussed);
                    cmd.ExecuteNonQuery();
                }
            }
            lblMsg.Text = "Update completed successfully!";
        }
        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("csm_massmeeting_report.aspx");
        }


    }
}