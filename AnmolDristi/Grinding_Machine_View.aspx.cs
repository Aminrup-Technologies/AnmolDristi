

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
            int headerId = Convert.ToInt32(GvGrindingMachineChecklist.DataKeys[e.RowIndex].Value);
            GridViewRow row = GvGrindingMachineChecklist.Rows[e.RowIndex];

            string site = ((TextBox)row.Cells[0].Controls[0]).Text;

            // Parse DateOfInspection
            DateTime dateOfInspection;
            bool isValidDate = DateTime.TryParseExact(
                ((TextBox)row.Cells[1].Controls[0]).Text,
                "yyyy-MM-dd",
                System.Globalization.CultureInfo.InvariantCulture,
                System.Globalization.DateTimeStyles.None,
                out dateOfInspection);
            if (!isValidDate)
                dateOfInspection = DateTime.Now;

            string inspectedBy = ((TextBox)row.Cells[2].Controls[0]).Text;
            string serialNo = ((TextBox)row.Cells[3].Controls[0]).Text;
            string identificationNo = ((TextBox)row.Cells[4].Controls[0]).Text;
            string location = ((TextBox)row.Cells[5].Controls[0]).Text;

            // Checklist-specific fields
            string checklistQuestion = ((TextBox)row.Cells[6].Controls[0]).Text;
            DropDownList ddlIsYes = (DropDownList)row.FindControl("ddlIsYes");
            TextBox txtRemarks = (TextBox)row.FindControl("txtRemarks");
            FileUpload filePhoto = (FileUpload)row.FindControl("filePhoto");
            Label lblExistingPhoto = (Label)row.FindControl("lblExistingPhoto");

            string isYes = ddlIsYes.SelectedValue;
            string remarks = txtRemarks.Text;
            string photoPath = lblExistingPhoto.Text;

            if (filePhoto.HasFile)
            {
                string filename = Path.GetFileName(filePhoto.FileName);
                string filepath = Server.MapPath("~/Uploads/") + filename;
                filePhoto.SaveAs(filepath);
                photoPath = "~/Uploads/" + filename;
            }


            string jobId = ((TextBox)row.Cells[10].Controls[0]).Text;
            string jobName = ((TextBox)row.Cells[11].Controls[0]).Text;
            string finalRemarks = ((TextBox)row.Cells[12].Controls[0]).Text;

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Update Header Table
                string updateHeaderQuery = @"
            UPDATE GrindingMachine_Header 
            SET Site = @Site, DateOfInspection = @DateOfInspection, InspectedBy = @InspectedBy, 
                SerialNo = @SerialNo, IdentificationNumber = @IdentificationNumber, 
                Location = @Location, JobID = @JobID, JobName = @JobName, Final_Remarks = @FinalRemarks
            WHERE HeaderID = @HeaderID";

                using (SqlCommand cmd = new SqlCommand(updateHeaderQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", headerId);
                    cmd.Parameters.AddWithValue("@Site", site);
                    cmd.Parameters.AddWithValue("@DateOfInspection", dateOfInspection);
                    cmd.Parameters.AddWithValue("@InspectedBy", inspectedBy);
                    cmd.Parameters.AddWithValue("@SerialNo", serialNo);
                    cmd.Parameters.AddWithValue("@IdentificationNumber", identificationNo);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Parameters.AddWithValue("@JobID", jobId);
                    cmd.Parameters.AddWithValue("@JobName", jobName);
                    cmd.Parameters.AddWithValue("@FinalRemarks", finalRemarks);
                    cmd.ExecuteNonQuery();
                }

                // Update Checklist Table
                string updateChecklistQuery = @"
    UPDATE GrindingMachine_Checklist 
    SET IsYes = @IsYes, Remarks = @Remarks, PhotoPath = @PhotoPath
    WHERE HeaderID = @HeaderID AND Question = @ChecklistQuestion";


                using (SqlCommand cmd = new SqlCommand(updateChecklistQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", headerId);
                    cmd.Parameters.AddWithValue("@ChecklistQuestion", checklistQuestion);
                    cmd.Parameters.AddWithValue("@IsYes", isYes);
                    cmd.Parameters.AddWithValue("@Remarks", remarks);
                    cmd.Parameters.AddWithValue("@PhotoPath", photoPath);
                    cmd.ExecuteNonQuery();
                }
            }

            GvGrindingMachineChecklist.EditIndex = -1;
            LoadGrindingMachineIncidentDetails();
        }

        protected void GvGrindingMachineChecklist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GvGrindingMachineChecklist.DataKeys[e.RowIndex].Value);
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
    }
}






