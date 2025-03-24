using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace AnmolDristi
{
    public partial class csm_massmeeting_record : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializeGrid();
            }
            RestoreUploadedFiles();
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (ViewState["GridViewData"] != null)
            {
                GridView1.DataSource = ViewState["GridViewData"];
                GridView1.DataBind();
            }
        }

        private void InitializeGrid()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("SLNO");
            dt.Columns.Add("AgendaTitle");
            dt.Columns.Add("DiscussedByCode");
            dt.Columns.Add("DiscussionType");
            dt.Columns.Add("CompanyCode");
            dt.Columns.Add("DeptCode");
            dt.Columns.Add("PointBy");
            dt.Columns.Add("AgendaPointDescription");
            dt.Columns.Add("Duration");
            dt.Columns.Add("RefPhotoBefore");
            dt.Columns.Add("AgendaPointAfter");
            dt.Columns.Add("RefPhotoAfter");

            dt.Rows.Add("1", "", "", "", "", "", "", "", "", "", "", "");
            ViewState["GridViewData"] = dt;
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        private void RestoreUploadedFiles()
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                FileUpload fuBefore = (FileUpload)row.FindControl("fuPhotoBefore");
                FileUpload fuAfter = (FileUpload)row.FindControl("fuPhotoAfter");
                Label lbl_fuPhotoBefore = (Label)row.FindControl("lbl_fuPhotoBefore");
                Label lbl_fuPhotoAfter = (Label)row.FindControl("lbl_fuPhotoAfter");

                if (Session["FileBefore_" + row.RowIndex] != null)
                {
                    lbl_fuPhotoBefore.Text = "Uploaded: " + Path.GetFileName(Session["FileBefore_" + row.RowIndex].ToString());
                }

                if (Session["FileAfter_" + row.RowIndex] != null)
                {
                    lbl_fuPhotoAfter.Text = "Uploaded: " + Path.GetFileName(Session["FileAfter_" + row.RowIndex].ToString());
                }
            }
        }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            DataTable dt = ViewState["GridViewData"] as DataTable;
            if (dt == null) return;

            foreach (GridViewRow row in GridView1.Rows)
            {
                TextBox txtAgendaTitle = (TextBox)row.FindControl("txtAgendaTitle");
                TextBox txtDiscussedByCode = (TextBox)row.FindControl("txtDiscussedByCode");
                DropDownList ddlDiscussionType = (DropDownList)row.FindControl("ddlDiscussionType");
                DropDownList ddlCompanyCode = (DropDownList)row.FindControl("ddlCompanyCode");
                DropDownList ddlDeptCode = (DropDownList)row.FindControl("ddlDeptCode");
                TextBox txtPointBy = (TextBox)row.FindControl("txtPointBy");
                TextBox txtAgendaDesc = (TextBox)row.FindControl("txtAgendaDesc");
                TextBox txtDuration = (TextBox)row.FindControl("txtDuration");
                TextBox txtAgendaDescAfter = (TextBox)row.FindControl("txtAgendaDescAfter");

                dt.Rows[row.RowIndex]["AgendaTitle"] = txtAgendaTitle.Text;
                dt.Rows[row.RowIndex]["DiscussedByCode"] = txtDiscussedByCode.Text;
                dt.Rows[row.RowIndex]["DiscussionType"] = ddlDiscussionType.SelectedValue;
                dt.Rows[row.RowIndex]["CompanyCode"] = ddlCompanyCode.SelectedValue;
                dt.Rows[row.RowIndex]["DeptCode"] = ddlDeptCode.SelectedValue;
                dt.Rows[row.RowIndex]["PointBy"] = txtPointBy.Text;
                dt.Rows[row.RowIndex]["AgendaPointDescription"] = txtAgendaDesc.Text;
                dt.Rows[row.RowIndex]["Duration"] = txtDuration.Text;
                dt.Rows[row.RowIndex]["AgendaPointAfter"] = txtAgendaDescAfter.Text;
            }

            if (e.CommandName == "AddMore")
            {
                int newSLNo = dt.Rows.Count + 1;
                dt.Rows.Add(newSLNo.ToString(), "", "", "", "", "", "", "", "", "", "", "");
            }
            else if (e.CommandName == "Remove")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                if (dt.Rows.Count > 1)
                {
                    dt.Rows.RemoveAt(rowIndex);
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        dt.Rows[i]["SLNO"] = (i + 1).ToString();
                    }
                }
            }

            ViewState["GridViewData"] = dt;
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        protected void btnAddMore_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                
                FileUpload fuBefore = (FileUpload)row.FindControl("fuPhotoBefore");
                TextBox txtBeforePath = (TextBox)row.FindControl("txtPhotoBeforePath");

                FileUpload fuAfter = (FileUpload)row.FindControl("fuPhotoAfter");
                TextBox txtAfterPath = (TextBox)row.FindControl("txtPhotoAfterPath");

                if (fuBefore.HasFile)
                {
                    string filePathBefore = "~/Uploads/" + fuBefore.FileName; // Ensure you have this folder in your project
                    fuBefore.SaveAs(Server.MapPath(filePathBefore));
                    txtBeforePath.Text = filePathBefore;
                }

                if (fuAfter.HasFile)
                {
                    string filePathAfter = "~/Uploads/" + fuAfter.FileName;
                    fuAfter.SaveAs(Server.MapPath(filePathAfter));
                    txtAfterPath.Text = filePathAfter;
                }
            }
            lblMsg1.Text = "Files uploaded and saved successfully!";
            lblMsg1.ForeColor = System.Drawing.Color.Green;
        }

        protected void btnsave1_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(DDL_WorkRegion.SelectedValue) ||
                  string.IsNullOrEmpty(DDL_Company.SelectedValue) ||
                  string.IsNullOrEmpty(DDL_Location.SelectedValue))
            {
                lblMsg.Text = "Please select all required fields.";
                return;
            }
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string meetingId = Guid.NewGuid().ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO csm_massmeting_records 
                                (MM_Id, MM_DocNo, Meeting_Date, Meeting_StartTime, Meeting_EndTime, 
                                SubmitterCode, RegionCode, CompanyCode, DeptCode, LocationCode, 
                                ExactLocation, Coordinator_Name, LastModifiedOn, LastModifiedByCode) 
                                VALUES 
                                (@MM_Id, @MM_DocNo, @Meeting_Date, @Meeting_StartTime, @Meeting_EndTime, 
                                @SubmitterCode, @RegionCode, @CompanyCode, @DeptCode, @LocationCode, 
                                @ExactLocation, @Coordinator_Name, GETDATE(), @LastModifiedByCode)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                    cmd.Parameters.AddWithValue("@MM_DocNo", "ATS/DOC/MM/0010");
                    cmd.Parameters.AddWithValue("@Meeting_Date", TB_Date.Text);
                    cmd.Parameters.AddWithValue("@Meeting_StartTime", TB_StartTime.Text);
                    cmd.Parameters.AddWithValue("@Meeting_EndTime", TB_EndTime.Text);
                    cmd.Parameters.AddWithValue("@SubmitterCode", "SUB001"); // Update with actual submitter ID
                    cmd.Parameters.AddWithValue("@RegionCode", DDL_WorkRegion.SelectedValue);
                    cmd.Parameters.AddWithValue("@CompanyCode", DDL_Company.SelectedValue);
                    cmd.Parameters.AddWithValue("@DeptCode", DDL_Department.SelectedValue);
                    cmd.Parameters.AddWithValue("@LocationCode", DDL_Location.SelectedValue);
                    cmd.Parameters.AddWithValue("@ExactLocation", TB_ExactLocation.Text);
                    cmd.Parameters.AddWithValue("@Coordinator_Name", TB_CoordinatorName.Text);
                    cmd.Parameters.AddWithValue("@LastModifiedByCode", "USER001"); // Replace with actual user ID

                    try
                    {
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            lblMsg.Text = "Record inserted successfully!";
                            HiddenField_MMId.Value = meetingId;
                            ViewState["MM_Id"] = meetingId;
                            //lblMsg.Text += $" (Meeting ID: {meetingId})"; // Debug output
                        }
                        else
                        {
                            lblMsg.Text = "Failed to insert record.";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMsg.Text = "Error: " + ex.Message;
                    }
                }
            }
        }

        protected void btnsave3_Click(object sender, EventArgs e)
        {
            string meetingId = HiddenField_MMId.Value; // Retrieve MM_Id
            
            if (string.IsNullOrEmpty(meetingId) && ViewState["MM_Id"] != null)
            {
                meetingId = ViewState["MM_Id"].ToString();
            }

            if (string.IsNullOrEmpty(meetingId))
            {
                lbl_btnsave3.Text = "Error: Meeting ID is missing!";
                lbl_btnsave3.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction(); // Use transaction for atomicity

                try
                {
                    // Step 1: Retrieve RegionCode & LocationCode from Meeting Table
                    string regionCode = "";
                    string locationCode = "";

                    string fetchQuery = @"SELECT RegionCode, LocationCode FROM csm_massmeting_records WHERE MM_Id = @MM_Id";
                    using (SqlCommand fetchCmd = new SqlCommand(fetchQuery, conn, transaction))
                    {
                        fetchCmd.Parameters.AddWithValue("@MM_Id", meetingId);
                        SqlDataReader reader = fetchCmd.ExecuteReader();
                        if (reader.Read())
                        {
                            regionCode = reader["RegionCode"].ToString();
                            locationCode = reader["LocationCode"].ToString();
                        }
                        reader.Close();
                    }


                    foreach (GridViewRow row in GridView1.Rows)
                    {
                        string momId = Guid.NewGuid().ToString(); // Unique MOM_Id

                        TextBox txtAgendaTitle = (TextBox)row.FindControl("txtAgendaTitle");
                        TextBox txtDiscussedByCode = (TextBox)row.FindControl("txtDiscussedByCode");
                        DropDownList ddlDiscussionType = (DropDownList)row.FindControl("ddlDiscussionType");
                        DropDownList ddlDeptCode = (DropDownList)row.FindControl("ddlDeptCode");
                        DropDownList ddlCompanyCode = (DropDownList)row.FindControl("ddlCompanyCode");
                        TextBox txtPointBy = (TextBox)row.FindControl("txtPointBy");
                        TextBox txtAgendaDesc = (TextBox)row.FindControl("txtAgendaDesc");
                        TextBox txtAgendaDescAfter = (TextBox)row.FindControl("txtAgendaDescAfter");
                        TextBox txtDuration = (TextBox)row.FindControl("txtDuration");

                        FileUpload fuBefore = (FileUpload)row.FindControl("fuPhotoBefore");
                        FileUpload fuAfter = (FileUpload)row.FindControl("fuPhotoAfter");

                        string photoPathBefore = SaveFile(fuBefore);
                        string photoPathAfter = SaveFile(fuAfter);

                        string insertQuery = @"
                    INSERT INTO csm_massmeting_mom 
                    (MM_Id, MOM_Id, DiscussedByCode, AgendaTitle, PointBy,RegionCode, LocationCode, DiscussionType,DeptCode , CompanyCode, DiscussionDescription1, DiscussionDescription2, Duration, Ref_PhotoBefore, Ref_PhotoAfter, Ref_PhotoPathBefore, Ref_PhotoPathAfter)
                    VALUES 
                    (@MM_Id, @MOM_Id, @DiscussedByCode, @AgendaTitle, @PointBy, @RegionCode, @LocationCode, @DiscussionType, @DeptCode ,@CompanyCode, @DiscussionDescription1, @DiscussionDescription2, @Duration, @Ref_PhotoBefore, @Ref_PhotoAfter, @Ref_PhotoPathBefore, @Ref_PhotoPathAfter)";

                        using (SqlCommand cmd = new SqlCommand(insertQuery, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                            cmd.Parameters.AddWithValue("@MOM_Id", momId);
                            cmd.Parameters.AddWithValue("@DiscussedByCode", txtDiscussedByCode.Text);
                            cmd.Parameters.AddWithValue("@AgendaTitle", txtAgendaTitle.Text);
                            cmd.Parameters.AddWithValue("@PointBy", txtPointBy.Text);
                            cmd.Parameters.AddWithValue("@RegionCode", regionCode); // Retrieved from Meeting table
                            cmd.Parameters.AddWithValue("@LocationCode", locationCode);// Retrieved from Meeting table
                            cmd.Parameters.AddWithValue("@DiscussionType", ddlDiscussionType.SelectedValue);
                            cmd.Parameters.AddWithValue("@CompanyCode", ddlCompanyCode.SelectedValue);
                            cmd.Parameters.AddWithValue("@DeptCode", ddlDeptCode.SelectedValue);
                            cmd.Parameters.AddWithValue("@DiscussionDescription1", txtAgendaDesc.Text);
                            cmd.Parameters.AddWithValue("@DiscussionDescription2", txtAgendaDescAfter.Text);
                            cmd.Parameters.AddWithValue("@Duration", txtDuration.Text);
                            cmd.Parameters.AddWithValue("@Ref_PhotoBefore", Path.GetFileName(photoPathBefore));
                            cmd.Parameters.AddWithValue("@Ref_PhotoAfter", Path.GetFileName(photoPathAfter));
                            cmd.Parameters.AddWithValue("@Ref_PhotoPathBefore", photoPathBefore);
                            cmd.Parameters.AddWithValue("@Ref_PhotoPathAfter", photoPathAfter);

                            cmd.ExecuteNonQuery();
                        }
                    }

                    transaction.Commit();
                    lbl_btnsave3.Text = "Points saved successfully!";
                    lbl_btnsave3.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lbl_btnsave3.Text = "Error: " + ex.Message;
                    lbl_btnsave3.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        private string SaveFile(FileUpload fileUpload)
        {
            if (fileUpload.HasFile)
            {
                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string filePath = folderPath + fileUpload.FileName;
                fileUpload.SaveAs(filePath);
                return "~/Uploads/" + fileUpload.FileName;
            }
            return "";
        }

        protected void rbEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlAttendeeType.Visible = rbEmployee.SelectedValue == "Yes";
            pnlDetails.Visible = rbEmployee.SelectedValue == "No";
        }

        protected void rbAttendeeType_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool isInternal = rbAttendeeType.SelectedValue == "Internal";
            txtAttendeeCode.Text = isInternal ? "" : "N/A";
            txtAttendeeCode.Enabled = isInternal;
            pnlDetails.Visible = true;
        }
       
        
        protected void btnAddAttendees_Click(object sender, EventArgs e)
        {
            DataTable dt;
            if (ViewState["Attendees"] == null)
            {
                dt = new DataTable();
                dt.Columns.Add("EmployeeOrNot");
                dt.Columns.Add("EmployeeName");
                dt.Columns.Add("AttendeeCode");
                dt.Columns.Add("GatePassNo");
                dt.Columns.Add("AttendeeType");
                dt.Columns.Add("Designation");
                dt.Columns.Add("ImagePath"); // New column for image path
            }
            else
            {
                dt = (DataTable)ViewState["Attendees"];
            }
            string imagePath = "";
            if (imgupload.HasFile)
            {
                string fileExtension = Path.GetExtension(imgupload.FileName).ToLower();
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblMsg1.Text = "Error: Only JPG, JPEG, and PNG files are allowed.";
                    lblMsg1.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
                string fileName = Path.GetFileName(imgupload.FileName);
                imagePath = "~/Uploads/" + fileName;
                imgupload.SaveAs(folderPath + fileName);
            }


            DataRow dr = dt.NewRow();
            dr["EmployeeOrNot"] = rbEmployee.SelectedItem != null ? rbEmployee.SelectedItem.Text : "";
            dr["AttendeeType"] = rbAttendeeType.SelectedItem != null ? rbAttendeeType.SelectedItem.Text : "";
            dr["EmployeeName"] = txtEmployeeName.Text.Trim();
            dr["AttendeeCode"] = txtAttendeeCode.Text.Trim();
            dr["GatePassNo"] = txtgatepassno.Text.Trim();
            dr["Designation"] = txtdes.Text.Trim();
            dr["ImagePath"] = imagePath; // Store image path
            dt.Rows.Add(dr);

            ViewState["Attendees"] = dt;
            gvAttendees.DataSource = dt;
            gvAttendees.DataBind();

            // Clear input fields for next attendee
            rbEmployee.ClearSelection();
            rbAttendeeType.ClearSelection();
            txtEmployeeName.Text = "";
            txtAttendeeCode.Text = "";
            txtgatepassno.Text = "";
            txtdes.Text = "";
        }

        protected void btnsave2_Click(object sender, EventArgs e)
        {
            // Ensure GridView has data
            if (gvAttendees.Rows.Count > 0)
            {
                // Retrieve MM_Id from the first div (assuming it's stored in a hidden field)
                string meetingId = HiddenField_MMId.Value; // Make sure you set this value when saving Meeting records

                if (string.IsNullOrEmpty(meetingId) && ViewState["MM_Id"] != null)
                {
                    meetingId = ViewState["MM_Id"].ToString();
                }

                // ✅ Debugging: Show what MM_Id is retrieved
                lbl_btnsave22.Text = $"Retrieved Meeting ID: {meetingId}";

                if (string.IsNullOrEmpty(meetingId))
                {
                    lbl_btnsave22.Text = "Error: Meeting ID is missing!";
                    lbl_btnsave22.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Initialize variables for comma-separated values
                List<string> attendeeCodes = new List<string>();
                List<string> employeeNames = new List<string>();
                List<string> attendeeTypes = new List<string>();
                List<string> designations = new List<string>();
                List<string> gatePassNos = new List<string>();
                List<string> imagePaths = new List<string>();

                // Iterate through GridView rows and collect data
                foreach (GridViewRow row in gvAttendees.Rows)
                {
                    attendeeCodes.Add(row.Cells[3].Text.Trim()); // AttendeeCode
                    employeeNames.Add(row.Cells[2].Text.Trim()); // EmployeeName
                    attendeeTypes.Add(row.Cells[1].Text.Trim()); // Attendee_Type
                    designations.Add(row.Cells[5].Text.Trim()); // Designation
                    gatePassNos.Add(row.Cells[4].Text.Trim()); // Gate Pass No
                    Image imgControl = (Image)row.FindControl("imgPreview");
                    if (imgControl != null && !string.IsNullOrEmpty(imgControl.ImageUrl))
                    {
                        imagePaths.Add(imgControl.ImageUrl);
                    }
                }

                // Convert lists to comma-separated strings
                string strAttendeeCodes = string.Join(",", attendeeCodes);
                string strEmployeeNames = string.Join(",", employeeNames);
                string strAttendeeTypes = string.Join(",", attendeeTypes);
                string strDesignations = string.Join(",", designations);
                string strGatePassNos = string.Join(",", gatePassNos);
                string strImagePaths = string.Join(",", imagePaths);

                
                // Database connection
                string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = @"INSERT INTO csm_massmeting_attendee 
                            (MM_Id, AttendeeCode, EmployeeName, Attendee_Type, Designation, Gate_passno,Image_upload) 
                            VALUES (@MM_Id, @AttendeeCode, @EmployeeName, @Attendee_Type, @Designation, @Gate_passno,@Image_upload)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                        cmd.Parameters.AddWithValue("@AttendeeCode", strAttendeeCodes);
                        cmd.Parameters.AddWithValue("@EmployeeName", strEmployeeNames);
                        cmd.Parameters.AddWithValue("@Attendee_Type", strAttendeeTypes);
                        cmd.Parameters.AddWithValue("@Designation", strDesignations);
                        cmd.Parameters.AddWithValue("@Gate_passno", strGatePassNos);
                        cmd.Parameters.Add("@Image_upload", SqlDbType.NVarChar).Value = strImagePaths;

                       
                        int rowsInserted = cmd.ExecuteNonQuery();
                        if (rowsInserted > 0)
                        {
                            lbl_btnsave22.Text = "Attendees saved successfully!";
                            lbl_btnsave22.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            lbl_btnsave22.Text = "Failed to save attendees!";
                            lbl_btnsave22.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
            else
            {
                lbl_btnsave22.Text = "No attendees to save!";
                lbl_btnsave22.ForeColor = System.Drawing.Color.Red;
            }
        }
        protected void btnsave4_Click(object sender, EventArgs e)
        {
            string meetingId = HiddenField_MMId.Value; // Make sure you set this value when saving Meeting records

            if (string.IsNullOrEmpty(meetingId) && ViewState["MM_Id"] != null)
            {
                meetingId = ViewState["MM_Id"].ToString();
            }

            // ✅ Debugging: Show what MM_Id is retrieved
            lbl_btnsave44.Text = $"Retrieved Meeting ID: {meetingId}";

            if (string.IsNullOrEmpty(meetingId))
            {
                lbl_btnsave44.Text = "Error: Meeting ID is missing!";
                lbl_btnsave44.ForeColor = System.Drawing.Color.Red;
                return;
            }
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO csm_massmeeting_feedback (FeedbackByName, FeedbackDescription, Rating, MM_Id) VALUES (@FeedbackByName, @FeedbackDescription, @Rating, @MM_Id)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FeedbackByName", txtfeedname.Text.Trim());
                    cmd.Parameters.AddWithValue("@FeedbackDescription", txtfeeddesc.Text.Trim());
                    cmd.Parameters.AddWithValue("@Rating", ddlRating.SelectedValue);
                    cmd.Parameters.AddWithValue("@MM_Id", meetingId); // Replace with actual MM_Id source

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        lbl_btnsave44.Text = "Feedback saved successfully!";
                        lbl_btnsave44.ForeColor = System.Drawing.Color.Green;
                    }
                    catch (Exception ex)
                    {
                        lbl_btnsave44.Text = "Error: " + ex.Message;
                        lbl_btnsave44.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("csm_massmeeting_record.aspx");

        }
    }
}