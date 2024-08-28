using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static AnmolDristi.qaqc.qaqc_inspector_rpt;
using Newtonsoft.Json;

namespace AnmolDristi
{
    public partial class ccp_checklist : System.Web.UI.Page
    {
        public static string M_CheckId_key= String.Empty;
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
                    lbl_docname.Text = "CCP CHECKLIST: MD, SS";
                    lbl_docnumber.Text = "ANMOL/DOC/CORP/QA/03";
                    PlantBinder();
                    BindGridView(9);
                }
            }
        }

        private void BindGridView(int rowCount)
        {
            DataTable dt = new DataTable();

            // Create columns: LineNo, Sl, Qty of Metal Found(gm), CleanedStatus, Remarks for not ok
            dt.Columns.Add("Sl");
            dt.Columns.Add("Location");         
            dt.Columns.Add("Qty of Metal Found(gm)");
            dt.Columns.Add("CleanedStatus");
            dt.Columns.Add("Remarks for not ok");

            // List of elements for the LineNo column
            List<string> Location = new List<string>
                {
                    "Maida 1", "Maida 2", "Maida 3", "Maida 4", "Maida 5",
                    "Sugar 1", "Sugar 2", "Broken Biscuit 1", "Broken Biscuit 2"
                };

            for (int i = 0; i < rowCount; i++)
            {
                DataRow dr = dt.NewRow();
                dr["Sl"] = i + 1; // Serial number (Sl)

                // Assign LineNo value cyclically if rowCount exceeds the number of items in lineNumbers
                dr["Location"] = Location[i % Location.Count];

                dt.Rows.Add(dr);
            }

            GridView_MetalCheck.DataSource = dt;
            GridView_MetalCheck.DataBind();
        }



        //protected void SaveData()
        //{
        //    // Get the current shift
        //    string shift = GetCurrentShift();

        //    foreach (GridViewRow row in GridView_MetalCheck.Rows)
        //    {  
        //        // Find controls in the current row
        //        Label lblLineName = (Label)row.FindControl("Label_LineName");
        //        TextBox txtQtyMetalFound = (TextBox)row.FindControl("TB_QtyMetalFound");
        //        RadioButtonList rblCleanedStatus = (RadioButtonList)row.FindControl("RBL_CleanedStatus");
        //        TextBox txtRemarks = (TextBox)row.FindControl("TXB_CleanedStatusRemarks");

        //        // Extract values
        //        string lineName = lblLineName.Text;
        //        decimal qtyMetalFound = string.IsNullOrEmpty(txtQtyMetalFound.Text) ? 0 : Convert.ToDecimal(txtQtyMetalFound.Text);
        //        bool cleanedStatus = rblCleanedStatus.SelectedValue == "1"; // "Ok" = 1, "Not Ok" = 0
        //        string remarks = txtRemarks.Text;

        //        // Define your other parameters
        //        string ccpId = GetNextCcpId(); // Generate CCP ID value
        //        DateTime date = DateTime.Now; // Use current date
        //        int lineNo = GetLineNo(lineName); // Map LineName to LineNo

        //        // SQL query to insert into the database
        //        string query = "INSERT INTO Metal_Check_Table (CcpId, LineNo, Date, Shift, QtyOfMetalFound, CleanedStatus, RemarksForCleanedStatus) " +
        //                       "VALUES (@CcpId, @LineNo, @Date, @Shift, @QtyOfMetalFound, @CleanedStatus, @RemarksForCleanedStatus)";

        //        using (SqlConnection conn = new SqlConnection("your_connection_string_here"))
        //        {
        //            using (SqlCommand cmd = new SqlCommand(query, conn))
        //            {
        //                cmd.Parameters.AddWithValue("@CcpId", ccpId);
        //                cmd.Parameters.AddWithValue("@LineNo", lineNo);
        //                cmd.Parameters.AddWithValue("@Date", date);
        //                cmd.Parameters.AddWithValue("@Shift", shift);
        //                cmd.Parameters.AddWithValue("@QtyOfMetalFound", qtyMetalFound);
        //                cmd.Parameters.AddWithValue("@CleanedStatus", cleanedStatus);
        //                cmd.Parameters.AddWithValue("@RemarksForCleanedStatus", remarks);

        //                conn.Open();
        //                cmd.ExecuteNonQuery();
        //                conn.Close();
        //            }
        //        }
        //    }
        //}

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridView_MetalCheck.Rows)
            {
                // Get controls in each row
                Label lblLineNo = (Label)row.FindControl("lblLineNo"); // Assuming LineNo is a label
                TextBox txtQtyOfMetalFound = (TextBox)row.FindControl("txtQtyOfMetalFound");
                RadioButtonList rblCleanedStatus = (RadioButtonList)row.FindControl("rblCleanedStatus");
                TextBox txtRemarks = (TextBox)row.FindControl("txtRemarks");

                if (lblLineNo != null && txtQtyOfMetalFound != null && rblCleanedStatus != null)
                {
                    string lineNo = lblLineNo.Text;
                    decimal qtyOfMetalFound = decimal.Parse(txtQtyOfMetalFound.Text);
                    string cleanedStatus = rblCleanedStatus.SelectedValue;
                    string remarks = cleanedStatus == "Not Ok" ? txtRemarks.Text : null;

                    int sl = row.RowIndex + 1;  // Serial number (Sl)
                    int mCheckId = GetMCheckIdBySerialNumber(sl); // Retrieve the M_CheckId based on the Sl

                    UpdateMetalCheckRecord(mCheckId, lineNo, qtyOfMetalFound, cleanedStatus, remarks);
                }
            }
        }

        // Method to retrieve M_CheckId based on serial number (Sl)
        private int GetMCheckIdBySerialNumber(int serialNumber)
        {
            // Implement your logic to retrieve the M_CheckId based on serial number
            // For example, you might query the database to get the M_CheckId
            // based on some criteria related to the serial number
            // Example:
            // SELECT M_CheckId FROM Metal_Check_Table WHERE Row_Number = @serialNumber
            return serialNumber; // This is a placeholder. Replace it with your actual retrieval logic.
        }

        // Method to update the Metal_Check_Table record
        private void UpdateMetalCheckRecord(int M_CheckId_key, string lineNo, decimal qtyOfMetalFound, string cleanedStatus, string remarks)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = @"
            UPDATE Metal_Check_Table
            SET LineNo = @LineNo, 
                QtyOfMetalFound = @QtyOfMetalFound, 
                CleanedStatus = @CleanedStatus, 
                RemarksForCleanedStatus = @Remarks
            WHERE M_CheckId = @MCheckId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@LineNo", lineNo);
                    cmd.Parameters.AddWithValue("@QtyOfMetalFound", qtyOfMetalFound);
                    cmd.Parameters.AddWithValue("@CleanedStatus", cleanedStatus);
                    cmd.Parameters.AddWithValue("@Remarks", (object)remarks ?? DBNull.Value); // Use DBNull.Value if remarks are null
                    cmd.Parameters.AddWithValue("@MCheckId", M_CheckId_key);

                    cmd.ExecuteNonQuery();
                }
            }
        }
        private string GenerateUniqueM_CheckId()
        {
            string M_CheckId_key;
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Fetch the maximum numeric part of M_CheckId safely
                    string query = @"
            SELECT ISNULL(MAX(CAST(SUBSTRING(M_CheckId, 8, LEN(M_CheckId) - 7) AS INT)), 0) 
            FROM Metal_Check_Table
            WHERE LEN(M_CheckId) >= 8 AND ISNUMERIC(SUBSTRING(M_CheckId, 8, LEN(M_CheckId) - 7)) = 1";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        object result = command.ExecuteScalar();
                        int maxNumericValue = Convert.ToInt32(result);

                        // Increment the numeric part
                        int numericPart = maxNumericValue + 1;

                        // Format the new value
                        M_CheckId_key = $"M_Check{numericPart:D3}"; // Ensures format like M_Check001, M_Check002
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Console.WriteLine("Error generating M_CheckId: " + ex.Message);
                throw;
            }

            return M_CheckId_key;
        }




        private int GetLineNo(string lineName)
        {
            // Implement mapping logic for LineName to LineNo
            switch (lineName)
            {
                case "Maida 1": return 1;
                case "Maida 2": return 2;
                case "Maida 3": return 3;
                case "Maida 4": return 4;
                case "Maida 5": return 5;
                case "Sugar 1": return 6;
                case "Sugar 2": return 7;
                case "Broken Biscuit 1": return 8;
                case "Broken Biscuit 2": return 9;
                default: return 0;
            }
        }


        private string GetNextCcpId()
        {
            // Logic to generate the next CCP ID
            // Assuming it follows the format 00001, 00002, 00003, etc.
            int nextId = 1; // Fetch the last ID from the database and increment
            return nextId.ToString("D5"); // Format as 00001, 00002, etc.
        }

        protected void RBL_CleanedStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            RadioButtonList rbl = (RadioButtonList)sender;
            GridViewRow row = (GridViewRow)rbl.NamingContainer;
            TextBox txtRemarks = (TextBox)row.FindControl("TXB_CleanedStatusRemarks");

            if (rbl.SelectedValue == "0") // "Not Ok"
            {
                txtRemarks.Style["display"] = "block";
            }
            else
            {
                txtRemarks.Style["display"] = "none";
            }
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
        protected void DDL_Plant_QtyOfMetal_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Handle the event here
            // Example: Update related controls or process the selected value
            string selectedValue = ((DropDownList)sender).SelectedValue;
            // Perform necessary actions based on the selected value
        }

        protected void DDL_Plant_MetalCheck_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void RBL_FF_Status_SelectedIndexChanged(object sender, EventArgs e)
        {
           // TB_FF_Remarks.Visible = RBL_FF_Status.SelectedValue == "Sensing";
        }

        protected void RBL_NFE_Status_SelectedIndexChanged(object sender, EventArgs e)
        {
            //TB_NFE_Remarks.Visible = RBL_NFE_Status.SelectedValue == "Sensing";
        }

        protected void RBL_SS_Status_SelectedIndexChanged(object sender, EventArgs e)
        {
            //TB_SS_Remarks.Visible = RBL_SS_Status.SelectedValue == "Sensing";
        }
        

        
        protected void btnBDSave_Click(object sender, EventArgs e)
        {
            // Retrieve values from controls
            string plantName = DDL_Plant.SelectedValue;
            string line = DDL_PlantLine.SelectedValue;
            string productCategory = DDL_ProductCategory.SelectedValue;
            string productBrand = DDL_ProductBrand.SelectedValue; // Assuming DDL_ProductBrand is a DropDownList
            string brandSKU = DDL_BrandSKU.SelectedValue;
            string shift = GetCurrentShift();  // Automatically get the current shift

            

            // Generate a new CcpId
            string ccpId = GenerateUniqueCcpId();

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string insertQuery = @"
        INSERT INTO Basic_Data_Ccp (
            PlantId, [Line], ProductCategory, ProductBrand, SKUID, CcpId, [Date], [Shift], [Time], 
            [CreatedBy], [LEVEL1_APPROVER_ID], [LEVEL1_APPROVER_NAME], [LEVEL1_APPROVER_STATUS], [LEVEL1_APPROVER_TIMESTAMP], 
            [LEVEL2_APPROVER_ID], [LEVEL2_APPROVER_NAME], [LEVEL2_APPROVER_STATUS], [LEVEL2_APPROVER_TIMESTAMP], 
            [LEVEL3_APPROVER_ID], [LEVEL3_APPROVER_NAME], [LEVEL3_APPROVER_STATUS], [LEVEL3_APPROVER_TIMESTAMP]
        ) VALUES (
            @PlantId, @Line, @ProductCategory, @ProductBrand, @SKUID, @CcpId, @Date, @Shift, @Time, 
            @CreatedBy, @LEVEL1_APPROVER_ID, @LEVEL1_APPROVER_NAME, @LEVEL1_APPROVER_STATUS, @LEVEL1_APPROVER_TIMESTAMP, 
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
                        insertCommand.Parameters.AddWithValue("@Line", line);
                        insertCommand.Parameters.AddWithValue("@ProductCategory", productCategory);
                        insertCommand.Parameters.AddWithValue("@ProductBrand", productBrand);
                        insertCommand.Parameters.AddWithValue("@SKUID", brandSKU);
                        insertCommand.Parameters.AddWithValue("@CcpId", ccpId);
                        insertCommand.Parameters.AddWithValue("@Date", DateTime.Now.Date);
                        insertCommand.Parameters.AddWithValue("@Shift", shift );  
                        insertCommand.Parameters.AddWithValue("@Time", DateTime.Now.TimeOfDay);
                        insertCommand.Parameters.AddWithValue("@CreatedBy", Session["USERID"]?.ToString() ?? "Unknown");

                        // Approver fields
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


                        // Redirect to the Metal_Check section
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "SwitchTab", "document.getElementById('Metal_Check-tab').click();", true);

                        // Make the inputs read-only
                        MakeInputsReadOnly();
                    }
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
                                     "}});\n" +
                                     "</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowErrorNotification", errorScript, false);
            }

        }

        private string GenerateUniqueCcpId()
        {
            string newCcpId;
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // Fetch the maximum CcpId value
                    string query = "SELECT ISNULL(MAX(CAST(CcpId AS INT)), 0) FROM Basic_Data_Ccp";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        object result = command.ExecuteScalar();
                        int maxCcpId = Convert.ToInt32(result);

                        // Increment the numeric part
                        int numericPart = maxCcpId + 1;

                        // Format the new value
                        newCcpId = $"{numericPart:D5}"; // Ensure five digits (e.g., 00001, 00002)
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Console.WriteLine("Error generating CcpId: " + ex.Message);
                throw;
            }

            return newCcpId;
        }

        private void MakeInputsReadOnly()
        {
            // Disable all input controls
            DDL_Plant.Enabled = false;
            DDL_PlantLine.Enabled = false;
            DDL_ProductCategory.Enabled = false;
            DDL_ProductBrand.Enabled = false;
           

            btnBDSave.Enabled = false;
            btnBDSave.Text = "SAVED";
            btnBDSave.CssClass = "btn btn-sm btn-success";

            string successScript = @"<script type='text/javascript'>
                    new PNotify({
                        title: 'Data Success',
                        text: 'Recorded Successfully!!',
                        type: 'success',
                        styling: 'bootstrap3'
                    });
                </script>";

            // Register the JavaScript code to show success notification
            ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", successScript, false);
        }

        protected void btnBDReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("ccp_checklist.aspx");
        }

        
    }
}  