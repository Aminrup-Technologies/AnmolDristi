using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;              
using System.Data.SqlClient;    
using System.Configuration;     
using System.Text;
using System.IO;


namespace AnmolDristi
{
    public partial class vm_ccp_checklist : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
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
                    lbl_docnumber.Text = "ANMOL/DOC/DAN/QA/05 ";
                    PlantBinder();
                    loadAlldata();
                }
            }
        }
        private void PlantBinder()
        {
            string query = "SELECT plant_id, CONCAT(plant_name, '[', sap_code, ']') AS plant_name FROM MST_PlantDetails";
            string textField = "plant_name";
            string valueField = "plant_id";

            bool recordsBound;

            // Bind the DropDownList and get the flag indicating whether records were bound
            DatabaseHelper.BindDropDownList(query, DDL_Plant, textField, valueField, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Plant);
                string PlantBinder_Error_script = @"<script type='text/javascript'>
                      new PNotify({
                          title: 'Error',
                          text: 'An error occurred!',
                          type: 'error',
                          styling: 'bootstrap3'
                      });
                  </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantBinderErrorNotification", PlantBinder_Error_script, false);

            }
            BindGridView();

        }

        public class ValidationCriteria
        {
            public string RequiredFieldErrorMessage { get; set; }
            public string RegularExpressionErrorMessage { get; set; }
            public string RegularExpression { get; set; }
            public string RangeErrorMessage { get; set; }
            public string MinimumValue { get; set; }
            public string MaximumValue { get; set; }
            public bool IsRequired { get; set; }
            public bool IsRegularExpressionRequired { get; set; }
            public bool IsRangeRequired { get; set; }
        }
        private ValidationCriteria GetValidationCriteriaFromDatabase(string fieldName)
        {
            // Query the database to fetch validation criteria based on the field name
            // Implement database querying logic here, and return the fetched data
            // For example:
            // SELECT * FROM ValidationCriteria WHERE FieldName = fieldName

            // Simulated data for demonstration
            ValidationCriteria criteria = new ValidationCriteria();
            criteria.RequiredFieldErrorMessage = "*";
            criteria.RegularExpressionErrorMessage = "[30-40]";
            criteria.RegularExpression = @"\d+";
            criteria.RangeErrorMessage = "[30-40]";
            criteria.MinimumValue = "30";
            criteria.MaximumValue = "40";
            criteria.IsRequired = true;
            criteria.IsRegularExpressionRequired = true;
            criteria.IsRangeRequired = false;

            return criteria;
        }

        protected void DDL_Plant_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Plant.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                PlantLinesBinder(selectedPlantValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_PlantLine);

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
            BindGridView();

        }
        private void PlantLinesBinder(string selectedPlantValue)
        {
            string query = "SELECT line_id, line_name FROM MST_Plant_Lines WHERE plant_id = @SelectedPlantValue";
            string textField = "line_name";
            string valueField = "line_id";

            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_PlantLine, textField, valueField, new SqlParameter("@SelectedPlantValue", selectedPlantValue), out recordsBound);

            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_PlantLine);

                string PlantLinesBinder_Error_script = @"<script type='text/javascript'>
                      new PNotify({
                          title: 'Error',
                          text: 'An error occurred!',
                          type: 'error',
                          styling: 'bootstrap3'
                      });
                  </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantLinesBinderErrorNotification", PlantLinesBinder_Error_script, false);
            }
            BindGridView();

        }
        protected void DDL_PlantLine_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_PlantLine.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantLineValue = DDL_PlantLine.SelectedValue.ToString();
                LineProductsBinder(selectedPlantValue, selectedPlantLineValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_ProductCategory);

                string DDL_PlantLine_Error_script = @"<script type='text/javascript'>
                      new PNotify({
                          title: 'Error',
                          text: 'Invalid Selection!',
                          type: 'error',
                          styling: 'bootstrap3'
                      });
                  </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantInvalidErrorNotification", DDL_PlantLine_Error_script, false);
            }
            BindGridView();


        }
        private void LineProductsBinder(string selectedPlantValue, string selectedPlantLineValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT category_id, category_name FROM MST_LineCategory WHERE plant_id = @PlantId AND line_id = @LineId";
            string textField = "category_name"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "category_id"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
          new SqlParameter("@PlantId", selectedPlantValue),
          new SqlParameter("@LineId", selectedPlantLineValue)
            };

            // Call the BindDropDownList method with parameters
            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_ProductCategory, textField, valueField, parameters, out recordsBound);

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
            BindGridView();

        }
        protected void DDL_ProductCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (DDL_ProductCategory.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantLineValue = DDL_PlantLine.SelectedValue.ToString();
                string selectedProductCategoryValue = DDL_ProductCategory.SelectedValue.ToString();
                ProductBrandsBinder(selectedPlantValue, selectedPlantLineValue, selectedProductCategoryValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_ProductBrand);

                string DDL_PlantLine_Error_script = @"<script type='text/javascript'>
                      new PNotify({
                          title: 'Error',
                          text: 'Invalid Selection!',
                          type: 'error',
                          styling: 'bootstrap3'
                      });
                  </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantInvalidErrorNotification", DDL_PlantLine_Error_script, false);
            }
            BindGridView();

        }
        private void ProductBrandsBinder(string selectedPlantValue, string selectedPlantLineValue, string selectedProductCategoryValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT brand_id, brand_name FROM MST_LineCatBrands WHERE plant_id = @PlantId AND line_id = @LineId and category_id=@CategoryId";
            string textField = "brand_name"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "brand_id"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
          new SqlParameter("@PlantId", selectedPlantValue),
          new SqlParameter("@LineId", selectedPlantLineValue),
          new SqlParameter("@CategoryId", selectedProductCategoryValue)
            };

            // Call the BindDropDownList method with parameters
            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_ProductBrand, textField, valueField, parameters, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                string ProductBrands_Error_script = @"<script type='text/javascript'>
              new PNotify({
                  title: 'Error',
                  text: 'No Brands found for the selected plant and line!',
                  type: 'error',
                  styling: 'bootstrap3'
              });
          </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowProductBrandsBinderErrorNotification", ProductBrands_Error_script, false);
            }
            BindGridView();

        }

        protected void DDL_ProductBrand_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_ProductBrand.SelectedIndex != 0)
            {
                string selectedProductBrandValue = DDL_ProductBrand.SelectedValue.ToString();
                BrandSKUBinder(selectedProductBrandValue);

                DataTable dataTable = DatabaseHelper.GetBrandFieldsControlByBrandId(Convert.ToInt16(selectedProductBrandValue));


                // Example: Querying the DataTable for a specific field name
                //string fieldName = "no_of_pcs"; // Specify the field name you want to query
                //DataRow[] rows = dataTable.Select($"brand_id = {selectedProductBrandValue} AND field_name = '{fieldName}'");

                // Iterate through the filtered rows and extract validation criteria
                foreach (DataRow row in dataTable.Rows)
                {
                    // Extract field name from the current row
                    string fieldName = row["field_name"].ToString();

                    // Extract validation criteria from the DataRow
                    bool rfvEnabled = Convert.ToBoolean(row["RFV_YesNo"]);
                    string rfvErrorMessage = row["RFV_ErrorMsg"].ToString();
                    bool revEnabled = Convert.ToBoolean(row["REV_YesNo"]);
                    string revErrorMessage = row["REV_ErrorMsg"].ToString();
                    string revExpression = row["REV_Expression"].ToString();
                    bool rvEnabled = Convert.ToBoolean(row["RV_Yesno"]);
                    string rvErrorMessage = row["RV_ErrorMsg"].ToString();
                    string rvMinValue = row["RV_MinValue"].ToString();
                    string rvMaxValue = row["RV_MaxValue"].ToString();

                    // Create a new instance of ValidationCriteria and populate it with data from the DataRow
                    ValidationCriteria criteria = new ValidationCriteria();
                    criteria.RequiredFieldErrorMessage = rfvErrorMessage;
                    criteria.IsRequired = rfvEnabled;
                    criteria.RegularExpressionErrorMessage = revErrorMessage;
                    criteria.IsRegularExpressionRequired = revEnabled;
                    criteria.RegularExpression = revExpression;
                    criteria.RangeErrorMessage = rvErrorMessage;
                    criteria.IsRangeRequired = rvEnabled;
                    criteria.MinimumValue = rvMinValue;
                    criteria.MaximumValue = rvMaxValue;

                    // Use the criteria as needed
                    // For example, you can pass it to a method to set up validators
                    //SetUpValidatorsForField(fieldName, criteria);
                }
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_ProductBrand);

                string DDL_ProductBrand_Error_script = @"<script type='text/javascript'>
                      new PNotify({
                          title: 'Error',
                          text: 'Invalid Selection!',
                          type: 'error',
                          styling: 'bootstrap3'
                      });
                  </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowSKUInvalidErrorNotification", DDL_ProductBrand_Error_script, false);
            }
            BindGridView();

        }
        private void BrandSKUBinder(string selectedProductBrandValue)
        {
            string query = "SELECT SKUId, SKU_name FROM MST_Brand_SKU WHERE brand_id = @SelectedPlantValue";
            string textField = "SKU_name";
            string valueField = "SKUId";

            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_BrandSKU, textField, valueField, new SqlParameter("@SelectedPlantValue", selectedProductBrandValue), out recordsBound);

            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_PlantLine);

                string BrandSKUBinder_Error_script = @"<script type='text/javascript'>
                      new PNotify({
                          title: 'Error',
                          text: 'An error occurred!',
                          type: 'error',
                          styling: 'bootstrap3'
                      });
                  </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowBrandSKUBinderErrorNotification", BrandSKUBinder_Error_script, false);
            }
            BindGridView();
        }


        
        public class ReportInfo
        {
            
            public int Id { get; set; }
            public string CcpId { get; set; }
            public int FormID { get; set; }
            public string PlantId { get; set; }
            public string Line { get; set; }
            public string ProductCategory { get; set; }
            public string ProductBrand { get; set; }
            public string SKUID { get; set; }
            public int SubmittedById { get; set; }
            public string SubmittedByEmployeeCode { get; set; }
            public DateTime SubmittedDate { get; set; }
            public TimeSpan SubmittedTime { get; set; }
            public string Shift { get; set; }
            public int ViewMode { get; set; }
            public int DeleteMode { get; set; }
            public string Approver1EmployeeCode { get; set; }
            public int? Approver1_Status { get; set; }
            public DateTime? Approver1_TimeStamp { get; set; }
            public string Approver2EmployeeCode { get; set; }
            public int? Approver2_Status { get; set; }
            public DateTime? Approver2_TimeStamp { get; set; }
            public string DottedLineApproverEmployeeCode { get; set; }
            public int? DottedApprover_Status { get; set; }
            public DateTime? DottedApprover_TimeStamp { get; set; }
            public string MetalCheck { get; set; }
            public string SieveCheck { get; set; }
            public int? FF_Status { get; set; }
            public string FF_Remarks { get; set; }
            public int? NFE_Status { get; set; }
            public string NFE_Remarks { get; set; }
            public int? SS_Status { get; set; }
            public string SS_Remarks { get; set; }
            public string MD_Remarks { get; set; }
            public int? T1_Status { get; set; }
            public int? T2_Status { get; set; }
            public int? T3_Status { get; set; }
            public int? T4_Status { get; set; }
            public int? Final_Status { get; set; }
        }


        private DataTable GetFilteredData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Start building the SQL query
                StringBuilder sqlQuery = new StringBuilder("SELECT * FROM [dbo].[TRN_CCP_Checklist] WHERE 1=1 ");

                // List of parameters to add to the command later
                List<SqlParameter> parameters = new List<SqlParameter>();

                // Add filters to SQL query based on the selected values
                if (!string.IsNullOrEmpty(DDL_Plant.SelectedValue) && DDL_Plant.SelectedValue != "0")
                {
                    sqlQuery.Append(" AND PlantId = @Plant_Id ");
                    parameters.Add(new SqlParameter("@Plant_Id", DDL_Plant.SelectedValue));
                }

                if (!string.IsNullOrEmpty(DDL_PlantLine.SelectedValue) && DDL_PlantLine.SelectedValue != "0")
                {
                    sqlQuery.Append(" AND Line = @Plant_Line ");
                    parameters.Add(new SqlParameter("@Plant_Line", DDL_PlantLine.SelectedValue));
                }

                if (!string.IsNullOrEmpty(DDL_ProductCategory.SelectedValue) && DDL_ProductCategory.SelectedValue != "0")
                {
                    sqlQuery.Append(" AND ProductCategory = @Product_Category ");
                    parameters.Add(new SqlParameter("@Product_Category", DDL_ProductCategory.SelectedValue));
                }

                if (!string.IsNullOrEmpty(DDL_ProductBrand.SelectedValue) && DDL_ProductBrand.SelectedValue != "0")
                {
                    sqlQuery.Append(" AND ProductBrand = @Product_Brand ");
                    parameters.Add(new SqlParameter("@Product_Brand", DDL_ProductBrand.SelectedValue));
                }

                if (!string.IsNullOrEmpty(DDL_BrandSKU.SelectedValue) && DDL_BrandSKU.SelectedValue != "0")
                {
                    sqlQuery.Append(" AND SKUId = @SkuId ");
                    parameters.Add(new SqlParameter("@SkuId", DDL_BrandSKU.SelectedValue));
                }

                using (SqlCommand cmd = new SqlCommand(sqlQuery.ToString(), con))
                {
                    // Add parameters to the SqlCommand
                    cmd.Parameters.AddRange(parameters.ToArray());
                    cmd.CommandType = CommandType.Text;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        // Fill DataTable with the result
                        sda.Fill(dt);
                    }
                }
            }

            return dt;
        }


        private void BindGridView()
        {
            // Fetch filtered data from the database
            DataTable dt = GetFilteredData();

            // Convert DataTable to List<ReportInfo>
            List<ReportInfo> dataSave = new List<ReportInfo>();

            foreach (DataRow row in dt.Rows)
            {
                ReportInfo info = new ReportInfo
                {
                    //PlantName = row["PlantName"] == DBNull.Value ? string.Empty : row["PlantName"].ToString(),
                    CcpId = row["CcpId"] == DBNull.Value ? string.Empty : row["CcpId"].ToString(),
                    FormID = row["FormID"] == DBNull.Value ? 0 : Convert.ToInt32(row["FormID"]),
                    PlantId = row["PlantId"] == DBNull.Value ? string.Empty : row["PlantId"].ToString(),
                    Line = row["Line"] == DBNull.Value ? string.Empty : row["Line"].ToString(),
                    ProductCategory = row["ProductCategory"] == DBNull.Value ? string.Empty : row["ProductCategory"].ToString(),
                    ProductBrand = row["ProductBrand"] == DBNull.Value ? string.Empty : row["ProductBrand"].ToString(),
                    SKUID = row["SKUID"] == DBNull.Value ? string.Empty : row["SKUID"].ToString(),
                    SubmittedById = row["SubmittedById"] == DBNull.Value ? 0 : Convert.ToInt32(row["SubmittedById"]),
                    SubmittedByEmployeeCode = row["SubmittedByEmployeeCode"] == DBNull.Value ? string.Empty : row["SubmittedByEmployeeCode"].ToString(),
                    SubmittedDate = row["SubmittedDate"] == DBNull.Value ? DateTime.MinValue : Convert.ToDateTime(row["SubmittedDate"]),
                    SubmittedTime = row["SubmittedTime"] == DBNull.Value ? TimeSpan.Zero : TimeSpan.Parse(row["SubmittedTime"].ToString()),
                    Shift = row["Shift"] == DBNull.Value ? string.Empty : row["Shift"].ToString(),
                    ViewMode = row["ViewMode"] == DBNull.Value ? 0 : Convert.ToInt32(row["ViewMode"]),
                    DeleteMode = row["DeleteMode"] == DBNull.Value ? 0 : Convert.ToInt32(row["DeleteMode"]),
                    Approver1EmployeeCode = row["Approver1EmployeeCode"] == DBNull.Value ? string.Empty : row["Approver1EmployeeCode"].ToString(),
                    Approver1_Status = row["Approver1_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["Approver1_Status"]),
                    Approver1_TimeStamp = row["Approver1_TimeStamp"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["Approver1_TimeStamp"]),
                    Approver2EmployeeCode = row["Approver2EmployeeCode"] == DBNull.Value ? string.Empty : row["Approver2EmployeeCode"].ToString(),
                    Approver2_Status = row["Approver2_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["Approver2_Status"]),
                    Approver2_TimeStamp = row["Approver2_TimeStamp"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["Approver2_TimeStamp"]),
                    DottedLineApproverEmployeeCode = row["DottedLineApproverEmployeeCode"] == DBNull.Value ? string.Empty : row["DottedLineApproverEmployeeCode"].ToString(),
                    DottedApprover_Status = row["DottedApprover_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["DottedApprover_Status"]),
                    DottedApprover_TimeStamp = row["DottedApprover_TimeStamp"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["DottedApprover_TimeStamp"]),
                    MetalCheck = row["MetalCheck"] == DBNull.Value ? string.Empty : row["MetalCheck"].ToString(),
                    SieveCheck = row["SieveCheck"] == DBNull.Value ? string.Empty : row["SieveCheck"].ToString(),
                    FF_Status = row["FF_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["FF_Status"]),
                    FF_Remarks = row["FF_Remarks"] == DBNull.Value ? string.Empty : row["FF_Remarks"].ToString(),
                    NFE_Status = row["NFE_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["NFE_Status"]),
                    NFE_Remarks = row["NFE_Remarks"] == DBNull.Value ? string.Empty : row["NFE_Remarks"].ToString(),
                    SS_Status = row["SS_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["SS_Status"]),
                    SS_Remarks = row["SS_Remarks"] == DBNull.Value ? string.Empty : row["SS_Remarks"].ToString(),
                    MD_Remarks = row["MD_Remarks"] == DBNull.Value ? string.Empty : row["MD_Remarks"].ToString(),
                    T1_Status = row["T1_Status"] == DBNull.Value ? 0 : Convert.ToInt32(row["T1_Status"]),
                    T2_Status = row["T2_Status"] == DBNull.Value ? 0 : Convert.ToInt32(row["T2_Status"]),
                    T3_Status = row["T3_Status"] == DBNull.Value ? 0 : Convert.ToInt32(row["T3_Status"]),
                    T4_Status = row["T4_Status"] == DBNull.Value ? 0 : Convert.ToInt32(row["T4_Status"]),
                    Final_Status = row["Final_Status"] == DBNull.Value ? 0 : Convert.ToInt32(row["Final_Status"])
                };

                dataSave.Add(info);
            }

            // Bind to GridView
            GridView1.DataSource = dataSave;
            GridView1.DataBind();
        }


        private void loadAlldata()
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString);
            SqlCommand cmd = new SqlCommand("select * from TRN_CCP_Checklist", con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }


        protected void ExportBtn_Click(object sender, EventArgs e)
        {
            try
            {
                // Fetch the data that needs to be exported from TRN_CCP_Checklist
                DataTable exportData = GetFilteredData(); // Update this method to retrieve your specific data for export

                if (exportData != null && exportData.Rows.Count > 0)
                {
                    // Set the response settings for Excel export
                    Response.Clear();
                    Response.Buffer = true;
                    Response.AddHeader("content-disposition", "attachment;filename=CCP_Checklist_Export.xls");
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.ms-excel";

                    using (StringWriter sw = new StringWriter())
                    {
                        HtmlTextWriter hw = new HtmlTextWriter(sw);

                        // Create an HTML table to export data using GridView
                        GridView exportGridView = new GridView();
                        exportGridView.DataSource = exportData;
                        exportGridView.DataBind();

                        // Render the GridView content
                        exportGridView.RenderControl(hw);

                        // Write the content to the response
                        Response.Output.Write(sw.ToString());
                        Response.Flush();
                        Response.End();
                    }
                }
                else
                {
                    // Notify the user if no data is available for export
                    ShowNotification("No Data", "No data available to export.", "info");
                }
            }
            catch (Exception ex)
            {
                // Handle any errors that occur during the export process
                ShowNotification("Error", $"An error occurred while exporting: {ex.Message}", "error");
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            // Confirms that an HtmlForm control is rendered for the specified ASP.NET
        }

        private DataTable GetLeakTestDataForExport()
        {
            // Connection string to your database
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            // Query to fetch data from the TRN_CCP_Checklist table
            string query = "SELECT * FROM TRN_CCP_Checklist"; // Adjust this query as per your table structure

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        // Optional: Implement a basic notification function (This can be customized or removed)
        private void ShowNotification(string title, string message, string type)
        {
            // You can implement a real notification system here or log to the console
            Console.WriteLine($"{title}: {message} [{type}]");
        }
        protected void btn_view_submit_Click(object sender, EventArgs e)
        {
            // Retrieve date range from textboxes
            DateTime? dateFrom = string.IsNullOrEmpty(TXT_PackageDate.Text) ? (DateTime?)null : DateTime.ParseExact(TXT_PackageDate.Text, "yyyy-MM-dd", null);
            DateTime? dateTo = string.IsNullOrEmpty(TextBox1.Text) ? (DateTime?)null : DateTime.ParseExact(TextBox1.Text, "yyyy-MM-dd", null);

            // Build SQL query based on date range
            StringBuilder queryBuilder = new StringBuilder("SELECT * FROM [dbo].[TRN_CCP_Checklist] WHERE 1 = 1");
            var parameters = new List<SqlParameter>();

            if (dateFrom.HasValue)
            {
                queryBuilder.Append(" AND SubmittedDate >= @DateFrom");
                parameters.Add(new SqlParameter("@DateFrom", SqlDbType.Date) { Value = dateFrom.Value.Date });
            }

            if (dateTo.HasValue)
            {
                queryBuilder.Append(" AND SubmittedDate <= @DateTo");
                parameters.Add(new SqlParameter("@DateTo", SqlDbType.Date) { Value = dateTo.Value.Date });
            }

            try
            {
                // Fetch filtered data using the constructed query and parameters
                DataTable filteredData = GetDataFromTable(queryBuilder.ToString(), parameters.ToArray());

                // Convert DataTable to List<TRN_CCP_ChecklistInfo>
                List<ReportInfo> dataSave = new List<ReportInfo>();
                foreach (DataRow row in filteredData.Rows)
                {
                    ReportInfo info = new ReportInfo
                    {
                        Id = row["Id"] == DBNull.Value ? 0 : Convert.ToInt32(row["Id"]),
                        CcpId = row["CcpId"] == DBNull.Value ? string.Empty : row["CcpId"].ToString(),
                        FormID = row["FormID"] == DBNull.Value ? 0 : Convert.ToInt32(row["FormID"]),
                        PlantId = row["PlantId"] == DBNull.Value ? string.Empty : row["PlantId"].ToString(),
                        Line = row["Line"] == DBNull.Value ? string.Empty : row["Line"].ToString(),
                        ProductCategory = row["ProductCategory"] == DBNull.Value ? string.Empty : row["ProductCategory"].ToString(),
                        ProductBrand = row["ProductBrand"] == DBNull.Value ? string.Empty : row["ProductBrand"].ToString(),
                        SKUID = row["SKUID"] == DBNull.Value ? string.Empty : row["SKUID"].ToString(),
                        SubmittedById = row["SubmittedById"] == DBNull.Value ? 0 : Convert.ToInt32(row["SubmittedById"]),
                        SubmittedByEmployeeCode = row["SubmittedByEmployeeCode"] == DBNull.Value ? string.Empty : row["SubmittedByEmployeeCode"].ToString(),
                        SubmittedDate = row["SubmittedDate"] == DBNull.Value ? DateTime.MinValue : Convert.ToDateTime(row["SubmittedDate"]),
                        SubmittedTime = row["SubmittedTime"] == DBNull.Value ? TimeSpan.Zero : TimeSpan.Parse(row["SubmittedTime"].ToString()),
                        Shift = row["Shift"] == DBNull.Value ? string.Empty : row["Shift"].ToString(),
                        ViewMode = row["ViewMode"] == DBNull.Value ? 0 : Convert.ToInt32(row["ViewMode"]),
                        DeleteMode = row["DeleteMode"] == DBNull.Value ? 0 : Convert.ToInt32(row["DeleteMode"]),
                        Approver1EmployeeCode = row["Approver1EmployeeCode"] == DBNull.Value ? string.Empty : row["Approver1EmployeeCode"].ToString(),
                        Approver1_Status = row["Approver1_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["Approver1_Status"]),
                        Approver1_TimeStamp = row["Approver1_TimeStamp"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["Approver1_TimeStamp"]),
                        Approver2EmployeeCode = row["Approver2EmployeeCode"] == DBNull.Value ? string.Empty : row["Approver2EmployeeCode"].ToString(),
                        Approver2_Status = row["Approver2_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["Approver2_Status"]),
                        Approver2_TimeStamp = row["Approver2_TimeStamp"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["Approver2_TimeStamp"]),
                        DottedLineApproverEmployeeCode = row["DottedLineApproverEmployeeCode"] == DBNull.Value ? string.Empty : row["DottedLineApproverEmployeeCode"].ToString(),
                        DottedApprover_Status = row["DottedApprover_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["DottedApprover_Status"]),
                        DottedApprover_TimeStamp = row["DottedApprover_TimeStamp"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["DottedApprover_TimeStamp"]),
                        MetalCheck = row["MetalCheck"] == DBNull.Value ? string.Empty : row["MetalCheck"].ToString(),
                        SieveCheck = row["SieveCheck"] == DBNull.Value ? string.Empty : row["SieveCheck"].ToString(),
                        FF_Status = row["FF_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["FF_Status"]),
                        FF_Remarks = row["FF_Remarks"] == DBNull.Value ? string.Empty : row["FF_Remarks"].ToString(),
                        NFE_Status = row["NFE_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["NFE_Status"]),
                        NFE_Remarks = row["NFE_Remarks"] == DBNull.Value ? string.Empty : row["NFE_Remarks"].ToString(),
                        SS_Status = row["SS_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["SS_Status"]),
                        SS_Remarks = row["SS_Remarks"] == DBNull.Value ? string.Empty : row["SS_Remarks"].ToString(),
                        MD_Remarks = row["MD_Remarks"] == DBNull.Value ? string.Empty : row["MD_Remarks"].ToString(),
                        T1_Status = row["T1_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["T1_Status"]),
                        T2_Status = row["T2_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["T2_Status"]),
                        T3_Status = row["T3_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["T3_Status"]),
                        T4_Status = row["T4_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["T4_Status"]),
                        Final_Status = row["Final_Status"] == DBNull.Value ? (int?)null : Convert.ToInt32(row["Final_Status"])
                    };

                    dataSave.Add(info);
                }

                // Bind to GridView
                GridView1.DataSource = dataSave;
                GridView1.DataBind();

                // Show a notification if no records are found
                if (filteredData.Rows.Count == 0)
                {
                    // ShowNotification("No Data", "No records found for the selected date range.", "info");
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions (log it, show an error message, etc.)
                // ShowNotification("Error", "An error occurred while processing your request.", "error");
            }
        }



        private DataTable GetDataFromTable(string query, SqlParameter[] parameters)
        {
            DataTable dt = new DataTable();
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddRange(parameters);
                    cmd.CommandType = CommandType.Text;

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }

            return dt;
        }


        protected void btn_view_Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void btn_view_Reset_Click(object sender, EventArgs e)
        {
            Response.Redirect("vm_ccp_checklist.aspx");
        }
        

    }
}