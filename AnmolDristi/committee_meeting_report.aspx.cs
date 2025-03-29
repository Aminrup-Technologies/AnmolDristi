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
    public partial class committee_meeting_report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    if (Session["USERID"] == null || Session["USERNAME"] == null || Session["WORKMAN"] == null)
            //    {
            //        Response.Redirect("login.aspx");
            //    }
            //    else
            //    {

            //    }
            //}
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
                string query = @"SELECT 
                    MeetingID, 
                    MeetingNo, 
                    Title, 
                    MeetingDate, 
                    MeetingTime, 
                    Venue, 
                    ChairedBy
                FROM Committee_MeetingReview
                ORDER BY MeetingDate DESC";
            

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvMeetings.DataSource = dt;
                    gvMeetings.DataBind();
                }
            }
        }

        

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
           

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                   
                    string query = @"SELECT MeetingID, MeetingNo, Title, MeetingDate, MeetingTime, Venue, ChairedBy
                             FROM Committee_MeetingReview
                             WHERE MeetingDate BETWEEN @FromDate AND @ToDate
                             ORDER BY MeetingDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@FromDate", Convert.ToDateTime(TB_FromDate.Text.Trim()));
                        cmd.Parameters.AddWithValue("@ToDate", Convert.ToDateTime(TB_ToDate.Text.Trim()));

                        //cmd.Parameters.AddWithValue("@FromDate", fromDate.ToString("yyyy-MM-dd"));
                        //cmd.Parameters.AddWithValue("@ToDate", toDate.ToString("yyyy-MM-dd"));

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                gvMeetings.DataSource = dt; // Bind to GridView
                                gvMeetings.DataBind();
                            }
                            else
                            {
                                gvMeetings.DataSource = null;
                                gvMeetings.DataBind();
                                lblMsg.Text = "No records found!";
                                lblMsg.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "Error: " + ex.Message;
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void BtnEdit_Click(object sender, EventArgs e)
        {

        }
        protected void BtnDelete_Click(object sender, EventArgs e)
        {

        }
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("committee_meeting_report.aspx");
            TB_FromDate.Text = string.Empty;
            TB_ToDate.Text = string.Empty;

            // Optional: Clear the GridView as well
            gvMeetings.DataSource = null;
            gvMeetings.DataBind();
        }


    }
}