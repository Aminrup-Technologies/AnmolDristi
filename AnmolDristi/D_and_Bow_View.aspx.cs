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
            try
            {
                //Response.Write("Update Event Triggered!<br>");

                string id = GvDandBowChecklist.DataKeys[e.RowIndex].Value.ToString();
             //   Response.Write("Row ID: " + id + "<br>");

                GridViewRow row = GvDandBowChecklist.Rows[e.RowIndex];

                string jobName = ((TextBox)row.FindControl("txtJobName")).Text.Trim();
              //  Response.Write("JobName: " + jobName + "<br>");

                // Shackles Section
                string shacklesQuestion = ((TextBox)row.FindControl("txtShacklesQuestion")).Text.Trim();
                DropDownList ddlShacklesIsYes = (DropDownList)row.FindControl("ddlShacklesIsYes");
                int newShacklesIsYes = ddlShacklesIsYes.SelectedValue == "True" ? 1 : 0;
                string shacklesRemarks = ((TextBox)row.FindControl("txtShacklesRemarks")).Text.Trim();
                FileUpload fileShacklesPhoto = (FileUpload)row.FindControl("fileShacklesPhoto");
                Label lblExistingShacklesPhoto = (Label)row.FindControl("lblExistingShacklesPhoto");
                string shacklesPhotoPath = lblExistingShacklesPhoto.Text;

                if (fileShacklesPhoto.HasFile)
                {
                    string fileName = Path.GetFileName(fileShacklesPhoto.FileName);
                    string path = Server.MapPath("~/Uploads/");
                    Directory.CreateDirectory(path);
                    string fullPath = Path.Combine(path, fileName);
                    fileShacklesPhoto.SaveAs(fullPath);
                    shacklesPhotoPath = "~/Uploads/" + fileName;
                   // Response.Write("Shackles Photo Uploaded: " + shacklesPhotoPath + "<br>");
                }

                // Chain Pulley Section
                string chainPulleyQuestion = ((TextBox)row.FindControl("txtChainPulleyQuestion")).Text.Trim();
                DropDownList ddlChainPulleyIsYes = (DropDownList)row.FindControl("ddlChainPulleyIsYes");
                int newChainPulleyIsYes = ddlChainPulleyIsYes.SelectedValue == "True" ? 1 : 0;
                string chainPulleyRemarks = ((TextBox)row.FindControl("txtChainPulleyRemarks")).Text.Trim();
                FileUpload fileChainPulleyPhoto = (FileUpload)row.FindControl("fileChainPulleyPhoto");
                Label lblExistingChainPulleyPhoto = (Label)row.FindControl("lblExistingChainPulleyPhoto");
                string chainPulleyPhotoPath = lblExistingChainPulleyPhoto.Text;

                if (fileChainPulleyPhoto.HasFile)
                {
                    string fileName = Path.GetFileName(fileChainPulleyPhoto.FileName);
                    string path = Server.MapPath("~/Uploads/");
                    Directory.CreateDirectory(path);
                    string fullPath = Path.Combine(path, fileName);
                    fileChainPulleyPhoto.SaveAs(fullPath);
                    chainPulleyPhotoPath = "~/Uploads/" + fileName;
                   // Response.Write("Chain Pulley Photo Uploaded: " + chainPulleyPhotoPath + "<br>");
                }

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
                {
                    conn.Open();
                    SqlTransaction trans = conn.BeginTransaction();
                  //  Response.Write("DB Connection Opened.<br>");

                    try
                    {
                        // 1. Update Header
                        SqlCommand updateHeader = new SqlCommand(@"
                    UPDATE MahimaGupta_CSMS.ShacklesChecklist_BasicDetails
                    SET JobName = @JobName
                    WHERE BasicID = @ID
                ", conn, trans);
                        updateHeader.Parameters.AddWithValue("@JobName", jobName);
                       // updateHeader.Parameters.AddWithValue("@ID", Convert.ToInt32(id));
                        updateHeader.Parameters.AddWithValue("@ID", id);
                        int headerRows = updateHeader.ExecuteNonQuery();
                       
                        // 2. Get Old Values
                        int currentShacklesIsYes = -1;
                        int currentChainPulleyIsYes = -1;

                        SqlCommand getOld = new SqlCommand(@"
                    SELECT 
                        (SELECT IsYes FROM MahimaGupta_CSMS.ShacklesChecklist_DBow WHERE HeaderID = @ID AND Question = @SQ) AS OldShackles,
                        (SELECT IsYes FROM MahimaGupta_CSMS.ShacklesChecklist_ChainPulley WHERE HeaderID = @ID AND Question = @CQ) AS OldPulley
                ", conn, trans);
                        getOld.Parameters.AddWithValue("@ID", id);
                        getOld.Parameters.AddWithValue("@SQ", shacklesQuestion);
                        getOld.Parameters.AddWithValue("@CQ", chainPulleyQuestion);

                        using (SqlDataReader reader = getOld.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                currentShacklesIsYes = reader["OldShackles"] != DBNull.Value ? Convert.ToInt32(reader["OldShackles"]) : -1;
                                currentChainPulleyIsYes = reader["OldPulley"] != DBNull.Value ? Convert.ToInt32(reader["OldPulley"]) : -1;

                               // Response.Write("Current Shackles IsYes: " + currentShacklesIsYes + "<br>");
                              //  Response.Write("Current Chain Pulley IsYes: " + currentChainPulleyIsYes + "<br>");
                            }
                            else
                            {
                               // Response.Write("Old values not found!<br>");
                            }
                        }

                        // 3. Update Shackles
                        SqlCommand updateShackles = new SqlCommand(@"
                    UPDATE MahimaGupta_CSMS.ShacklesChecklist_DBow
                    SET IsYes = @IsYes, Remarks = @Remarks, PhotoPath = @PhotoPath, CAPA_ID = @CAPA_ID
                    WHERE HeaderID = @ID AND Question = @Question
                ", conn, trans);
                        updateShackles.Parameters.AddWithValue("@ID", id);
                        updateShackles.Parameters.AddWithValue("@IsYes", newShacklesIsYes);
                        updateShackles.Parameters.AddWithValue("@Remarks", newShacklesIsYes == 1 ? (object)DBNull.Value : (object)shacklesRemarks ?? DBNull.Value);
                        updateShackles.Parameters.AddWithValue("@PhotoPath", newShacklesIsYes == 1 ? (object)DBNull.Value : (object)shacklesPhotoPath ?? DBNull.Value);

                        updateShackles.Parameters.AddWithValue("@Question", shacklesQuestion);
                        updateShackles.Parameters.AddWithValue("@CAPA_ID", DBNull.Value);

                        int shacklesRows = updateShackles.ExecuteNonQuery();
                        

                        // 4. Update Chain Pulley
                        SqlCommand updatePulley = new SqlCommand(@"
                    UPDATE MahimaGupta_CSMS.ShacklesChecklist_ChainPulley
                    SET IsYes = @IsYes, Remarks = @Remarks, PhotoPath = @PhotoPath, CAPA_ID = @CAPA_ID
                    WHERE HeaderID = @ID AND Question = @Question
                ", conn, trans);
                        updatePulley.Parameters.AddWithValue("@ID", id);
                        updatePulley.Parameters.AddWithValue("@IsYes", newChainPulleyIsYes);
                        updatePulley.Parameters.AddWithValue("@Remarks", newChainPulleyIsYes == 1 ? (object)DBNull.Value : (object)chainPulleyRemarks ?? DBNull.Value);
                        updatePulley.Parameters.AddWithValue("@PhotoPath", newChainPulleyIsYes == 1 ? (object)DBNull.Value : (object)chainPulleyPhotoPath ?? DBNull.Value);

                        updatePulley.Parameters.AddWithValue("@Question", chainPulleyQuestion);
                        updatePulley.Parameters.AddWithValue("@CAPA_ID", DBNull.Value);

                        int pulleyRows = updatePulley.ExecuteNonQuery();
                       // Response.Write("Chain Pulley Update Rows Affected: " + pulleyRows + "<br>");

                        trans.Commit();
                      //  Response.Write("<b>Transaction Committed Successfully.</b><br>");
                    }
                    catch (Exception innerEx)
                    {
                        trans.Rollback();
                       // Response.Write("<b>Inner Exception during transaction:</b> " + innerEx.Message + "<br>");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<b>Outer Exception:</b> " + ex.Message + "<br>");
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