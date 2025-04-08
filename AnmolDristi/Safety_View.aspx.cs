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
                LoadSafetyAuditDetails();
            }
        }


            private void LoadSafetyAuditDetails()
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string query = @"
                    SELECT 
                         sa.ID, sa.Department, sa.Section, sa.Date, sa.Time, 
                         sa.ContractorVendorCode, sa.TotalContractorPeople, 
                         sev.AuditID, sev.InternalEmployees,sev.ExternalMembers,
                         sdesc.Description, sdesc.GoodCitizens, sdesc.NoOfViolations, sdesc.Severity,sdesc.ViolationXSeverity, sdesc.FourAndFive, sdesc.UnsafeActConditions
                     FROM SafetyAudit_Main sa
                     LEFT JOIN SafetyAudit_Severity sev ON sa.ID = sev.AuditID
                     LEFT JOIN SafetyAudit_Description sdesc ON sa.ID = sdesc.AuditID
                     ORDER BY sa.Date DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            GvSafetyAudit.DataSource = dt;
                            GvSafetyAudit.DataBind();
                        }
                    }
                }
            }

            protected void GvSafetyAudit_RowEditing(object sender, GridViewEditEventArgs e)
            {
                GvSafetyAudit.EditIndex = e.NewEditIndex;
                LoadSafetyAuditDetails();
            }

            protected void GvSafetyAudit_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
            {
                GvSafetyAudit.EditIndex = -1;
                LoadSafetyAuditDetails();
            }

            protected void GvSafetyAudit_RowUpdating(object sender, GridViewUpdateEventArgs e)
            {
                int auditID = Convert.ToInt32(GvSafetyAudit.DataKeys[e.RowIndex].Value);
                GridViewRow row = GvSafetyAudit.Rows[e.RowIndex];

                string department = ((TextBox)row.Cells[0].Controls[0]).Text;
                string section = ((TextBox)row.Cells[1].Controls[0]).Text;
                string contractorCode = ((TextBox)row.Cells[4].Controls[0]).Text;

                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string updateQuery = @"
                    UPDATE SafetyAudit_Main 
                    SET Department = @Department, Section = @Section, ContractorVendorCode = @Contractor 
                    WHERE ID = @AuditID";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@AuditID", auditID);
                        cmd.Parameters.AddWithValue("@Department", department);
                        cmd.Parameters.AddWithValue("@Section", section);
                        cmd.Parameters.AddWithValue("@Contractor", contractorCode);

                        cmd.ExecuteNonQuery();
                    }
                }

                GvSafetyAudit.EditIndex = -1;
                LoadSafetyAuditDetails();
            }

            protected void GvSafetyAudit_RowDeleting(object sender, GridViewDeleteEventArgs e)
            {
                int auditID = Convert.ToInt32(GvSafetyAudit.DataKeys[e.RowIndex].Value);
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM SafetyAudit_Description WHERE AuditID = @AuditID; DELETE FROM SafetyAudit_Severity WHERE AuditID = @AuditID; DELETE FROM SafetyAudit_Main WHERE ID = @AuditID;", conn))
                    {
                        cmd.Parameters.AddWithValue("@AuditID", auditID);
                        cmd.ExecuteNonQuery();
                    }
                }

                LoadSafetyAuditDetails();
            }
        }
    }
