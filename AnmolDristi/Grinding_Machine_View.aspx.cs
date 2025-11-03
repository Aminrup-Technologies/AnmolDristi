

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.SqlTypes;
using System.IO;

namespace AnmolDristi
{
    public partial class Grinding_Machine_View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGrindingMachineIncidentDetails();
            }
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string id = btn.CommandArgument;
            Response.Redirect("GrindingDetailedView.aspx?HeaderID=" + id);
        }


        private void LoadGrindingMachineIncidentDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                SELECT 
                    gh.HeaderID, gh.Site, gh.DateOfInspection, gh.InspectedBy, gh.SerialNo, 
                    gh.IdentificationNumber, gh.Location, gh.Final_Remarks,gh.JobID, gh.JobName,
                    gc.Question AS ChecklistQuestion, gc.IsYes, gc.Remarks, gc.PhotoPath, gc.EntryDate
                FROM GrindingMachine_Header gh
                LEFT JOIN GrindingMachine_Checklist gc ON gh.HeaderID = gc.HeaderID
                ORDER BY gh.HeaderID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GvGrindingMachineChecklist.DataSource = dt;
                        GvGrindingMachineChecklist.DataBind();
                    }
                }
            }
        }

        protected void GvGrindingMachineChecklist_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GvGrindingMachineChecklist.EditIndex = e.NewEditIndex;
            LoadGrindingMachineIncidentDetails();
        }

        protected void GvGrindingMachineChecklist_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GvGrindingMachineChecklist.EditIndex = -1;
            LoadGrindingMachineIncidentDetails();
        }

       

        protected void GvGrindingMachineChecklist_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string headerId = GvGrindingMachineChecklist.DataKeys[e.RowIndex].Value.ToString();

            GridViewRow row = GvGrindingMachineChecklist.Rows[e.RowIndex];

            //string checklistQuestion = ((TextBox)row.Cells[6].Controls[0]).Text;


            // ✅ SAFEST WAY: use FindControl instead of Cells[6]
            //TextBox txtChecklistQuestion = (TextBox)row.FindControl("txtChecklistQuestion");
            //string checklistQuestion = txtChecklistQuestion != null ? txtChecklistQuestion.Text : row.Cells[6].Text.Trim();

            string checklistQuestion = row.Cells[7].Text;


            DropDownList ddlIsYes = (DropDownList)row.FindControl("ddlIsYes");
            TextBox txtRemarks = (TextBox)row.FindControl("txtRemarks");
            FileUpload filePhoto = (FileUpload)row.FindControl("filePhoto");
            Label lblExistingPhoto = (Label)row.FindControl("lblExistingPhoto");

            string selectedIsYesStr = ddlIsYes.SelectedValue; // "True" or "False"
            bool newIsYes = selectedIsYesStr == "True";
            int newIsYesInt = newIsYes ? 1 : 0;

            string newRemarks = txtRemarks.Text;
            string newPhotoPath = lblExistingPhoto.Text;

            if (filePhoto.HasFile)
            {
                string filename = Path.GetFileName(filePhoto.FileName);
                string folderPath = Server.MapPath("~/Uploads/");
                Directory.CreateDirectory(folderPath);
                string fullPath = Path.Combine(folderPath, filename);
                filePhoto.SaveAs(fullPath);
                newPhotoPath = "~/Uploads/" + filename;
            }
            else
            {
                // No new photo uploaded
                // If existing label has a photo path, keep it
                if (string.IsNullOrWhiteSpace(lblExistingPhoto.Text))
                {
                    // If nothing existed before, keep it empty
                    newPhotoPath = "";
                }
                else
                {
                    // Keep old one
                    newPhotoPath = lblExistingPhoto.Text;
                }
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction trans = conn.BeginTransaction();

                try
                {
                    // Get current IsYes and CAPA_ID
                    int currentIsYes = -1;
                    object currentCAPAID = null;

                    using (SqlCommand getCmd = new SqlCommand(
                        "SELECT IsYes, CAPA_ID FROM GrindingMachine_Checklist WHERE HeaderID = @HeaderID AND Question = @Question", conn, trans))
                    {
                        getCmd.Parameters.AddWithValue("@HeaderID", headerId);
                        getCmd.Parameters.AddWithValue("@Question", checklistQuestion);
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

                    if (currentIsYes == 1 && newIsYesInt == 0)
                    {

                        // Remarks are mandatory when IsYes = false
                        if (string.IsNullOrWhiteSpace(newRemarks))
                            throw new Exception("Remarks cannot be empty when marking as Not OK.");





                        // Changed from true → false: Insert new CAPA
                        SqlCommand insertCAPA = new SqlCommand(@"
                    INSERT INTO tbl_CAPAMaster (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate)
                    OUTPUT INSERTED.CAPAID
                    VALUES (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate)", conn, trans);
                        insertCAPA.Parameters.AddWithValue("@HeaderID", headerId);
                        insertCAPA.Parameters.AddWithValue("@PhotoPath", newPhotoPath ?? "");
                        insertCAPA.Parameters.AddWithValue("@Remarks", newRemarks ?? "");
                        insertCAPA.Parameters.AddWithValue("@AssignedBy", Session["UserName"] ?? "System"); // Or txtInspectedBy.Text
                        insertCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                        capaIDToUse = insertCAPA.ExecuteScalar();
                    }
                    else if (currentIsYes == 0 && newIsYesInt == 1)
                    {
                        // Changed from false → true: clear remarks/photo only
                        newRemarks = "";
                        newPhotoPath = "";
                        // Keep CAPA_ID unchanged

                        // Update CAPA to mark as resolved (IsYes = 1)
                        if (currentCAPAID != null)
                        {
                            SqlCommand updateCAPA = new SqlCommand(
                                "UPDATE tbl_CAPAMaster SET IsYes = 1 WHERE CAPAID = @CAPAID", conn, trans);
                            updateCAPA.Parameters.AddWithValue("@CAPAID", currentCAPAID);
                            updateCAPA.ExecuteNonQuery();
                        }



                    }

                    // Update Checklist
                    SqlCommand updateChecklist = new SqlCommand(@"
                UPDATE GrindingMachine_Checklist 
                SET IsYes = @IsYes, Remarks = @Remarks, PhotoPath = @PhotoPath, CAPA_ID = @CAPA_ID
                WHERE HeaderID = @HeaderID AND Question = @Question", conn, trans);

                    updateChecklist.Parameters.AddWithValue("@IsYes", newIsYesInt);
                    updateChecklist.Parameters.AddWithValue("@Remarks", (object)newRemarks ?? DBNull.Value);
                    updateChecklist.Parameters.AddWithValue("@PhotoPath", (object)newPhotoPath ?? DBNull.Value);
                    updateChecklist.Parameters.AddWithValue("@CAPA_ID", capaIDToUse ?? DBNull.Value);
                    updateChecklist.Parameters.AddWithValue("@HeaderID", headerId);
                    updateChecklist.Parameters.AddWithValue("@Question", checklistQuestion);

                    updateChecklist.ExecuteNonQuery();

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
                catch (Exception ex)
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

            GvGrindingMachineChecklist.EditIndex = -1;
            LoadGrindingMachineIncidentDetails(); // Rebinds with updated values
        }


        protected void GvGrindingMachineChecklist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = GvGrindingMachineChecklist.DataKeys[e.RowIndex].Value.ToString();

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(@"
                    DELETE FROM GrindingMachine_Checklist WHERE HeaderID = @HeaderID;
                    DELETE FROM GrindingMachine_Header WHERE HeaderID = @HeaderID;", conn))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", id);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadGrindingMachineIncidentDetails();
        }

        protected void GvGrindingMachineChecklist_RowDataBound(object sender, GridViewRowEventArgs e)
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






