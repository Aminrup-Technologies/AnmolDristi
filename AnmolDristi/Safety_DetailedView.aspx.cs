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
                string auditId = Request.QueryString["AuditID"];
                if (!string.IsNullOrEmpty(auditId))
                {
                    LoadSafetyAuditData(auditId);
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

        private void LoadSafetyAuditData(string auditId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"
    SELECT
        t1.ID AS AuditID,
        t1.Department, t1.Section, t1.Date, t1.Time,
        t1.ContractorVendorCode, t1.TotalContractorPeople,
        t2.InternalEmployees, t2.ExternalMembers,
        t3.Description, t3.GoodCitizens, t3.NoOfViolations, t3.Severity,
        t3.ViolationXSeverity, t3.FourAndFive, t3.UnsafeActConditions,
        t3.SubmittedDate, t3.SubmittedTime,
        t3.CAPAID   -- ✅ Add CAPAID here
    FROM [MahimaGupta_CSMS].[SafetyAudit_Main] t1
    LEFT JOIN [MahimaGupta_CSMS].[SafetyAudit_Severity] t2 ON t1.ID = t2.AuditID
    LEFT JOIN [MahimaGupta_CSMS].[SafetyAudit_Description] t3 ON t1.ID = t3.AuditID
    WHERE t1.ID = @AuditID", conn);


                cmd.Parameters.AddWithValue("@AuditID", auditId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSafetyAuditDetails.DataSource = dt;
                gvSafetyAuditDetails.DataBind();
            }
        }
    }
}
