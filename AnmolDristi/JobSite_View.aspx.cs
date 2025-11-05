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

namespace AnmolDristi
{
    public partial class JobSite_View : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadChecklist();
            }
        }

        private void LoadChecklist()
        {
            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = @"
                    SELECT 
                        h.HeaderID, h.ChecklistDate, h.Area, 
                        d.Question, d.IsYes, d.Remarks, d.PhotoPath
                    FROM MahimaGupta_CSMS.JobSiteHeader h
                    INNER JOIN MahimaGupta_CSMS.JobSiteChecklistDetails d ON h.HeaderID = d.HeaderID
                    ORDER BY h.HeaderID DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridViewJobSiteChecklist.DataSource = dt;
                GridViewJobSiteChecklist.DataBind();
            }
        }


        protected void btnView_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string headerId = btn.CommandArgument;


            Response.Redirect("JobSite_DetailedView.aspx?headerId=" + headerId);
        }

        protected void GridViewJobSiteChecklist_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewJobSiteChecklist.EditIndex = e.NewEditIndex;
            LoadChecklist();
        }

        protected void GridViewJobSiteChecklist_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewJobSiteChecklist.EditIndex = -1;
            LoadChecklist();
        }

        protected void GridViewJobSiteChecklist_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string headerId = GridViewJobSiteChecklist.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow row = GridViewJobSiteChecklist.Rows[e.RowIndex];

            string checklistDate = ((TextBox)row.FindControl("txtChecklistDate")).Text;
            string area = ((TextBox)row.FindControl("txtArea")).Text;
            string question = ((TextBox)row.FindControl("txtQuestion")).Text;
            string isYesStr = ((DropDownList)row.FindControl("ddlIsYes")).SelectedValue;
            bool isYes = isYesStr == "True";
            int newIsYes = isYes ? 1 : 0;

            string remarks = ((TextBox)row.FindControl("txtRemarks")).Text;
            Label lblExistingPhoto = (Label)row.FindControl("lblExistingPhoto");
            FileUpload filePhoto = (FileUpload)row.FindControl("filePhoto");

            string photoPath = lblExistingPhoto.Text;

            if (filePhoto.HasFile)
            {
                string fileName = Path.GetFileName(filePhoto.FileName);
                string uploadPath = Server.MapPath("~/Uploads/");
                Directory.CreateDirectory(uploadPath);
                string fullPath = Path.Combine(uploadPath, fileName);
                filePhoto.SaveAs(fullPath);
                photoPath = "~/Uploads/" + fileName;
            }

            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlTransaction trans = conn.BeginTransaction();

                try
                {
                    string upquery = @"UPDATE JobSiteHeader SET ChecklistDate=@ChecklistDate, Area =@Area WHERE HeaderID = @HeaderID";
                    // Step 1: Insert Header
                    using (SqlCommand cmd = new SqlCommand(upquery, conn, trans))
                    {
                        //cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@HeaderID", headerId);
                        cmd.Parameters.AddWithValue("@ChecklistDate", checklistDate);
                        cmd.Parameters.AddWithValue("@Area", area);
                        cmd.ExecuteNonQuery();
                    }












                        // 1. Get previous IsYes and CAPA_ID
                        int currentIsYes = -1;
                    object currentCAPAID = null;

                    using (SqlCommand getCmd = new SqlCommand(@"
                        SELECT IsYes, CAPA_ID FROM MahimaGupta_CSMS.JobSiteChecklistDetails
                        WHERE HeaderID = @HeaderID AND Question = @Question", conn, trans))
                    {
                        getCmd.Parameters.AddWithValue("@HeaderID", headerId);
                        getCmd.Parameters.AddWithValue("@Question", question);
                        using (SqlDataReader reader = getCmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                currentIsYes = Convert.ToInt32(reader["IsYes"]);
                                currentCAPAID = reader["CAPA_ID"] == DBNull.Value ? null : reader["CAPA_ID"];
                            }
                        }
                    }

                    object capaIDToUse = currentCAPAID;


                    if (currentIsYes == 1 && newIsYes == 0)
                    {
                        // True → False → Create CAPA
                        using (SqlCommand insertCAPA = new SqlCommand(@"
                            INSERT INTO tbl_CAPAMaster (HeaderID, PhotoPath, Description, AssignedBy, AssignedDate, SourceTable)
                            OUTPUT INSERTED.CAPAID
                            VALUES (@HeaderID, @PhotoPath, @Description, @AssignedBy, @AssignedDate, @SourceTable)", conn, trans))
                        {
                            insertCAPA.Parameters.AddWithValue("@HeaderID", headerId);
                            insertCAPA.Parameters.AddWithValue("@PhotoPath", photoPath ?? "");
                            insertCAPA.Parameters.AddWithValue("@Description", question ?? "");
                            insertCAPA.Parameters.AddWithValue("@AssignedBy", Session["UserName"] ?? "System");
                            insertCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                            insertCAPA.Parameters.AddWithValue("@SourceTable", "Job Site Checklist");
                            capaIDToUse = insertCAPA.ExecuteScalar();
                        }
                    }
                    else if (currentIsYes == 0 && newIsYes == 1)
                    {
                        // False → True → Clear remarks/photo
                        remarks = "";
                        photoPath = "";

                        // Update CAPA to mark as resolved (IsYes = 1)
                        if (currentCAPAID != null)
                        {
                            SqlCommand updateCAPA = new SqlCommand(
                                "UPDATE tbl_CAPAMaster SET IsYes = 1 WHERE CAPAID = @CAPAID", conn, trans);
                            updateCAPA.Parameters.AddWithValue("@CAPAID", currentCAPAID);
                            updateCAPA.ExecuteNonQuery();
                        }
                    }

                    // 2. Update Header (optional if editable)
                    using (SqlCommand updateHeader = new SqlCommand(@"
                        UPDATE MahimaGupta_CSMS.JobSiteHeader
                        SET ChecklistDate = @ChecklistDate, Area = @Area
                        WHERE HeaderID = @HeaderID", conn, trans))
                    {
                        updateHeader.Parameters.AddWithValue("@ChecklistDate", checklistDate);
                        updateHeader.Parameters.AddWithValue("@Area", area);
                        updateHeader.Parameters.AddWithValue("@HeaderID", headerId);
                        updateHeader.ExecuteNonQuery();
                    }

                    // 3. Update Checklist
                    using (SqlCommand updateDetails = new SqlCommand(@"
                        UPDATE MahimaGupta_CSMS.JobSiteChecklistDetails
                        SET IsYes = @IsYes, Remarks = @Remarks, PhotoPath = @PhotoPath, CAPA_ID = @CAPA_ID
                        WHERE HeaderID = @HeaderID AND Question = @Question", conn, trans))
                    {
                        updateDetails.Parameters.AddWithValue("@IsYes", newIsYes);
                        updateDetails.Parameters.AddWithValue("@Remarks", remarks ?? (object)DBNull.Value);
                        updateDetails.Parameters.AddWithValue("@PhotoPath", photoPath ?? (object)DBNull.Value);
                        updateDetails.Parameters.AddWithValue("@CAPA_ID", capaIDToUse ?? (object)DBNull.Value);
                        updateDetails.Parameters.AddWithValue("@HeaderID", headerId);
                        updateDetails.Parameters.AddWithValue("@Question", question);
                        updateDetails.ExecuteNonQuery();
                    }

                    trans.Commit();
                    //  success
                    ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-success", @"
                        new PNotify({
                            title: 'Update Successful',
                            text: 'Checklist updated successfully.',
                            type: 'success',
                            styling: 'bootstrap3',
                            delay: 2500
                        });
                    ", true);
                }
                catch(Exception ex)
                {
                    trans.Rollback();
                    ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-error", $@"
                            new PNotify({{
                                title: 'Update Failed',
                                text: 'Error: {ex.Message.Replace("'", " ")}',
                                type: 'error',
                                styling: 'bootstrap3',
                                delay: 3000
                            }});
                        ", true);
                }
            }

            GridViewJobSiteChecklist.EditIndex = -1;
            LoadChecklist();
        }

        protected void GridViewJobSiteChecklist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string headerId = GridViewJobSiteChecklist.DataKeys[e.RowIndex].Values["HeaderID"].ToString();
            string question = GridViewJobSiteChecklist.DataKeys[e.RowIndex].Values["Question"].ToString();

            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(@"
            DELETE FROM MahimaGupta_CSMS.JobSiteChecklistDetails 
            WHERE HeaderID = @HeaderID AND Question = @Question", conn);

                cmd.Parameters.AddWithValue("@HeaderID", headerId);
                cmd.Parameters.AddWithValue("@Question", question);
                cmd.ExecuteNonQuery();
            }

            LoadChecklist();
        }

        protected void GridViewJobSiteChecklist_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Skip if the row is in edit mode
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                    return;

                bool isYes = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "IsYes"));
                string photoPath = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "PhotoPath"));

                Literal litPhoto = (Literal)e.Row.FindControl("litPhoto");
                if (litPhoto == null) return;

                if (isYes)
                {
                    // If "Yes" → show nothing
                    litPhoto.Text = "";
                }
                else
                {
                    // If "No"
                    if (string.IsNullOrWhiteSpace(photoPath))
                    {
                        litPhoto.Text = "<span style='color:gray;'>No photo uploaded</span>";
                    }
                    else
                    {
                        litPhoto.Text = $"<a href='{ResolveUrl(photoPath)}' target='_blank'>" +
                                        $"<img src='{ResolveUrl(photoPath)}' " +
                                        $"style='width:80px;height:80px;border:1px solid #ccc;border-radius:8px;object-fit:cover;' /></a>";
                    }
                }
            }
        }
    }
}