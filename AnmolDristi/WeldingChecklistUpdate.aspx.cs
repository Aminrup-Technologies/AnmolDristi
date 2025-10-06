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
using System.Diagnostics;

namespace AnmolDristi
{
    public partial class WeldingChecklistUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                string headerID = Request.QueryString["HeaderID"];

                if (!string.IsNullOrEmpty(headerID))
                {
                    LoadDetails(headerID);        // Load header
                    BindChecklist();
                    BindChecklist_Terminals();
                    BindChecklist_WorkArea();
                    BindChecklist_ElectrodeHolder();
                    BindChecklist_Cables();

                    LoadChecklistItems(headerID); // Load data into repeaters
                }
            }

        }
        private void BindChecklist()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));
            dt.Rows.Add(1, "In good working condition.");
            dt.Rows.Add(2, "Provided with earthing in grounding.");
            dt.Rows.Add(3, "Fire extinguisher is available.");
            dt.Rows.Add(4, "Rubber mat available.");
            dt.Rows.Add(5, "Double earthing.");
            rptChecklist.DataSource = dt;
            rptChecklist.DataBind();
        }
        private void BindChecklist_Cables()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(10, "Is the cables free from heat.");
            dt.Rows.Add(11, "Properly insulated and no exposed cables.");
            dt.Rows.Add(12, "Size of cable suitable for voltage supply.");
            dt.Rows.Add(13, "Hang up to prevent tripping hazard.");
            dt.Rows.Add(14, "Hang on insulated hook or material.");
            dt.Rows.Add(15, "Cables and joints are properly and in good condition.");

            rptCables.DataSource = dt;
            rptCables.DataBind();
        }
        private void BindChecklist_Terminals()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(6, "In good working condition.");
            dt.Rows.Add(7, "Secured and effectively insulated.");
            dt.Rows.Add(8, "Is joint in healthy condition.");
            dt.Rows.Add(9, "Is the lugging was crimped with tool.");

            rptTerminals.DataSource = dt;
            rptTerminals.DataBind();
        }
        private void BindChecklist_ElectrodeHolder()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(16, "Electrode holder is free from defects.");
            dt.Rows.Add(17, "Return cable clamp is free from defects.");
            dt.Rows.Add(18, "Detech electrodes when not in use.");

            rptElectrodeHolder.DataSource = dt;
            rptElectrodeHolder.DataBind();
        }
        private void BindChecklist_WorkArea()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(19, "No combustible or flammable material.");
            dt.Rows.Add(20, "Fire Blanket is provided.");
            dt.Rows.Add(21, "Maintain good housekeeping.");
            dt.Rows.Add(22, "Flooring is free from water.");

            rptWorkArea.DataSource = dt;
            rptWorkArea.DataBind();
        }

        private void LoadDetails(string headerID)
        {
            string query = @"SELECT HeaderID,ChecklistDate,JobID,Location,EmployeeName,InspectedBy ,Remarks from  WeldingChecklistHeader where HeaderID=@HeaderID ";


            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerID);
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtdate.Text = Convert.ToDateTime(reader["ChecklistDate"]).ToString("yyyy-MM-dd");
                        txtloc.Text = reader["Location"].ToString();
                        txtnote.Text = reader["Remarks"].ToString();
                        txtjobId.Text = reader["JobID"].ToString();
                        txtInsBy.Text = reader["InspectedBy"].ToString();
                        txtDocNo.Text = reader["EmployeeName"].ToString();
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
            string query = "SELECT * FROM WeldingChecklist WHERE HeaderID = @HeaderID";

            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            LoadRepeaterWithData(rptChecklist, dt);
            LoadRepeaterWithData(rptTerminals, dt);
            LoadRepeaterWithData(rptCables, dt);
            LoadRepeaterWithData(rptElectrodeHolder, dt);
            LoadRepeaterWithData(rptWorkArea, dt);
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

                    // Reset all to avoid leftover checks
                    rdoYes.Checked = false;
                    rdoNo.Checked = false;
                    rdoNA.Checked = false;


                    // NULL - N/A, True - Yes, False - No
                    if (row["IsOk"] == DBNull.Value)
                    {
                        rdoNA.Checked = true;  // NULL means N/A
                    }
                    else
                    {
                        bool isOk = Convert.ToBoolean(row["IsOk"]);

                        if (isOk)
                            rdoYes.Checked = true;   // 1 → Yes
                        else
                            rdoNo.Checked = true;    // 0 → No
                    }

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
                    if (!rdoYes.Checked && !rdoNA.Checked)
                    {
                       txtRemarks.Style["display"] = "block";
                       fileUpload.Style["display"] = "block";
                     }
                    //CheckBox chkCapa = (CheckBox)item.FindControl("chkCapaReport");
                    //if (row["CAPA_Report"] != DBNull.Value)
                    //{
                    //    chkCapa.Checked = true;
                    //    chkCapa.Style["display"] = "block";
                    //}
                    //else
                    //{
                    //    chkCapa.Checked = false;
                    //    chkCapa.Style["display"] = "none";
                    //}
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

       


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtdate.Text) || string.IsNullOrWhiteSpace(txtloc.Text) ||
               string.IsNullOrWhiteSpace(txtjobId.Text) || string.IsNullOrWhiteSpace(txtDocNo.Text) ||
               string.IsNullOrWhiteSpace(txtInsBy.Text) || string.IsNullOrWhiteSpace(txtnote.Text))

            {
                lblMsg.Text = "Please fill all required fields.";
                return;
            }

            //✅ Validation for "No" selected rows
            foreach (RepeaterItem item in rptChecklist.Items)
            {
                RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");
                TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                HiddenField hfImagePath = (HiddenField)item.FindControl("hfImagePath");
                System.Web.UI.WebControls.Label lblDescription = (System.Web.UI.WebControls.Label)item.FindControl("lblDescription");

                if (rdoNo != null && rdoNo.Checked)
                {
                    if (txtRemarks != null && string.IsNullOrWhiteSpace(txtRemarks.Text))
                    {
                        lblMsg.Text = $"Please enter remarks for: \"{lblDescription.Text}\".";
                        return;
                    }

                    // Check if neither a new file is uploaded nor a previous path exists
                    bool isNewFileUploaded = fileUpload != null && fileUpload.HasFile;
                    bool isExistingImagePresent = hfImagePath != null && !string.IsNullOrWhiteSpace(hfImagePath.Value);

                    if (!isNewFileUploaded && !isExistingImagePresent)
                    {
                        lblMsg.Text = $"Please upload photo for: \"{lblDescription.Text}\".";
                        return;
                    }
                }
            }

            string headerID = Request.QueryString["HeaderID"];
            if (string.IsNullOrEmpty(headerID)) return;

            try { 
                    string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                    using (SqlConnection con = new SqlConnection(connStr))
                    {
                        con.Open();

                        // Update Header
                        SqlCommand cmdUpdateHeader = new SqlCommand(@"
                    UPDATE WeldingChecklistHeader SET
                        ChecklistDate = @ChecklistDate,
                        JobID = @JobID,
                        Location = @Location,
                        EmployeeName = @EmployeeName,
                        InspectedBy = @InspectedBy,
                        Remarks = @Remarks
                    WHERE HeaderID = @HeaderID", con);

                        cmdUpdateHeader.Parameters.AddWithValue("@ChecklistDate", txtdate.Text);
                        cmdUpdateHeader.Parameters.AddWithValue("@JobID", txtjobId.Text);
                        cmdUpdateHeader.Parameters.AddWithValue("@Location", txtloc.Text);
                        cmdUpdateHeader.Parameters.AddWithValue("@EmployeeName", txtDocNo.Text);
                        cmdUpdateHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text);
                        cmdUpdateHeader.Parameters.AddWithValue("@Remarks", txtnote.Text);
                        cmdUpdateHeader.Parameters.AddWithValue("@HeaderID", headerID);

                        cmdUpdateHeader.ExecuteNonQuery();

                        // Delete existing checklist items first
                        SqlCommand cmdDeleteChecklist = new SqlCommand("DELETE FROM WeldingChecklist WHERE HeaderID = @HeaderID", con);
                        cmdDeleteChecklist.Parameters.AddWithValue("@HeaderID", headerID);
                        cmdDeleteChecklist.ExecuteNonQuery();

                        // Save updated checklist items
                        SaveChecklistItems(rptChecklist, headerID, con);
                        SaveChecklistItems(rptTerminals, headerID, con);
                        SaveChecklistItems(rptCables, headerID, con);
                        SaveChecklistItems(rptElectrodeHolder, headerID, con);
                        SaveChecklistItems(rptWorkArea, headerID, con);

                        con.Close();
                    }

                //  PNotify after successful save
                ShowPNotify("Success", "Data saved successfully!", "success");
            }
             catch (Exception ex)
                {
                    ShowPNotify("Error", "Error while saving data: " + ex.Message, "error");
               }
        }

        
        private void SaveChecklistItems(Repeater repeater, string headerID, SqlConnection con)
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

                int questionNumber = Convert.ToInt32(hfQuestionNumber.Value);
                //bool isOk = rdoYes.Checked;

                bool na = (rdoNA != null && rdoNA.Checked);
                string description = lblDescription?.Text?.Trim() ?? "";
                string remarks = txtRemarks?.Text ?? "";
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
                // --- Determine IsOk value for single column ---
                object isOkValue = DBNull.Value;

                // rdoYes → 1, rdoNo → 0, rdoNA → NULL
                if (rdoYes != null && rdoYes.Checked)
                {
                    isOkValue = 1;
                    remarks = "";
                    checklistPhotoPath = "";
                }
                else if (rdoNo != null && rdoNo.Checked)
                {
                    isOkValue = 0;
                }
                else if (rdoNA != null && rdoNA.Checked)
                {
                    isOkValue = DBNull.Value; // NA saved as NULL
                }

                HiddenField hfCapaReportID = (HiddenField)item.FindControl("hfCapaReportID");
                object capaID = DBNull.Value;

                if (!string.IsNullOrEmpty(hfCapaReportID.Value))
                {
                    capaID = hfCapaReportID.Value;

                    // If changed from No to Yes or NA, clear PhotoPath & Remarks
                    if (rdoYes.Checked || rdoNA.Checked)
                    {
                        SqlCommand clearsCAPAFields = new SqlCommand(@"
                                  UPDATE tbl_CAPAMaster 
                                SET IsYes = 1
                                WHERE CAPAID = @CAPAID", con);

                        clearsCAPAFields.Parameters.AddWithValue("@CAPAID", hfCapaReportID.Value);
                        clearsCAPAFields.ExecuteNonQuery();
                        remarks = "";
                        checklistPhotoPath = "";

                    }
                }

                else if (rdoNo.Checked && chkCapa != null && chkCapa.Checked)
                {
                    SqlCommand cmdCAPA = new SqlCommand(@"
        INSERT INTO tbl_CAPAMaster 
        (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate,Description)
        OUTPUT INSERTED.CAPAID
        VALUES 
        (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate,@Description)", con);

                    cmdCAPA.Parameters.AddWithValue("@HeaderID", headerID);
                    cmdCAPA.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(checklistPhotoPath) ? DBNull.Value : (object)checklistPhotoPath);
                    cmdCAPA.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
                    cmdCAPA.Parameters.AddWithValue("@AssignedBy", Session["UserName"]?.ToString() ?? "");
                    cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                    cmdCAPA.Parameters.AddWithValue("@Description", lblDescription.Text);


                    capaID = cmdCAPA.ExecuteScalar();
                }

                SqlCommand cmdInsert = new SqlCommand(@"
            INSERT INTO WeldingChecklist 
            (HeaderID, QuestionNumber, IsOk,  Remarks, PhotoPath, Description,CAPA_Report)
            VALUES 
            (@HeaderID, @QuestionNumber, @IsOk,  @Remarks, @PhotoPath, @Description,@CAPA_Report)", con);

                cmdInsert.Parameters.AddWithValue("@HeaderID", headerID);
                cmdInsert.Parameters.AddWithValue("@QuestionNumber", questionNumber);
                cmdInsert.Parameters.AddWithValue("@IsOk", isOkValue);
                //cmdInsert.Parameters.AddWithValue("@NA", na);
                cmdInsert.Parameters.AddWithValue("@Remarks", remarks);
                cmdInsert.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                cmdInsert.Parameters.AddWithValue("@Description", description);
                cmdInsert.Parameters.AddWithValue("@CAPA_Report", capaID);

                cmdInsert.ExecuteNonQuery();
            }
           
        }

        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("WeldingChecklistView.aspx");
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