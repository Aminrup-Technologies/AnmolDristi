using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.EnterpriseServices;
using System.Windows.Media;

namespace AnmolDristi
{
    public partial class RM_Class_3 : System.Web.UI.Page
    {
        public static string ImgLink1 = string.Empty;
        public static string RmfId = string.Empty;
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
                    hdn_formid.Value = string.Empty;


                    lbl_docname.Text = "QC - RM Class 3 Report";
                    lbl_docnumber.Text = "ANMOL/DOC/CORP/QC/PKNG/01";
                    PlantBinder();
                    PopulateColorDropdown();

                    // Call a helper method to make all controls visible
                    SetControlsVisible(Page.Controls, true);

                    // set validators for fields or columns
                    SetQuantityValidators();
                    SetGradeValidators();
                    SetPhValidators();
                    SetMoistureValidators();
                    SetTotalAshValidators();
                    SetInsolubleAshValidators();
                    SetTotalSolidValidators();
                    SetDextroseEquivalentValidators();
                    SetTitrableAcidityValidators();
                    SetAlcoholicAcidityValidators();
                    SetSO2Validators();
                    SetGlycerineContentValidators();
                    SetGlucoseContentValidators();
                    SetLossOnDryingValidators();
                    SetSolubityValidators();
                    SetShapeOrSizeValidators();
                    SetWIMValidators();
                    SetVehicleNoValidators();
                    SetLotBatchNoValidators();
                    SetChallanNoValidators();
                    SetChallanDateValidators();
                    SetPkdDateValidators();
                }

            }
        }

        private void SetControlsVisible(ControlCollection controls, bool visible)
        {
            foreach (Control ctrl in controls)
            {
                // Only hide/show divs that are not related to the Plant dropdown
                if (ctrl is HtmlGenericControl && (ctrl as HtmlGenericControl).TagName == "div")
                {
                    // Assuming you have named your divs properly or added IDs to them (e.g., divSupplierSection, divOtherSection, etc.)
                    if (ctrl.ID != "PlantDIV" && ctrl.ID != "MaterialDIV")
                    {
                        ctrl.Visible = visible;
                    }
                }
                // Check for remarks TextBoxes
                if (ctrl is TextBox && (ctrl.ID.EndsWith("RemarksDiv", StringComparison.OrdinalIgnoreCase)))
                {
                    if (!visible)
                    {
                        (ctrl as TextBox).CssClass += " hidden"; // Add 'hidden' class to hide
                    }
                    else
                    {
                        (ctrl as TextBox).CssClass = (ctrl as TextBox).CssClass.Replace(" hidden", ""); // Remove 'hidden' class
                    }
                }

                // Recursively check nested controls for divs
                if (ctrl.HasControls())
                {
                    SetControlsVisible(ctrl.Controls, visible);
                }
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

        private void SetQuantityValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_Quantity.ErrorMessage = "*";
            RFV_TB_Quantity.ForeColor = System.Drawing.Color.Red;
            RFV_TB_Quantity.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_Quantity.ErrorMessage = "Decimal Only";
            REV_TB_Quantity.ForeColor = System.Drawing.Color.Red;
            REV_TB_Quantity.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_PH.ErrorMessage = "[0.00 - 2000.00]";
            CV_TB_PH.ForeColor = System.Drawing.Color.Red;
        }
        private void SetGradeValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_Grade.ErrorMessage = "*";
            RFV_TB_Grade.ForeColor = System.Drawing.Color.Red;
            RFV_TB_Grade.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_Grade.ErrorMessage = "Decimal Only";
            REV_TB_Grade.ForeColor = System.Drawing.Color.Red;
            REV_TB_Grade.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_PH.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_PH.ForeColor = System.Drawing.Color.Red;
        }
        private void SetPhValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_PH.ErrorMessage = "*";
            RFV_TB_PH.ForeColor = System.Drawing.Color.Red;
            RFV_TB_PH.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_PH.ErrorMessage = "Decimal Only";
            REV_TB_PH.ForeColor = System.Drawing.Color.Red;
            REV_TB_PH.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_PH.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_PH.ForeColor = System.Drawing.Color.Red;
        }
        private void SetMoistureValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_Moisture.ErrorMessage = "*";
            RFV_TB_Moisture.ForeColor = System.Drawing.Color.Red;
            RFV_TB_Moisture.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_Moisture.ErrorMessage = "Decimal Only";
            REV_TB_Moisture.ForeColor = System.Drawing.Color.Red;
            REV_TB_Moisture.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_Moisture.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_Moisture.ForeColor = System.Drawing.Color.Red;
        }
        private void SetTotalAshValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_TotalAsh.ErrorMessage = "*";
            RFV_TB_TotalAsh.ForeColor = System.Drawing.Color.Red;
            RFV_TB_TotalAsh.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_TotalAsh.ErrorMessage = "Decimal Only";
            REV_TB_TotalAsh.ForeColor = System.Drawing.Color.Red;
            REV_TB_TotalAsh.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_TotalAsh.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_TotalAsh.ForeColor = System.Drawing.Color.Red;
        }
        private void SetInsolubleAshValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_InsolubleAsh.ErrorMessage = "*";
            RFV_TB_InsolubleAsh.ForeColor = System.Drawing.Color.Red;
            RFV_TB_InsolubleAsh.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_InsolubleAsh.ErrorMessage = "Decimal Only";
            REV_TB_InsolubleAsh.ForeColor = System.Drawing.Color.Red;
            REV_TB_InsolubleAsh.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_InsolubleAsh.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_InsolubleAsh.ForeColor = System.Drawing.Color.Red;
        }
        private void SetTotalSolidValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_TotalSolid.ErrorMessage = "*";
            RFV_TB_TotalSolid.ForeColor = System.Drawing.Color.Red;
            RFV_TB_TotalSolid.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_TotalSolid.ErrorMessage = "Decimal Only";
            REV_TB_TotalSolid.ForeColor = System.Drawing.Color.Red;
            REV_TB_TotalSolid.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_TotalSolid.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_TotalSolid.ForeColor = System.Drawing.Color.Red;
        }
        private void SetDextroseEquivalentValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_Dextrose.ErrorMessage = "*";
            RFV_TB_Dextrose.ForeColor = System.Drawing.Color.Red;
            RFV_TB_Dextrose.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_Dextrose.ErrorMessage = "Decimal Only";
            REV_TB_Dextrose.ForeColor = System.Drawing.Color.Red;
            REV_TB_Dextrose.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_Dextrose.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_Dextrose.ForeColor = System.Drawing.Color.Red;
        }
        private void SetTitrableAcidityValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_TitrableAcidity.ErrorMessage = "*";
            RFV_TB_TitrableAcidity.ForeColor = System.Drawing.Color.Red;
            RFV_TB_TitrableAcidity.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_TitrableAcidity.ErrorMessage = "Decimal Only";
            REV_TB_TitrableAcidity.ForeColor = System.Drawing.Color.Red;
            REV_TB_TitrableAcidity.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_TitrableAcidity.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_TitrableAcidity.ForeColor = System.Drawing.Color.Red;
        }
        private void SetAlcoholicAcidityValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_AlcoholicAcidity.ErrorMessage = "*";
            RFV_TB_AlcoholicAcidity.ForeColor = System.Drawing.Color.Red;
            RFV_TB_AlcoholicAcidity.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_AlcoholicAcidity.ErrorMessage = "Integer Only";
            REV_TB_AlcoholicAcidity.ForeColor = System.Drawing.Color.Red;
            REV_TB_AlcoholicAcidity.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_AlcoholicAcidity.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_AlcoholicAcidity.ForeColor = System.Drawing.Color.Red;
        }
        private void SetSO2Validators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_SO2.ErrorMessage = "*";
            RFV_TB_SO2.ForeColor = System.Drawing.Color.Red;
            RFV_TB_SO2.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_SO2.ErrorMessage = "Integer Only";
            REV_TB_SO2.ForeColor = System.Drawing.Color.Red;
            REV_TB_SO2.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_SO2.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_SO2.ForeColor = System.Drawing.Color.Red;
        }
        private void SetGlycerineContentValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_GlycerineContent.ErrorMessage = "*";
            RFV_TB_GlycerineContent.ForeColor = System.Drawing.Color.Red;
            RFV_TB_GlycerineContent.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_GlycerineContent.ErrorMessage = "Integer Only";
            REV_TB_GlycerineContent.ForeColor = System.Drawing.Color.Red;
            REV_TB_GlycerineContent.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_GlycerineContent.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_GlycerineContent.ForeColor = System.Drawing.Color.Red;
        }
        private void SetGlucoseContentValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_GlucoseContent.ErrorMessage = "*";
            RFV_TB_GlucoseContent.ForeColor = System.Drawing.Color.Red;
            RFV_TB_GlucoseContent.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_GlucoseContent.ErrorMessage = "Integer Only";
            REV_TB_GlucoseContent.ForeColor = System.Drawing.Color.Red;
            REV_TB_GlucoseContent.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_GlucoseContent.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_GlucoseContent.ForeColor = System.Drawing.Color.Red;
        }
        private void SetLossOnDryingValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_LossOnDrying.ErrorMessage = "*";
            RFV_TB_LossOnDrying.ForeColor = System.Drawing.Color.Red;
            RFV_TB_LossOnDrying.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_LossOnDrying.ErrorMessage = "Decimal Only";
            REV_TB_LossOnDrying.ForeColor = System.Drawing.Color.Red;
            REV_TB_LossOnDrying.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_LossOnDrying.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_LossOnDrying.ForeColor = System.Drawing.Color.Red;
        }
        private void SetSolubityValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_Solubility.ErrorMessage = "*";
            RFV_TB_Solubility.ForeColor = System.Drawing.Color.Red;
            RFV_TB_Solubility.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_Solubility.ErrorMessage = "Decimal Only";
            REV_TB_Solubility.ForeColor = System.Drawing.Color.Red;
            REV_TB_Solubility.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_Solubility.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_Solubility.ForeColor = System.Drawing.Color.Red;
        }
        private void SetShapeOrSizeValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_ShapeOrSize.ErrorMessage = "*";
            RFV_TB_ShapeOrSize.ForeColor = System.Drawing.Color.Red;
            RFV_TB_ShapeOrSize.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_ShapeOrSize.ErrorMessage = "Decimal Only";
            REV_TB_ShapeOrSize.ForeColor = System.Drawing.Color.Red;
            REV_TB_ShapeOrSize.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_ShapeOrSize.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_ShapeOrSize.ForeColor = System.Drawing.Color.Red;
        }
        private void SetWIMValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_WIM.ErrorMessage = "*";
            RFV_TB_WIM.ForeColor = System.Drawing.Color.Red;
            RFV_TB_WIM.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_WIM.ErrorMessage = "Decimal Only";
            REV_TB_WIM.ForeColor = System.Drawing.Color.Red;
            REV_TB_WIM.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            CV_TB_WIM.ErrorMessage = "[0.00 - 1000.00]";
            CV_TB_WIM.ForeColor = System.Drawing.Color.Red;
        }
        private void SetVehicleNoValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_VehicleNo.ErrorMessage = "*";
            RFV_TB_VehicleNo.ForeColor = System.Drawing.Color.Red;
            RFV_TB_VehicleNo.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_VehicleNo.ErrorMessage = "Alphanumeric Only";
            REV_TB_VehicleNo.ForeColor = System.Drawing.Color.Red;
            REV_TB_VehicleNo.ValidationExpression = "^[a-zA-Z0-9]*$"; // Regular expression for alphanumeric input
        }
        private void SetLotBatchNoValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_LotNo.ErrorMessage = "*";
            RFV_TB_LotNo.ForeColor = System.Drawing.Color.Red;
            RFV_TB_LotNo.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_LotNo.ErrorMessage = "Alphanumeric Only";
            REV_TB_LotNo.ForeColor = System.Drawing.Color.Red;
            REV_TB_LotNo.ValidationExpression = "^[a-zA-Z0-9, /]*$"; // Regular expression for alphanumeric input
        }
        private void SetChallanNoValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_ChallanNo.ErrorMessage = "*";
            RFV_TB_ChallanNo.ForeColor = System.Drawing.Color.Red;
            RFV_TB_ChallanNo.Enabled = true;

            // Set properties of RegularExpressionValidator
            REV_TB_ChallanNo.ErrorMessage = "Alphanumeric Only";
            REV_TB_ChallanNo.ForeColor = System.Drawing.Color.Red;
            REV_TB_ChallanNo.ValidationExpression = "^[a-zA-Z0-9]*$"; // Regular expression for alphanumeric input
        }
        private void SetChallanDateValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_ChallanDate.ErrorMessage = "*";
            RFV_TB_ChallanDate.ForeColor = System.Drawing.Color.Red;
            RFV_TB_ChallanDate.Enabled = true;
        }
        private void SetPkdDateValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_PkdMfg.ErrorMessage = "*";
            RFV_TB_PkdMfg.ForeColor = System.Drawing.Color.Red;
            RFV_TB_PkdMfg.Enabled = true;
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
                MaterialBinder(selectedPlantValue);
                LoadApprovers(selectedPlantValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Material);

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
        private void LoadApprovers(string selectedPlantValue)
        {
            // Replace with your actual connection string
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_GetFormsApprovalMatrix_PM", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Set parameters for the stored procedure
                    cmd.Parameters.AddWithValue("@PlantId", selectedPlantValue); // Replace with actual value
                    cmd.Parameters.AddWithValue("@FormID", 1); // Replace with actual value
                    cmd.Parameters.AddWithValue("@FormName", "RM_Class_3"); // Replace with actual value

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Bind the data to a GridView or another control
                        GridViewApprovers.DataSource = dt;
                        GridViewApprovers.DataBind();

                        // Bind data to Flow Diagram if needed
                        if (dt.Rows.Count > 0)
                        {
                            hdn_formid.Value = "12";
                            DataRow row = dt.Rows[0];

                            // Set data for flow diagram
                            Approver1NameLabel.Text = row["Approver1Name"].ToString();
                            Approver1CodeLabel.Text = row["Approver1EmployeeCode"].ToString();
                            //Approver1Photo.ImageUrl = row["Approver1Photo"].ToString(); // Adjust field name for photo

                            Approver2NameLabel.Text = row["Approver2Name"].ToString();
                            Approver2CodeLabel.Text = row["Approver2EmployeeCode"].ToString();
                            //Approver2Photo.ImageUrl = row["Approver2Photo"].ToString(); // Adjust field name for photo

                            DottedLineApproverNameLabel.Text = row["DottedLineApproverName"].ToString();
                            DottedLineApproverCodeLabel.Text = row["DottedLineApproverEmployeeCode"].ToString();
                            //DottedLineApproverPhoto.ImageUrl = row["DottedLineApproverPhoto"].ToString(); // Adjust field name for photo
                        }
                        else
                        {
                            hdn_formid.Value = "12";
                            // Set default values to ADMIN if no rows are found
                            Approver1NameLabel.Text = "ADMIN";
                            Approver1CodeLabel.Text = "ADMIN";

                            Approver2NameLabel.Text = "ADMIN";
                            Approver2CodeLabel.Text = "ADMIN";

                            DottedLineApproverNameLabel.Text = "ADMIN";
                            DottedLineApproverCodeLabel.Text = "ADMIN";
                        }
                    }
                }
            }
        }
        private void MaterialBinder(string selectedPlantValue)
        {
            string query = "SELECT Material_Id, Material_Name FROM RM_Material where Class = 3 ";
            string textField = "Material_Name";
            string valueField = "Material_Id";

            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Material, textField, valueField, new SqlParameter("@SelectedPlantValue", selectedPlantValue), out recordsBound);

            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Material);

                string MaterialBinder_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'An error occurred!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowRegionBinderErrorNotification", MaterialBinder_Error_script, false);
            }
        }
        protected void DDL_Material_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Material.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedMaterialValue = DDL_Material.SelectedValue.ToString();
                ProductBrandsBinder(selectedPlantValue);

                // Call method to show relevant controls based on selected material
                DivBinders(selectedMaterialValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_ProductBrand);

                string DDL_Material_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowRegionInvalidErrorNotification", DDL_Material_Error_script, false);
            }
        }
        private void ProductBrandsBinder(string selectedPlantValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT brand_id, brand_name FROM MST_LineCatBrands WHERE plant_id = @PlantId";
            string textField = "brand_name"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "brand_id"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@PlantId", selectedPlantValue)
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

        private bool UploadImage1()
        {
            bool imgSaved = false;

            try
            {
                string TBPhotoId = "QAPC";
                DateTime now = DateTime.Now;

                // Define the target folder path
                string targetFolderPath = Server.MapPath("~/UploadedFiles/QAPC/MaterialImage/");

                // Check if the target folder exists, if not, create it
                if (!Directory.Exists(targetFolderPath))
                {
                    Directory.CreateDirectory(targetFolderPath);
                }

                // Check if a file is posted
                if (FU_MaterialImage.PostedFile != null)
                {
                    // Check the extension of the image
                    string extension = Path.GetExtension(FU_MaterialImage.FileName);
                    if (extension.ToLower() == ".png" || extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg")
                    {
                        // Get the uploaded image stream
                        Stream strm = FU_MaterialImage.PostedFile.InputStream;
                        using (var uploadedImage = System.Drawing.Image.FromStream(strm))
                        {

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
                                ImgLink1 = "~/UploadedFiles/QAPC/MaterialImage/" + fileName;
                                //imgfilename = fileName;

                                // Show the image instantly
                                FU_MaterialImage_img.Visible = true;
                                uploadedImage1.ImageUrl = ImgLink1;

                                // Image saved successfully
                                imgSaved = true;

                                FU_MaterialImage_Upldr.Visible = false;
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
                throw ex;

            }

            return imgSaved;
        }
        protected void BtnUploadFU_MaterialImage_Click(object sender, EventArgs e)
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
        }

        private string GenerateUnique()
        {

            string newRmfValue;
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // Fetch the maximum RMF01 value
                    string query = "SELECT ISNULL(MAX(CAST(SUBSTRING(RMFID, 4, LEN(RMFID)) AS INT)), 0) FROM TRN_RM_CLASS_3";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        object result = command.ExecuteScalar();
                        int maxRMFValue = Convert.ToInt32(result);

                        // Increment the numeric part
                        int numericPart = maxRMFValue + 1;

                        // Format the new value
                        newRmfValue = $"RMF{numericPart:D3}"; // Ensure three digits (e.g., RMF001, RMF002)
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Console.WriteLine("Error generating RMF01: " + ex.Message);
                throw;
            }

            RmfId = newRmfValue;
            return newRmfValue;
        }

        private decimal? TryParseDecimal(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                // Return null if the input is null, empty, or consists only of whitespace
                return null;
            }

            decimal result;
            return decimal.TryParse(value, out result) ? (decimal?)result : null;
        }
        private int? TryParseInt(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                // Return null if the input is null, empty, or consists only of whitespace
                return null;
            }

            int result;
            return int.TryParse(value, out result) ? (int?)result : null;
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string rmfId = GenerateUnique();  // Generate unique value
            int formID = Convert.ToInt32(hdn_formid.Value.ToString());

            string plantName = DDL_Plant.SelectedValue;
            string materialName = DDL_Material.SelectedValue;
            string productBrand = string.IsNullOrEmpty(DDL_ProductBrand.SelectedValue) ? null : DDL_ProductBrand.Text;

            string supplier = string.IsNullOrEmpty(TB_Supplier.Text) ? null : TB_Supplier.Text;
            string challanNo = string.IsNullOrEmpty(TB_ChallanNo.Text) ? null : TB_ChallanNo.Text;
            DateTime? challanDate = string.IsNullOrEmpty(TB_ChallanDate.Text) ? (DateTime?)null : DateTime.Parse(TB_ChallanDate.Text).Date;
            string lotNo = string.IsNullOrEmpty(TB_LotNo.Text) ? null : TB_LotNo.Text;
            DateTime? pkdMfgDate = string.IsNullOrEmpty(TB_PkdMfg.Text) ? (DateTime?)null : DateTime.Parse(TB_PkdMfg.Text).Date;
            string vehicleNo = string.IsNullOrEmpty(TB_VehicleNo.Text) ? null : TB_VehicleNo.Text;

            decimal? grade = !string.IsNullOrWhiteSpace(TB_Grade.Text) ? Convert.ToDecimal(TB_Grade.Text) : (decimal?)null;
            string gradeRemarks = string.IsNullOrEmpty(TXB_Grade_Remarks.Text) ? null : TXB_Grade_Remarks.Text;

            decimal? quantity = !string.IsNullOrWhiteSpace(TB_Quantity.Text) ? Convert.ToDecimal(TB_Quantity.Text) : (decimal?)null;
            string quantityRemarks = string.IsNullOrEmpty(TXB_Quantity_Remarks.Text) ? null : TXB_Quantity_Remarks.Text;

            string color = string.IsNullOrEmpty(DDL_Color.SelectedItem.Text) ? null : DDL_Color.Text;
            string colorRemarks = string.IsNullOrEmpty(TXB_Color_Remarks.Text) ? null : TXB_Color_Remarks.Text;

            int? smell = string.IsNullOrEmpty(RBL_Smell.SelectedValue) ? (int?)null : (int?)Convert.ToInt32(RBL_Smell.SelectedValue);
            string smellRemarks = string.IsNullOrEmpty(TXB_Smell_Remarks.Text) ? null : TXB_Smell_Remarks.Text;

            int? appearance = string.IsNullOrEmpty(RBL_Appearance.SelectedValue) ? (int?)null : (int?)Convert.ToInt32(RBL_Appearance.SelectedValue);
            string appearanceRemarks = string.IsNullOrEmpty(TXB_Appearance_Remarks.Text) ? null : TXB_Appearance_Remarks.Text;

            int? taste = string.IsNullOrEmpty(RBL_TasteFlavor.SelectedValue) ? (int?)null : (int?)Convert.ToInt32(RBL_TasteFlavor.SelectedValue);
            string tasteRemarks = string.IsNullOrEmpty(TXB_TasteFlavor_Remarks.Text) ? null : TXB_TasteFlavor_Remarks.Text;

            string foreignImpurites = string.IsNullOrEmpty(TB_Foreign_Impurities.Text) ? null : TB_Foreign_Impurities.Text;

            decimal? ph = !string.IsNullOrWhiteSpace(TB_PH.Text) ? Convert.ToDecimal(TB_PH.Text) : (decimal?)null;
            string phRemarks = string.IsNullOrEmpty(TXB_PH_Remarks.Text) ? null : TXB_PH_Remarks.Text;

            decimal? moisture = !string.IsNullOrWhiteSpace(TB_Moisture.Text) ? Convert.ToDecimal(TB_Moisture.Text) : (decimal?)null;
            string moistureRemarks = string.IsNullOrEmpty(TXB_PH_Remarks.Text) ? null : TXB_PH_Remarks.Text;

            decimal? ash = !string.IsNullOrWhiteSpace(TB_TotalAsh.Text) ? Convert.ToDecimal(TB_TotalAsh.Text) : (decimal?)null;
            string ashRemarks = string.IsNullOrEmpty(TXB_Ash_Remarks.Text) ? null : TXB_Ash_Remarks.Text;

            decimal? insolubleAsh = !string.IsNullOrWhiteSpace(TB_InsolubleAsh.Text) ? Convert.ToDecimal(TB_InsolubleAsh.Text) : (decimal?)null;
            string insolubleAshRemarks = string.IsNullOrEmpty(TXB_InsolubleAsh_Remarks.Text) ? null : TXB_InsolubleAsh_Remarks.Text;

            decimal? solid = !string.IsNullOrWhiteSpace(TB_TotalSolid.Text) ? Convert.ToDecimal(TB_TotalSolid.Text) : (decimal?)null;
            string solidRemarks = string.IsNullOrEmpty(TXB_Solid_Remarks.Text) ? null : TXB_Solid_Remarks.Text;

            decimal? dextroseEquivalent = !string.IsNullOrWhiteSpace(TB_Dextrose.Text) ? Convert.ToDecimal(TB_Dextrose.Text) : (decimal?)null;
            string dextroseEquivalentRemarks = string.IsNullOrEmpty(TXB_Dextrose_Remarks.Text) ? null : TXB_Dextrose_Remarks.Text;

            decimal? titrableAcidity = !string.IsNullOrWhiteSpace(TB_TitrableAcidity.Text) ? Convert.ToDecimal(TB_TitrableAcidity.Text) : (decimal?)null;
            string titrableAcidityRemarks = string.IsNullOrEmpty(TXB_TitrableAcidity_Remarks.Text) ? null : TXB_TitrableAcidity_Remarks.Text;

            decimal? alcoholicAcidity = !string.IsNullOrWhiteSpace(TB_AlcoholicAcidity.Text) ? Convert.ToDecimal(TB_AlcoholicAcidity.Text) : (decimal?)null;
            string alcoholicAcidityRemarks = string.IsNullOrEmpty(TXB_AlcoholicAcidity.Text) ? null : TXB_AlcoholicAcidity.Text;

            decimal? sO2 = !string.IsNullOrWhiteSpace(TB_SO2.Text) ? Convert.ToDecimal(TB_SO2.Text) : (decimal?)null;
            string sO2Remarks = string.IsNullOrEmpty(TXB_SO2_Remarks.Text) ? null : TXB_SO2_Remarks.Text;

            decimal? glycerineContent = !string.IsNullOrWhiteSpace(TB_GlycerineContent.Text) ? Convert.ToDecimal(TB_GlycerineContent.Text) : (decimal?)null;
            string glycerineContentRemarks = string.IsNullOrEmpty(TXB_GlycerineContent_Remarks.Text) ? null : TXB_GlycerineContent_Remarks.Text;

            int? glucoseContent = string.IsNullOrEmpty(TB_GlucoseContent.Text) ? (int?)null : Convert.ToInt32(TB_GlucoseContent.Text);
            string glucoseContentRemarks = string.IsNullOrEmpty(TXB_GlucoseContent_Remarks.Text) ? null : TXB_GlucoseContent_Remarks.Text;

            decimal? lossOnDrying = !string.IsNullOrWhiteSpace(TB_LossOnDrying.Text) ? Convert.ToDecimal(TB_LossOnDrying.Text) : (decimal?)null;
            string lossOnDryingRemarks = string.IsNullOrEmpty(TXB_LossOnDrying_Remarks.Text) ? null : TXB_LossOnDrying_Remarks.Text;

            decimal? solubility = !string.IsNullOrWhiteSpace(TB_Solubility.Text) ? Convert.ToDecimal(TB_Solubility.Text) : (decimal?)null;
            string solubilityRemarks = string.IsNullOrEmpty(TXB_Solubility_Remarks.Text) ? null : TXB_Solubility_Remarks.Text;

            decimal? shapeOrSize = !string.IsNullOrWhiteSpace(TB_ShapeOrSize.Text) ? Convert.ToDecimal(TB_ShapeOrSize.Text) : (decimal?)null;
            string shapeOrSizeRemarks = string.IsNullOrEmpty(TXB_ShapeOrSize_Remarks.Text) ? null : TXB_ShapeOrSize_Remarks.Text;

            decimal? wim = !string.IsNullOrWhiteSpace(TB_WIM.Text) ? Convert.ToDecimal(TB_WIM.Text) : (decimal?)null;
            string wimRemarks = string.IsNullOrEmpty(TXB_WIM.Text) ? null : TXB_WIM.Text;

            DateTime submittedDate = DateTime.Now.Date;
            TimeSpan submittedTime = DateTime.Now.TimeOfDay;
            int submittedById = Convert.ToInt32(Session["USERID"].ToString());
            string submittedByEmployeeCode = Session["WORKMAN"].ToString();

            string approver1EmployeeCode = Approver1CodeLabel.Text.ToString();
            string approver2EmployeeCode = Approver1CodeLabel.Text.ToString();
            string dottedLineApproverEmployeeCode = DottedLineApproverCodeLabel.Text.ToString();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("SP_RM_CLASS_3", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Add parameters
                        command.Parameters.AddWithValue("@RMFID", rmfId);
                        command.Parameters.AddWithValue("@FormID", formID);

                        command.Parameters.AddWithValue("@PlantName", plantName);
                        command.Parameters.AddWithValue("@MaterialName", materialName);
                        command.Parameters.AddWithValue("@ProductBrand", productBrand);

                        command.Parameters.AddWithValue("@Supplier_Name", (object)supplier ?? DBNull.Value);
                        command.Parameters.AddWithValue("@Challan_No", (object)challanNo ?? DBNull.Value);
                        command.Parameters.AddWithValue("@Challan_Date", (object)challanDate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@Lot_No", (object)lotNo ?? DBNull.Value);
                        command.Parameters.AddWithValue("@Pkd_Date", (object)pkdMfgDate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@Vehicle_No", (object)vehicleNo ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Grade", (object)grade ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForGrade", (object)gradeRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Quantity", (object)quantity ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForQuantity", (object)quantityRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Color", (object)color ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForColor", (object)colorRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Smell", (object)smell ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForSmell", (object)smellRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Appearance", (object)appearance ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForAppearance", (object)appearanceRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Taste", (object)taste ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForTaste", (object)tasteRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Foreign_Matter_Impurities", (object)foreignImpurites ?? DBNull.Value);

                        command.Parameters.AddWithValue("@PH", (object)ph ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForPH", (object)phRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Moisture", (object)moisture ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForMoisture", (object)moistureRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Total_Ash", (object)ash ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForAsh", (object)ashRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Acid_Insoluble_Ash", (object)insolubleAsh ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForInsolubleAsh", (object)insolubleAshRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Total_Solids", (object)solid ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForSolid", (object)solidRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Dextrose_Equivalent", (object)dextroseEquivalent ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForDextroseEquivalent", (object)dextroseEquivalentRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Titrable_Acidity", (object)titrableAcidity ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForTitrableAcidity", (object)titrableAcidityRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Alcoholic_Acidity", (object)alcoholicAcidity ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForAlcoholicAcidity", (object)alcoholicAcidityRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@SO2", (object)sO2 ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForSO2", (object)sO2Remarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Glycerine_Content", (object)glycerineContent ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForGlycerineContent", (object)glycerineContentRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Glucose_Content", (object)glucoseContent ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForGlucoseContent", (object)glucoseContentRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Loss_On_Drying", (object)lossOnDrying ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForLossOnDrying", (object)lossOnDryingRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Solubility", (object)solubility ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForSolubility", (object)solubilityRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@ShapeOrSize", (object)shapeOrSize ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForShapeOrSize", (object)shapeOrSizeRemarks ?? DBNull.Value);

                        command.Parameters.AddWithValue("@WIM", (object)wim ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CommentsForWIM", (object)wim ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Material_Image", (object)ImgLink1 ?? DBNull.Value);

                        command.Parameters.AddWithValue("@SubmittedDate", submittedDate);
                        command.Parameters.AddWithValue("@SubmittedTime", submittedTime);
                        command.Parameters.AddWithValue("@SubmittedById", submittedById);
                        command.Parameters.AddWithValue("@SubmittedByEmployeeCode", (object)submittedByEmployeeCode ?? DBNull.Value);

                        command.Parameters.AddWithValue("@Approver1EmployeeCode", (object)approver1EmployeeCode ?? DBNull.Value);
                        command.Parameters.AddWithValue("@Approver2EmployeeCode", (object)approver2EmployeeCode ?? DBNull.Value);
                        command.Parameters.AddWithValue("@DottedLineApproverEmployeeCode", (object)dottedLineApproverEmployeeCode ?? DBNull.Value);


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
            DDL_Plant.Enabled = false;
            DDL_Material.Enabled = false;
            DDL_ProductBrand.Enabled = false;

            TB_Supplier.ReadOnly = true;
            TB_ChallanNo.ReadOnly = true;
            TB_ChallanDate.ReadOnly = true;
            TB_Quantity.ReadOnly = true;
            TXB_Quantity_Remarks.ReadOnly = true;
            TB_LotNo.ReadOnly = true;
            TB_PkdMfg.ReadOnly = true;
            TB_VehicleNo.ReadOnly = true;
            TB_Grade.ReadOnly = true;
            TXB_Grade_Remarks.ReadOnly = true;

            RBL_Smell.Enabled = false;
            TXB_Smell_Remarks.ReadOnly = true;

            RBL_Appearance.Enabled = false;
            TXB_Appearance_Remarks.ReadOnly = true;

            DDL_Color.Enabled = false;
            TXB_Color_Remarks.ReadOnly = true;

            RBL_TasteFlavor.Enabled = false;
            TXB_TasteFlavor_Remarks.ReadOnly = true;

            TB_Foreign_Impurities.ReadOnly = true;

            TB_PH.ReadOnly = true;
            TXB_PH_Remarks.ReadOnly = true;

            TB_Moisture.ReadOnly = true;
            TXB_Moisture_Remarks.ReadOnly = true;

            TB_TotalAsh.ReadOnly = true;
            TXB_Ash_Remarks.ReadOnly = true;

            TB_InsolubleAsh.ReadOnly = true;
            TXB_InsolubleAsh_Remarks.ReadOnly = true;

            TB_TotalSolid.ReadOnly = true;
            TXB_Solid_Remarks.ReadOnly = true;

            TB_Dextrose.ReadOnly = true;
            TXB_Dextrose_Remarks.ReadOnly = true;

            TB_TitrableAcidity.ReadOnly = true;
            TXB_TitrableAcidity_Remarks.ReadOnly = true;

            TB_AlcoholicAcidity.ReadOnly = true;
            TXB_AlcoholicAcidity.ReadOnly = true;

            TB_SO2.ReadOnly = true;
            TXB_SO2_Remarks.ReadOnly = true;

            TB_GlycerineContent.ReadOnly = true;
            TXB_GlycerineContent_Remarks.ReadOnly = true;

            TB_GlucoseContent.ReadOnly = true;
            TXB_GlucoseContent_Remarks.ReadOnly = true;

            TB_LossOnDrying.ReadOnly = true;
            TXB_LossOnDrying_Remarks.ReadOnly = true;

            TB_Solubility.ReadOnly = true;
            TXB_Solubility_Remarks.ReadOnly = true;

            TB_ShapeOrSize.ReadOnly = true;
            TXB_ShapeOrSize_Remarks.ReadOnly = true;

            TB_WIM.ReadOnly = true;
            TXB_WIM.ReadOnly = true;

            BtnSave.Enabled = false;
            BtnSave.Text = "SAVED";
            BtnSave.CssClass = "btn btn-sm btn-success";

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
            Response.Redirect("RM_Class_3.aspx");
        }

        private void PopulateColorDropdown()
        {
            // Add the "Select" option as the first item
            DDL_Color.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_Color.Items.Add(new ListItem("Brown", "Brown"));
            DDL_Color.Items.Add(new ListItem("Yellow", "Yellow"));
            DDL_Color.Items.Add(new ListItem("White", "White"));
            DDL_Color.Items.Add(new ListItem("Colourless", "Colourless"));
            DDL_Color.Items.Add(new ListItem("Other", "Other"));

        }
        protected void DDL_Color_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (DDL_Color.SelectedItem.Text == "Select")
            {

                DatabaseHelper.BindWithDefaultNoRecords(DDL_Color);

                string DDL_Color_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowColorInvalidErrorNotification", DDL_Color_Error_script, false);


            }
            else if (DDL_Color.SelectedItem.Text == "Other")
            {
                ColorRemarksDiv.Style["display"] = "block";
            }
            else
            {
                // Hide custom color input fields
                ColorRemarksDiv.Style["display"] = "none";
            }

        }

        private void SetUpValidatorsForField(string fieldName, ValidationCriteria criteria)
        {
            switch (fieldName)
            {
                case "Quantity":

                    RFV_TB_Quantity.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Quantity.Enabled = criteria.IsRequired;

                    TB_Quantity.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Quantity.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Quantity.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Quantity.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Quantity.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Quantity.Enabled = criteria.IsRangeRequired;

                    hdnMinQtyValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxQtyValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "GradeValue":

                    RFV_TB_Grade.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Grade.Enabled = criteria.IsRequired;

                    TB_Grade.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Grade.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Grade.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Grade.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Grade.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Grade.Enabled = criteria.IsRangeRequired;

                    hdnMinGradeValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxGradeValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "PhValue":

                    RFV_TB_PH.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_PH.Enabled = criteria.IsRequired;

                    TB_PH.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_PH.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_PH.ValidationExpression = criteria.RegularExpression;
                    REV_TB_PH.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_PH.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_PH.Enabled = criteria.IsRangeRequired;

                    hdnMinPhValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxPhValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "MoistureValue":

                    RFV_TB_Moisture.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Moisture.Enabled = criteria.IsRequired;

                    TB_Moisture.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Moisture.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Moisture.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Moisture.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Moisture.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Moisture.Enabled = criteria.IsRangeRequired;

                    hdnMinMoistureValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxMoistureValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "TotalAshValue":

                    RFV_TB_TotalAsh.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_TotalAsh.Enabled = criteria.IsRequired;

                    TB_TotalAsh.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_TotalAsh.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_TotalAsh.ValidationExpression = criteria.RegularExpression;
                    REV_TB_TotalAsh.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_TotalAsh.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_TotalAsh.Enabled = criteria.IsRangeRequired;

                    hdnMinTotalAshValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxTotalAshValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "InsolubleAshValue":

                    RFV_TB_InsolubleAsh.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_InsolubleAsh.Enabled = criteria.IsRequired;

                    TB_InsolubleAsh.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_InsolubleAsh.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_InsolubleAsh.ValidationExpression = criteria.RegularExpression;
                    REV_TB_InsolubleAsh.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_InsolubleAsh.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_InsolubleAsh.Enabled = criteria.IsRangeRequired;

                    hdnMinInsolubleAshValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxInsolubleAshValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "TotalSolidValue":

                    RFV_TB_TotalSolid.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_TotalSolid.Enabled = criteria.IsRequired;

                    TB_TotalSolid.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_TotalSolid.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_TotalSolid.ValidationExpression = criteria.RegularExpression;
                    REV_TB_TotalSolid.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_TotalSolid.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_TotalSolid.Enabled = criteria.IsRangeRequired;

                    hdnMinTotalSolidValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxTotalSolidValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "DextroseEquivalentValue":

                    RFV_TB_Dextrose.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Dextrose.Enabled = criteria.IsRequired;

                    TB_Dextrose.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Dextrose.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Dextrose.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Dextrose.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Dextrose.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Dextrose.Enabled = criteria.IsRangeRequired;

                    hdnMinDextroseValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxDextroseValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "TitrableAcidityValue":

                    RFV_TB_TitrableAcidity.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_TitrableAcidity.Enabled = criteria.IsRequired;

                    TB_TitrableAcidity.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_TitrableAcidity.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_TitrableAcidity.ValidationExpression = criteria.RegularExpression;
                    REV_TB_TitrableAcidity.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_TitrableAcidity.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_TitrableAcidity.Enabled = criteria.IsRangeRequired;

                    hdnMinTitrableAcidityValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxTitrableAcidityValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "AlcoholicAcidityValue":

                    RFV_TB_AlcoholicAcidity.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_AlcoholicAcidity.Enabled = criteria.IsRequired;

                    TB_AlcoholicAcidity.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_AlcoholicAcidity.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_AlcoholicAcidity.ValidationExpression = criteria.RegularExpression;
                    REV_TB_AlcoholicAcidity.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_AlcoholicAcidity.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_AlcoholicAcidity.Enabled = criteria.IsRangeRequired;

                    hdnMinAlcoholicAcidityValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxAlcoholicAcidityValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "SO2Value":

                    RFV_TB_SO2.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_SO2.Enabled = criteria.IsRequired;

                    TB_SO2.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_SO2.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_SO2.ValidationExpression = criteria.RegularExpression;
                    REV_TB_SO2.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_SO2.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_SO2.Enabled = criteria.IsRangeRequired;

                    hdnMinSO2Value.Value = criteria.MinimumValue.ToString();
                    hdnMaxSO2Value.Value = criteria.MaximumValue.ToString();
                    break;

                case "GlycerineContentValue":

                    RFV_TB_GlycerineContent.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_GlycerineContent.Enabled = criteria.IsRequired;

                    TB_GlycerineContent.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_GlycerineContent.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_GlycerineContent.ValidationExpression = criteria.RegularExpression;
                    REV_TB_GlycerineContent.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_GlycerineContent.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_GlycerineContent.Enabled = criteria.IsRangeRequired;

                    hdnMinGlycerineContentValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxGlycerineContentValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "GlucoseContentValue":

                    RFV_TB_GlucoseContent.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_GlucoseContent.Enabled = criteria.IsRequired;

                    TB_GlucoseContent.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_GlucoseContent.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_GlucoseContent.ValidationExpression = criteria.RegularExpression;
                    REV_TB_GlucoseContent.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_GlucoseContent.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_GlucoseContent.Enabled = criteria.IsRangeRequired;

                    hdnMinGlucoseContentValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxGlucoseContentValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "LossOnDryingValue":

                    RFV_TB_LossOnDrying.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_LossOnDrying.Enabled = criteria.IsRequired;

                    TB_LossOnDrying.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_LossOnDrying.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_LossOnDrying.ValidationExpression = criteria.RegularExpression;
                    REV_TB_LossOnDrying.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_LossOnDrying.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_LossOnDrying.Enabled = criteria.IsRangeRequired;

                    hdnMaxLossonDryingValue.Value = criteria.MinimumValue.ToString();
                    hdnMinLossonDryingValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "SolubilityValue":

                    RFV_TB_Solubility.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Solubility.Enabled = criteria.IsRequired;

                    TB_Solubility.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Solubility.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Solubility.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Solubility.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Solubility.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Solubility.Enabled = criteria.IsRangeRequired;

                    hdnMaxSolubilityValue.Value = criteria.MinimumValue.ToString();
                    hdnMinSolubilityValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "ShapeOrSizeValue":

                    RFV_TB_ShapeOrSize.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_ShapeOrSize.Enabled = criteria.IsRequired;

                    TB_ShapeOrSize.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_ShapeOrSize.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_ShapeOrSize.ValidationExpression = criteria.RegularExpression;
                    REV_TB_ShapeOrSize.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_ShapeOrSize.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_ShapeOrSize.Enabled = criteria.IsRangeRequired;

                    hdnMinShapeSizeValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxShapeSizeValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "WIMValue":

                    RFV_TB_WIM.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_WIM.Enabled = criteria.IsRequired;

                    TB_WIM.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_WIM.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_WIM.ValidationExpression = criteria.RegularExpression;
                    REV_TB_WIM.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_WIM.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_WIM.Enabled = criteria.IsRangeRequired;

                    hdnMinWIMValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxWIMValue.Value = criteria.MaximumValue.ToString();
                    break;


                default:
                    // Handle unrecognized field names
                    break;
            }
        }

        private void DivBinders(string selectedMaterialValue)
        {
            string selectedMaterial = DDL_Material.SelectedItem.Text;

            SetControlsVisible(Page.Controls, false);
            FU_MaterialImage_Upldr.Visible = false;
            FU_MaterialImage.Visible = false;

            // Show relevant controls based on the selected material
            switch (selectedMaterial)
            {
                case "Sugar":

                    //Product Brand
                    BrandDIV.Visible = true;

                    //Supplier	
                    SupplierDIV.Visible = true;

                    //Challan No & Date	
                    ChallanNoDIV.Visible = true;
                    ChallanDateDIV.Visible = true;

                    //QTY	
                    QuantityDIV.Visible = true;

                    //Lot No/ Batch No.
                    LotNoDIV.Visible = true;

                    //Pkd/Mfg Date	
                    PkdMfgDIV.Visible = true;

                    //Colour	
                    ColorDIV.Visible = true;
                    ColorRemarksDiv.Visible = true;

                    //Odour/Smell	
                    SmellDIV.Visible = true;

                    //Appearance	
                    AppearanceDIV.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //Foreign Matter/Impurities
                    ImpuritiesDIV.Visible = true;

                    //Shape/Size 
                    ShapeOrSizeDIV.Visible = true;

                    //WIM 
                    WIMDIV.Visible = true;

                    //Image
                    FU_MaterialImage_Upldr.Visible = true;
                    FU_MaterialImage.Visible = true;
                    break;

                case "Maltodextrin":
                    //Supplier	
                    SupplierDIV.Visible = true;

                    //Challan No & Date	
                    ChallanNoDIV.Visible = true;
                    ChallanDateDIV.Visible = true;

                    //QTY	
                    QuantityDIV.Visible = true;

                    //Lot No/ Batch No.
                    LotNoDIV.Visible = true;

                    //Pkd/Mfg Date	
                    PkdMfgDIV.Visible = true;

                    //Vehicle No	
                    VehicleNoDIV.Visible = true;

                    //Colour	
                    ColorDIV.Visible = true;
                    ColorRemarksDiv.Visible = true;

                    //Odour/Smell	
                    SmellDIV.Visible = true;

                    //Appearance	
                    AppearanceDIV.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //Moisture		
                    MoistureDIV.Visible = true;

                    //Total Solids	
                    SolidDIV.Visible = true;

                    //Loss On Drying
                    LossOnDryingDIV.Visible = true;

                    //Solubility
                    SolubilityDIV.Visible = true;

                    //Image
                    FU_MaterialImage_Upldr.Visible = true;
                    FU_MaterialImage.Visible = true;
                    break;

                case "Dextrose":

                    //Supplier	
                    SupplierDIV.Visible = true;

                    //Challan No & Date	
                    ChallanNoDIV.Visible = true;
                    ChallanDateDIV.Visible = true;

                    //QTY	
                    QuantityDIV.Visible = true;

                    //Pkd/Mfg Date	
                    PkdMfgDIV.Visible = true;

                    //Vehicle No	
                    VehicleNoDIV.Visible = true;

                    //Colour	
                    ColorDIV.Visible = true;
                    ColorRemarksDiv.Visible = true;

                    //Odour/Smell	
                    SmellDIV.Visible = true;

                    //Appearance	
                    AppearanceDIV.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //Titrable Acidity
                    TitrableAcidityDIV.Visible = true;

                    //SO2
                    SO2DIV.Visible = true;

                    //Glucose Content
                    GlucoseContentDIV.Visible = true;

                    //Loss On Drying
                    LossOnDryingDIV.Visible = true;

                    //Image
                    FU_MaterialImage_Upldr.Visible = true;
                    FU_MaterialImage.Visible = true;
                    break;

                case "Glycerine":

                    //Product Brand
                    BrandDIV.Visible = true;

                    // Supplier
                    SupplierDIV.Visible = true;

                    //Challan No & Date	
                    ChallanDateDIV.Visible = true;
                    ChallanNoDIV.Visible = true;

                    //QTY	
                    QuantityDIV.Visible = true;

                    //Lot No/ Batch No.
                    LotNoDIV.Visible = true;

                    //Pkd/Mfg Date	
                    PkdMfgDIV.Visible = true;

                    //Vehicle No	
                    VehicleNoDIV.Visible = true;

                    //Grade
                    GradeDIV.Visible = true;

                    //Colour	
                    ColorDIV.Visible = true;
                    ColorRemarksDiv.Visible = true;

                    //Odour/Smell	
                    SmellDIV.Visible = true;

                    //Appearance	
                    AppearanceDIV.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;
                    
                    //Glycerine Content
                    GlycerineContentDIV.Visible = true;


                    //Image
                    FU_MaterialImage_Upldr.Visible = true;
                    FU_MaterialImage.Visible = true;
                    break;

                case "Glucose":

                    //Product Brand
                    BrandDIV.Visible = true;

                    // Supplier
                    SupplierDIV.Visible = true;

                    //Challan No & Date	
                    ChallanDateDIV.Visible = true;
                    ChallanNoDIV.Visible = true;

                    //QTY	
                    QuantityDIV.Visible = true;

                    //Lot No/ Batch No.
                    LotNoDIV.Visible = true;

                    //Vehicle No	
                    VehicleNoDIV.Visible = true;

                    //Colour	
                    ColorDIV.Visible = true;
                    ColorRemarksDiv.Visible = true;

                    //Appearance	
                    AppearanceDIV.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //Foreign Matter/Impurities
                    ImpuritiesDIV.Visible = true;

                    //pH
                    PHDIV.Visible = true;

                    //Moisture		
                    MoistureDIV.Visible = true;

                    //Total Solids
                    SolidDIV.Visible = true;

                    //Dextrose Equivalent
                    DextroseDIV.Visible = true;

                    //Image
                    FU_MaterialImage_Upldr.Visible = true;
                    FU_MaterialImage.Visible = true;
                    break;

                case "Starch":
                    // Supplier
                    SupplierDIV.Visible = true;

                    //Product Brand
                    BrandDIV.Visible = true;

                    //Challan No & Date	
                    ChallanDateDIV.Visible = true;
                    ChallanNoDIV.Visible = true;

                    //Lot No/ Batch No.
                    LotNoDIV.Visible = true;

                    //Vehicle No	
                    VehicleNoDIV.Visible = true;

                    //Colour	
                    ColorDIV.Visible = true;
                    ColorRemarksDiv.Visible = true;

                    //Odour/Smell	
                    SmellDIV.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //Moisture		
                    MoistureDIV.Visible = true;

                    //Total Ash			
                    AshDIV.Visible = true;

                    //Acid Insoluble Ash
                    InsolubleAshDIV.Visible = true;

                    //Alcoholic Acidity
                    AlcoholicAcidityDIV.Visible = true;

                    //SO2
                    SO2DIV.Visible = true;

                    //Image
                    FU_MaterialImage_Upldr.Visible = true;
                    FU_MaterialImage.Visible = true;
                    break;

                

                default:
                    // Optionally handle a default case
                    break;
            }
        }

    }
}