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
                        h.Id AS BasicID, h.Site, h.TagNo, h.InspectionDate,h.JobID,
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
                    LEFT JOIN MahimaGupta_CSMS.ShacklesChecklist_DBow sd ON h.Id = sd.HeaderID
                    LEFT JOIN MahimaGupta_CSMS.ShacklesChecklist_ChainPulley cd ON h.Id = cd.HeaderID

                    ORDER BY h.Id DESC";

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
            int id = Convert.ToInt32(GvDandBowChecklist.DataKeys[e.RowIndex].Value);
            GridViewRow row = GvDandBowChecklist.Rows[e.RowIndex];

            string jobName = ((TextBox)row.Cells[0].Controls[0]).Text;
            string shacklesQuestion = ((TextBox)row.Cells[1].Controls[0]).Text;
            DropDownList ddlShacklesIsYes = (DropDownList)row.FindControl("ddlShacklesIsYes");
            string shacklesIsYes = ddlShacklesIsYes.SelectedValue;

            TextBox txtShacklesRemarks = (TextBox)row.FindControl("txtShacklesRemarks");
            FileUpload fileShacklesPhoto = (FileUpload)row.FindControl("fileShacklesPhoto");
            Label lblExistingShacklesPhoto = (Label)row.FindControl("lblExistingShacklesPhoto");

            string shacklesRemarks = txtShacklesRemarks.Text;
            string shacklesPhotoPath = lblExistingShacklesPhoto.Text;

            if (fileShacklesPhoto.HasFile)
            {
                string fileName = Path.GetFileName(fileShacklesPhoto.FileName);
                string filePath = Server.MapPath("~/Uploads/") + fileName;
                fileShacklesPhoto.SaveAs(filePath);
                shacklesPhotoPath = "~/Uploads/" + fileName;
            }

            string chainPulleyQuestion = ((TextBox)row.Cells[5].Controls[0]).Text;
            DropDownList ddlChainPulleyIsYes = (DropDownList)row.FindControl("ddlChainPulleyIsYes");
            string chainPulleyIsYes = ddlChainPulleyIsYes.SelectedValue;

            TextBox txtChainPulleyRemarks = (TextBox)row.FindControl("txtChainPulleyRemarks");
            FileUpload fileChainPulleyPhoto = (FileUpload)row.FindControl("fileChainPulleyPhoto");
            Label lblExistingChainPulleyPhoto = (Label)row.FindControl("lblExistingChainPulleyPhoto");

            string chainPulleyRemarks = txtChainPulleyRemarks.Text;
            string chainPulleyPhotoPath = lblExistingChainPulleyPhoto.Text;

            if (fileChainPulleyPhoto.HasFile)
            {
                string fileName = Path.GetFileName(fileChainPulleyPhoto.FileName);
                string filePath = Server.MapPath("~/Uploads/") + fileName;
                fileChainPulleyPhoto.SaveAs(filePath);
                chainPulleyPhotoPath = "~/Uploads/" + fileName;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string updateQuery = @"
    UPDATE MahimaGupta_CSMS.ShacklesChecklist_BasicDetails
    SET JobName = @JobName
    WHERE Id = @ID;

    UPDATE MahimaGupta_CSMS.ShacklesChecklist_DBow
    SET IsYes = @ShacklesIsYes, Remarks = @ShacklesRemarks, PhotoPath = @ShacklesPhotoPath
    WHERE HeaderID = @ID AND Question = @ShacklesQuestion;

    UPDATE MahimaGupta_CSMS.ShacklesChecklist_ChainPulley
    SET IsYes = @ChainPulleyIsYes, Remarks = @ChainPulleyRemarks, PhotoPath = @ChainPulleyPhotoPath
    WHERE HeaderID = @ID AND Question = @ChainPulleyQuestion;";


                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", id);
                    cmd.Parameters.AddWithValue("@JobName", jobName);

                    cmd.Parameters.AddWithValue("@ShacklesQuestion", shacklesQuestion);
                    cmd.Parameters.AddWithValue("@ShacklesIsYes", shacklesIsYes);
                    cmd.Parameters.AddWithValue("@ShacklesRemarks", shacklesRemarks);
                    cmd.Parameters.AddWithValue("@ShacklesPhotoPath", shacklesPhotoPath);

                    cmd.Parameters.AddWithValue("@ChainPulleyQuestion", chainPulleyQuestion);
                    cmd.Parameters.AddWithValue("@ChainPulleyIsYes", chainPulleyIsYes);
                    cmd.Parameters.AddWithValue("@ChainPulleyRemarks", chainPulleyRemarks);
                    cmd.Parameters.AddWithValue("@ChainPulleyPhotoPath", chainPulleyPhotoPath);


                    cmd.ExecuteNonQuery();
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