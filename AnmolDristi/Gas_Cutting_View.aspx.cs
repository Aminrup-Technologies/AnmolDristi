using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;


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
        protected void btnView_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string id = btn.CommandArgument;
            Response.Redirect("GasDetailedView.aspx?HeaderID=" + id);
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
            int headerId = Convert.ToInt32(GvGasCuttingChecklist.DataKeys[e.RowIndex].Value);
            GridViewRow row = GvGasCuttingChecklist.Rows[e.RowIndex];

            // Extract header fields
            string siteName = ((TextBox)row.FindControl("txtSiteName")).Text.Trim();
            string tagNo = ((TextBox)row.FindControl("txtTagNo")).Text.Trim();
            string jobId = ((TextBox)row.FindControl("txtJobId")).Text.Trim();
            string gasCutterName = ((TextBox)row.FindControl("txtGasCutterName")).Text.Trim();

            // Handle Inspection Date
            string inspectionDateStr = ((TextBox)row.FindControl("txtInspectionDate")).Text.Trim();
            DateTime inspectionDate;
            bool validDate = DateTime.TryParseExact(inspectionDateStr, "yyyy-MM-dd",
                System.Globalization.CultureInfo.InvariantCulture,
                System.Globalization.DateTimeStyles.None, out inspectionDate);
            if (!validDate)
                inspectionDate = DateTime.Now;

            // Checklist Fields
            string checklistQuestion = ((TextBox)row.FindControl("txtChecklistQuestion")).Text.Trim();
            DropDownList ddlIsYes = (DropDownList)row.FindControl("ddlIsYes");
            string isYes = ddlIsYes.SelectedValue;
            TextBox txtRemarks = (TextBox)row.FindControl("txtRemarks");
            FileUpload filePhoto = (FileUpload)row.FindControl("filePhoto");
            Label lblExistingPhoto = (Label)row.FindControl("lblExistingPhoto");
            string remarks = txtRemarks.Text.Trim();
            string photoPath = lblExistingPhoto.Text;

            // Upload new photo if present
            if (filePhoto.HasFile)
            {
                string fileName = Path.GetFileName(filePhoto.FileName);
                string folderPath = Server.MapPath("~/Uploads/");
                Directory.CreateDirectory(folderPath);
                string fullPath = Path.Combine(folderPath, fileName);
                filePhoto.SaveAs(fullPath);
                photoPath = "~/Uploads/" + fileName;
            }

            string finalRemarks = ((TextBox)row.FindControl("txtFinalRemarks")).Text.Trim();

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string updateHeaderQuery = @"
        UPDATE GasCutting_Header 
        SET SiteName = @SiteName, InspectionDate = @InspectionDate, TagNo = @TagNo,
            GasCutterName = @GasCutterName, JobID = @JobID
        WHERE HeaderID = @HeaderID";

                using (SqlCommand cmd = new SqlCommand(updateHeaderQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", headerId);
                    cmd.Parameters.AddWithValue("@SiteName", siteName);
                    cmd.Parameters.AddWithValue("@InspectionDate", inspectionDate);
                    cmd.Parameters.AddWithValue("@TagNo", tagNo);
                    cmd.Parameters.AddWithValue("@GasCutterName", gasCutterName);
                    cmd.Parameters.AddWithValue("@JobID", jobId);
                    cmd.ExecuteNonQuery();
                }

                
                string updateChecklistQuery = @"
        UPDATE GasCutting_Checklist
        SET IsYes = @IsYes, Remarks = @Remarks, 
            PhotoPath = @PhotoPath, FinalRemarks = @FinalRemarks
        WHERE HeaderID = @HeaderID AND Question = @ChecklistQuestion";

                using (SqlCommand cmd = new SqlCommand(updateChecklistQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", headerId);
                    cmd.Parameters.AddWithValue("@ChecklistQuestion", checklistQuestion);
                    cmd.Parameters.AddWithValue("@IsYes", isYes);
                    cmd.Parameters.AddWithValue("@Remarks", string.IsNullOrEmpty(remarks) ? (object)DBNull.Value : remarks);
                    cmd.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(photoPath) ? (object)DBNull.Value : photoPath);
                    cmd.Parameters.AddWithValue("@FinalRemarks", string.IsNullOrEmpty(finalRemarks) ? (object)DBNull.Value : finalRemarks);
                    cmd.ExecuteNonQuery();
                }
            }

            GvGasCuttingChecklist.EditIndex = -1;
            LoadGasCuttingIncidentDetails();
        }


        protected void GvGasCuttingChecklist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            object rawKey = GvGasCuttingChecklist.DataKeys[e.RowIndex].Value;

            int id; 
            if (rawKey != null && int.TryParse(rawKey.ToString(), out id))
            {
                
            }
            else
            {
               
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