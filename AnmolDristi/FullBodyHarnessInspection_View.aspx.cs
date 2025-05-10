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
    public partial class FullBodyHarnessInspection_View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInspectionData();
            }
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            string fromDate = txdate.Text.Trim();
            string toDate = ttodate.Text.Trim();

            if (string.IsNullOrEmpty(fromDate) || string.IsNullOrEmpty(toDate))
            {
                lblMsg.Text = "Please enter both From and To dates.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
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
                lblMsg.Text = "Invalid date format.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT 
                InspectionID, 
                Site,
                 EmployeeName,
                InspectedBy, 
                CONVERT(VARCHAR(10), DateOfInspection, 23) AS DateOfInspection 
            FROM [CSMS].[dbo].[InspectionHeader]
            WHERE DateOfInspection BETWEEN @FromDate AND @ToDate
            ORDER BY DateOfInspection DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@FromDate", SqlDbType.Date).Value = parsedFromDate;
                    cmd.Parameters.Add("@ToDate", SqlDbType.Date).Value = parsedToDate;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        gvInspection.DataSource = dt;
                        gvInspection.DataBind();
                        lblMsg.Text = $"{dt.Rows.Count} record(s) found.";
                        lblMsg.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        gvInspection.DataSource = null;
                        gvInspection.DataBind();
                        lblMsg.Text = "No records found for the selected date range.";
                        lblMsg.ForeColor = System.Drawing.Color.OrangeRed;
                    }
                }
            }
            // Optional: Clear date inputs if needed
            txdate.Text = "";
            ttodate.Text = "";
        }




        private void LoadInspectionData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP (5) [InspectionID], [EmployeeName], [Site], [InspectedBy], [DateOfInspection] 
                         FROM [CSMS].[dbo].[InspectionHeader] 
                         ORDER BY DateOfInspection DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                try
                {
                    conn.Open();
                    da.Fill(dt);
                    gvInspection.DataSource = dt;
                    gvInspection.DataBind();
                }
                catch (Exception ex)
                {
                    // Optional: handle/log error
                    lblMsg.Text = "Error loading data: " + ex.Message;
                }
            }
        }

        
        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the InspectionID of the selected row
                Button btn = (Button)sender;
                GridViewRow row = (GridViewRow)btn.NamingContainer;
                int inspectionID = Convert.ToInt32(gvInspection.DataKeys[row.RowIndex].Value);

                string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = "DELETE FROM InspectionHeader WHERE InspectionID = @InspectionID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@InspectionID", inspectionID);
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Reload updated data into GridView
                            LoadInspectionData();
                            // Optionally show success message
                            // Response.Write("<script>alert('Inspection deleted successfully.');</script>");
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
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }

        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            Button btnEdit = (Button)sender;
            GridViewRow row = (GridViewRow)btnEdit.NamingContainer;
            int InspectionID = Convert.ToInt32(btnEdit.CommandArgument);

            // Redirect to update page with AuditID in query string
            Response.Redirect($"FullBodyHarnessInspection_Update.aspx?InspectionID={InspectionID}");
        }

        //Reset Button is not working
        protected void BtnReseet_Click(object sender, EventArgs e)
        {
           
           Response.Redirect("FullBodyHarnessInspection_View.aspx");
           
        }
    }
}