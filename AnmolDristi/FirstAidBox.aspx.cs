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
using System.Data.Entity.Core.Metadata.Edm;


namespace AnmolDristi
{
    public partial class FirstAidBox : System.Web.UI.Page
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
            string query = "SELECT EmployeeName FROM [CSMS].[dbo].[FirstAidInspectionHeader] WHERE InspectedBy = @InspectedBy";

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
            dt.Rows.Add(1, "Is Any Expired Item?");
            rptChecklist.DataSource = dt;
            rptChecklist.DataBind();
        }
        protected void btnAddIssues_Click(object sender, EventArgs e)
        {
            lblMsg2.Text = "";
            DataTable dts;
            if (ViewState["Issues"] == null)
            {
                dts = new DataTable();
                dts.Columns.Add("SNo");
                dts.Columns.Add("ItemName");
                dts.Columns.Add("Quantity");
                dts.Columns.Add("ExpiryDate");
                dts.Columns.Add("LastRefilledDate");
                dts.Columns.Add("NextRefillDueDate");
            }
            else
            {
                dts = (DataTable)ViewState["Issues"];
            }
            // Generating SNo dynamically
            int serialNo = dts.Rows.Count + 1;

            DataRow dr = dts.NewRow();
            dr["SNo"] = serialNo;
            dr["ItemName"] = txtItemName.Text.Trim();
            dr["Quantity"] = txtQuantity.Text.Trim();
            dr["ExpiryDate"] = txtExpiryDate.Text.Trim();
            dr["LastRefilledDate"] = txtLastRefilledDate.Text.Trim();
            dr["NextRefillDueDate"] = txtNextRefillDueDate.Text.Trim();
            dts.Rows.Add(dr);

            ViewState["Issues"] = dts;
            gvIssues.DataSource = dts;
            gvIssues.DataBind();

            // Clear input fields for next attendee
            txtItemName.Text = "";
            txtQuantity.Text = "";
            txtExpiryDate.Text = "";
            txtLastRefilledDate.Text = "";
            txtNextRefillDueDate.Text = "";
         
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "showSuccessMessages();", true);

        }
        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            if (gvIssues.DataKeys.Count == 0 || row.RowIndex < 0 || row.RowIndex >= gvIssues.DataKeys.Count)
            {
                return; // Prevent out-of-range errors
            }

            int sNo = Convert.ToInt32(gvIssues.DataKeys[row.RowIndex].Value);
            DataTable dts = ViewState["Issues"] as DataTable;

            if (dts != null)
            {
                DataRow[] rows = dts.Select("SNo=" + sNo);
                if (rows.Length > 0)
                {
                    dts.Rows.Remove(rows[0]);
                    dts.AcceptChanges();
                }

                // **Renumber SNo** after deletion
                for (int i = 0; i < dts.Rows.Count; i++)
                {
                    dts.Rows[i]["SNo"] = i + 1; // Reset SNo from 1 to N
                }

                if (dts.Rows.Count == 0)
                {
                    ViewState["Issues"] = null;
                    gvIssues.DataSource = null;
                    gvIssues.DataBind();
                }
                else
                {
                    ViewState["Issues"] = dts;
                    gvIssues.DataSource = dts;
                    gvIssues.DataBind();
                }
            }
        }

        private string GenerateFABInspectionID()
        {
            string id = "";
            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT dbo.GenerateFABInspectionID()", con))
                {
                    con.Open();
                    id = cmd.ExecuteScalar().ToString();
                }
            }
            return id;
        }


        //private string GenerateCapaReportID(SqlConnection con, SqlTransaction tran)
        //{
        //    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM FirstAidChecklist WHERE Capa_Report IS NOT NULL", con, tran);
        //    int count = (int)cmd.ExecuteScalar();
        //    //return $"CAPA-{(count + 1).ToString("D3")}";
        //    return $"CAPA-{count + 1:D3}";

        //}



        //protected void BtnSubmit_Click(object sender, EventArgs e)
        //{
        //    string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //    using (SqlConnection con = new SqlConnection(connStr))
        //    {
        //        con.Open();
        //        SqlTransaction tran = con.BeginTransaction();

        //        try
        //        {
        //            // 1. Upload FirstAidBox image
        //            string photoPath = "";
        //            if (imgupload.HasFile)
        //            {
        //                string fileName = Path.GetFileName(imgupload.FileName);
        //                string folderPath = Server.MapPath("~/Uploads1/");
        //                if (!Directory.Exists(folderPath))
        //                {
        //                    Directory.CreateDirectory(folderPath);
        //                }

        //                string filePath = folderPath + fileName;
        //                imgupload.SaveAs(filePath);
        //                photoPath = "~/Uploads1/" + fileName;
        //            }

        //            string inspectionID = GenerateFABInspectionID();
        //            string insertHeaderQuery = @"
        //        INSERT INTO FirstAidInspectionHeader 
        //        (InspectionID, Location, InspectionDate, InspectedBy, EmployeeName, Remarks, TotalItemCount, PhotoPath) 
        //        VALUES 
        //        (@InspectionID, @Location, @InspectionDate, @InspectedBy, @EmployeeName, @Remarks, @TotalItemCount, @PhotoPath)";

        //            SqlCommand cmdHeader = new SqlCommand(insertHeaderQuery, con, tran);
        //            cmdHeader.Parameters.AddWithValue("@InspectionID", inspectionID);
        //            cmdHeader.Parameters.AddWithValue("@Location", txtVenue.Text.Trim());
        //            cmdHeader.Parameters.AddWithValue("@InspectionDate", Convert.ToDateTime(txtdate.Text));
        //            cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text.Trim());
        //            cmdHeader.Parameters.AddWithValue("@EmployeeName", txtDocNo.Text.Trim());
        //            cmdHeader.Parameters.AddWithValue("@Remarks", txtnote.Text.Trim());

        //            DataTable dtIssues = ViewState["Issues"] as DataTable;
        //            int itemCount = 0;
        //            if (dtIssues != null)
        //            {
        //                foreach (DataRow row in dtIssues.Rows)
        //                {
        //                    int qty;
        //                    if (int.TryParse(row["Quantity"].ToString(), out qty))
        //                    {
        //                        itemCount += qty;
        //                    }
        //                }
        //            }
        //            cmdHeader.Parameters.AddWithValue("@TotalItemCount", itemCount);
        //            cmdHeader.Parameters.AddWithValue("@PhotoPath", photoPath);

        //            cmdHeader.ExecuteNonQuery();

        //            // Insert into FirstAidItemDetails
        //            if (dtIssues != null && dtIssues.Rows.Count > 0)
        //            {
        //                foreach (DataRow row in dtIssues.Rows)
        //                {
        //                    string insertDetailQuery = @"INSERT INTO FirstAidItemDetails 
        //                (InspectionID, ItemName, Quantity, ExpiryDate, LastRefilledDate, NextRefillDueDate)
        //                VALUES (@InspectionID, @ItemName, @Quantity, @ExpiryDate, @LastRefilledDate, @NextRefillDueDate)";

        //                    SqlCommand cmdDetail = new SqlCommand(insertDetailQuery, con, tran);
        //                    cmdDetail.Parameters.AddWithValue("@InspectionID", inspectionID);
        //                    cmdDetail.Parameters.AddWithValue("@ItemName", row["ItemName"].ToString());
        //                    cmdDetail.Parameters.AddWithValue("@Quantity", Convert.ToInt32(row["Quantity"]));
        //                    cmdDetail.Parameters.AddWithValue("@ExpiryDate", Convert.ToDateTime(row["ExpiryDate"]));
        //                    cmdDetail.Parameters.AddWithValue("@LastRefilledDate", Convert.ToDateTime(row["LastRefilledDate"]));
        //                    cmdDetail.Parameters.AddWithValue("@NextRefillDueDate", Convert.ToDateTime(row["NextRefillDueDate"]));
        //                    cmdDetail.ExecuteNonQuery();
        //                }
        //            }

        //            // Insert checklist entries
        //            foreach (RepeaterItem item in rptChecklist.Items)
        //            {
        //                HiddenField hfQNo = (HiddenField)item.FindControl("hfQuestionNumber");
        //                System.Web.UI.WebControls.Label lblDesc = (System.Web.UI.WebControls.Label)item.FindControl("lblDescription");
        //                RadioButton rdoYes = (RadioButton)item.FindControl("rdoYes");
        //                TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
        //                FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
        //                CheckBox chkCapaReport = (CheckBox)item.FindControl("chkCapaReport");

        //                bool isOK = rdoYes.Checked;
        //                string checklistPhotoPath = "";
        //                string capaReportID = null;

        //                // Upload checklist photo
        //                if (fileUpload.HasFile)
        //                {
        //                    string fileName = Path.GetFileName(fileUpload.FileName);
        //                    string folderPath = Server.MapPath("~/Uploads1/");
        //                    if (!Directory.Exists(folderPath))
        //                    {
        //                        Directory.CreateDirectory(folderPath);
        //                    }

        //                    string filePath = folderPath + fileName;
        //                    fileUpload.SaveAs(filePath);
        //                    checklistPhotoPath = "~/Uploads1/" + fileName;
        //                }

        //                // Generate and insert CAPA entry if checkbox checked
        //                if (chkCapaReport != null && chkCapaReport.Checked)
        //                {
        //                    capaReportID = GenerateCapaReportID(con, tran);

        //                    // Insert into tbl_CAPAMaster
        //                    SqlCommand cmdCAPA = new SqlCommand(@"
        //                INSERT INTO tbl_CAPAMaster 
        //                (CAPAID, HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate)
        //                VALUES 
        //                (@CAPAID, @HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate)", con, tran);

        //                    cmdCAPA.Parameters.AddWithValue("@CAPAID", capaReportID);
        //                    cmdCAPA.Parameters.AddWithValue("@HeaderID", inspectionID);
        //                    cmdCAPA.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
        //                    cmdCAPA.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
        //                    cmdCAPA.Parameters.AddWithValue("@AssignedBy", txtInsBy.Text.Trim());
        //                    cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

        //                    cmdCAPA.ExecuteNonQuery();
        //                }

        //                // Insert checklist row
        //                SqlCommand cmdChecklist = new SqlCommand(@"
        //            INSERT INTO FirstAidChecklist 
        //            (InspectionID, QuestionNumber, Description, IsOK, ItemName, PhotoPath, Capa_Report) 
        //            VALUES 
        //            (@InspectionID, @QuestionNumber, @Description, @IsOK, @ItemName, @PhotoPath, @Capa_Report)", con, tran);

        //                cmdChecklist.Parameters.AddWithValue("@InspectionID", inspectionID);
        //                cmdChecklist.Parameters.AddWithValue("@QuestionNumber", Convert.ToInt32(hfQNo.Value));
        //                cmdChecklist.Parameters.AddWithValue("@Description", lblDesc.Text);
        //                cmdChecklist.Parameters.AddWithValue("@IsOK", isOK);
        //                cmdChecklist.Parameters.AddWithValue("@ItemName", txtRemarks.Text.Trim());
        //                cmdChecklist.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);

        //                if (!string.IsNullOrEmpty(capaReportID))
        //                    cmdChecklist.Parameters.AddWithValue("@Capa_Report", capaReportID);
        //                else
        //                    cmdChecklist.Parameters.AddWithValue("@Capa_Report", DBNull.Value);

        //                cmdChecklist.ExecuteNonQuery();
        //            }

        //            tran.Commit();
        //            lblMsg.Text = "Data saved successfully!";
        //            lblMsg.ForeColor = System.Drawing.Color.Green;
        //        }
        //        catch (Exception ex)
        //        {
        //            tran.Rollback();
        //            lblMsg.Text = "Error: " + ex.Message;
        //            lblMsg.ForeColor = System.Drawing.Color.Red;
        //        }
        //    }
        //}






        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            lblMsg.Text = "";
            lblMsg2.Text = "";
            
            
            if (string.IsNullOrWhiteSpace(txtdate.Text))
            {
                lblMsg.Text = "Please select Date.";
                return;
            }
           
            if (string.IsNullOrWhiteSpace(txtVenue.Text))
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
            if (string.IsNullOrWhiteSpace(txtnote.Text))
            {
                lblMsg.Text = "Please enter Remarks.";
                return;
            }
            if (string.IsNullOrWhiteSpace(imgupload.PostedFile.FileName))
            {
                lblMsg.Text = "Please upload image.";
                return;
            }
            bool hasError = false;
            if (ViewState["Issues"] == null)
            {
                lblMsg.Text = "No Items to Save";
                lblMsg2.Text = "Please Add Items";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg2.ForeColor = System.Drawing.Color.Red;
                hasError = true;
            }
            if (hasError)
            {
                BtnSubmit.Enabled = true; // Re-enable button
                return;
            }
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlTransaction tran = con.BeginTransaction();

                try
                {
                    // 1. Upload FirstAidBox image
                    string photoPath = "";
                    if (imgupload.HasFile)
                    {
                        string fileName = Path.GetFileName(imgupload.FileName);
                        string folderPath = Server.MapPath("~/Uploads1/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        string filePath = folderPath + fileName;
                        imgupload.SaveAs(filePath);
                        photoPath = "~/Uploads1/" + fileName;
                    }

                    string inspectionID = GenerateFABInspectionID();

                    string insertHeaderQuery = @"
                INSERT INTO FirstAidInspectionHeader 
                (InspectionID, Location, InspectionDate, InspectedBy, EmployeeName, Remarks, TotalItemCount, PhotoPath) 
                VALUES 
                (@InspectionID, @Location, @InspectionDate, @InspectedBy, @EmployeeName, @Remarks, @TotalItemCount, @PhotoPath)";

                    SqlCommand cmdHeader = new SqlCommand(insertHeaderQuery, con, tran);
                    cmdHeader.Parameters.AddWithValue("@InspectionID", inspectionID);
                    cmdHeader.Parameters.AddWithValue("@Location", txtVenue.Text.Trim());
                    cmdHeader.Parameters.AddWithValue("@InspectionDate", Convert.ToDateTime(txtdate.Text));
                    cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text.Trim());
                    cmdHeader.Parameters.AddWithValue("@EmployeeName", hfEmployeeName.Value.Trim());
                    cmdHeader.Parameters.AddWithValue("@Remarks", txtnote.Text.Trim());

                    DataTable dtIssues = ViewState["Issues"] as DataTable;
                    int itemCount = 0;
                    if (dtIssues != null)
                    {
                        foreach (DataRow row in dtIssues.Rows)
                        {
                            int qty;
                            if (int.TryParse(row["Quantity"].ToString(), out qty))
                            {
                                itemCount += qty;
                            }
                        }
                    }
                    cmdHeader.Parameters.AddWithValue("@TotalItemCount", itemCount);
                    cmdHeader.Parameters.AddWithValue("@PhotoPath", photoPath);

                    cmdHeader.ExecuteNonQuery();

                    // 2. Insert into FirstAidItemDetails
                    if (dtIssues != null && dtIssues.Rows.Count > 0)
                    {
                        foreach (DataRow row in dtIssues.Rows)
                        {
                            string insertDetailQuery = @"INSERT INTO FirstAidItemDetails 
                        (InspectionID, ItemName, Quantity, ExpiryDate, LastRefilledDate, NextRefillDueDate)
                        VALUES (@InspectionID, @ItemName, @Quantity, @ExpiryDate, @LastRefilledDate, @NextRefillDueDate)";

                            SqlCommand cmdDetail = new SqlCommand(insertDetailQuery, con, tran);
                            cmdDetail.Parameters.AddWithValue("@InspectionID", inspectionID);
                            cmdDetail.Parameters.AddWithValue("@ItemName", row["ItemName"].ToString());
                            cmdDetail.Parameters.AddWithValue("@Quantity", Convert.ToInt32(row["Quantity"]));
                            cmdDetail.Parameters.AddWithValue("@ExpiryDate", Convert.ToDateTime(row["ExpiryDate"]));
                            cmdDetail.Parameters.AddWithValue("@LastRefilledDate", Convert.ToDateTime(row["LastRefilledDate"]));
                            cmdDetail.Parameters.AddWithValue("@NextRefillDueDate", Convert.ToDateTime(row["NextRefillDueDate"]));
                            cmdDetail.ExecuteNonQuery();
                        }
                    }

                    // 3. Insert checklist entries
                    foreach (RepeaterItem item in rptChecklist.Items)
                    {
                        HiddenField hfQNo = (HiddenField)item.FindControl("hfQuestionNumber");
                        System.Web.UI.WebControls.Label lblDesc = (System.Web.UI.WebControls.Label)item.FindControl("lblDescription");
                        RadioButton rdoYes = (RadioButton)item.FindControl("rdoYes");
                        TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                        FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                        CheckBox chkCapaReport = (CheckBox)item.FindControl("chkCapaReport");

                        bool isOK = rdoYes.Checked;
                        string checklistPhotoPath = "";
                        object capaReportID = DBNull.Value;

                        // Upload checklist photo
                        if (fileUpload.HasFile)
                        {
                            string fileName = Path.GetFileName(fileUpload.FileName);
                            string folderPath = Server.MapPath("~/Uploads1/");
                            if (!Directory.Exists(folderPath))
                            {
                                Directory.CreateDirectory(folderPath);
                            }

                            string filePath = folderPath + fileName;
                            fileUpload.SaveAs(filePath);
                            checklistPhotoPath = "~/Uploads1/" + fileName;
                        }

                        // If CAPA checkbox is checked, insert CAPA and get generated ID
                        if (chkCapaReport != null && chkCapaReport.Checked)
                        {
                            SqlCommand cmdCAPA = new SqlCommand(@"
                        INSERT INTO tbl_CAPAMaster 
                        (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate)
                        OUTPUT INSERTED.CAPAID
                        VALUES 
                        (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate)", con, tran);

                            cmdCAPA.Parameters.AddWithValue("@HeaderID", inspectionID);
                            cmdCAPA.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                            cmdCAPA.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
                            cmdCAPA.Parameters.AddWithValue("@AssignedBy", txtInsBy.Text.Trim());
                            cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                            capaReportID = cmdCAPA.ExecuteScalar(); // Get the newly inserted CAPAID
                        }

                        // Insert checklist row with or without CAPA_Report
                        SqlCommand cmdChecklist = new SqlCommand(@"
                    INSERT INTO FirstAidChecklist 
                    (InspectionID, QuestionNumber, Description, IsOK, ItemName, PhotoPath, Capa_Report) 
                    VALUES 
                    (@InspectionID, @QuestionNumber, @Description, @IsOK, @ItemName, @PhotoPath, @Capa_Report)", con, tran);

                        cmdChecklist.Parameters.AddWithValue("@InspectionID", inspectionID);
                        cmdChecklist.Parameters.AddWithValue("@QuestionNumber", Convert.ToInt32(hfQNo.Value));
                        cmdChecklist.Parameters.AddWithValue("@Description", lblDesc.Text);
                        cmdChecklist.Parameters.AddWithValue("@IsOK", isOK);
                        cmdChecklist.Parameters.AddWithValue("@ItemName", txtRemarks.Text.Trim());
                        cmdChecklist.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                        cmdChecklist.Parameters.AddWithValue("@Capa_Report", capaReportID);

                        cmdChecklist.ExecuteNonQuery();
                    }

                    tran.Commit();
                    lblMsg.Text = "Data saved successfully!";
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    lblMsg.Text = "Error: " + ex.Message;
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
        }






        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("FirstAidBox.aspx");
        }
        protected void BtnView_Click(object sender, EventArgs e)
        {
            Response.Redirect("FirstAidBoxView.aspx");
        }
    }
}