using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using static AnmolDristi.qaqc.qaqc_inspector_rpt;
using Newtonsoft.Json;

namespace AnmolDristi
{
    public partial class qa_qc_FinalCbbWtReport : System.Web.UI.Page
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

                    lbl_docname.Text = "FINAL CBB WEIGHT CHECKLIST";
                    lbl_docnumber.Text = "ANMOL/DOC/CORP/QA/08";
                    PlantBinder();
                    GridBinder(10);
                }
            }
        }

        private void GridBinder(int rowCount)
        {
            DataTable dt = new DataTable();

            // Create two columns: Sl and GrossWeightValue
            dt.Columns.Add("Sl");
            dt.Columns.Add("GrossWeightValue");

            for (int i = 1; i <= rowCount; i++)
            {
                DataRow dr = dt.NewRow();
                dr["Sl"] = i; // Serial number (Sl)
                dt.Rows.Add(dr);
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Dictionary<int, decimal> grossWeightData = new Dictionary<int, decimal>();
            foreach (GridViewRow row in GridView1.Rows)
            {
                TextBox txtGrossWeight = (TextBox)row.FindControl("txtGrossWeight");

                if (txtGrossWeight != null && !string.IsNullOrEmpty(txtGrossWeight.Text))
                {
                    decimal grossWeight;
                    if (decimal.TryParse(txtGrossWeight.Text, out grossWeight))
                    {
                        int sl = row.RowIndex + 1;  // Serial number
                        grossWeightData.Add(sl, grossWeight);
                    }
                }
            }
            string jsonData = JsonConvert.SerializeObject(grossWeightData);

            // Insert into the database
            //using (SqlConnection conn = new SqlConnection(connectionString))
            //{
            //    conn.Open();
            //    string query = "INSERT INTO YourTable (GrossWeightJson) VALUES (@jsonString)";
            //    using (SqlCommand cmd = new SqlCommand(query, conn))
            //    {
            //        cmd.Parameters.AddWithValue("@jsonString", jsonData);
            //        cmd.ExecuteNonQuery();
            //    }
            //}

            // Now, save the JSON data to the database
            //SaveGrossWeightsToDatabase(jsonData);

            PopulateGridView(jsonData);
        }

        private void PopulateGridView(string jsonString)
        {
            //string jsonString = "";

            // Retrieve the JSON string from the database
            //using (SqlConnection conn = new SqlConnection(connectionString))
            //{
            //    conn.Open();
            //    string query = "SELECT GrossWeightJson FROM YourTable WHERE Id = @id";
            //    using (SqlCommand cmd = new SqlCommand(query, conn))
            //    {
            //        cmd.Parameters.AddWithValue("@id", yourId);
            //        jsonString = cmd.ExecuteScalar()?.ToString();
            //    }
            //}

            // Deserialize the JSON string into a dictionary
            Dictionary<string, decimal> grossWeightData = JsonConvert.DeserializeObject<Dictionary<string, decimal>>(jsonString);

            // Create a DataTable and populate it with data from the dictionary
            DataTable dataTable = new DataTable();
            dataTable.Columns.Add("SlNo", typeof(string));
            dataTable.Columns.Add("GrossWeight", typeof(decimal));

            foreach (var item in grossWeightData)
            {
                DataRow row = dataTable.NewRow();
                row["SlNo"] = item.Key;
                row["GrossWeight"] = item.Value;
                dataTable.Rows.Add(row);
            }

            // Bind the DataTable to the GridView
            yourGridView.DataSource = dataTable;
            yourGridView.DataBind();
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
                    SetUpValidatorsForField(fieldName, criteria);
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

        private void SetUpValidatorsForField(string fieldName, ValidationCriteria criteria)
        {
            //switch (fieldName)
            //{
            //    //case "no_of_pcs":

            //    //    RFV_TB_NoOfPcs.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    RFV_TB_NoOfPcs.Enabled = criteria.IsRequired;

            //    //    TB_NoOfPcs.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    REV_TB_NoOfPcs.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    REV_TB_NoOfPcs.ValidationExpression = criteria.RegularExpression;
            //    //    REV_TB_NoOfPcs.Enabled = criteria.IsRegularExpressionRequired;

            //    //    RV_TB_NoOfPcs.ErrorMessage = criteria.RangeErrorMessage;
            //    //    RV_TB_NoOfPcs.MinimumValue = criteria.MinimumValue;
            //    //    RV_TB_NoOfPcs.MaximumValue = criteria.MaximumValue;
            //    //    RV_TB_NoOfPcs.Enabled = criteria.IsRangeRequired;

            //    //    //hdnMinNoOfPcs.Value = criteria.MinimumValue.ToString();
            //    //    //hdnMaxNoOfPcs.Value = criteria.MaximumValue.ToString();

            //    //    break;

            //    //case "GaugeVal":

            //    //    //RFV_TB_GaugeVal.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    //RFV_TB_GaugeVal.Enabled = criteria.IsRequired;

            //    //    //TB_GaugeVal.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    //REV_TB_GaugeVal.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    //REV_TB_GaugeVal.ValidationExpression = criteria.RegularExpression;
            //    //    //REV_TB_GaugeVal.Enabled = criteria.IsRegularExpressionRequired;

            //    //    //RV_TB_GaugeVal.ErrorMessage = criteria.RangeErrorMessage;
            //    //    //RV_TB_GaugeVal.MinimumValue = criteria.MinimumValue;
            //    //    //RV_TB_GaugeVal.MaximumValue = criteria.MaximumValue;
            //    //    //RV_TB_GaugeVal.Enabled = criteria.IsRangeRequired;
            //    //    break;

            //    //case "DryWeight":

            //    //    //RFV_TB_DryWeight.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    //RFV_TB_DryWeight.Enabled = criteria.IsRequired;

            //    //    //TB_DryWeight.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    //REV_TB_DryWeight.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    //REV_TB_DryWeight.ValidationExpression = criteria.RegularExpression;
            //    //    //REV_TB_DryWeight.Enabled = criteria.IsRegularExpressionRequired;

            //    //    ////RV_TB_DryWeight.ErrorMessage = criteria.RangeErrorMessage;
            //    //    ////RV_TB_DryWeight.MinimumValue = criteria.MinimumValue;
            //    //    ////RV_TB_DryWeight.MaximumValue = criteria.MaximumValue;
            //    //    ////RV_TB_DryWeight.Enabled = criteria.IsRangeRequired;
            //    //    break;

            //    //case "DippedWeight":

            //    //    //RFV_TB_DippedWeight.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    //RFV_TB_DippedWeight.Enabled = criteria.IsRequired;

            //    //    //TB_DippedWeight.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    //REV_TB_DippedWeight.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    //REV_TB_DippedWeight.ValidationExpression = criteria.RegularExpression;
            //    //    //REV_TB_DippedWeight.Enabled = criteria.IsRegularExpressionRequired;

            //    //    //RV_TB_DippedWeight.ErrorMessage = criteria.RangeErrorMessage;
            //    //    //RV_TB_DippedWeight.MinimumValue = criteria.MinimumValue;
            //    //    //RV_TB_DippedWeight.MaximumValue = criteria.MaximumValue;
            //    //    //RV_TB_DippedWeight.Enabled = criteria.IsRangeRequired;
            //    //    break;

            //    //case "VartyPkt":

            //    //    RFV_TB_VartyPkt.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    RFV_TB_VartyPkt.Enabled = criteria.IsRequired;

            //    //    TB_VartyPkt.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    REV_TB_VartyPkt.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    REV_TB_VartyPkt.ValidationExpression = criteria.RegularExpression;
            //    //    REV_TB_VartyPkt.Enabled = criteria.IsRegularExpressionRequired;

            //    //    //RV_TB_VartyPkt.ErrorMessage = criteria.RangeErrorMessage;
            //    //    //RV_TB_VartyPkt.MinimumValue = criteria.MinimumValue;
            //    //    //RV_TB_VartyPkt.MaximumValue = criteria.MaximumValue;
            //    //    //RV_TB_VartyPkt.Enabled = criteria.IsRangeRequired;
            //    //    break;

            //    //case "BakingTime":

            //    //    RFV_TB_BakingTime.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    RFV_TB_BakingTime.Enabled = criteria.IsRequired;

            //    //    TB_BakingTime.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    REV_TB_BakingTime.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    REV_TB_BakingTime.ValidationExpression = criteria.RegularExpression;
            //    //    REV_TB_BakingTime.Enabled = criteria.IsRegularExpressionRequired;

            //    //    RV_TB_BakingTime.ErrorMessage = criteria.RangeErrorMessage;
            //    //    RV_TB_BakingTime.MinimumValue = criteria.MinimumValue;
            //    //    RV_TB_BakingTime.MaximumValue = criteria.MaximumValue;
            //    //    RV_TB_BakingTime.Enabled = criteria.IsRangeRequired;

            //    //    hdnMinBakingTime.Value = criteria.MinimumValue.ToString();
            //    //    hdnMaxBakingTime.Value = criteria.MaximumValue.ToString();

            //    //    break;

            //    //case "FlavTst":

            //    //    RFV_RBL_FlavTst.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    RFV_RBL_FlavTst.Enabled = criteria.IsRequired;

            //    //    //RBL_FlavTst.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    //REV_RBL_FlavTst.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    //REV_RBL_FlavTst.ValidationExpression = criteria.RegularExpression;
            //    //    //REV_RBL_FlavTst.Enabled = criteria.IsRegularExpressionRequired;

            //    //    //RV_TB_DippedWeight.ErrorMessage = criteria.RangeErrorMessage;
            //    //    //RV_TB_DippedWeight.MinimumValue = criteria.MinimumValue;
            //    //    //RV_TB_DippedWeight.MaximumValue = criteria.MaximumValue;
            //    //    //RV_TB_DippedWeight.Enabled = criteria.IsRangeRequired;
            //    //    break;

            //    //case "SpSz":

            //    //    RFV_TB_ShapeSize.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    RFV_TB_ShapeSize.Enabled = criteria.IsRequired;

            //    //    TB_ShapeSize.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    REV_TB_ShapeSize.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    REV_TB_ShapeSize.ValidationExpression = criteria.RegularExpression;
            //    //    REV_TB_ShapeSize.Enabled = criteria.IsRegularExpressionRequired;

            //    //    CV_TB_ShapeSize.ErrorMessage = criteria.RangeErrorMessage;
            //    //    //RV_TB_ShapeSize.ErrorMessage = criteria.RangeErrorMessage;
            //    //    //RV_TB_ShapeSize.MinimumValue = criteria.MinimumValue;
            //    //    //RV_TB_ShapeSize.MaximumValue = criteria.MaximumValue;
            //    //    //RV_TB_ShapeSize.Enabled = criteria.IsRangeRequired;

            //    //    hdnMinShapeSize.Value = criteria.MinimumValue.ToString();
            //    //    hdnMaxShapeSize.Value = criteria.MaximumValue.ToString();
            //    //    break;

            //    //case "TextureBite":

            //    //    //RFV_TB_TextureBite.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    //RFV_TB_TextureBite.Enabled = criteria.IsRequired;

            //    //    //TB_TextureBite.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    //REV_TB_TextureBite.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    //REV_TB_TextureBite.ValidationExpression = criteria.RegularExpression;
            //    //    //REV_TB_TextureBite.Enabled = criteria.IsRegularExpressionRequired;

            //    //    //RV_TB_TextureBite.ErrorMessage = criteria.RangeErrorMessage;
            //    //    //RV_TB_TextureBite.MinimumValue = criteria.MinimumValue;
            //    //    //RV_TB_TextureBite.MaximumValue = criteria.MaximumValue;
            //    //    //RV_TB_TextureBite.Enabled = criteria.IsRangeRequired;
            //    //    break;

            //    //case "Moisture":

            //    //    RFV_TB_Moisture.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    RFV_TB_Moisture.Enabled = criteria.IsRequired;

            //    //    TB_Moisture.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    REV_TB_Moisture.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    REV_TB_Moisture.ValidationExpression = criteria.RegularExpression;
            //    //    REV_TB_Moisture.Enabled = criteria.IsRegularExpressionRequired;

            //    //    RV_TB_Moisture.ErrorMessage = criteria.RangeErrorMessage;
            //    //    RV_TB_Moisture.MinimumValue = criteria.MinimumValue;
            //    //    RV_TB_Moisture.MaximumValue = criteria.MaximumValue;
            //    //    RV_TB_Moisture.Enabled = criteria.IsRangeRequired;
            //    //    break;

            //    //case "GaugeLen":

            //    //    RFV_TB_GaugeLen.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    RFV_TB_GaugeLen.Enabled = criteria.IsRequired;

            //    //    TB_GaugeLen.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    REV_TB_GaugeLen.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    REV_TB_GaugeLen.ValidationExpression = criteria.RegularExpression;
            //    //    REV_TB_GaugeLen.Enabled = criteria.IsRegularExpressionRequired;

            //    //    CV_TB_GaugeLen.ErrorMessage = criteria.RangeErrorMessage;
            //    //    //CV_TB_GaugeLen.MinimumValue = criteria.MinimumValue;
            //    //    //RV_TB_GaugeLen.MaximumValue = criteria.MaximumValue;
            //    //    CV_TB_GaugeLen.Enabled = criteria.IsRangeRequired;

            //    //    hdnMinGaugelen.Value = criteria.MinimumValue.ToString();
            //    //    hdnMaxGaugelen.Value = criteria.MaximumValue.ToString();

            //    //    break;

            //    //case "wgtwtoil":
            //    //    //weight without oil or dry weight
            //    //    RFV_TB_wgtwtoil.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    RFV_TB_wgtwtoil.Enabled = criteria.IsRequired;

            //    //    TB_wgtwtoil.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    REV_TB_wgtwtoil.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    REV_TB_wgtwtoil.ValidationExpression = criteria.RegularExpression;
            //    //    REV_TB_wgtwtoil.Enabled = criteria.IsRegularExpressionRequired;

            //    //    RV_TB_wgtwtoil.ErrorMessage = criteria.RangeErrorMessage;
            //    //    RV_TB_wgtwtoil.MinimumValue = criteria.MinimumValue;
            //    //    RV_TB_wgtwtoil.MaximumValue = criteria.MaximumValue;
            //    //    RV_TB_wgtwtoil.Enabled = criteria.IsRangeRequired;
            //    //    break;

            //    //case "wgtwoil":
            //    //    //weight with oil or dipped weight
            //    //    RFV_TB_wgtwoil.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    RFV_TB_wgtwoil.Enabled = criteria.IsRequired;

            //    //    TB_wgtwoil.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    REV_TB_wgtwoil.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    REV_TB_wgtwoil.ValidationExpression = criteria.RegularExpression;
            //    //    REV_TB_wgtwoil.Enabled = criteria.IsRegularExpressionRequired;

            //    //    RV_TB_wgtwoil.ErrorMessage = criteria.RangeErrorMessage;
            //    //    RV_TB_wgtwoil.MinimumValue = criteria.MinimumValue;
            //    //    RV_TB_wgtwoil.MaximumValue = criteria.MaximumValue;
            //    //    RV_TB_wgtwoil.Enabled = criteria.IsRangeRequired;
            //    //    break;

            //    //case "oilpercent":

            //    //    RFV_TB_oilpercent.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    RFV_TB_oilpercent.Enabled = criteria.IsRequired;

            //    //    TB_oilpercent.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    REV_TB_oilpercent.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    REV_TB_oilpercent.ValidationExpression = criteria.RegularExpression;
            //    //    REV_TB_oilpercent.Enabled = criteria.IsRegularExpressionRequired;

            //    //    RV_TB_oilpercent.ErrorMessage = criteria.RangeErrorMessage;
            //    //    RV_TB_oilpercent.MinimumValue = criteria.MinimumValue;
            //    //    RV_TB_oilpercent.MaximumValue = criteria.MaximumValue;
            //    //    RV_TB_oilpercent.Enabled = criteria.IsRangeRequired;
            //    //    break;

            //    //case "PktWgt":

            //    //    RFV_TB_PktWgt.ErrorMessage = criteria.RequiredFieldErrorMessage;
            //    //    RFV_TB_PktWgt.Enabled = criteria.IsRequired;

            //    //    TB_PktWgt.Attributes["placeholder"] = criteria.RangeErrorMessage;

            //    //    REV_TB_PktWgt.ErrorMessage = criteria.RegularExpressionErrorMessage;
            //    //    REV_TB_PktWgt.ValidationExpression = criteria.RegularExpression;
            //    //    REV_TB_PktWgt.Enabled = criteria.IsRegularExpressionRequired;

            //    //    RV_TB_PktWgt.ErrorMessage = criteria.RangeErrorMessage;
            //    //    RV_TB_PktWgt.MinimumValue = criteria.MinimumValue;
            //    //    RV_TB_PktWgt.MaximumValue = criteria.MaximumValue;
            //    //    RV_TB_PktWgt.Enabled = criteria.IsRangeRequired;
            //    //    break;

            //    //    default:
            //    //    // Handle unrecognized field names
            //    //    break;
            //}
        }

        protected void Btn_Reset_Click(object sender, EventArgs e)
        {
            DDL_Plant.SelectedIndex = 0;
            DDL_PlantLine.SelectedIndex = 0;
            DDL_ProductCategory.SelectedIndex = 0;
            DDL_ProductBrand.SelectedIndex = 0;
            DDL_BrandSKU.SelectedIndex = 0;

            //TXT_LineNo.Text = string.Empty;
            //TXT_ProductName.Text = string.Empty;
            TXT_BatchNo.Text = string.Empty;
            //TXT_SlNo.Text = string.Empty;
            TXT_MRP.Text = string.Empty;
            //TXT_GrossWt.Text = string.Empty;

            lblMessage.Text = string.Empty;
        }


        //protected void Btn_Save_Click(object sender, EventArgs e)
        //{

        //}

        //protected void Btn_Save_Click(object sender, EventArgs e)
        //{
        //    // Retrieve selected values from dropdowns
        //    string plantName = DDL_Plant.SelectedValue;
        //    string plantLine = DDL_PlantLine.SelectedValue;
        //    string productCategory = DDL_ProductCategory.SelectedValue;
        //    string productBrand = DDL_ProductBrand.SelectedValue;
        //    string brandSKU = DDL_BrandSKU.SelectedValue;

        //    // Retrieve the LineNo from the TextBox
        //    int lineNo;
        //    if (!int.TryParse(TXT_LineNo.Text, out lineNo))
        //    {
        //        lblMessage.Text = "Please enter a valid Line Number.";
        //        lblMessage.ForeColor = System.Drawing.Color.Red;
        //        return;
        //    }

        //    // Define your connection string
        //    string connectionString = "Data Source=Buddy\\SQLEXPRESS06;Initial Catalog=AnmolDristi;Integrated Security=True;";

        //    // Create and open a connection to the database
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        connection.Open();

        //        // SQL query to insert the data
        //        string insertQuery = "INSERT INTO Basic_Data (PlantId, [Line], ProductCategory, ProductBrand, SKUID, [Date], [Shift], [Time], [LineNo], [ProductName]) " +
        //                             "VALUES (@PlantId, @Line, @ProductCategory, @ProductBrand, @SKUID, @Date, @Shift, @Time, @LineNo, @ProductName)";

        //        using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
        //        {
        //            // Add parameters to the query
        //            insertCommand.Parameters.AddWithValue("@PlantId", plantName);
        //            insertCommand.Parameters.AddWithValue("@Line", plantLine);
        //            insertCommand.Parameters.AddWithValue("@ProductCategory", productCategory);
        //            insertCommand.Parameters.AddWithValue("@ProductBrand", productBrand);
        //            insertCommand.Parameters.AddWithValue("@SKUID", brandSKU);
        //            insertCommand.Parameters.AddWithValue("@Date", DateTime.Now.Date);  // Example: Set current date
        //            insertCommand.Parameters.AddWithValue("@Shift", 'A');  // Example: Set shift
        //            insertCommand.Parameters.AddWithValue("@Time", DateTime.Now.TimeOfDay);  // Example: Set current time
        //            insertCommand.Parameters.AddWithValue("@LineNo", lineNo);  // Use the user-provided LineNo
        //            insertCommand.Parameters.AddWithValue("@ProductName", ProductName);  // Use the user-provided LineNo

        //            try
        //            {
        //                // Execute the query
        //                int result = insertCommand.ExecuteNonQuery();

        //                // Check if the insert was successful
        //                if (result > 0)
        //                {
        //                    lblMessage.Text = "Data saved successfully!";
        //                    lblMessage.ForeColor = System.Drawing.Color.Green;
        //                }
        //                else
        //                {
        //                    lblMessage.Text = "Error saving data.";
        //                    lblMessage.ForeColor = System.Drawing.Color.Red;
        //                }
        //            }
        //            catch (SqlException ex)
        //            {
        //                if (ex.Number == 2627) // SQL error code for unique constraint violation
        //                {
        //                    lblMessage.Text = "Error: Line Number already exists. Please enter a different Line Number.";
        //                }
        //                else
        //                {
        //                    lblMessage.Text = $"Error: {ex.Message}";
        //                }
        //                lblMessage.ForeColor = System.Drawing.Color.Red;
        //            }
        //        }
        //    }

        //}

        protected void Btn_Save_Click(object sender, EventArgs e)
        {
            // Retrieve selected values from dropdowns
            string plantName = DDL_Plant.SelectedValue;
            string plantLine = DDL_PlantLine.SelectedValue;
            string productCategory = DDL_ProductCategory.SelectedValue;
            string productBrand = DDL_ProductBrand.SelectedValue;
            string brandSKU = DDL_BrandSKU.SelectedValue;

            // Retrieve ProductName from appropriate control
            // string productName = TXT_ProductName.Text;  // Assuming you have a TextBox for ProductName
            string batchNo = TXT_BatchNo.Text;  // Assuming you have a TextBox for ProductName
            //string slNo = TXT_SlNo.Text;  // Assuming you have a TextBox for ProductName

            // Retrieve the LineNo from the TextBox
            //int lineNo;
            //if (!int.TryParse(TXT_LineNo.Text, out lineNo))
            //{
            //    lblMessage.Text = "Please enter a valid Line Number.";
            //    lblMessage.ForeColor = System.Drawing.Color.Red;
            //    return;
            //}

            // Retrieve and validate SlNo
            //int slNo;
            //if (!int.TryParse(TXT_SlNo.Text, out slNo))
            //{
            //    lblMessage.Text = "Please enter a valid Serial Number (Sl No).";
            //    lblMessage.ForeColor = System.Drawing.Color.Red;
            //    return;
            //}

            decimal mrp;
            if (!decimal.TryParse(TXT_MRP.Text, out mrp))
            {
                lblMessage.Text = "Please enter a valid MRP.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            //decimal grossWt;
            //if (!decimal.TryParse(TXT_GrossWt.Text, out grossWt))
            //{
            //    lblMessage.Text = "Please enter a valid Gross Weight.";
            //    lblMessage.ForeColor = System.Drawing.Color.Red;
            //    return;
            //}





            // Define your connection string
            string connectionString = "Data Source=Buddy\\SQLEXPRESS06;Initial Catalog=AnmolDristi;Integrated Security=True;";

            // Create and open a connection to the database
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // SQL query to insert the data
                string insertQuery = "INSERT INTO Basic_Data (PlantId, [Line], ProductCategory, ProductBrand, SKUID, [Date], [Shift], [Time], [BatchNo], [MRP]) " +
                                     "VALUES (@PlantId, @Line, @ProductCategory, @ProductBrand, @SKUID, @Date, @Shift, @Time, @BatchNo, @MRP)";

                using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                {
                    // Add parameters to the query
                    insertCommand.Parameters.AddWithValue("@PlantId", plantName);
                    insertCommand.Parameters.AddWithValue("@Line", plantLine);
                    insertCommand.Parameters.AddWithValue("@ProductCategory", productCategory);
                    insertCommand.Parameters.AddWithValue("@ProductBrand", productBrand);
                    insertCommand.Parameters.AddWithValue("@SKUID", brandSKU);
                    insertCommand.Parameters.AddWithValue("@Date", DateTime.Now.Date);  // Example: Set current date
                    insertCommand.Parameters.AddWithValue("@Shift", 'A');  // Example: Set shift
                    insertCommand.Parameters.AddWithValue("@Time", DateTime.Now.TimeOfDay);  // Example: Set current time
                    //insertCommand.Parameters.AddWithValue("@LineNo", lineNo);  // Use the user-provided LineNo
                    //insertCommand.Parameters.AddWithValue("@ProductName", productName);  // Use the user-provided ProductName
                    insertCommand.Parameters.AddWithValue("@BatchNo", batchNo);  // Use the user-provided ProductName
                    //insertCommand.Parameters.AddWithValue("@SlNo", slNo);  // Use the user-provided ProductName
                    insertCommand.Parameters.AddWithValue("@MRP", mrp);  // Use the user-provided ProductName
                    //insertCommand.Parameters.AddWithValue("@GrossWt", grossWt);  // Use the user-provided ProductName

                    try
                    {
                        // Execute the query
                        int result = insertCommand.ExecuteNonQuery();

                        // Check if the insert was successful
                        if (result > 0)
                        {
                            lblMessage.Text = "Data saved successfully!";
                            lblMessage.ForeColor = System.Drawing.Color.Green;

                            // Inject JavaScript to switch to the 'rawBiscuts' tab
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "SwitchTab", "document.getElementById('rawBiscuts-tab').click();", true);
                        }
                        else
                        {
                            lblMessage.Text = "Error saving data.";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 2627) // SQL error code for unique constraint violation
                        {
                            lblMessage.Text = "Error: Line Number already exists. Please enter a different Line Number.";
                        }
                        else
                        {
                            lblMessage.Text = $"Error: {ex.Message}";
                        }
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

        }
    }
}