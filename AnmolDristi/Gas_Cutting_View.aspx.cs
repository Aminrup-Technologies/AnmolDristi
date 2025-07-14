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
            string headerId = GvGasCuttingChecklist.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow row = GvGasCuttingChecklist.Rows[e.RowIndex];

            string siteName = ((TextBox)row.FindControl("txtSiteName")).Text.Trim();
            string tagNo = ((TextBox)row.FindControl("txtTagNo")).Text.Trim();
            string jobId = ((TextBox)row.FindControl("txtJobId")).Text.Trim();
            string gasCutterName = ((TextBox)row.FindControl("txtGasCutterName")).Text.Trim();

            string inspectionDateStr = ((TextBox)row.FindControl("txtInspectionDate")).Text.Trim();
            DateTime inspectionDate;
            if (!DateTime.TryParseExact(inspectionDateStr, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None, out inspectionDate))
            {
                inspectionDate = DateTime.Now;
            }

            string checklistQuestion = ((TextBox)row.FindControl("txtChecklistQuestion")).Text.Trim();
            DropDownList ddlIsYes = (DropDownList)row.FindControl("ddlIsYes");
            string selectedIsYes = ddlIsYes.SelectedValue;
            int isYesInt = selectedIsYes == "True" ? 1 : 0;

            TextBox txtRemarks = (TextBox)row.FindControl("txtRemarks");
            string remarks = txtRemarks.Text.Trim();

            FileUpload filePhoto = (FileUpload)row.FindControl("filePhoto");
            Label lblExistingPhoto = (Label)row.FindControl("lblExistingPhoto");
            string photoPath = lblExistingPhoto.Text;

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
                SqlTransaction trans = conn.BeginTransaction();

                try
                {
                    // 1. Update Header
                    SqlCommand updateHeader = new SqlCommand(@"
                UPDATE GasCutting_Header 
                SET SiteName = @SiteName, InspectionDate = @InspectionDate, TagNo = @TagNo, 
                    GasCutterName = @GasCutterName, JobID = @JobID 
                WHERE HeaderID = @HeaderID", conn, trans);

                    updateHeader.Parameters.AddWithValue("@HeaderID", headerId);
                    updateHeader.Parameters.AddWithValue("@SiteName", siteName);
                    updateHeader.Parameters.AddWithValue("@InspectionDate", inspectionDate);
                    updateHeader.Parameters.AddWithValue("@TagNo", tagNo);
                    updateHeader.Parameters.AddWithValue("@GasCutterName", gasCutterName);
                    updateHeader.Parameters.AddWithValue("@JobID", jobId);
                    updateHeader.ExecuteNonQuery();

                    // 2. Get current IsYes and CAPA_ID
                    int currentIsYes = -1;
                    object currentCAPAID = null;

                    SqlCommand getCmd = new SqlCommand(@"
                SELECT IsYes, CAPA_ID 
                FROM GasCutting_Checklist 
                WHERE HeaderID = @HeaderID AND Question = @ChecklistQuestion", conn, trans);
                    getCmd.Parameters.AddWithValue("@HeaderID", headerId);
                    getCmd.Parameters.AddWithValue("@ChecklistQuestion", checklistQuestion);

                    using (SqlDataReader reader = getCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            currentIsYes = Convert.ToInt32(reader["IsYes"]);
                            currentCAPAID = reader["CAPA_ID"] == DBNull.Value ? null : reader["CAPA_ID"];
                        }
                    }

                    object capaIDToUse = currentCAPAID;

                    if (currentIsYes == 1 && isYesInt == 0)
                    {
                        // Changed from Yes to No → Insert CAPA
                        SqlCommand insertCAPA = new SqlCommand(@"
                    INSERT INTO tbl_CAPAMaster (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate)
                    OUTPUT INSERTED.CAPAID
                    VALUES (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate)", conn, trans);

                        insertCAPA.Parameters.AddWithValue("@HeaderID", headerId);
                        insertCAPA.Parameters.AddWithValue("@PhotoPath", photoPath ?? "");
                        insertCAPA.Parameters.AddWithValue("@Remarks", remarks ?? "");
                        insertCAPA.Parameters.AddWithValue("@AssignedBy", "System");
                        insertCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                        capaIDToUse = insertCAPA.ExecuteScalar();
                    }
                    else if (currentIsYes == 0 && isYesInt == 1)
                    {
                        // Changed from No to Yes → Clear remarks/photo
                        remarks = "";
                        photoPath = "";
                    }

                    // 3. Update Checklist
                    SqlCommand updateChecklist = new SqlCommand(@"
                UPDATE GasCutting_Checklist 
                SET IsYes = @IsYes, Remarks = @Remarks, PhotoPath = @PhotoPath, FinalRemarks = @FinalRemarks, CAPA_ID = @CAPA_ID
                WHERE HeaderID = @HeaderID AND Question = @ChecklistQuestion", conn, trans);

                    updateChecklist.Parameters.AddWithValue("@IsYes", isYesInt);
                    updateChecklist.Parameters.AddWithValue("@Remarks", string.IsNullOrEmpty(remarks) ? (object)DBNull.Value : remarks);
                    updateChecklist.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(photoPath) ? (object)DBNull.Value : photoPath);
                    updateChecklist.Parameters.AddWithValue("@FinalRemarks", string.IsNullOrEmpty(finalRemarks) ? (object)DBNull.Value : finalRemarks);
                    updateChecklist.Parameters.AddWithValue("@CAPA_ID", capaIDToUse ?? DBNull.Value);
                    updateChecklist.Parameters.AddWithValue("@HeaderID", headerId);
                    updateChecklist.Parameters.AddWithValue("@ChecklistQuestion", checklistQuestion);
                    updateChecklist.ExecuteNonQuery();

                    trans.Commit();
                }
                catch
                {
                    trans.Rollback();
                }
            }

            GvGasCuttingChecklist.EditIndex = -1;
            LoadGasCuttingIncidentDetails();
        }

        protected void GvGasCuttingChecklist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string headerId = GvGasCuttingChecklist.DataKeys[e.RowIndex].Values["HeaderID"].ToString();
            string checklistQuestion = GvGasCuttingChecklist.DataKeys[e.RowIndex].Values["ChecklistQuestion"].ToString();

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(@"
            DELETE FROM GasCutting_Checklist 
            WHERE HeaderID = @HeaderID AND Question = @ChecklistQuestion", conn))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", headerId);
                    cmd.Parameters.AddWithValue("@ChecklistQuestion", checklistQuestion);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadGasCuttingIncidentDetails();
        }
    }
}