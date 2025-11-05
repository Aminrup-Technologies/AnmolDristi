using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Runtime.Remoting.Messaging;
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
//                string query = @"
//SELECT 
//    sa.ID, sa.Department, sa.Section, sa.Date, sa.Time, 
//    sa.ContractorVendorCode, sa.TotalContractorPeople, 
//    sev.AuditID, sev.InternalEmployees, sev.ExternalMembers,
//    sdesc.Description, sdesc.GoodCitizens, sdesc.NoOfViolations, 
//    sdesc.Severity, sdesc.ViolationXSeverity, sdesc.FourAndFive, 
//    sdesc.UnsafeActConditions, sdesc.SubmittedDate, sdesc.SubmittedTime,
//    sdesc.GenerateCAPA
//FROM SafetyAudit_Main sa
//LEFT JOIN SafetyAudit_Severity sev ON sa.ID = sev.AuditID
//LEFT JOIN SafetyAudit_Description sdesc ON sa.ID = sdesc.AuditID
//LEFT JOIN tbl_CAPAMaster capa ON capa.HeaderID = 'SA' + RIGHT('000' + CAST(sa.ID AS VARCHAR), 3)
//ORDER BY sa.Date DESC";




                string query = @"SELECT 
    sdesc.ID AS DescriptionID,           -- ✅ Unique key for each observation row
    sa.ID AS AuditID,                    -- ✅ Main Audit ID
    sa.Department, sa.Section, sa.Date, sa.Time, 
    sa.ContractorVendorCode, sa.TotalContractorPeople, 
    sev.InternalEmployees, sev.ExternalMembers,
    sdesc.Description, sdesc.GoodCitizens, sdesc.NoOfViolations, 
    sdesc.Severity, sdesc.ViolationXSeverity, sdesc.FourAndFive, 
    sdesc.UnsafeActConditions, sdesc.SubmittedDate, sdesc.SubmittedTime,
    sdesc.GenerateCAPA, sdesc.CAPAID
FROM SafetyAudit_Main sa
LEFT JOIN SafetyAudit_Severity sev ON sa.ID = sev.AuditID
LEFT JOIN SafetyAudit_Description sdesc ON sa.ID = sdesc.AuditID
ORDER BY sa.ID DESC";



                using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                        // 🔍 Debug check:
                        if (!dt.Columns.Contains("GenerateCAPA"))
                        {
                            throw new Exception("Column 'GenerateCAPA' not found in DataTable!");
                        }


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
            int id = Convert.ToInt32(GvSafetyAudit.DataKeys[e.RowIndex].Values["DescriptionID"]);
            int auditID = Convert.ToInt32(GvSafetyAudit.DataKeys[e.RowIndex].Values["AuditID"]);

            GridViewRow row = GvSafetyAudit.Rows[e.RowIndex];




            string department = ((TextBox)row.FindControl("txtDepartment")).Text;
            string section = ((TextBox)row.FindControl("txtSection")).Text;
            string date = ((TextBox)row.FindControl("txtDate")).Text;
            string time = ((TextBox)row.FindControl("txtTime")).Text;
            string vendorCode = ((TextBox)row.FindControl("txtVendorCode")).Text;
            string totalPeople = ((TextBox)row.FindControl("txtTotalContractorPeople")).Text;
            string internalMembers = ((TextBox)row.FindControl("txtInternalEmployees")).Text;
            string externalMembers = ((TextBox)row.FindControl("txtExternalMembers")).Text;
            string description = ((TextBox)row.FindControl("txtDescription")).Text;
            string goodCitizens = ((TextBox)row.FindControl("txtGoodCitizens")).Text;
            string noOfViolations = ((TextBox)row.FindControl("txtNoOfViolations")).Text;
            string severity = ((TextBox)row.FindControl("txtSeverity")).Text;
            string violationXSeverity = ((TextBox)row.FindControl("txtViolationXSeverity")).Text;
            string fourAndFive = ((TextBox)row.FindControl("txtFourAndFive")).Text;
            string unsafeValue = ((DropDownList)row.FindControl("ddlUnsafeActConditions")).SelectedValue;


            CheckBox chkRequiresCAPA = (CheckBox)row.FindControl("chkRequiresCAPAEdit");
            //bool requiresCAPA = chkRequiresCAPA != null && chkRequiresCAPA.Checked;
            bool requiresCAPA = chkRequiresCAPA != null && chkRequiresCAPA.Checked;

            string headerID = "SA" + auditID.ToString("D3");
            int isYesValue = requiresCAPA ? 1 : 0;


            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction trans = conn.BeginTransaction();

                try
                {

                    // Update main fields
                    string updateQuery = @"
                        UPDATE SafetyAudit_Main 
                        SET Department = @Department, Section = @Section, ContractorVendorCode = @Contractor , TotalContractorPeople= @TotalPeople, Date=@Date, Time = @Time
                        WHERE ID = @AuditID";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@AuditID", auditID);
                        cmd.Parameters.AddWithValue("@Department", department);
                        cmd.Parameters.AddWithValue("@Section", section);
                        cmd.Parameters.AddWithValue("@Contractor", vendorCode);
                        cmd.Parameters.AddWithValue("@TotalPeople", totalPeople);
                        cmd.Parameters.AddWithValue("@Date", date);
                        cmd.Parameters.AddWithValue("@Time", time);
                        cmd.ExecuteNonQuery();
                    }


                    // ===== Update Members =====
                    string updateMembers = @"
                    UPDATE SafetyAudit_Severity
                    SET InternalEmployees = @Internal, ExternalMembers = @External
                    WHERE AuditID = @AuditID";

                    using (SqlCommand cmd = new SqlCommand(updateMembers, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@AuditID", auditID);
                        cmd.Parameters.AddWithValue("@Internal", internalMembers);
                        cmd.Parameters.AddWithValue("@External", externalMembers);
                        cmd.ExecuteNonQuery();
                    }

                    // === Fetch existing CAPA info ===
                    bool wasPreviouslyChecked = false;
                    int? currentCAPAID = null;

                    using (SqlCommand cmdCheck = new SqlCommand(@"
                        SELECT GenerateCAPA, CAPAID 
                        FROM SafetyAudit_Description 
                        WHERE ID = @DescriptionID", conn, trans))
                    {
                        cmdCheck.Parameters.AddWithValue("@DescriptionID", id);
                        using (SqlDataReader reader = cmdCheck.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                wasPreviouslyChecked = reader["GenerateCAPA"] != DBNull.Value && Convert.ToBoolean(reader["GenerateCAPA"]);
                                if (reader["CAPAID"] != DBNull.Value)
                                    currentCAPAID = Convert.ToInt32(reader["CAPAID"]);
                            }
                        }
                    }

                    int? newCAPAID = currentCAPAID;

                    // === CASE 1: Previously unchecked → now checked (Insert new CAPA) ===
                    if (!wasPreviouslyChecked && requiresCAPA)
                    {
                        using (SqlCommand cmdCAPA = new SqlCommand(@"
                                INSERT INTO tbl_CAPAMaster (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate)
                                OUTPUT INSERTED.CAPAID
                                VALUES (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate)", conn, trans))
                        {
                            cmdCAPA.Parameters.AddWithValue("@HeaderID", headerID);
                            cmdCAPA.Parameters.AddWithValue("@PhotoPath", DBNull.Value);
                            cmdCAPA.Parameters.AddWithValue("@Remarks", DBNull.Value);
                            cmdCAPA.Parameters.AddWithValue("@AssignedBy", Session["UserName"] ?? "System");
                            cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                            newCAPAID = Convert.ToInt32(cmdCAPA.ExecuteScalar());
                        }
                    }

                    // === CASE 2: Previously checked → now unchecked (Mark CAPA inactive) ===
                    if (wasPreviouslyChecked && !requiresCAPA && currentCAPAID.HasValue)
                    {
                        using (SqlCommand updateCAPA = new SqlCommand(
                            "UPDATE tbl_CAPAMaster SET IsYes = 1 WHERE CAPAID = @CAPAID", conn, trans))
                        {
                            updateCAPA.Parameters.AddWithValue("@CAPAID", currentCAPAID.Value);
                            updateCAPA.ExecuteNonQuery();
                        }
                    }

                    // === Update SafetyAudit_Description ===
                    string updateDescription = @"
                            UPDATE SafetyAudit_Description
                            SET Description = @Desc, GoodCitizens = @Good, NoOfViolations = @Viol, Severity = @Severity,
                                ViolationXSeverity = @ViolXSev, FourAndFive = @FourFive, UnsafeActConditions = @Unsafe,
                                CAPAID = @CAPAID, GenerateCAPA = @GenerateCAPA
                            WHERE ID = @DescriptionID";

                    using (SqlCommand cmd = new SqlCommand(updateDescription, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@DescriptionID", id);
                        cmd.Parameters.AddWithValue("@Desc", description);
                        cmd.Parameters.AddWithValue("@Good", goodCitizens);
                        cmd.Parameters.AddWithValue("@Viol", noOfViolations);
                        cmd.Parameters.AddWithValue("@Severity", severity);
                        cmd.Parameters.AddWithValue("@ViolXSev", violationXSeverity);
                        cmd.Parameters.AddWithValue("@FourFive", fourAndFive);
                        cmd.Parameters.AddWithValue("@Unsafe", unsafeValue);
                        cmd.Parameters.AddWithValue("@GenerateCAPA", requiresCAPA);
                        cmd.Parameters.AddWithValue("@CAPAID", (object)newCAPAID ?? DBNull.Value);

                        cmd.ExecuteNonQuery();
                    }

                    trans.Commit();
                    GvSafetyAudit.EditIndex = -1;
                    LoadSafetyAuditDetails();

                    //  success
                    ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-success", @"
                        new PNotify({
                            title: 'Successful',
                            text: 'Form updated successfully.',
                            type: 'success',
                            styling: 'bootstrap3',
                            delay: 2500
                        });
                    ", true);

                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-error", $@"
                            new PNotify({{
                                title: 'Failed',
                                text: 'Error: {ex.Message.Replace("'", " ")}',
                                type: 'error',
                                styling: 'bootstrap3',
                                delay: 3000
                            }});
                        ", true);
                }
            }
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
