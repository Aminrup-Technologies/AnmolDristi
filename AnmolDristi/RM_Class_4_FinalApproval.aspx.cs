using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class RM_Class_4_FinalApproval : System.Web.UI.Page
    {
        public static string PlantId = string.Empty;
        public static string PlantName = string.Empty;
        public static string MaterialName = string.Empty;
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
            string query = "SELECT Material_Id, Material_Name FROM RM_Material where Class = 4 ";
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
                case "Butter":

                    //Product Brand
                    BrandDIV.Visible = true;

                    //Supplier	
                    SupplierDIV.Visible = true;

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

                    //Fungus Infestation
                    FungusDIV.Visible = true;

                    //Moisture
                    MoistureDIV.Visible = true;

                    //Fat Content 
                    FatContentDIV.Visible = true;

                    //Milk Snf
                    MilkDIV.Visible = true;

                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;
                    break;

                case "Condensed Milk":
                    //Supplier	
                    SupplierDIV.Visible = true;

                    //Challan No & Date	
                    ChallanNoDIV.Visible = true;
                    ChallanDateDIV.Visible = true;

                    //Lot No/ Batch No.
                    LotNoDIV.Visible = true;

                    //Pkd/Mfg Date	
                    PkdMfgDIV.Visible = true;

                    //Vehicle No	
                    VehicleNoDIV.Visible = true;

                    //Colour	
                    ColorDIV.Visible = true;
                    ColorRemarksDiv.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //Total Solids	
                    SolidDIV.Visible = true;

                    //Titrable Acidity
                    TitrableAcidityDIV.Visible = true;


                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;
                    break;

                case "SMP":

                    //Product Brand
                    BrandDIV.Visible = true;

                    // Supplier
                    SupplierDIV.Visible = true;

                    //Challan No & Date	
                    ChallanDateDIV.Visible = true;
                    ChallanNoDIV.Visible = true;

                    //Lot No/ Batch No.
                    LotNoDIV.Visible = true;

                    //Pkd/Mfg Date	
                    PkdMfgDIV.Visible = true;

                    //Vehicle No	
                    VehicleNoDIV.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //Moisture
                    MoistureDIV.Visible = true;

                    //Total Ash
                    AshDIV.Visible = true;

                    //Protein	
                    ProteinDIV.Visible = true;

                    //Milk Fat
                    MilkFatDIV.Visible = true;

                    //Titrable Acidity
                    TitrableAcidityDIV.Visible = true;

                    //SO2
                    SO2DIV.Visible = true;

                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;
                    break;

                case "Whey Powder":

                    //Product Brand
                    BrandDIV.Visible = true;

                    // Supplier
                    SupplierDIV.Visible = true;

                    //Challan No & Date	
                    ChallanDateDIV.Visible = true;
                    ChallanNoDIV.Visible = true;

                    //Lot No/ Batch No.
                    LotNoDIV.Visible = true;

                    //Pkd/Mfg Date	
                    PkdMfgDIV.Visible = true;

                    //Vehicle No	
                    VehicleNoDIV.Visible = true;

                    //Taste/Flavour	
                    TasteFlavorDIV.Visible = true;

                    //pH
                    PHDIV.Visible = true;

                    //Moisture
                    MoistureDIV.Visible = true;

                    //Total Ash
                    AshDIV.Visible = true;

                    //Lactose Content
                    LactoseDIV.Visible = true;

                    //Protein	
                    ProteinDIV.Visible = true;

                    //Milk Fat
                    MilkFatDIV.Visible = true;

                    //Image
                    FU_MaterialImage_img.Visible = true;
                    imgMaterial.Visible = true;
                    break;

                case "Whole Milk Powder":

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

                    //Titrable Acidity	
                    TitrableAcidityDIV.Visible = true;

                    //SO2	
                    SO2DIV.Visible = true;

                    //Loss on Drying	
                    LossOnDryingDIV.Visible = true;

                    //Glucose Content
                    GlucoseContentDIV.Visible = true;

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
                    using (SqlCommand cmd = new SqlCommand("SP_RM_4_ApprovalData", con))
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

                                ProductBrandsBinder(PlantId);
                                CategoryBrand = dt.Rows[0]["ProductBrand"].ToString();
                                DDL_ProductBrand.SelectedValue = CategoryBrand;

                                TB_Supplier.Text = dt.Rows[0]["Supplier_Name"].ToString();

                                TB_ChallanNo.Text = dt.Rows[0]["Challan_No"].ToString();
                                TB_ChallanDate.Text = dt.Rows[0]["Challan_Date"].ToString();
                                TB_LotNo.Text = dt.Rows[0]["Lot_No"].ToString();
                                TB_VehicleNo.Text = dt.Rows[0]["Vehicle_No"].ToString();
                                TB_PkdMfg.Text = dt.Rows[0]["Pkd_Date"].ToString();


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

                                TB_Fungus.Text = dt.Rows[0]["Fungus"].ToString();
                                TXB_Fungus_Remarks.Text = dt.Rows[0]["CommentsForFungus"].ToString();

                                TB_PH.Text = dt.Rows[0]["PH"].ToString();
                                TXB_PH_Remarks.Text = dt.Rows[0]["CommentsForPH"].ToString();

                                TB_Moisture.Text = dt.Rows[0]["Moisture"].ToString();
                                TXB_Moisture_Remarks.Text = dt.Rows[0]["CommentsForMoisture"].ToString();

                                TB_TotalAsh.Text = dt.Rows[0]["Total_Ash"].ToString();
                                TXB_Ash_Remarks.Text = dt.Rows[0]["CommentsForTotalAsh"].ToString();

                                TB_FatContent.Text = dt.Rows[0]["Fat_Content"].ToString();
                                TXB_Fat_Remarks.Text = dt.Rows[0]["CommentsForFatContent"].ToString();

                                TB_Milk.Text = dt.Rows[0]["Milk"].ToString();
                                TXB_Milk_Remarks.Text = dt.Rows[0]["CommentsForMilk"].ToString();

                                TB_TotalSolid.Text = dt.Rows[0]["Total_Solids"].ToString();
                                TXB_Solid_Remarks.Text = dt.Rows[0]["CommentsForSolid"].ToString();

                                TB_Protein.Text = dt.Rows[0]["Protein"].ToString();
                                TXB_Protein_Remarks.Text = dt.Rows[0]["CommentsForProtein"].ToString();

                                TB_Lactose.Text = dt.Rows[0]["Lactose"].ToString();
                                TXB_Lactose_Remarks.Text = dt.Rows[0]["CommentsForLactose"].ToString();

                                TB_MilkFat.Text = dt.Rows[0]["MilkFat"].ToString();
                                TXB_MilkFat_Remarks.Text = dt.Rows[0]["CommentsForMilkFat"].ToString();

                                TB_TitrableAcidity.Text = dt.Rows[0]["Titrable_Acidity"].ToString();
                                TXB_TitrableAcidity_Remarks.Text = dt.Rows[0]["CommentsForTitrableAcidity"].ToString();

                                TB_SO2.Text = dt.Rows[0]["SO2"].ToString();
                                TXB_SO2_Remarks.Text = dt.Rows[0]["CommentsForSO2"].ToString();

                                TB_GlucoseContent.Text = dt.Rows[0]["Glucose_Content"].ToString();
                                TXB_GlucoseContent_Remarks.Text = dt.Rows[0]["CommentsForGlucoseContent"].ToString();

                                TB_LossOnDrying.Text = dt.Rows[0]["Loss_On_Drying"].ToString();
                                TXB_LossOnDrying_Remarks.Text = dt.Rows[0]["CommentsForLossOnDrying"].ToString();

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