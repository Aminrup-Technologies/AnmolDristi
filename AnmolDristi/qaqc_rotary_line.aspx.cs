using AnmolDristi.DAL;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace AnmolDristi
{
    public partial class qaqc_rotary_line : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        public static String RLWt = String.Empty;
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

                    lbl_docname.Text = "Roatary Line & Oven End Report";
                    lbl_docnumber.Text = "ANMOL/DOC/CORQ/QA/02";
                    PlantBinder();
                    //HiddenField1.Value = "0";
                    //ShowInputBox(0);

                    // BindGridView(30);
                    //BindGridView1(3);
                    //LoadGridData();
                    //GridBinder(3);
                    GridBinder1(10);
                    GridBinder(10);
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
        }


        protected void Btn_Save_Click(object sender, EventArgs e)
        {
            // Validate and save the data
            SaveData();
        }
        private void SaveData()
        {
            // Get values from the UI controls
            string plantName = DDL_Plant.SelectedValue;
            string plantLine = DDL_PlantLine.SelectedValue;
            string productCategory = DDL_ProductCategory.SelectedValue;
            string productBrand = DDL_ProductBrand.SelectedValue;
            string brandSKU = DDL_BrandSKU.SelectedValue;
            string varietyPacket = TB_VartyPkt.Text;
            string shift = GetCurrentShift();  // Automatically get the current shift



            string insertQuery = @"
        INSERT INTO BasicRl_Data_Table (
            PlantId, [Line], ProductCategory, ProductBrand, SKUID, [Date], [Shift], [Time], 
            [RLWT], [Variety], [CreatedBy], 
            [LEVEL1_APPROVER_ID], [LEVEL1_APPROVER_NAME], [LEVEL1_APPROVER_STATUS], [LEVEL1_APPROVER_TIMESTAMP], 
            [LEVEL2_APPROVER_ID], [LEVEL2_APPROVER_NAME], [LEVEL2_APPROVER_STATUS], [LEVEL2_APPROVER_TIMESTAMP], 
            [LEVEL3_APPROVER_ID], [LEVEL3_APPROVER_NAME], [LEVEL3_APPROVER_STATUS], [LEVEL3_APPROVER_TIMESTAMP]
        ) VALUES (
            @PlantId, @Line, @ProductCategory, @ProductBrand, @SKUID, @Date, @Shift, @Time, 
            @RLWT, @Variety, @CreatedBy, 
            @LEVEL1_APPROVER_ID, @LEVEL1_APPROVER_NAME, @LEVEL1_APPROVER_STATUS, @LEVEL1_APPROVER_TIMESTAMP, 
            @LEVEL2_APPROVER_ID, @LEVEL2_APPROVER_NAME, @LEVEL2_APPROVER_STATUS, @LEVEL2_APPROVER_TIMESTAMP, 
            @LEVEL3_APPROVER_ID, @LEVEL3_APPROVER_NAME, @LEVEL3_APPROVER_STATUS, @LEVEL3_APPROVER_TIMESTAMP
        );";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                    {
                        // Set parameters for the SQL command
                        insertCommand.Parameters.AddWithValue("@PlantId", plantName);
                        insertCommand.Parameters.AddWithValue("@Line", plantLine);
                        insertCommand.Parameters.AddWithValue("@ProductCategory", productCategory);
                        insertCommand.Parameters.AddWithValue("@ProductBrand", productBrand);
                        insertCommand.Parameters.AddWithValue("@SKUID", brandSKU);
                        insertCommand.Parameters.AddWithValue("@Date", DateTime.Now.Date);
                        insertCommand.Parameters.AddWithValue("@Shift", shift);  // Assuming a default shift 'A'
                        insertCommand.Parameters.AddWithValue("@Time", DateTime.Now.TimeOfDay);
                        insertCommand.Parameters.AddWithValue("@RLWT", GenerateUniqueRLWT01());  // Generate unique value
                        insertCommand.Parameters.AddWithValue("@Variety", varietyPacket);
                        insertCommand.Parameters.AddWithValue("@CreatedBy", DBNull.Value);  // Replace with actual user ID
                        insertCommand.Parameters.AddWithValue("@LEVEL1_APPROVER_ID", DBNull.Value);
                        insertCommand.Parameters.AddWithValue("@LEVEL1_APPROVER_NAME", DBNull.Value);
                        insertCommand.Parameters.AddWithValue("@LEVEL1_APPROVER_STATUS", DBNull.Value);
                        insertCommand.Parameters.AddWithValue("@LEVEL1_APPROVER_TIMESTAMP", DBNull.Value);
                        insertCommand.Parameters.AddWithValue("@LEVEL2_APPROVER_ID", DBNull.Value);
                        insertCommand.Parameters.AddWithValue("@LEVEL2_APPROVER_NAME", DBNull.Value);
                        insertCommand.Parameters.AddWithValue("@LEVEL2_APPROVER_STATUS", DBNull.Value);
                        insertCommand.Parameters.AddWithValue("@LEVEL2_APPROVER_TIMESTAMP", DBNull.Value);
                        insertCommand.Parameters.AddWithValue("@LEVEL3_APPROVER_ID", DBNull.Value);
                        insertCommand.Parameters.AddWithValue("@LEVEL3_APPROVER_NAME", DBNull.Value);
                        insertCommand.Parameters.AddWithValue("@LEVEL3_APPROVER_STATUS", DBNull.Value);
                        insertCommand.Parameters.AddWithValue("@LEVEL3_APPROVER_TIMESTAMP", DBNull.Value);

                        // Open the connection and execute the command
                        connection.Open();
                        insertCommand.ExecuteNonQuery();

                        lblMessage.Text = "Data saved successfully!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "SwitchTab", "document.getElementById('rawBiscuts-tab').click();", true);

                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception
                lblMessage.Text = "An error occurred: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        private string GenerateUniqueRLWT01()
        {

            string newRlValue;
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // Fetch the maximum RLW01 value
                    string query = "SELECT ISNULL(MAX(CAST(SUBSTRING(RLWT, 4, LEN(RLWT)) AS INT)), 0) FROM BasicRl_Data_Table";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        object result = command.ExecuteScalar();
                        int maxRlValue = Convert.ToInt32(result);

                        // Increment the numeric part
                        int numericPart = maxRlValue + 1;

                        // Format the new value
                        newRlValue = $"RLW{numericPart:D3}"; // Ensure three digits (e.g., RLW001, RLW002)
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Console.WriteLine("Error generating RLW01: " + ex.Message);
                throw;
            }

            RLWt = newRlValue;
            return newRlValue;
        }

        private string GetCurrentShift()
        {
            TimeSpan currentTime = DateTime.Now.TimeOfDay;

            // Define shift times
            TimeSpan shiftAStart = new TimeSpan(6, 0, 0);  // 06:00 AM
            TimeSpan shiftAEnd = new TimeSpan(14, 0, 0);   // 02:00 PM
            TimeSpan shiftBStart = new TimeSpan(14, 0, 0); // 02:00 PM
            TimeSpan shiftBEnd = new TimeSpan(22, 0, 0);   // 10:00 PM
            TimeSpan shiftCStart = new TimeSpan(22, 0, 0); // 10:00 PM
            TimeSpan shiftCEnd = new TimeSpan(6, 0, 0);    // 06:00 AM (next day)

            // Determine the current shift based on time
            if (currentTime >= shiftAStart && currentTime < shiftAEnd)
            {
                return "A";  // Morning Shift
            }
            else if (currentTime >= shiftBStart && currentTime < shiftBEnd)
            {
                return "B";  // Afternoon Shift
            }
            else if (currentTime >= shiftCStart || currentTime < shiftCEnd)
            {
                return "C";  // Night Shift
            }

            return "Unknown";
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            //// Clear all the controls
            DDL_Plant.SelectedIndex = 0;
            DDL_PlantLine.SelectedIndex = 0;
            DDL_ProductCategory.SelectedIndex = 0;
            DDL_ProductBrand.SelectedIndex = 0;
            DDL_BrandSKU.SelectedIndex = 0;
            TB_VartyPkt.Text = string.Empty;
            lblMessage.Text = string.Empty;
        }

        /// <summary>
        /// Raw wt line rpt
        /// </summary>

        private void GridBinder1(int rowCount)
        {
            DataTable dt = new DataTable();

            // Create columns
            dt.Columns.Add("Sl", typeof(int)); // Serial number column
            dt.Columns.Add("stlWeightValue", typeof(decimal)); // Column for stl weight values
            dt.Columns.Add("edlWeightValue", typeof(decimal)); // Column for edl weight values

            for (int i = 1; i <= rowCount; i++)
            {
                DataRow dr = dt.NewRow();
                dr["Sl"] = i; // Serial number
                dt.Rows.Add(dr);
            }

            GridView2.DataSource = dt;
            GridView2.DataBind();
        }

        protected void btn_rawSubmit_Click(object sender, EventArgs e)
        {
            // Assuming stlweightData and edlweightData are for different columns.
            Dictionary<int, decimal> stlweightData = new Dictionary<int, decimal>();
            Dictionary<int, decimal> edlweightData = new Dictionary<int, decimal>();

            foreach (GridViewRow row in GridView2.Rows)
            {
                TextBox txtStlWeight = (TextBox)row.FindControl("txtStlWeight");
                TextBox txtEdlWeight = (TextBox)row.FindControl("txtEdlWeight");

                if (txtStlWeight != null && !string.IsNullOrEmpty(txtStlWeight.Text))
                {
                    decimal stlweight;
                    if (decimal.TryParse(txtStlWeight.Text, out stlweight))
                    {
                        int sl = row.RowIndex + 1;  // Serial number
                        stlweightData[sl] = stlweight;
                    }
                }

                if (txtEdlWeight != null && !string.IsNullOrEmpty(txtEdlWeight.Text))
                {
                    decimal edlweight;
                    if (decimal.TryParse(txtEdlWeight.Text, out edlweight))
                    {
                        int sl = row.RowIndex + 1;  // Serial number
                        edlweightData[sl] = edlweight;
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SwitchTab", "document.getElementById('ovenReport-tab').click();", true);

            }

            // Combine data into a single JSON object
            var combinedData = new
            {
                stlWeights = stlweightData,
                edlWeights = edlweightData
            };

            string jsonData = JsonConvert.SerializeObject(combinedData);

            // Update the database
            UpdatelinewtInDatabase(jsonData);
            //GridView2.Visible = false;
        }


        private void UpdatelinewtInDatabase(string jsonData)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = "UPDATE BasicRl_Data_Table SET stlwt = @stlwt WHERE RLWt = @RLWt";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@stlwt", jsonData);
                    cmd.Parameters.AddWithValue("@RLWt", RLWt); // Assuming RLWt is the primary key or unique identifier

                    cmd.ExecuteNonQuery();
                }

                // Switch to a different tab using JavaScript

            }
        }




        protected void btn_rawrest_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridView2.Rows)
            {
                TextBox txtStlWeight = (TextBox)row.FindControl("txtStlWeight");
                TextBox txtEdlWeight = (TextBox)row.FindControl("txtEdlWeight");

                if (txtStlWeight != null)
                {
                    txtStlWeight.Text = string.Empty; // Clear STL weight text
                }

                if (txtEdlWeight != null)
                {
                    txtEdlWeight.Text = string.Empty; // Clear EDL weight text
                }
            }

            // Optionally, you can rebind the GridView to ensure it reflects the cleared state
            // GridBinder1(GridView2.Rows.Count); // Adjust the rowCount as necessary
        }



        /// <summary>
        /// Oven wt rpt
        /// </summary>


        private void GridBinder(int rowCount)
        {
            DataTable dt = new DataTable();

            // Create columns: Sl, GaugeLengthValue, WeightValue
            dt.Columns.Add("Sl", typeof(int));
            dt.Columns.Add("GaugeLengthValue", typeof(decimal));
            dt.Columns.Add("WeightValue", typeof(decimal));

            for (int i = 1; i <= rowCount; i++)
            {
                DataRow dr = dt.NewRow();
                dr["Sl"] = i; // Serial number
                dt.Rows.Add(dr);
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnOvenSubmit_Click(object sender, EventArgs e)
        {
            var gaugeLengthData = new Dictionary<int, decimal>();
            var weightData = new Dictionary<int, decimal>();

            foreach (GridViewRow row in GridView1.Rows)
            {
                TextBox txtGaugeLength = (TextBox)row.FindControl("txtGaugeLength");
                TextBox txtWeight = (TextBox)row.FindControl("txtWeight");

                if (txtGaugeLength != null && !string.IsNullOrEmpty(txtGaugeLength.Text))
                {
                    decimal gaugeLength;
                    if (decimal.TryParse(txtGaugeLength.Text, out gaugeLength))
                    {
                        int sl = row.RowIndex + 1;  // Serial number
                        gaugeLengthData[sl] = gaugeLength;
                    }
                }

                if (txtWeight != null && !string.IsNullOrEmpty(txtWeight.Text))
                {
                    decimal weight;
                    if (decimal.TryParse(txtWeight.Text, out weight))
                    {
                        int sl = row.RowIndex + 1;  // Serial number
                        weightData[sl] = weight;
                    }
                }
            }

            // Combine data into a single JSON object
            var combinedData = new
            {
                GaugeLengths = gaugeLengthData,
                Weights = weightData
            };

            string jsonData = JsonConvert.SerializeObject(combinedData);

            // Update existing records in the database
            UpdateWeightsInDatabase(jsonData);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "SwitchTab", "document.getElementById('GrossWeightData-tab').click();", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SwitchTab", "document.getElementById('basicData-tab').click();", true);
            //GridView1.Visible=false;
        }

        private void UpdateWeightsInDatabase(string jsonData)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = "UPDATE BasicRl_Data_Table SET edlwt = @edlwt WHERE RLWt = @RLWt";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@edlwt", jsonData);
                    cmd.Parameters.AddWithValue("@RLWt", RLWt); // Primary key or unique identifier

                    cmd.ExecuteNonQuery();
                }

                // Optional: Switch to a different tab using JavaScript

            }
        }

        protected void btn_ovenrest_Click(object sender, EventArgs e)
        {
            // Iterate through each row of the GridView
            foreach (GridViewRow row in GridView1.Rows)
            {
                // Find the TextBox controls in the current row
                TextBox txtGaugeLength = (TextBox)row.FindControl("txtGaugeLength");
                TextBox txtWeight = (TextBox)row.FindControl("txtWeight");

                // Check if the TextBox for Gauge Length exists and clear its content
                if (txtGaugeLength != null)
                {
                    txtGaugeLength.Text = string.Empty; // Clear Gauge Length text
                }

                // Check if the TextBox for Weight exists and clear its content
                if (txtWeight != null)
                {
                    txtWeight.Text = string.Empty; // Clear Weight text
                }
            }

            // Optional: Rebind the GridView to refresh its state if needed
            // You might want to keep the same number of rows or reset to a default state
            // GridBinder(GridView1.Rows.Count); // Uncomment if you need to rebind with the same number of rows
        }

    }
}


