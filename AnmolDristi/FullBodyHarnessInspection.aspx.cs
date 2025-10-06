using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity.Core.Metadata.Edm;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class FullBodyHarnessInspection : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindChecklist(); // ✅ First-time load only
            }
            else
            {
                txtDocNo.Text = hfEmployeeName.Value; // ✅ Restore name
            }
        }

        //Code to fetch the details from backend
        [System.Web.Services.WebMethod]
        public static string GetEmployeeName(string empCode)
        {
            string empName = "";
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT EmployeeName FROM MST_UserMaster WHERE EmployeeCode = @EmployeeCode";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeCode", empCode);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        empName = result.ToString();
                    }
                }
            }

            return empName;
        }




        //[WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        //public static string GetEmployeeName(string inspectionId)
        //{
        //    string employeeName = string.Empty;

        //    string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //    string query = "SELECT EmployeeName FROM [CSMS].[dbo].[InspectionHeader] WHERE InspectedBy = @InspectedBy";

        //    using (SqlConnection conn = new SqlConnection(connStr))
        //    {
        //        SqlCommand cmd = new SqlCommand(query, conn);
        //        cmd.Parameters.AddWithValue("@InspectedBy", inspectionId);  // Assuming inspectionId is the 'InspectedBy'

        //        try
        //        {
        //            conn.Open();
        //            var result = cmd.ExecuteScalar(); // ExecuteScalar will return the first column of the first row
        //            if (result != null)
        //            {
        //                employeeName = result.ToString();
        //            }
        //            else
        //            {
        //                employeeName = "Invalid Inspection ID";  // If no result is found, return an error message
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            // Handle exception and log error if needed
        //            employeeName = "Error occurred while fetching data";  // Return a generic error message
        //        }
        //    }

        //    return employeeName;
        //}

        private void BindChecklist()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));
            dt.Rows.Add(1, "Is the Harness conforming to IS: 3521 & also full body double lanyard type and length is not more than 1.8mtr?");
            dt.Rows.Add(2, "Condition of Lanyard: A) No visible damage B) Burn C) Cut D) Worn/Torn out");
            dt.Rows.Add(3, "Condition of thimble and snap hook: A) No visible damage B) Smooth working of hook");
            dt.Rows.Add(4, "Condition of stitching and buckles: A) Stitching is ok B) Rust free buckles");
            dt.Rows.Add(5, "Condition of D-RINGS: A) Distortion B) Cracks C) Sharp edges D) Break");
            rptsChecklist.DataSource = dt;
            rptsChecklist.DataBind();
        }

        protected void txtInsBy_TextChanged(object sender, EventArgs e)
        {
            string inspectedBy = txtInsBy.Text.Trim();

            if (!string.IsNullOrEmpty(inspectedBy))
            {
                string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = @"SELECT TOP 1 EmployeeName 
                             FROM InspectionHeader 
                             WHERE InspectedBy = @InspectedBy 
                             ORDER BY DateOfInspection DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@InspectedBy", inspectedBy);
                        conn.Open();

                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            txtDocNo.Text = result.ToString();
                        }
                        else
                        {
                            txtDocNo.Text = "";
                            
                        }
                    }
                }
            }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("FullBodyHarnessInspection.aspx");
        }
        private string GenerateHeaderID(int inspectionID)
        {
            return "FBH-" + inspectionID.ToString();
        }


        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            lblMsg.Text = "";

            // Pre-check validations
            if (string.IsNullOrWhiteSpace(txtdate.Text)) { lblMsg.Text = "Please select Date."; return; }
            if (string.IsNullOrWhiteSpace(txtjobID.Text)) { lblMsg.Text = "Please enter Job ID."; return; }
            if (string.IsNullOrWhiteSpace(txtSite.Text)) { lblMsg.Text = "Please enter Site."; return; }
            if (string.IsNullOrWhiteSpace(hfEmployeeName.Value)) { lblMsg.Text = "Employee name is missing."; return; }
            if (string.IsNullOrWhiteSpace(txtInsBy.Text)) { lblMsg.Text = "Please enter Inspected By."; return; }
            if (string.IsNullOrWhiteSpace(txtnote.Text)) { lblMsg.Text = "Please enter Remarks."; return; }
            if (string.IsNullOrWhiteSpace(txtIdentity.Text)) { lblMsg.Text = "Please enter Identity No"; return; }
            if (string.IsNullOrWhiteSpace(txtLoc.Text)) { lblMsg.Text = "Please enter Location"; return; }

            // ✅ Validation for "No" selected rows
            foreach (RepeaterItem item in rptsChecklist.Items)
            {
                RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");
                TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                Label lblDescription = (Label)item.FindControl("lblDescription");

                if (rdoNo != null && rdoNo.Checked)
                {
                    if (txtRemarks != null && string.IsNullOrWhiteSpace(txtRemarks.Text))
                    {
                        lblMsg.Text = $"Please enter remarks for: \"{lblDescription.Text}\".";
                        return;
                    }

                    if (fileUpload != null && !fileUpload.HasFile)
                    {
                        lblMsg.Text = $"Please upload photo for: \"{lblDescription.Text}\".";
                        return;
                    }
                }
            }

            try
            {
                // Save to DB
                string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                string insertHeaderQuery = @"
            INSERT INTO InspectionHeader 
            (EmployeeName, Site, Remarks, JobID, InspectedBy, DateOfInspection)
            OUTPUT INSERTED.InspectionID
            VALUES 
            (@EmployeeName, @Site, @Remarks, @JobID, @InspectedBy, @DateOfInspection)";

                SqlCommand cmdHeader = new SqlCommand(insertHeaderQuery, con);
                cmdHeader.Parameters.AddWithValue("@EmployeeName", hfEmployeeName.Value.Trim());
                cmdHeader.Parameters.AddWithValue("@Site", txtSite.Text.Trim());
                cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text.Trim());
                cmdHeader.Parameters.AddWithValue("@JobID", txtjobID.Text.Trim());
                cmdHeader.Parameters.AddWithValue("@Remarks", txtnote.Text.Trim());
                cmdHeader.Parameters.AddWithValue("@DateOfInspection", Convert.ToDateTime(txtdate.Text.Trim()));

                int inspectionID = (int)cmdHeader.ExecuteScalar();

                SaveChecklistItemsFromRepeater(rptsChecklist, con, inspectionID);

                con.Close();
            }

                // PNotify after successful save
                ShowPNotify("Success", "Data saved successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowPNotify("Error", "Error while saving data: " + ex.Message, "error");
            }
        }

        //protected void BtnSubmit_Click(object sender, EventArgs e)
        //{
        //    lblMsg.Text = "";
        //    if (string.IsNullOrWhiteSpace(txtdate.Text))
        //    {
        //        lblMsg.Text = "Please select Date.";
        //        return;
        //    }
        //    if (string.IsNullOrWhiteSpace(txtjobID.Text))
        //    {
        //        lblMsg.Text = "Please enter Job ID.";
        //        return;
        //    }
        //    if (string.IsNullOrWhiteSpace(txtSite.Text))
        //    {
        //        lblMsg.Text = "Please enter Site.";
        //        return;
        //    }
        //    if (string.IsNullOrWhiteSpace(hfEmployeeName.Value))
        //    {
        //        lblMsg.Text = "Employee name is missing.";
        //        return;
        //    }
        //    if (string.IsNullOrWhiteSpace(txtInsBy.Text))
        //    {
        //        lblMsg.Text = "Please enter Inspected By.";
        //        return;
        //    }
        //    if (string.IsNullOrWhiteSpace(txtnote.Text))
        //    {
        //        lblMsg.Text = "Please enter Remarks.";
        //        return;
        //    }
        //    if (string.IsNullOrWhiteSpace(txtIdentity.Text))
        //    {
        //        lblMsg.Text = "Please enter Identity No";
        //        return;
        //    }
        //    if (string.IsNullOrWhiteSpace(txtLoc.Text))
        //    {
        //        lblMsg.Text = "Please enter Location";
        //        return;
        //    }

        //    string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        //    using (SqlConnection con = new SqlConnection(connStr))
        //    {
        //        con.Open();

        //        // 1. Insert into InspectionHeader
        //        string insertHeaderQuery = @"
        //    INSERT INTO InspectionHeader 
        //    (EmployeeName, Site, Remarks, JobID, InspectedBy, DateOfInspection)
        //    OUTPUT INSERTED.InspectionID
        //    VALUES 
        //    (@EmployeeName, @Site, @Remarks, @JobID, @InspectedBy, @DateOfInspection)";

        //        SqlCommand cmdHeader = new SqlCommand(insertHeaderQuery, con);
        //        cmdHeader.Parameters.AddWithValue("@EmployeeName", hfEmployeeName.Value.Trim());
        //        cmdHeader.Parameters.AddWithValue("@Site", txtSite.Text.Trim());
        //        cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text.Trim());
        //        cmdHeader.Parameters.AddWithValue("@JobID", txtjobID.Text.Trim());
        //        cmdHeader.Parameters.AddWithValue("@Remarks", txtnote.Text.Trim());
        //        cmdHeader.Parameters.AddWithValue("@DateOfInspection", Convert.ToDateTime(txtdate.Text.Trim()));

        //        int inspectionID = (int)cmdHeader.ExecuteScalar(); // ✅ Executes insert and returns ID

        //        // 2. Save checklist items
        //        SaveChecklistItemsFromRepeater(rptsChecklist, con, inspectionID);

        //        con.Close();
        //    }

        //    lblMsg.Text = "Data saved successfully!";
        //}
        private void SaveChecklistItemsFromRepeater(Repeater rpt, SqlConnection con, int inspectionID)
        {
            using (SqlTransaction tran = con.BeginTransaction())
            {
                try
                {
                    foreach (RepeaterItem item in rpt.Items)
                    {
                        int questionNumber = 0;
                        HiddenField hfQuestionNumber = (HiddenField)item.FindControl("hfQuestionNumber");
                        if (hfQuestionNumber != null && !string.IsNullOrWhiteSpace(hfQuestionNumber.Value))
                        {
                            int.TryParse(hfQuestionNumber.Value, out questionNumber);
                        }

                        RadioButton rdoYes = (RadioButton)item.FindControl("rdoYes");
                        RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");
                        RadioButton rdoNA = (RadioButton)item.FindControl("rdoNA");
                        TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                        FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                        CheckBox chkCapaReport = (CheckBox)item.FindControl("chkCapaReport");
                        Label lblDescription = (Label)item.FindControl("lblDescription");

                        // --- Generate HeaderID ---
                        string headerID = GenerateHeaderID(inspectionID);

                        // --- Determine status ---
                        string status = ""; 
                        if (rdoYes != null && rdoYes.Checked)
                        {
                            status = "Yes";
                        }
                        else if (rdoNo != null && rdoNo.Checked)
                        {
                            status = "No";
                        }
                        else if (rdoNA != null && rdoNA.Checked)
                        {
                            status = "NA";
                        }

                        // --- Convert to DB value for single column IsOk ---
                        object isOkValue = status == "Yes" ? 1
                                          : status == "No" ? 0
                                          : (object)DBNull.Value; // NA


                        string remarks = txtRemarks?.Text ?? "";
                        string description = lblDescription?.Text ?? "";

                        string checklistPhotoPath = "";
                        if (fileUpload != null && fileUpload.HasFile)
                        {
                            string fileName = Path.GetFileName(fileUpload.FileName);
                            string savePath = Server.MapPath("~/Uploads1/" + fileName);
                            fileUpload.SaveAs(savePath);
                            checklistPhotoPath = "~/Uploads1/" + fileName;
                        }

                        object capaReportID = DBNull.Value;

                        if (chkCapaReport != null && chkCapaReport.Checked)
                        {
                            SqlCommand cmdCAPA = new SqlCommand(@"
                        INSERT INTO tbl_CAPAMaster 
                        (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate,Description)
                        OUTPUT INSERTED.CAPAID
                        VALUES 
                        (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate,@Description)", con, tran);

                            cmdCAPA.Parameters.AddWithValue("@HeaderID", headerID);
                            cmdCAPA.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                            cmdCAPA.Parameters.AddWithValue("@Remarks", remarks);
                            cmdCAPA.Parameters.AddWithValue("@AssignedBy", Session["UserName"]?.ToString() ?? "");
                            cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                            cmdCAPA.Parameters.AddWithValue("@Description", lblDescription.Text);


                            capaReportID = cmdCAPA.ExecuteScalar(); // Get the newly inserted CAPAID
                        }

                        // ✅ Fix: Add connection and transaction to the SqlCommand
                        SqlCommand cmdChecklist = new SqlCommand(@"
                    INSERT INTO InspectionChecklist 
                    (Location, InspectionNo, InspectionID, QuestionNumber, IsOk, Remarks, PhotoPath, HeaderID, Capa_Report, Description)
                    VALUES 
                    (@Location, @InspectionNo, @InspectionID, @QuestionNumber, @IsOk, @Remarks, @PhotoPath, @HeaderID, @CapaReport, @Description)", con, tran);

                        cmdChecklist.Parameters.AddWithValue("@Location", txtLoc.Text.Trim());
                        cmdChecklist.Parameters.AddWithValue("@InspectionNo", txtIdentity.Text.Trim());
                        cmdChecklist.Parameters.AddWithValue("@InspectionID", inspectionID);
                        cmdChecklist.Parameters.AddWithValue("@QuestionNumber", questionNumber);
                        cmdChecklist.Parameters.AddWithValue("@IsOk", isOkValue);
                        //cmdChecklist.Parameters.AddWithValue("@NA", na);
                        cmdChecklist.Parameters.AddWithValue("@Remarks", remarks);
                        cmdChecklist.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                        cmdChecklist.Parameters.AddWithValue("@HeaderID", headerID);
                        cmdChecklist.Parameters.AddWithValue("@CapaReport", capaReportID);
                        cmdChecklist.Parameters.AddWithValue("@Description", description);

                        cmdChecklist.ExecuteNonQuery();
                    }

                    tran.Commit();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    throw new Exception("Failed to save checklist items: " + ex.Message);
                }
            }
        }

        private void ShowPNotify(string title, string message, string type)
        {
            string script = $@"
        new PNotify({{
            title: '{title}',
            text: '{message}',
            type: '{type}',  // success | error | info | notice
            styling: 'bootstrap3',
            delay: 2500,
            addclass: 'stack-topright'
        }});";

            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), script, true);
        }



    }
}