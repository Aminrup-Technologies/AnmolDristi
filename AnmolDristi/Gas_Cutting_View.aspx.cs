using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace AnmolDristi
{
    public partial class Gas_Cutting_View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGasCuttingIncidentDetails();
            }
        }

        private void LoadGasCuttingIncidentDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
SELECT 
    gh.HeaderID, gh.SiteName, gh.InspectionDate, gh.TagNo,gh.JobID,
    gh.GasCutterName,gh.SubmittedDate, gh.SubmittedTime,
    gc.Question AS ChecklistQuestion, gc.IsYes, gc.Remarks, gc.PhotoPath,  gc.FinalRemarks    
FROM GasCutting_Header gh
LEFT JOIN GasCutting_Checklist gc ON gh.HeaderID = gc.HeaderID
ORDER BY gh.HeaderID DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Bind data to GridView
                        GvGasCuttingChecklist.DataSource = dt;
                        GvGasCuttingChecklist.DataBind();
                    }
                }
            }
        }

        protected void GvGasCuttingChecklist_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GvGasCuttingChecklist.EditIndex = e.NewEditIndex;
            LoadGasCuttingIncidentDetails();
        }

        protected void GvGasCuttingChecklist_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GvGasCuttingChecklist.EditIndex = -1;
            LoadGasCuttingIncidentDetails();
        }

        protected void GvGasCuttingChecklist_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(GvGasCuttingChecklist.DataKeys[e.RowIndex].Value);
            GridViewRow row = GvGasCuttingChecklist.Rows[e.RowIndex];

            string siteName = ((TextBox)row.FindControl("txtSiteName")).Text;
            string inspectionDate = ((TextBox)row.FindControl("txtInspectionDate")).Text;
            string tagNo = ((TextBox)row.FindControl("txtTagNo")).Text;
            string gasCutterName = ((TextBox)row.FindControl("txtGasCutterName")).Text;
            string jobId = ((TextBox)row.FindControl("txtJobID")).Text;
            string checklistQuestion = ((TextBox)row.FindControl("txtChecklistQuestion")).Text;
            string isYes = ((TextBox)row.FindControl("txtIsYes")).Text;
            string remarks = ((TextBox)row.FindControl("txtRemarks")).Text;
            string photoPath = ((TextBox)row.FindControl("txtPhotoPath")).Text;
            string finalRemarks = ((TextBox)row.FindControl("txtFinalRemarks")).Text;

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string updateQuery = @"
            UPDATE GasCutting_Header 
            SET SiteName = @SiteName, InspectionDate = @InspectionDate, TagNo = @TagNo,
                GasCutterName = @GasCutterName, JobID = @JobID
            WHERE HeaderID = @HeaderID;

            UPDATE GasCutting_Checklist
            SET Question = @ChecklistQuestion, IsYes = @IsYes, Remarks = @Remarks, 
                PhotoPath = @PhotoPath, FinalRemarks = @FinalRemarks
            WHERE HeaderID = @HeaderID";

                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", id);
                    cmd.Parameters.AddWithValue("@SiteName", siteName);
                    cmd.Parameters.AddWithValue("@InspectionDate", inspectionDate);
                    cmd.Parameters.AddWithValue("@TagNo", tagNo);
                    cmd.Parameters.AddWithValue("@GasCutterName", gasCutterName);
                    cmd.Parameters.AddWithValue("@JobID", jobId);
                    cmd.Parameters.AddWithValue("@ChecklistQuestion", checklistQuestion);
                    cmd.Parameters.AddWithValue("@IsYes", isYes);
                    cmd.Parameters.AddWithValue("@Remarks", remarks);
                    cmd.Parameters.AddWithValue("@PhotoPath", photoPath);
                    cmd.Parameters.AddWithValue("@FinalRemarks", finalRemarks);

                    cmd.ExecuteNonQuery();
                }
            }

            GvGasCuttingChecklist.EditIndex = -1;
            LoadGasCuttingIncidentDetails();
        }


        protected void GvGasCuttingChecklist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            object rawKey = GvGasCuttingChecklist.DataKeys[e.RowIndex].Value;

            int id; // Declare first
            if (rawKey != null && int.TryParse(rawKey.ToString(), out id))
            {
                // Safe to use 'id'
            }
            else
            {
                // Handle error or return early
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(@"
            DELETE FROM GasCutting_Checklist WHERE HeaderID = @HeaderID;
            DELETE FROM GasCutting_Header WHERE HeaderID = @HeaderID;", conn))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", id);
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }}