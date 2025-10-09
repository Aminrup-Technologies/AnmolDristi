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
using System.Web.Services;
using System.Web.Script.Services;
using System.Diagnostics;
using System.Runtime.Remoting.Messaging;

namespace AnmolDristi
{
    public partial class FirstAidBoxView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRecords();
            }
        }
        private void LoadRecords()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT InspectionID,InspectionDate,Location,InspectedBy  from FirstAidInspectionHeader ORDER BY InspectionID Desc";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);


                    gvChecklist.DataSource = dt;
                    gvChecklist.DataBind();
                }
            }
        }
        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btnView = (Button)sender;
            GridViewRow row = (GridViewRow)btnView.NamingContainer;
            string InspectionID = btnView.CommandArgument.ToString(); 
            Response.Redirect($"FirstAidBoxRept.aspx?InspectionID={InspectionID}");
        }
        protected void Btndelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            string inspectionID = gvChecklist.DataKeys[row.RowIndex].Value.ToString();

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Step 1: Delete child records first
                SqlCommand deleteChecklistCmd = new SqlCommand("DELETE FROM FirstAidChecklist WHERE InspectionID = @InspectionID", con);
                deleteChecklistCmd.Parameters.AddWithValue("@InspectionID", inspectionID);
                deleteChecklistCmd.ExecuteNonQuery();
                SqlCommand deleteChecklistCmdd = new SqlCommand("DELETE FROM FirstAidItemDetails WHERE InspectionID = @InspectionID", con);
                deleteChecklistCmdd.Parameters.AddWithValue("@InspectionID", inspectionID);
                deleteChecklistCmdd.ExecuteNonQuery();
                // Step 2: Delete header records
                SqlCommand deleteHeaderCmd = new SqlCommand("DELETE FROM FirstAidInspectionHeader WHERE InspectionID = @InspectionID", con);
                deleteHeaderCmd.Parameters.AddWithValue("@InspectionID", inspectionID);
                deleteHeaderCmd.ExecuteNonQuery();

                con.Close();
            }

            // Rebind the GridView
            LoadRecords();
        }

        protected void BtnEdit_Click(object sender, EventArgs e)
        {
            Button btnEdit = (Button)sender;
            GridViewRow row = (GridViewRow)btnEdit.NamingContainer;
            string InspectionID = btnEdit.CommandArgument.ToString();
            Response.Redirect($"FirstAidBoxUpdate.aspx?InspectionID={InspectionID}");
        }

        protected void Btnsearch_Click(object sender, EventArgs e)
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
                string query = @"SELECT InspectionID,InspectionDate,Location,EmployeeName,InspectedBy  from  FirstAidInspectionHeader where InspectionDate BETWEEN @FromDate AND @ToDate ORDER BY InspectionDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@FromDate", SqlDbType.Date).Value = parsedFromDate;
                    cmd.Parameters.Add("@ToDate", SqlDbType.Date).Value = parsedToDate;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvChecklist.DataSource = dt;
                    gvChecklist.DataBind();
                }
            }
        }
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("FirstAidBoxView.aspx");
        }
    }
}