using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity.Core.Metadata.Edm;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class FullBodyHarnessInspection_Update : System.Web.UI.Page
    {
        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    if (!IsPostBack)
        //    {
        //        if (Request.QueryString["InspectionID"] != null)
        //        {
        //            int inspectionID = Convert.ToInt32(Request.QueryString["InspectionID"]);
        //            //LoadInspectionData(inspectionID);
        //            BindChecklist(); 
        //            LoadDetails(inspectionID);
        //            LoadChecklistItems(inspectionID); // Load data into repeaters
        //        }
        //    }
        //}
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string inspectionIdStr = Request.QueryString["InspectionID"];

                int inspectionID = 0; // ✅ Declare separately

                if (!string.IsNullOrEmpty(inspectionIdStr) && int.TryParse(inspectionIdStr, out inspectionID))
                {
                    BindChecklist();
                    LoadDetails(inspectionID);         // Method must accept int
                    LoadChecklistItems(inspectionID);  // Method must accept int
                    string headerID = GetHeaderIDFromDatabase(inspectionID); 

                    hfHeaderID.Value = headerID;
                }
                else
                {
                    // Optional: display a message or redirect
                    // lblMsg.Text = "Invalid or missing InspectionID.";
                }
            }
        }
        private string GetHeaderIDFromDatabase(int inspectionID)
        {
            string headerID = "";
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT HeaderID FROM InspectionChecklist WHERE InspectionID = @InspectionID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@InspectionID", inspectionID);
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                    headerID = result.ToString();
            }
            return headerID;
        }


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

        private void LoadDetails(int inspectionID)
        {
            string query = @"SELECT InspectionID, DateOfInspection,JobID,Site,EmployeeName,InspectedBy ,Remarks from  InspectionHeader where InspectionID=@InspectionID ";


            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@InspectionID", inspectionID);
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtdate.Text = Convert.ToDateTime(reader["DateOfInspection"]).ToString("yyyy-MM-dd");
                        txtSite.Text = reader["Site"].ToString();
                        txtnote.Text = reader["Remarks"].ToString();
                        txtjobID.Text = reader["JobID"].ToString();
                        txtInsBy.Text = reader["InspectedBy"].ToString();
                        txtDocNo.Text = reader["EmployeeName"].ToString();
                    }
                    else
                    {

                    }
                }
            }
        }
        private void LoadChecklistItems(int inspectionID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string query = "SELECT Location, InspectionNo, QuestionNumber, Description, IsOk, NA,Remarks, PhotoPath, CAPA_Report,HeaderID FROM InspectionChecklist WHERE InspectionID = @InspectionID";

            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@InspectionID", inspectionID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            if (dt.Rows.Count > 0)
            {
                LoadHeaderFields(dt.Rows[0]);
                LoadRepeaterWithData(rptsChecklist, dt);
            }
            else
            {
                // Optional: Clear fields or show a message
                txtLoc.Text = "";
                txtIdentity.Text = "";
                rptsChecklist.DataSource = null;
                rptsChecklist.DataBind();
                lblMsg.Text = "No checklist items found for this Inspection ID.";
            }
        }

        //private void LoadChecklistItems(int inspectionID)
        //{
        //    string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //    string query = "SELECT Location,InspectionNo,QuestionNumber,Description,IsOk,Remarks, PhotoPath,CAPA_Report  FROM InspectionChecklist where InspectionID=@InspectionID";

        //    DataTable dt = new DataTable();
        //    using (SqlConnection con = new SqlConnection(connStr))
        //    using (SqlCommand cmd = new SqlCommand(query, con))
        //    {
        //        cmd.Parameters.AddWithValue("@InspectionID", inspectionID);
        //        SqlDataAdapter da = new SqlDataAdapter(cmd);
        //        da.Fill(dt);
        //    }
        //    LoadHeaderFields(dt.Rows[0]);
        //    LoadRepeaterWithData(rptsChecklist, dt);
        //}


        private void LoadHeaderFields(DataRow headerRow)
        {
            txtLoc.Text = headerRow["Location"].ToString();
            txtIdentity.Text = headerRow["InspectionNo"].ToString();
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
                    RadioButton rdoNA = (RadioButton)item.FindControl("rdoNA");

                    if (Convert.ToBoolean(row["IsOk"]))
                        rdoYes.Checked = true;
                    else if (Convert.ToBoolean(row["NA"]))
                        rdoNA.Checked = true;
                    else
                        rdoNo.Checked = true;

                    TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                    txtRemarks.Text = row["Remarks"].ToString();
                    var lblDescription = (Label)item.FindControl("lblDescription");
                    if (lblDescription != null)
                        lblDescription.Text = row["Description"].ToString();

                    HiddenField hfImagePath = (HiddenField)item.FindControl("hfImagePath");
                    FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                    System.Web.UI.WebControls.Image imgPreview = (System.Web.UI.WebControls.Image)item.FindControl("imgPreview");

                    string photoPath = row["PhotoPath"].ToString();
                    if (!string.IsNullOrEmpty(photoPath))
                    {
                        string physicalPath = Server.MapPath(photoPath);
                        if (System.IO.File.Exists(physicalPath))
                        {
                            imgPreview.ImageUrl = photoPath;
                            imgPreview.Visible = true;
                            hfImagePath.Value = photoPath;
                        }
                        else
                        {
                            imgPreview.Visible = false;
                        }
                    }
                    else
                    {
                        imgPreview.Visible = false;
                    }
                    if (!Convert.ToBoolean(row["IsOk"]) && !Convert.ToBoolean(row["NA"]))
                    {
                        txtRemarks.Style["display"] = "block";
                        fileUpload.Style["display"] = "block";
                    }
                    CheckBox chkCapa = (CheckBox)item.FindControl("chkCapaReport");
                    HiddenField hfCapaReportID = (HiddenField)item.FindControl("hfCapaReportID");

                    if (row["CAPA_Report"] != DBNull.Value)
                    {
                        chkCapa.Checked = true;
                        chkCapa.Style["display"] = "block";
                        hfCapaReportID.Value = row["CAPA_Report"].ToString();
                    }
                    else
                    {
                        chkCapa.Checked = false;
                        chkCapa.Style["display"] = "none";
                        hfCapaReportID.Value = "";
                    }

                }
            }
        }



        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("FullBodyHarnessInspection_View.aspx");
        }


        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            lblMsg.Text = "";

            if (string.IsNullOrWhiteSpace(txtdate.Text) || string.IsNullOrWhiteSpace(txtjobID.Text) ||
                string.IsNullOrWhiteSpace(txtSite.Text) || string.IsNullOrWhiteSpace(txtDocNo.Text) ||
                string.IsNullOrWhiteSpace(txtInsBy.Text) || string.IsNullOrWhiteSpace(txtnote.Text) ||
                string.IsNullOrWhiteSpace(txtIdentity.Text) || string.IsNullOrWhiteSpace(txtLoc.Text) )
            {
                lblMsg.Text = "Please fill all required fields.";
                return;
            }
            int inspectionID = Convert.ToInt32(Request.QueryString["InspectionID"]); // assuming InspectionID is passed via query string
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

               // STEP 2: Update Header
                SqlCommand cmdUpdateHeader = new SqlCommand(@"
            UPDATE InspectionHeader SET
                DateOfInspection = @DateOfInspection,
                JobID = @JobID,
                Site = @Site,
                EmployeeName = @EmployeeName,
                InspectedBy = @InspectedBy,
                Remarks = @Remarks
            WHERE InspectionID = @InspectionID", con);

                cmdUpdateHeader.Parameters.AddWithValue("@DateOfInspection", txtdate.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@JobID", txtjobID.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@Site", txtSite.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@EmployeeName", txtDocNo.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@Remarks", txtnote.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@InspectionID",inspectionID );

                cmdUpdateHeader.ExecuteNonQuery();


                // STEP 3: Delete old checklist
                SqlCommand cmdDeleteChecklist = new SqlCommand("DELETE FROM InspectionChecklist WHERE InspectionID = @InspectionID", con);
                cmdDeleteChecklist.Parameters.AddWithValue("@InspectionID", inspectionID);
                cmdDeleteChecklist.ExecuteNonQuery();

                // STEP 4: Re-insert checklist items, preserving CAPA if exists
                SaveChecklistItems(rptsChecklist, inspectionID, con);

                con.Close();
            }

            lblMsg.Text = "Checklist updated successfully.";
            lblMsg.ForeColor = System.Drawing.Color.Green;
        }
        private void SaveChecklistItems(Repeater repeater, int inspectionID, SqlConnection con)
        {

            foreach (RepeaterItem item in repeater.Items)
            {
                HiddenField hfQuestionNumber = (HiddenField)item.FindControl("hfQuestionNumber");
                RadioButton rdoYes = (RadioButton)item.FindControl("rdoYes");
                RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");
                RadioButton rdoNA = (RadioButton)item.FindControl("rdoNA");
                TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                HiddenField hfImagePath = (HiddenField)item.FindControl("hfImagePath");
                Label lblDescription = (Label)item.FindControl("lblDescription");
                CheckBox chkCapa = (CheckBox)item.FindControl("chkCapaReport");
                string headerID = hfHeaderID.Value;


                bool na = (rdoNA != null && rdoNA.Checked);
                string description = lblDescription?.Text?.Trim() ?? "";
                string remarks = txtRemarks?.Text ?? "";
                string location = txtLoc?.Text ?? "";
                string identityno = txtIdentity?.Text ?? "";
                int questionNumber = Convert.ToInt32(hfQuestionNumber.Value);
                string checklistPhotoPath = "";
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
                //bool isOk = rdoYes.Checked;
                object isOkValue;
                if (rdoYes.Checked) { 
                    isOkValue = 1;
                    remarks = "";
                    checklistPhotoPath = "";
                }
                else 
                    isOkValue = 0;
               
               

                

                HiddenField hfCapaReportID = (HiddenField)item.FindControl("hfCapaReportID");
                object capaID = DBNull.Value;


              
                if (!string.IsNullOrEmpty(hfCapaReportID.Value))
                {
                    capaID = hfCapaReportID.Value;

                    // If changed from No to Yes or NA, mark CAPA as resolved (IsYes = 1)
                    if (rdoYes.Checked || rdoNA.Checked)
                    {
                        SqlCommand updateIsYes = new SqlCommand(@"
            UPDATE tbl_CAPAMaster
            SET IsYes = 1
            WHERE CAPAID = @CAPAID", con);

                        updateIsYes.Parameters.AddWithValue("@CAPAID", hfCapaReportID.Value);
                        updateIsYes.ExecuteNonQuery();
                    }
                }
                else if (rdoNo.Checked && chkCapa != null && chkCapa.Checked)
                {
                    SqlCommand cmdCAPA = new SqlCommand(@"
                        INSERT INTO tbl_CAPAMaster 
                        (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate)
                        OUTPUT INSERTED.CAPAID
                        VALUES 
                        (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate)", con);

                    cmdCAPA.Parameters.AddWithValue("@HeaderID", headerID);
                    cmdCAPA.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                    cmdCAPA.Parameters.AddWithValue("@Remarks", remarks);
                    cmdCAPA.Parameters.AddWithValue("@AssignedBy", txtInsBy.Text.Trim());
                    cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                    capaID = cmdCAPA.ExecuteScalar();
                }


                SqlCommand cmdInsert = new SqlCommand(@"
                               INSERT INTO InspectionChecklist  
                              (HeaderID,Location,InspectionNo, InspectionID, QuestionNumber, IsOk, NA, Remarks, PhotoPath, Description, Capa_Report, DateOfChecklist)
                               VALUES 
                               (@HeaderID,@Location,@InspectionNo, @InspectionID, @QuestionNumber, @IsOk, @NA, @Remarks, @PhotoPath, @Description, @CAPA_Report, @DateOfChecklist)", con);

                cmdInsert.Parameters.AddWithValue("@HeaderID", headerID);
                cmdInsert.Parameters.AddWithValue("@InspectionID", inspectionID);
                cmdInsert.Parameters.AddWithValue("@QuestionNumber", questionNumber);
                cmdInsert.Parameters.AddWithValue("@IsOk", isOkValue);
                cmdInsert.Parameters.AddWithValue("@NA", na);
                cmdInsert.Parameters.AddWithValue("@Remarks", remarks);
                cmdInsert.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                cmdInsert.Parameters.AddWithValue("@Description", description);
                cmdInsert.Parameters.AddWithValue("@CAPA_Report", capaID);
                cmdInsert.Parameters.AddWithValue("@Location", location);
                cmdInsert.Parameters.AddWithValue("@InspectionNo", identityno);
                cmdInsert.Parameters.AddWithValue("@DateOfChecklist", DateTime.Now);

                cmdInsert.ExecuteNonQuery();
            }


        }


        //protected void BtnUpdate_Click(object sender, EventArgs e)
        //{
        //    //int inspectionID = Convert.ToInt32(Request.QueryString["InspectionID"]); // assuming InspectionID is passed via query string
        //    //string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        //    //using (SqlConnection con = new SqlConnection(connStr))
        //    //{
        //    //    con.Open();

        //    //    // STEP 2: Update Header



        //    //    // STEP 3: Delete old checklist
        //    //    SqlCommand cmdDeleteChecklist = new SqlCommand("DELETE FROM FireExtinguisherChecklist WHERE HeaderID = @HeaderID", con);
        //    //    cmdDeleteChecklist.Parameters.AddWithValue("@HeaderID", headerID);
        //    //    cmdDeleteChecklist.ExecuteNonQuery();

        //    //    // STEP 4: Re-insert checklist items, preserving CAPA if exists
        //    //    SaveChecklistItems(rptChecklist, headerID, con);

        //    //    con.Close();
        //    //}

        //    //lblMsg.Text = "Checklist updated successfully.";
        //    //lblMsg.ForeColor = System.Drawing.Color.Green;

        //    //using (SqlConnection con = new SqlConnection(connectionString))
        //    //{
        //    //    con.Open();

        //    //    // Update InspectionHeader
        //    //    string updateHeaderQuery = @"UPDATE InspectionHeader 
        //    //                         SET EmployeeName = @EmployeeName,
        //    //                             Site = @Site,
        //    //                             InspectedBy = @InspectedBy,
        //    //                             Remarks=@Remarks,
        //    //                              JobID=@JobID,
        //    //                             DateOfInspection = @DateOfInspection
        //    //                         WHERE InspectionID = @InspectionID";

        //    //    using (SqlCommand cmdHeader = new SqlCommand(updateHeaderQuery, con))
        //    //    {
        //    //        cmdHeader.Parameters.AddWithValue("@EmployeeName", txtDocNo.Text.Trim());
        //    //        cmdHeader.Parameters.AddWithValue("@Site", txtSite.Text.Trim());
        //    //        cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text.Trim());
        //    //        cmdHeader.Parameters.AddWithValue("@Remarks", txtnote.Text.Trim());
        //    //        cmdHeader.Parameters.AddWithValue("@JobID", txtjobID.Text.Trim());
        //    //        cmdHeader.Parameters.AddWithValue("@DateOfInspection", txtdate.Text.Trim());
        //    //        cmdHeader.Parameters.AddWithValue("@InspectionID", inspectionID);
        //    //        cmdHeader.ExecuteNonQuery();
        //    //    }

        //    //    // Update each checklist row
        //    //    foreach (GridViewRow row in gvChecklist.Rows)
        //    //    {
        //    //        string identificationNo = ((Label)row.FindControl("lblIdentificationNo")).Text;
        //    //        string location = ((TextBox)row.FindControl("txtLocation")).Text;

        //    //        for (int q = 1; q <= 5; q++)
        //    //        {

        //    //            string remarks = "";
        //    //            string photoPath = "";
        //    //            //string status = ((TextBox)row.FindControl($"txtQ{q}Status")).Text.Trim();
        //    //            string status = ((DropDownList)row.FindControl($"ddlQ{q}Status")).SelectedValue.Trim();
        //    //            if (!status.Equals("OK", StringComparison.OrdinalIgnoreCase))
        //    //            {
        //    //                // Save remarks only if not OK
        //    //                remarks = ((TextBox)row.FindControl($"txtQ{q}Remarks")).Text;
        //    //                // Save photo only if uploaded
        //    //                FileUpload fuPhoto = (FileUpload)row.FindControl($"fuimgQ{q}Photo");
        //    //                if (fuPhoto.HasFile)
        //    //                {
        //    //                    string fileName = Path.GetFileName(fuPhoto.FileName);
        //    //                    string savePath = Server.MapPath("~/images/") + fileName;
        //    //                    fuPhoto.SaveAs(savePath);
        //    //                    photoPath = "~/images/" + fileName;
        //    //                }
        //    //                else
        //    //                {
        //    //                    // Preserve existing photo if already present
        //    //                    Label lblPhoto = (Label)row.FindControl($"lblimgQ{q}Photo");
        //    //                    photoPath = lblPhoto.Text;
        //    //                }
        //    //            }
        //    //            //string status = ((TextBox)row.FindControl($"txtQ{q}Status")).Text;
        //    //            //string remarks = ((TextBox)row.FindControl($"txtQ{q}Remarks")).Text;
        //    //            //FileUpload fuPhoto = (FileUpload)row.FindControl($"fuimgQ{q}Photo");
        //    //            //Label lblPhoto = (Label)row.FindControl($"lblimgQ{q}Photo");

        //    //            //string photoPath = lblPhoto.Text;

        //    //            //// Save new image if uploaded
        //    //            //if (fuPhoto.HasFile)
        //    //            //{
        //    //            //    string fileName = Path.GetFileName(fuPhoto.FileName);
        //    //            //    string savePath = Server.MapPath("~/images/") + fileName;
        //    //            //    fuPhoto.SaveAs(savePath);
        //    //            //    photoPath = "~/images/" + fileName;
        //    //            //}

        //    //            // Update the database row
        //    //            string updateChecklistQuery = @"UPDATE InspectionChecklist
        //    //                                    SET IsOk = @IsOk,
        //    //                                        Remarks = @Remarks,
        //    //                                        PhotoPath = @PhotoPath,
        //    //                                        Location = @Location
        //    //                                    WHERE InspectionID = @InspectionID AND 
        //    //                                          InspectionNo = @InspectionNo AND 
        //    //                                          QuestionNumber = @QuestionNumber";

        //    //            using (SqlCommand cmdChecklist = new SqlCommand(updateChecklistQuery, con))
        //    //            {
        //    //                cmdChecklist.Parameters.AddWithValue("@IsOk", status.Equals("OK", StringComparison.OrdinalIgnoreCase));
        //    //                cmdChecklist.Parameters.AddWithValue("@Remarks", remarks);
        //    //                cmdChecklist.Parameters.AddWithValue("@PhotoPath", photoPath);
        //    //                cmdChecklist.Parameters.AddWithValue("@Location", location);
        //    //                cmdChecklist.Parameters.AddWithValue("@InspectionID", inspectionID);
        //    //                cmdChecklist.Parameters.AddWithValue("@InspectionNo", identificationNo);
        //    //                cmdChecklist.Parameters.AddWithValue("@QuestionNumber", q);
        //    //                cmdChecklist.ExecuteNonQuery();
        //    //            }
        //    //        }
        //    //    }

        //    //    lblMsg.Text = "Update successful!";
        //    //}


        //}


    }
}