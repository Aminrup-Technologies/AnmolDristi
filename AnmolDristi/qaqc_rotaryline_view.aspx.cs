using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.IO;
using System.Web.Services;
using System.Security.Cryptography;

//using Microsoft.Office.Interop.Excel;
//using System.Runtime.InteropServices; // Optional, for Excel interop cleanup
//using ExcelInterop = Microsoft.Office.Interop.Excel;



namespace AnmolDristi
{
    public partial class qaqc_rotaryline_view : System.Web.UI.Page
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

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

                    lbl_upper.Text = "Search Filters for Rotary Line Report";
                    lbl_lower.Text = "View and Select for Detailed View  ||   ";

                    PlantBinder();
                    //loadAlldata();  // Load all data on initial load
                    BindGridView();
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
            

        }

        protected void DDL_Plant_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Plant.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                lbl_DDL_Plant_Value.Text = selectedPlantValue;
                PlantLinesBinder(selectedPlantValue);
                FilterGridView();
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
           

        }
        protected void DDL_PlantLine_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_PlantLine.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantLineValue = DDL_PlantLine.SelectedValue.ToString();
                lbl_DDL_PlantLine_Value.Text = selectedPlantLineValue;
                LineProductsBinder(selectedPlantValue, selectedPlantLineValue);
                FilterGridView();
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
            

        }
        protected void DDL_ProductCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (DDL_ProductCategory.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantLineValue = DDL_PlantLine.SelectedValue.ToString();
                string selectedProductCategoryValue = DDL_ProductCategory.SelectedValue.ToString();
                lbl_DDL_ProductCategory_Value.Text = selectedProductCategoryValue;
                ProductBrandsBinder(selectedPlantValue, selectedPlantLineValue, selectedProductCategoryValue);
                FilterGridView();
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
            

        }
        protected void DDL_ProductBrand_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_ProductBrand.SelectedIndex != 0)
            {
                string selectedProductBrandValue = DDL_ProductBrand.SelectedValue.ToString();
                lbl_DDL_ProductBrand_Value.Text = selectedProductBrandValue;
                FilterGridView();
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
            

        }
       



        protected void btn_view_cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void btn_view_reset_Click(object sender, EventArgs e)
        {
            Response.Redirect("qaqc_rotaryline_view.aspx");
        }


        //private void loadAlldata()
        //{
        //    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString);
        //    SqlCommand cmd = new SqlCommand("select * from BasicRl_Data_Table", con);
        //    SqlDataAdapter sda = new SqlDataAdapter(cmd);
        //    DataTable dt = new DataTable();
        //    sda.Fill(dt);
        //    GridView1.DataSource = dt;
        //    GridView1.DataBind();
        //}

        //public class ReportInfo
        //{
        //    public int Id { get; set; }
        //    public string PlantName { get; set; }  // Updated to match database column
        //    public string Line { get; set; }
        //    public string ProductCategory { get; set; }
        //    public string ProductBrand { get; set; }
        //    public string SKUID { get; set; }
        //    public string RLWt { get; set; }
        //    public DateTime? SubmittedDate { get; set; }  // Renamed to match the database column
        //    public TimeSpan? SubmittedTime { get; set; }  // Renamed to match the database column
        //    public string Shift { get; set; }
        //    public string SubmittedById { get; set; }
        //    public string Variety { get; set; }
        //    public string SubmittedByEmployeeCode { get; set; }  // Added this field based on database
        //    public int? Approver1_Status { get; set; }  // Changed type to int to match database
        //    public DateTime? Approver1_TimeStamp { get; set; }  // Changed to DateTime? to match database
        //    public string Approver1EmployeeCode { get; set; }  // Added this field based on database
        //    public int? Approver2_Status { get; set; }  // Changed type to int to match database
        //    public DateTime? Approver2_TimeStamp { get; set; }  // Changed to DateTime? to match database
        //    public string Approver2EmployeeCode { get; set; }  // Added this field based on database
        //    public int? DottedApprover_Status { get; set; }  // Changed type to int to match database
        //    public DateTime? DottedApprover_TimeStamp { get; set; }  // Changed to DateTime? to match database
        //    public string DottedLineApproverEmployeeCode { get; set; }  // Added this field based on database
        //    public string LineWt { get; set; }
        //    public string GaugeAndWeight { get; set; }
        //    public decimal? AvgLineWt { get; set; }
        //    public decimal? AvgGaugeValue { get; set; }
        //    public decimal? AvgWeightValue { get; set; }
        //}

        //private DataTable GetFilteredData()
        //{
        //    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //    DataTable dt = new DataTable();

        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        string sqlQuery = "SELECT * FROM TRN_RotaryLine_OvenEnd WHERE ViewMode=1";

        //        // Add filters to SQL query based on the selected values
        //        if (!string.IsNullOrEmpty(DDL_Plant.SelectedValue) && DDL_Plant.SelectedValue != "0")
        //        {
        //            sqlQuery += " AND PlantName = @PlantName";
        //        }

        //        if (!string.IsNullOrEmpty(DDL_PlantLine.SelectedValue) && DDL_PlantLine.SelectedValue != "0")
        //        {
        //            sqlQuery += " AND Line = @Line";
        //        }

        //        if (!string.IsNullOrEmpty(DDL_ProductCategory.SelectedValue) && DDL_ProductCategory.SelectedValue != "0")
        //        {
        //            sqlQuery += " AND ProductCategory = @ProductCategory";
        //        }

        //        if (!string.IsNullOrEmpty(DDL_ProductBrand.SelectedValue) && DDL_ProductBrand.SelectedValue != "0")
        //        {
        //            sqlQuery += " AND ProductBrand = @ProductBrand";
        //        }

        //        if (!string.IsNullOrEmpty(DDL_BrandSKU.SelectedValue) && DDL_BrandSKU.SelectedValue != "0")
        //        {
        //            sqlQuery += " AND SKUID = @SKUID";
        //        }


        //        sqlQuery += " order by Id desc";

        //        using (SqlCommand cmd = new SqlCommand(sqlQuery, con))
        //        {
        //            // Add parameters only if they are being used in the query
        //            if (!string.IsNullOrEmpty(DDL_Plant.SelectedValue) && DDL_Plant.SelectedValue != "0")
        //            {
        //                cmd.Parameters.AddWithValue("@PlantName", DDL_Plant.SelectedValue);
        //            }

        //            if (!string.IsNullOrEmpty(DDL_PlantLine.SelectedValue) && DDL_PlantLine.SelectedValue != "0")
        //            {
        //                cmd.Parameters.AddWithValue("@Line", DDL_PlantLine.SelectedValue);
        //            }

        //            if (!string.IsNullOrEmpty(DDL_ProductCategory.SelectedValue) && DDL_ProductCategory.SelectedValue != "0")
        //            {
        //                cmd.Parameters.AddWithValue("@ProductCategory", DDL_ProductCategory.SelectedValue);
        //            }

        //            if (!string.IsNullOrEmpty(DDL_ProductBrand.SelectedValue) && DDL_ProductBrand.SelectedValue != "0")
        //            {
        //                cmd.Parameters.AddWithValue("@ProductBrand", DDL_ProductBrand.SelectedValue);
        //            }

        //            if (!string.IsNullOrEmpty(DDL_BrandSKU.SelectedValue) && DDL_BrandSKU.SelectedValue != "0")
        //            {
        //                cmd.Parameters.AddWithValue("@SKUID", DDL_BrandSKU.SelectedValue);
        //            }

        //            cmd.CommandType = CommandType.Text;

        //            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
        //            {
        //                sda.Fill(dt);
        //            }
        //        }
        //    }

        //    return dt;
        //}


        //private void BindGridView()
        //{
        //    // Fetch filtered data from the database
        //    DataTable dt = GetFilteredData();

        //    // Convert DataTable to List<ReportInfo>
        //    List<ReportInfo> dataSave = new List<ReportInfo>();

        //    foreach (DataRow row in dt.Rows)
        //    {
        //        ReportInfo info = new ReportInfo
        //        {
        //            Id = row["Id"] == DBNull.Value ? 0 : Convert.ToInt32(row["Id"]),
        //            //FormID = row["FormID"] == DBNull.Value ? 0 : Convert.ToInt32(row["FormID"]),
        //            //SubmittedById = row["SubmittedById"] == DBNull.Value ? 0 : Convert.ToInt32(row["SubmittedById"]),
        //            SubmittedDate = row["SubmittedDate"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["SubmittedDate"]),
        //            SubmittedTime = row["SubmittedTime"] == DBNull.Value ? (TimeSpan?)null : TimeSpan.Parse(row["SubmittedTime"].ToString()),
        //            Shift = row["Shift"] == DBNull.Value ? string.Empty : row["Shift"].ToString(),
        //            SubmittedByEmployeeCode = row["SubmittedByEmployeeCode"] == DBNull.Value ? string.Empty : row["SubmittedByEmployeeCode"].ToString(),
        //            PlantName = row["PlantName"] == DBNull.Value ? string.Empty : row["PlantName"].ToString(),
        //            Line = row["Line"] == DBNull.Value ? string.Empty : row["Line"].ToString(),
        //            ProductCategory = row["ProductCategory"] == DBNull.Value ? string.Empty : row["ProductCategory"].ToString(),
        //            ProductBrand = row["ProductBrand"] == DBNull.Value ? string.Empty : row["ProductBrand"].ToString(),
        //            SKUID = row["SKUId"] == DBNull.Value ? string.Empty : row["SKUId"].ToString(),
        //            RLWt = row["RLWt"] == DBNull.Value ? string.Empty : row["RLWt"].ToString(),
        //            Variety = row["Variety"] == DBNull.Value ? string.Empty : row["Variety"].ToString(),
        //            //ViewMode = row["ViewMode"] == DBNull.Value ? 0 : Convert.ToInt32(row["ViewMode"]),
        //            //DeleteMode = row["DeleteMode"] == DBNull.Value ? 0 : Convert.ToInt32(row["DeleteMode"]),
        //            Approver1EmployeeCode = row["Approver1EmployeeCode"] == DBNull.Value ? string.Empty : row["Approver1EmployeeCode"].ToString(),
        //            Approver1_Status = row["Approver1_Status"] == DBNull.Value ? 0 : Convert.ToInt32(row["Approver1_Status"]),
        //            Approver1_TimeStamp = row["Approver1_TimeStamp"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["Approver1_TimeStamp"]),
        //            Approver2EmployeeCode = row["Approver2EmployeeCode"] == DBNull.Value ? string.Empty : row["Approver2EmployeeCode"].ToString(),
        //            Approver2_Status = row["Approver2_Status"] == DBNull.Value ? 0 : Convert.ToInt32(row["Approver2_Status"]),
        //            Approver2_TimeStamp = row["Approver2_TimeStamp"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["Approver2_TimeStamp"]),
        //            DottedLineApproverEmployeeCode = row["DottedLineApproverEmployeeCode"] == DBNull.Value ? string.Empty : row["DottedLineApproverEmployeeCode"].ToString(),
        //            DottedApprover_Status = row["DottedApprover_Status"] == DBNull.Value ? 0 : Convert.ToInt32(row["DottedApprover_Status"]),
        //            DottedApprover_TimeStamp = row["DottedApprover_TimeStamp"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(row["DottedApprover_TimeStamp"]),
        //            LineWt = row["linewt"] == DBNull.Value ? string.Empty : row["linewt"].ToString(),
        //            AvgLineWt = row["avglinewt"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(row["avglinewt"]),
        //            //GaugeValues = row["gaugevalues"] == DBNull.Value ? string.Empty : row["gaugevalues"].ToString(),
        //            AvgGaugeValue = row["avggaugevalue"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(row["avggaugevalue"]),
        //            //WeightValue = row["weightvalue"] == DBNull.Value ? string.Empty : row["weightvalue"].ToString(),
        //            AvgWeightValue = row["avgweightvalue"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(row["avgweightvalue"]),
        //            GaugeAndWeight = row["gaugeandweight"] == DBNull.Value ? string.Empty : row["gaugeandweight"].ToString()
        //        };

        //        dataSave.Add(info);
        //    }

        //    // Bind to GridView
        //    GridView1.DataSource = dataSave;
        //    GridView1.DataBind();
        //}



        //protected void btn_view_submit_Click(object sender, EventArgs e)
        //{
        //    // Retrieve date range from textboxes
        //    DateTime? dateFrom = GetDateFromTextBox(TxtDateFrom.Text);
        //    DateTime? dateTo = GetDateFromTextBox(TxtDateTo.Text);

        //    // SQL query to fetch data based on date range
        //    StringBuilder queryBuilder = new StringBuilder("SELECT * FROM dbo.TRN_RotaryLine_OvenEnd WHERE 1 = 1");
        //    var parameters = new List<SqlParameter>();

        //    if (dateFrom.HasValue)
        //    {
        //        queryBuilder.Append(" AND [Date] >= @DateFrom");
        //        parameters.Add(new SqlParameter("@DateFrom", SqlDbType.Date) { Value = dateFrom.Value.Date });
        //    }

        //    if (dateTo.HasValue)
        //    {
        //        queryBuilder.Append(" AND [Date] <= @DateTo");
        //        parameters.Add(new SqlParameter("@DateTo", SqlDbType.Date) { Value = dateTo.Value.Date });
        //    }

        //    try
        //    {
        //        // Fetch filtered data using the constructed query and parameters
        //        DataTable filteredData = GetDataFromTable(queryBuilder.ToString(), parameters.ToArray());

        //        // Bind filtered data to GridView
        //        GridView1.DataSource = filteredData;
        //        GridView1.DataBind();

        //        // Show a notification if no records are found 
        //        if (filteredData.Rows.Count == 0)
        //        {
        //            ShowNotification("No Data", "No records found for the selected date range.", "info");
        //        }
        //    }
        //    catch (Exception)
        //    {
        //        // Handle exceptions (log it, show an error message, etc.)
        //        ShowNotification("Error", "An error occurred while processing your request.", "error");
        //    }
        //}

        //// Helper method to convert textbox text to DateTime
        //private DateTime? GetDateFromTextBox(string text)
        //{
        //    return string.IsNullOrEmpty(text) ? (DateTime?)null : DateTime.ParseExact(text, "yyyy-MM-dd", null);
        //}

        //// Helper method to fetch data from the table
        //private DataTable GetDataFromTable(string query, SqlParameter[] parameters)
        //{
        //    // Implementation for retrieving data from the database based on query and parameters
        //    // Ensure to use appropriate connection string and data retrieval logic
        //    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //    DataTable dataTable = new DataTable();

        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand command = new SqlCommand(query, connection))
        //        {
        //            command.Parameters.AddRange(parameters);
        //            using (SqlDataAdapter adapter = new SqlDataAdapter(command))
        //            {
        //                adapter.Fill(dataTable);
        //            }
        //        }
        //    }

        //    return dataTable;
        //}

        ////Helper method to show notifications
        //private void ShowNotification(string title, string message, string type)
        //{
        //    // Example: Use PNotify or any other notification mechanism
        //    string script = $@"
        //    <script type='text/javascript'>
        //        new PNotify({{
        //        title: '{title}',
        //        text: '{message}',
        //        type: '{type}',
        //        styling: 'bootstrap3'
        //        }});
        //    </script>";

        //    ClientScript.RegisterStartupScript(this.GetType(), "ShowNotification", script, false);
        //}



        //protected void btn_view_export_Click(object sender, EventArgs e)
        //{
        //    Response.Clear();
        //    //Response.Buffer = true;
        //    //Response.ContentType = "application/ms-excel";
        //    //Response.AddHeader("content-disposition", "attachment; filename= ProcessChecking_ViewPage.xls");
        //    //Response.Charset = "";
        //    //StringWriter sw = new StringWriter();
        //    //HtmlTextWriter htw = new HtmlTextWriter(sw);
        //    //GridView1.RenderControl(htw);
        //    //Response.Output.Write(sw.ToString());
        //    //Response.End();


        //    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //    string query = @"
        //        SELECT
        //            A.plant_name,
        //            B.line_name,
        //            C.category_name,
        //            D.brand_name,
        //            P.*  -- Columns from the TRN_RotaryLine_OvenEnd table
        //        FROM
        //            TRN_RotaryLine_OvenEnd P
        //        JOIN dbo.MST_PlantDetails A ON P.PlantName = A.plant_id
        //        JOIN dbo.MST_Plant_Lines B ON P.Line = B.line_id
        //        JOIN dbo.MST_LineCategory C ON P.ProductCategory = C.category_id
        //        JOIN dbo.MST_LineCatBrands D ON P.ProductBrand = D.brand_id";

        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            con.Open();

        //            using (SqlDataReader reader = cmd.ExecuteReader())
        //            {
        //                if (reader.HasRows)
        //                {
        //                    string GridViewDataExportedFileInfo = "RotaryLine_OvenEnd_ViewPage_" + DateTime.UtcNow.ToString("yyyyMMdd_HHmmss") + ".xls";

        //                    #region Export In Documents Folder
        //                    object misValue = System.Reflection.Missing.Value;
        //                    ExcelInterop.Application application = new ExcelInterop.Application();
        //                    application.Visible = false;

        //                    ExcelInterop.Workbook workbook = application.Workbooks.Add(misValue);
        //                    ExcelInterop.Worksheet worksheet = (ExcelInterop.Worksheet)workbook.Worksheets[1];
        //                    worksheet.Name = "RotaryLine_OvenEnd_ViewPage";
        //                    worksheet.Cells.Font.Size = 12;

        //                    // Add Column Headers from SqlDataReader
        //                    for (int i = 0; i < reader.FieldCount; i++)
        //                    {
        //                        worksheet.Cells[1, i + 1] = reader.GetName(i);  // Adding column headers
        //                    }

        //                    // Add Data from SqlDataReader
        //                    int rowIndex = 2; // Data starts from row 2
        //                    while (reader.Read())
        //                    {
        //                        for (int i = 0; i < reader.FieldCount; i++)
        //                        {
        //                            worksheet.Cells[rowIndex, i + 1] = reader.GetValue(i).ToString();  // Add data to the cells
        //                        }
        //                        rowIndex++;
        //                    }

        //                    // Apply AutoFilter
        //                    ExcelInterop.Range usedRange = worksheet.UsedRange;
        //                    usedRange.AutoFilter(1, Type.Missing, ExcelInterop.XlAutoFilterOperator.xlFilterValues, Type.Missing, true);

        //                    // Save the workbook
        //                    workbook.SaveAs(GridViewDataExportedFileInfo,
        //                        ExcelInterop.XlFileFormat.xlWorkbookNormal, misValue, misValue, misValue, misValue,
        //                        ExcelInterop.XlSaveAsAccessMode.xlExclusive, misValue, misValue, misValue, misValue, misValue);

        //                    // Close the workbook and quit the application
        //                    workbook.Close(true, misValue, misValue);
        //                    application.Quit();

        //                    // Notify the user
        //                    this.ClientScript.RegisterStartupScript(this.GetType(), "GridViewData Exported Alert Box.",
        //                        "alert('Data File Exported with name " + GridViewDataExportedFileInfo + " in Document folder');", true);
        //                    #endregion
        //                }
        //                else
        //                {
        //                    this.ClientScript.RegisterStartupScript(this.GetType(), "No Data Alert Box.",
        //                        "alert('There are no records to Download.');", true);
        //                }
        //            }
        //        }
        //    }


        //}

        //public void AddColumnInSheetFromReader(Worksheet worksheet, SqlDataReader reader)
        //{
        //    for (int i = 0; i < reader.FieldCount; i++)
        //    {
        //        string columnName = reader.GetName(i);
        //        worksheet.Cells[1, i + 1] = columnName; // Write column headers in the first row
        //    }
        //}


        //public override void VerifyRenderingInServerForm(Control control)
        //{

        //}


        public class ReportInfo
        {
            public int Id { get; set; }
            public string plant_name { get; set; }
            public string line_name { get; set; }
            public string category_name { get; set; }
            public string brand_name { get; set; }
            public string RLWt { get; set; }
            public DateTime? SubmittedDate { get; set; }  // Renamed to match the database column
            public TimeSpan? SubmittedTime { get; set; }  // Renamed to match the database column
            public string Shift { get; set; }
            public string SubmittedById { get; set; }
            public string Variety { get; set; }
            public string SubmittedByEmployeeCode { get; set; }  // Added this field based on database
            public int? Approver1_Status { get; set; }  // Changed type to int to match database
            public DateTime? Approver1_TimeStamp { get; set; }  // Changed to DateTime? to match database
            public string Approver1EmployeeCode { get; set; }  // Added this field based on database
            public int? Approver2_Status { get; set; }  // Changed type to int to match database
            public DateTime? Approver2_TimeStamp { get; set; }  // Changed to DateTime? to match database
            public string Approver2EmployeeCode { get; set; }  // Added this field based on database
            public int? DottedApprover_Status { get; set; }  // Changed type to int to match database
            public DateTime? DottedApprover_TimeStamp { get; set; }  // Changed to DateTime? to match database
            public string DottedLineApproverEmployeeCode { get; set; }  // Added this field based on database
            public string LineWt { get; set; }
            public string GaugeAndWeight { get; set; }
            public decimal? AvgLineWt { get; set; }
            public decimal? AvgGaugeValue { get; set; }
            public decimal? AvgWeightValue { get; set; }
        }


        protected void btn_view_submit_Click(object sender, EventArgs e)
        {
            try
            {
                // Convert dates from TextBox inputs
                DateTime fromDate = Convert.ToDateTime(TxtDateFrom.Text);
                DateTime toDate = Convert.ToDateTime(TxtDateTo.Text);

                // Validate date range
                if (toDate > DateTime.Now)
                {
                    Response.Write("<script>alert('ToDate cannot be greater than the current date!');</script>");
                    return;
                }
                else if (fromDate > toDate)
                {
                    Response.Write("<script>alert('FromDate cannot be greater than ToDate!');</script>");
                    return;
                }

                // Call method to fetch and bind data
                getReportData(fromDate, toDate);
            }
            catch (FormatException)
            {
                Response.Write("<script>alert('Invalid date format! Please enter a valid date.');</script>");
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        private void getReportData(DateTime fromDate, DateTime toDate)
        {
            string query = @"
                SELECT
                    A.plant_name,
                    B.line_name,
                    C.category_name,
                    D.brand_name,
                    P.*
                FROM
                    TRN_RotaryLine_OvenEnd P
                JOIN dbo.MST_PlantDetails A ON P.PlantName = A.plant_id
                JOIN dbo.MST_Plant_Lines B ON P.Line = B.line_id
                JOIN dbo.MST_LineCategory C ON P.ProductCategory = C.category_id
                JOIN dbo.MST_LineCatBrands D ON P.ProductBrand = D.brand_id
                WHERE SubmittedDate BETWEEN @FromDate AND @ToDate";

            // Add conditions for optional filters
            if (!string.IsNullOrEmpty(DDL_Plant.SelectedValue))
            {
                query += " AND P.PlantName = @PlantName";
            }
            if (!string.IsNullOrEmpty(DDL_PlantLine.SelectedValue))
            {
                query += " AND P.Line = @Line";
            }
            if (!string.IsNullOrEmpty(DDL_ProductCategory.SelectedValue))
            {
                query += " AND P.ProductCategory = @CategoryName";
            }
            if (!string.IsNullOrEmpty(DDL_ProductBrand.SelectedValue))
            {
                query += " AND P.ProductBrand = @BrandName";
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.CommandType = CommandType.Text;

                    // Add common parameters
                    cmd.Parameters.AddWithValue("@FromDate", fromDate);
                    cmd.Parameters.AddWithValue("@ToDate", toDate);

                    // Add filter parameters only if DropDownList values are selected
                    if (!string.IsNullOrEmpty(DDL_Plant.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue("@PlantName", DDL_Plant.SelectedValue);
                    }
                    if (!string.IsNullOrEmpty(DDL_PlantLine.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue("@Line", DDL_PlantLine.SelectedValue);
                    }
                    if (!string.IsNullOrEmpty(DDL_ProductCategory.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue("@CategoryName", DDL_ProductCategory.SelectedValue);
                    }
                    if (!string.IsNullOrEmpty(DDL_ProductBrand.SelectedValue))
                    {
                        cmd.Parameters.AddWithValue("@BrandName", DDL_ProductBrand.SelectedValue);
                    }

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        System.Data.DataTable dt = new System.Data.DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }
                        else
                        {
                            Response.Write("<script>alert('No records found for the selected filters and date range.');</script>");
                            GridView1.DataSource = null;
                            GridView1.DataBind();
                        }
                    }
                }
            }
        }


        protected void BindGridView()
        {
            try
            {
                // Define query
                string query = @"
                SELECT
                    A.plant_name,
                    B.line_name,
                    C.category_name,
                    D.brand_name,
                    P.*  -- Columns from the TRN_RotaryLine_OvenEnd table
                FROM
                    TRN_RotaryLine_OvenEnd P
                JOIN dbo.MST_PlantDetails A ON P.PlantName = A.plant_id
                JOIN dbo.MST_Plant_Lines B ON P.Line = B.line_id
                JOIN dbo.MST_LineCategory C ON P.ProductCategory = C.category_id
                JOIN dbo.MST_LineCatBrands D ON P.ProductBrand = D.brand_id";

                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.CommandType = CommandType.Text;

                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            System.Data.DataTable dt = new System.Data.DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                // Bind data to GridView
                                GridView1.DataSource = dt;
                                GridView1.DataBind();
                            }
                            else
                            {
                                // Handle empty result
                                GridView1.DataSource = null;
                                GridView1.DataBind();
                                Response.Write("<script>alert('No data found.');</script>");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }

        protected void FilterGridView()
        {
            try
            {
                // Establish database connection
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    // Define query with filters
                    string query = @"
                    SELECT
                        A.plant_name,
                        B.line_name,
                        C.category_name,
                        D.brand_name,
                        P.*
                    FROM
                        TRN_RotaryLine_OvenEnd P
                    JOIN dbo.MST_PlantDetails A ON P.PlantName = A.plant_id
                    JOIN dbo.MST_Plant_Lines B ON P.Line = B.line_id
                    JOIN dbo.MST_LineCategory C ON P.ProductCategory = C.category_id
                    JOIN dbo.MST_LineCatBrands D ON P.ProductBrand = D.brand_id
                    WHERE
                        (@Plant_Name IS NULL OR P.PlantName = @Plant_Name) AND
                        (@Plant_Line IS NULL OR P.Line = @Plant_Line) AND
                        (@Product_Category IS NULL OR P.ProductCategory = @Product_Category) AND
                        (@Product_Brand IS NULL OR P.ProductBrand = @Product_Brand) ";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        // Add parameters for filtering
                        cmd.Parameters.AddWithValue("@Plant_Name", string.IsNullOrEmpty(DDL_Plant.SelectedValue) || DDL_Plant.SelectedValue == "0" ? (object)DBNull.Value: Convert.ToInt32(DDL_Plant.SelectedValue));
                        cmd.Parameters.AddWithValue("@Plant_Line", string.IsNullOrEmpty(DDL_PlantLine.SelectedValue) || DDL_PlantLine.SelectedValue == "0" ? (object)DBNull.Value : Convert.ToInt32(DDL_PlantLine.SelectedValue));
                        cmd.Parameters.AddWithValue("@Product_Category", string.IsNullOrEmpty(DDL_ProductCategory.SelectedValue) || DDL_ProductCategory.SelectedValue == "0" ? (object)DBNull.Value : Convert.ToInt32(DDL_ProductCategory.SelectedValue));
                        cmd.Parameters.AddWithValue("@Product_Brand", string.IsNullOrEmpty(DDL_ProductBrand.SelectedValue) || DDL_ProductBrand.SelectedValue == "0" ? (object)DBNull.Value : Convert.ToInt32(DDL_ProductBrand.SelectedValue));

                        cmd.CommandType = CommandType.Text;

                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            System.Data.DataTable dt = new System.Data.DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                // Bind filtered data to GridView
                                GridView1.DataSource = dt;
                                GridView1.DataBind();
                            }
                            else
                            {
                                // Handle empty result
                                GridView1.DataSource = null;
                                GridView1.DataBind();
                                Response.Write("<script>alert('No data found for the selected filters.');</script>");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }
        }


    }
}

