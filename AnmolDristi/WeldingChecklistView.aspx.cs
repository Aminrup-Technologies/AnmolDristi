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
    public partial class WeldingChecklistView : System.Web.UI.Page
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
                string query = @"SELECT HeaderID,ChecklistDate,JobID,Location,InspectedBy  from WeldingChecklistHeader ORDER BY HeaderID Desc";

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

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("WeldingChecklistView.aspx");
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
                string query = @"SELECT HeaderID,ChecklistDate,JobID,Location,EmployeeName,InspectedBy  from  WeldingChecklistHeader where ChecklistDate BETWEEN @FromDate AND @ToDate ORDER BY ChecklistDate DESC";

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

        protected void Btndelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            //int headerID = Convert.ToInt32(gvChecklist.DataKeys[row.RowIndex].Value);
            string headerID = gvChecklist.DataKeys[row.RowIndex].Value.ToString();

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Step 1: Delete child records first
                SqlCommand deleteChecklistCmd = new SqlCommand("DELETE FROM WeldingChecklist WHERE HeaderID = @HeaderID", con);
                deleteChecklistCmd.Parameters.AddWithValue("@HeaderID", headerID);
                deleteChecklistCmd.ExecuteNonQuery();

                // Step 2: Delete header record
                SqlCommand deleteHeaderCmd = new SqlCommand("DELETE FROM WeldingChecklistHeader WHERE HeaderID = @HeaderID", con);
                deleteHeaderCmd.Parameters.AddWithValue("@HeaderID", headerID);
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
           // int HeaderID = Convert.ToInt32(btnEdit.CommandArgument);
            string HeaderID = btnEdit.CommandArgument.ToString();
            Response.Redirect($"WeldingChecklistUpdate.aspx?HeaderID={HeaderID}");
        }
        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btnView = (Button)sender;
            GridViewRow row = (GridViewRow)btnView.NamingContainer;
            // int HeaderID = Convert.ToInt32(btnView.CommandArgument);
            string HeaderID = btnView.CommandArgument.ToString();
            // Redirect to update page with AuditID in query string
            Response.Redirect($"WeldingChecklistRpt.aspx?HeaderID={HeaderID}");
        }

    }
}