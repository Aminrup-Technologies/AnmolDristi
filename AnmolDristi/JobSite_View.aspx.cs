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
            GridViewRow row = GridViewJobSiteChecklist.Rows[e.RowIndex];
            int headerId = Convert.ToInt32(GridViewJobSiteChecklist.DataKeys[e.RowIndex].Value);

            string checklistDate = ((TextBox)row.FindControl("txtChecklistDate")).Text;
            string area = ((TextBox)row.FindControl("txtArea")).Text;
            string question = ((TextBox)row.FindControl("txtQuestion")).Text;
            string isYes = ((DropDownList)row.FindControl("ddlIsYes")).SelectedValue;
            string remarks = ((TextBox)row.FindControl("txtRemarks")).Text;
            Label lblExistingPhoto = (Label)row.FindControl("lblExistingPhoto");
            FileUpload filePhoto = (FileUpload)row.FindControl("filePhoto");

            string photoPath = lblExistingPhoto.Text;

            // Upload new photo if selected
            if (filePhoto.HasFile)
            {
                string fileName = Path.GetFileName(filePhoto.FileName);
                string uploadPath = Server.MapPath("~/Uploads/") + fileName;
                filePhoto.SaveAs(uploadPath);
                photoPath = "~/Uploads/" + fileName;
            }

            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

              
                string updateHeaderQuery = @"
            UPDATE MahimaGupta_CSMS.JobSiteHeader
            SET ChecklistDate = @ChecklistDate, Area = @Area
            WHERE HeaderID = @HeaderID";

                using (SqlCommand cmd = new SqlCommand(updateHeaderQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@ChecklistDate", checklistDate);
                    cmd.Parameters.AddWithValue("@Area", area);
                    cmd.Parameters.AddWithValue("@HeaderID", headerId);
                    cmd.ExecuteNonQuery();
                }

            
                string updateDetailQuery = @"
            UPDATE MahimaGupta_CSMS.JobSiteChecklistDetails
            SET Question = @Question, IsYes = @IsYes, Remarks = @Remarks, PhotoPath = @PhotoPath
            WHERE HeaderID = @HeaderID AND Question = @Question";

                using (SqlCommand cmd = new SqlCommand(updateDetailQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Question", question);
                    cmd.Parameters.AddWithValue("@IsYes", isYes);
                    cmd.Parameters.AddWithValue("@Remarks", remarks);
                    cmd.Parameters.AddWithValue("@PhotoPath", photoPath);
                    cmd.Parameters.AddWithValue("@HeaderID", headerId);
                    cmd.ExecuteNonQuery();
                }
            }

            GridViewJobSiteChecklist.EditIndex = -1;
            LoadChecklist();
        }

        protected void GridViewJobSiteChecklist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int headerId = Convert.ToInt32(GridViewJobSiteChecklist.DataKeys[e.RowIndex].Value);

            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(@"
                    DELETE FROM MahimaGupta_CSMS.JobSiteChecklistDetails WHERE HeaderID = @HeaderID;
                    DELETE FROM MahimaGupta_CSMS.JobSiteHeader WHERE HeaderID = @HeaderID;", conn);
                cmd.Parameters.AddWithValue("@HeaderID", headerId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadChecklist();
        }
    }
}
