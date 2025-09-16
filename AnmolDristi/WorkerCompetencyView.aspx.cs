using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Remoting.Messaging;

namespace AnmolDristi
{
    public partial class WorkerCompetencyView : System.Web.UI.Page
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
                string query = @"SELECT AssessmentID,Date,NameOfWorkman,Designation,TechnicalKnowledge,TechnicalSkills,ConsistencyInJob,JobQuality,SafetyAwareness from WorkerCompetencyAssessment ORDER BY AssessmentID DESC";



                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);


                    gvRecords.DataSource = dt;
                    gvRecords.DataBind();
                }
            }
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
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
                string query = @"SELECT AssessmentID,Date,NameOfWorkman,Designation,TechnicalKnowledge,TechnicalSkills,ConsistencyInJob,JobQuality,SafetyAwareness from WorkerCompetencyAssessment where Date BETWEEN @FromDate AND @ToDate ORDER BY Date DESC";


                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@FromDate", SqlDbType.Date).Value = parsedFromDate;
                    cmd.Parameters.Add("@ToDate", SqlDbType.Date).Value = parsedToDate;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvRecords.DataSource = dt;
                    gvRecords.DataBind();
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
                int assessmentID = Convert.ToInt32(gvRecords.DataKeys[row.RowIndex].Value);

                string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = "DELETE FROM WorkerCompetencyAssessment WHERE AssessmentID=@AssessmentID ";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@AssessmentID", assessmentID);
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Reload updated data into GridView
                            LoadRecords();

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
            int assessmentID = Convert.ToInt32(btnEdit.CommandArgument);

            // Redirect to update page with AuditID in query string
            Response.Redirect($"WorkerCompetencyUpdate.aspx?AssessmentID={assessmentID}");
        }
        protected void BtnView_Click(object sender, EventArgs e)
        {
            Button btnView = (Button)sender;
            GridViewRow row = (GridViewRow)btnView.NamingContainer;
            int AssessmentID = Convert.ToInt32(btnView.CommandArgument);
            Response.Redirect($"WorkerCompetencyRpt.aspx?AssessmentID={AssessmentID}");

        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("WorkerCompetencyView.aspx");
        }
    }
}