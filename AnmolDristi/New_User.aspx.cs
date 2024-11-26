using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class New_User : System.Web.UI.Page
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
                    lbl_docname.Text = "Create New User";
                    CompanyBinder();

                }

            }
        }

        private void CompanyBinder()
        {
            string query = "SELECT Company_ID, Company_Description FROM MST_Company";
            string textField = "Company_Description";
            string valueField = "Company_ID";

            bool recordsBound;

            // Bind the DropDownList and get the flag indicating whether records were bound
            DatabaseHelper.BindDropDownList(query, DDL_Company, textField, valueField, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Company);
                string CompanyBinder_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'An error occurred!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowCompanyBinderErrorNotification", CompanyBinder_Error_script, false);

            }
        }
        protected void DDL_Company_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Company.SelectedIndex != 0)
            {
                string selectedCompanyValue = DDL_Company.SelectedValue.ToString();
                RegionBinder(selectedCompanyValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Region);

                string DDL_Company_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowCompanyInvalidErrorNotification", DDL_Company_Error_script, false);
            }
        }

        private void RegionBinder(string selectedCompanyValue)
        {
            string query = "SELECT Region_ID, Region_Description FROM MST_Region WHERE Company_ID = @SelectedCompanyValue";
            string textField = "Region_Description";
            string valueField = "Region_ID";

            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Region, textField, valueField, new SqlParameter("@SelectedCompanyValue", selectedCompanyValue), out recordsBound);

            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Region);

                string RegionBinder_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'An error occurred!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowRegionBinderErrorNotification", RegionBinder_Error_script, false);
            }
        }
        protected void DDL_Region_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Region.SelectedIndex != 0)
            {
                string selectedCompanyValue = DDL_Plant.SelectedValue.ToString();
                string selectedRegionValue = DDL_Region.SelectedValue.ToString();
                BranchBinder(selectedCompanyValue, selectedRegionValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Branch);

                string DDL_Region_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowRegionInvalidErrorNotification", DDL_Region_Error_script, false);
            }
        }

        private void BranchBinder(string selectedCompanyValue, string selectedRegionValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT Branch_ID, Branch_Description FROM MST_Branch WHERE Company_ID = @CompanyID AND Region_ID = @RegionID";
            string textField = "Branch_Description"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "Branch_ID"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@CompanyID", selectedCompanyValue),
                new SqlParameter("@RegionID", selectedRegionValue)
            };

            // Call the BindDropDownList method with parameters
            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Branch, textField, valueField, parameters, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                string PN_Error_script = @"<script type='text/javascript'>
                    new PNotify({
                        title: 'Error',
                        text: 'No line categories found for the selected plant and line!',
                        type: 'error',
                        styling: 'bootstrap3'
                    });
                </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowLineProductsBinderErrorNotification", PN_Error_script, false);
            }
        }
        protected void DDL_Branch_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Branch.SelectedIndex != 0)
            {
                string selectedCompanyValue = DDL_Company.SelectedValue.ToString();
                string selectedRegionValue = DDL_Region.SelectedValue.ToString();
                string selectedBranchValue = DDL_Branch.SelectedValue.ToString();
                PlantBinder(selectedCompanyValue, selectedRegionValue, selectedBranchValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Plant);

                string DDL_Branch_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowBranchInvalidErrorNotification", DDL_Branch_Error_script, false);
            }
        }

        private void PlantBinder(string selectedCompanyValue, string selectedRegionValue, string selectedBranchValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT PlantID_ID, PlantID_Description FROM MST_Plant WHERE Company_ID = @CompanyID AND Region_ID = @RegionID and Branch_ID = @BranchID";
            string textField = "PlantID_Description"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "PlantID_ID"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@CompanyID", selectedCompanyValue),
                new SqlParameter("@RegionID", selectedRegionValue),
                new SqlParameter("@BranchID", selectedBranchValue)
            };

            // Call the BindDropDownList method with parameters
            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Plant, textField, valueField, parameters, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                string PlantBinder_Error_script = @"<script type='text/javascript'>
                    new PNotify({
                        title: 'Error',
                        text: 'No Brands found for the selected plant and line!',
                        type: 'error',
                        styling: 'bootstrap3'
                    });
                </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantBinderBinderErrorNotification", PlantBinder_Error_script, false);
            }
        }

        protected void DDL_Plant_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Plant.SelectedIndex != 0)
            {
                string selectedCompanyValue = DDL_Company.SelectedValue.ToString();
                string selectedRegionValue = DDL_Region.SelectedValue.ToString();
                string selectedBranchValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                DivisionBinder(selectedCompanyValue, selectedRegionValue, selectedBranchValue, selectedPlantValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Division);

                string DDL_Plant_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantInvalidErrorNotification", DDL_Plant_Error_script, false);
            }
        }

        private void DivisionBinder(string selectedCompanyValue, string selectedRegionValue, string selectedBranchValue, string selectedPlantValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT Division_ID, Division_Description FROM MST_Division WHERE Company_ID = @CompanyID AND Region_ID = @RegionID and Branch_ID = @BranchID and PlantID_ID = @PlantIDID ";
            string textField = "Division_Description"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "Division_ID"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@CompanyID", selectedCompanyValue),
                new SqlParameter("@RegionID", selectedRegionValue),
                new SqlParameter("@BranchID", selectedBranchValue),
                new SqlParameter("@PlantIDID", selectedPlantValue)
            };

            // Call the BindDropDownList method with parameters
            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Division, textField, valueField, parameters, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                string DDL_Division_Error_script = @"<script type='text/javascript'>
                    new PNotify({
                        title: 'Error',
                        text: 'No Brands found for the selected plant and line!',
                        type: 'error',
                        styling: 'bootstrap3'
                    });
                </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowDivisionBinderBinderErrorNotification", DDL_Division_Error_script, false);
            }
        }
        protected void DDL_Division_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Division.SelectedIndex != 0)
            {
                string selectedCompanyValue = DDL_Company.SelectedValue.ToString();
                string selectedRegionValue = DDL_Region.SelectedValue.ToString();
                string selectedBranchValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedDivisionValue = DDL_Division.SelectedValue.ToString();
                DepartmentBinder(selectedCompanyValue, selectedRegionValue, selectedBranchValue, selectedPlantValue, selectedDivisionValue );
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Division);

                string DDL_Division_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowDivisionInvalidErrorNotification", DDL_Division_Error_script, false);
            }
        }

        private void DepartmentBinder(string selectedCompanyValue, string selectedRegionValue, string selectedBranchValue, string selectedPlantValue, string selectedDivisionValue )
        {
            // Construct the SQL query with parameters
            string query = "SELECT Department_ID, Department_Description FROM MST_Department WHERE Company_ID = @CompanyID AND Region_ID = @RegionID and Branch_ID = @BranchID and " +
                            "PlantID_ID = @PlantIDID and Division_ID = @DivisionID";
            string textField = "Department_Description"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "Department_ID"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@CompanyID", selectedCompanyValue),
                new SqlParameter("@RegionID", selectedRegionValue),
                new SqlParameter("@BranchID", selectedBranchValue),
                new SqlParameter("@PlantIDID", selectedPlantValue),
                new SqlParameter("@DivisionID", selectedDivisionValue)
            };

            // Call the BindDropDownList method with parameters
            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Department, textField, valueField, parameters, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                string DDL_Department_Error_script = @"<script type='text/javascript'>
                    new PNotify({
                        title: 'Error',
                        text: 'No Brands found for the selected plant and line!',
                        type: 'error',
                        styling: 'bootstrap3'
                    });
                </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowDepartmentBinderBinderErrorNotification", DDL_Department_Error_script, false);
            }
        }

        protected void DDL_Department_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Department.SelectedIndex != 0)
            {
                string selectedCompanyValue = DDL_Company.SelectedValue.ToString();
                string selectedRegionValue = DDL_Region.SelectedValue.ToString();
                string selectedBranchValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedDivisionValue = DDL_Division.SelectedValue.ToString();
                string selectedDepartmentValue = DDL_Department.SelectedValue.ToString();
                SubDepartmentBinder(selectedCompanyValue, selectedRegionValue, selectedBranchValue, selectedPlantValue, selectedDivisionValue, selectedDepartmentValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Division);

                string DDL_Department_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowDepartmentInvalidErrorNotification", DDL_Department_Error_script, false);
            }
        }

        private void SubDepartmentBinder(string selectedCompanyValue, string selectedRegionValue, string selectedBranchValue, string selectedPlantValue, string selectedDivisionValue, string selectedDepartmentValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT SubDepartment_ID, SubDepartment_Description FROM MST_SubDepartment WHERE Company_ID = @CompanyID AND Region_ID = @RegionID and Branch_ID = @BranchID and " +
                            "PlantID_ID = @PlantIDID and Division_ID = @DivisionID and Department_ID = @DepartmentID";
            string textField = "SubDepartment_Description"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "SubDepartment_ID"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@CompanyID", selectedCompanyValue),
                new SqlParameter("@RegionID", selectedRegionValue),
                new SqlParameter("@BranchID", selectedBranchValue),
                new SqlParameter("@PlantIDID", selectedPlantValue),
                new SqlParameter("@DivisionID", selectedDivisionValue),
                new SqlParameter("@DepartmentID", selectedDepartmentValue)
            };

            // Call the BindDropDownList method with parameters
            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_SubDepartment, textField, valueField, parameters, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                string SubDepartment_Error_script = @"<script type='text/javascript'>
                    new PNotify({
                        title: 'Error',
                        text: 'No Brands found for the selected plant and line!',
                        type: 'error',
                        styling: 'bootstrap3'
                    });
                </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowSubDepartmentBinderErrorNotification", SubDepartment_Error_script, false);
            }
        }

        protected void DDL_SubDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_SubDepartment.SelectedIndex != 0)
            {
                string selectedCompanyValue = DDL_Company.SelectedValue.ToString();
                string selectedRegionValue = DDL_Region.SelectedValue.ToString();
                string selectedBranchValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedDivisionValue = DDL_Division.SelectedValue.ToString();
                string selectedDepartmentValue = DDL_Department.SelectedValue.ToString();
                string selectedSubDepartmentValue = DDL_SubDepartment.SelectedValue.ToString();
                CategoryBinder(selectedCompanyValue, selectedRegionValue, selectedBranchValue, selectedPlantValue, selectedDivisionValue, selectedDepartmentValue, selectedSubDepartmentValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Division);

                string DDL_SubDepartment_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowSubDepartmentInvalidErrorNotification", DDL_SubDepartment_Error_script, false);
            }
        }

        private void CategoryBinder(string selectedCompanyValue, string selectedRegionValue, string selectedBranchValue, string selectedPlantValue, string selectedDivisionValue, string selectedDepartmentValue, string selectedSubDepartmentValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT Category_ID, Category_Description FROM MST_Category WHERE Company_ID = @CompanyID AND Region_ID = @RegionID and Branch_ID = @BranchID and " +
                            "PlantID_ID = @PlantIDID and Division_ID = @DivisionID and Department_ID = @DepartmentID and SubDepartment_ID = @SubDepartmentID";
            string textField = "Category_Description"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "Category_ID"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@CompanyID", selectedCompanyValue),
                new SqlParameter("@RegionID", selectedRegionValue),
                new SqlParameter("@BranchID", selectedBranchValue),
                new SqlParameter("@PlantIDID", selectedPlantValue),
                new SqlParameter("@DivisionID", selectedDivisionValue),
                new SqlParameter("@DepartmentID", selectedDepartmentValue),
                new SqlParameter("@SubDepartmentID", selectedSubDepartmentValue)
            };

            // Call the BindDropDownList method with parameters
            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Category, textField, valueField, parameters, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                string Category_Error_script = @"<script type='text/javascript'>
                    new PNotify({
                        title: 'Error',
                        text: 'No Brands found for the selected plant and line!',
                        type: 'error',
                        styling: 'bootstrap3'
                    });
                </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowCategoryBinderErrorNotification", Category_Error_script, false);
            }
        }

        protected void DDL_Category_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Category.SelectedIndex != 0)
            {
                string selectedCompanyValue = DDL_Company.SelectedValue.ToString();
                string selectedRegionValue = DDL_Region.SelectedValue.ToString();
                string selectedBranchValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedDivisionValue = DDL_Division.SelectedValue.ToString();
                string selectedDepartmentValue = DDL_Department.SelectedValue.ToString();
                string selectedSubDepartmentValue = DDL_SubDepartment.SelectedValue.ToString();
                string selectedCategoryValue = DDL_Category.SelectedValue.ToString();
                GradeBinder(selectedCompanyValue, selectedRegionValue, selectedBranchValue, selectedPlantValue, selectedDivisionValue, selectedDepartmentValue, selectedSubDepartmentValue, selectedCategoryValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Grade);

                string DDL_Category_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowSubDepartmentInvalidErrorNotification", DDL_Category_Error_script, false);
            }
        }

        private void GradeBinder(string selectedCompanyValue, string selectedRegionValue, string selectedBranchValue, string selectedPlantValue, string selectedDivisionValue, string selectedDepartmentValue, string selectedSubDepartmentValue, string selectedCategoryValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT Grade_ID, Grade_Description FROM MST_Category WHERE Company_ID = @CompanyID AND Region_ID = @RegionID and Branch_ID = @BranchID and " +
                            "PlantID_ID = @PlantIDID and Division_ID = @DivisionID and Department_ID = @DepartmentID and SubDepartment_ID = @SubDepartmentID and Category_ID = @CategoryID ";
            string textField = "Grade_Description"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "Grade_ID"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@CompanyID", selectedCompanyValue),
                new SqlParameter("@RegionID", selectedRegionValue),
                new SqlParameter("@BranchID", selectedBranchValue),
                new SqlParameter("@PlantIDID", selectedPlantValue),
                new SqlParameter("@DivisionID", selectedDivisionValue),
                new SqlParameter("@DepartmentID", selectedDepartmentValue),
                new SqlParameter("@SubDepartmentID", selectedSubDepartmentValue),
                new SqlParameter("@CategoryID", selectedCategoryValue)
            };

            // Call the BindDropDownList method with parameters
            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Grade, textField, valueField, parameters, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                string Grade_Error_script = @"<script type='text/javascript'>
                    new PNotify({
                        title: 'Error',
                        text: 'No Brands found for the selected plant and line!',
                        type: 'error',
                        styling: 'bootstrap3'
                    });
                </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowGradeBinderErrorNotification", Grade_Error_script, false);
            }
        }

        protected void DDL_Grade_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Grade.SelectedIndex != 0)
            {
                string selectedCompanyValue = DDL_Company.SelectedValue.ToString();
                string selectedRegionValue = DDL_Region.SelectedValue.ToString();
                string selectedBranchValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedDivisionValue = DDL_Division.SelectedValue.ToString();
                string selectedDepartmentValue = DDL_Department.SelectedValue.ToString();
                string selectedSubDepartmentValue = DDL_SubDepartment.SelectedValue.ToString();
                string selectedCategoryValue = DDL_Category.SelectedValue.ToString();
            }
            else
            {
                string DDL_Grade_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowGradeInvalidErrorNotification", DDL_Grade_Error_script, false);
            }
        }


        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string employeeCode = TB_EmpCode.Text;
            string employeeName = TB_EmpName.Text;
            
            string company = DDL_Company.SelectedValue;
            string region = DDL_Region.SelectedValue;
            string branch = DDL_Branch.SelectedValue;
            string plant = DDL_Plant.SelectedValue;
            string division = DDL_Division.SelectedValue;
            string department = DDL_Department.SelectedValue;
            string subDepartment = DDL_SubDepartment.SelectedValue;
            string category = DDL_Category.SelectedValue;
            string grade = DDL_Grade.SelectedValue;

            DateTime doj = DateTime.Parse(TB_DOJ.Text).Date;
            string email = string.IsNullOrEmpty(TB_Email.Text) ? null : TB_Email.Text;
            string mobile = string.IsNullOrEmpty(TB_Mobile.Text) ? null : TB_Mobile.Text;
            int gender = Convert.ToInt32(RBL_Gender.SelectedValue);

            string employeeStatus = "Active";
            DateTime createdDate = DateTime.Now.Date;
            int createdBy = Convert.ToInt32(Session["WORKMAN"].ToString());
            string creationMode = "Single";
            string password = "pass@123";
            DateTime? lastLogin = null;
            DateTime? lastlogout = null;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "INSERT INTO MST_UserMaster (EmployeeCode ,EmployeeName, BranchId, PlantId, EmployeeStatus, CompanyId, DepartmentId, GradeId, SubDepartmentId, " +
                                    "DOJ, CategoryId, Email, Mobile, Gender, RegionId, DivisionId, CreatedDate, CreatedBy, CreationMode, Password, LastLoginDate, LastLogoutDate) " +

                                    "VALUES (@EmployeeCode ,@EmployeeName, @BranchId, @PlantId, @EmployeeStatus, @CompanyId, @DepartmentId, @GradeId, @SubDepartmentId, @DOJ, " +
                            "@CategoryId, @Email, @Mobile, @Gender, @RegionId, @DivisionId, @CreatedDate, @CreatedBy, @CreationMode, @Password, @LastLoginDate, @LastLogoutDate)";

                    using (SqlCommand command = new SqlCommand("query", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Add parameters
                        command.Parameters.AddWithValue("@EmployeeCode", employeeCode );
                        command.Parameters.AddWithValue("@EmployeeName", employeeName );
                        command.Parameters.AddWithValue("@BranchId", branch );
                        command.Parameters.AddWithValue("@PlantId", plant );
                        command.Parameters.AddWithValue("@EmployeeStatus", employeeStatus);
                        command.Parameters.AddWithValue("@CompanyId", company );
                        command.Parameters.AddWithValue("@DepartmentId", department);
                        command.Parameters.AddWithValue("@GradeId", grade);
                        command.Parameters.AddWithValue("@SubDepartmentId", subDepartment);
                        command.Parameters.AddWithValue("@DOJ", doj);
                        command.Parameters.AddWithValue("@CategoryId", category);
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@Mobile", mobile);
                        command.Parameters.AddWithValue("@Gender", gender);
                        command.Parameters.AddWithValue("@RegionId", region);
                        command.Parameters.AddWithValue("@DivisionId", division);
                        command.Parameters.AddWithValue("@CreatedDate", createdDate);
                        command.Parameters.AddWithValue("@CreatedBy", createdBy);
                        command.Parameters.AddWithValue("@CreationMode", creationMode);
                        command.Parameters.AddWithValue("@Password", password);
                        command.Parameters.AddWithValue("@LastLoginDate", lastLogin);
                        command.Parameters.AddWithValue("@LastLogoutDate", lastlogout);

                        // Execute the query
                        command.ExecuteNonQuery();
                        MakeInputsReadOnly();
                    }
                    connection.Close();
                }
            }
            catch (Exception ex)
            {
                string errorMessage = ex.Message.Replace("'", "\\'"); // Escape single quotes in the error message
                string errorScript = "<script type='text/javascript'>\n" +
                                     $"new PNotify({{\n" +
                                     "    title: 'Error',\n" +
                                     $"    text: '{errorMessage}',\n" +
                                     "    type: 'error',\n" +
                                     "    styling: 'bootstrap3'\n" +
                                     "});\n" +
                                     "</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowErrorNotification", errorScript, false);
            }
        }

        private void MakeInputsReadOnly()
        {
            DDL_Company.Enabled = false;
            DDL_Region.Enabled = false;
            DDL_Branch.Enabled = false;
            DDL_Plant.Enabled = false;
            DDL_Division.Enabled = false;
            DDL_Department.Enabled = false;
            DDL_SubDepartment.Enabled = false;
            DDL_Category.Enabled = false;   
            DDL_Grade.Enabled = false;

            TB_EmpCode.ReadOnly = true;
            TB_EmpName.ReadOnly = true;
            TB_DOJ.ReadOnly = true;
            TB_Email.ReadOnly = true;
            TB_Mobile.ReadOnly = true;
            RBL_Gender.Enabled = false;

            BtnSubmit.Enabled = false;
            BtnSubmit.Text = "SAVED";
            BtnSubmit.CssClass = "btn btn-sm btn-success";

            string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Data Success',
                                text: 'Recorded Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

            // RegisterStartupScript adds the JavaScript code to the page
            ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("New_User.aspx");
        }
    }
}