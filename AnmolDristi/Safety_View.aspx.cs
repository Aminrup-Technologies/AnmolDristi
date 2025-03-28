using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Safety_View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSafetyAuditData();
            }
        }

        private void LoadSafetyAuditData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
SELECT 
    sa.AuditID, sa.Department, sa.Section, sa.AuditDate, sa.AuditTime,
    sa.ContractorVendorCode, sa.TotalContractorPeople, sa.TeamMembers,
    sev.SeverityLevel, d.Description AS descriptionAlias, sa.SelectedField, sa.Options
FROM SafetyAudit_Main sa
LEFT JOIN SafetyAudit_Severity sev ON sa.AuditID = sev.AuditID
LEFT JOIN SafetyAudit_Description d ON sa.AuditID = d.AuditID
ORDER BY sa.AuditID DESC";


                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvSafetyAudit.DataSource = dt;
                        gvSafetyAudit.DataBind();
                    }
                }
            }
        }

        protected void gvSafetyAudit_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSafetyAudit.EditIndex = e.NewEditIndex;
            LoadSafetyAuditData();
        }

        protected void gvSafetyAudit_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSafetyAudit.EditIndex = -1;
            LoadSafetyAuditData();
        }

        protected void gvSafetyAudit_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int auditID = Convert.ToInt32(gvSafetyAudit.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvSafetyAudit.Rows[e.RowIndex];

            string department = ((TextBox)row.Cells[0].Controls[0]).Text;
            string section = ((TextBox)row.Cells[1].Controls[0]).Text;
            string auditDate = ((TextBox)row.Cells[2].Controls[0]).Text;
            string auditTime = ((TextBox)row.Cells[3].Controls[0]).Text;
            string vendorCode = ((TextBox)row.Cells[4].Controls[0]).Text;
            string totalPeople = ((TextBox)row.Cells[5].Controls[0]).Text;
            string teamMembers = ((TextBox)row.Cells[6].Controls[0]).Text;
            string severityLevel = ((TextBox)row.Cells[7].Controls[0]).Text;
            string description = ((TextBox)row.Cells[8].Controls[0]).Text;
            string selectedField = ((TextBox)row.Cells[9].Controls[0]).Text;
            string options = ((TextBox)row.Cells[10].Controls[0]).Text;

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string updateQuery = @"
                UPDATE SafetyAudit_Main 
                SET Department=@Department, Section=@Section, AuditDate=@AuditDate, AuditTime=@AuditTime,
                    ContractorVendorCode=@VendorCode, TotalContractorPeople=@TotalPeople, TeamMembers=@TeamMembers,
                    SelectedField=@SelectedField, Options=@Options
                WHERE AuditID=@AuditID;

                UPDATE SafetyAudit_Severity 
                SET SeverityLevel=@SeverityLevel 
                WHERE AuditID=@AuditID;

                UPDATE SafetyAudit_Description 
                SET Description=@Description 
                WHERE AuditID=@AuditID;";

                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@AuditID", auditID);
                    cmd.Parameters.AddWithValue("@Department", department);
                    cmd.Parameters.AddWithValue("@Section", section);
                    cmd.Parameters.AddWithValue("@AuditDate", auditDate);
                    cmd.Parameters.AddWithValue("@AuditTime", auditTime);
                    cmd.Parameters.AddWithValue("@VendorCode", vendorCode);
                    cmd.Parameters.AddWithValue("@TotalPeople", totalPeople);
                    cmd.Parameters.AddWithValue("@TeamMembers", teamMembers);
                    cmd.Parameters.AddWithValue("@SeverityLevel", severityLevel);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@SelectedField", selectedField);
                    cmd.Parameters.AddWithValue("@Options", options);

                    cmd.ExecuteNonQuery();
                }
            }

            gvSafetyAudit.EditIndex = -1;
            LoadSafetyAuditData();
        }




        protected void gvSafetyAudit_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int auditID = Convert.ToInt32(gvSafetyAudit.DataKeys[e.RowIndex].Value);
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string deleteQuery = @"
                DELETE FROM SafetyAudit_Severity WHERE AuditID = @AuditID;
                DELETE FROM SafetyAudit_Description WHERE AuditID = @AuditID;
                DELETE FROM SafetyAudit_Main WHERE AuditID = @AuditID;";

                using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@AuditID", auditID);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadSafetyAuditData();
        }
    }
}
