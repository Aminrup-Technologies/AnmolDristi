using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection.Emit;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;
using System.Diagnostics;
using static System.Net.Mime.MediaTypeNames;


namespace AnmolDristi
{
    public partial class FireExtinguisherChecklist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindChecklist();
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetEmployeeName(string inspectionId)
        {
            string employeeName = string.Empty;

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string query = "SELECT EmployeeName FROM [CSMS].[dbo].[FireExtinguisherHeader] WHERE InspectedBy = @InspectedBy";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@InspectedBy", inspectionId);

                try
                {
                    conn.Open();
                    var result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        employeeName = result.ToString();
                    }
                    else
                    {
                        employeeName = "Invalid Inspection ID";
                    }
                }
                catch
                {
                    employeeName = "Error occurred while fetching data";
                }
            }

            return employeeName;
        }


        private void BindChecklist()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));
            dt.Rows.Add(1, "Nozzle (house) Condition.");
            dt.Rows.Add(2, "Is the pin in place.");
            dt.Rows.Add(3, "Does the gauge show in the green.");
            dt.Rows.Add(4, "Tag attached.");
            dt.Rows.Add(5, "Body Condition.");
            rptChecklist.DataSource = dt;
            rptChecklist.DataBind();
        }
        protected void rptChecklist_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                RadioButton rdoYes = (RadioButton)e.Item.FindControl("rdoYes");
                RadioButton rdoNo = (RadioButton)e.Item.FindControl("rdoNo");
                RadioButton rdoNA = (RadioButton)e.Item.FindControl("rdoNA");

                if (rdoYes != null)
                {
                    rdoYes.InputAttributes.Add("value", "Yes");
                    rdoYes.Attributes.Add("onclick", "toggleFields(this);");
                }

                if (rdoNo != null)
                {
                    rdoNo.InputAttributes.Add("value", "No");
                    rdoNo.Attributes.Add("onclick", "toggleFields(this);");
                }

                if (rdoNA != null)
                {
                    rdoNA.InputAttributes.Add("value", "NA");
                    rdoNA.Attributes.Add("onclick", "toggleFields(this);");
                }
            }
        }

        private string GenerateFABHeaderID()
        {
            string id = "";
            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT dbo.GenerateFABHeaderID()", con))
                {
                    con.Open();
                    id = cmd.ExecuteScalar().ToString();
                }
            }
            return id;
        }

        //private string GenerateCapaaReportID(SqlConnection con, SqlTransaction tran)
        //{
        //    string query = "SELECT COUNT(*) FROM FireExtinguisherChecklist WHERE CAPA_Report IS NOT NULL";

        //    using (SqlCommand cmd = new SqlCommand(query, con, tran))
        //    {
        //        object result = cmd.ExecuteScalar();

        //        int count = 0;

        //        if (result != null && result != DBNull.Value)
        //        {
        //            count = Convert.ToInt32(result);
        //        }
        //        return $"CAPA-{count + 1:D3}";

        //    }
        //}


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMsg.Text = "";
            if (string.IsNullOrWhiteSpace(txtdate.Text))
            {
                lblMsg.Text = "Please select Date.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtjobId.Text))
            {
                lblMsg.Text = "Please enter Job ID.";
                return;
            }
            //if (!System.Text.RegularExpressions.Regex.IsMatch(txtjobId.Text.Trim(), @"^\d+$"))
            //{
            //    lblMsg.Text = "Job ID must contain digits only.";
            //    return;
            //}
            if (string.IsNullOrWhiteSpace(txtloc.Text))
            {
                lblMsg.Text = "Please enter Location.";
                return;
            }
            if (string.IsNullOrWhiteSpace(hfEmployeeName.Value))
            {
                lblMsg.Text = "Employee name is missing.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtInsBy.Text))
            {
                lblMsg.Text = "Please enter Inspected By.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtnote.Text))
            {
                lblMsg.Text = "Please enter Remarks.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtCalibrationDate.Text))
            {
                lblMsg.Text = "Please enter Calibration Date.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtsno.Text))
            {
                lblMsg.Text = "Please enter FE Serial Number.";
                return;
            }
            if (string.IsNullOrWhiteSpace(ddlType.Text))
            {
                lblMsg.Text = "Please enter  Extinguisher Type.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtDueDate.Text))
            {
                lblMsg.Text = "Please enter Due Date.";
                return;
            }

            // ✅ Validation for "No" selected rows
            foreach (RepeaterItem item in rptChecklist.Items)
            {
                RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");
                TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                //Label lblDescription = (Label)item.FindControl("lblDescription");
                System.Web.UI.WebControls.Label lblDescription = (System.Web.UI.WebControls.Label)item.FindControl("lblDescription");

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

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // 1. Generate unique string ID for Header
                string headerID = GenerateFABHeaderID();

                string insertHeaderQuery = @"
                    INSERT INTO FireExtinguisherHeader 
                   (HeaderID, ChecklistDate, JobID, Location, EmployeeName, InspectedBy, Remarks)
                    VALUES 
                     (@HeaderID, @ChecklistDate, @JobID, @Location, @EmployeeName, @InspectedBy, @Remarks)";

                SqlCommand cmdHeader = new SqlCommand(insertHeaderQuery, con);
                cmdHeader.Parameters.AddWithValue("@HeaderID", headerID);
                cmdHeader.Parameters.AddWithValue("@ChecklistDate", Convert.ToDateTime(txtdate.Text));
                cmdHeader.Parameters.AddWithValue("@JobID", txtjobId.Text);
                cmdHeader.Parameters.AddWithValue("@Location", txtloc.Text);
                cmdHeader.Parameters.AddWithValue("@EmployeeName", hfEmployeeName.Value.Trim());
                cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text);
                cmdHeader.Parameters.AddWithValue("@Remarks", txtnote.Text);

                
                cmdHeader.ExecuteNonQuery();

                // 2. Save checklist items with reference to the inserted header
                SaveChecklistItemsFromRepeater(rptChecklist, con, headerID);

                con.Close();
            }



            lblMsg.Text = "Data saved successfully!";
            
        }
        private void SaveChecklistItemsFromRepeater(Repeater rpt, SqlConnection con, string headerID)
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
                        RadioButton rdoNA = (RadioButton)item.FindControl("rdoNA");
                        TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                        FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                        //CheckBox chkCapaReport = (CheckBox)item.FindControl("chkCapaReport");
                        CheckBox chkCapaReport = (CheckBox)item.FindControl("chkCapaReport");
                        System.Web.UI.WebControls.Label lblDescription = (System.Web.UI.WebControls.Label)item.FindControl("lblDescription");

                        bool isOk = rdoYes != null && rdoYes.Checked;
                        bool na = rdoNA != null && rdoNA.Checked;
                        string remarks = txtRemarks?.Text ?? "";
                        string description = lblDescription?.Text ?? "";
                        //  string photoPath = "";

                        // Handle file upload
                        //if (fileUpload != null && fileUpload.HasFile)
                        //{
                        //    string fileName = Path.GetFileName(fileUpload.FileName);
                        //    string savePath = Server.MapPath("~/Uploads1/" + fileName);
                        //    fileUpload.SaveAs(savePath);
                        //    photoPath = "~/Uploads1/" + fileName;
                        //}
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
                        (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate)
                        OUTPUT INSERTED.CAPAID
                        VALUES 
                        (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate)", con, tran);

                            cmdCAPA.Parameters.AddWithValue("@HeaderID", headerID);
                            cmdCAPA.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                            cmdCAPA.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
                            cmdCAPA.Parameters.AddWithValue("@AssignedBy", txtInsBy.Text.Trim());
                            cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                            capaReportID = cmdCAPA.ExecuteScalar(); // Get the newly inserted CAPAID
                        }
                        // ✅ Generate CAPA Report only when checkbox checked
                        //string capaReportID = null;
                        //if (chkCapaReport != null && chkCapaReport.Checked)
                        //{
                        //    capaReportID = GenerateCapaaReportID(con, tran);
                        //}

                        string insertDetailQuery = @"
                INSERT INTO FireExtinguisherChecklist 
                (HeaderID, ExtinguisherType, FE_SerialNo, CalibrationDate, DueDate, 
                 QuestionNumber, IsOk, Remarks, PhotoPath, NA, Description, CAPA_Report)
                VALUES 
                (@HeaderID, @ExtinguisherType, @FE_SerialNo, @CalibrationDate, @DueDate, 
                 @QuestionNumber, @IsOk, @Remarks, @PhotoPath, @NA, @Description, @CAPA_Report)";

                        SqlCommand cmdDetail = new SqlCommand(insertDetailQuery, con, tran);
                        cmdDetail.Parameters.AddWithValue("@HeaderID", headerID);
                        cmdDetail.Parameters.AddWithValue("@ExtinguisherType", ddlType.SelectedValue);
                        cmdDetail.Parameters.AddWithValue("@FE_SerialNo", Convert.ToInt32(txtsno.Text));
                        cmdDetail.Parameters.AddWithValue("@CalibrationDate", Convert.ToDateTime(txtCalibrationDate.Text));
                        cmdDetail.Parameters.AddWithValue("@DueDate", Convert.ToDateTime(txtDueDate.Text));
                        cmdDetail.Parameters.AddWithValue("@QuestionNumber", questionNumber);
                        cmdDetail.Parameters.AddWithValue("@IsOk", isOk);
                        cmdDetail.Parameters.AddWithValue("@Remarks", remarks);
                       // cmdDetail.Parameters.AddWithValue("@PhotoPath", photoPath);
                        cmdDetail.Parameters.AddWithValue("@NA", na);
                        cmdDetail.Parameters.AddWithValue("@Description", description);
                        cmdDetail.Parameters.AddWithValue("@Capa_Report", capaReportID);
                        cmdDetail.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                        //cmdDetail.Parameters.AddWithValue("@CAPA_Report", string.IsNullOrEmpty(capaReportID) ? (object)DBNull.Value : capaReportID);
                        //if (!string.IsNullOrEmpty(capaReportID))
                        //{
                        //    cmdDetail.Parameters.AddWithValue("@CAPA_Report", capaReportID);
                        //}
                        //else
                        //{
                        //    // Ensure null is passed explicitly to avoid duplicate NULLs violating unique constraint
                        //    cmdDetail.Parameters.AddWithValue("@CAPA_Report", DBNull.Value);
                        //}

                        cmdDetail.ExecuteNonQuery();
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






        //private void SaveChecklistItemsFromRepeater(Repeater rpt, SqlConnection con, string headerID)
        //{
        //    foreach (RepeaterItem item in rpt.Items)
        //    {

        //        HiddenField hfQuestionNumber = (HiddenField)item.FindControl("hfQuestionNumber");
        //        int questionNumber = Convert.ToInt32(hfQuestionNumber.Value);

        //        int qn = 0;
        //        if (hfQuestionNumber != null && int.TryParse(hfQuestionNumber.Value, out qn))
        //        {
        //            questionNumber = qn;
        //        }


        //        RadioButton rdoYes = (RadioButton)item.FindControl("rdoYes");
        //        RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");
        //        RadioButton rdoNA = (RadioButton)item.FindControl("rdoNA");

        //        TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
        //        FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");

        //        bool isOk = rdoYes != null && rdoYes.Checked;
        //        bool na = rdoNA != null && rdoNA.Checked;

        //        string remarks = txtRemarks?.Text ?? "";
        //        string photoPath = "";

        //        if (fileUpload != null && fileUpload.HasFile)
        //        {
        //            string fileName = Path.GetFileName(fileUpload.FileName);
        //            string savePath = Server.MapPath("~/Uploads1/" + fileName);
        //            fileUpload.SaveAs(savePath);
        //            photoPath = "~/Uploads1/" + fileName;
        //        }
        //        //Label lblDescription = (Label)item.FindControl("lblDescription");
        //        System.Web.UI.WebControls.Label lblDescription = (System.Web.UI.WebControls.Label)item.FindControl("lblDescription");
        //        string description = lblDescription?.Text ?? "";



        //        string insertDetailQuery = @"
        //    INSERT INTO FireExtinguisherChecklist (HeaderID,ExtinguisherType,FE_SerialNo,CalibrationDate,DueDate, QuestionNumber, IsOk, Remarks, PhotoPath, NA,description)
        //    VALUES (@HeaderID,@ExtinguisherType,@FE_SerialNo,@CalibrationDate,@DueDate, @QuestionNumber, @IsOk, @Remarks, @PhotoPath, @NA,@description)";

        //        SqlCommand cmdDetail = new SqlCommand(insertDetailQuery, con);
        //        cmdDetail.Parameters.AddWithValue("@HeaderID", headerID);
        //        cmdDetail.Parameters.AddWithValue("@ExtinguisherType", ddlType.SelectedValue);
        //        cmdDetail.Parameters.AddWithValue("@FE_SerialNo", txtsno.Text);
        //        cmdDetail.Parameters.AddWithValue("@CalibrationDate", Convert.ToDateTime(txtCalibrationDate.Text));
        //        cmdDetail.Parameters.AddWithValue("@DueDate", Convert.ToDateTime(txtDueDate.Text));    
        //        cmdDetail.Parameters.AddWithValue("@QuestionNumber", questionNumber);
        //        cmdDetail.Parameters.AddWithValue("@IsOk", isOk);
        //        cmdDetail.Parameters.AddWithValue("@Remarks", remarks);
        //        cmdDetail.Parameters.AddWithValue("@PhotoPath", photoPath);
        //        cmdDetail.Parameters.AddWithValue("@NA", na);
        //        cmdDetail.Parameters.AddWithValue("@description", description);
        //        cmdDetail.ExecuteNonQuery();
        //    }
        //}

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("FireExtinguisherChecklist.aspx");
        }
    }
}