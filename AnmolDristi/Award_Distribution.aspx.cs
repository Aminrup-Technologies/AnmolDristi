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
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                BindAwardCategoryDropdown();
                InitializeAwardeeTable();
            }

           
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

       

        private void InitializeAwardeeTable()
        {
            if (ViewState["AwardeeTable"] == null)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("EmployeeID");
                dt.Columns.Add("EmployeeName");
                dt.Columns.Add("Designation");
                dt.Columns.Add("AwardCategory");
                dt.Columns.Add("AwardCategoryID");
                dt.Columns.Add("PhotoName");
                ViewState["AwardeeTable"] = dt;
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            // Get Awardee DataTable from ViewState
            DataTable dtAwardees = ViewState["AwardeeTable"] as DataTable;
            
            if (dtAwardees == null || dtAwardees.Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please add at least one awardee before saving.');", true);
                return; 
            }



            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlTransaction tran = conn.BeginTransaction();

                try
                {
                    
                    string insertHeaderQuery = @"
                INSERT INTO AwardDistributionHeader 
                (DateOfAwardDistribution, EventName, SubmittedDate, SubmittedTime)
                VALUES (@Date, @EventName, GETDATE(), CONVERT(TIME, GETDATE()));
                SELECT SCOPE_IDENTITY();";

                    int awardId;
                    using (SqlCommand cmd = new SqlCommand(insertHeaderQuery, conn, tran))
                    {
                        cmd.Parameters.AddWithValue("@Date", txtDateOfAwardDistribution.Text);
                        cmd.Parameters.AddWithValue("@EventName", txtEventName.Text);
                        awardId = Convert.ToInt32(cmd.ExecuteScalar());
                    }

                 
                    DataTable dt = (DataTable)ViewState["AwardeeTable"];
                    foreach (DataRow row in dt.Rows)
                    {
                        string photoName = row["PhotoName"].ToString();

                        string insertDetailQuery = @"
                    INSERT INTO AwardDistributionDetails
                    (Award_ID, EmpId, EmpName, Designation, ImagePath, SubmittedDate, SubmittedTime, AwardCategory)
                    VALUES (@Award_ID, @EmpId, @EmpName, @Designation, @ImagePath, GETDATE(), CONVERT(TIME, GETDATE(), @AwardCategory));";

                        using (SqlCommand cmd = new SqlCommand(insertDetailQuery, conn, tran))
                        {
                            cmd.Parameters.AddWithValue("@Award_ID", awardId);
                            cmd.Parameters.AddWithValue("@EmpId", row["EmployeeID"]);
                            cmd.Parameters.AddWithValue("@EmpName", row["EmployeeName"]);
                            cmd.Parameters.AddWithValue("@Designation", row["Designation"]);
                            cmd.Parameters.AddWithValue("@ImagePath", photoName);
                            cmd.Parameters.AddWithValue("@AwardCategory", row["AwardCategory"]);
                            cmd.ExecuteNonQuery();
                        }
                    }

                 
                    tran.Commit();

                   
                    ViewState["AwardeeTable"] = null;
                    GvEmployees.DataSource = null;
                    GvEmployees.DataBind();
                    txtDateOfAwardDistribution.Text = "";
                    txtEventName.Text = "";

                    //  success
                    ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-success", @"
                        new PNotify({
                            title: 'Successful',
                            text: 'Form submitted successfully.',
                            type: 'success',
                            styling: 'bootstrap3',
                            delay: 2500
                        });
                    ", true);
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    
                    ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-error", $@"
                        new PNotify({{
                            title: 'Failed',
                            text: 'Error: {ex.Message}',
                            type: 'error',
                            styling: 'bootstrap3',
                            delay: 3000
                        }});
                    ", true);
                }
            }
        }

        protected void BtnAddEmployee_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["AwardeeTable"];

            string employeeID = txtEmployeeID.Text.Trim();
            string employeeName = txtEmployeeName.Text.Trim();
            string designation = txtDesignation.Text.Trim();
            string awardCategory = ddlAwardCategory.SelectedItem.Text;
            string awardCategoryID = ddlAwardCategory.SelectedValue;



            // Build a list of missing fields
            List<string> missingFields = new List<string>();

            if (string.IsNullOrEmpty(employeeID))
                missingFields.Add("Employee ID");
            if (string.IsNullOrEmpty(employeeName))
                missingFields.Add("Employee Name");
            if (string.IsNullOrEmpty(designation))
                missingFields.Add("Designation");
            if (awardCategoryID == "-1")
                missingFields.Add("Award Category");
            if (!fuPhoto.HasFile)
                missingFields.Add("Photo");

            // If any field is missing, show alert
            if (missingFields.Count > 0)
            {
                string fields = string.Join(", ", missingFields);
                string script = $"alert('Please fill/select the following required fields: {fields}');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMissingFields", script, true);
                return; // Stop processing
            }

            string photoName = "";

            // ✅ Save temporarily to ~/Uploads/ and store full relative path
            if (fuPhoto.HasFile)
            {
                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string fileName = Path.GetFileName(fuPhoto.FileName);
                fuPhoto.SaveAs(Path.Combine(folderPath, fileName));

                // ✅ Save relative path for DB
                photoName = "~/Uploads/" + fileName;
            }

            dt.Rows.Add(employeeID, employeeName, designation, awardCategory, awardCategoryID, photoName);
            ViewState["AwardeeTable"] = dt;
            BindGrid();

            // Clear inputs
            txtEmployeeID.Text = "";
            txtEmployeeName.Text = "";
            txtDesignation.Text = "";
            ddlAwardCategory.SelectedIndex = 0;
        }

        private void BindGrid()
        {
            GvEmployees.DataSource = (DataTable)ViewState["AwardeeTable"];
            GvEmployees.DataBind();
        }
    }
}














