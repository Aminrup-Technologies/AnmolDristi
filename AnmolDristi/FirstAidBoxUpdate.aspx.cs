using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Remoting.Messaging;
using static System.Net.Mime.MediaTypeNames;
using System.IO;
using System.Drawing;
using System.Security.Cryptography;

namespace AnmolDristi
{
    public partial class FirstAidBoxUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string headerID = Request.QueryString["InspectionID"];

                if (!string.IsNullOrEmpty(headerID))
                {
                    LoadDetails(headerID);        // Load header
                    BindChecklist();              // Bind structure
                    LoadIssuesGrid(headerID);
                    LoadChecklistItems(headerID); // Load data into repeaters
                }
            }
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
        private void LoadDetails(string headerID)
        {
            string query = @"SELECT InspectionID,InspectionDate,Location,EmployeeName,InspectedBy ,Remarks,PhotoPath from  FirstAidInspectionHeader where InspectionID=@InspectionID ";


            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@InspectionID", headerID);
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtdate.Text = Convert.ToDateTime(reader["InspectionDate"]).ToString("yyyy-MM-dd");
                        txtVenue.Text = reader["Location"].ToString();
                        txtnote.Text = reader["Remarks"].ToString();
                        txtInsBy.Text = reader["InspectedBy"].ToString();
                        txtDocNo.Text = reader["EmployeeName"].ToString();
                        string photoPath = reader["PhotoPath"]?.ToString();
                        if (!string.IsNullOrEmpty(photoPath))
                        {
                            imgPreview1.ImageUrl = photoPath;
                            imgPreview1.Visible = true;
                            hfImagePath1.Value = photoPath; // store in hidden field if needed for update
                        }
                        else
                        {
                            imgPreview1.Visible = false;
                        }
                    }
                    else
                    {

                    }
                }
            }
        }
        private void LoadChecklistItems(string headerID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string query = "SELECT ItemName,QuestionNumber,Description,IsOk,PhotoPath,Capa_Report  FROM FirstAidChecklist WHERE InspectionID = @InspectionID";

            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@InspectionID", headerID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
              LoadRepeaterWithData(rptChecklist, dt);
        }
        private void LoadRepeaterWithData(Repeater repeater, DataTable checklistData)
        {
            foreach (RepeaterItem item in repeater.Items)
            {
                HiddenField hfQuestionNumber = (HiddenField)item.FindControl("hfQuestionNumber");
                int questionNumber = Convert.ToInt32(hfQuestionNumber.Value);

                DataRow[] rows = checklistData.Select("QuestionNumber = " + questionNumber);
                if (rows.Length > 0)
                {
                    DataRow row = rows[0];

                    RadioButton rdoYes = (RadioButton)item.FindControl("rdoYes");
                    RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");

                    // ✅ Select radio based on IsOk value
                    bool isOk = Convert.ToBoolean(row["IsOk"]);
                    rdoYes.Checked = isOk;
                    rdoNo.Checked = !isOk;

                    // ✅ Set ItemNames (instead of Remarks)
                    TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                    if (txtRemarks != null)
                        txtRemarks.Text = row["ItemName"]?.ToString();  


                    // ✅ Load Photo
                    string photoPath = row["PhotoPath"]?.ToString();
                    HiddenField hfImagePath = (HiddenField)item.FindControl("hfImagePath");
                    //Image imgPreview = (Image)item.FindControl("imgPreview");
                    System.Web.UI.WebControls.Image imgPreview = (System.Web.UI.WebControls.Image)item.FindControl("imgPreview");


                    if (!string.IsNullOrEmpty(photoPath))
                    {
                        imgPreview.ImageUrl = photoPath;
                        imgPreview.Visible = true;
                        hfImagePath.Value = photoPath;
                    }
                    else
                    {
                        imgPreview.Visible = false;
                    }

                    // ✅ Show fields only if Yes
                    if (isOk)
                    {
                        if (txtRemarks != null) txtRemarks.Style["display"] = "block";
                        FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                        if (fileUpload != null) fileUpload.Style["display"] = "block";
                    }

                    // ✅ Load CAPA Report
                    CheckBox chkCapaReport = (CheckBox)item.FindControl("chkCapaReport");
                    if (chkCapaReport != null)
                    {
                        bool capaRequired = row.Table.Columns.Contains("CAPA_Report") &&
                                            !string.IsNullOrEmpty(row["CAPA_Report"].ToString());

                        chkCapaReport.Checked = capaRequired;
                        chkCapaReport.Style["display"] = capaRequired ? "inline-block" : "none";
                    }
                }
            }
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            // Parse ItemDetailID (int) from DataKeys
            int itemDetailID = Convert.ToInt32(gvIssues.DataKeys[row.RowIndex].Value);

            if (itemDetailID > 0)
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM FirstAidItemDetails WHERE ItemDetailID = @ItemDetailID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ItemDetailID", itemDetailID);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                
                if (Request.QueryString["InspectionID"] != null)
                {
                    string inspectionID = Request.QueryString["InspectionID"].ToString();
                    LoadIssuesGrid(inspectionID); // <-- Make sure this is your actual method name
                }
            }
        }

      
        private void LoadIssuesGrid(string headerID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string query = @"SELECT ItemDetailID, ItemName, Quantity, ExpiryDate, LastRefilledDate, NextRefillDueDate
                     FROM FirstAidItemDetails
                     WHERE InspectionID = @InspectionID";

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@InspectionID", headerID);

                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    gvIssues.DataSource = dt;
                    gvIssues.DataBind();
                }
            }
        }

        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("FirstAidBoxView.aspx");
        }

        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string inspectionID = Request.QueryString["InspectionID"];

            if (string.IsNullOrEmpty(inspectionID))
            {
                lblMsg.Text = "InspectionID missing.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();

                try
                {
                    // Calculate total item count
                    int totalItemCount = 0;

                    foreach (GridViewRow row in gvIssues.Rows)
                    {
                        TextBox txtQty = (TextBox)row.FindControl("txtQuantity");
                        if (txtQty != null)
                        {
                            int qty;
                            if (int.TryParse(txtQty.Text.Trim(), out qty))
                            {
                                totalItemCount += qty;
                            }
                        }
                    }

                    // 1. Update Header
                    string updateHeader = @"UPDATE FirstAidInspectionHeader
                SET Location = @Location,
                    InspectionDate = @InspectionDate,
                    InspectedBy = @InspectedBy,
                    EmployeeName = @EmployeeName,
                    Remarks = @Remarks,
                    TotalItemCount = @TotalItemCount,
                    PhotoPath = @PhotoPath
                WHERE InspectionID = @InspectionID";

                    using (SqlCommand cmd = new SqlCommand(updateHeader, con, trans))
                    {
                        cmd.Parameters.AddWithValue("@Location", txtVenue.Text.Trim());
                        cmd.Parameters.AddWithValue("@InspectionDate", Convert.ToDateTime(txtdate.Text));
                        cmd.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text.Trim());
                        cmd.Parameters.AddWithValue("@EmployeeName", txtDocNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Remarks", txtnote.Text.Trim());
                        cmd.Parameters.AddWithValue("@TotalItemCount", totalItemCount);
                        cmd.Parameters.AddWithValue("@PhotoPath", hfImagePath1.Value ?? "");
                        cmd.Parameters.AddWithValue("@InspectionID", inspectionID);
                        cmd.ExecuteNonQuery();
                    }

                    // 2. Delete old Checklist + CAPA
                    SqlCommand delChecklist = new SqlCommand("DELETE FROM FirstAidChecklist WHERE InspectionID = @InspectionID", con, trans);
                    delChecklist.Parameters.AddWithValue("@InspectionID", inspectionID);
                    delChecklist.ExecuteNonQuery();

                    //SqlCommand delCAPA = new SqlCommand("DELETE FROM tbl_CAPAMaster WHERE HeaderID = @HeaderID", con, trans);
                    //delCAPA.Parameters.AddWithValue("@HeaderID", inspectionID);
                    //delCAPA.ExecuteNonQuery();
                    //SqlCommand clearCAPAFields = new SqlCommand(@"
                    //      UPDATE tbl_CAPAMaster 
                    //      SET PhotoPath = NULL, Remarks = NULL 
                    //      WHERE HeaderID = @HeaderID", con, trans);
                    SqlCommand clearCAPAFields = new SqlCommand(@"
                                  UPDATE tbl_CAPAMaster 
                                SET IsYes = 1
                                WHERE CAPAID = @CAPAID", con,trans);

                    clearCAPAFields.Parameters.AddWithValue("@HeaderID", inspectionID);
                    clearCAPAFields.ExecuteNonQuery();

                    foreach (RepeaterItem item in rptChecklist.Items)
                    {
                        HiddenField hfQNo = (HiddenField)item.FindControl("hfQuestionNumber");
                        Label lblDesc = (Label)item.FindControl("lblDescription");
                        RadioButton rdoYes = (RadioButton)item.FindControl("rdoYes");
                        RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");
                        TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                        HiddenField hfImagePath = (HiddenField)item.FindControl("hfImagePath");
                        CheckBox chkCapa = (CheckBox)item.FindControl("chkCapaReport");
                        FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");



                        bool isOk = (rdoYes != null && rdoYes.Checked);
                        string checklistPhotoPath = "";
                        //string txtRemarks = "";
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
                        else
                        {
                            checklistPhotoPath = hfImagePath?.Value ?? "";
                        }
                        object capaID = DBNull.Value;

                        // If YES is selected AND CAPA checkbox is checked, insert CAPA entry
                        if (isOk && chkCapa != null && chkCapa.Checked)
                        {
                            SqlCommand cmdCAPA = new SqlCommand(@"
            INSERT INTO tbl_CAPAMaster 
            (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate)
            OUTPUT INSERTED.CAPAID
            VALUES 
            (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate)", con, trans);

                            cmdCAPA.Parameters.AddWithValue("@HeaderID", inspectionID);
                            cmdCAPA.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(checklistPhotoPath) ? DBNull.Value : (object)checklistPhotoPath);
                            cmdCAPA.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
                            cmdCAPA.Parameters.AddWithValue("@AssignedBy", txtInsBy.Text.Trim());
                            cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                            capaID = cmdCAPA.ExecuteScalar();
                        }

                        // Insert checklist row with or without CAPA_Report
                        SqlCommand cmdChecklist = new SqlCommand(@"
            INSERT INTO FirstAidChecklist 
            (InspectionID, ItemName, QuestionNumber, Description, IsOK, PhotoPath, Capa_Report)
            VALUES
            (@InspectionID, @ItemName, @QuestionNumber, @Description, @IsOK, @PhotoPath, @Capa_Report)", con, trans);

                            cmdChecklist.Parameters.AddWithValue("@InspectionID", inspectionID);
                            //cmdChecklist.Parameters.AddWithValue("@ItemName", txtRemarks.Text.Trim());  
                            
                            cmdChecklist.Parameters.AddWithValue("@QuestionNumber", Convert.ToInt32(hfQNo.Value));
                            cmdChecklist.Parameters.AddWithValue("@Description", lblDesc.Text);
                            cmdChecklist.Parameters.AddWithValue("@IsOK", isOk);
                            cmdChecklist.Parameters.AddWithValue("@ItemName", isOk ? txtRemarks.Text.Trim() : (object)DBNull.Value);
                            
                            cmdChecklist.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                            cmdChecklist.Parameters.AddWithValue("@Capa_Report", capaID);

                            cmdChecklist.ExecuteNonQuery();
                        }
                   


                    // 4. Delete + Re-insert item details
                    SqlCommand delItems = new SqlCommand("DELETE FROM FirstAidItemDetails WHERE InspectionID = @InspectionID", con, trans);
                    delItems.Parameters.AddWithValue("@InspectionID", inspectionID);
                    delItems.ExecuteNonQuery();

                    foreach (GridViewRow row in gvIssues.Rows)
                    {
                        TextBox txtItemName = (TextBox)row.FindControl("txtItemName");
                        TextBox txtQty = (TextBox)row.FindControl("txtQuantity");
                        TextBox txtExpiry = (TextBox)row.FindControl("txtExpiryDate");
                        TextBox txtlastrefill = (TextBox)row.FindControl("txtLastRefilledDate");
                        TextBox txtnextrefill = (TextBox)row.FindControl("txtNextRefillDueDate");

                        SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO FirstAidItemDetails 
                    (InspectionID, ItemName, Quantity, ExpiryDate, LastRefilledDate, NextRefillDueDate)
                    VALUES
                    (@InspectionID, @ItemName, @Quantity, @ExpiryDate, @LastRefilledDate, @NextRefillDueDate)", con, trans);

                        cmd.Parameters.AddWithValue("@InspectionID", inspectionID);
                        cmd.Parameters.AddWithValue("@ItemName", txtItemName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Quantity", string.IsNullOrEmpty(txtQty.Text) ? 0 : Convert.ToInt32(txtQty.Text));
                        cmd.Parameters.AddWithValue("@ExpiryDate", string.IsNullOrEmpty(txtExpiry.Text) ? DBNull.Value : (object)Convert.ToDateTime(txtExpiry.Text));
                        cmd.Parameters.AddWithValue("@LastRefilledDate", string.IsNullOrEmpty(txtlastrefill.Text) ? DBNull.Value : (object)Convert.ToDateTime(txtlastrefill.Text));
                        cmd.Parameters.AddWithValue("@NextRefillDueDate", string.IsNullOrEmpty(txtnextrefill.Text) ? DBNull.Value : (object)Convert.ToDateTime(txtnextrefill.Text));

                        cmd.ExecuteNonQuery();
                    }

                    trans.Commit();
                    lblMsg.Text = "Inspection updated successfully.";
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    lblMsg.Text = "Error: " + ex.Message;
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

    }





}
