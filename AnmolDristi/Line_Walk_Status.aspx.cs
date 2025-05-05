using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Line_Walk_Status : System.Web.UI.Page
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

                }
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            DataSaver();
        }

        protected void DataSaver()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    using (SqlTransaction transaction = con.BeginTransaction())
                    {
                        try
                        {
                            // Insert the main Line Walk Status
                            string insertWalkStatusQuery = @"INSERT INTO [Line_walk_status] ([WalkDate], [JobDescription], [JobID]) VALUES (@WalkDate, @JobDescription, @JobID); SELECT SCOPE_IDENTITY();";
                            int walkStatusId;
                            using (SqlCommand cmd = new SqlCommand(insertWalkStatusQuery, con, transaction))
                            {
                                cmd.Parameters.AddWithValue("@WalkDate", DateTime.Today);
                                cmd.Parameters.AddWithValue("@JobDescription", TB_JD.Text.Trim());
                                cmd.Parameters.AddWithValue("@JobID", TB_ID.Text.Trim());

                                walkStatusId = Convert.ToInt32(cmd.ExecuteScalar());
                                if (walkStatusId <= 0)
                                {
                                    throw new Exception("Failed to insert into Line_walk_status.");
                                }
                            }

                            // Fetch team members and save them
                            //List<TeamMember> teamMembers = GetTeamMembersFromForm();
                            DataTable dt = Session["EmpData"] as DataTable;
                            if (dt != null && dt.Rows.Count > 0)
                            {
                                foreach (DataRow row in dt.Rows)
                                {
                                    string insertTeamMemberQuery = @"INSERT INTO [Line_walk_status_description] ([ID], [TM_names]) VALUES (@ID, @TM_names);";
                                    using (SqlCommand cmdTeam = new SqlCommand(insertTeamMemberQuery, con, transaction))
                                    {
                                        cmdTeam.Parameters.AddWithValue("@ID", walkStatusId);
                                        cmdTeam.Parameters.AddWithValue("@TM_names", row["EmpName"]);
                                        if (cmdTeam.ExecuteNonQuery() == 0)
                                            throw new Exception("Failed to insert into Line_walk_status_description.");
                                    }
                                }
                            }


                            // Fetch observations from the session DataTable
                            DataTable dtObservations = Session["ObservationData"] as DataTable;

                            if (dtObservations != null && dtObservations.Rows.Count > 0)
                            {
                                foreach (DataRow row in dtObservations.Rows)
                                {
                                    string insertWalkDetailQuery = @"INSERT INTO [Line_walk_details] 
                                 ([ID], [Location], [Observation_Points], [Recommendation_Points], [Responsibility], 
                                  [Target_Date], [Remarks], [Snap_File_Path]) 
                                 VALUES (@ID, @Location, @Observation_Points, @Recommendation_Points, @Responsibility, 
                                         @Target_Date, @Remarks, @Snap_File_Path);";

                                    using (SqlCommand cmdWalkDetail = new SqlCommand(insertWalkDetailQuery, con, transaction))
                                    {
                                        cmdWalkDetail.Parameters.AddWithValue("@ID", walkStatusId); // <== this is the walk ID
                                        cmdWalkDetail.Parameters.AddWithValue("@Location", row["Area"]);
                                        cmdWalkDetail.Parameters.AddWithValue("@Observation_Points", row["Observation"]);
                                        cmdWalkDetail.Parameters.AddWithValue("@Recommendation_Points", row["Recommendation"]);
                                        cmdWalkDetail.Parameters.AddWithValue("@Responsibility", row["Responsibility"]);
                                        cmdWalkDetail.Parameters.AddWithValue("@Target_Date", Convert.ToDateTime(row["TargetDate"]));
                                        cmdWalkDetail.Parameters.AddWithValue("@Remarks", row["Remarks"]);
                                        cmdWalkDetail.Parameters.AddWithValue("@Snap_File_Path", row["FilePath"]);

                                        if (cmdWalkDetail.ExecuteNonQuery() == 0)
                                            throw new Exception("Failed to insert into Line_walk_details.");
                                    }
                                }
                            }


                            //if (dtObservations != null && dtObservations.Rows.Count > 0)
                            //{
                            //    foreach (DataRow row in dtObservations.Rows)
                            //    {
                            //        string insertWalkDetailQuery = @"INSERT INTO [Line_walk_details] 
                            //                                 ([ID], [Location], [Observation_Points], [Recommendation_Points], [Responsibility], 
                            //                                  [Target_Date], [Remarks], [Snap_File_Path]) 
                            //                                 VALUES (@ID, @Location, @Observation_Points, @Recommendation_Points, @Responsibility, 
                            //                                         @Target_Date, @Remarks, @Snap_File_Path);";

                            //        using (SqlCommand cmdWalkDetail = new SqlCommand(insertWalkDetailQuery, con, transaction))
                            //        {
                            //            cmdWalkDetail.Parameters.AddWithValue("@ID", walkStatusId);
                            //            cmdWalkDetail.Parameters.AddWithValue("@Location", row["Area"]);
                            //            cmdWalkDetail.Parameters.AddWithValue("@Observation_Points", row["Observation"]);
                            //            cmdWalkDetail.Parameters.AddWithValue("@Recommendation_Points", row["Recommendation"]);
                            //            cmdWalkDetail.Parameters.AddWithValue("@Responsibility", row["Responsibility"]);
                            //            cmdWalkDetail.Parameters.AddWithValue("@Target_Date", Convert.ToDateTime(row["TargetDate"]));
                            //            cmdWalkDetail.Parameters.AddWithValue("@Remarks", row["Remarks"]);
                            //            cmdWalkDetail.Parameters.AddWithValue("@Snap_File_Path", row["FilePath"]);

                            //            if (cmdWalkDetail.ExecuteNonQuery() == 0)
                            //                throw new Exception("Failed to insert into Line_walk_details.");
                            //        }
                            //    }
                            //}

                            transaction.Commit();
                            string successScript = $"Swal.fire({{ title: 'Success!', text: 'All data saved successfully.', icon: 'success' }});";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitSuccess", successScript, true);
                        }
                        catch (Exception ex)
                        {
                            transaction.Rollback();
                            string errorScript = $"Swal.fire({{ title: 'Error!', text: '{ex.Message}', icon: 'error' }});";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitError", errorScript, true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                string errorScript = $"Swal.fire({{ title: 'Error!', text: '{ex.Message}', icon: 'error' }});";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitError", errorScript, true);
            }
        }




        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Session["EmpData"] = null;
            Session["ObservationData"] = null;
            Response.Redirect("Line_Walk_Status.aspx");

        }

        //Method to fetch team members data from form controls
        private List<TeamMember> GetTeamMembersFromForm()
        {
            var teamMembers = new List<TeamMember>();

            // Loop through expected team member textboxes (adjust the number as needed)
            for (int i = 0; i < 5; i++) // Change 5 to the number of team members allowed
            {
                TextBox nameTextBox = (TextBox)FindControl("TB_EmpName" + i); 

                if (nameTextBox != null)
                {
                    string name = nameTextBox.Text.Trim();

                    if (!string.IsNullOrEmpty(name))
                    {
                        teamMembers.Add(new TeamMember { Name = name });
                    }
                }
            }

            return teamMembers;
        }


        // Method to fetch walk details data from form controls
        //private List<WalkDetail> GetWalkDetailsFromForm()
        //{
        //    var walkDetails = new List<WalkDetail>();

        //    int index = 0;

        //    while (true)
        //    {
        //        // Dynamically construct control IDs
        //        TextBox responsibilityTextBox = (TextBox)FindControl("TB_Responsibility_" + index);
        //        TextBox targetDateTextBox = (TextBox)FindControl("TB_TargetDate_" + index);
        //        TextBox remarksTextBox = (TextBox)FindControl("TB_Remarks_" + index);
        //        FileUpload snapFileUploadControl = (FileUpload)FindControl("File_Snaps_" + index);

        //        // Exit loop when no more controls are found
        //        if (responsibilityTextBox == null || targetDateTextBox == null || remarksTextBox == null || snapFileUploadControl == null)
        //            break;

        //        string responsibility = responsibilityTextBox.Text.Trim();
        //        string remarks = remarksTextBox.Text.Trim();
        //        DateTime targetDate;

        //        DateTime.TryParse(targetDateTextBox.Text, out targetDate);

        //        // Optional: handle image upload
        //        //string snapPath = SaveSnapToUploadsFolder(snapFileUploadControl);
        //        string snapPath = SaveUploadedImageForWalkDetail(snapFileUploadControl);

        //        walkDetails.Add(new WalkDetail
        //        {
        //            Responsibility = responsibility,
        //            TargetDate = targetDate,
        //            Remarks = remarks,
        //            SnapPath = snapPath
        //        });

        //        index++;
        //    }

        //    return walkDetails;
        //}


        //private string SaveSnapToUploadsFolder(FileUpload fileUploadControl)
        //{
        //    if (fileUploadControl.HasFile)
        //    {
        //        try
        //        {
        //            string folderPath = Server.MapPath("~/Uploads/");
        //            if (!Directory.Exists(folderPath))
        //                Directory.CreateDirectory(folderPath);

        //            string filename = Guid.NewGuid().ToString() + Path.GetExtension(fileUploadControl.FileName);
        //            string fullPath = Path.Combine(folderPath, filename);
        //            fileUploadControl.SaveAs(fullPath);

        //            return "~/Uploads/" + filename;
        //        }
        //        catch (Exception ex)
        //        {
        //            Console.WriteLine("Error uploading file: " + ex.Message);
        //            return null;
        //        }
        //    }
        //    return null;
        //}




        // Method to save uploaded image for walk detail snap
        //private string SaveUploadedImageForWalkDetail(FileUpload fileUploadControl)
        //{
        //    if (fileUploadControl.HasFile)
        //    {
        //        try
        //        {
        //            string fileName = Path.GetFileName(fileUploadControl.PostedFile.FileName);
        //            string fileExtension = Path.GetExtension(fileName);
        //            string uniqueFileName = DateTime.Now.Ticks.ToString() + fileExtension;

        //            string folderPath = Server.MapPath("~/images/");
        //            if (!Directory.Exists(folderPath))
        //            {
        //                Directory.CreateDirectory(folderPath);
        //            }

        //            string imagePath = Path.Combine(folderPath, uniqueFileName);
        //            fileUploadControl.SaveAs(imagePath);

        //            return "~/images/" + uniqueFileName;
        //        }
        //        catch (Exception ex)
        //        {
        //            Console.WriteLine("Error uploading file: " + ex.Message);
        //        }
        //    }

        //    return null;
        //}


        // Define the data models for TeamMember and WalkDetail
        public class TeamMember
        {
            public string Name { get; set; }
            
        }

        public class WalkDetail
        {
            public string Location { get; set; }
            public string Observation { get; set; }
            public string Recommendation { get; set; }
            public string Responsibility { get; set; }
            public DateTime TargetDate { get; set; }
            public string Remarks { get; set; }
            public string SnapPath { get; set; }
        }


        //-------------------------------Added on 15-04-2025-----------KK-TL---------------//
        [WebMethod]
        public static string GetEmpName(string empCode)
        {
            string empName = "";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT EmployeeName FROM MST_UserMaster WHERE EmployeeCode = @Code", con);
                cmd.Parameters.AddWithValue("@Code", empCode);
                con.Open();
                var result = cmd.ExecuteScalar();
                if (result != null)
                    empName = result.ToString();
            }

            return empName;
        }

        public class MemberEntry
        {
            public string type { get; set; }
            public string code { get; set; }
            public string name { get; set; }
        }

        private void ShowNotification(string title, string message, string type = "error")
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Notify",
                $"showNotification('{title}', '{message}', '{type}');", true);
        }

        

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataTable dt = Session["ObservationData"] as DataTable;
            if (dt != null)
            {
                dt.Rows.RemoveAt(e.RowIndex);
                GridView1.DataSource = dt;
                GridView1.DataBind();

                Session["ObservationData"] = dt;
            }
        }

        protected void btn_panel1_save_Click(object sender, EventArgs e)
        {
            
        }

        protected void btn_panel2_save_Click(object sender, EventArgs e)
        {
            string json = HF_MemberList.Value;
            if (string.IsNullOrEmpty(json))
                return;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<MemberEntry> members = serializer.Deserialize<List<MemberEntry>>(json);

            List<string> internalCodes = new List<string>();
            List<string> externalNames = new List<string>();

            foreach (var member in members)
            {
                if (member.type == "Internal" && !string.IsNullOrWhiteSpace(member.code))
                {
                    internalCodes.Add(member.code.Trim());
                }
                else if (member.type == "External" && !string.IsNullOrWhiteSpace(member.name))
                {
                    externalNames.Add(member.name.Trim());
                }
            }

            string internalString = string.Join(",", internalCodes);
            string externalString = string.Join(",", externalNames);

            //lbl_panel2_msg.Text = $"✅ Internal: {internalString} | ✅ External: {externalString}";
        }

        protected void btnAddToGrid_Click(object sender, EventArgs e)
        {
            try
            {
                string area = txtAreaLocation.Text.Trim();
                string observation = txtObservation.Text.Trim();
                string recommendation = txtRecommendation.Text.Trim();
                string responsibility = txtResponsibility.Text.Trim();
                string targetDate = txtTargetDate.Text.Trim();
                string remarks = txtRemarks.Text.Trim();
                string filePath = "";

                if (fileSnap.HasFile)
                {
                    string folderPath = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(folderPath))
                        Directory.CreateDirectory(folderPath);

                    string filename = Guid.NewGuid().ToString() + "_" + Path.GetFileName(fileSnap.FileName);
                    filePath = "~/Uploads/" + filename;
                    fileSnap.SaveAs(Path.Combine(folderPath, filename));
                }

                DataTable dt = Session["ObservationData"] as DataTable;
                if (dt == null)
                {
                    dt = new DataTable();
                    dt.Columns.Add("Area");
                    dt.Columns.Add("Observation");
                    dt.Columns.Add("Recommendation");
                    dt.Columns.Add("Responsibility");
                    dt.Columns.Add("TargetDate");
                    dt.Columns.Add("Remarks");
                    dt.Columns.Add("FilePath");
                }

                dt.Rows.Add(area, observation, recommendation, responsibility, targetDate, remarks, filePath);

                Session["ObservationData"] = dt;
                GridView1.DataSource = dt;
                GridView1.DataBind();

                txtAreaLocation.Text = "";
                txtObservation.Text = "";
                txtRecommendation.Text = "";
                txtResponsibility.Text = "";
                txtTargetDate.Text = "";
                txtRemarks.Text = "";
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Error saving observation: " + ex.Message + "');", true);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)

        {
            try
            {

                string EmpType = rblEmpType.SelectedValue;
                string EmpCode = txtEmpCode.Text.Trim();
                string EmpName = txtEmpName.Text.Trim();

                if (EmpType != "Internal")
                {
                    EmpCode = "-";
                }

                DataTable dt = Session["EmpData"] as DataTable;
                if (dt == null)
                {
                    dt = new DataTable();
                    dt.Columns.Add("EmpType");
                    dt.Columns.Add("EmpCode");
                    dt.Columns.Add("EmpName");

                }

                dt.Rows.Add(EmpType, EmpCode, EmpName);

                Session["EmpData"] = dt;
                GridView2.DataSource = dt;
                GridView2.DataBind();

                rblEmpType.SelectedValue = "";
                txtEmpCode.Text = "";
                txtEmpName.Text = "";
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Error saving Team members: " + ex.Message + "');", true);
            }
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseModalAndAlert", @"
        var modal = bootstrap.Modal.getInstance(document.getElementById('employeeModal'));
        if (modal) { modal.hide(); }
        showSuccessAlert();", true);
        }
    }

        //protected void Btn_AddMember_Click(object sender, EventArgs e)
        //{
        //    try
        //    {

        //        string EmpType = rblEmpType.SelectedValue;
        //        string EmpCode = txtEmpCode.Text.Trim();
        //        string EmpName = txtEmpName.Text.Trim();

        //        if (EmpType != "Internal")
        //        {
        //            EmpCode = "-";
        //        }

        //        DataTable dt = Session["EmpData"] as DataTable;
        //        if (dt == null)
        //        {
        //            dt = new DataTable();
        //            dt.Columns.Add("EmpType");
        //            dt.Columns.Add("EmpCode");
        //            dt.Columns.Add("EmpName");

        //        }

        //        dt.Rows.Add(EmpType, EmpCode, EmpName);

        //        Session["EmpData"] = dt;
        //        GridView2.DataSource = dt;
        //        GridView2.DataBind();

        //        rblEmpType.SelectedValue = "";
        //        txtEmpCode.Text = "";
        //        txtEmpName.Text = "";
        //    }
        //    catch (Exception ex)
        //    {
        //        ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Error saving Team members: " + ex.Message + "');", true);
        //    }



        }








        //-------------------------------Added on 15-04-2025-----------KK-TL--------------//
    

