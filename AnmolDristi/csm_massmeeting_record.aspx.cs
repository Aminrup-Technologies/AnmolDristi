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
                    ClearSessionAndViewState();
                    hfActiveTab.Value = "#Meeting";

                    TB_CoordinatorName.Text = Session["USERNAME"].ToString();
                    //LoadDummyValues();
                    //InitializeGrid();
                    //BindAttendeeGrid();

                    //LoadDummyAttendees();
                    BindAttendeesGrid();

                    PopulateAgendaDropdown();
                    //LoadAgendaTitles();
                }
            }          
            //RestoreUploadedFiles();
        }

        private void ClearSessionAndViewState()
        {
            Session["AgendaDetails"] = null;
            Session["Attendees"] = null;
            ViewState.Clear();
        }

        [WebMethod]
        public static object UploadFile()
        {
            try
            {
                HttpPostedFile file = HttpContext.Current.Request.Files["file"];
                if (file == null || file.ContentLength == 0)
                {
                    return new { success = false, message = "No file uploaded." };
                }

                // Define upload folder
                string uploadFolder = HttpContext.Current.Server.MapPath("~/Uploads/");
                if (!Directory.Exists(uploadFolder))
                {
                    Directory.CreateDirectory(uploadFolder);
                }

                // Generate unique filename
                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                string filePath = Path.Combine(uploadFolder, fileName);

                // Save file
                file.SaveAs(filePath);

                // Return file path for preview
                string fileUrl = "/Uploads/" + fileName;
                return new { success = true, filePath = fileUrl };
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        // Function to load agenda titles
        //private void LoadAgendaTitles()
        //{
        //    List<ListItem> agendaTitles = new List<ListItem>
        //        {
        //            new ListItem("Select", ""),
        //            new ListItem("Budget Planning", "Budget Planning"),
        //            new ListItem("Project Updates", "Project Updates"),
        //            new ListItem("HR Policies", "HR Policies"),
        //            new ListItem("Company Strategy", "Company Strategy")
        //        };

        //    ddlAgendaTitle.Items.Clear();
        //    ddlAgendaTitle.Items.AddRange(agendaTitles.ToArray());
        //}

        private void PopulateAgendaDropdown()
        {
            // Replace with actual DB call
            DataTable dt = new DataTable();
            dt.Columns.Add("AgendaID");
            dt.Columns.Add("AgendaTitle");

            dt.Rows.Add("1", "Budget Planning");
            dt.Rows.Add("2", "HR Policy Review");
            dt.Rows.Add("3", "Project Timeline Discussion");

            ddlAgendaTitle.DataSource = dt;
            ddlAgendaTitle.DataTextField = "AgendaTitle";
            ddlAgendaTitle.DataValueField = "AgendaID";
            ddlAgendaTitle.DataBind();

            ddlAgendaTitle.Items.Insert(0, new ListItem("Select", ""));
        }

        // Function to load dummy data
        private void LoadDummyAttendees()
        {
            List<Attendee> attendees = new List<Attendee>
            {
                new Attendee { EmployeeOrNot = "Yes", AttendeeType = "Internal", EmployeeName = "John Doe", AttendeeCode = "EMP001", Designation = "Manager", GatePassNo = "GP123" },
                new Attendee { EmployeeOrNot = "No", AttendeeType = "External", EmployeeName = "Jane Smith", AttendeeCode = "EXT001", Designation = "Consultant", GatePassNo = "GP456" }
            };

            Session["Attendees"] = attendees; // Store dummy data in session
        }

        // Function to bind GridView with session data
        private void BindAttendeesGrid()
        {
            if (Session["Attendees"] != null)
            {
                gvAttendees.DataSource = (List<Attendee>)Session["Attendees"];
                gvAttendees.DataBind();
            }
        }

        private void LoadDummyValues()
        {
            // Assign dummy values to textboxes
            TB_Date.Text = DateTime.Now.ToString("yyyy-MM-dd"); // Current date
            TB_StartTime.Text = "09:00"; // Example start time
            TB_EndTime.Text = "10:00"; // Example end time
            TB_ExactLocation.Text = "Main Conference Room";
            TB_CoordinatorName.Text = "John Doe"; // Example coordinator name

            // Assign dummy values to dropdowns
            if (DDL_WorkRegion.Items.Count > 1) DDL_WorkRegion.SelectedIndex = 1;
            if (DDL_Company.Items.Count > 1) DDL_Company.SelectedIndex = 1;
            if (DDL_Department.Items.Count > 1) DDL_Department.SelectedIndex = 1;
            if (DDL_Location.Items.Count > 1) DDL_Location.SelectedIndex = 1;
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            //if (ViewState["GridViewData"] != null)
            //{
            //    GridView1.DataSource = ViewState["GridViewData"];
            //    GridView1.DataBind();
            //}
        }

        //private void InitializeGrid()
        //{
        //    DataTable dt = new DataTable();
        //    dt.Columns.Add("SLNO");
        //    dt.Columns.Add("AgendaTitle");
        //    dt.Columns.Add("DiscussedByCode");
        //    dt.Columns.Add("DiscussionType");
        //    dt.Columns.Add("CompanyCode");
        //    dt.Columns.Add("DeptCode");
        //    dt.Columns.Add("PointBy");
        //    dt.Columns.Add("AgendaPointDescription");
        //    dt.Columns.Add("Duration");
        //    dt.Columns.Add("RefPhotoBefore");
        //    dt.Columns.Add("AgendaPointAfter");
        //    dt.Columns.Add("RefPhotoAfter");

        //    dt.Rows.Add("1", "", "", "", "", "", "", "", "", "", "", "");
        //    ViewState["GridViewData"] = dt;
        //    GridView1.DataSource = dt;
        //    GridView1.DataBind();
        //}

        //private void RestoreUploadedFiles()
        //{
        //    foreach (GridViewRow row in GridView1.Rows)
        //    {
        //        FileUpload fuBefore = (FileUpload)row.FindControl("fuPhotoBefore");
        //        FileUpload fuAfter = (FileUpload)row.FindControl("fuPhotoAfter");
        //        Label lbl_fuPhotoBefore = (Label)row.FindControl("lbl_fuPhotoBefore");
        //        Label lbl_fuPhotoAfter = (Label)row.FindControl("lbl_fuPhotoAfter");

        //        if (Session["FileBefore_" + row.RowIndex] != null)
        //        {
        //            lbl_fuPhotoBefore.Text = "Uploaded: " + Path.GetFileName(Session["FileBefore_" + row.RowIndex].ToString());
        //        }

        //        if (Session["FileAfter_" + row.RowIndex] != null)
        //        {
        //            lbl_fuPhotoAfter.Text = "Uploaded: " + Path.GetFileName(Session["FileAfter_" + row.RowIndex].ToString());
        //        }
        //    }
        //}


        protected void btnSaveAgendaDetails_Click(object sender, EventArgs e)
        {
            List<AgendaDetail> agendaList = (List<AgendaDetail>)Session["AgendaDetails"];

            if (agendaList != null && agendaList.Count > 0)
            {
                foreach (var agenda in agendaList)
                {
                    string query = "INSERT INTO AgendaDetails (AgendaTitle, Description, PointBy, DiscussionTime, PhotoPath) VALUES (@AgendaTitle, @Description, @PointBy, @DiscussionTime, @PhotoPath)";
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@AgendaTitle", agenda.AgendaTitle);
                            cmd.Parameters.AddWithValue("@Description", agenda.Description);
                            cmd.Parameters.AddWithValue("@PointBy", agenda.PointBy);
                            cmd.Parameters.AddWithValue("@DiscussionTime", agenda.DiscussionTime);
                            cmd.Parameters.AddWithValue("@PhotoPath", agenda.PhotoPath);

                            conn.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                // Clear session after saving
                Session["AgendaDetails"] = null;
                gvAgendaDetails.DataSource = null;
                gvAgendaDetails.DataBind();
            }
        }

        public class AgendaDetail
        {
            public string AgendaTitle { get; set; }
            public string Description { get; set; }
            public string PointBy { get; set; }
            public string DiscussionTime { get; set; }
            public string PhotoPath { get; set; }
        }

        protected void btnAddAgendaDetails_Click(object sender, EventArgs e)
        {
            List<AgendaDetail> agendaList = new List<AgendaDetail>();

            if (Session["AgendaDetails"] != null)
            {
                agendaList = (List<AgendaDetail>)Session["AgendaDetails"];
            }

            // Save the photo if uploaded
            string photoName = fuPhoto.HasFile ? fuPhoto.FileName : string.Empty;
            string photoPath = fuPhoto.HasFile ? SavePhoto(fuPhoto) : string.Empty;

            AgendaDetail newAgenda = new AgendaDetail
            {
                AgendaTitle = ddlAgendaTitle.SelectedItem.Text,
                Description = txtAgendaDesc.Text,
                PointBy = txtPointBy.Text,
                DiscussionTime = ddlDiscussionTime.SelectedValue,
                PhotoPath = !string.IsNullOrEmpty(photoName) ? photoName : "No"
            };

            agendaList.Add(newAgenda);
            Session["AgendaDetails"] = agendaList;

            BindAgendaGrid();
        }

        private void BindAgendaGrid()
        {
            gvAgendaDetails.DataSource = Session["AgendaDetails"];
            gvAgendaDetails.DataBind();
        }

        public string SavePhoto(FileUpload fileUploadControl)
        {
            if (fileUploadControl.HasFile)
            {
                string fileName = Path.GetFileName(fileUploadControl.FileName);
                string filePath = "~/Uploads/" + fileName; // Adjust the path as needed
                fileUploadControl.SaveAs(Server.MapPath(filePath));
                return filePath; // Return the saved file path
            }
            return string.Empty;
        }


        protected void gvAgendaDetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                List<AgendaDetail> agendaList = (List<AgendaDetail>)Session["AgendaDetails"];

                if (agendaList != null && index >= 0 && index < agendaList.Count)
                {
                    agendaList.RemoveAt(index);
                    Session["AgendaDetails"] = agendaList;
                    BindAgendaGrid();
                }
            }
        }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
        }


        //private void PanelThree_RowCmd()
        //{
        //    DataTable dt = ViewState["GridViewData"] as DataTable;
        //    if (dt == null) return;

        //    foreach (GridViewRow row in GridView1.Rows)
        //    {
        //        TextBox txtAgendaTitle = (TextBox)row.FindControl("txtAgendaTitle");
        //        TextBox txtDiscussedByCode = (TextBox)row.FindControl("txtDiscussedByCode");
        //        DropDownList ddlDiscussionType = (DropDownList)row.FindControl("ddlDiscussionType");
        //        DropDownList ddlCompanyCode = (DropDownList)row.FindControl("ddlCompanyCode");
        //        DropDownList ddlDeptCode = (DropDownList)row.FindControl("ddlDeptCode");
        //        TextBox txtPointBy = (TextBox)row.FindControl("txtPointBy");
        //        TextBox txtAgendaDesc = (TextBox)row.FindControl("txtAgendaDesc");
        //        TextBox txtDuration = (TextBox)row.FindControl("txtDuration");
        //        TextBox txtAgendaDescAfter = (TextBox)row.FindControl("txtAgendaDescAfter");

        //        dt.Rows[row.RowIndex]["AgendaTitle"] = txtAgendaTitle.Text;
        //        dt.Rows[row.RowIndex]["DiscussedByCode"] = txtDiscussedByCode.Text;
        //        dt.Rows[row.RowIndex]["DiscussionType"] = ddlDiscussionType.SelectedValue;
        //        dt.Rows[row.RowIndex]["CompanyCode"] = ddlCompanyCode.SelectedValue;
        //        dt.Rows[row.RowIndex]["DeptCode"] = ddlDeptCode.SelectedValue;
        //        dt.Rows[row.RowIndex]["PointBy"] = txtPointBy.Text;
        //        dt.Rows[row.RowIndex]["AgendaPointDescription"] = txtAgendaDesc.Text;
        //        dt.Rows[row.RowIndex]["Duration"] = txtDuration.Text;
        //        dt.Rows[row.RowIndex]["AgendaPointAfter"] = txtAgendaDescAfter.Text;
        //    }

        //    if (e.CommandName == "AddMore")
        //    {
        //        int newSLNo = dt.Rows.Count + 1;
        //        dt.Rows.Add(newSLNo.ToString(), "", "", "", "", "", "", "", "", "", "", "");
        //    }
        //    else if (e.CommandName == "Remove")
        //    {
        //        int rowIndex = Convert.ToInt32(e.CommandArgument);
        //        if (dt.Rows.Count > 1)
        //        {
        //            dt.Rows.RemoveAt(rowIndex);
        //            for (int i = 0; i < dt.Rows.Count; i++)
        //            {
        //                dt.Rows[i]["SLNO"] = (i + 1).ToString();
        //            }
        //        }
        //    }

        //    ViewState["GridViewData"] = dt;
        //    GridView1.DataSource = dt;
        //    GridView1.DataBind();
        //}

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
            if (string.IsNullOrEmpty(DDL_WorkRegion.SelectedValue) || string.IsNullOrEmpty(DDL_Company.SelectedValue) || string.IsNullOrEmpty(DDL_Location.SelectedValue))
            {
                lblMsg.Text = "Please select all required fields.";
                return;
            }
            else
            {
               // PanelOneDateSaver();

                //Below is for Dev Only
                PanelOne_DummyDataSaver();
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

        private void PanelOne_DummyDataSaver()
        {
            try
            {
                PanelOneDateSaver(); // Save data

                // Show success notification
                string script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Success',
                                text: 'Meeting details saved successfully!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                            moveToNext('Meeting', 'Attendees'); // Move to next tab
                          </script>";
                ScriptManager.RegisterStartupScript(this, GetType(), "MoveNextTab", script, false);
            }
            catch (Exception ex)
            {
                string errorScript = $"<script type='text/javascript'> new PNotify({{ title: 'Error', text: '{ex.Message}', type: 'error', styling: 'bootstrap3' }}); </script>";
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorMessage", errorScript, false);
            }
        }

        private void PanelOneDateSaver()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string meetingId = Guid.NewGuid().ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO csm_massmeting_records (MM_Id, MM_DocNo, Meeting_Date, Meeting_StartTime, Meeting_EndTime, SubmitterCode, RegionCode, CompanyCode, DeptCode, LocationCode, ExactLocation, Coordinator_Name, LastModifiedOn, LastModifiedByCode) 
                        VALUES (@MM_Id, @MM_DocNo, @Meeting_Date, @Meeting_StartTime, @Meeting_EndTime, @SubmitterCode, @RegionCode, @CompanyCode, @DeptCode, @LocationCode, @ExactLocation, @Coordinator_Name, GETDATE(), @LastModifiedByCode)";

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





        protected void btnsave3_Click(object sender, EventArgs e)
        {
            PanelThree_dataSaver();
        }

        private void PanelThree_dataSaver()
        {
            string meetingId = HiddenField_MMId.Value;

            if (string.IsNullOrEmpty(meetingId) && ViewState["MM_Id"] != null)
            {
                meetingId = ViewState["MM_Id"].ToString();
            }

            if (string.IsNullOrEmpty(meetingId))
            {
                Label7.Text = "Error: Meeting ID is missing!";
                Label7.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
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

                    foreach (GridViewRow row in gvAgendaDetails.Rows)
                    {
                        if (row.RowType == DataControlRowType.DataRow)
                        {
                            string momId = Guid.NewGuid().ToString();
                            //Label lblAgendaTitle = (Label)row.FindControl("lblAgendaTitle");
                            //Label lblDescription = (Label)row.FindControl("lblDescription");
                            //Label lblPointBy = (Label)row.FindControl("lblPointBy");
                            //Label lblDiscussionTime = (Label)row.FindControl("lblDiscussionTime");
                            //Label lblPhotoPath = (Label)row.FindControl("lblPhotoPath");

                            // Extract values from BoundFields using Cells[index]
                            string agendaTitle = row.Cells[0].Text.Trim(); // Agenda Title
                            string description = row.Cells[1].Text.Trim(); // Description
                            string pointBy = row.Cells[2].Text.Trim(); // Point Raised By
                            string discussionTime = row.Cells[3].Text.Trim(); // Discussion Time
                            string photoPath = row.Cells[4].Text.Trim(); // Photo Path

                            //string agendaTitle = lblAgendaTitle != null ? lblAgendaTitle.Text.Trim() : "";
                            //string description = lblDescription != null ? lblDescription.Text.Trim() : "";
                            //string pointBy = lblPointBy != null ? lblPointBy.Text.Trim() : "";
                            //string discussionTime = lblDiscussionTime != null ? lblDiscussionTime.Text.Trim() : "";
                            //string photoPath = lblPhotoPath != null ? lblPhotoPath.Text.Trim() : "";

                            if (photoPath == "No")
                                photoPath = "";

                            string insertQuery = @"
                            INSERT INTO csm_massmeting_mom 
                            (MM_Id, MOM_Id, AgendaTitle, PointBy, RegionCode, LocationCode, DiscussionDescription1, Duration, Ref_PhotoPathBefore, DiscussedByCode, DiscussionType, DeptCode, CompanyCode, DiscussionDescription2, Ref_PhotoAfter, Ref_PhotoPathAfter)
                            VALUES 
                            (@MM_Id, @MOM_Id, @AgendaTitle, @PointBy, @RegionCode, @LocationCode, @DiscussionDescription1, @Duration, @Ref_PhotoPathBefore, @DiscussedByCode, @DiscussionType, @DeptCode, @CompanyCode, @DiscussionDescription2, @Ref_PhotoAfter, @Ref_PhotoPathAfter)";

                            using (SqlCommand cmd = new SqlCommand(insertQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                                cmd.Parameters.AddWithValue("@MOM_Id", momId);
                                cmd.Parameters.AddWithValue("@AgendaTitle", agendaTitle);
                                cmd.Parameters.AddWithValue("@PointBy", pointBy);
                                cmd.Parameters.AddWithValue("@DiscussedByCode", "");
                                cmd.Parameters.AddWithValue("@RegionCode", regionCode);
                                cmd.Parameters.AddWithValue("@LocationCode", locationCode);
                                cmd.Parameters.AddWithValue("@DiscussionDescription1", description);
                                cmd.Parameters.AddWithValue("@Duration", discussionTime);
                                cmd.Parameters.AddWithValue("@Ref_PhotoBefore", "");                                
                                cmd.Parameters.AddWithValue("@Ref_PhotoPathBefore", photoPath);

                                // Additional fields with empty values (if not present in GridView)
                                
                                cmd.Parameters.AddWithValue("@DiscussionType", "");
                                cmd.Parameters.AddWithValue("@DeptCode", ""); //Shall be taken from login user session
                                cmd.Parameters.AddWithValue("@CompanyCode", ""); //Shall be taken from login user session
                                cmd.Parameters.AddWithValue("@DiscussionDescription2", "");
                                cmd.Parameters.AddWithValue("@Ref_PhotoAfter", "");
                                cmd.Parameters.AddWithValue("@Ref_PhotoPathAfter", "");

                                cmd.ExecuteNonQuery();
                            }
                        }
                    }

                    transaction.Commit();
                    Label7.Text = "Points saved successfully!";
                    Label7.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    Label7.Text = "Error: " + ex.Message;
                    Label7.ForeColor = System.Drawing.Color.Red;
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
            //pnlAttendeeType.Visible = rbEmployee.SelectedValue == "Yes";
            //pnlDetails.Visible = rbEmployee.SelectedValue == "No";
        }

        protected void rbAttendeeType_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool isInternal = rbAttendeeType.SelectedValue == "Internal";
            txtAttendeeCode.Text = isInternal ? "N/A" : "N/A";
            txtAttendeeCode.Enabled = isInternal;
            pnlDetails.Visible = true;
        }


        [WebMethod]
        public static List<Attendee> AddAttendee(string attendeeType, string empCode, string empName, string designation, string gatePassNo)
        {
            List<Attendee> attendees = new List<Attendee>();

            if (HttpContext.Current.Session["Attendees"] != null)
            {
                attendees = (List<Attendee>)HttpContext.Current.Session["Attendees"];
            }

            Attendee newAttendee = new Attendee
            {
                EmployeeOrNot = attendeeType == "Internal" ? "Yes" : "No",
                AttendeeType = attendeeType,
                AttendeeCode = empCode,
                EmployeeName = empName,
                Designation = designation,
                GatePassNo = gatePassNo
                //ImagePath = imagePath // Assuming image URL is stored
            };

            attendees.Add(newAttendee);
            HttpContext.Current.Session["Attendees"] = attendees;

            return attendees;
        }

        public class Attendee
        {
            public string EmployeeOrNot { get; set; }   //from here every column of gridview is getting fetched..
            public string AttendeeType { get; set; }
            public string AttendeeCode { get; set; }
            public string EmployeeName { get; set; }
            public string Designation { get; set; }
            public string GatePassNo { get; set; }
            //public string ImagePath { get; set; }  //ye sir ne kyu comment kia...?unke paas uploads wla folder hoga nhi toh filepath nhi milra hoga isiliye
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
            //dr["EmployeeOrNot"] = rbEmployee.SelectedItem != null ? rbEmployee.SelectedItem.Text : "";
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
            //rbEmployee.ClearSelection();
            rbAttendeeType.ClearSelection();
            txtEmployeeName.Text = "";
            txtAttendeeCode.Text = "";
            txtgatepassno.Text = "";
            txtdes.Text = "";
        }

        protected void btnsave2_Click(object sender, EventArgs e)
        {
            PanelTwo_DataSaver();
        }

        private void PanelTwo_DataSaver()
        {
            // Retrieve attendees from session
            List<Attendee> attendees = HttpContext.Current.Session["Attendees"] as List<Attendee>;

            if (attendees == null || attendees.Count == 0)
            {
                ShowPNotify("Error", "No attendees to save!", "error");
                return;
            }

            // Retrieve Meeting ID
            string meetingId = HiddenField_MMId.Value;
            if (string.IsNullOrEmpty(meetingId) && ViewState["MM_Id"] != null)
            {
                meetingId = ViewState["MM_Id"].ToString();
            }

            if (string.IsNullOrEmpty(meetingId))
            {
                ShowPNotify("Error", "Meeting ID is missing!", "error");
                return;
            }

            // Database connection
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = @"INSERT INTO csm_massmeting_attendee 
                         (MM_Id, AttendeeCode, EmployeeName, Attendee_Type, Designation, Gate_passno) 
                         VALUES (@MM_Id, @AttendeeCode, @EmployeeName, @Attendee_Type, @Designation, @Gate_passno)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    foreach (var attendee in attendees)
                    {
                        // Clear parameters at the beginning of each loop iteration
                        cmd.Parameters.Clear();

                        // Add parameters inside the loop for each attendee
                        cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                        cmd.Parameters.AddWithValue("@AttendeeCode", attendee.AttendeeCode);
                        cmd.Parameters.AddWithValue("@EmployeeName", attendee.EmployeeName);
                        cmd.Parameters.AddWithValue("@Attendee_Type", attendee.AttendeeType);
                        cmd.Parameters.AddWithValue("@Designation", attendee.Designation);
                        cmd.Parameters.AddWithValue("@Gate_passno", attendee.GatePassNo);

                        cmd.ExecuteNonQuery();
                    }
                }
            }

            // Show success notification
            ShowPNotify("Success", "Attendees saved successfully!", "success");

            // Clear the session after saving
            //HttpContext.Current.Session["Attendees"] = null;

            // ✅ Instead of clearing session, refresh GridView
            BindAttendeeGrid();

            // Move to the next tab after saving
            ScriptManager.RegisterStartupScript(this, GetType(), "MoveToNextTab", "moveToNext('Attendees', 'Points');", true);
        }

        private void BindAttendeeGrid()
        {
            if (Session["Attendees"] != null)
            {
                gvAttendees.DataSource = (List<Attendee>)Session["Attendees"];
                gvAttendees.DataBind();
            }
        }


        private void PanelTwo_DataSaver_Esha()
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