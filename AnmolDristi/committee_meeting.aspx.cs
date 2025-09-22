using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity.Core.Metadata.Edm;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class committee_meeting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                txtEmployeeName.Text = txtEmployeeName.Text.Trim();  // already set by JS
                txtdes.Text = txtdes.Text.Trim();
            }

        }
        [System.Web.Services.WebMethod]
        public static object GetAttendeeDetails(string empCode)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string empName = "";
            string deptId = "";

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT EmployeeName, DepartmentId FROM MST_UserMaster WHERE EmployeeCode = @EmployeeCode";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeCode", empCode);
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            empName = reader["EmployeeName"].ToString();
                            deptId = reader["DepartmentId"].ToString();
                        }
                    }
                }
            }

            return new
            {
                EmployeeName = empName,
                Designation = deptId
            };
        }


        //[WebMethod]
        //public static object GetAttendeeDetails(string attendeeCode)
        //{
        //    string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //    using (SqlConnection conn = new SqlConnection(connString))
        //    {
        //        string query = "SELECT Name, Designation FROM Committee_MeetingAttendance WHERE AttendeeCode = @AttendeeCode";
        //        using (SqlCommand cmd = new SqlCommand(query, conn))
        //        {
        //            cmd.Parameters.AddWithValue("@AttendeeCode", attendeeCode);
        //            conn.Open();
        //            SqlDataReader reader = cmd.ExecuteReader();

        //            if (reader.Read())
        //            {
        //                return new
        //                {
        //                    success = true,
        //                    name = reader["Name"].ToString(),
        //                    designation = reader["Designation"].ToString()
        //                };
        //            }
        //            else
        //            {
        //                return new { success = false, message = "Attendee Code not found!" };
        //            }
        //        }
        //    }
        //}

        protected void rbAttendeeType_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool isInternal = rbAttendeeType.SelectedValue == "Internal";
            txtAttendeeCode.Text = isInternal ? "" : "N/A";
            txtAttendeeCode.Enabled = isInternal;
            pnlDetails.Visible = true;
            pnlDetails1.Visible = true;
        }
        protected void btnAddAttendees_Click(object sender, EventArgs e)
        {

            lblMsg1.Text = "";
            DataTable dt;

            
            if (ViewState["Attendance"] == null)
            {
                dt = new DataTable();
                dt.Columns.Add("SNo");
                dt.Columns.Add("EmployeeName");
                dt.Columns.Add("AttendeeCode");
                dt.Columns.Add("AttendanceStatus");
                dt.Columns.Add("AttendeeType");
                dt.Columns.Add("Designation");
                //dt.Columns.Add("ImagePath");
                //dt.Columns.Add("EmployeeOrNot");

                ViewState["Attendance"] = dt;
            }
            else
            {
                dt = (DataTable)ViewState["Attendance"];
            }

            
            string attendeeCode = txtAttendeeCode.Text.Trim();
            string employeeName = txtEmployeeName.Text.Trim();
            string attendanceStatus = ddlAttendanceStatus.SelectedValue;
            string attendeeType = rbAttendeeType.SelectedValue;
            string designation = txtdes.Text.Trim();
            //string imagePath = ""; 
            //string employeeOrNot = chkEmployee.Checked ? "Yes" : "No";


            // Duplicate check
            if (attendeeCode != "N/A") // internal employee
            {
                DataRow[] existingRows = dt.Select("AttendeeCode = '" + attendeeCode.Replace("'", "''") + "'");
                if (existingRows.Length > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotify",
                        "new PNotify({ title: 'Warning', text: 'This employee is already added!', type: 'warning', styling: 'bootstrap3', delay: 2000 });", true);
                    return;
                }
            }
            else // external attendee
            {
                string filter = "EmployeeName = '" + employeeName.Replace("'", "''") + "' AND Designation = '" + designation.Replace("'", "''") + "'";
                DataRow[] existingRows = dt.Select(filter);
                if (existingRows.Length > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotify",
                        "new PNotify({ title: 'Warning', text: 'This external attendee is already added!', type: 'warning', styling: 'bootstrap3', delay: 2000 });", true);
                    return;
                }
            }

            // Add new row
            DataRow dr = dt.NewRow();
            dr["SNo"] = dt.Rows.Count + 1;
            dr["EmployeeName"] = employeeName;
            dr["AttendeeCode"] = attendeeCode;
            dr["AttendanceStatus"] = attendanceStatus;
            dr["AttendeeType"] = attendeeType;
            dr["Designation"] = designation;
            //dr["ImagePath"] = imagePath;
            //dr["EmployeeOrNot"] = employeeOrNot;

            dt.Rows.Add(dr);
            ViewState["Attendance"] = dt;

            gvAttendees.DataSource = dt;
            gvAttendees.DataBind();



            // Bind to "Point Raised By" dropdown 
            ddlPointRaisedBy.DataSource = dt;
            ddlPointRaisedBy.DataTextField = "EmployeeName";   // show name
            ddlPointRaisedBy.DataValueField = "AttendeeCode";  // keep code as value
            ddlPointRaisedBy.DataBind();

            foreach (ListItem item in ddlPointRaisedBy.Items)
            {
                if (!string.IsNullOrEmpty(item.Value) && item.Value != "N/A")
                {
                    // Internal employee: show Name (Code)
                    item.Text = item.Text + " (" + item.Value + ")";
                }
                else if (item.Value == "N/A")
                {
                    // External attendee: show Name (N/A)
                    item.Text = item.Text + " (N/A)";
                }
            }



            ddlPointRaisedBy.Items.Insert(0, new ListItem("-- Select Attendee --", ""));




            // Success notify
            ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotifySuccess",
                "new PNotify({ title: 'Success', text: 'Attendee added successfully!', type: 'success', styling: 'bootstrap3', delay: 2000 });", true);


        }

        protected void btnAddIssues_Click(object sender, EventArgs e)
        {
            lblMsg2.Text = "";
            DataTable dts;

            if (ViewState["Issues"] == null)
            {
                dts = new DataTable();
                dts.Columns.Add("SNo");
                dts.Columns.Add("AgendaTitle");
                dts.Columns.Add("IssuesDiscussed");
                dts.Columns.Add("Capa_Report"); 
                dts.Columns.Add("ActionBy");
                dts.Columns.Add("TargetDate");
                dts.Columns.Add("ReviewDate");
                dts.Columns.Add("ReviewBy");     
                dts.Columns.Add("ReviewByCode"); 
                dts.Columns.Add("Status");
                dts.Columns.Add("Responsiblity");
            }
            else
            {
                dts = (DataTable)ViewState["Issues"];
            }

            string capaStatus = chkQ3CAPA.Checked ? "Checked" : "";

            int serialNo = dts.Rows.Count + 1;
            //string allIssues = hdnPointsDiscussed.Value.Trim();

            DataRow dr = dts.NewRow();
            dr["SNo"] = serialNo;
            dr["AgendaTitle"] = txtAgendaTitle.Text.Trim();
            dr["IssuesDiscussed"] = txtIssuesDes.Text;
            dr["Capa_Report"] = capaStatus; 
            dr["ActionBy"] = txtActionBy.Text.Trim();
            dr["TargetDate"] = txtTargetDate.Text.Trim();
            dr["ReviewDate"] = txtReviewDate.Text.Trim();
            //  Save both attendee text and value
            dr["ReviewBy"] = ddlPointRaisedBy.SelectedItem != null ? ddlPointRaisedBy.SelectedItem.Text : "";
            dr["ReviewByCode"] = ddlPointRaisedBy.SelectedValue ?? "";
            dr["Status"] = ddlStatus.SelectedValue;
            dr["Responsiblity"] = txtResponsiblePerson.Text.Trim();

            dts.Rows.Add(dr);

            ViewState["Issues"] = dts;
            gvIssues.DataSource = dts;
            gvIssues.DataBind();

            // Clear input fields 
            txtAgendaTitle.Text = "";
            txtIssuesDes.Text = "";
            hdnPointsDiscussed.Value = "";
            txtActionBy.Text = "";
            ddlPointRaisedBy.SelectedIndex = 0;
            txtTargetDate.Text = "";
            txtReviewDate.Text = "";
            ddlStatus.SelectedIndex = 0;
            chkQ3CAPA.Checked = true; 

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

        protected void BtnDelAttendees_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            if (gvAttendees.DataKeys.Count == 0 || row.RowIndex < 0 || row.RowIndex >= gvAttendees.DataKeys.Count)
            {
                return; // Prevent out-of-range errors
            }

            int sNo = Convert.ToInt32(gvAttendees.DataKeys[row.RowIndex].Value);
            DataTable dt = ViewState["Attendance"] as DataTable;

            if (dt != null)
            {
                DataRow[] rows = dt.Select("SNo=" + sNo);
                if (rows.Length > 0)
                {
                    dt.Rows.Remove(rows[0]);
                    dt.AcceptChanges();
                }

                // **Renumber SNo** after deletion
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SNo"] = i + 1; // Reset SNo from 1 to N
                }

                if (dt.Rows.Count == 0)
                {
                    ViewState["Attendance"] = null;
                    gvAttendees.DataSource = null;
                    gvAttendees.DataBind();
                }
                else
                {
                    ViewState["Attendance"] = dt;
                    gvAttendees.DataSource = dt;
                    gvAttendees.DataBind();
                }
            }
        }
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("committee_meeting.aspx");
        }
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            lblMsg.Text = "";
            bool hasError = false;
            if (ViewState["Issues"] == null)
            {
                lblMsg.Text = "No Meeting Issues to save.Please Add Issues";
                lblMsg2.Text = "Please Add Issues";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg2.ForeColor = System.Drawing.Color.Red;
                hasError = true;
            }
            if (ViewState["Attendance"] == null)
            {
                lblMsg.Text = "No Meeting Attendance to save.Please Add Attendees";
                lblMsg1.Text = "Please Add Attendees";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg1.ForeColor = System.Drawing.Color.Red;
                hasError = true;
            }

            if (hasError)
            {
                BtnSubmit.Enabled = true; // Re-enable button
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction(); // Start transaction

                try
                {
                    string imagePath = null;

                    if (imgupload.HasFile)
                    {
                        string extension = Path.GetExtension(imgupload.FileName).ToLower();
                        if (extension != ".jpg" && extension != ".jpeg" && extension != ".png")
                        {
                            lblBeforeError.Text = "Only JPG, JPEG, and PNG files are allowed.";
                            lblBeforeError.Style["display"] = "block";
                            return;
                        }

                        try
                        {
                            string fileName = Path.GetFileName(imgupload.FileName);
                            string uploadFolder = Server.MapPath("~/Uploads1/");
                            Directory.CreateDirectory(uploadFolder);

                            string filePath = Path.Combine(uploadFolder, fileName);
                            imgupload.SaveAs(filePath);
                            imagePath = "~/Uploads1/" + fileName;
                            Session["UploadedFilePath"] = filePath;
                        }
                        catch (Exception ex)
                        {
                            lblBeforeError.Text = "File upload failed: " + ex.Message;
                            lblBeforeError.Style["display"] = "block";
                            return;
                        }
                    }

                    string insertMeetingQuery = @"INSERT INTO Committee_MeetingReview (MeetingNo,Title,JobID,MeetingDate, MeetingTime, Venue, ChairedBy,Image_upload) 
                                  OUTPUT INSERTED.MeetingID 
                                  VALUES (@MeetingNo, @Title,@JobID, @MeetingDate, @MeetingTime, @Venue, @ChairedBy,@Image_upload)";

                    int meetingID;
                    using (SqlCommand cmd = new SqlCommand(insertMeetingQuery, conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@MeetingNo", txtMeetingNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@Title", "Internal Safety Committee meeting");
                        cmd.Parameters.AddWithValue("@MeetingDate", Convert.ToDateTime(txtdate.Text.Trim()));
                        cmd.Parameters.AddWithValue("@MeetingTime", TimeSpan.Parse(txtTime.Text.Trim()));
                        cmd.Parameters.AddWithValue("@Venue", txtVenue.Text.Trim());
                        cmd.Parameters.AddWithValue("@ChairedBy", txtChairedBy.Text.Trim());
                        cmd.Parameters.AddWithValue("@JobID", txtjobID.Text.Trim());
                        if (!string.IsNullOrEmpty(imagePath))
                            cmd.Parameters.AddWithValue("@Image_upload", imagePath);
                        else
                            cmd.Parameters.AddWithValue("@Image_upload", DBNull.Value);

                        meetingID = (int)cmd.ExecuteScalar();
                        System.Diagnostics.Debug.WriteLine("Meeting Inserted with ID: " + meetingID);
                    }

                    if (ViewState["Attendance"] != null)
                    {
                        DataTable dtAttendees = (DataTable)ViewState["Attendance"];
                        foreach (DataRow row in dtAttendees.Rows)
                        {
                            string insertAttendeeQuery = @"INSERT INTO Committee_MeetingAttendance (MeetingID, Name, Designation, AttendeeCode, Attendee_Type, AttendanceStatus)
                                           VALUES (@MeetingID, @Name, @Designation, @AttendeeCode, @Attendee_Type, @AttendanceStatus)";

                            using (SqlCommand cmd = new SqlCommand(insertAttendeeQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                                cmd.Parameters.AddWithValue("@Name", row["EmployeeName"].ToString());
                                cmd.Parameters.AddWithValue("@Designation", row["Designation"].ToString());
                                cmd.Parameters.AddWithValue("@AttendeeCode", row["AttendeeCode"].ToString());
                                cmd.Parameters.AddWithValue("@Attendee_Type", row["AttendeeType"].ToString());
                                cmd.Parameters.AddWithValue("@AttendanceStatus", row["AttendanceStatus"].ToString());

                                cmd.ExecuteNonQuery();
                                System.Diagnostics.Debug.WriteLine("Inserted Attendance for: " + row["EmployeeName"].ToString());
                            }
                        }
                    }

                    object capaReportID = DBNull.Value;
                    string customid = "COM-" + meetingID;

                    if (ViewState["Issues"] != null)
                    {
                        DataTable dtIssues = (DataTable)ViewState["Issues"];

                        foreach (DataRow row in dtIssues.Rows)
                        {
                            capaReportID = DBNull.Value; // Reset for each row

                            string tblnme = "Safety Committee Meeting";

                            if (row["Capa_Report"].ToString() == "Checked")
                            {
                                // Insert into CAPA Master table
                                SqlCommand cmdCAPA = new SqlCommand(@"
INSERT INTO tbl_CAPAMaster (HeaderID, AssignedBy, AssignedDate, Description,SourceTable, ResponsiblePerson, TargetCompletionDate)
OUTPUT INSERTED.CAPAID
VALUES (@HeaderID, @AssignedBy, @AssignedDate, @Description,@SourceTable,@ResponsiblePerson, @TargetCompletionDate)", conn, transaction);

                                cmdCAPA.Parameters.AddWithValue("@HeaderID", customid);
                                cmdCAPA.Parameters.AddWithValue("@AssignedBy", Session["UserName"]?.ToString() ?? "");
                                cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                                cmdCAPA.Parameters.AddWithValue("@Description", row["IssuesDiscussed"].ToString());
                                cmdCAPA.Parameters.AddWithValue("@SourceTable", tblnme);
                                cmdCAPA.Parameters.AddWithValue("@ResponsiblePerson", row["Responsiblity"].ToString());
                                cmdCAPA.Parameters.AddWithValue("@TargetCompletionDate", row["TargetDate"].ToString());

                                capaReportID = cmdCAPA.ExecuteScalar();
                            }

                            // ✅ Include Capa_Report in the insert query
                            string insertIssueQuery = @"
INSERT INTO Committee_MeetingIssues 
(MeetingID, IssueDescription, CloseBy, TargetDate, CloseDate, AgendaTitle, Status, ReviewBy, HeaderID, Capa_Report,Responsiblity)
VALUES 
(@MeetingID, @IssueDescription, @ResponsiblePerson, @TargetDate, @ReviewDate, @AgendaTitle, @Status, @ReviewBy, @HeaderID, @Capa_Report,@Responsiblity)";

                            using (SqlCommand cmd = new SqlCommand(insertIssueQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                                cmd.Parameters.AddWithValue("@HeaderID", customid);
                                cmd.Parameters.AddWithValue("@IssueDescription", row["IssuesDiscussed"].ToString());
                                cmd.Parameters.AddWithValue("@ResponsiblePerson", row["ActionBy"].ToString());
                                cmd.Parameters.AddWithValue("@TargetDate", Convert.ToDateTime(row["TargetDate"]));
                                cmd.Parameters.AddWithValue("@ReviewDate",
    string.IsNullOrWhiteSpace(row["ReviewDate"]?.ToString())
        ? DBNull.Value
        : (object)Convert.ToDateTime(row["ReviewDate"]));

                                cmd.Parameters.AddWithValue("@AgendaTitle", row["AgendaTitle"].ToString());
                                cmd.Parameters.AddWithValue("@Status", row["Status"].ToString());
                                cmd.Parameters.AddWithValue("@ReviewBy", row["ReviewBy"].ToString());
                                cmd.Parameters.AddWithValue("@Capa_Report", capaReportID ?? DBNull.Value); // Use DBNull if null
                                cmd.Parameters.AddWithValue("@Responsiblity", row["Responsiblity"].ToString());

                                cmd.ExecuteNonQuery();
                            }
                        }
                    }
                    transaction.Commit();
                    
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotifySuccess",
                        "new PNotify({ " +
                        "title: 'Success'," +
                        "text: 'Data saved successfully!'," +
                        "type: 'success'," +
                        "styling: 'bootstrap3'," +
                        "delay: 2000 });", true);

                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    System.Diagnostics.Debug.WriteLine("Transaction Error: " + ex.Message);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotifyError",
                        "new PNotify({ " +
                        "title: 'Error'," +
                        "text: '" + ex.Message.Replace("'", "\\'") + "'," + 
                        "type: 'error'," +
                        "styling: 'bootstrap3'," +
                        "delay: 4000 });", true);
                }
            }
        }

        protected void txtResponsiblePerson_TextChanged(object sender, EventArgs e)
        {
            string empCode = txtResponsiblePerson.Text.Trim();

            if (!string.IsNullOrEmpty(empCode))
            {
                // Example: Fetch from DB using your TableAdapter or SqlCommand
                string empName = GetEmployeeNameByCode(empCode);

                if (!string.IsNullOrEmpty(empName))
                {
                    lblResponsibleName.Text = empName;
                    lblResponsibleName.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblResponsibleName.Text = "Invalid EmpCode";
                    lblResponsibleName.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        private string GetEmployeeNameByCode(string empCode)
        {
            string empName = string.Empty;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT EmployeeName FROM EmployeeMaster WHERE EmployeeCode = @EmpCode", con))
                {
                    cmd.Parameters.AddWithValue("@EmpCode", empCode);
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
    }
}
















