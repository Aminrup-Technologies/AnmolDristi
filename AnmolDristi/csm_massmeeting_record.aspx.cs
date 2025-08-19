using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.IO;
using System.Linq;
using System.Net.NetworkInformation;
using System.Security.Cryptography;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
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
                if (Session["USERID"] == null || Session["USERNAME"] == null || Session["WORKMAN"] == null)
                {
                    Response.Redirect("login.aspx");
                }

                
                else
                {
                    hfActiveTab.Value = "#Meeting";

                    TB_CoordinatorName.Text = Session["USERNAME"].ToString();

                    PopulateAgendaDropdown();

                    string Massmeetid = Request.QueryString["id"];
                    if (!string.IsNullOrEmpty(Massmeetid))
                    {
                        ViewState["RecordId"] = Massmeetid;
                        heading.Text = "UPDATE MASS MEETING DATA";

                        MainForm();
                        BindAttendeeGrid();
                        BindMOMGrid();
                        pnlDetails.Visible = true;
                    }

                    PopulateAgendaDropdown();

                }
            }

            BindAttendeeGrid();
        }

        private void PopulateAgendaDropdown()
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT AgendaID, AgendaTitle FROM csm_MassMeetingAgenda", conn);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                ddlAgendaTitle.DataSource = reader;
                ddlAgendaTitle.DataTextField = "AgendaTitle";
                ddlAgendaTitle.DataValueField = "AgendaID";
                ddlAgendaTitle.DataBind();

                ddlAgendaTitle.Items.Insert(0, new ListItem("Select", ""));
                ddlAgendaTitle.Items.Add(new ListItem("Other", "Other")); // for custom entry
            }
        }

        public class AgendaDetail
        {
            public string AgendaTitle { get; set; }
            public string Description { get; set; }
            public string Membertype { get; set; }
            public string PointBy { get; set; }
            public string Employeenme { get; set; }
            public string DiscussionTime { get; set; }
        }

        protected void btnAddMore_Click(object sender, EventArgs e)
        {
            //foreach (GridViewRow row in GridView1.Rows)
            //{
                
            //    FileUpload fuBefore = (FileUpload)row.FindControl("fuPhotoBefore");
            //    TextBox txtBeforePath = (TextBox)row.FindControl("txtPhotoBeforePath");

            //    FileUpload fuAfter = (FileUpload)row.FindControl("fuPhotoAfter");
            //    TextBox txtAfterPath = (TextBox)row.FindControl("txtPhotoAfterPath");

            //    if (fuBefore.HasFile)
            //    {
            //        string filePathBefore = "~/Uploads/" + fuBefore.FileName; // Ensure you have this folder in your project
            //        fuBefore.SaveAs(Server.MapPath(filePathBefore));
            //        txtBeforePath.Text = filePathBefore;
            //    }

            //    if (fuAfter.HasFile)
            //    {
            //        string filePathAfter = "~/Uploads/" + fuAfter.FileName;
            //        fuAfter.SaveAs(Server.MapPath(filePathAfter));
            //        txtAfterPath.Text = filePathAfter;
            //    }
            //}
            //lblMsg1.Text = "Files uploaded and saved successfully!";
            //lblMsg1.ForeColor = System.Drawing.Color.Green;
        }

        protected void btnsave1_Click(object sender, EventArgs e)
        {
            if (ViewState["MM_Id"] != null && !string.IsNullOrEmpty(ViewState["MM_Id"].ToString()))
            {
                UpdatePanelOneForm(); // Perform update
            }
            else
            {
                PanelOneDateSaver(); // Perform insert
            }
        }

        private void ShowPNotify(string title, string message, string type)
        {
            string script = $@"
                <script type='text/javascript'>
                    new PNotify({{
                        title: '{title}',
                        text: '{message}',
                        type: '{type}',
                        styling: 'bootstrap3',
                        delay: 3000
                    }});
                </script>";

            ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), script, false);
        }

        private void PanelOneDateSaver()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string meetingId = Guid.NewGuid().ToString();
            string photoPath = null;


            // Handle photo upload
            if (TB_Photo.HasFile)
            {
                string extension = Path.GetExtension(TB_Photo.FileName);
                string uniqueFileName = Guid.NewGuid().ToString() + extension;

                string folderPath = Server.MapPath("~/Uploads/MassMeetingPhotos/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fullPath = Path.Combine(folderPath, uniqueFileName);
                TB_Photo.SaveAs(fullPath);

                photoPath = uniqueFileName;  // Store only the file name in DB
            }


            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO csm_massmeting_records (MM_Id, MM_DocNo, Meeting_Date, Meeting_StartTime, Meeting_EndTime, SubmitterCode, RegionCode, CompanyCode, DeptCode, LocationCode, ExactLocation, Coordinator_Name, LastModifiedOn, LastModifiedByCode, Photo) 
                        VALUES (@MM_Id, @MM_DocNo, @Meeting_Date, @Meeting_StartTime, @Meeting_EndTime, @SubmitterCode, @RegionCode, @CompanyCode, @DeptCode, @LocationCode, @ExactLocation, @Coordinator_Name, GETDATE(), @LastModifiedByCode, @Photo)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    DateTime meetingDate;
                    DateTime startTime;
                    DateTime endTime;

                    bool isDateValid = DateTime.TryParse(TB_Date.Text.Trim(), out meetingDate);
                    bool isStartTimeValid = DateTime.TryParse(TB_StartTime.Text.Trim(), out startTime);
                    bool isEndTimeValid = DateTime.TryParse(TB_EndTime.Text.Trim(), out endTime);

                    if (!isDateValid || !isStartTimeValid || !isEndTimeValid)
                    {
                        ShowPNotify("Validation Error", "Invalid Date or Time format. Please check your inputs.", "warning");
                        return;
                    }

                    cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                    cmd.Parameters.AddWithValue("@MM_DocNo", "ATS/DOC/MM/0010");
                    cmd.Parameters.AddWithValue("@Meeting_Date", meetingDate);
                    cmd.Parameters.AddWithValue("@Meeting_StartTime", startTime);
                    cmd.Parameters.AddWithValue("@Meeting_EndTime", endTime);
                    cmd.Parameters.AddWithValue("@SubmitterCode", Session["WORKMAN"].ToString());
                    cmd.Parameters.AddWithValue("@RegionCode", DDL_WorkRegion.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@CompanyCode", DDL_Company.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@DeptCode", DDL_Department.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@LocationCode", DDL_Location.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@ExactLocation", TB_ExactLocation.Text.Trim());
                    cmd.Parameters.AddWithValue("@Coordinator_Name", TB_CoordinatorName.Text.Trim());
                    cmd.Parameters.AddWithValue("@LastModifiedByCode", string.Empty);
                    cmd.Parameters.AddWithValue("@Photo", (object)photoPath ?? DBNull.Value);

                    try
                    {
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            lblMsg.Text = "Record inserted successfully!";
                            HiddenField_MMId.Value = meetingId;
                            ViewState["MM_Id"] = meetingId;

                            ShowPNotify("Success", "Record inserted successfully!", "success");
                            ScriptManager.RegisterStartupScript(this, GetType(), "MoveToNextTab", "moveToNext('Meeting', 'Attendees');", true);

                        }
                        else
                        {
                            ShowPNotify("Error", "Failed to insert record.", "error");
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowPNotify("Database Error", ex.Message, "error");
                    }
                }
            }
        }


        [WebMethod]
        public static string GetEmployeeName(string empCode)
        {
            string empName = "Not Found"; // Default response

            if (!string.IsNullOrEmpty(empCode))
            {
                string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT EmployeeName FROM MST_UserMaster WHERE EmployeeCode = @EmpCode";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@EmpCode", empCode);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        empName = result.ToString();
                    }
                }
            }

            return empName; // Return employee name
        }

        [WebMethod]
        public static EmployeeDetails GetEmployeeDetails(string empCode)
        {
            EmployeeDetails details = new EmployeeDetails();

            string query = "SELECT EmployeeName, GradeId as Designation, Password as GatePassNo FROM MST_UserMaster WHERE EmployeeCode = @empCode";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@empCode", empCode);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        details.EmployeeName = reader["EmployeeName"].ToString();
                        details.Designation = reader["Designation"].ToString();
                        details.GatePassNo = reader["GatePassNo"].ToString();
                    }
                    else
                    {
                        details.EmployeeName = "Not Found";
                        details.Designation = "";
                        details.GatePassNo = "";
                    }
                }
            }

            return details;
        }

        public class EmployeeDetails
        {
            public string EmployeeName { get; set; }
            public string Designation { get; set; }
            public string GatePassNo { get; set; }
        }

        //protected void rbAttendeeType_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    bool isInternal = rbAttendeeType.SelectedValue == "Internal";
        //    txtAttendeeCode.Text = isInternal ? "N/A" : "N/A";
        //    txtAttendeeCode.Enabled = isInternal;
        //    pnlDetails.Visible = true;
        //}

        public class Attendee
        {
            public string EmployeeOrNot { get; set; }   //from here every column of gridview is getting fetched..
            public string AttendeeType { get; set; }
            public string AttendeeCode { get; set; }
            public string EmployeeName { get; set; }
            public string Designation { get; set; }
            public string GatePassNo { get; set; }
            public string ImagePath { get; set; }  
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



        private void MainForm()
        {
            string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                string mainID = ViewState["RecordId"]?.ToString(); // Use correct key for your use case
                SqlCommand cmd = new SqlCommand("SELECT * FROM csm_massmeting_records WHERE Id = @ID", con);
                cmd.Parameters.AddWithValue("@ID", mainID);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        TB_Date.Text = Convert.ToDateTime(reader["Meeting_Date"]).ToString("yyyy-MM-dd");
                        TB_StartTime.Text = reader["Meeting_StartTime"].ToString();
                        TB_EndTime.Text = reader["Meeting_EndTime"].ToString();
                        TB_Duration.Text = reader["Duration"].ToString();

                        DDL_WorkRegion.SelectedValue = reader["RegionCode"].ToString();
                        DDL_Company.SelectedValue = reader["CompanyCode"].ToString();
                        DDL_Department.SelectedValue = reader["DeptCode"].ToString();
                        DDL_Location.SelectedValue = reader["LocationCode"].ToString();

                        TB_ExactLocation.Text = reader["ExactLocation"].ToString();
                        TB_CoordinatorName.Text = reader["Coordinator_Name"].ToString();

                        string photo = reader["Photo"]?.ToString();
                        if (!string.IsNullOrEmpty(photo))
                        {
                            Lbl_SavedPhoto.Text = photo;
                            Lbl_SavedPhoto.Visible = true;
                        }
                        else
                        {
                            Lbl_SavedPhoto.Text = "";
                            Lbl_SavedPhoto.Visible = false;
                        }

                        // Store ID for reuse if needed
                        ViewState["MM_Id"] = reader["MM_Id"].ToString();
                    }
                }
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static void AddAttendee(string attendeeType, string empCode, string empName, string designation, string gatePassNo)
        {
            DataTable dt = HttpContext.Current.Session["AttendeesTable"] as DataTable;

            if (dt == null)
            {
                dt = new DataTable();
                dt.Columns.Add("EmployeeOrNot");
                dt.Columns.Add("AttendeeType");
                dt.Columns.Add("AttendeeCode");
                dt.Columns.Add("EmployeeName");
                dt.Columns.Add("Designation");
                dt.Columns.Add("GatePassNo");
            }

            DataRow newRow = dt.NewRow();
            newRow["EmployeeOrNot"] = attendeeType == "Internal" ? "Yes" : "No";
            newRow["AttendeeType"] = attendeeType;
            newRow["AttendeeCode"] = empCode;
            newRow["EmployeeName"] = empName;
            newRow["Designation"] = designation;
            newRow["GatePassNo"] = gatePassNo;

            dt.Rows.Add(newRow);
            HttpContext.Current.Session["AttendeesTable"] = dt;
        }

        protected void btnRefreshGrid_Click(object sender, EventArgs e)
        {
            BindAttendeeGrid();
        }

   
        private void UpdatePanelOneForm()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string meetingId = ViewState["MM_Id"]?.ToString();
            string photoPath = null;

            if (TB_Photo.HasFile)
            {
                string extension = Path.GetExtension(TB_Photo.FileName);
                string uniqueFileName = Guid.NewGuid().ToString() + extension;

                string folderPath = Server.MapPath("~/Uploads/MassMeetingPhotos/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fullPath = Path.Combine(folderPath, uniqueFileName);
                TB_Photo.SaveAs(fullPath);

                photoPath = uniqueFileName;
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"UPDATE csm_massmeting_records SET 
                            Meeting_Date = @Meeting_Date,
                            Meeting_StartTime = @Meeting_StartTime,
                            Meeting_EndTime = @Meeting_EndTime,
                            RegionCode = @RegionCode,
                            CompanyCode = @CompanyCode,
                            DeptCode = @DeptCode,
                            LocationCode = @LocationCode,
                            ExactLocation = @ExactLocation,
                            Coordinator_Name = @Coordinator_Name,
                            LastModifiedOn = GETDATE(),
                            LastModifiedByCode = @LastModifiedByCode" +
                                    (photoPath != null ? ", Photo = @Photo" : "") +
                                " WHERE ID = @MM_Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    DateTime meetingDate;
                    DateTime startTime;
                    DateTime endTime;

                    bool isDateValid = DateTime.TryParse(TB_Date.Text.Trim(), out meetingDate);
                    bool isStartTimeValid = DateTime.TryParse(TB_StartTime.Text.Trim(), out startTime);
                    bool isEndTimeValid = DateTime.TryParse(TB_EndTime.Text.Trim(), out endTime);

                    if (!isDateValid || !isStartTimeValid || !isEndTimeValid)
                    {
                        ShowPNotify("Validation Error", "Invalid Date or Time format.", "warning");
                        return;
                    }

                    cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                    cmd.Parameters.AddWithValue("@Meeting_Date", meetingDate);
                    cmd.Parameters.AddWithValue("@Meeting_StartTime", startTime);
                    cmd.Parameters.AddWithValue("@Meeting_EndTime", endTime);
                    cmd.Parameters.AddWithValue("@RegionCode", DDL_WorkRegion.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@CompanyCode", DDL_Company.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@DeptCode", DDL_Department.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@LocationCode", DDL_Location.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@ExactLocation", TB_ExactLocation.Text.Trim());
                    cmd.Parameters.AddWithValue("@Coordinator_Name", TB_CoordinatorName.Text.Trim());
                    cmd.Parameters.AddWithValue("@LastModifiedByCode", Session["WORKMAN"]?.ToString() ?? "");

                    if (photoPath != null)
                    {
                        cmd.Parameters.AddWithValue("@Photo", photoPath);
                    }

                    try
                    {
                        conn.Open();
                        int rows = cmd.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            ShowPNotify("Success", "Meeting record updated!", "success");
                        }
                        else
                        {
                            ShowPNotify("Error", "No record updated.", "error");
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowPNotify("Database Error", ex.Message, "error");
                    }
                }
            }
        }


        private void BindAttendeeGrid()
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string meetingId = ViewState["MM_Id"]?.ToString();

            if (string.IsNullOrEmpty(meetingId))
            {
                gvAttendees.DataSource = null;
                gvAttendees.DataBind();
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM csm_massmeting_attendee WHERE MM_Id = @MM_Id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        gvAttendees.DataSource = dt;
                        gvAttendees.DataBind();
                    }
                }
            }
        }






        private void InsertAttendee()
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string meetingId = ViewState["MM_Id"]?.ToString();

            if (string.IsNullOrEmpty(meetingId))
            {
                ShowPNotify("Error", "Meeting ID not found.", "error");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO csm_massmeting_attendee 
                         (MM_Id, AttendeeCode, EmployeeName, Attendee_Type, Designation, Gate_passno) 
                         VALUES (@MM_Id, @AttendeeCode, @EmployeeName, @Attendee_Type, @Designation, @Gate_passno)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                    cmd.Parameters.AddWithValue("@AttendeeCode", txtAttendeeCode.Text.Trim());
                    cmd.Parameters.AddWithValue("@EmployeeName", txtEmployeeName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Attendee_Type", rbAttendeeType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Designation", txtdes.Text.Trim());
                    cmd.Parameters.AddWithValue("@Gate_passno", txtgatepassno.Text.Trim());

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowPNotify("Success", "Attendee added successfully.", "success");
            BindAttendeeGrid();
        }

        private void UpdateAttendee()
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"UPDATE csm_massmeting_attendee 
                         SET AttendeeCode = @AttendeeCode,
                             EmployeeName = @EmployeeName,
                             Attendee_Type = @Attendee_Type,
                             Designation = @Designation,
                             Gate_passno = @Gate_passno
                         WHERE ID = @ID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@AttendeeCode", txtAttendeeCode.Text.Trim());
                    cmd.Parameters.AddWithValue("@EmployeeName", txtEmployeeName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Attendee_Type", rbAttendeeType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Designation", txtdes.Text.Trim());
                    cmd.Parameters.AddWithValue("@Gate_passno", txtgatepassno.Text.Trim());
                    cmd.Parameters.AddWithValue("@ID", HiddenField_AttendeeId.Value);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowPNotify("Success", "Attendee updated successfully.", "success");
            HiddenField_AttendeeId.Value = string.Empty;
        }

        protected void gvAttendees_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "EditAttendee")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvAttendees.Rows[rowIndex];

                string attendeeId = gvAttendees.DataKeys[rowIndex].Value.ToString();
                HiddenField_AttendeeId.Value = attendeeId;

                txtAttendeeCode.Text = ((Label)row.FindControl("lblAttendeeCode"))?.Text ?? string.Empty;
                txtEmployeeName.Text = ((Label)row.FindControl("lblEmployeeName"))?.Text ?? string.Empty;

                string attendeeType = ((Label)row.FindControl("lblAttendeeType"))?.Text?.Trim() ?? string.Empty;
                if (!string.IsNullOrEmpty(attendeeType) && rbAttendeeType.Items.FindByValue(attendeeType) != null)
                {
                    rbAttendeeType.SelectedValue = attendeeType;
                }
                else
                {
                    rbAttendeeType.ClearSelection();
                }

                txtdes.Text = ((Label)row.FindControl("lblDesignation"))?.Text ?? string.Empty;
                txtgatepassno.Text = ((Label)row.FindControl("lblGatePassNo"))?.Text ?? string.Empty;

                pnlDetails.Visible = true;

            }
            else if (e.CommandName == "DeleteAttendee")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int id = Convert.ToInt32(gvAttendees.DataKeys[rowIndex].Value);
                DeleteAttendees(id);
                BindAttendeeGrid();
            }
        }
            private void ClearAttendeeForm()
            {
                txtAttendeeCode.Text = "";
                txtEmployeeName.Text = "";
                rbAttendeeType.ClearSelection();
                txtdes.Text = "";
                txtgatepassno.Text = "";
                HiddenField_AttendeeId.Value = "";
           }

        protected void btnsave2_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(HiddenField_AttendeeId.Value))
            {
                UpdateAttendee();
            }
            else
            {
                InsertAttendee();
            }

            BindAttendeeGrid();
            ClearAttendeeForm();
        }



        private void UpdateMOM()
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string meetingId = ViewState["MM_Id"]?.ToString();

            if (string.IsNullOrEmpty(meetingId))
            {
                ShowPNotify("Error", "Meeting ID not found.", "error");
                return;
            }

            // Determine agenda title
            string agendaTitle = ddlAgendaTitle.SelectedValue == "Other"
                ? txtOtherAgenda.Text.Trim()
                : ddlAgendaTitle.SelectedItem.Text;

            if (ddlAgendaTitle.SelectedValue == "Other" && string.IsNullOrWhiteSpace(agendaTitle))
            {
                ShowPNotify("Validation", "Please enter a custom agenda title.", "error");
                return;
            }

            string momId = hfMomId.Value;
            string customId = "MM-" + meetingId;
            bool isNowChecked = chkGenerateCAPA.Checked;

            object previousCapaId = null;
            bool wasPreviouslyChecked = false;
            int? capaIdToSave = null;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Step 1: Fetch previous CAPA data
                string fetchQuery = "SELECT CAPA_ID, IsCAPAGenerated FROM csm_massmeting_mom WHERE MOM_Id = @MOM_Id";
                using (SqlCommand fetchCmd = new SqlCommand(fetchQuery, conn))
                {
                    fetchCmd.Parameters.AddWithValue("@MOM_Id", momId);
                    using (SqlDataReader reader = fetchCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            previousCapaId = reader["CAPA_ID"];
                            wasPreviouslyChecked = reader["IsCAPAGenerated"] != DBNull.Value &&
                                                   Convert.ToBoolean(reader["IsCAPAGenerated"]);
                        }
                    }
                }

                // === SCENARIO B: Now checked (Always insert a new CAPA)
                if (isNowChecked && !wasPreviouslyChecked)
                {
                    string insertCapa = @"
                INSERT INTO tbl_CAPAMaster 
                (HeaderID, Remarks, AssignedBy, AssignedDate, SourceTable, Description)
                VALUES 
                (@HeaderID, @Remarks, @AssignedBy, @AssignedDate, @SourceTable, @Description);
                SELECT SCOPE_IDENTITY();";

                    using (SqlCommand insertCmd = new SqlCommand(insertCapa, conn))
                    {
                        insertCmd.Parameters.AddWithValue("@HeaderID", customId);
                        insertCmd.Parameters.AddWithValue("@Remarks", txtDescription.Text.Trim());
                        insertCmd.Parameters.AddWithValue("@AssignedBy", txtEmpName.Text.Trim());
                        insertCmd.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                        insertCmd.Parameters.AddWithValue("@SourceTable", "Mass Meeting");
                        insertCmd.Parameters.AddWithValue("@Description", agendaTitle);

                        object result = insertCmd.ExecuteScalar();
                        int newCapaId;
                        if (result != null && int.TryParse(result.ToString(), out newCapaId))
                        {
                            capaIdToSave = newCapaId;
                        }
                    }
                }

                // === SCENARIO A: Was checked, now unchecked → deactivate existing CAPA and keep CAPA_ID
                else if (previousCapaId != null && previousCapaId != DBNull.Value)
                {
                    string deactivateQuery = "UPDATE tbl_CAPAMaster SET IsYes = 1 WHERE CAPAID = @CAPAID";
                    using (SqlCommand deactivateCmd = new SqlCommand(deactivateQuery, conn))
                    {
                        deactivateCmd.Parameters.AddWithValue("@CAPAID", Convert.ToInt32(previousCapaId));
                        int rows = deactivateCmd.ExecuteNonQuery();

                        System.Diagnostics.Debug.WriteLine("Deactivated CAPA rows: " + rows); // ← Add this
                    }

                    capaIdToSave = Convert.ToInt32(previousCapaId);
                }
                // === SCENARIO C: Still unchecked, never checked → leave capaIdToSave = null

                // Step 3: Update MOM record
                string updateQuery = @"
            UPDATE csm_massmeting_mom
            SET 
                MM_Id = @MM_Id,
                AgendaTitle = @AgendaTitle,
                EmployeeType = @EmployeeType,
                EmployeeName = @EmployeeName,
                Description = @Description,
                PointRaisedBy = @PointRaisedBy,
                DiscussionTime = @DiscussionTime,
                IsCAPAGenerated = @IsCAPAGenerated,
                CAPA_ID = @CAPA_ID
            WHERE MOM_Id = @MOM_Id";

                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                    cmd.Parameters.AddWithValue("@AgendaTitle", agendaTitle);
                    cmd.Parameters.AddWithValue("@EmployeeType", rblEmpType.SelectedValue);
                    cmd.Parameters.AddWithValue("@EmployeeName", txtEmpName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@PointRaisedBy", txtPointBy.Text.Trim());
                    cmd.Parameters.AddWithValue("@DiscussionTime", ddlTime.SelectedValue);
                    cmd.Parameters.AddWithValue("@IsCAPAGenerated", isNowChecked);
                    cmd.Parameters.AddWithValue("@CAPA_ID", capaIdToSave.HasValue ? (object)capaIdToSave : DBNull.Value);
                    cmd.Parameters.AddWithValue("@MOM_Id", momId);

                    cmd.ExecuteNonQuery();
                }
            }


            ShowPNotify("Success", "MOM point updated successfully.", "success");

            hfMomId.Value = string.Empty;
            ClearPointFields();
            BindMOMGrid();
        }



        private void InsertMOM()
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string meetingId = ViewState["MM_Id"]?.ToString();

            if (string.IsNullOrEmpty(meetingId))
            {
                ShowPNotify("Error", "Meeting ID not found.", "error");
                return;
            }

            string momId = Guid.NewGuid().ToString(); // Generate new GUID for MOM_Id
            string customId = "MM-" + meetingId;


            // Determine actual Agenda Title
            string agendaTitle = ddlAgendaTitle.SelectedValue == "Other"
                ? txtOtherAgenda.Text.Trim()
                : ddlAgendaTitle.SelectedItem.Text;

            if (ddlAgendaTitle.SelectedValue == "Other" && string.IsNullOrWhiteSpace(agendaTitle))
            {
                ShowPNotify("Validation", "Please enter a custom agenda title.", "error");
                return;
            }

            int? capaId = null;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // ✅ If checkbox is checked, insert into CAPA master with customId
                if (chkGenerateCAPA.Checked)
                {
                    string capaInsertQuery = @"
                INSERT INTO tbl_CAPAMaster 
                (HeaderID, Remarks, AssignedBy, AssignedDate, SourceTable,Description)
                VALUES 
                (@HeaderID, @Remarks, @AssignedBy, @AssignedDate, @SourceTable, @Description);
                SELECT SCOPE_IDENTITY();";

                    using (SqlCommand capaCmd = new SqlCommand(capaInsertQuery, conn))
                    {
                        capaCmd.Parameters.AddWithValue("@HeaderID", customId); // MM-<MM_Id>
                        capaCmd.Parameters.AddWithValue("@Remarks", txtDescription.Text.Trim());
                        capaCmd.Parameters.AddWithValue("@AssignedBy", txtEmpName.Text.Trim());
                        capaCmd.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                        capaCmd.Parameters.AddWithValue("@SourceTable", "Mass Meeting");
                        capaCmd.Parameters.AddWithValue("@Description", agendaTitle);

                        object result = capaCmd.ExecuteScalar();
                        int generatedCapaId;

                        if (result != null && int.TryParse(result.ToString(), out generatedCapaId))
                        {
                            capaId = generatedCapaId;
                        }
                    }
                }


                string query = @"INSERT INTO csm_massmeting_mom
                         (MOM_Id, MM_Id, AgendaTitle, EmployeeType, EmployeeName, Description, PointRaisedBy, DiscussionTime,IsCAPAGenerated,CAPA_ID,Custom_ID)
                         VALUES
                         (@MOM_Id, @MM_Id, @AgendaTitle, @EmployeeType, @EmployeeName, @Description, @PointRaisedBy, @DiscussionTime, @IsCAPAGenerated, @CAPA_ID, @Custom_ID)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MOM_Id", momId);
                    cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                    cmd.Parameters.AddWithValue("@AgendaTitle", agendaTitle);
                    cmd.Parameters.AddWithValue("@EmployeeType", rblEmpType.SelectedValue);
                    cmd.Parameters.AddWithValue("@EmployeeName", txtEmpName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@PointRaisedBy", txtPointBy.Text.Trim());
                    cmd.Parameters.AddWithValue("@DiscussionTime", ddlTime.SelectedValue);
                    cmd.Parameters.AddWithValue("@IsCAPAGenerated", chkGenerateCAPA.Checked);
                    cmd.Parameters.AddWithValue("@CAPA_ID", capaId.HasValue ? (object)capaId.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@Custom_ID", customId);


                    
                    cmd.ExecuteNonQuery();
                }
            }

            ShowPNotify("Success", "MOM point inserted successfully.", "success");
            ClearPointFields(); 
            BindMOMGrid();      
        }




        private void BindMOMGrid()
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string meetingId = ViewState["MM_Id"]?.ToString();

            if (string.IsNullOrEmpty(meetingId))
            {
                gvPoints.DataSource = null;
                gvPoints.DataBind();
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM csm_massmeting_mom WHERE MM_Id = @MM_Id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        gvPoints.DataSource = dt;
                        gvPoints.DataBind();
                    }
                }
            }
        }

        private void ClearPointFields()
        {
            ddlAgendaTitle.SelectedIndex = 0;
            txtOtherAgenda.Text = string.Empty;
            pnlOtherAgenda.Visible = false;
            rblEmpType.ClearSelection();
            txtEmpName.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtPointBy.Text = string.Empty;
            txtPointBy.Enabled = true;
            ddlTime.SelectedIndex = 0;
            hfMomId.Value = string.Empty;
        }

        protected void gvPoints_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvPoints.Rows[index];

            if (e.CommandName == "EditPoint")
            {
                hfMomId.Value = gvPoints.DataKeys[index].Value.ToString();

                string agendaTitle = ((Label)row.FindControl("lblPointTitle")).Text;

                ListItem item = ddlAgendaTitle.Items.FindByText(agendaTitle);
                if (item != null)
                {
                    ddlAgendaTitle.SelectedValue = item.Value;
                    pnlOtherAgenda.Visible = false;
                    txtOtherAgenda.Text = "";
                }
                else
                {
                    ddlAgendaTitle.SelectedValue = "Other"; // Show 'Other' selected
                    pnlOtherAgenda.Visible = true;
                    txtOtherAgenda.Text = agendaTitle; // Fill custom agenda in textbox
                }


                string empType = ((Label)row.FindControl("lblEmployeeType")).Text;

                rblEmpType.SelectedValue = ((Label)row.FindControl("lblEmployeeType")).Text;
                txtEmpName.Text = ((Label)row.FindControl("lblEmployeeName")).Text;
                txtDescription.Text = ((Label)row.FindControl("lblRemarks")).Text;
                txtPointBy.Text = ((Label)row.FindControl("lblPointBy")).Text;
                ddlTime.SelectedValue = ((Label)row.FindControl("lblDiscussionTime")).Text;
                chkGenerateCAPA.Checked = gvPoints.DataKeys[index].Values["IsCAPAGenerated"] != DBNull.Value &&
                          Convert.ToBoolean(gvPoints.DataKeys[index].Values["IsCAPAGenerated"]);



                btnAddPoint.Text = "Update";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "toggleEmpTypeJS",
                       $"toggleMemberType('{empType}', false);", true);

            }
            else if (e.CommandName == "DeletePoint")
            {
                int id = Convert.ToInt32(gvPoints.DataKeys[index].Value);
                DeleteMOM(id);
            }


        }

        protected void btnAddPoint_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(hfMomId.Value))
            {
                UpdateMOM();
            }
            else
            {
                InsertMOM();
            }

            ClearPointFields();
        }

        private void DeleteMOM(int id)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM csm_massmeting_mom WHERE Id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowPNotify("Success", "Point deleted successfully.", "success");
            BindMOMGrid();
        }

        protected void ddlAgendaTitle_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlAgendaTitle.SelectedValue == "Other")
            {
                pnlOtherAgenda.Visible = true;
                rfvOtherAgenda.Enabled = true;
            }
            else
            {
                pnlOtherAgenda.Visible = false;
                rfvOtherAgenda.Enabled = false;
                txtOtherAgenda.Text = "";
            }
        }


        //protected void rblEmpType_SelectedIndexChanged1(object sender, EventArgs e)
        //{
        //    if (rblEmpType.SelectedValue == "External")
        //    {
        //        txtPointBy.Enabled = false;
        //        txtPointBy.Text = string.Empty;
        //    }
        //    else
        //    {
        //        txtPointBy.Enabled = true;
        //    }
        //}

        private void DeleteAttendees(int id)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM csm_massmeting_attendee WHERE Id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowPNotify("Success", "Attendee deleted successfully.", "success");
            BindMOMGrid();
        }
    }
}
