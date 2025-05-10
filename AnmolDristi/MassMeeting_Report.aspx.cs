using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class MassMeeting_Report : System.Web.UI.Page
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
                string query = @"SELECT TOP 10 
                                 ID,
                                 MM_DocNo,
                                 CONVERT(VARCHAR(10), Meeting_Date, 23) AS Meeting_Date,
                                 SubmitterCode,
                                 DeptCode,
                                 ExactLocation,
                                 CompanyCode,
                                 Coordinator_Name
                                 FROM  csm_massmeting_records
                                 WHERE MM_Id is not null";



                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        GVMeetings.DataSource = dt;
                        GVMeetings.DataBind();
                        //lblMsg.Text = $"{dt.Rows.Count} record(s) found.";
                        //lblMsg.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        GVMeetings.DataSource = null;
                        GVMeetings.DataBind();
                        lblMsg.Text = "No records found for the selected date range.";
                        lblMsg.ForeColor = System.Drawing.Color.OrangeRed;
                    }


                    //GVMeetings.DataSource = dt;
                    //GVMeetings.DataBind();
                }
            }
        }
        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            string fromDate = TB_FromDate.Text.Trim();
            string toDate = TB_ToDate.Text.Trim();

            if (string.IsNullOrEmpty(fromDate) || string.IsNullOrEmpty(toDate))
            {
                // Optional: show validation error using a Label if needed
                return;
            }

            DateTime parsedFromDate, parsedToDate;
            bool isFromValid = DateTime.TryParseExact(fromDate, "yyyy-MM-dd",
                                        System.Globalization.CultureInfo.InvariantCulture,
                                        System.Globalization.DateTimeStyles.None,
                                        out parsedFromDate);

            bool isToValid = DateTime.TryParseExact(toDate, "yyyy-MM-dd",
                                    System.Globalization.CultureInfo.InvariantCulture,
                                    System.Globalization.DateTimeStyles.None,
                                    out parsedToDate);

            if (!isFromValid || !isToValid)
            {
                // Optional: show error message if needed
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
            SELECT 
                Id,
                MM_DocNo,
                CONVERT(VARCHAR(10), Meeting_Date, 23) AS Meeting_Date,
                SubmitterCode,
                DeptCode,
                ExactLocation,
                CompanyCode,
                Coordinator_Name
            FROM csm_massmeting_records
            WHERE Meeting_Date BETWEEN @FromDate AND @ToDate
              AND DeleteMode = 0
            ORDER BY Meeting_Date DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@FromDate", SqlDbType.Date).Value = parsedFromDate;
                    cmd.Parameters.Add("@ToDate", SqlDbType.Date).Value = parsedToDate;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    GVMeetings.DataSource = dt;
                    GVMeetings.DataBind();
                }
            }

            // Optional: Clear date inputs if needed
            //TB_FromDate.Text = "";
            //TB_ToDate.Text = "";
        }


        protected void BtnReset_Click(object sender, EventArgs e)
        {

            // Reload all meetings (default unfiltered data)
            Response.Redirect("MassMeeting_Report.aspx");
            //LoadMeetings();
        }

        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string meetingId = btn.CommandArgument;

            if (!string.IsNullOrEmpty(meetingId))
            {
                Response.Redirect("MassMeeting_Update.aspx?Id=" + meetingId);
            }
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string meetingId = GVMeetings.DataKeys[row.RowIndex].Value.ToString();

            if (!string.IsNullOrEmpty(meetingId))
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string deleteQuery = "DELETE FROM csm_massmeting_records WHERE Id = @Id";

                    using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", meetingId);

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMsg.Text = "Record deleted successfully.";
                            lblMsg.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            lblMsg.Text = "Error: Record could not be deleted.";
                            lblMsg.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }

                // Refresh the GridView
                LoadMeetings();
            }
        }

        protected void BtnView_Click(object sender, EventArgs e)
        {
            Response.Redirect("dummy.aspx");
        }



    }
}