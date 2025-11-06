using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
namespace AnmolDristi
{
    public partial class Safety_DetailedView : System.Web.UI.Page
    {
       
        string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string auditID = Request.QueryString["AuditID"];

                if (!string.IsNullOrEmpty(auditID))
                {
                    LoadSafetyAuditData(auditID);
                }
            }
        }
        protected void gvSafetyAuditDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;

                HyperLink lnk = (HyperLink)e.Row.FindControl("lnkCapa");
                if (lnk != null)
                {
                    if (drv["CAPA_ID"] == DBNull.Value || string.IsNullOrEmpty(drv["CAPA_ID"].ToString()))
                    {
                        lnk.Visible = false; // hide when null
                    }
                }
            }
        }

        private void LoadSafetyAuditData(string auditID)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // === 1️⃣ SafetyAudit_Main ===
                string queryMain = @"
            SELECT 
                ID,
                Department,
                Section,
                Date,
                Time,
                ContractorVendorCode,
                TotalContractorPeople
            FROM [MahimaGupta_CSMS].[SafetyAudit_Main]
            WHERE ID = @AuditID";

                SqlDataAdapter daMain = new SqlDataAdapter(queryMain, conn);
                daMain.SelectCommand.Parameters.AddWithValue("@AuditID", auditID);
                DataTable dtMain = new DataTable();
                daMain.Fill(dtMain);

                gvAuditMain.DataSource = dtMain;
                gvAuditMain.DataBind();

                // === 2️⃣ SafetyAudit_Severity ===
                string querySeverity = @"
            SELECT 
                ID,
                AuditID,
                InternalEmployees,
                ExternalMembers
            FROM [MahimaGupta_CSMS].[SafetyAudit_Severity]
            WHERE AuditID = @AuditID";

                SqlDataAdapter daSeverity = new SqlDataAdapter(querySeverity, conn);
                daSeverity.SelectCommand.Parameters.AddWithValue("@AuditID", auditID);
                DataTable dtSeverity = new DataTable();
                daSeverity.Fill(dtSeverity);

                gvAuditSeverity.DataSource = dtSeverity;
                gvAuditSeverity.DataBind();

                // === 3️⃣ SafetyAudit_Description === (multiple rows possible)
                string queryDescription = @"
            SELECT 
                ID,
                AuditID,
                Description,
                GoodCitizens,
                NoOfViolations,
                Severity,
                ViolationXSeverity,
                FourAndFive,
                UnsafeActConditions,
                SubmittedDate,
                SubmittedTime,
                CAPAID,
                Custom_ID,
                GenerateCAPA
            FROM [MahimaGupta_CSMS].[SafetyAudit_Description]
            WHERE AuditID = @AuditID
            ORDER BY ID";

                SqlDataAdapter daDescription = new SqlDataAdapter(queryDescription, conn);
                daDescription.SelectCommand.Parameters.AddWithValue("@AuditID", auditID);
                DataTable dtDescription = new DataTable();
                daDescription.Fill(dtDescription);

                gvAuditDescription.DataSource = dtDescription;
                gvAuditDescription.DataBind();
            }
        }

    }
}
