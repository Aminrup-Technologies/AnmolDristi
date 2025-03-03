using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing.Drawing2D;
using AnmolDristi.DAL;
using System.Globalization;
using System.Web.Script.Serialization;


namespace AnmolDristi
{
    public partial class csm_massmeeting_report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMeetings();
            }

        }
        private void LoadMeetings()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
            SELECT 
                M.Meeting_ID,
                M.Meeting_Time,
                M.Meeting_Date,
                M.Location,
                A.Employee_Name,
                A.Designation,
                A.RFID,
                P.Points_Discussed
            FROM Meeting M
            INNER JOIN Attendees A ON M.Meeting_ID = A.Meeting_ID
            INNER JOIN Points P ON A.Attendees_ID = P.Attendees_ID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["Points_Discussed"] != DBNull.Value)
                        {
                            string points = row["Points_Discussed"].ToString();
                            string[] pointArray = points.Split('|'); // Splitting based on '|'
                            string formattedPoints = "<ol><li>" + string.Join("</li><li>", pointArray) + "</li></ol>";
                            row["Points_Discussed"] = formattedPoints;
                        }
                    }

                    gvMeetings.DataSource = dt;
                    gvMeetings.DataBind();
                }
            }
        }
        //protected void BtnUpdate_Click(object sender, EventArgs e)
        //{
        //    Button btn = (Button)sender;
        //    GridViewRow row = (GridViewRow)btn.NamingContainer;

        //    int meetingID = Convert.ToInt32(gvMeetings.DataKeys[row.RowIndex].Value);
        //    string meetingTime = ((TextBox)row.FindControl("txtMeetingTime")).Text;
        //    string meetingDate = ((TextBox)row.FindControl("txtMeetingDate")).Text;
        //    string location = ((TextBox)row.FindControl("txtLocation")).Text;
        //    string employeeName = ((TextBox)row.FindControl("txtEmployeeName")).Text;
        //    string designation = ((TextBox)row.FindControl("txtDesignation")).Text;
        //    string rfid = ((TextBox)row.FindControl("txtRFID")).Text;
        //    string pointsDiscussed = ((TextBox)row.FindControl("txtPointsDiscussed")).Text;

        //    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        conn.Open();
        //        string query = @"UPDATE Meeting 
        //                 SET Meeting_Time = @Meeting_Time, Meeting_Date = @Meeting_Date, Location = @Location 
        //                 WHERE Meeting_ID = @Meeting_ID;

        //                 UPDATE Attendees 
        //                 SET Employee_Name = @Employee_Name, Designation = @Designation, RFID = @RFID 
        //                 WHERE Meeting_ID = @Meeting_ID;

        //                 UPDATE Points 
        //                 SET Points_Discussed = @Points_Discussed 
        //                 WHERE Attendees_ID IN (SELECT Attendees_ID FROM Attendees WHERE Meeting_ID = @Meeting_ID)";

        //        using (SqlCommand cmd = new SqlCommand(query, conn))
        //        {
        //            cmd.Parameters.AddWithValue("@Meeting_ID", meetingID);
        //            cmd.Parameters.AddWithValue("@Meeting_Time", meetingTime);
        //            cmd.Parameters.AddWithValue("@Meeting_Date", meetingDate);
        //            cmd.Parameters.AddWithValue("@Location", location);
        //            cmd.Parameters.AddWithValue("@Employee_Name", employeeName);
        //            cmd.Parameters.AddWithValue("@Designation", designation);
        //            cmd.Parameters.AddWithValue("@RFID", rfid);
        //            cmd.Parameters.AddWithValue("@Points_Discussed", pointsDiscussed);
        //            cmd.ExecuteNonQuery();
        //        }
        //    }
        //    LoadMeetings(); // Refresh grid after update
        //}

        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int meetingID = Convert.ToInt32(gvMeetings.DataKeys[row.RowIndex].Value);
            Response.Redirect("Csm_massmeeting_Update.aspx?MeetingID=" + meetingID);
        }



        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int meetingID = Convert.ToInt32(gvMeetings.DataKeys[row.RowIndex].Value);

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("DeleteMeeting", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Meeting_ID", meetingID);
                    cmd.ExecuteNonQuery();
                }
            }
            LoadMeetings(); // Refresh grid after deletion
        }
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("csm_massmeeting_report.aspx");
            TB_FromDate.Text = string.Empty;
            TB_ToDate.Text = string.Empty;

            // Optional: Clear the GridView as well
            gvMeetings.DataSource = null;
            gvMeetings.DataBind();
        }
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string fromDate = TB_FromDate.Text;
            string toDate = TB_ToDate.Text;

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
            SELECT 
                M.Meeting_ID,
                M.Meeting_Time,
                M.Meeting_Date,
                M.Location,
                A.Employee_Name,
                A.Designation,
                A.RFID,
                P.Points_Discussed
            FROM Meeting M
            INNER JOIN Attendees A ON M.Meeting_ID = A.Meeting_ID
            INNER JOIN Points P ON A.Attendees_ID = P.Attendees_ID
            WHERE M.Meeting_Date = @FromDate";

                if (!string.IsNullOrEmpty(toDate))
                {
                    query = @"
                SELECT 
                    M.Meeting_ID,
                    M.Meeting_Time,
                    M.Meeting_Date,
                    M.Location,
                    A.Employee_Name,
                    A.Designation,
                    A.RFID,
                    P.Points_Discussed
                FROM Meeting M
                INNER JOIN Attendees A ON M.Meeting_ID = A.Meeting_ID
                INNER JOIN Points P ON A.Attendees_ID = P.Attendees_ID
                WHERE M.Meeting_Date BETWEEN @FromDate AND @ToDate";
                }

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FromDate", fromDate);
                    if (!string.IsNullOrEmpty(toDate))
                    {
                        cmd.Parameters.AddWithValue("@ToDate", toDate);
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["Points_Discussed"] != DBNull.Value)
                        {
                            string points = row["Points_Discussed"].ToString();
                            string[] pointArray = points.Split('|');
                            string formattedPoints = "<ol><li>" + string.Join("</li><li>", pointArray) + "</li></ol>";
                            row["Points_Discussed"] = formattedPoints;
                        }
                    }

                    gvMeetings.DataSource = dt;
                    gvMeetings.DataBind();
                }
            }
            TB_FromDate.Text = string.Empty;
            TB_ToDate.Text = string.Empty;
        }


    }
}