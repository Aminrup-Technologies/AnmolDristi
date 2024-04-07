using AnmolDristi.DAL;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi.qaqc
{
    public partial class qaqc_inspector_rpt : System.Web.UI.Page
    {
        public static string ImgLink1 = string.Empty;
        public static string ImgLink2 = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lbl_docname.Text = "QC - Inspection Report";
                lbl_docnumber.Text = "ANMOL/DOC/DAN/QA/02";


                PlantBinder();
                SetValidatorPropertiesFromDatabase();
                //NoOfPcs();
                GaugeValue();
                GaugeLength();
                SetDryWeightValidators();
                SetDippedWeightValidators();
                SetVartyPktValidators();
                SetTextureBiteValidators();
                SetMoistureValidators();
                SetWeightWithOilValidators();
                SetWeightWithoutOilValidators();
                SetOilPercentageValidators();
                SetPacketWeightValidators();


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

        private void SetValidatorPropertiesFromDatabase()
        {
            // Fetch validation criteria from the database for NoOfPcs
            ValidationCriteria noOfPcsValidationCriteria = GetValidationCriteriaFromDatabase("NoOfPcs");

            // Set properties for NoOfPcs validators
            RFV_TB_NoOfPcs.ErrorMessage = noOfPcsValidationCriteria.RequiredFieldErrorMessage;
            RFV_TB_NoOfPcs.Enabled = noOfPcsValidationCriteria.IsRequired;
            REV_TB_NoOfPcs.ErrorMessage = noOfPcsValidationCriteria.RegularExpressionErrorMessage;
            REV_TB_NoOfPcs.ValidationExpression = noOfPcsValidationCriteria.RegularExpression;
            REV_TB_NoOfPcs.Enabled = noOfPcsValidationCriteria.IsRegularExpressionRequired;
            RV_TB_NoOfPcs.ErrorMessage = noOfPcsValidationCriteria.RangeErrorMessage;
            RV_TB_NoOfPcs.MinimumValue = noOfPcsValidationCriteria.MinimumValue;
            RV_TB_NoOfPcs.MaximumValue = noOfPcsValidationCriteria.MaximumValue;
            RV_TB_NoOfPcs.Enabled = noOfPcsValidationCriteria.IsRangeRequired;

            //// Fetch validation criteria from the database for GaugeVal
            //ValidationCriteria gaugeValValidationCriteria = GetValidationCriteriaFromDatabase("GaugeVal");

            //// Set properties for GaugeVal validators
            //RFV_TB_GaugeVal.ErrorMessage = gaugeValValidationCriteria.RequiredFieldErrorMessage;
            //RFV_TB_GaugeVal.Enabled = gaugeValValidationCriteria.IsRequired;
            //REV_TB_GaugeVal.ErrorMessage = gaugeValValidationCriteria.RegularExpressionErrorMessage;
            //REV_TB_GaugeVal.ValidationExpression = gaugeValValidationCriteria.RegularExpression;
            //REV_TB_GaugeVal.Enabled = gaugeValValidationCriteria.IsRegularExpressionRequired;
            //RV_TB_GaugeVal.ErrorMessage = gaugeValValidationCriteria.RangeErrorMessage;
            //RV_TB_GaugeVal.MinimumValue = gaugeValValidationCriteria.MinimumValue;
            //RV_TB_GaugeVal.MaximumValue = gaugeValValidationCriteria.MaximumValue;
            //RV_TB_GaugeVal.Enabled = gaugeValValidationCriteria.IsRangeRequired;
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


        private void NoOfPcs()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_NoOfPcs.ErrorMessage = "*";
            RFV_TB_NoOfPcs.InitialValue = "0";
            RFV_TB_NoOfPcs.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_NoOfPcs.ErrorMessage = "Numeric Only";
            REV_TB_NoOfPcs.ForeColor = System.Drawing.Color.Red;
            REV_TB_NoOfPcs.ValidationExpression = @"\d+"; // Regular expression for numeric input

            // Set properties of RangeValidator
            RV_TB_NoOfPcs.ErrorMessage = "[30 - 40]";
            RV_TB_NoOfPcs.ForeColor = System.Drawing.Color.Red;
            RV_TB_NoOfPcs.MinimumValue = "30";
            RV_TB_NoOfPcs.MaximumValue = "40";
        }

        private void GaugeValue()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_GaugeVal.ErrorMessage = "*";
            RFV_TB_GaugeVal.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_GaugeVal.ErrorMessage = "Decimal Only";
            REV_TB_GaugeVal.ForeColor = System.Drawing.Color.Red;
            REV_TB_GaugeVal.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_GaugeVal.ErrorMessage = "[10.00 - 100.00]";
            RV_TB_GaugeVal.ForeColor = System.Drawing.Color.Red;
            RV_TB_GaugeVal.MinimumValue = "10.00";
            RV_TB_GaugeVal.MaximumValue = "100.00";
        }

        private void GaugeLength()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_GaugeLen.ErrorMessage = "*";
            RFV_TB_GaugeLen.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_GaugeLen.ErrorMessage = "Decimal Only";
            REV_TB_GaugeLen.ForeColor = System.Drawing.Color.Red;
            REV_TB_GaugeLen.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_GaugeLen.ErrorMessage = "[10.00 - 100.00]";
            RV_TB_GaugeLen.ForeColor = System.Drawing.Color.Red;
            RV_TB_GaugeLen.MinimumValue = "10.00";
            RV_TB_GaugeLen.MaximumValue = "100.00";
        }


        private void SetDryWeightValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_DryWeight.ErrorMessage = "*";
            RFV_TB_DryWeight.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_DryWeight.ErrorMessage = "Decimal Only";
            REV_TB_DryWeight.ForeColor = System.Drawing.Color.Red;
            REV_TB_DryWeight.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_DryWeight.ErrorMessage = "[10.00 - 100.00]";
            RV_TB_DryWeight.ForeColor = System.Drawing.Color.Red;
            RV_TB_DryWeight.MinimumValue = "10.00";
            RV_TB_DryWeight.MaximumValue = "100.00";
        }

        private void SetDippedWeightValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_DippedWeight.ErrorMessage = "*";
            RFV_TB_DippedWeight.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_DippedWeight.ErrorMessage = "Decimal Only";
            REV_TB_DippedWeight.ForeColor = System.Drawing.Color.Red;
            REV_TB_DippedWeight.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_DippedWeight.ErrorMessage = "[0.00 - 1000.00]";
            RV_TB_DippedWeight.ForeColor = System.Drawing.Color.Red;
            RV_TB_DippedWeight.MinimumValue = "0.00";
            RV_TB_DippedWeight.MaximumValue = "1000.00";
        }


        private void SetVartyPktValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_VartyPkt.ErrorMessage = "*";
            RFV_TB_VartyPkt.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_VartyPkt.ErrorMessage = "Alphanumeric Only";
            REV_TB_VartyPkt.ForeColor = System.Drawing.Color.Red;
            REV_TB_VartyPkt.ValidationExpression = "^[a-zA-Z0-9]*$"; // Regular expression for alphanumeric input
        }


        private void SetTextureBiteValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_TextureBite.ErrorMessage = "*";
            RFV_TB_TextureBite.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_TextureBite.ErrorMessage = "Decimal Only";
            REV_TB_TextureBite.ForeColor = System.Drawing.Color.Red;
            REV_TB_TextureBite.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_TextureBite.ErrorMessage = "Texture bite should be between 0.00 and 10.00";
            RV_TB_TextureBite.ForeColor = System.Drawing.Color.Red;
            RV_TB_TextureBite.MinimumValue = "0.00";
            RV_TB_TextureBite.MaximumValue = "10.00";
        }

        private void SetMoistureValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_Moisture.ErrorMessage = "*";
            RFV_TB_Moisture.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_Moisture.ErrorMessage = "Decimal Only";
            REV_TB_Moisture.ForeColor = System.Drawing.Color.Red;
            REV_TB_Moisture.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_Moisture.ErrorMessage = "Moisture should be between 0.00% and 100.00%";
            RV_TB_Moisture.ForeColor = System.Drawing.Color.Red;
            RV_TB_Moisture.MinimumValue = "0.00";
            RV_TB_Moisture.MaximumValue = "100.00";
        }

        private void SetWeightWithOilValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_wgtwtoil.ErrorMessage = "*";
            RFV_TB_wgtwtoil.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_wgtwtoil.ErrorMessage = "Decimal Only";
            REV_TB_wgtwtoil.ForeColor = System.Drawing.Color.Red;
            REV_TB_wgtwtoil.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_wgtwtoil.ErrorMessage = "Weight with oil should be between 0.00 and 1000.00 kg";
            RV_TB_wgtwtoil.ForeColor = System.Drawing.Color.Red;
            RV_TB_wgtwtoil.MinimumValue = "0.00";
            RV_TB_wgtwtoil.MaximumValue = "1000.00";
        }

        private void SetWeightWithoutOilValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_wgtwoil.ErrorMessage = "*";
            RFV_TB_wgtwoil.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_wgtwoil.ErrorMessage = "Decimal Only";
            REV_TB_wgtwoil.ForeColor = System.Drawing.Color.Red;
            REV_TB_wgtwoil.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_wgtwoil.ErrorMessage = "Weight without oil should be between 0.00 and 1000.00 g";
            RV_TB_wgtwoil.ForeColor = System.Drawing.Color.Red;
            RV_TB_wgtwoil.MinimumValue = "0.00";
            RV_TB_wgtwoil.MaximumValue = "1000.00";
        }

        private void SetOilPercentageValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_oilpercent.ErrorMessage = "*";
            RFV_TB_oilpercent.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_oilpercent.ErrorMessage = "Decimal Only";
            REV_TB_oilpercent.ForeColor = System.Drawing.Color.Red;
            REV_TB_oilpercent.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_oilpercent.ErrorMessage = "Oil percentage should be between 0.00% and 100.00%";
            RV_TB_oilpercent.ForeColor = System.Drawing.Color.Red;
            RV_TB_oilpercent.MinimumValue = "0.00";
            RV_TB_oilpercent.MaximumValue = "100.00";
        }

        private void SetPacketWeightValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_PktWgt.ErrorMessage = "*";
            RFV_TB_PktWgt.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_PktWgt.ErrorMessage = "Decimal Only";
            REV_TB_PktWgt.ForeColor = System.Drawing.Color.Red;
            REV_TB_PktWgt.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_PktWgt.ErrorMessage = "Packet weight should be between 0.00 and 1000.00 g";
            RV_TB_PktWgt.ForeColor = System.Drawing.Color.Red;
            RV_TB_PktWgt.MinimumValue = "0.00";
            RV_TB_PktWgt.MaximumValue = "1000.00";
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //// Retrieve values from DropDownList controls
            //string selectedPlant = DDL_Plant.SelectedValue;
            //string selectedPlantLine = DDL_PlantLine.SelectedValue;
            //string selectedProductCategory = DDL_ProductCategory.SelectedValue;

            //// Retrieve values from TextBox controls
            //string noOfPcs = TB_NoOfPcs.Text;
            //string gaugeVal = TB_GaugeVal.Text;
            //string dryWeight = TB_DryWeight.Text;
            //string dippedWeight = TB_DippedWeight.Text;
            //string vartyPkt = TB_VartyPkt.Text;
            //string bakingTime = TB_BakingTime.Text;
            //string textureBite = TB_TextureBite.Text;
            //string moisture = TB_Moisture.Text;
            //string gaugeVal = TB_GaugeLen.Text;
            //string wgtwtoil = TB_wgtwtoil.Text;
            //string wgtwoil = TB_wgtwoil.Text;
            //string oilPercent = TB_oilpercent.Text;
            //string pktWgt = TB_PktWgt.Text;

            //// Retrieve values from RadioButtonList controls
            //string flavTst = RBL_FlavTst.SelectedValue;
            //string flavTstRemarks = TXB_RBL_FlavTst_Rmrks.Text;
            //string spSz = RBL_SpSz.SelectedValue;
            //string spSzRemarks = TB_RBL_SpSz_Rmrks.Text;

            // Further processing or saving logic here


            // Retrieve values from controls
            string plantName = DDL_Plant.SelectedValue;
            string line = DDL_PlantLine.SelectedValue;
            string productCategory = DDL_ProductCategory.SelectedValue;
            string productBrand = DDL_ProductBrand.SelectedValue; // Assuming DDL_ProductBrand is a DropDownList
            int numberOfPieces = Convert.ToInt32(TB_NoOfPcs.Text);
            decimal gaugeValue = Convert.ToDecimal(TB_GaugeVal.Text);
            decimal dryWeight = Convert.ToDecimal(TB_DryWeight.Text);
            decimal dippedWeight = Convert.ToDecimal(TB_DippedWeight.Text);
            string varietyOrLotNo = TB_VartyPkt.Text;
            int bakingTime = Convert.ToInt32(TB_BakingTime.Text);
            int flavourAndTaste = Convert.ToInt32(RBL_FlavTst.SelectedValue);
            string commentsForFlavourAndTaste = TXB_RBL_FlavTst_Rmrks.Text;
            decimal textureBite = Convert.ToDecimal(TB_TextureBite.Text);
            int shapeOrSize = Convert.ToInt32(RBL_SpSz.SelectedValue);
            string commentsForShapeOrSize = TB_RBL_SpSz_Rmrks.Text;
            decimal moisture = Convert.ToDecimal(TB_Moisture.Text);
            decimal gaugeLength = Convert.ToDecimal(TB_GaugeLen.Text);
            decimal weightWithoutOil = Convert.ToDecimal(TB_wgtwtoil.Text);
            decimal weightWithOil = Convert.ToDecimal(TB_wgtwoil.Text);
            decimal oilPercentage = Convert.ToDecimal(TB_oilpercent.Text);
            decimal packetWeight = Convert.ToDecimal(TB_PktWgt.Text);
            // Retrieve other values in a similar manner

            //string designAndImplementation = "";
            //string colourAndAppearance = "";
            int submittedById = 1;
            string SubmittedByPNo = "AHO445";

            QCInspectorDataAccess dataAccess = new QCInspectorDataAccess();

            try
            {
                // Call the InsertQCInspectorData method with the retrieved values
                dataAccess.InsertQCInspectorData(plantName, line, productCategory, productBrand,
                      numberOfPieces, gaugeValue, dryWeight, dippedWeight,
                      varietyOrLotNo, bakingTime, flavourAndTaste, commentsForFlavourAndTaste,
                      textureBite, shapeOrSize, commentsForShapeOrSize, moisture,
                      gaugeLength, weightWithoutOil, weightWithOil, oilPercentage,
                      packetWeight, ImgLink1, ImgLink2,
                      submittedById, DateTime.Now.Date, DateTime.Now.TimeOfDay, SubmittedByPNo);

                //Make the inputs readonly
                MakeInputsReadOnly();
            }
            catch (Exception ex)
            {
                // Handle any exceptions that might occur during the insertion process
                // For example, you can log the exception and display an error message to the user
                // For simplicity, here we are just displaying the exception message
            }
        }

        private void MakeInputsReadOnly()
        {
            DDL_Plant.Enabled = false;
            DDL_PlantLine.Enabled = false;
            DDL_ProductCategory.Enabled = false;
            DDL_ProductBrand.Enabled = false;
            TB_NoOfPcs.ReadOnly = true;
            TB_GaugeVal.ReadOnly = true;
            TB_DryWeight.ReadOnly = true;
            TB_DippedWeight.ReadOnly = true;
            TB_VartyPkt.ReadOnly = true;
            TB_BakingTime.ReadOnly = true;
            RBL_FlavTst.Enabled = false;
            TXB_RBL_FlavTst_Rmrks.ReadOnly = true;
            TB_TextureBite.ReadOnly = true;
            RBL_SpSz.Enabled = false;
            TB_RBL_SpSz_Rmrks.ReadOnly = true;
            TB_Moisture.ReadOnly = true;
            TB_GaugeLen.ReadOnly = true;
            TB_wgtwtoil.ReadOnly = true;
            TB_wgtwoil.ReadOnly = true;
            TB_oilpercent.ReadOnly = true;
            TB_PktWgt.ReadOnly = true;

            btnSubmit.Enabled = false;
            btnSubmit.Text = "SAVED";
            btnSubmit.CssClass = "btn btn-sm btn-success";

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

        protected void BtnUploadFU_DesgImp_Click(object sender, EventArgs e)
        {

            if (UploadImage1() == true)
            {
                string UI_1_Successscript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Upload Success',
                                text: 'Image Saved!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowImage1SuccessNotification", UI_1_Successscript, false);
            }
            //if (FU_DesgImp.HasFile)
            //{
            //    try
            //    {
            //        // Get the file name and extension
            //        string fileName = Path.GetFileNameWithoutExtension(FU_DesgImp.FileName);
            //        string fileExtension = Path.GetExtension(FU_DesgImp.FileName);

                //        // Rename the file with a unique name
                //        string uniqueFileName = $"{fileName}_{DateTime.Now:yyyyMMddHHmmss}{fileExtension}";

                //        // Check if the directory exists, if not, create it
                //        string uploadFolderPath = Server.MapPath("~/UploadedFiles/");
                //        if (!Directory.Exists(uploadFolderPath))
                //        {
                //            Directory.CreateDirectory(uploadFolderPath);
                //        }

                //        // Save the file to the server
                //        string filePath = Path.Combine(uploadFolderPath, uniqueFileName);
                //        FU_DesgImp.SaveAs(filePath);

                //        // Optimize the image size (optional)
                //        // You can use third-party libraries like ImageMagick or .NET built-in classes
                //        // For simplicity, I'll assume you're using System.Drawing
                //        using (System.Drawing.Image image = System.Drawing.Image.FromFile(filePath))
                //        {
                //            // Resize the image (e.g., to a maximum width of 800 pixels)
                //            int maxWidth = 800;
                //            int newWidth = image.Width > maxWidth ? maxWidth : image.Width;
                //            int newHeight = (int)((double)newWidth / image.Width * image.Height);
                //            using (System.Drawing.Image resizedImage = image.GetThumbnailImage(newWidth, newHeight, null, IntPtr.Zero))
                //            {
                //                // Save the resized image back to the file system
                //                resizedImage.Save(filePath);
                //            }
                //        }

                //        // Display the uploaded image
                //        FU_DesgImp_Img.Visible = true;
                //        uploadedImage.Visible = true;
                //        uploadedImage.ImageUrl = "~/UploadedFiles/" + uniqueFileName;
                //    }
                //    catch (Exception ex)
                //    {
                //        // Handle any exceptions
                //        lblErrorMessage2.Text = "Error: " + ex.Message;
                //    }
                //}
                //else
                //{
                //    lblErrorMessage2.Text = "Please select a file to upload.";
                //}
        }


        private bool UploadImage1()
        {
            bool imgSaved = false;

            try
            {
                string TBPhotoId = "QCIR";
                DateTime now = DateTime.Now;

                // Define the target folder path
                string targetFolderPath = Server.MapPath("~/UploadedFiles/QCIR/DesignImp/");

                // Check if the target folder exists, if not, create it
                if (!Directory.Exists(targetFolderPath))
                {
                    Directory.CreateDirectory(targetFolderPath);
                }

                // Check if a file is posted
                if (FU_DesgImp.PostedFile != null)
                {
                    // Check the extension of the image
                    string extension = Path.GetExtension(FU_DesgImp.FileName);
                    if (extension.ToLower() == ".png" || extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg")
                    {
                        // Get the uploaded image stream
                        Stream strm = FU_DesgImp.PostedFile.InputStream;
                        using (var uploadedImage = System.Drawing.Image.FromStream(strm))
                        {
                            // Resize the image
                            //int newWidth = 440; // New Width of Image in Pixel
                            //int newHeight = 540; // New Height of Image in Pixel
                            //using (var resizedImage = new Bitmap(newWidth, newHeight))
                            //{
                            //    using (var graphics = Graphics.FromImage(resizedImage))
                            //    {
                            //        graphics.CompositingQuality = CompositingQuality.HighQuality;
                            //        graphics.SmoothingMode = SmoothingMode.HighQuality;
                            //        graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                            //        var imgRectangle = new Rectangle(0, 0, newWidth, newHeight);
                            //        graphics.DrawImage(uploadedImage, imgRectangle);

                            //        // Save the resized image to the target folder
                            //        string fileName = $"{TBPhotoId}_{imgDate}.jpg";
                            //        string targetPath = Path.Combine(targetFolderPath, fileName);
                            //        resizedImage.Save(targetPath, System.Drawing.Imaging.ImageFormat.Jpeg);

                            //        // Set the image link for database
                            //        string imglink = "~/UploadedFiles" + fileName;
                            //        //imgfilename = fileName;

                            //        // Show the image instantly
                            //        uploadedImage1.ImageUrl = imglink;

                            //        // Image saved successfully
                            //        imgSaved = true;
                            //    }
                            //}

                            // Resize the image
                            int maxWidth = 800;
                            int newWidth = uploadedImage.Width > maxWidth ? maxWidth : uploadedImage.Width;
                            int newHeight = (int)((double)newWidth / uploadedImage.Width * uploadedImage.Height);
                            using (var resizedImage = uploadedImage.GetThumbnailImage(newWidth, newHeight, null, IntPtr.Zero))
                            {
                                string fileName = $"{TBPhotoId}_{DateTime.Now:yyyyMMddHHmmss}.jpg";
                                // Save the resized image to the target folder
                                string targetPath = Path.Combine(targetFolderPath, fileName);
                                resizedImage.Save(targetPath, System.Drawing.Imaging.ImageFormat.Jpeg);

                                // Set the image link for database
                                ImgLink1 = "~/UploadedFiles/QCIR/DesignImp/" + fileName;
                                //imgfilename = fileName;

                                // Show the image instantly
                                FU_DesgImp_Img.Visible = true;
                                uploadedImage1.ImageUrl = ImgLink1;

                                // Image saved successfully
                                imgSaved = true;

                                FU_DesgImp_Upldr.Visible = false;
                            }
                        }
                    }
                    else
                    {
                        // Display error notification for inappropriate file type
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception or display an error message
            }

            return imgSaved;
        }

        private bool UploadImage2()
        {
            bool imgSaved = false;

            try
            {
                string TBPhotoId = "QCIR";
                DateTime now = DateTime.Now;

                // Define the target folder path
                string targetFolderPath = Server.MapPath("~/UploadedFiles/QCIR/ClrApp/");

                // Check if the target folder exists, if not, create it
                if (!Directory.Exists(targetFolderPath))
                {
                    Directory.CreateDirectory(targetFolderPath);
                }

                // Check if a file is posted
                if (FU_ClrApp.PostedFile != null)
                {
                    // Check the extension of the image
                    string extension = Path.GetExtension(FU_ClrApp.FileName);
                    if (extension.ToLower() == ".png" || extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg")
                    {
                        // Get the uploaded image stream
                        Stream strm = FU_ClrApp.PostedFile.InputStream;
                        using (var uploadedImage = System.Drawing.Image.FromStream(strm))
                        {
                            // Resize the image
                            //int newWidth = 440; // New Width of Image in Pixel
                            //int newHeight = 540; // New Height of Image in Pixel
                            //using (var resizedImage = new Bitmap(newWidth, newHeight))
                            //{
                            //    using (var graphics = Graphics.FromImage(resizedImage))
                            //    {
                            //        graphics.CompositingQuality = CompositingQuality.HighQuality;
                            //        graphics.SmoothingMode = SmoothingMode.HighQuality;
                            //        graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                            //        var imgRectangle = new Rectangle(0, 0, newWidth, newHeight);
                            //        graphics.DrawImage(uploadedImage, imgRectangle);

                            //        // Save the resized image to the target folder
                            //        string fileName = $"{TBPhotoId}_{imgDate}.jpg";
                            //        string targetPath = Path.Combine(targetFolderPath, fileName);
                            //        resizedImage.Save(targetPath, System.Drawing.Imaging.ImageFormat.Jpeg);

                            //        // Set the image link for database
                            //        string imglink = "~/UploadedFiles" + fileName;
                            //        //imgfilename = fileName;

                            //        // Show the image instantly
                            //        uploadedImage1.ImageUrl = imglink;

                            //        // Image saved successfully
                            //        imgSaved = true;
                            //    }
                            //}

                            // Resize the image
                            int maxWidth = 800;
                            int newWidth = uploadedImage.Width > maxWidth ? maxWidth : uploadedImage.Width;
                            int newHeight = (int)((double)newWidth / uploadedImage.Width * uploadedImage.Height);
                            using (var resizedImage = uploadedImage.GetThumbnailImage(newWidth, newHeight, null, IntPtr.Zero))
                            {
                                string fileName = $"{TBPhotoId}_{DateTime.Now:yyyyMMddHHmmss}.jpg";
                                // Save the resized image to the target folder
                                string targetPath = Path.Combine(targetFolderPath, fileName);
                                resizedImage.Save(targetPath, System.Drawing.Imaging.ImageFormat.Jpeg);

                                // Set the image link for database
                                ImgLink2 = "~/UploadedFiles/QCIR/ClrApp/" + fileName;
                                //imgfilename = fileName;

                                // Show the image instantly
                                FU_ClrApp_Img.Visible = true;
                                uploadedImage2.ImageUrl = ImgLink2;

                                // Image saved successfully
                                imgSaved = true;

                                FU_ClrApp_Upldr.Visible = false;
                            }
                        }
                    }
                    else
                    {
                        // Display error notification for inappropriate file type
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception or display an error message
            }

            return imgSaved;
        }

        protected void BtnUploadClrApp_Click(object sender, EventArgs e)
        {
            if (UploadImage2() == true)
            {
                string UI_2_Successscript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Upload Success',
                                text: 'Image Saved!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowImage2SuccessNotification", UI_2_Successscript, false);
            }
        }
    }
}