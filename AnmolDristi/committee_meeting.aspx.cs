using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
           
        }
       

        [WebMethod]
        public static object GetAttendeeDetails(string attendeeCode)
        {
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT Name, Designation FROM Committee_MeetingAttendance WHERE AttendeeCode = @AttendeeCode";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@AttendeeCode", attendeeCode);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        return new
                        {
                            success = true,
                            name = reader["Name"].ToString(),
                            designation = reader["Designation"].ToString()
                        };
                    }
                    else
                    {
                        return new { success = false, message = "Attendee Code not found!" };
                    }
                }
            }
        }

       

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

            // Ensure ViewState["Attendees"] is initialized
            if (ViewState["Attendance"] == null)
            {
                dt = new DataTable();
                dt.Columns.Add("SNo");
               
                dt.Columns.Add("EmployeeName");
                dt.Columns.Add("AttendeeCode"); // Ensure AttendeeCode exists
                dt.Columns.Add("AttendanceStatus");
                dt.Columns.Add("AttendeeType");
                dt.Columns.Add("Designation");
               // dt.Columns.Add("ImagePath"); // Ensure ImagePath exists

                ViewState["Attendance"] = dt;
            }
            else
            {
                dt = (DataTable)ViewState["Attendance"];

                // Ensure all necessary columns exist before using them
                string[] requiredColumns = { "SNo", "EmployeeOrNot", "EmployeeName", "AttendeeCode", "AttendanceStatus", "AttendeeType", "Designation", "ImagePath" };
                foreach (string column in requiredColumns)
                {
                    if (!dt.Columns.Contains(column))
                    {
                        dt.Columns.Add(column);
                    }
                }
            }


            //string imagePath = "";
            //if (imgupload.HasFile)
            //{
            //    string fileExtension = Path.GetExtension(imgupload.FileName).ToLower();
            //    if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
            //    {
            //        lblMsg1.Text = "Error: Only JPG, JPEG, and PNG files are allowed.";
            //        lblMsg1.ForeColor = System.Drawing.Color.Red;
            //        return;
            //    }

            //    string folderPath = Server.MapPath("~/Uploads1/");
            //    if (!Directory.Exists(folderPath))
            //    {
            //        Directory.CreateDirectory(folderPath);
            //    }
            //    string fileName = Path.GetFileName(imgupload.FileName);
            //    imagePath = "~/Uploads1/" + fileName;
            //    imgupload.SaveAs(folderPath + fileName);
            //}
            // Generating SNo dynamically
            int serialNo = dt.Rows.Count + 1;

            DataRow dr = dt.NewRow();
            dr["SNo"] = serialNo;
            
            dr["AttendeeType"] = rbAttendeeType.SelectedItem != null ? rbAttendeeType.SelectedItem.Text : "";
            dr["EmployeeName"] = txtEmployeeName.Text.Trim();
            dr["AttendeeCode"] = txtAttendeeCode.Text.Trim();
            dr["AttendanceStatus"] = ddlAttendanceStatus.SelectedValue;
            dr["Designation"] = txtdes.Text.Trim();
            //dr["ImagePath"] = imagePath; // Store image path
            dt.Rows.Add(dr);

            ViewState["Attendance"] = dt;
            gvAttendees.DataSource = dt;
            gvAttendees.DataBind();

            // Clear input fields for next attendee
            
            rbAttendeeType.ClearSelection();
            ddlAttendanceStatus.SelectedIndex = 0;
            txtEmployeeName.Text = "";
            txtAttendeeCode.Text = "";
            txtdes.Text = "";


            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "showSuccessMessage();", true);
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
                dts.Columns.Add("ActionBy");
                dts.Columns.Add("TargetDate");
                dts.Columns.Add("ReviewDate");
                dts.Columns.Add("ReviewBy");
                dts.Columns.Add("Status");
            }
            else
            {
                dts = (DataTable)ViewState["Issues"];
            }
            // Generating SNo dynamically
            int serialNo = dts.Rows.Count + 1;
            string allIssues = hdnPointsDiscussed.Value.Trim();

            DataRow dr = dts.NewRow();
            dr["SNo"] = serialNo;
            dr["AgendaTitle"] = txtAgendaTitle.Text.Trim();
            dr["ActionBy"] = txtActionBy.Text.Trim();
            dr["IssuesDiscussed"] = allIssues;
            dr["TargetDate"] = txtTargetDate.Text.Trim();
            dr["ReviewDate"] = txtReviewDate.Text.Trim();
            dr["ReviewBy"] = txtReviewBy.Text.Trim();
            dr["Status"] = ddlStatus.SelectedValue;
            dts.Rows.Add(dr);

            ViewState["Issues"] = dts;
            gvIssues.DataSource = dts;
            gvIssues.DataBind();

            // Clear input fields for next attendee
            txtActionBy.Text = "";
            txtAgendaTitle.Text="";
            txtReviewBy.Text = "";
            txtTargetDate.Text = "";
            txtIssuesDes.Text = "";
            hdnPointsDiscussed.Value = "";
            txtReviewDate.Text = "";
            ddlStatus.SelectedIndex = 0;


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
                        // Validate file extension (optional but recommended)
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
                            Directory.CreateDirectory(uploadFolder); // Create folder if not exists

                            string filePath = Path.Combine(uploadFolder, fileName);
                            imgupload.SaveAs(filePath);

                            // Save relative path to DB
                            imagePath = "~/Uploads1/" + fileName;

                            // Optional session store
                            Session["UploadedFilePath"] = filePath;
                        }
                        catch (Exception ex)
                        {
                            lblBeforeError.Text = "File upload failed: " + ex.Message;
                            lblBeforeError.Style["display"] = "block";
                            return;
                        }
                    }


                    

                    // 1. Insert into Committee_MeetingReview (Parent Table)
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
                        //cmd.Parameters.AddWithValue("@Image_upload", (object)imagePath ?? DBNull.Value);

                        if (!string.IsNullOrEmpty(imagePath))
                            cmd.Parameters.AddWithValue("@Image_upload", imagePath);
                        else
                            cmd.Parameters.AddWithValue("@Image_upload", DBNull.Value);


                        meetingID = (int)cmd.ExecuteScalar(); // Get newly inserted MeetingID
                    }

                    // 2. Insert into Committee_MeetingAttendance (Attendees GridView)
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
                               // cmd.Parameters.AddWithValue("@Image_upload", row["ImagePath"].ToString());
                                cmd.Parameters.AddWithValue("@AttendanceStatus", row["AttendanceStatus"].ToString());


                                cmd.ExecuteNonQuery();
                            }
                        }
                    }

                    // 3. Insert into Committee_MeetingIssues (Issues GridView)
                    if (ViewState["Issues"] != null)
                    {
                        DataTable dtIssues = (DataTable)ViewState["Issues"];
                        foreach (DataRow row in dtIssues.Rows)
                        {
                            string insertIssueQuery = @"INSERT INTO Committee_MeetingIssues (MeetingID, IssueDescription, ResponsiblePerson, TargetDate, ReviewDate, AgendaTitle, Status,ReviewBy)
                                                VALUES (@MeetingID, @IssueDescription, @ResponsiblePerson, @TargetDate, @ReviewDate, @AgendaTitle, @Status,@ReviewBy)";

                            using (SqlCommand cmd = new SqlCommand(insertIssueQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                                cmd.Parameters.AddWithValue("@IssueDescription", row["IssuesDiscussed"].ToString());
                                cmd.Parameters.AddWithValue("@ResponsiblePerson", row["ActionBy"].ToString());
                                cmd.Parameters.AddWithValue("@TargetDate", Convert.ToDateTime(row["TargetDate"]));
                                cmd.Parameters.AddWithValue("@ReviewDate", Convert.ToDateTime(row["ReviewDate"]));
                                cmd.Parameters.AddWithValue("@AgendaTitle", row["AgendaTitle"].ToString());
                                cmd.Parameters.AddWithValue("@Status", row["Status"].ToString());
                                cmd.Parameters.AddWithValue("@ReviewBy", row["ReviewBy"].ToString());

                                cmd.ExecuteNonQuery();
                            }
                        }
                    }

                    transaction.Commit(); // Commit if everything is successful
                    lblMsg.Text = "Data saved successfully!";
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "showSuccess();", true);
                }
                catch (Exception ex)
                {
                    transaction.Rollback(); // Rollback if any error occurs
                    lblMsg.Text = "Error: " + ex.Message;
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
        }



    }



}