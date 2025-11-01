using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace AnmolDristi
{
    public partial class KYT_View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadKYTIncidentDetails();
            }
        }

  
        private void LoadKYTIncidentDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
               
                string query = @"
                            SELECT
                                kyt.ID,                                 
                                hkyt.KYT_Table2ID,                       
                                kyt.KYT_WorksiteName,
                                kyt.KYT_Department,
                                kyt.KYT_Location,
                                kyt.KYT_Date,
                                kyt.KYT_JobID,
                                kyt.KYT_SOPNo,
                                kyt.KYT_Vendor,
                                hkyt.KYT_Activity,
                                hkyt.KYT_HiddenHazards,
                                hkyt.KYT_Consequence,
                                hkyt.KYT_CounterMeasures,
                                hkyt.KYT_PriorityValue,
                                hkyt.KYT_PhotographPath,
                                hkyt.SubmissionDate,
                                hkyt.SubmissionTime,
                                hkyt.CAPAID,
                                hkyt.Custom_ID,
                                hkyt.IsCAPAChecked
                            FROM KYT_Table1 kyt
                            LEFT JOIN KYT_Table2 hkyt 
                                ON kyt.ID = hkyt.ID   -- FK in child table
                            ORDER BY 
                                kyt.ID DESC, 
                                hkyt.SubmissionDate DESC, 
                                hkyt.SubmissionTime DESC";


                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        
                        GvKYTRecords.DataSource = dt;
                        GvKYTRecords.DataBind();
                    }
                }
            }
        }

        protected void GvKYTRecords_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GvKYTRecords.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void GvKYTRecords_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GvKYTRecords.EditIndex = -1;
            LoadKYTIncidentDetails();
        }
        protected void GvKYTRecords_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

            GridViewRow row = GvKYTRecords.Rows[e.RowIndex];
            string kytID = GvKYTRecords.DataKeys[e.RowIndex].Values["ID"].ToString();
            string observationID = GvKYTRecords.DataKeys[e.RowIndex].Values["KYT_Table2ID"].ToString();

            TextBox txtWorksite = (TextBox)row.FindControl("txtWorksiteName");
            TextBox txtDepartment = (TextBox)row.FindControl("txtDepartment");
            TextBox txtLocation = (TextBox)row.FindControl("txtLocation");
            TextBox txtJobID = (TextBox)row.FindControl("txtJobID");
            CheckBox chkRequiresCAPAEdit = (CheckBox)row.FindControl("chkRequiresCAPAEdit");
            TextBox txtSOPNo = (TextBox)row.FindControl("txtSOPNo");
            TextBox txtVendor = (TextBox)row.FindControl("txtVendor");
            TextBox txtKYTDate = (TextBox)row.FindControl("txtKYTDate");

            TextBox txtActivity = (TextBox)row.FindControl("txtActivity");
            TextBox txtHiddenHazards = (TextBox)row.FindControl("txtHazards");
            TextBox txtConsequence = (TextBox)row.FindControl("txtConsequence");
            TextBox txtCounterMeasures = (TextBox)row.FindControl("txtCounterMeasures");
            DropDownList ddlPriority = (DropDownList)row.FindControl("ddlPriority");
            FileUpload fuPhoto = (FileUpload)row.FindControl("Photograph");
            Image imgPhoto = (Image)row.FindControl("imgPhoto");

            bool requiresCAPA = chkRequiresCAPAEdit != null && chkRequiresCAPAEdit.Checked;

            string imagePath = imgPhoto != null ? imgPhoto.ImageUrl : null;

            if (fuPhoto != null && fuPhoto.HasFile)
            {
                string folderPath = Server.MapPath("~/Uploads/KYTPhotos/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string fileName = Path.GetFileName(fuPhoto.FileName);
                string savePath = Path.Combine(folderPath, fileName);
                fuPhoto.SaveAs(savePath);
                imagePath = "~/Uploads/KYTPhotos/" + fileName;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string headerID = "KY" + Convert.ToInt32(kytID).ToString("D3");

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction tran = conn.BeginTransaction();

                try
                {
                    // previous CAPA information 
                    int? prevCAPAID = null;
                    int prevIsCAPAChecked = 0;

                    using (SqlCommand cmdPrev = new SqlCommand(@"
            SELECT CAPAID, ISNULL(IsCAPAChecked, 0) AS IsCAPAChecked
            FROM KYT_Table2
            WHERE KYT_Table2ID = @KYT_Table2ID", conn, tran))
                    {
                        cmdPrev.Parameters.AddWithValue("@KYT_Table2ID", observationID);

                        using (SqlDataReader dr = cmdPrev.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                if (dr["CAPAID"] != DBNull.Value)
                                    prevCAPAID = Convert.ToInt32(dr["CAPAID"]);

                                prevIsCAPAChecked = Convert.ToInt32(dr["IsCAPAChecked"]);
                            }
                        }
                    }

                    int? capaId = prevCAPAID;

                    // CAPA checkbox logic
                    if (prevIsCAPAChecked == 1 && requiresCAPA)
                    {
                        
                    }
                    else if (prevIsCAPAChecked == 1 && !requiresCAPA)
                    {
                       
                        using (SqlCommand cmd1 = new SqlCommand(
                            "UPDATE tbl_CAPAMaster SET IsYes = 1 WHERE CAPAID = @CAPAID", conn, tran))
                        {
                            cmd1.Parameters.AddWithValue("@CAPAID", prevCAPAID ?? (object)DBNull.Value);
                            cmd1.ExecuteNonQuery();
                        }

                        using (SqlCommand cmd2 = new SqlCommand(
                            "UPDATE KYT_Table2 SET IsCAPAChecked = 0 WHERE KYT_Table2ID = @KYT_Table2ID", conn, tran))
                        {
                            cmd2.Parameters.AddWithValue("@KYT_Table2ID", observationID); 
                            cmd2.ExecuteNonQuery();
                        }
                    }
                    else if (prevIsCAPAChecked == 0 && requiresCAPA)
                    {
                        
                        using (SqlCommand cmdInsert = new SqlCommand(@"
                            INSERT INTO tbl_CAPAMaster 
                            (HeaderID, Description, AssignedBy, AssignedDate, SourceTable, PhotoPath, IsYes)
                            VALUES (@HeaderID, @Description, @AssignedBy, @AssignedDate, @SourceTable, @PhotoPath, 0);
                            SELECT SCOPE_IDENTITY();", conn, tran))
                        {
                            cmdInsert.Parameters.AddWithValue("@HeaderID", headerID);
                            cmdInsert.Parameters.AddWithValue("@Description", txtActivity.Text.Trim());
                            cmdInsert.Parameters.AddWithValue("@AssignedBy", Session["UserName"] ?? "System");
                            cmdInsert.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                            cmdInsert.Parameters.AddWithValue("@SourceTable", "KYT");
                            cmdInsert.Parameters.AddWithValue("@PhotoPath", (object)imagePath ?? DBNull.Value);

                            object result = cmdInsert.ExecuteScalar();
                            capaId = Convert.ToInt32(result);
                        }

                        using (SqlCommand cmdUpdate = new SqlCommand(@"
                UPDATE KYT_Table2 
                SET CAPAID = @CAPAID, IsCAPAChecked = 1
                WHERE KYT_Table2ID = @KYT_Table2ID", conn, tran))
                        {
                            cmdUpdate.Parameters.AddWithValue("@CAPAID", capaId);
                            cmdUpdate.Parameters.AddWithValue("@KYT_Table2ID", observationID);
                            cmdUpdate.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        
                    }

                    // Update KYT_Table1 
                    using (SqlCommand cmd = new SqlCommand(@"
            UPDATE KYT_Table1 
            SET KYT_WorksiteName=@Worksite, KYT_Department=@Department, 
                KYT_Location=@Location, KYT_JobID=@JobID, 
                KYT_SOPNo=@SOPNo, KYT_Vendor=@Vendor, KYT_Date=@Date
            WHERE ID=@ID", conn, tran))
                    {
                        cmd.Parameters.AddWithValue("@ID", kytID);
                        cmd.Parameters.AddWithValue("@Worksite", txtWorksite.Text.Trim());
                        cmd.Parameters.AddWithValue("@Department", txtDepartment.Text.Trim());
                        cmd.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
                        cmd.Parameters.AddWithValue("@JobID", txtJobID.Text.Trim());
                        cmd.Parameters.AddWithValue("@SOPNo", txtSOPNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Vendor", txtVendor.Text.Trim());
                        cmd.Parameters.AddWithValue("@Date", DateTime.Parse(txtKYTDate.Text));
                        cmd.ExecuteNonQuery();
                    }

                    // Update KYT_Table2 
                    string updateDetail = (fuPhoto != null && fuPhoto.HasFile)
                        ? @"UPDATE KYT_Table2 SET 
                KYT_Activity=@Activity, KYT_HiddenHazards=@HiddenHazards, 
                KYT_Consequence=@Consequence, KYT_CounterMeasures=@CounterMeasures, 
                KYT_PriorityValue=@PriorityValue, KYT_PhotographPath=@PhotoPath,
                CAPAID=@CAPAID, IsCAPAChecked=@IsCAPAChecked
            WHERE KYT_Table2ID=@KYT_Table2ID"
                        : @"UPDATE KYT_Table2 SET 
                KYT_Activity=@Activity, KYT_HiddenHazards=@HiddenHazards, 
                KYT_Consequence=@Consequence, KYT_CounterMeasures=@CounterMeasures, 
                KYT_PriorityValue=@PriorityValue,
                CAPAID=@CAPAID, IsCAPAChecked=@IsCAPAChecked
           WHERE KYT_Table2ID=@KYT_Table2ID";

                    using (SqlCommand cmd = new SqlCommand(updateDetail, conn, tran))
                    {
                        cmd.Parameters.AddWithValue("@KYT_Table2ID", observationID);
                        cmd.Parameters.AddWithValue("@Activity", txtActivity.Text.Trim());
                        cmd.Parameters.AddWithValue("@HiddenHazards", txtHiddenHazards.Text.Trim());
                        cmd.Parameters.AddWithValue("@Consequence", txtConsequence.Text.Trim());
                        cmd.Parameters.AddWithValue("@CounterMeasures", txtCounterMeasures.Text.Trim());
                        cmd.Parameters.AddWithValue("@PriorityValue", ddlPriority.SelectedValue);
                        cmd.Parameters.AddWithValue("@PhotoPath", (object)imagePath ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@CAPAID", (object)capaId ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@IsCAPAChecked", requiresCAPA ? 1 : 0);
                        cmd.ExecuteNonQuery();
                    }

                    tran.Commit();

                    GvKYTRecords.EditIndex = -1;
                    BindGrid();

                    ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-success", @"
                        new PNotify({
                            title: 'Update Successful',
                            text: 'Observation updated successfully.',
                            type: 'success',
                            styling: 'bootstrap3',
                            delay: 2500
                        });
                    ", true);
                }
                catch(Exception ex)
                {
                    tran.Rollback();
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

        }



        protected void GvKYTRecords_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int kytID = Convert.ToInt32(GvKYTRecords.DataKeys[e.RowIndex].Value);
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM KYT_Table2 WHERE ID = @ID; DELETE FROM KYT_Table1 WHERE ID = @ID;", conn))
                {
                    cmd.Parameters.AddWithValue("@ID", kytID);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadKYTIncidentDetails();
        }

        private void BindGrid()
        {
            LoadKYTIncidentDetails(); // ✅ Called here only once
        }

    }
}
