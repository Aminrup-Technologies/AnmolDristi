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
    public partial class housekeeping_audit_report : System.Web.UI.Page
    {
        public object AuditID { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
             if (!IsPostBack)
            {
                LoadAuditData();
            }
        }

        private void LoadAuditData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT 
                            ai.AuditID,
                            ai.Title,
                            CONVERT(VARCHAR(10), ai.AuditDate, 23) AS AuditDate,
                            ai.Location,
                            ai.JobID,
                            STRING_AGG(ao.ObservationText, ', ') AS Observations
                        FROM AuditInfo ai
                        LEFT JOIN AuditObservations ao ON ai.AuditID = ao.AuditID
                        GROUP BY ai.AuditID, ai.Title, ai.AuditDate, ai.Location, ai.JobID";




                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);


                    gvAudit.DataSource = dt;
                    gvAudit.DataBind();
                }
            }
        }


        //private void LoadAuditData()
        //{
        //    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("GetAuditInfoWithObservations", conn)) // SP name
        //        {
        //            cmd.CommandType = CommandType.StoredProcedure;

        //            // If your SP has parameters, you can add them like:
        //            // cmd.Parameters.AddWithValue("@SomeParam", value);

        //            SqlDataAdapter da = new SqlDataAdapter(cmd);
        //            DataTable dt = new DataTable();

        //            da.Fill(dt);

        //            gvAudit.DataSource = dt;
        //            gvAudit.DataBind();
        //        }
        //    }
        //}

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string fromDate = txtfromdate.Text.Trim();
            string toDate = txttodate.Text.Trim();

            // Validate that both dates are provided
            if (string.IsNullOrEmpty(fromDate) || string.IsNullOrEmpty(toDate))
            {
                lblMsg.Text = "Please select both From Date and To Date.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Parse the dates safely
            DateTime parsedFromDate, parsedToDate;
            bool isFromDateValid = DateTime.TryParseExact(fromDate, "yyyy-MM-dd",
                                          System.Globalization.CultureInfo.InvariantCulture,
                                          System.Globalization.DateTimeStyles.None,
                                          out parsedFromDate);

            bool isToDateValid = DateTime.TryParseExact(toDate, "yyyy-MM-dd",
                                        System.Globalization.CultureInfo.InvariantCulture,
                                        System.Globalization.DateTimeStyles.None,
                                        out parsedToDate);

            if (!isFromDateValid || !isToDateValid)
            {
                lblMsg.Text = "Invalid date format. Please select valid dates.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                        SELECT 
                        ai.AuditID,
                        ai.Title,
                        CONVERT(VARCHAR(10), ai.AuditDate, 23) AS AuditDate,
                        ai.Location,
                        ao.ObserverID,
                        ao.OpenBy,
                        ao.CloseBy
                        FROM AuditInfo ai
                        LEFT JOIN AuditObservations ao ON ai.AuditID = ao.AuditID
                        WHERE ai.AuditDate BETWEEN @FromDate AND @ToDate";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@FromDate", SqlDbType.Date).Value = parsedFromDate;
                    cmd.Parameters.Add("@ToDate", SqlDbType.Date).Value = parsedToDate;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvAudit.DataSource = dt;
                    gvAudit.DataBind();
                }
            }

            // Clear textboxes after execution
            //txtfromdate.Text = "";
            //txttodate.Text = "";
        }

        protected void BtnView_Click(object sender, EventArgs e)
        { 
            Button btnView = (Button)sender;
            GridViewRow row = (GridViewRow)btnView.NamingContainer;
            int AuditID = Convert.ToInt32(btnView.CommandArgument);
            Response.Redirect($"housekeeping_Rpt.aspx?AuditID={AuditID}");

        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            txtfromdate.Text = "";
            txttodate.Text = "";
            Response.Redirect("housekeeping_audit_report.aspx");
        }
        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            Button btnEdit = (Button)sender;
            GridViewRow row = (GridViewRow)btnEdit.NamingContainer;
            int auditID = Convert.ToInt32(btnEdit.CommandArgument);

            // Redirect to update page with AuditID in query string
            Response.Redirect($"HousekeepingUpdate.aspx?AuditID={auditID}");
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the AuditID of the selected row
                Button btn = (Button)sender;
                GridViewRow row = (GridViewRow)btn.NamingContainer;
                int auditID = Convert.ToInt32(gvAudit.DataKeys[row.RowIndex].Value);

                string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = "DELETE FROM AuditInfo WHERE AuditID = @AuditID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@AuditID", auditID);
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Refresh the GridView after deletion
                            LoadAuditData();
                        }
                        else
                        {
                            Response.Write("<script>alert('Error: Unable to delete record.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
















    }
}