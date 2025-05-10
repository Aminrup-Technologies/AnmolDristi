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
                SELECT TOP 10 
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