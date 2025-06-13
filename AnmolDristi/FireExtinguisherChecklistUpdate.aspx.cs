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
    public partial class FireExtinguisherChecklistUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int headerID;
                if (int.TryParse(Request.QueryString["HeaderID"], out headerID))
                {
                    LoadDetails(headerID);        // Load header
                    BindChecklist();              // Bind structure
                    LoadChecklistItems(headerID); // Load data into repeaters
                }
            }
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
        private void LoadDetails(int headerID)
        {
            string query = @"SELECT HeaderID,ChecklistDate,JobID,Location,EmployeeName,InspectedBy ,Remarks from  FireExtinguisherHeader where HeaderID=@HeaderID ";


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
        private void LoadChecklistItems(int headerID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string query = "SELECT ExtinguisherType,FE_SerialNo,CalibrationDate,DueDate,QuestionNumber,Description,IsOk,Remarks, PhotoPath,NA  FROM FireExtinguisherChecklist WHERE HeaderID = @HeaderID";

            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            LoadHeaderFields(dt.Rows[0]);
            LoadRepeaterWithData(rptChecklist, dt);
        }
        private void LoadHeaderFields(DataRow headerRow)
        {
            // Set dropdown value
            if (ddlType.Items.FindByValue(headerRow["ExtinguisherType"].ToString()) != null)
            {
                ddlType.SelectedValue = headerRow["ExtinguisherType"].ToString();
            }

            // Set Serial No.
            txtsno.Text = headerRow["FE_SerialNo"].ToString();

            // Parse Calibration Date
            DateTime calDate;
            if (DateTime.TryParse(headerRow["CalibrationDate"].ToString(), out calDate))
            {
                txtCalibrationDate.Text = calDate.ToString("yyyy-MM-dd");
            }

            // Parse Due Date
            DateTime dueDate;
            if (DateTime.TryParse(headerRow["DueDate"].ToString(), out dueDate))
            {
                txtDueDate.Text = dueDate.ToString("yyyy-MM-dd");
            }
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
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
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
            if (!System.Text.RegularExpressions.Regex.IsMatch(txtjobId.Text.Trim(), @"^\d+$"))
            {
                lblMsg.Text = "Job ID must contain digits only.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtloc.Text))
            {
                lblMsg.Text = "Please enter Location.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtDocNo.Text))
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


            int headerID;
            if (!int.TryParse(Request.QueryString["HeaderID"], out headerID))
            {
                // Invalid header ID
                return;
            }
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Update Header
                SqlCommand cmdUpdateHeader = new SqlCommand(@"
            UPDATE FireExtinguisherHeader SET
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
                SqlCommand cmdDeleteChecklist = new SqlCommand("DELETE FROM FireExtinguisherChecklist WHERE HeaderID = @HeaderID", con);
                cmdDeleteChecklist.Parameters.AddWithValue("@HeaderID", headerID);
                cmdDeleteChecklist.ExecuteNonQuery();

                // Save updated checklist items
                SaveChecklistItems(rptChecklist, headerID, con);
               

                con.Close();
            }

            // Redirect or show success message
            lblMsg.Text = "Checklist updated successfully.";
            lblMsg.ForeColor = System.Drawing.Color.Green;
        }
        private void SaveChecklistItems(Repeater repeater, int headerID, SqlConnection con)
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

                int questionNumber = Convert.ToInt32(hfQuestionNumber.Value);
                bool isOk = rdoYes.Checked;
                bool na = rdoNA.Checked;
                string description = lblDescription?.Text?.Trim() ?? "";

                string remarks = "";
                string photoPath = "";

                // Only allow remarks and photo if "No" is selected
                if (rdoNo.Checked)
                {
                    remarks = txtRemarks.Text.Trim();

                    if (fileUpload.HasFile)
                    {
                        string fileName = Path.GetFileName(fileUpload.FileName);
                        string savePath = Server.MapPath("~/Uploads/" + fileName);
                        fileUpload.SaveAs(savePath);
                        photoPath = "~/Uploads/" + fileName;
                    }
                    else
                    {
                        photoPath = hfImagePath?.Value ?? "";
                    }
                }

            SqlCommand cmdInsert = new SqlCommand(@"
            INSERT INTO FireExtinguisherChecklist  
            (HeaderID,ExtinguisherType,FE_SerialNo,CalibrationDate,DueDate , QuestionNumber, IsOk, NA, Remarks, PhotoPath, Description)
            VALUES 
            (@HeaderID,@ExtinguisherType,@FE_SerialNo ,@CalibrationDate,@DueDate , @QuestionNumber, @IsOk, @NA, @Remarks, @PhotoPath, @Description)", con);

                cmdInsert.Parameters.AddWithValue("@HeaderID", headerID);
                cmdInsert.Parameters.AddWithValue("@ExtinguisherType", ddlType.SelectedValue);
                cmdInsert.Parameters.AddWithValue("@FE_SerialNo",txtsno.Text );
                cmdInsert.Parameters.AddWithValue("@CalibrationDate", txtCalibrationDate.Text);
                cmdInsert.Parameters.AddWithValue("@DueDate", txtDueDate.Text);
                cmdInsert.Parameters.AddWithValue("@QuestionNumber", questionNumber);
                cmdInsert.Parameters.AddWithValue("@IsOk", isOk);
                cmdInsert.Parameters.AddWithValue("@NA", na);
                cmdInsert.Parameters.AddWithValue("@Remarks", remarks);
                cmdInsert.Parameters.AddWithValue("@PhotoPath", photoPath);
                cmdInsert.Parameters.AddWithValue("@Description", description);

                cmdInsert.ExecuteNonQuery();
            }
        }
        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("FireExtinguisherChecklistView.aspx");
        }


    }
}