using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class RM_Class_1_FinalApproval : System.Web.UI.Page
    {
        public static string PlantId = string.Empty;
        public static string PlantName = string.Empty;
        public static string MaterialName = string.Empty;
        public static string ProductCategory = string.Empty;
        public static string CategoryBrand = string.Empty;
        public static string Color = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["RMFID"] != null)
                {
                    string rmfid = Request.QueryString["RMFID"];

                    PlantBinder();
                    getDetails(rmfid);

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
        private void MaterialBinder(string selectedPlantValue)
        {
            string query = "SELECT Material_Id, Material_Name FROM RM_Material where class=1 ";
            string textField = "Material_Name";
            string valueField = "Material_Id";

            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Material, textField, valueField, new SqlParameter("@SelectedPlantValue", selectedPlantValue), out recordsBound);

            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Material);

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
        private void LineProductsBinder(string selectedPlantValue, string selectedMaterialValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT category_id, category_name FROM MST_LineCategory WHERE plant_id = @PlantId";
            string textField = "category_name"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "category_id"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@PlantId", selectedPlantValue)
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
        private void BrandsBinder(string selectedPlantValue)
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
        private void ProductBrandsBinder(string selectedPlantValue, string selectedProductCategoryValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT brand_id, brand_name FROM MST_LineCatBrands WHERE plant_id = @PlantId AND  category_id=@CategoryId";
            string textField = "brand_name"; // Assuming this is the correct field for displaying in the DropDownList
            string valueField = "brand_id"; // Assuming this is the correct field for storing in the DropDownList

            // Create SQL parameters for plant_id and line_id
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@PlantId", selectedPlantValue),
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
        private void PopulateColorDropdown()
        {
            // Add the "Select" option as the first item
            DDL_Color.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_Color.Items.Add(new ListItem("Brown", "Brown"));
            DDL_Color.Items.Add(new ListItem("Yellow", "Yellow"));
            DDL_Color.Items.Add(new ListItem("White", "White"));
            DDL_Color.Items.Add(new ListItem("Other", "Other"));

        }
        private void DivBinders(string selectedMaterialValue)
        {
            SetControlsVisible(Page.Controls, false);
            FU_MaterialImage_img.Visible = false;

            // Show relevant controls based on the selected material
            switch (MaterialName)
            {
                case "Choco Chips":

                    // Supplier
                    SupplierDIV.Visible = true;

                    //Product Brand
                    BrandDIV.Visible = true;

                    //Challan No & Date	
                    ChallanNoDIV.Visible = true;
                    ChallanDateDIV.Visible = true;

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

                    //Fat Content
                    FatContentDIV.Visible = true;

                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;

                    break;

                case "Malt":
                    //Supplier	
                    SupplierDIV.Visible = true;

                    //Product Brand
                    BrandDIV.Visible = true;

                    //Challan No & Date	
                    ChallanNoDIV.Visible = true;
                    ChallanDateDIV.Visible = true;

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

                    //Density		
                    DensityDIV.Visible = true;

                    //Total Solids	
                    SolidDIV.Visible = true;

                    //Reducing Sugar as Maltose	
                    SugarDIV.Visible = true;

                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;

                    break;

                case "Cocoa Powder":

                    //Product Category	
                    CategoryDIV.Visible = true;

                    // Supplier
                    SupplierDIV.Visible = true;

                    //Challan No & Date	
                    ChallanDateDIV.Visible = true;
                    ChallanNoDIV.Visible = true;

                    //Vehicle No	
                    VehicleNoDIV.Visible = true;

                    //Colour	
                    ColorDIV.Visible = true;
                    ColorRemarksDiv.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //pH
                    PHDIV.Visible = true;

                    //Moisture		
                    MoistureDIV.Visible = true;

                    //Total Ash			
                    AshDIV.Visible = true;

                    //Acid Insoluble Ash
                    InsolubleAshDIV.Visible = true;

                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;

                    break;

                case "Desiccated Coconut":

                    // Supplier
                    SupplierDIV.Visible = true;

                    //Colour	
                    ColorDIV.Visible = true;
                    ColorRemarksDiv.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //pH
                    PHDIV.Visible = true;

                    //Moisture		
                    MoistureDIV.Visible = true;

                    //Total Ash			
                    AshDIV.Visible = true;

                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;

                    break;

                case "Egg Powder":

                    // Supplier
                    SupplierDIV.Visible = true;

                    //Challan No & Date	
                    ChallanDateDIV.Visible = true;
                    ChallanNoDIV.Visible = true;

                    //QTY	
                    QuantityDIV.Visible = true;

                    //Vehicle No	
                    VehicleNoDIV.Visible = true;

                    //Colour	
                    ColorDIV.Visible = true;
                    ColorRemarksDiv.Visible = true;

                    //Odour/Smell	
                    SmellDIV.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //Foreign Matter/Impurities
                    ImpuritiesDIV.Visible = true;

                    //pH
                    PHDIV.Visible = true;

                    //Total Ash			
                    AshDIV.Visible = true;

                    //Acid Insoluble Ash
                    InsolubleAshDIV.Visible = true;

                    //TS
                    TSDIV.Visible = true;

                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;

                    break;

                case "Besan":
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

                    //Appearance	
                    AppearanceDIV.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //Foreign Matter/Impurities
                    ImpuritiesDIV.Visible = true;

                    //Moisture		
                    MoistureDIV.Visible = true;

                    //Total Ash			
                    AshDIV.Visible = true;

                    //Acid Insoluble Ash
                    InsolubleAshDIV.Visible = true;

                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;

                    break;

                case "Cashew Nut":

                    // Supplier
                    SupplierDIV.Visible = true;

                    //Product Brand
                    BrandDIV.Visible = true;

                    //Challan No & Date	
                    ChallanNoDIV.Visible = true;
                    ChallanDateDIV.Visible = true;

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

                    //Foreign Matter/Impurities
                    ImpuritiesDIV.Visible = true;

                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;

                    break;

                case "Tutty Frutti":
                    // Supplier
                    SupplierDIV.Visible = true;

                    //Challan No & Date	
                    ChallanNoDIV.Visible = true;
                    ChallanDateDIV.Visible = true;

                    //QTY	
                    QuantityDIV.Visible = true;

                    //Vehicle No	
                    VehicleNoDIV.Visible = true;

                    //Colour	
                    ColorDIV.Visible = true;
                    ColorRemarksDiv.Visible = true;

                    //Odour/Smell	
                    SmellDIV.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //Foreign Matter/Impurities
                    ImpuritiesDIV.Visible = true;

                    //Moisture		
                    MoistureDIV.Visible = true;

                    //Drainable Syrup	
                    SyrupDIV.Visible = true;

                    //No of Matured/Immatured seeds	
                    SeedsDIV.Visible = true;

                    //Brix	
                    BrixDIV.Visible = true;

                    //Shape/Size 
                    ShapeOrSizeDIV.Visible = true;

                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;

                    break;

                default:
                    // Optionally handle a default case
                    break;
            }
        }

        void getDetails(string rmfid)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_RM_1_ApprovalData", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@RMFID", rmfid);
                        con.Open();
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            System.Data.DataTable dt = new System.Data.DataTable();
                            sda.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                DataRow row = dt.Rows[0];

                                PlantId = dt.Rows[0]["PlantId"].ToString();
                                PlantName = dt.Rows[0]["plant_name"].ToString();
                                DDL_Plant.SelectedItem.Text = PlantName; //This is for binding the DDL using TEXT

                                MaterialBinder(PlantId);
                                MaterialName = dt.Rows[0]["Material_Name"].ToString();
                                DDL_Material.SelectedItem.Text = MaterialName;
                                DivBinders(MaterialName);

                                LineProductsBinder(PlantId,MaterialName);
                                ProductCategory = dt.Rows[0]["ProductCategory"].ToString();
                                DDL_ProductCategory.SelectedValue = ProductCategory; //This is for binding the DDL using Value / ID

                                ProductBrandsBinder(PlantId, ProductCategory);
                                CategoryBrand = dt.Rows[0]["ProductBrand"].ToString();
                                DDL_ProductBrand.SelectedValue = CategoryBrand;

                                TB_Supplier.Text = dt.Rows[0]["Supplier_Name"].ToString();

                                TB_ChallanNo.Text = dt.Rows[0]["Challan_No"].ToString();
                                TB_ChallanDate.Text = dt.Rows[0]["Challan_Date"].ToString();
                                TB_LotNo.Text = dt.Rows[0]["Lot_No"].ToString();
                                TB_VehicleNo.Text = dt.Rows[0]["Vehicle_No"].ToString();

                                TB_Quantity.Text = dt.Rows[0]["Quantity"].ToString();
                                TXB_Quantity_Remarks.Text = dt.Rows[0]["CommentsForQuantity"].ToString();


                                PopulateColorDropdown();
                                Color = dt.Rows[0]["Color"].ToString();
                                DDL_Color.SelectedValue = Color;
                                TXB_Color_Remarks.Text = dt.Rows[0]["CommentsForColor"].ToString();

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

                                TB_Density.Text = dt.Rows[0]["Density"].ToString();
                                TXB_Density_Remarks.Text = dt.Rows[0]["CommentsForDensity"].ToString();

                                TB_FatContent.Text = dt.Rows[0]["Fat_Content"].ToString();
                                TXB_Fat_Remarks.Text = dt.Rows[0]["CommentsForFatContent"].ToString();

                                TB_TotalSolid.Text = dt.Rows[0]["Total_Solids"].ToString();
                                TXB_Solid_Remarks.Text = dt.Rows[0]["CommentsForSolid"].ToString();

                                TB_ReducingSugar.Text = dt.Rows[0]["Reducing_Sugar"].ToString();
                                TXB_Sugar_Remarks.Text = dt.Rows[0]["CommentsForSugar"].ToString();

                                TB_DrainableSyrup.Text = dt.Rows[0]["Drainable_Syrup"].ToString();
                                TXB_Syrup_Remarks.Text = dt.Rows[0]["CommentsForSyrup"].ToString();

                                TB_Matured_Immatured_Seeds.Text = dt.Rows[0]["Matured_Immatured_seeds"].ToString();
                                TXB_Seeds_Remarks.Text = dt.Rows[0]["CommentsForSeed"].ToString();

                                TB_Brix.Text = dt.Rows[0]["Brix"].ToString();
                                TXB_Brix_Remarks.Text = dt.Rows[0]["CommentsForBrix"].ToString();

                                TB_ShapeOrSize.Text = dt.Rows[0]["ShapeOrSize"].ToString();
                                TXB_ShapeOrSize_Remarks.Text = dt.Rows[0]["CommentsForShapeOrSize"].ToString();

                                TB_TS.Text = dt.Rows[0]["TS"].ToString();
                                TXB_TS_Remarks.Text = dt.Rows[0]["CommentsForTS"].ToString();

                                imgMaterial.ImageUrl = dt.Rows[0]["Material_Image"].ToString();

                                Approver1CodeLabel.Text = dt.Rows[0]["Approver1EmployeeCode"].ToString();
                                Approver2CodeLabel.Text = dt.Rows[0]["Approver2EmployeeCode"].ToString();
                                DottedLineApproverCodeLabel.Text = dt.Rows[0]["DottedLineApproverEmployeeCode"].ToString();

                            }
                        }
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
                                     "});\n" +
                                     "</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowErrorNotification", errorScript, false);
            }
        }

        protected void BtnApprove_Click(object sender, EventArgs e)
        {

        }
        protected void BtnReject_Click(object sender, EventArgs e)
        {

        }
    }
}