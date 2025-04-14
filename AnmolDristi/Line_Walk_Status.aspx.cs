//using System;
//using System.Collections.Generic;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;
//using System.Web.UI;

//namespace AnmolDristi
//{
//    public partial class Line_Walk_Status : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//        }

//        protected void BtnSubmit_Click(object sender, EventArgs e)

//      {
//            try
//            {
//                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

//                using (SqlConnection con = new SqlConnection(connectionString))
//                using (SqlCommand cmd = new SqlCommand("SP_Line_Walk_Status", con))
//                {
//                    cmd.CommandType = CommandType.StoredProcedure;

//                    DateTime walkDate = DateTime.Today; // Replace with: Convert.ToDateTime(txtDate.Text);
//                    string jobDescription = TB_JD.Text.Trim();
//                    string jobId = TB_ID.Text.Trim();

//                    cmd.Parameters.AddWithValue("@WalkDate", walkDate);
//                    cmd.Parameters.AddWithValue("@JobDescription", jobDescription);
//                    cmd.Parameters.AddWithValue("@JobID", jobId);

//                    // Get real user input from the form
//                    List<TeamMember> teamMembers = GetTeamMembersFromForm();
//                    DataTable teamMembersTable = GetTeamMembersTable(teamMembers);
//                    SqlParameter teamParam = cmd.Parameters.AddWithValue("@TeamMembers", teamMembersTable);
//                    teamParam.SqlDbType = SqlDbType.Structured;
//                    teamParam.TypeName = "dbo.TeamMembersType";

//                    List<WalkDetail> walkDetails = GetWalkDetailsFromForm();
//                    DataTable detailsTable = GetWalkDetailsTable(walkDetails);
//                    SqlParameter detailParam = cmd.Parameters.AddWithValue("@WalkDetails", detailsTable);
//                    detailParam.SqlDbType = SqlDbType.Structured;
//                    detailParam.TypeName = "dbo.WalkDetailsType";

//                    con.Open();
//                    cmd.ExecuteNonQuery();

//                    string successScript = $"Swal.fire({{ title: 'Success!', text: 'Data saved successfully.', icon: 'success' }});";
//                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitSuccess", successScript, true);
//                }
//            }
//            catch (Exception ex)
//            {
//                string errorScript = $"Swal.fire({{ title: 'Error!', text: '{ex.Message}', icon: 'error' }});";
//                ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitError", errorScript, true);
//            }
//        }

//        protected void BtnReset_Click(object sender, EventArgs e)
//        {
//            Response.Redirect("Line_Walk_Status.aspx");
//        }

//        private DataTable GetTeamMembersTable(List<TeamMember> teamMembers)
//        {
//            var table = new DataTable();
//            table.Columns.Add("TM_names", typeof(string));
//            table.Columns.Add("TM_Image", typeof(string));

//            foreach (var member in teamMembers)
//            {
//                table.Rows.Add(member.Name, member.Image);
//            }

//            return table;
//        }

//        private DataTable GetWalkDetailsTable(List<WalkDetail> walkDetails)
//        {
//            var table = new DataTable();
//            table.Columns.Add("Location", typeof(string));
//            table.Columns.Add("Observation_Points", typeof(string));
//            table.Columns.Add("Recommendation_Points", typeof(string));
//            table.Columns.Add("Responsibility", typeof(string));
//            table.Columns.Add("Target_Date", typeof(DateTime));
//            table.Columns.Add("Remarks", typeof(string));
//            table.Columns.Add("Snap_File_Path", typeof(string));

//            foreach (var detail in walkDetails)
//            {
//                table.Rows.Add(detail.Location, detail.Observation, detail.Recommendation,
//                               detail.Responsibility, detail.TargetDate, detail.Remarks, detail.SnapPath);
//            }

//            return table;
//        }

//        // Define the data models
//        public class TeamMember
//        {
//            public string Name { get; set; }
//            public string Image { get; set; }
//        }

//        public class WalkDetail
//        {
//            public string Location { get; set; }
//            public string Observation { get; set; }
//            public string Recommendation { get; set; }
//            public string Responsibility { get; set; }
//            public DateTime TargetDate { get; set; }
//            public string Remarks { get; set; }
//            public string SnapPath { get; set; }
//        }

//        // Replace these with logic to fetch actual form values
//        private List<TeamMember> GetTeamMembersFromForm()
//        {
//            return new List<TeamMember>(); // Fill this from your frontend inputs
//        }

//        private List<WalkDetail> GetWalkDetailsFromForm()
//        {
//            return new List<WalkDetail>(); // Fill this from your frontend inputs
//        }
//    }
//}




using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Line_Walk_Status : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
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
                            string insertWalkStatusQuery = @"
                        INSERT INTO [dbo].[Line_walk_status] 
                        ([WalkDate], [JobDescription], [JobID]) 
                        VALUES (@WalkDate, @JobDescription, @JobID); 
                        SELECT SCOPE_IDENTITY();";

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

                            // Insert into Line_walk_status_description
                            List<TeamMember> teamMembers = GetTeamMembersFromForm();
                            foreach (var member in teamMembers)
                            {
                                string insertTeamMemberQuery = @"
                            INSERT INTO [dbo].[Line_walk_status_description] 
                            ([ID], [TM_names], [TM_Image]) 
                            VALUES (@ID, @TM_names, @TM_Image);";

                                using (SqlCommand cmdTeam = new SqlCommand(insertTeamMemberQuery, con, transaction))
                                {
                                    cmdTeam.Parameters.AddWithValue("@ID", walkStatusId);
                                    cmdTeam.Parameters.AddWithValue("@TM_names", member.Name);
                                    cmdTeam.Parameters.AddWithValue("@TM_Image", member.Image);

                                    if (cmdTeam.ExecuteNonQuery() == 0)
                                        throw new Exception("Failed to insert into Line_walk_status_description.");
                                }
                            }

                            // Insert into Line_walk_details
                            List<WalkDetail> walkDetails = GetWalkDetailsFromForm();
                            foreach (var detail in walkDetails)
                            {
                                string insertWalkDetailQuery = @"
                            INSERT INTO [dbo].[Line_walk_details] 
                            ([ID], [Location], [Observation_Points], [Recommendation_Points], 
                             [Responsibility], [Target_Date], [Remarks], [Snap_File_Path]) 
                            VALUES 
                            (@ID, @Location, @Observation_Points, @Recommendation_Points, 
                             @Responsibility, @Target_Date, @Remarks, @Snap_File_Path);";

                                using (SqlCommand cmdWalkDetail = new SqlCommand(insertWalkDetailQuery, con, transaction))
                                {
                                    cmdWalkDetail.Parameters.AddWithValue("@ID", walkStatusId);
                                    cmdWalkDetail.Parameters.AddWithValue("@Location", detail.Location ?? "");
                                    cmdWalkDetail.Parameters.AddWithValue("@Observation_Points", detail.Observation ?? "");
                                    cmdWalkDetail.Parameters.AddWithValue("@Recommendation_Points", detail.Recommendation ?? "");
                                    cmdWalkDetail.Parameters.AddWithValue("@Responsibility", detail.Responsibility ?? "");
                                    cmdWalkDetail.Parameters.AddWithValue("@Target_Date", detail.TargetDate);
                                    cmdWalkDetail.Parameters.AddWithValue("@Remarks", detail.Remarks ?? "");
                                    cmdWalkDetail.Parameters.AddWithValue("@Snap_File_Path", detail.SnapPath ?? "");

                                    if (cmdWalkDetail.ExecuteNonQuery() == 0)
                                        throw new Exception("Failed to insert into Line_walk_details.");
                                }
                            }

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
            Response.Redirect("Line_Walk_Status.aspx");
        }

        // Method to fetch team members data from form controls
        private List<TeamMember> GetTeamMembersFromForm()
        {
            var teamMembers = new List<TeamMember>();

            // Assuming you have multiple TextBoxes for team member names
            // Fetching each team member's name and image upload control values
            for (int i = 0; i < 5; i++) // Adjust the loop to handle the correct number of dynamic entries
            {
                // Reference each control (this could be dynamic, for example, by indexing the TextBox names)
                TextBox nameTextBox = (TextBox)FindControl("TB_TeamMemberName" + i); // Assuming the name controls are TB_TeamMemberName0, TB_TeamMemberName1, etc.
                FileUpload imageUploadControl = (FileUpload)FindControl("File_TeamMemberImage" + i); // Similarly, for the image controls

                if (nameTextBox != null && imageUploadControl != null)
                {
                    string name = nameTextBox.Text.Trim();
                    if (!string.IsNullOrEmpty(name))
                    {
                        string imagePath = SaveUploadedImageForTeamMember(imageUploadControl);
                        teamMembers.Add(new TeamMember { Name = name, Image = imagePath });
                    }
                }
            }

            return teamMembers;
        }

        // Method to fetch walk details data from form controls
        private List<WalkDetail> GetWalkDetailsFromForm()
        {
            var walkDetails = new List<WalkDetail>();

            // Loop through each dynamic set of fields (Responsibility, TargetDate, Remarks, etc.)
            for (int i = 0; i < 1; i++) // Change this based on your actual loop logic
            {
                // Fetch values for each input control by ID
                TextBox responsibilityTextBox = (TextBox)FindControl("TB_Responsibility");
                TextBox targetDateTextBox = (TextBox)FindControl("TB_TargetDate");
                TextBox remarksTextBox = (TextBox)FindControl("TB_Remarks");
                FileUpload snapFileUploadControl = (FileUpload)FindControl("File_Snaps");

                // Check if controls are found, to avoid NullReferenceException
                if (responsibilityTextBox != null && targetDateTextBox != null && remarksTextBox != null && snapFileUploadControl != null)
                {
                    string responsibility = responsibilityTextBox.Text;
                    DateTime targetDate;

                    // Try parsing the target date, default to DateTime.MinValue if parsing fails
                    DateTime.TryParse(targetDateTextBox.Text, out targetDate);
                    string remarks = remarksTextBox.Text;

                    // Handle the snap file upload - save the image and get its path
                    string snapPath = SaveUploadedImageForWalkDetail(snapFileUploadControl);

                    // Create WalkDetail object with dynamic form values
                    walkDetails.Add(new WalkDetail
                    {
                        Responsibility = responsibility,
                        TargetDate = targetDate,
                        Remarks = remarks,
                        SnapPath = snapPath
                    });
                }
                else
                {
                    // Log or handle the error when controls are not found
                    Console.WriteLine("Some controls were not found in the page.");
                }
            }

            return walkDetails;
        }

        // Method to save uploaded image for team member
        private string SaveUploadedImageForTeamMember(FileUpload fileUploadControl)
        {
            string imagePath = string.Empty;

            if (fileUploadControl.HasFile)
            {
                string folderPath = @"C:\path\to\your\images\";
                string fileName = "TeamMember_" + Guid.NewGuid() + Path.GetExtension(fileUploadControl.PostedFile.FileName);
                string fullFilePath = Path.Combine(folderPath, fileName);

                // Save the uploaded file to the server
                fileUploadControl.SaveAs(fullFilePath);

                // Return the relative path to save in the database (use a relative path or URL as needed)
                imagePath = "/images/" + fileName;
            }

            return imagePath;
        }

        // Method to save uploaded image for walk detail snap
        private string SaveUploadedImageForWalkDetail(FileUpload fileUploadControl)
        {
            string snapPath = string.Empty;

            if (fileUploadControl.HasFile)
            {
                try
                {
                    string fileName = Path.GetFileName(fileUploadControl.PostedFile.FileName);
                    string fileExtension = Path.GetExtension(fileName);
                    string uniqueFileName = DateTime.Now.Ticks.ToString() + fileExtension;

                    // Define the path to save the uploaded image
                    string imagePath = Server.MapPath("~/images/") + uniqueFileName;

                    // Save the image to the specified path
                    fileUploadControl.SaveAs(imagePath);

                    snapPath = "~/images/" + uniqueFileName;
                }
                catch (Exception ex)
                {
                    // Handle errors during file upload
                    Console.WriteLine("Error uploading file: " + ex.Message);
                }
            }

            return snapPath;
        }
    }

    // Define the data models for TeamMember and WalkDetail
    public class TeamMember
    {
        public string Name { get; set; }
        public string Image { get; set; }
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
}
