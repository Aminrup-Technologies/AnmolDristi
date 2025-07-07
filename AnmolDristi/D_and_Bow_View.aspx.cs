using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.IO;




namespace AnmolDristi
{
    public partial class D_and_Bow_View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDandBowChecklistDetails();
            }
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string id = btn.CommandArgument;

            // Redirect to detailed view page with ID in query string
            Response.Redirect("DandBowDetailedView.aspx?id=" + id);
        }


        private void LoadDandBowChecklistDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
SELECT
    h.BasicID AS BasicID, h.Site, h.TagNo, h.InspectionDate, h.JobID,
    h.JobName,

    sd.Question AS ShacklesChecklistQuestion, 
    sd.IsYes AS ShacklesIsYes, 
    sd.Remarks AS ShacklesRemarks, 
    sd.PhotoPath AS ShacklesPhotoPath,

    cd.Question AS ChainPulleyChecklistQuestion,
    cd.IsYes AS ChainPulleyIsYes,
    cd.Remarks AS ChainPulleyRemarks,
    cd.PhotoPath AS ChainPulleyPhotoPath

FROM MahimaGupta_CSMS.ShacklesChecklist_BasicDetails h
LEFT JOIN MahimaGupta_CSMS.ShacklesChecklist_DBow sd ON h.BasicID = sd.HeaderID
LEFT JOIN MahimaGupta_CSMS.ShacklesChecklist_ChainPulley cd ON h.BasicID = cd.HeaderID

ORDER BY h.BasicID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GvDandBowChecklist.DataSource = dt;
                        GvDandBowChecklist.DataBind();
                    }
                }
            }
        }

        protected void GvDandBowChecklist_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GvDandBowChecklist.EditIndex = e.NewEditIndex;
            LoadDandBowChecklistDetails();
        }

        protected void GvDandBowChecklist_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GvDandBowChecklist.EditIndex = -1;
            LoadDandBowChecklistDetails();
        }

        protected void GvDandBowChecklist_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = GvDandBowChecklist.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow row = GvDandBowChecklist.Rows[e.RowIndex];

            string jobName = ((TextBox)row.FindControl("txtJobName")).Text.Trim();

            // Shackles section
            string shacklesQuestion = ((TextBox)row.FindControl("txtShacklesQuestion")).Text.Trim();
            DropDownList ddlShacklesIsYes = (DropDownList)row.FindControl("ddlShacklesIsYes");
            int newShacklesIsYes = ddlShacklesIsYes.SelectedValue == "True" ? 1 : 0;
            TextBox txtShacklesRemarks = (TextBox)row.FindControl("txtShacklesRemarks");
            FileUpload fileShacklesPhoto = (FileUpload)row.FindControl("fileShacklesPhoto");
            Label lblExistingShacklesPhoto = (Label)row.FindControl("lblExistingShacklesPhoto");

            string shacklesRemarks = txtShacklesRemarks.Text.Trim();
            string shacklesPhotoPath = lblExistingShacklesPhoto.Text;

            if (fileShacklesPhoto.HasFile)
            {
                string fileName = Path.GetFileName(fileShacklesPhoto.FileName);
                string path = Server.MapPath("~/Uploads/");
                Directory.CreateDirectory(path);
                string fullPath = Path.Combine(path, fileName);
                fileShacklesPhoto.SaveAs(fullPath);
                shacklesPhotoPath = "~/Uploads/" + fileName;
            }

            // Chain Pulley section
            string chainPulleyQuestion = ((TextBox)row.FindControl("txtChainPulleyQuestion")).Text.Trim();
            DropDownList ddlChainPulleyIsYes = (DropDownList)row.FindControl("ddlChainPulleyIsYes");
            int newChainPulleyIsYes = ddlChainPulleyIsYes.SelectedValue == "True" ? 1 : 0;
            TextBox txtChainPulleyRemarks = (TextBox)row.FindControl("txtChainPulleyRemarks");
            FileUpload fileChainPulleyPhoto = (FileUpload)row.FindControl("fileChainPulleyPhoto");
            Label lblExistingChainPulleyPhoto = (Label)row.FindControl("lblExistingChainPulleyPhoto");

            string chainPulleyRemarks = txtChainPulleyRemarks.Text.Trim();
            string chainPulleyPhotoPath = lblExistingChainPulleyPhoto.Text;

            if (fileChainPulleyPhoto.HasFile)
            {
                string fileName = Path.GetFileName(fileChainPulleyPhoto.FileName);
                string path = Server.MapPath("~/Uploads/");
                Directory.CreateDirectory(path);
                string fullPath = Path.Combine(path, fileName);
                fileChainPulleyPhoto.SaveAs(fullPath);
                chainPulleyPhotoPath = "~/Uploads/" + fileName;
            }

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                conn.Open();
                SqlTransaction trans = conn.BeginTransaction();

                try
                {
                    // 1. Update Header
                    SqlCommand updateHeader = new SqlCommand(@"
                UPDATE MahimaGupta_CSMS.ShacklesChecklist_BasicDetails
                SET JobName = @JobName
                WHERE Id = @ID", conn, trans);
                    updateHeader.Parameters.AddWithValue("@JobName", jobName);
                    updateHeader.Parameters.AddWithValue("@ID", id);
                    updateHeader.ExecuteNonQuery();

                    // 2. Get current IsYes values (optional: also fetch CAPA_ID if implementing CAPA logic)
                    int currentShacklesIsYes = -1;
                    int currentChainPulleyIsYes = -1;

                    SqlCommand getOld = new SqlCommand(@"
                SELECT 
                    (SELECT IsYes FROM MahimaGupta_CSMS.ShacklesChecklist_DBow WHERE HeaderID = @ID AND Question = @SQ) AS OldShackles,
                    (SELECT IsYes FROM MahimaGupta_CSMS.ShacklesChecklist_ChainPulley WHERE HeaderID = @ID AND Question = @CQ) AS OldPulley", conn, trans);
                    getOld.Parameters.AddWithValue("@ID", id);
                    getOld.Parameters.AddWithValue("@SQ", shacklesQuestion);
                    getOld.Parameters.AddWithValue("@CQ", chainPulleyQuestion);
                    using (SqlDataReader reader = getOld.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            currentShacklesIsYes = reader["OldShackles"] != DBNull.Value ? Convert.ToInt32(reader["OldShackles"]) : -1;
                            currentChainPulleyIsYes = reader["OldPulley"] != DBNull.Value ? Convert.ToInt32(reader["OldPulley"]) : -1;
                        }
                    }

                    // 3. Insert CAPA if needed (like grinding machine format)
                    // Add here if needed

                    // 4. Update Shackles
                    SqlCommand updateShackles = new SqlCommand(@"
                UPDATE MahimaGupta_CSMS.ShacklesChecklist_DBow
                SET IsYes = @IsYes, Remarks = @Remarks, PhotoPath = @PhotoPath
                WHERE HeaderID = @ID AND Question = @Question", conn, trans);
                    updateShackles.Parameters.AddWithValue("@ID", id);
                    updateShackles.Parameters.AddWithValue("@IsYes", newShacklesIsYes);
                    updateShackles.Parameters.AddWithValue("@Remarks", string.IsNullOrEmpty(shacklesRemarks) ? (object)DBNull.Value : shacklesRemarks);
                    updateShackles.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(shacklesPhotoPath) ? (object)DBNull.Value : shacklesPhotoPath);
                    updateShackles.Parameters.AddWithValue("@Question", shacklesQuestion);
                    updateShackles.ExecuteNonQuery();

                    // 5. Update Chain Pulley
                    SqlCommand updatePulley = new SqlCommand(@"
                UPDATE MahimaGupta_CSMS.ShacklesChecklist_ChainPulley
                SET IsYes = @IsYes, Remarks = @Remarks, PhotoPath = @PhotoPath
                WHERE HeaderID = @ID AND Question = @Question", conn, trans);
                    updatePulley.Parameters.AddWithValue("@ID", id);
                    updatePulley.Parameters.AddWithValue("@IsYes", newChainPulleyIsYes);
                    updatePulley.Parameters.AddWithValue("@Remarks", string.IsNullOrEmpty(chainPulleyRemarks) ? (object)DBNull.Value : chainPulleyRemarks);
                    updatePulley.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(chainPulleyPhotoPath) ? (object)DBNull.Value : chainPulleyPhotoPath);
                    updatePulley.Parameters.AddWithValue("@Question", chainPulleyQuestion);
                    updatePulley.ExecuteNonQuery();

                    trans.Commit();
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    // Optional: log or display error
                }
            }

            GvDandBowChecklist.EditIndex = -1;
            LoadDandBowChecklistDetails();
        }


        protected void GvDandBowChecklist_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow &&
                (GvDandBowChecklist.EditIndex == e.Row.RowIndex))
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlShacklesIsYes");
                Panel pnl = (Panel)e.Row.FindControl("pnlShacklesDetails");

                if (ddl != null && pnl != null && ddl.SelectedValue == "False")
                    pnl.Style["display"] = "block";

                DropDownList ddl2 = (DropDownList)e.Row.FindControl("ddlChainPulleyIsYes");
                Panel pnl2 = (Panel)e.Row.FindControl("pnlChainPulleyDetails");

                if (ddl2 != null && pnl2 != null && ddl2.SelectedValue == "False")
                    pnl2.Style["display"] = "block";
            }
        }


        protected void GvDandBowChecklist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GvDandBowChecklist.DataKeys[e.RowIndex].Value);

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(@"
            DELETE FROM MahimaGupta_CSMS.ShacklesChecklist_DBow WHERE HeaderID = @BasicID;
            DELETE FROM MahimaGupta_CSMS.ShacklesChecklist_ChainPulley WHERE HeaderID = @BasicID;
            DELETE FROM MahimaGupta_CSMS.ShacklesChecklist_BasicDetails WHERE Id = @BasicID;", conn))
                {
                    cmd.Parameters.AddWithValue("@BasicID", id);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadDandBowChecklistDetails();
        }

    }
}