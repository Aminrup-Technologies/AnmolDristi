using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Committee_meeting_update : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["MeetingID"] != null)
                {
                    int meetingID = Convert.ToInt32(Request.QueryString["MeetingID"]);
                    ViewState["MeetingID"] = meetingID;
                    LoadMeetingDetails(meetingID);
                    LoadAttendance(meetingID);
                    LoadIssues(meetingID);
                }
            }
        }

        private void LoadMeetingDetails(int meetingID)
        {
            string query = @"SELECT MeetingNo, Title, MeetingDate, MeetingTime, Venue, ChairedBy , JobID, Image_upload
                     FROM Committee_MeetingReview 
                     WHERE MeetingID = @MeetingID";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtMeetingNo.Text = reader["MeetingNo"].ToString();
                    txtdate.Text = Convert.ToDateTime(reader["MeetingDate"]).ToString("yyyy-MM-dd");
                    txtTime.Text = TimeSpan.Parse(reader["MeetingTime"].ToString()).ToString(@"hh\:mm");
                    txtVenue.Text = reader["Venue"].ToString();
                    txtChairedBy.Text = reader["ChairedBy"].ToString();
                    txtjobID.Text = reader["JobID"].ToString();
                    if (reader["Image_upload"] != DBNull.Value)
                    {
                        string imgPath = reader["Image_upload"].ToString();
                        imgPreview.ImageUrl = ResolveUrl(imgPath);
                        imgPreview.Visible = true;

                        // Save path in ViewState for use during update
                        ViewState["ExistingImagePath"] = imgPath;
                    }
                }
            }
        }
       

        private void LoadAttendance(int meetingID)
        {
            string query = @"SELECT Name , Designation, AttendeeCode, Attendee_Type , 
                             AttendanceStatus , AttendanceID
                     FROM Committee_MeetingAttendance 
                     WHERE MeetingID = @MeetingID";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvAttendees.DataSource = dt;
                    gvAttendees.DataBind();
                }
            }
        }
        private void LoadIssues(int meetingID)
        {
            string query = @"SELECT IssueID , AgendaTitle, IssueDescription AS IssuesDiscussed, 
                            CloseBy AS ActionBy, TargetDate, CloseDate, ReviewBy, Status, Responsiblity, Capa_Report 
                     FROM Committee_MeetingIssues 
                     WHERE MeetingID = @MeetingID";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvIssues.DataSource = dt;
                    gvIssues.DataBind();
                }
            }
        }

        //protected void BtnDelAttendees_Click(object sender, EventArgs e)
        //{
        //    Button btn = (Button)sender;
        //    GridViewRow row = (GridViewRow)btn.NamingContainer;


        //    string attendeeId = gvAttendees.DataKeys[row.RowIndex].Value.ToString();

        //    if (!string.IsNullOrEmpty(attendeeId))
        //    {
        //        string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //        using (SqlConnection con = new SqlConnection(connectionString))
        //        {
        //            string query = "DELETE FROM Committee_MeetingAttendance WHERE AttendanceID = @AttendanceID";
        //            using (SqlCommand cmd = new SqlCommand(query, con))
        //            {
        //                cmd.Parameters.AddWithValue("@AttendanceID", attendeeId);
        //                con.Open();
        //                cmd.ExecuteNonQuery();
        //                con.Close();
        //            }
        //        }

        //        if (Request.QueryString["MeetingID"] != null)
        //        {
        //            int meetingID = Convert.ToInt32(Request.QueryString["MeetingID"]);
        //            LoadAttendance(meetingID);  
        //        }
        //    }
        //}

        protected void BtnDelAttendees_Click(object sender, EventArgs e)
        {
            // Prevent deletion if only 1 attendee is left
            if (gvAttendees.Rows.Count <= 1)
            {
                lblMsg.Text = "At least one attendee must remain. Deletion cancelled.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            string attendeeId = gvAttendees.DataKeys[row.RowIndex].Value.ToString();

            if (!string.IsNullOrEmpty(attendeeId))
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Committee_MeetingAttendance WHERE AttendanceID = @AttendanceID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@AttendanceID", attendeeId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                if (Request.QueryString["MeetingID"] != null)
                {
                    int meetingID = Convert.ToInt32(Request.QueryString["MeetingID"]);
                    LoadAttendance(meetingID);
                }

                lblMsg.Text = "Attendee deleted successfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMsg.Text = "Failed to delete: AttendanceID is empty.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void BtnDelIssues_Click(object sender, EventArgs e)
        {
            // Ensure there's more than one row
            if (gvIssues.Rows.Count <= 1)
            {
                lblMsg.Text = "At least one issue must remain. Deletion cancelled.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            // Use DataKeys to get the SNo (IssueID)
            string issueId = gvIssues.DataKeys[row.RowIndex].Value.ToString();

            if (!string.IsNullOrEmpty(issueId))
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM Committee_MeetingIssues WHERE IssueID = @IssueID";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@IssueID", issueId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                // Reload issues
                if (Request.QueryString["MeetingID"] != null)
                {
                    int meetingID = Convert.ToInt32(Request.QueryString["MeetingID"]);
                    LoadIssues(meetingID);
                }

                lblMsg.Text = "Issue deleted successfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMsg.Text = "Failed to delete: IssueID is empty.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        //protected void BtnDelIssues_Click(object sender, EventArgs e)
        //{
        //    Button btn = (Button)sender;
        //    GridViewRow row = (GridViewRow)btn.NamingContainer;

        //    // Use DataKeys to get the SNo (IssueID)
        //    string issueId = gvIssues.DataKeys[row.RowIndex].Value.ToString();

        //    if (!string.IsNullOrEmpty(issueId))
        //    {
        //        string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //        using (SqlConnection con = new SqlConnection(connectionString))
        //        {
        //            string query = "DELETE FROM Committee_MeetingIssues WHERE IssueID = @IssueID";
        //            using (SqlCommand cmd = new SqlCommand(query, con))
        //            {
        //                cmd.Parameters.AddWithValue("@IssueID", issueId);
        //                con.Open();
        //                cmd.ExecuteNonQuery();
        //                con.Close();
        //            }
        //        }

        //        // Reload issues
        //        if (Request.QueryString["MeetingID"] != null)
        //        {
        //            int meetingID = Convert.ToInt32(Request.QueryString["MeetingID"]);
        //            LoadIssues(meetingID);
        //        }
        //    }
        //}
        protected void Btnback_Click(object sender, EventArgs e)
        {
            Response.Redirect("committee_meeting_report.aspx");
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int meetingID = Convert.ToInt32(Request.QueryString["MeetingID"]);

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                SqlTransaction transaction = con.BeginTransaction();

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
                    else
                    {
                        // Keep existing image path from session or DB
                        imagePath = ViewState["ExistingImagePath"]?.ToString() ?? DBNull.Value.ToString();
                    }




                    // 1. Update Committee_MeetingReview
                    SqlCommand cmdReview = new SqlCommand(@"UPDATE Committee_MeetingReview 
                                                     SET MeetingNo = @MeetingNo, 
                                                         MeetingDate = @MeetingDate, 
                                                         MeetingTime = @MeetingTime, 
                                                         Venue = @Venue,
                                                         JobID=@JobID,
                                                         Image_upload = @Image_upload,
                                                         ChairedBy = @ChairedBy 
                                                     WHERE MeetingID = @MeetingID", con, transaction);
                    cmdReview.Parameters.AddWithValue("@MeetingNo", txtMeetingNo.Text);
                    cmdReview.Parameters.AddWithValue("@MeetingDate", txtdate.Text);
                    cmdReview.Parameters.AddWithValue("@MeetingTime", txtTime.Text);
                    cmdReview.Parameters.AddWithValue("@Venue", txtVenue.Text);
                    cmdReview.Parameters.AddWithValue("@ChairedBy", txtChairedBy.Text);
                    cmdReview.Parameters.AddWithValue("@JobID", txtjobID.Text);
                    //cmdReview.Parameters.AddWithValue("@Image_upload", imgupload);
                    if (!string.IsNullOrEmpty(imagePath))
                        cmdReview.Parameters.AddWithValue("@Image_upload", imagePath);
                    else
                        cmdReview.Parameters.AddWithValue("@Image_upload", DBNull.Value);

                    cmdReview.Parameters.AddWithValue("@MeetingID", meetingID);
                    cmdReview.ExecuteNonQuery();

                    // 2. Update Committee_MeetingAttendance
                    foreach (GridViewRow row in gvAttendees.Rows)
                    {
                        int attendanceID = Convert.ToInt32(gvAttendees.DataKeys[row.RowIndex].Value);

                        string name = ((TextBox)row.FindControl("txtEmployeeName")).Text;
                        string designation = ((TextBox)row.FindControl("txtDesignation")).Text;
                        string code = ((TextBox)row.FindControl("txtAttendeeCode")).Text;
                        string type = ((DropDownList)row.FindControl("ddlAttendeeType")).SelectedValue;
                        string status = ((DropDownList)row.FindControl("ddlAttendanceStatus")).SelectedValue;

                       

                        SqlCommand cmdAtt = new SqlCommand(@"UPDATE Committee_MeetingAttendance 
                                                     SET Name = @Name, 
                                                         Designation = @Designation, 
                                                         AttendeeCode = @Code, 
                                                         Attendee_Type = @Type, 
                                                         AttendanceStatus = @Status 
                                                     WHERE AttendanceID = @ID", con, transaction);
                        cmdAtt.Parameters.AddWithValue("@Name", name);
                        cmdAtt.Parameters.AddWithValue("@Designation", designation);
                        cmdAtt.Parameters.AddWithValue("@Code", code);
                        cmdAtt.Parameters.AddWithValue("@Type", type);
                        cmdAtt.Parameters.AddWithValue("@Status", status);
                       // cmdAtt.Parameters.AddWithValue("@Image", imgPath);
                        cmdAtt.Parameters.AddWithValue("@ID", attendanceID);
                        cmdAtt.ExecuteNonQuery();
                    }

                    // 3. Update Committee_MeetingIssues
                    foreach (GridViewRow row in gvIssues.Rows)
                    {
                        int issueID = Convert.ToInt32(gvIssues.DataKeys[row.RowIndex].Value);

                        string agenda = ((TextBox)row.FindControl("txtAgendaTitle")).Text;
                        string issues = ((TextBox)row.FindControl("txtIssuesDiscussed")).Text;
                        string actionBy = ((TextBox)row.FindControl("txtActionBy")).Text;
                        //DateTime targetDate = Convert.ToDateTime(((TextBox)row.FindControl("txtTargetDate")).Text);
                        //DateTime reviewDate = Convert.ToDateTime(((TextBox)row.FindControl("txtReviewDate")).Text);
                        string targetDateText = ((TextBox)row.FindControl("txtTargetDate")).Text.Trim();
                        string reviewDateText = ((TextBox)row.FindControl("txtReviewDate")).Text.Trim();
                        string Responsiblity = ((TextBox)row.FindControl("txtresponsiblity")).Text.Trim();

                        DateTime targetDate;
                        DateTime reviewDate;

                        object reviewDateParam = DBNull.Value;

                        if (DateTime.TryParse(reviewDateText, out reviewDate))
                            reviewDateParam = reviewDate;

                        bool isTargetDateValid = DateTime.TryParseExact(targetDateText, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out targetDate);
                        //bool isReviewDateValid = DateTime.TryParseExact(reviewDateText, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out reviewDate);

                        

                        string reviewBy = ((DropDownList)row.FindControl("ddlReviewBy")).SelectedValue;
                        string status = ((DropDownList)row.FindControl("ddlStattus")).SelectedValue;

                        object capaReportObj = row.DataItem != null ? ((DataRowView)row.DataItem)["Capa_Report"] : DBNull.Value;

                        SqlCommand cmdIssue = new SqlCommand(@"UPDATE Committee_MeetingIssues 
                               SET AgendaTitle = @Agenda, 
                                   IssueDescription = @IssueDesc, 
                                   CloseBy = @ActionBy, 
                                   TargetDate = @TargetDate, 
                                   CloseDate = @ReviewDate, 
                                   ReviewBy = @ReviewBy, 
                                   Responsiblity =@Responsiblity,
                                   Status = @Status 
                               WHERE IssueID = @IssueID", con, transaction); 

                        cmdIssue.Parameters.AddWithValue("@Agenda", agenda);
                        cmdIssue.Parameters.AddWithValue("@IssueDesc", issues);
                        cmdIssue.Parameters.AddWithValue("@ActionBy", actionBy);
                        cmdIssue.Parameters.AddWithValue("@TargetDate", targetDate);
                        cmdIssue.Parameters.AddWithValue("@ReviewDate", reviewDateParam);
                        cmdIssue.Parameters.AddWithValue("@ReviewBy", reviewBy);
                        cmdIssue.Parameters.AddWithValue("@Status", status);
                        cmdIssue.Parameters.AddWithValue("@IssueID", issueID);
                        cmdIssue.Parameters.AddWithValue("@Responsiblity", Responsiblity);
                        cmdIssue.ExecuteNonQuery();


                        // Update tbl_CAPAMaster if Capa_Report exists
                        if (capaReportObj != DBNull.Value)
                        {
                            int capaID = Convert.ToInt32(capaReportObj);
                            SqlCommand cmdCAPA = new SqlCommand(@"
                                                            UPDATE tbl_CAPAMaster
                                                            SET Description = @Description,
                                                                ResponsiblePerson = @ResponsiblePerson,
                                                                TargetCompletionDate = @TargetCompletionDate
                                                            WHERE CAPAID = @CAPAID", con, transaction);

                            cmdCAPA.Parameters.AddWithValue("@Description", issues);
                            cmdCAPA.Parameters.AddWithValue("@ResponsiblePerson", Responsiblity);
                            cmdCAPA.Parameters.AddWithValue("@TargetCompletionDate", targetDate);
                            //cmdCAPA.Parameters.AddWithValue("@Status", status);
                            cmdCAPA.Parameters.AddWithValue("@CAPAID", capaID);

                            cmdCAPA.ExecuteNonQuery();
                        }

                    }

                    transaction.Commit();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotifySuccess",
                        "new PNotify({ " +
                        "title: 'Success'," +
                        "text: 'Updated successfully!'," +
                        "type: 'success'," +
                        "styling: 'bootstrap3'," +
                        "delay: 2000 });", true);

                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotifyError",
                                    "new PNotify({ " +
                                    "title: 'Error'," +
                                    "text: 'Error: " + ex.Message.Replace("'", "\\'") + "'," +  // escape single quotes
                                    "type: 'error'," +
                                    "styling: 'bootstrap3'," +
                                    "delay: 4000 });", true);

                }
            }
        }

        protected void txtAttendeeCode_TextChanged(object sender, EventArgs e)
        {
            TextBox txtCode = (TextBox)sender;
            GridViewRow row = (GridViewRow)txtCode.NamingContainer;

            string empCode = txtCode.Text.Trim();
            if (!string.IsNullOrEmpty(empCode))
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
                {
                    conn.Open();
                    string query = "SELECT EmployeeName, Designation FROM EmployeeMaster WHERE EmployeeCode = @Code";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Code", empCode);

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        // Find controls in the same row
                        TextBox txtName = (TextBox)row.FindControl("txtEmployeeName");
                        TextBox txtDesignation = (TextBox)row.FindControl("txtDesignation");

                        txtName.Text = dr["EmployeeName"].ToString();
                        txtDesignation.Text = dr["Designation"].ToString();
                    }
                    else
                    {
                        // Not found → clear
                        ((TextBox)row.FindControl("txtEmployeeName")).Text = "";
                        ((TextBox)row.FindControl("txtDesignation")).Text = "";
                    }
                }
            }
        }

        protected void ddlAttendeeType_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddl.NamingContainer;

            TextBox txtEmployeeName = (TextBox)row.FindControl("txtEmployeeName");
            TextBox txtAttendeeCode = (TextBox)row.FindControl("txtAttendeeCode");

            if (ddl.SelectedValue == "Internal")
            {
                txtEmployeeName.Enabled = false;
                txtAttendeeCode.Enabled = true;
            }
            else if (ddl.SelectedValue == "External")
            {
                txtAttendeeCode.Text = "N/A";
                txtAttendeeCode.Enabled = false;
                txtEmployeeName.Enabled = true;
            }
        }

        protected void gvAttendees_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlAttendeeType = (DropDownList)e.Row.FindControl("ddlAttendeeType");
                TextBox txtEmployeeName = (TextBox)e.Row.FindControl("txtEmployeeName");
                TextBox txtAttendeeCode = (TextBox)e.Row.FindControl("txtAttendeeCode");

                if (ddlAttendeeType != null)
                {
                    // Get saved value from DB
                    string typeValue = DataBinder.Eval(e.Row.DataItem, "Attendee_Type")?.ToString();

                    // Set dropdown
                    if (!string.IsNullOrEmpty(typeValue) && ddlAttendeeType.Items.FindByValue(typeValue) != null)
                    {
                        ddlAttendeeType.SelectedValue = typeValue;
                    }

                    // Apply lock logic based on DB value
                    if (typeValue == "Internal")
                    {
                        txtEmployeeName.Enabled = false;
                        txtAttendeeCode.Enabled = true;
                    }
                    else if (typeValue == "External")
                    {
                        txtAttendeeCode.Text = "N/A";
                        txtAttendeeCode.Enabled = false;
                        txtEmployeeName.Enabled = true;
                    }
                }
            }
        }

        protected void gvIssues_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            string savedValue = DataBinder.Eval(e.Row.DataItem, "ReviewBy")?.ToString().Trim();

            // Debug output to page
            //Response.Write($"Row {e.Row.RowIndex} savedValue='{savedValue}'<br/>");

            DropDownList ddlReviewBy = (DropDownList)e.Row.FindControl("ddlReviewBy");
            if (ddlReviewBy == null) return;

            int meetingID = Convert.ToInt32(ViewState["MeetingID"]);
            DataTable dtAttendees = GetAttendees(meetingID);

            ddlReviewBy.DataSource = dtAttendees;
            ddlReviewBy.DataTextField = "DisplayName";
            ddlReviewBy.DataValueField = "DisplayName";
            ddlReviewBy.DataBind();

            if (!string.IsNullOrEmpty(savedValue))
            {
                ListItem li = ddlReviewBy.Items.Cast<ListItem>()
                                      .FirstOrDefault(x => x.Value.Trim() == savedValue);
                if (li != null) li.Selected = true;
            }
        }


       






        private DataTable GetAttendees(int meetingID)
        {
            string query = @"
        SELECT AttendeeCode,
               Name + ' (' + AttendeeCode + ')' AS DisplayName
        FROM Committee_MeetingAttendance
        WHERE MeetingID = @MeetingID";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@MeetingID", meetingID);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }


        protected void gvIssues_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvIssues.Rows[e.RowIndex];
            DropDownList ddlReviewBy = (DropDownList)row.FindControl("ddlReviewBy");

            string reviewByCode = ddlReviewBy.SelectedValue;     // ADMIN
            string reviewByName = ddlReviewBy.SelectedItem.Text; // Administrator (ADMIN)

        }

        protected void ddlStattus_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddl.NamingContainer;

            TextBox txtActionBy = (TextBox)row.FindControl("txtActionBy");
            TextBox txtReviewDate = (TextBox)row.FindControl("txtReviewDate");
            RequiredFieldValidator rfvActionBy = (RequiredFieldValidator)row.FindControl("RFV_txtActionBy");
            RequiredFieldValidator rfvReviewDate = (RequiredFieldValidator)row.FindControl("RFV_txtReviewDate");

            bool isClosed = ddl.SelectedValue == "Closed";

            if (txtActionBy != null) txtActionBy.Enabled = isClosed;
            if (txtReviewDate != null) txtReviewDate.Enabled = isClosed;

            if (rfvActionBy != null) rfvActionBy.Enabled = isClosed;
            if (rfvReviewDate != null) rfvReviewDate.Enabled = isClosed;

            if (!isClosed)
            {
                if (txtActionBy != null) txtActionBy.Text = string.Empty;
                if (txtReviewDate != null) txtReviewDate.Text = string.Empty;
            }
        }
    }
}