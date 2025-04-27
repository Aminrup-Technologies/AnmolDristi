
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.Web;



namespace AnmolDristi
{
    public partial class Award_Distribution : System.Web.UI.Page
    {
        private const string UploadCountKey = "UploadControlCount";
        private const string UploadedFilesKey = "UploadedFiles";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState[UploadCountKey] = 1; // Initialize number of file upload controls
                ViewState[UploadedFilesKey] = new List<string>(); // Initialize uploaded files list
                LoadAwardData(); // Load existing records if needed

                BindAwardCategoryDropdown();
            }

            CreateUploadControls(); // Create file upload controls
            BindUploadedImages(); // Bind uploaded image paths to display
        }
        private void BindAwardCategoryDropdown()
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT Award_ID, AwardDescription FROM AwardCategoryDescription";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    ddlAwardCategory.Items.Clear();
                    ddlAwardCategory.Items.Add(new ListItem("--Select Award Category--", "-1"));

                    while (reader.Read())
                    {
                        int awardId = reader.GetInt32(0);
                        string awardName = reader.GetString(1);

                        ddlAwardCategory.Items.Add(new ListItem(awardName, awardId.ToString()));
                    }
                }
            }
        }


        //    private void BindAwardCategoryDropdown()
        //    {
        //        List<ListItem> awardCategories = new List<ListItem>
        //{
        //    new ListItem("Top Performer Award", "Top Performer Award"),
        //    new ListItem("Perfect Attendance Awards", "Perfect Attendance Awards"),
        //    new ListItem("Safety Awards", "Safety Awards"),
        //    new ListItem("Volunteer Awards", "Volunteer Awards"),
        //    new ListItem("Team Recognition", "Team Recognition")
        //};

        //        ddlAwardCategory.Items.Clear();
        //        ddlAwardCategory.Items.Add(new ListItem("--Select Award Category--", "-1"));
        //        ddlAwardCategory.Items.AddRange(awardCategories.ToArray());
        //    }

        private void LoadAwardData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                    SELECT Award_ID, DateOfAwardDistribution, EventName, EmpId, EmpName, 
                           Designation, SubmittedDate, SubmittedTime, ADR_ID, ImagePath
                    FROM AwardDistributionDetails
                    ORDER BY Award_ID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        
                    }
                }
            }
        }

        protected void ValidateAwardDateTime(object source, ServerValidateEventArgs args)
        {
            DateTime selectedDate;

            // Validate the award distribution date
            if (!DateTime.TryParse(txtDateOfAwardDistribution.Text, out selectedDate))
            {
                args.IsValid = false; // Invalid date format
                return;
            }

            // Automatically get current time for validation
            DateTime awardDateTime = selectedDate.Date + DateTime.Now.TimeOfDay;

            // Validate that the award date/time is not in the future
            if (awardDateTime > DateTime.Now)
            {
                args.IsValid = false; // Validation failed if date/time is in the future
            }
            else
            {
                args.IsValid = true; // Validation passed
            }
        }


        private void CreateUploadControls()
        {
            int count = (int)ViewState[UploadCountKey];
            phImageUploadControls.Controls.Clear(); // Clear any existing controls

            for (int i = 0; i < count; i++)
            {
                FileUpload fu = new FileUpload
                {
                    ID = $"FU_ClrApp_{i}",
                    CssClass = "form-control form-control-sm rounded mb-2"
                };

                phImageUploadControls.Controls.Add(fu);
            }
        }

        private void BindUploadedImages()
        {
            var files = ViewState[UploadedFilesKey] as List<string>;

            rptUploadedImages.DataSource = files;
            rptUploadedImages.DataBind();
        }

        protected void BtnAddEmployee_Click(object sender, EventArgs e)
        {
           // SaveUploadedFiles();
            int count = (int)ViewState[UploadCountKey];
            count++;
            ViewState[UploadCountKey] = count; // Increment upload controls count
            CreateUploadControls(); // Re-create controls
            BindUploadedImages(); // Re-bind images
        }

        protected void BtnRemoveEmployee_Click(object sender, EventArgs e)
        {
            int count = (int)ViewState[UploadCountKey];
            if (count > 1)
            {
                count--;
                ViewState[UploadCountKey] = count; // Decrement upload controls count
            }
            CreateUploadControls(); // Re-create controls
            BindUploadedImages(); // Re-bind images
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                InsertAwardData(); // Save form data
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Award distribution details saved successfully!";

                LoadAwardData(); // Refresh GridView with new data (if needed)
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        private void InsertAwardData()
        {
            
            string awardCategory = ddlAwardCategory.SelectedValue;
            if (awardCategory == "-1")
            {
                throw new Exception("Please select a valid Award Category.");
            }



            DateTime dateOfAwardDistribution = DateTime.Parse(txtDateOfAwardDistribution.Text);
            string eventName = txtEventName.Text;
            string empId = txtEmployeeID.Text;
            string empName = txtEmployeeName.Text;
            string designation = txtDesignation.Text;
           

            // Automatically fetch current date and time for SubmittedDate and SubmittedTime
            DateTime submittedDate = DateTime.Now.Date; // Current Date
            TimeSpan submittedTime = DateTime.Now.TimeOfDay; // Current Time

            int adrId = GetADR_IDFromCurrentUser(); // Get ADR_ID from the text box (or use your logic to assign it)
            string imagePath = ""; // Initialize the image path as an empty string.

            //// If an image is uploaded, save it and set its path
            //if (FU_Image.HasFile)
            //{
            //    string fileName = FU_Image.FileName;
            //    string filePath = Server.MapPath("~/UploadedImages/") + fileName;
            //    FU_Image.SaveAs(filePath);
            //    imagePath = "~/UploadedImages/" + fileName;
            //}


            foreach (Control ctrl in phImageUploadControls.Controls)
            {
                if (ctrl is FileUpload)
                {
                    FileUpload fileUpload = (FileUpload)ctrl;

                    if (fileUpload.HasFile)
                    {
                        string folderPath = Server.MapPath("~/Uploads/");
                        Directory.CreateDirectory(folderPath); // Create folder if it doesn't exist

                        string fileName = Path.GetFileName(fileUpload.FileName);
                        string fullPath = Path.Combine(folderPath, fileName);

                        fileUpload.SaveAs(fullPath);

                        imagePath = "~/Uploads/" + fileName; 
                        break; 
                    }
                }
            }


            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))

           
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // Step 1: Insert into AwardDistributionDetails
                    using (SqlCommand cmd = new SqlCommand("InsertAwardDistributionDetails", conn, transaction))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@DateOfAwardDistribution", dateOfAwardDistribution);
                        cmd.Parameters.AddWithValue("@EventName", eventName);
                        cmd.Parameters.AddWithValue("@EmpId", empId);
                        cmd.Parameters.AddWithValue("@EmpName", empName);
                        cmd.Parameters.AddWithValue("@Designation", designation);

                        cmd.Parameters.AddWithValue("@Award_ID", Convert.ToInt32(ddlAwardCategory.SelectedValue));
                        cmd.Parameters.AddWithValue("@SubmittedDate", submittedDate);
                        cmd.Parameters.AddWithValue("@SubmittedTime", submittedTime);
                       cmd.Parameters.AddWithValue("@ADR_ID", adrId);
                        cmd.Parameters.AddWithValue("@ImagePath", imagePath);

                      
                        cmd.ExecuteNonQuery();
                        
                       

                    }

                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    throw new Exception("Transaction failed: " + ex.Message);
                }
            }
        }
        private int GetADR_IDFromCurrentUser()
        {
            
            return Convert.ToInt32(Session["ADR_ID"]);
        }
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            txtDateOfAwardDistribution.Text = "";
            txtEventName.Text = "";
            txtEmployeeID.Text = "";
            txtEmployeeName.Text = "";
            txtDesignation.Text = "";
            ddlAwardCategory.SelectedIndex = -1;
            ddlAwardCategory.SelectedIndex = 0; // Not -1



            lblMessage.Text = "Form reset successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Blue;

            
            ViewState[UploadedFilesKey] = new List<string>();  // Reset uploaded files list in ViewState
            phImageUploadControls.Controls.Clear();  // Remove uploaded file controls from the form
        }


        private void SaveUploadedFiles(SqlConnection conn, SqlTransaction transaction, int headerId)
        {
            try
            {
                var savedFiles = ViewState[UploadedFilesKey] as List<string>;
                if (savedFiles == null)
                    savedFiles = new List<string>();

                foreach (Control ctrl in phImageUploadControls.Controls)
                {
                    FileUpload fu = ctrl as FileUpload;
                    if (fu != null && fu.HasFile)
                    {
                        string filename = Path.GetFileName(fu.FileName);
                        string folderPath = Server.MapPath("~/UploadedImages/");

                        // Create the folder if it doesn't exist
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        string fullPath = Path.Combine(folderPath, filename);
                        fu.SaveAs(fullPath);

                        string relativePath = "~/UploadedImages/" + filename;
                        savedFiles.Add(relativePath); // Save relative path to ViewState
                    }
                }

                ViewState[UploadedFilesKey] = savedFiles; // Save the uploaded file paths in ViewState
            }
            catch (Exception ex)
            {
                // Handle error, log or display message
                throw new Exception("Error saving uploaded files: " + ex.Message);
            }
        }



    }
}












