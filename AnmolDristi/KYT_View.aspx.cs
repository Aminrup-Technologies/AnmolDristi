using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using System.Data;
using System.Data.SqlClient;
using System.Configuration;


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
        hkyt.SubmissionDate,
        hkyt.SubmissionTime,
        ISNULL(capa.isYes, 0) AS RequiresCAPA
    FROM KYT_Table1 kyt
    LEFT JOIN KYT_Table2 hkyt ON kyt.ID = hkyt.ID
    LEFT JOIN tbl_CAPAMaster capa 
        ON capa.HeaderID = 'KY' + RIGHT('000' + CAST(kyt.ID AS VARCHAR), 3)
    ORDER BY kyt.ID DESC";


                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        // 🔍 DEBUG LOG EACH RequiresCAPA VALUE
                        foreach (DataRow row in dt.Rows)
                        {
                            System.Diagnostics.Debug.WriteLine("RequiresCAPA: " + row["RequiresCAPA"]);
                        }

                        GvKYTRecords.DataSource = dt;
                        GvKYTRecords.DataBind();
                    }
                }
            }
        }

        protected void GvKYTRecords_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GvKYTRecords.EditIndex = e.NewEditIndex;
            LoadKYTIncidentDetails();
        }

        protected void GvKYTRecords_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GvKYTRecords.EditIndex = -1;
            LoadKYTIncidentDetails();
        }
        protected void GvKYTRecords_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GvKYTRecords.Rows[e.RowIndex];
            string kytID = GvKYTRecords.DataKeys[e.RowIndex].Value.ToString();

            TextBox txtWorksite = (TextBox)row.FindControl("txtWorksiteName");
            TextBox txtDepartment = (TextBox)row.FindControl("txtDepartment");
            TextBox txtLocation = (TextBox)row.FindControl("txtLocation");
            TextBox txtJobID = (TextBox)row.FindControl("txtJobID");
            CheckBox chkRequiresCAPAEdit = (CheckBox)row.FindControl("chkRequiresCAPAEdit");

            if (txtWorksite == null || txtDepartment == null || txtLocation == null || txtJobID == null || chkRequiresCAPAEdit == null)
            {
                // Defensive check to avoid NullReferenceException
                // You may log or throw an error here
                return;
            }

            string worksite = txtWorksite.Text.Trim();
            string department = txtDepartment.Text.Trim();
            string location = txtLocation.Text.Trim();
            string jobID = txtJobID.Text.Trim();
           // bool requiresCAPA = chkRequiresCAPAEdit.Checked;
            bool requiresCAPA = true; // forcefully always store 1



            // Debug log just before DB write
            System.Diagnostics.Debug.WriteLine($"[DEBUG] Updating CAPA: HeaderID = {"KY" + Convert.ToInt32(kytID).ToString("D3")}, IsYes = {(requiresCAPA ? 1 : 0)}");

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Update KYT_Table1
                string updateQuery = @"
            UPDATE KYT_Table1 
            SET KYT_WorksiteName = @Worksite, 
                KYT_Department = @Department, 
                KYT_Location = @Location, 
                KYT_JobID = @JobID 
            WHERE ID = @ID";

                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", kytID);
                    cmd.Parameters.AddWithValue("@Worksite", worksite);
                    cmd.Parameters.AddWithValue("@Department", department);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Parameters.AddWithValue("@JobID", jobID);
                    cmd.ExecuteNonQuery();
                }

                // Update or insert CAPA
                // Update or insert CAPA
                string capaUpdateQuery = @"
IF EXISTS (SELECT 1 FROM tbl_CAPAMaster WHERE HeaderID = @HeaderID)
    UPDATE tbl_CAPAMaster SET isYes = @IsYes WHERE HeaderID = @HeaderID
ELSE
    INSERT INTO tbl_CAPAMaster (HeaderID, isYes) VALUES (@HeaderID, @IsYes)";

                using (SqlCommand cmd = new SqlCommand(capaUpdateQuery, conn))
                {
                    string headerID = "KY" + Convert.ToInt32(kytID).ToString("D3");
                    int isYesValue = requiresCAPA ? 1 : 0;

                    // 🔍 Debug output
                    System.Diagnostics.Debug.WriteLine($"[DEBUG] Updating CAPA: HeaderID = {headerID}, IsYes = {isYesValue}");

                    cmd.Parameters.AddWithValue("@HeaderID", headerID);
                    cmd.Parameters.AddWithValue("@IsYes", isYesValue);
                    cmd.ExecuteNonQuery();
                }
            }

                GvKYTRecords.EditIndex = -1;
            LoadKYTIncidentDetails();
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
    }
}
