using DocumentFormat.OpenXml.Vml;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using DocumentFormat.OpenXml.Bibliography;
using OfficeOpenXml.FormulaParsing.Excel.Functions.Database;

namespace AnmolDristi
{
    public partial class RM_Class_3_Detailed : System.Web.UI.Page
    {
        public static Int32 RecordID = 0;

        public static string MaterialId = string.Empty;
        public static string MaterialName = string.Empty;
        public static string PlantId = string.Empty;
        public static string PlantName = string.Empty;
        public static string PlantLine = string.Empty;
        public static string CategoryBrand = string.Empty;
        public static string Color = string.Empty;

        public static string App1_Status = string.Empty;
        public static string App2_Status = string.Empty;
        public static string DottedApp_Status = string.Empty;
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
                    MaterialBinder();

                    //below to bind the report details from TRN Tables
                    RecordID = Convert.ToInt32(Request.QueryString["ID"]);

                    // Call the new method to load data
                    LoadRecordData(RecordID);
                }

                string source = Request.QueryString["source"];

                if (source == "submitter")
                {
                    BtnApprove.Visible = false;
                    BtnReject.Visible = false;
                    BtnBack.PostBackUrl = "~/RM_Class_3_Submitter.aspx";
                    Lbl_BasicbtnApprove.Text = "Click on your Action";

                }
                else
                {
                    BtnBack.PostBackUrl = "~/RM_Class_3_Approval.aspx";
                }
            }
        }


        private void LoadRecordData(int recordID)
        {
            DataTable dt = FetchRecordById(recordID);
            if (dt.Rows.Count > 0)
            {
                getDetails(dt);
            }
            else
            {
                // Handle case where no data is found
            }
        }

        private DataTable FetchRecordById(int id)
        {
            DataTable dt = new DataTable();
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string query = @"
                        SELECT
                        P.MaterialName as MaterialId,
                        P.PlantName as PlantID,
	                    P.Line,
	                    P.ProductBrand,

                        M.Material_Name,
                        A.plant_name,
	                    L.line_name,
	                    pb.brand_name,
                        P.*
                    FROM
                        TRN_RM_CLASS_3 P
                    LEFT JOIN dbo.RM_MATERIAL M ON P.MaterialName = M.Material_Id
                    LEFT JOIN dbo.MST_PlantDetails A ON P.PlantName = A.plant_id
                    LEFT JOIN dbo.MST_Plant_Lines L ON P.Line = L.line_id
                    LEFT JOIN dbo.MST_LineCatBrands pb ON P.ProductBrand = pb.brand_id
                    WHERE P.Id = @Id";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }
            return dt;
        }

        private void MaterialBinder()
        {
            string query = "SELECT Material_Id, Material_Name FROM RM_Material where Class = 3";
            string textField = "Material_Name";
            string valueField = "Material_Id";

            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Material, textField, valueField, out recordsBound);

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
                ClientScript.RegisterStartupScript(this.GetType(), "ShowMaterialBinderErrorNotification", MaterialBinder_Error_script, false);
            }
        }

        private void PlantBinder(string selectedMaterialValue)
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

        private void LineBrandsBinder(string selectedPlantValue, string selectedPlantLineValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT brand_id, brand_name FROM MST_LineCatBrands WHERE plant_id = @PlantId ";
            string textField = "brand_name"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "brand_id"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@PlantId", selectedPlantValue),
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


        void getDetails(DataTable dt)
        {

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];

                MaterialId = dt.Rows[0]["MaterialId"].ToString();
                MaterialName = dt.Rows[0]["Material_Name"].ToString();
                DDL_Material.SelectedItem.Text = MaterialName;
                DDL_Material.Enabled = false;

                PlantBinder(MaterialId);
                PlantId = dt.Rows[0]["PlantId"].ToString();
                PlantName = dt.Rows[0]["plant_name"].ToString();
                DDL_Plant.SelectedValue = PlantId;
                DDL_Plant.Enabled = false;

                PlantLinesBinder(PlantId);
                PlantLine = dt.Rows[0]["line"].ToString();
                DDL_PlantLine.SelectedValue = PlantLine;
                DDL_PlantLine.Enabled = false;

                //TB_Brand.Text = dt.Rows[0]["ProductBrand"].ToString();

                string CategoryBrand = dt.Rows[0]["ProductBrand"].ToString();
                if (!string.IsNullOrEmpty(CategoryBrand) && CategoryBrand != "0")
                {
                    LineBrandsBinder(PlantId, PlantLine);

                    if (DDL_ProductBrand.Items.FindByValue(CategoryBrand) != null)
                    {
                        DDL_ProductBrand.SelectedValue = CategoryBrand;
                        DDL_ProductBrand.Enabled = false;
                    }
                }


                TB_Supplier.Text = dt.Rows[0]["Supplier_Name"].ToString();

                TB_ChallanNo.Text = dt.Rows[0]["Challan_No"].ToString();
                TB_ChallanDate.Text = dt.Rows[0]["Challan_Date"].ToString();
                TB_LotNo.Text = dt.Rows[0]["Lot_No"].ToString();
                TB_VehicleNo.Text = dt.Rows[0]["Vehicle_No"].ToString();
                TB_PkdMfg.Text = dt.Rows[0]["Pkd_Date"].ToString();

                TB_MfgName.Text = dt.Rows[0]["MfgName"].ToString();
                TB_BeforeDate.Text = dt.Rows[0]["BeforeDate"].ToString();
                TB_FssaiNo.Text = dt.Rows[0]["FssaiNo"].ToString();
                RBL_Fssai_Logo.SelectedValue = dt.Rows[0]["Fssai_Logo"].ToString();
                RBL_Veg_Logo.SelectedValue = dt.Rows[0]["Veg_Logo"].ToString();

                RBL_Packing_Condition.SelectedValue = dt.Rows[0]["Packing_Condition"].ToString();
                TXB_PackingCondition_Remarks.Text = dt.Rows[0]["PackingCondition_Remarks"].ToString();

                TB_Quantity.Text = dt.Rows[0]["Quantity"].ToString();
                TXB_Quantity_Remarks.Text = dt.Rows[0]["CommentsForQuantity"].ToString();

                RBL_Grade.SelectedValue = dt.Rows[0]["Grade"].ToString();
                TXB_Grade_Remarks.Text = dt.Rows[0]["CommentsForGrade"].ToString();

                PopulateColorDropdown();
                Color = dt.Rows[0]["Color"].ToString();
                DDL_Color.SelectedValue = Color;
                TXB_Color_Remarks.Text = dt.Rows[0]["CommentsForColor"].ToString();
                DDL_Color.Enabled = false;

                RBL_Smell.SelectedValue = dt.Rows[0]["Smell"].ToString();
                TXB_Smell_Remarks.Text = dt.Rows[0]["CommentsForSmell"].ToString();

                RBL_Appearance.SelectedValue = dt.Rows[0]["Appearance"].ToString();
                TXB_Appearance_Remarks.Text = dt.Rows[0]["CommentsForAppearance"].ToString();

                RBL_TasteFlavor.SelectedValue = dt.Rows[0]["Taste"].ToString();
                TXB_TasteFlavor_Remarks.Text = dt.Rows[0]["CommentsForTaste"].ToString();

                TB_Foreign_Impurities.Text = dt.Rows[0]["Foreign_Matter_Impurities"].ToString();

                TB_PH.Text = dt.Rows[0]["PH"].ToString();
                TXB_PH_Remarks.Text = dt.Rows[0]["CommentsForPH"].ToString();

                TB_Moisture.Text = dt.Rows[0]["Moisture"].ToString();
                TXB_Moisture_Remarks.Text = dt.Rows[0]["CommentsForMoisture"].ToString();

                TB_TotalAsh.Text = dt.Rows[0]["Total_Ash"].ToString();
                TXB_Ash_Remarks.Text = dt.Rows[0]["CommentsForTotalAsh"].ToString();

                TB_InsolubleAsh.Text = dt.Rows[0]["Acid_Insoluble_Ash"].ToString();
                TXB_InsolubleAsh_Remarks.Text = dt.Rows[0]["CommentsForInsolubleAsh"].ToString();

                TB_TotalSolid.Text = dt.Rows[0]["Total_Solids"].ToString();
                TXB_Solid_Remarks.Text = dt.Rows[0]["CommentsForSolid"].ToString();

                TB_Dextrose.Text = dt.Rows[0]["Dextrose_Equivalent"].ToString();
                TXB_Solid_Remarks.Text = dt.Rows[0]["CommentsForDextroseEquivalent"].ToString();

                TB_TitrableAcidity.Text = dt.Rows[0]["Titrable_Acidity"].ToString();
                TXB_TitrableAcidity_Remarks.Text = dt.Rows[0]["CommentsForTitrableAcidity"].ToString();

                TB_AlcoholicAcidity.Text = dt.Rows[0]["Alcoholic_Acidity"].ToString();
                TXB_AlcoholicAcidity.Text = dt.Rows[0]["CommentsForAlcoholicAcidity"].ToString();

                TB_SO2.Text = dt.Rows[0]["SO2"].ToString();
                TXB_SO2_Remarks.Text = dt.Rows[0]["CommentsForSO2"].ToString();

                TB_GlycerineContent.Text = dt.Rows[0]["Glycerine_Content"].ToString();
                TXB_GlycerineContent_Remarks.Text = dt.Rows[0]["CommentsForGlycerineContent"].ToString();

                TB_GlucoseContent.Text = dt.Rows[0]["Glucose_Content"].ToString();
                TXB_GlucoseContent_Remarks.Text = dt.Rows[0]["CommentsForGlucoseContent"].ToString();

                TB_LossOnDrying.Text = dt.Rows[0]["Loss_On_Drying"].ToString();
                TXB_LossOnDrying_Remarks.Text = dt.Rows[0]["CommentsForLossOnDrying"].ToString();

                TB_Solubility.Text = dt.Rows[0]["Solubility"].ToString();
                TXB_Solubility_Remarks.Text = dt.Rows[0]["CommentsForSolubility"].ToString();

                TB_WIM.Text = dt.Rows[0]["WIM"].ToString();
                TXB_WIM.Text = dt.Rows[0]["CommentsForWIM"].ToString();

                TB_ShapeOrSize.Text = dt.Rows[0]["ShapeOrSize"].ToString();
                TXB_ShapeOrSize_Remarks.Text = dt.Rows[0]["CommentsForShapeOrSize"].ToString();

                TB_Sucrose.Text = dt.Rows[0]["Sucrose_Content"].ToString();
                TXB_Sucrose.Text = dt.Rows[0]["CommentsForSucroseContent"].ToString();

                TB_Sulphide.Text = dt.Rows[0]["Sulphide_Content"].ToString();
                TXB_Sulphide.Text = dt.Rows[0]["CommentsForSulphideContent"].ToString();

                TB_SulphatedAsh.Text = dt.Rows[0]["SulphatedAsh"].ToString();
                TXB_SulphatedAsh_Remarks.Text = dt.Rows[0]["CommentsForSulphatedAsh"].ToString();

                RBL_Beverage.SelectedValue = dt.Rows[0]["Beverage"].ToString();

                imgMaterial.ImageUrl = dt.Rows[0]["Material_Image"].ToString();


                StandardValue_Binder(MaterialId, PlantId); // Texbox bind with std values
                string FormID = row["FormID"].ToString();
                LoadFormDetails(FormID, PlantId, PlantLine);

                // Assume the logged-in user's Employee Code is stored in a session variable
                string loggedInUserCode = Session["WORKMAN"].ToString(); // Example session variable

                // Retrieve approval statuses from the row
                App1_Status = row["Approver1_Status"].ToString();
                Approver1CodeLabel.Text = row["Approver1EmployeeCode"].ToString();

                App2_Status = row["Approver2_Status"].ToString();
                Approver2CodeLabel.Text = row["Approver2EmployeeCode"].ToString();

                DottedApp_Status = row["DottedApprover_Status"].ToString();
                DottedLineApproverCodeLabel.Text = row["DottedLineApproverEmployeeCode"].ToString();

                // Get the source parameter from the query string
                string source = Request.QueryString["source"];

                // Check if the page is accessed as a submitter
                bool isSubmitter = (source == "submitter");


                // Boolean flag to track if the logged-in user is one of the approvers
                bool isApprover = false;


                // Approver 1
                if (App1_Status == "0") // Pending
                {
                    Approver1CodeLabel.ForeColor = System.Drawing.Color.Brown;
                    if (loggedInUserCode == row["Approver1EmployeeCode"].ToString())
                    {
                        BtnApprove.Enabled = true;
                        BtnReject.Enabled = true;
                        isApprover = true;
                    }
                }
                else if (App1_Status == "1") // Approved
                {
                    Approver1CodeLabel.ForeColor = System.Drawing.Color.Green;
                    if (loggedInUserCode == row["Approver1EmployeeCode"].ToString())
                    {
                        BtnApprove.Text = "Approved";
                        BtnApprove.Enabled = false;
                        BtnReject.Enabled = false;
                        isApprover = true;
                        Lbl_BasicbtnApprove.Text = "You have approved!";
                    }
                }

                // Approver 2
                if (App2_Status == "0") // Pending
                {
                    Approver2CodeLabel.ForeColor = System.Drawing.Color.Brown;
                    if (loggedInUserCode == row["Approver2EmployeeCode"].ToString())
                    {
                        BtnApprove.Enabled = true;
                        BtnReject.Enabled = true;
                        isApprover = true;
                    }
                }
                else if (App2_Status == "1") // Approved
                {
                    Approver2CodeLabel.ForeColor = System.Drawing.Color.Green;
                    if (loggedInUserCode == row["Approver2EmployeeCode"].ToString())
                    {
                        BtnApprove.Text = "Approved";
                        BtnApprove.Enabled = false;
                        BtnReject.Enabled = false;
                        isApprover = true;
                        Lbl_BasicbtnApprove.Text = "You have approved!";

                    }
                }

                // Dotted Line Approver
                if (DottedApp_Status == "0") // Pending
                {
                    DottedLineApproverCodeLabel.ForeColor = System.Drawing.Color.Brown;
                    if (loggedInUserCode == row["DottedLineApproverEmployeeCode"].ToString())
                    {
                        BtnApprove.Enabled = true;
                        BtnReject.Enabled = true;
                        isApprover = true;
                    }
                }
                else if (DottedApp_Status == "1")  // Approved
                {
                    DottedLineApproverCodeLabel.ForeColor = System.Drawing.Color.Green;
                    if (loggedInUserCode == row["DottedLineApproverEmployeeCode"].ToString())
                    {
                        BtnApprove.Text = "Approved";
                        BtnApprove.Enabled = false;
                        BtnReject.Enabled = false;
                        isApprover = true;
                        Lbl_BasicbtnApprove.Text = "You have approved!";
                    }
                }

                // If the logged-in user is not any of the approvers
                if (!isApprover && !isSubmitter)
                {
                    // Option 1: Disable the buttons
                    BtnApprove.Enabled = false;
                    BtnReject.Enabled = false;

                    // Option 2: Hide the buttons entirely
                    // btnApprove.Visible = false;
                    // btnReject.Visible = false;
                    string PlantBinder_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'You are not authorized to approve!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";

                    // RegisterStartupScript adds the JavaScript code to the page
                    ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantBinderErrorNotification", PlantBinder_Error_script, false);
                    Lbl_BasicbtnApprove.Text = "You are not authorized to approve or reject this form.";

                }


                // Combined Actions - Example for handling when all approvers have approved
                if (App1_Status == "1" && App2_Status == "1" && DottedApp_Status == "1")
                {
                    // Perform action when all approvers have approved
                    // Example: Allow form submission or update status
                }
                else if (App1_Status == "0" || App2_Status == "0" || DottedApp_Status == "0")
                {
                    // Perform action when any approver is still pending
                    // Example: Disable form submission or show a pending message
                }



                //ScriptManager.RegisterStartupScript(this, GetType(), "triggerButtonClick", Page.ClientScript.GetPostBackEventReference(BtnValidate, ""), true);

            }

        }


        public class ValidationCriteria
        {
            public string DisplayName { get; set; }
            public bool IsVisible { get; set; }
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


        private void StandardValue_Binder(string MaterialId, string PlantId)
        {
            DataTable dataTable = DatabaseHelper.GetRMFieldsControlByPlantId(Convert.ToInt32(MaterialId), Convert.ToInt32(PlantId));


            // Example: Querying the DataTable for a specific field name
            //string fieldName = "no_of_pcs"; // Specify the field name you want to query
            //DataRow[] rows = dataTable.Select($"brand_id = {selectedProductBrandValue} AND field_name = '{fieldName}'");

            // Iterate through the filtered rows and extract validation criteria
            foreach (DataRow row in dataTable.Rows)
            {
                // Extract field name from the current row
                string fieldName = row["field_name"].ToString();
                string displayName = row["DisplayName"].ToString();

                // Extract validation criteria from the DataRow
                bool isVisible = Convert.ToBoolean(row["ViewMode"]);
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
                criteria.DisplayName = displayName;
                criteria.IsVisible = isVisible;
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

        private void SetUpValidatorsForField(string fieldName, ValidationCriteria criteria)
        {
            switch (fieldName)
            {
                case "ProductBrand":

                    BrandDIV.Visible = criteria.IsVisible;
                    Label_DDL_ProductBrand.Text = criteria.DisplayName;

                    RFV_DDL_ProductBrand.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_DDL_ProductBrand.Enabled = criteria.IsRequired;

                    break;

                case "Supplier":
                    SupplierDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Supplier.Text = criteria.DisplayName;

                    RFV_TB_Supplier.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Supplier.Enabled = criteria.IsRequired;

                    TB_Supplier.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Supplier.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Supplier.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Supplier.Enabled = criteria.IsRegularExpressionRequired;

                    hdnMinSupplierValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxSupplierValue.Value = criteria.MaximumValue.ToString();

                    break;

                case "ChallanDate":

                    ChallanDateDIV.Visible = criteria.IsVisible;
                    Lbl_TB_ChallanDate.Text = criteria.DisplayName;

                    RFV_TB_ChallanDate.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_ChallanDate.Enabled = criteria.IsRequired;

                    break;

                case "ChallanNo":

                    ChallanNoDIV.Visible = criteria.IsVisible;
                    Lbl_TB_ChallanNo.Text = criteria.DisplayName;

                    RFV_TB_ChallanNo.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_ChallanNo.Enabled = criteria.IsRequired;

                    TB_ChallanNo.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_ChallanNo.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_ChallanNo.ValidationExpression = criteria.RegularExpression;
                    REV_TB_ChallanNo.Enabled = criteria.IsRegularExpressionRequired;


                    break;

                case "Quantity":

                    QuantityDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Quantity.Text = criteria.DisplayName;

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

                case "Lot/Batch":

                    LotNoDIV.Visible = criteria.IsVisible;
                    Lbl_TB_LotNo.Text = criteria.DisplayName;

                    RFV_TB_LotNo.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_LotNo.Enabled = criteria.IsRequired;

                    TB_LotNo.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_LotNo.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_LotNo.ValidationExpression = criteria.RegularExpression;
                    REV_TB_LotNo.Enabled = criteria.IsRegularExpressionRequired;


                    break;

                case "Vehicle":

                    VehicleNoDIV.Visible = criteria.IsVisible;
                    Lbl_TB_VehicleNo.Text = criteria.DisplayName;

                    RFV_TB_VehicleNo.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_VehicleNo.Enabled = criteria.IsRequired;

                    TB_VehicleNo.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_VehicleNo.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_VehicleNo.ValidationExpression = criteria.RegularExpression;
                    REV_TB_VehicleNo.Enabled = criteria.IsRegularExpressionRequired;

                    break;

                case "Pkd/MfgDate":

                    PkdMfgDIV.Visible = criteria.IsVisible;
                    Lbl_TB_PkdMfg.Text = criteria.DisplayName;

                    RFV_TB_PkdMfg.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_PkdMfg.Enabled = criteria.IsRequired;

                    break;

                case "Grade":

                    GradeDIV.Visible = criteria.IsVisible;
                    Lbl_RBL_Grade.Text = criteria.DisplayName;

                    RFV_RBL_Grade.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_RBL_Grade.Enabled = criteria.IsRequired;

                    break;

                case "MfgName/Address":

                    MfgNameDIV.Visible = criteria.IsVisible;
                    Lbl_TB_MfgName.Text = criteria.DisplayName;

                    RFV_TB_MfgName.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_MfgName.Enabled = criteria.IsRequired;

                    TB_MfgName.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_MfgName.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_MfgName.ValidationExpression = criteria.RegularExpression;
                    REV_TB_MfgName.Enabled = criteria.IsRegularExpressionRequired;

                    hdnMinMfgNameValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxMfgNameValue.Value = criteria.MaximumValue.ToString();

                    break;

                case "BestBeforeDate":

                    BeforeDateDIV.Visible = criteria.IsVisible;
                    Lbl_TB_BeforeDate.Text = criteria.DisplayName;

                    RFV_TB_BeforeDate.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_BeforeDate.Enabled = criteria.IsRequired;

                    break;

                case "LicenceNo":

                    FssaiNoDIV.Visible = criteria.IsVisible;
                    Lbl_TB_FssaiNo.Text = criteria.DisplayName;

                    RFV_TB_FssaiNo.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_FssaiNo.Enabled = criteria.IsRequired;

                    TB_FssaiNo.Attributes["placeholder"] = criteria.RegularExpressionErrorMessage;

                    REV_TB_FssaiNo.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_FssaiNo.ValidationExpression = criteria.RegularExpression;
                    REV_TB_FssaiNo.Enabled = criteria.IsRegularExpressionRequired;

                    hdnMinLicenseNoValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxLicenseNoValue.Value = criteria.MaximumValue.ToString();

                    break;

                case "FssaiLogo":

                    FssaiLogoDIV.Visible = criteria.IsVisible;
                    Label_Fssai_Logo.Text = criteria.DisplayName;

                    RFV_RBL_Fssai_Logo.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_RBL_Fssai_Logo.Enabled = criteria.IsRequired;

                    break;

                case "VegLogo":

                    VegLogoDIV.Visible = criteria.IsVisible;
                    Label_Veg_Logo.Text = criteria.DisplayName;

                    RFV_RBL_Veg_Logo.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_RBL_Veg_Logo.Enabled = criteria.IsRequired;

                    break;

                case "PackingCondition":

                    PackingConditionDIV.Visible = criteria.IsVisible;
                    Label_Packing_Condition.Text = criteria.DisplayName;

                    RFV_RBL_Packing_Condition.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_RBL_Packing_Condition.Enabled = criteria.IsRequired;

                    break;

                case "Color":

                    ColorDIV.Visible = criteria.IsVisible;
                    LabelColor.Text = criteria.DisplayName;

                    RFV_DDL_Color.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_DDL_Color.Enabled = criteria.IsRequired;

                    break;

                case "Odour/Smell":

                    SmellDIV.Visible = criteria.IsVisible;
                    LabelSmell.Text = criteria.DisplayName;

                    RFV_RBL_Smell.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_RBL_Smell.Enabled = criteria.IsRequired;

                    break;

                case "Appearance":

                    AppearanceDIV.Visible = criteria.IsVisible;
                    LabelAppearance.Text = criteria.DisplayName;

                    RFV_RBL_Appearance.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_RBL_Appearance.Enabled = criteria.IsRequired;

                    break;

                case "Taste/Flavor":

                    TasteFlavorDIV.Visible = criteria.IsVisible;
                    LabelTasteFlavor.Text = criteria.DisplayName;

                    RFV_RBL_TasteFlavor.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_RBL_TasteFlavor.Enabled = criteria.IsRequired;

                    break;

                case "ForeignMatter/Impurities":

                    ImpuritiesDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Foreign_Impurities.Text = criteria.DisplayName;

                    RFV_TB_Foreign_Impurities.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Foreign_Impurities.Enabled = criteria.IsRequired;

                    TB_Foreign_Impurities.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Foreign_Impurities.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Foreign_Impurities.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Foreign_Impurities.Enabled = criteria.IsRegularExpressionRequired;

                    hdnMinImpuritiesValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxImpuritiesValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "PhValue":

                    PHDIV.Visible = criteria.IsVisible;
                    Lbl_TB_PH.Text = criteria.DisplayName;

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

                    MoistureDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Moisture.Text = criteria.DisplayName;

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

                    AshDIV.Visible = criteria.IsVisible;
                    Lbl_TB_TotalAsh.Text = criteria.DisplayName;

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

                    InsolubleAshDIV.Visible = criteria.IsVisible;
                    Lbl_TB_InsolubleAsh.Text = criteria.DisplayName;

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

                    SolidDIV.Visible = criteria.IsVisible;
                    Lbl_TB_TotalSolid.Text = criteria.DisplayName;

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

                    DextroseDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Dextrose.Text = criteria.DisplayName;

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

                    TitrableAcidityDIV.Visible = criteria.IsVisible;
                    Lbl_TB_TitrableAcidity.Text = criteria.DisplayName;

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

                    AlcoholicAcidityDIV.Visible = criteria.IsVisible;
                    Lbl_TB_AlcoholicAcidity.Text = criteria.DisplayName;

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

                    SO2DIV.Visible = criteria.IsVisible;
                    Lbl_TB_SO2.Text = criteria.DisplayName;

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

                    GlycerineContentDIV.Visible = criteria.IsVisible;
                    Lbl_TB_GlycerineContent.Text = criteria.DisplayName;

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

                    GlucoseContentDIV.Visible = criteria.IsVisible;
                    Lbl_TB_GlucoseContent.Text = criteria.DisplayName;

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

                    LossOnDryingDIV.Visible = criteria.IsVisible;
                    Lbl_TB_LossOnDrying.Text = criteria.DisplayName;

                    RFV_TB_LossOnDrying.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_LossOnDrying.Enabled = criteria.IsRequired;

                    TB_LossOnDrying.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_LossOnDrying.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_LossOnDrying.ValidationExpression = criteria.RegularExpression;
                    REV_TB_LossOnDrying.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_LossOnDrying.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_LossOnDrying.Enabled = criteria.IsRangeRequired;

                    hdnMinLossonDryingValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxLossonDryingValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "SolubilityValue":

                    SolubilityDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Solubility.Text = criteria.DisplayName;

                    RFV_TB_Solubility.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Solubility.Enabled = criteria.IsRequired;

                    TB_Solubility.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Solubility.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Solubility.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Solubility.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Solubility.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Solubility.Enabled = criteria.IsRangeRequired;

                    hdnMinSolubilityValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxSolubilityValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "ShapeOrSizeValue":

                    ShapeOrSizeDIV.Visible = criteria.IsVisible;
                    Lbl_TB_ShapeOrSize.Text = criteria.DisplayName;

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

                case "SulphatedAshValue":

                    SulphatedAshDIV.Visible = criteria.IsVisible;
                    Lbl_TB_SulphatedAsh.Text = criteria.DisplayName;

                    RFV_TB_SulphatedAsh.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_SulphatedAsh.Enabled = criteria.IsRequired;

                    TB_SulphatedAsh.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_SulphatedAsh.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_SulphatedAsh.ValidationExpression = criteria.RegularExpression;
                    REV_TB_SulphatedAsh.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_SulphatedAsh.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_SulphatedAsh.Enabled = criteria.IsRangeRequired;

                    hdnMinSulphatedAshValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxSulphatedAshValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "SucroseContentValue":

                    SucroseDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Sucrose.Text = criteria.DisplayName;

                    RFV_TB_Sucrose.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Sucrose.Enabled = criteria.IsRequired;

                    TB_Sucrose.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Sucrose.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Sucrose.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Sucrose.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Sucrose.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Sucrose.Enabled = criteria.IsRangeRequired;

                    hdnMinSucroseValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxSucroseValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "SulphideContentValue":

                    SulphideDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Sulphide.Text = criteria.DisplayName;

                    RFV_TB_Sulphide.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Sulphide.Enabled = criteria.IsRequired;

                    TB_Sulphide.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Sucrose.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Sucrose.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Sucrose.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_GlucoseContent.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_GlucoseContent.Enabled = criteria.IsRangeRequired;

                    hdnMinSulphideValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxSulphideValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "WIMValue":

                    WIMDIV.Visible = criteria.IsVisible;
                    Lbl_TB_WIM.Text = criteria.DisplayName;

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

                case "Beverage":

                    BeverageDIV.Visible = criteria.IsVisible;
                    Lbl_RBL_Beverage.Text = criteria.DisplayName;

                    RFV_RBL_Beverage.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_RBL_Beverage.Enabled = criteria.IsRequired;

                    break;


                default:
                    break;
            }
        }



        private void LoadFormDetails(string FormID, string selectedPlantValue, string selectedPlantLineValue)
        {
            // Replace with your actual connection string
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_GetFormsApprovalMatrix", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Set parameters for the stored procedure
                    cmd.Parameters.AddWithValue("@PlantId", selectedPlantValue); // Replace with actual value
                    cmd.Parameters.AddWithValue("@LineId", selectedPlantLineValue);  // Replace with actual value
                    cmd.Parameters.AddWithValue("@FormID", FormID); // Replace with actual value
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
                            DataRow row = dt.Rows[0];

                            lbl_docname.Text = row["DocumentName"].ToString();
                            lbl_docnumber.Text = row["DocumentNumber"].ToString();
                            // Set data for flow diagram
                            Approver1NameLabel.Text = row["Approver1Name"].ToString();
                            //Approver1CodeLabel.Text = row["Approver1EmployeeCode"].ToString();
                            //Approver1Photo.ImageUrl = row["Approver1Photo"].ToString(); // Adjust field name for photo

                            Approver2NameLabel.Text = row["Approver2Name"].ToString();
                            //Approver2CodeLabel.Text = row["Approver2EmployeeCode"].ToString();
                            //Approver2Photo.ImageUrl = row["Approver2Photo"].ToString(); // Adjust field name for photo

                            DottedLineApproverNameLabel.Text = row["DottedLineApproverName"].ToString();
                            //DottedLineApproverCodeLabel.Text = row["DottedLineApproverEmployeeCode"].ToString();
                            //DottedLineApproverPhoto.ImageUrl = row["DottedLineApproverPhoto"].ToString(); // Adjust field name for photo
                        }
                        else
                        {
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



        protected void BtnApprove_Click(object sender, EventArgs e)
        {
            UpdateColumnBasedOnApproverType();
            LoadRecordData(RecordID);
        }
        protected void BtnReject_Click(object sender, EventArgs e)
        {
            RejectionBasedOnApproverType();
            LoadRecordData(RecordID);

        }


        public void UpdateColumnBasedOnApproverType()
        {
            // Get the logged-in employee code from session
            string employeeCode = Session["WORKMAN"] as string;

            if (!string.IsNullOrEmpty(employeeCode))
            {
                // Retrieve the approver codes from the labels in the approver-flow div
                string approver1Code = Approver1CodeLabel.Text.ToString();
                string approver2Code = Approver2CodeLabel.Text.ToString();
                string dottedLineApproverCode = DottedLineApproverCodeLabel.Text.ToString();

                // Determine the approver type based on the employee code
                string approverType = string.Empty;

                if (employeeCode == approver1Code)
                {
                    approverType = "Approver1";
                }
                else if (employeeCode == approver2Code)
                {
                    approverType = "Approver2";
                }
                else if (employeeCode == dottedLineApproverCode)
                {
                    approverType = "DottedLineApprover";
                }

                if (!string.IsNullOrEmpty(approverType))
                {
                    // Define the connection string
                    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                    // Perform SQL operation based on the approver type
                    string updateQuery = string.Empty;

                    switch (approverType)
                    {
                        case "Approver1":
                            updateQuery = "UPDATE TRN_RM_CLASS_3 SET Approver1_Status = 1, Approver1_TimeStamp = @TimeStamp WHERE Approver1EmployeeCode = @Condition and Id=@Id";
                            break;
                        case "Approver2":
                            updateQuery = "UPDATE TRN_RM_CLASS_3 SET Approver2_Status = 1, Approver2_TimeStamp = @TimeStamp WHERE Approver2EmployeeCode = @Condition and Id=@Id";
                            break;
                        case "DottedLineApprover":
                            updateQuery = "UPDATE TRN_RM_CLASS_3 SET DottedApprover_Status = 1, DottedApprover_TimeStamp = @TimeStamp WHERE DottedLineApproverEmployeeCode = @Condition and Id=@Id";
                            break;
                    }

                    if (!string.IsNullOrEmpty(updateQuery))
                    {
                        using (SqlConnection conn = new SqlConnection(connectionString))
                        {
                            SqlCommand cmd = new SqlCommand(updateQuery, conn);
                            cmd.Parameters.AddWithValue("@TimeStamp", DateTime.Now);
                            cmd.Parameters.AddWithValue("@Condition", employeeCode);
                            cmd.Parameters.AddWithValue("@Id", RecordID);
                            try
                            {
                                conn.Open();
                                cmd.ExecuteNonQuery();
                                Lbl_BasicbtnApprove.Text = "Approved";
                            }
                            catch (Exception ex)
                            {
                                // Handle exceptions (e.g., logging, rethrowing)
                                //throw new Exception("Error updating the table.", ex);
                                Lbl_BasicbtnApprove.Text = ex.Message;
                            }
                        }
                    }
                }
            }
        }

        public void RejectionBasedOnApproverType()
        {
            // Get the logged-in employee code from session
            string employeeCode = Session["WORKMAN"] as string;

            if (!string.IsNullOrEmpty(employeeCode))
            {
                // Retrieve the approver codes from the labels in the approver-flow div
                string approver1Code = Approver1CodeLabel.Text.ToString();
                string approver2Code = Approver2CodeLabel.Text.ToString();
                string dottedLineApproverCode = DottedLineApproverCodeLabel.Text.ToString();

                // Determine the approver type based on the employee code
                string approverType = string.Empty;

                if (employeeCode == approver1Code)
                {
                    approverType = "Approver1";
                }
                else if (employeeCode == approver2Code)
                {
                    approverType = "Approver2";
                }
                else if (employeeCode == dottedLineApproverCode)
                {
                    approverType = "DottedLineApprover";
                }

                if (!string.IsNullOrEmpty(approverType))
                {
                    // Define the connection string
                    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                    // Perform SQL operation based on the approver type
                    string updateQuery = string.Empty;

                    switch (approverType)
                    {
                        case "Approver1":
                            updateQuery = "UPDATE TRN_RM_CLASS_3 SET Approver1_Status = 0, Approver1_TimeStamp = @TimeStamp WHERE Approver1EmployeeCode = @Condition and Id=@Id";
                            break;
                        case "Approver2":
                            updateQuery = "UPDATE TRN_RM_CLASS_3 SET Approver2_Status = 0, Approver2_TimeStamp = @TimeStamp WHERE Approver2EmployeeCode = @Condition and Id=@Id";
                            break;
                        case "DottedLineApprover":
                            updateQuery = "UPDATE TRN_RM_CLASS_3 SET DottedApprover_Status = 0, DottedApprover_TimeStamp = @TimeStamp WHERE DottedLineApproverEmployeeCode = @Condition and Id=@Id";
                            break;
                    }

                    if (!string.IsNullOrEmpty(updateQuery))
                    {
                        using (SqlConnection conn = new SqlConnection(connectionString))
                        {
                            SqlCommand cmd = new SqlCommand(updateQuery, conn);
                            cmd.Parameters.AddWithValue("@TimeStamp", DateTime.Now);
                            cmd.Parameters.AddWithValue("@Condition", employeeCode);
                            cmd.Parameters.AddWithValue("@Id", RecordID);
                            try
                            {
                                conn.Open();
                                cmd.ExecuteNonQuery();
                                Lbl_BasicbtnApprove.Text = "Rejected";
                            }
                            catch (Exception ex)
                            {
                                // Handle exceptions (e.g., logging, rethrowing)
                                Lbl_BasicbtnApprove.Text = ex.Message;
                                //throw new Exception("Error updating the table.", ex);
                            }
                        }
                    }
                }
            }
        }



    }
}