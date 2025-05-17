
//using System;
//using System.Collections.Generic;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;
//using System.IO;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Linq;
//using System.Web;



//namespace AnmolDristi
//{
//    public partial class Award_Distribution : System.Web.UI.Page
//    {
//        private const string UploadCountKey = "UploadControlCount";
//        private const string UploadedFilesKey = "UploadedFiles";


//            private const string EmployeeDataKey = "EmployeeData";

//            protected void Page_Load(object sender, EventArgs e)
//            {
//                if (!IsPostBack)
//                {
//                    ViewState[UploadCountKey] = 1;
//                    ViewState[UploadedFilesKey] = new List<string>();
//                    ViewState[EmployeeDataKey] = CreateEmployeeDataTable();

//                    LoadAwardData();
//                    BindAwardCategoryDropdown();
//                }

//                CreateUploadControls();
//                BindUploadedImages();
//                BindEmployeeGrid();
//            }

//            private void LoadAwardData()
//            {
//                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
//                using (SqlConnection conn = new SqlConnection(connectionString))
//                {
//                    conn.Open();
//                    string query = @"
//                    SELECT Award_ID, DateOfAwardDistribution, EventName, EmpId, EmpName, 
//                           Designation, SubmittedDate, SubmittedTime, ADR_ID, ImagePath
//                    FROM AwardDistributionDetails
//                    ORDER BY Award_ID DESC";

//                    using (SqlCommand cmd = new SqlCommand(query, conn))
//                    {
//                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
//                        {
//                            DataTable dt = new DataTable();
//                            da.Fill(dt);
//                            // Bind elsewhere if needed
//                        }
//                    }
//                }
//            }

//        private void BindAwardCategoryDropdown()
//        {
//            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
//            using (SqlConnection conn = new SqlConnection(connStr))
//            {
//                conn.Open();
//                string query = "SELECT Award_ID, AwardDescription FROM AwardCategoryDescription";

//                using (SqlCommand cmd = new SqlCommand(query, conn))
//                {
//                    SqlDataAdapter da = new SqlDataAdapter(cmd);
//                    DataTable dt = new DataTable();
//                    da.Fill(dt);

//                    ddlAwardCategory.DataSource = dt;
//                    ddlAwardCategory.DataTextField = "AwardDescription";
//                    ddlAwardCategory.DataValueField = "Award_ID";
//                    ddlAwardCategory.DataBind();

//                    ddlAwardCategory.Items.Insert(0, new ListItem("--Select Award Category--", "-1"));
//                }
//            }
//        }


//        //private void BindAwardCategoryDropdown()
//        //{
//        //    string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
//        //    using (SqlConnection conn = new SqlConnection(connStr))
//        //    {
//        //        conn.Open();
//        //        string query = "SELECT Award_ID, AwardDescription FROM AwardCategoryDescription";

//        //        using (SqlCommand cmd = new SqlCommand(query, conn))
//        //        {
//        //            using (SqlDataReader reader = cmd.ExecuteReader())
//        //            {
//        //                ddlAwardCategory.Items.Clear();
//        //                ddlAwardCategory.Items.Add(new ListItem("--Select Award Category--", "-1"));

//        //                while (reader.Read())
//        //                {
//        //                    string awardName = reader["AwardDescription"].ToString();
//        //                    string awardId = reader["Award_ID"].ToString();

//        //                    ddlAwardCategory.Items.Add(new ListItem(awardName, awardId));
//        //                }
//        //            }
//        //        }
//        //    }
//        //}

//        private DataTable CreateEmployeeDataTable()
//            {
//                DataTable dt = new DataTable();
//                dt.Columns.Add("EmpId");
//                dt.Columns.Add("EmpName");
//                dt.Columns.Add("Designation");
//                dt.Columns.Add("AwardCategory");
//                dt.Columns.Add("ImagePath");
//                return dt;
//            }

//            private void BindEmployeeGrid()
//            {
//                if (ViewState[EmployeeDataKey] != null)
//                {
//                    gvEmployee.DataSource = (DataTable)ViewState[EmployeeDataKey];
//                    gvEmployee.DataBind();
//                }
//            }

//            private void CreateUploadControls()
//            {
//                int count = (int)ViewState[UploadCountKey];
//                phImageUploadControls.Controls.Clear();

//                for (int i = 0; i < count; i++)
//                {
//                    FileUpload fu = new FileUpload();
//                    fu.ID = "FU_ClrApp_" + i.ToString();
//                    fu.CssClass = "form-control form-control-sm rounded mb-2";
//                    phImageUploadControls.Controls.Add(fu);
//                }
//            }

//            private void BindUploadedImages()
//            {
//                List<string> files = ViewState[UploadedFilesKey] as List<string>;
//                rptUploadedImages.DataSource = files;
//                rptUploadedImages.DataBind();
//            }

//            protected void BtnAddEmployee_Click(object sender, EventArgs e)
//            {
//                if (!Page.IsValid) return;

//                string empId = txtEmployeeID.Text.Trim();
//                string empName = txtEmployeeName.Text.Trim();
//                string designation = txtDesignation.Text.Trim();
//                string awardCategory = ddlAwardCategory.SelectedItem.Text;
//                string imagePath = "";

//                foreach (Control ctrl in phImageUploadControls.Controls)
//                {
//                    FileUpload fileUpload = ctrl as FileUpload;
//                    if (fileUpload != null && fileUpload.HasFile)
//                    {
//                        string folderPath = Server.MapPath("~/Uploads/");
//                        if (!Directory.Exists(folderPath))
//                        {
//                            Directory.CreateDirectory(folderPath);
//                        }

//                        string fileName = Path.GetFileName(fileUpload.FileName);
//                        string fullPath = Path.Combine(folderPath, fileName);
//                        fileUpload.SaveAs(fullPath);

//                        imagePath = "~/Uploads/" + fileName;
//                        break;
//                    }
//                }

//                DataTable dt = ViewState[EmployeeDataKey] as DataTable;
//                if (dt == null)
//                {
//                    dt = CreateEmployeeDataTable();
//                }

//                DataRow dr = dt.NewRow();
//                dr["EmpId"] = empId;
//                dr["EmpName"] = empName;
//                dr["Designation"] = designation;
//                dr["AwardCategory"] = awardCategory;
//                dr["ImagePath"] = imagePath;
//                dt.Rows.Add(dr);

//                ViewState[EmployeeDataKey] = dt;

//                txtEmployeeID.Text = "";
//                txtEmployeeName.Text = "";
//                txtDesignation.Text = "";
//                ddlAwardCategory.SelectedIndex = 0;

//                ViewState[UploadCountKey] = 1;
//                phImageUploadControls.Controls.Clear();
//                CreateUploadControls();
//                BindUploadedImages();
//                BindEmployeeGrid();
//            }

//            protected void BtnRemoveEmployee_Click(object sender, EventArgs e)
//            {
//                ViewState[EmployeeDataKey] = CreateEmployeeDataTable();
//                gvEmployee.DataSource = null;
//                gvEmployee.DataBind();
//            }

//            protected void ValidateAwardDateTime(object source, ServerValidateEventArgs args)
//            {
//                DateTime selectedDate;
//                if (!DateTime.TryParse(txtDateOfAwardDistribution.Text, out selectedDate))
//                {
//                    args.IsValid = false;
//                    return;
//                }

//                DateTime awardDateTime = selectedDate.Date + DateTime.Now.TimeOfDay;

//                if (awardDateTime > DateTime.Now)
//                {
//                    args.IsValid = false;
//                }
//                else
//                {
//                    args.IsValid = true;
//                }
//            }



//            protected void BtnSubmit_Click(object sender, EventArgs e)
//            {
//            lblMessage.Text = $"DEBUG: SelectedValue = {ddlAwardCategory.SelectedValue}, Text = {ddlAwardCategory.SelectedItem.Text}";

//            try
//            {
//                    InsertAwardData();
//                    lblMessage.ForeColor = System.Drawing.Color.Green;
//                    lblMessage.Text = "Award distribution details saved successfully!";
//                    LoadAwardData();

//                    ViewState["EmployeeData"] = CreateEmployeeDataTable();
//                    BindEmployeeGrid();
//                }
//                catch (Exception ex)
//                {
//                    lblMessage.ForeColor = System.Drawing.Color.Red;
//                    lblMessage.Text = "Error: " + ex.Message;
//                }
//            }

//            //protected void BtnRemoveEmployee_Click(object sender, EventArgs e)
//            //{
//            //    int count = (int)ViewState[UploadCountKey];
//            //    if (count > 1)
//            //    {
//            //        count--;
//            //        ViewState[UploadCountKey] = count; // Decrement upload controls count
//            //    }
//            //    CreateUploadControls(); // Re-create controls
//            //    BindUploadedImages(); // Re-bind images
//            //}

//            //protected void BtnSubmit_Click(object sender, EventArgs e)
//            //{
//            //    try
//            //    {
//            //        InsertAwardData();
//            //        lblMessage.ForeColor = System.Drawing.Color.Green;
//            //        lblMessage.Text = "Award distribution details saved successfully!";
//            //        LoadAwardData();

//            //        ViewState[EmployeeDataKey] = CreateEmployeeDataTable(); // Clear temp data
//            //        BindEmployeeGrid();
//            //    }
//            //    catch (Exception ex)
//            //    {
//            //        lblMessage.ForeColor = System.Drawing.Color.Red;
//            //        lblMessage.Text = "Error: " + ex.Message;
//            //    }
//            //}


//            private void InsertAwardData()
//            {
//            if (ddlAwardCategory.SelectedValue == "-1")
//            {
//                lblMessage.Text = "Please select an Award Category.";
//                lblMessage.ForeColor = System.Drawing.Color.Red;
//                return;
//            }

//            //if (ddlAwardCategory.SelectedIndex == 0 || ddlAwardCategory.SelectedValue == "-1")
//            //{
//            //    throw new Exception("Please select a valid Award Category.");
//            //}

//            DateTime dateOfAwardDistribution = DateTime.Parse(txtDateOfAwardDistribution.Text);
//                string eventName = txtEventName.Text.Trim();
//                DateTime submittedDate = DateTime.Now.Date;
//                TimeSpan submittedTime = DateTime.Now.TimeOfDay;
//                int adrId = GetADR_IDFromCurrentUser();

//                DataTable employeeTable = (DataTable)ViewState["EmployeeData"];
//                if (employeeTable == null || employeeTable.Rows.Count == 0)
//                {
//                    throw new Exception("Please add at least one employee entry.");
//                }

//                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
//                SqlConnection conn = new SqlConnection(connectionString);
//                conn.Open();
//                SqlTransaction transaction = conn.BeginTransaction();

//                try
//                {
//                    foreach (DataRow row in employeeTable.Rows)
//                    {
//                        SqlCommand cmd = new SqlCommand("InsertAwardDistributionDetails", conn, transaction);
//                        cmd.CommandType = CommandType.StoredProcedure;

//                        cmd.Parameters.AddWithValue("@DateOfAwardDistribution", dateOfAwardDistribution);
//                        cmd.Parameters.AddWithValue("@EventName", eventName);
//                        cmd.Parameters.AddWithValue("@EmpId", row["EmpId"].ToString());
//                        cmd.Parameters.AddWithValue("@EmpName", row["EmpName"].ToString());
//                        cmd.Parameters.AddWithValue("@Designation", row["Designation"].ToString());
//                        cmd.Parameters.AddWithValue("@Award_ID", Convert.ToInt32(ddlAwardCategory.SelectedValue));
//                        cmd.Parameters.AddWithValue("@SubmittedDate", submittedDate);
//                        cmd.Parameters.AddWithValue("@SubmittedTime", submittedTime);
//                        cmd.Parameters.AddWithValue("@ADR_ID", adrId);
//                        cmd.Parameters.AddWithValue("@ImagePath", row["ImagePath"].ToString());

//                        cmd.ExecuteNonQuery();
//                    }

//                    transaction.Commit();
//                }
//                catch (Exception ex)
//                {
//                    transaction.Rollback();
//                    throw new Exception("Transaction failed: " + ex.Message);
//                }
//                finally
//                {
//                    conn.Close();
//                }
//            }


//            private int GetADR_IDFromCurrentUser()
//            {

//                return Convert.ToInt32(Session["ADR_ID"]);
//            }


//            protected void BtnReset_Click(object sender, EventArgs e)
//            {
//                txtDateOfAwardDistribution.Text = "";
//                txtEventName.Text = "";
//                txtEmployeeID.Text = "";
//                txtEmployeeName.Text = "";
//                txtDesignation.Text = "";
//                ddlAwardCategory.SelectedIndex = 0;

//                lblMessage.Text = "Form reset successfully!";
//                lblMessage.ForeColor = System.Drawing.Color.Blue;

//                ViewState["UploadedFiles"] = new List<string>();
//                phImageUploadControls.Controls.Clear();

//                ViewState["UploadCount"] = 1;
//                ViewState["EmployeeData"] = CreateEmployeeDataTable();

//                BindEmployeeGrid();
//                CreateUploadControls();
//            }


//            private void SaveUploadedFiles(SqlConnection conn, SqlTransaction transaction, int headerId)
//            {
//                try
//                {
//                    var savedFiles = ViewState[UploadedFilesKey] as List<string>;
//                    if (savedFiles == null)
//                        savedFiles = new List<string>();

//                    foreach (Control ctrl in phImageUploadControls.Controls)
//                    {
//                        FileUpload fu = ctrl as FileUpload;
//                        if (fu != null && fu.HasFile)
//                        {
//                            string filename = Path.GetFileName(fu.FileName);
//                            string folderPath = Server.MapPath("~/UploadedImages/");

//                            // Create the folder if it doesn't exist
//                            if (!Directory.Exists(folderPath))
//                            {
//                                Directory.CreateDirectory(folderPath);
//                            }

//                            string fullPath = Path.Combine(folderPath, filename);
//                            fu.SaveAs(fullPath);

//                            string relativePath = "~/UploadedImages/" + filename;
//                            savedFiles.Add(relativePath); // Save relative path to ViewState
//                        }
//                    }

//                    ViewState[UploadedFilesKey] = savedFiles; // Save the uploaded file paths in ViewState
//                }
//                catch (Exception ex)
//                {
//                    // Handle error, log or display message
//                    throw new Exception("Error saving uploaded files: " + ex.Message);
//                }
//            }



//        }
//    }



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












