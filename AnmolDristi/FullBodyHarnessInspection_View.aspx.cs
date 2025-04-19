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
            lblMsg.Text = ""; // Clear previous messages

            string fromDateStr = txdate.Text.Trim();
            string toDateStr = ttodate.Text.Trim();

            if (!string.IsNullOrEmpty(fromDateStr) && !string.IsNullOrEmpty(toDateStr))
            {
                DateTime fromDate, toDate;

                if (DateTime.TryParse(fromDateStr, out fromDate) && DateTime.TryParse(toDateStr, out toDate))
                {
                    string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        string query = @"SELECT [InspectionID], [DocumentNo], [Site], [InspectedBy], [DateOfInspection]
                                 FROM [CSMS].[dbo].[InspectionHeader]
                                 WHERE DateOfInspection BETWEEN @FromDate AND @ToDate
                                 ORDER BY DateOfInspection DESC";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@FromDate", fromDate);
                            cmd.Parameters.AddWithValue("@ToDate", toDate);

                            DataTable dt = new DataTable();
                            SqlDataAdapter da = new SqlDataAdapter(cmd);

                            try
                            {
                                conn.Open();
                                da.Fill(dt);

                                if (dt.Rows.Count > 0)
                                {
                                    gvInspection.DataSource = dt;
                                    gvInspection.DataBind();
                                }
                                else
                                {
                                    gvInspection.DataSource = null;
                                    gvInspection.DataBind();
                                    lblMsg.Text = "No records found for the selected date range.";
                                }
                            }
                            catch (Exception ex)
                            {
                                lblMsg.Text = "Error: " + ex.Message;
                            }
                        }
                    }
                }
                else
                {
                    lblMsg.Text = "Invalid date format.";
                }
            }
            else
            {
                lblMsg.Text = "Both dates are required.";
            }
        }


        private void LoadInspectionData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT TOP (5) [InspectionID], [DocumentNo], [Site], [InspectedBy], [DateOfInspection] 
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
    }
}