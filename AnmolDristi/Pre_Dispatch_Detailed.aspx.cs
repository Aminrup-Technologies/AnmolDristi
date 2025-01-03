using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace AnmolDristi
{
    public partial class Pre_Dispatch_Detailed : System.Web.UI.Page
    {
        public static string PlantId = string.Empty;
        public static string PlantName = string.Empty;
        public static string PlantLine = string.Empty;
        public static string ProductCategory = string.Empty;
        public static string CategoryBrand = string.Empty;
        public static string BrandSKU = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["PDCR_PK"] != null)
                {
                    string pdcr = Request.QueryString["PDCR_PK"];

                    PlantBinder();
                    getDetails(pdcr);
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
        void getDetails(string pdcr)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                string query = @"
                    SELECT
                        P.PlantName as PlantID,
                        A.plant_name,
                        P.Line,
                        B.line_name,
                        C.category_name,
                        D.brand_name,
	                    E.SKU_name,
                        P.*
                    FROM
                        TRN_Pre_Dispatch_Clearance_Report P
                    JOIN dbo.MST_PlantDetails A ON P.PlantName = A.plant_id
                    JOIN dbo.MST_Plant_Lines B ON P.Line = B.line_id
                    JOIN dbo.MST_LineCategory C ON P.ProductCategory = C.category_id
                    JOIN dbo.MST_LineCatBrands D ON P.ProductBrand = D.brand_id
                    JOIN dbo.MST_Brand_SKU E ON P.SKUId = E.SKUId
                    WHERE P.PDCR_PK = @PDCR_PK";


                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@PDCR_PK", pdcr);
                        con.Open();
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            System.Data.DataTable dt = new System.Data.DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                // Retrieve the first row
                                DataRow row = dt.Rows[0];

                                string PlantId = dt.Rows[0]["PlantID"].ToString();
                                string PlantName = dt.Rows[0]["plant_name"].ToString();
                                DDL_Plant.SelectedItem.Text = PlantName;

                                PlantLinesBinder(PlantId);
                                string PlantLine = dt.Rows[0]["Line"].ToString();
                                DDL_PlantLine.SelectedValue = PlantLine;

                                LineProductsBinder(PlantId, PlantLine);
                                string ProductCategory = dt.Rows[0]["ProductCategory"].ToString();
                                DDL_ProductCategory.SelectedValue = ProductCategory;

                                ProductBrandsBinder(PlantId, PlantLine, ProductCategory);
                                string CategoryBrand = dt.Rows[0]["ProductBrand"].ToString();
                                DDL_ProductBrand.SelectedValue = CategoryBrand;

                                BrandSKUBinder(CategoryBrand);
                                string BrandSKU = dt.Rows[0]["SKUId"].ToString();
                                DDL_BrandSKU.SelectedValue = BrandSKU;

                                TXT_InspectionLot.Text = dt.Rows[0]["InspectionLot"].ToString();
                                TXT_MaterialCode.Text = dt.Rows[0]["MaterialCode"].ToString();
                                TXT_CBB_Produced.Text = dt.Rows[0]["CBB_Produced"].ToString();
                                TXT_CBB_Checked.Text = dt.Rows[0]["CBB_Checked"].ToString();

                                RBL_BoxCondition.SelectedValue = dt.Rows[0]["CBB_Box_Condition"].ToString();
                                TXB_BoxCondition_Remarks.Text = dt.Rows[0]["CBB_Box_ConditionRemarks"].ToString();

                                TXT_Packets_CBB.Text = dt.Rows[0]["Packets_CBB"].ToString();

                                RBL_Tapping.SelectedValue = dt.Rows[0]["CBB_tapping"].ToString();
                                TXB_Tapping_Remarks.Text = dt.Rows[0]["CBB_tappingRemarks"].ToString();

                                TXT_Pkts_Checked_Per_CBB.Text = dt.Rows[0]["PacketsChecked_CBB"].ToString();
                                TXT_Wt_of_Pkts.Text = dt.Rows[0]["WeightofPackets"].ToString();
                                TXT_PackageDate.Text = dt.Rows[0]["PackageDate"].ToString();
                                TXT_BatchNo.Text = dt.Rows[0]["BatchNo"].ToString();

                                TXT_PacketsMRP.Text = dt.Rows[0]["PacketsMRP"].ToString();

                                RBL_LongSeal.SelectedValue = dt.Rows[0]["LongSeal"].ToString();
                                TXB_LongSeal_Remarks.Text = dt.Rows[0]["LongSealRemarks"].ToString();

                                RBL_EndSeal.SelectedValue = dt.Rows[0]["EndSeal"].ToString();
                                TXB_EndSeal_Remarks.Text = dt.Rows[0]["EndSealRemarks"].ToString();

                                RBL_MainPanel.SelectedValue = dt.Rows[0]["MainPanel"].ToString();
                                TXB_MainPanel_Remarks.Text = dt.Rows[0]["MainPanelRemarks"].ToString();

                                RBL_CutsPackets.SelectedValue = dt.Rows[0]["Cuts_Packets"].ToString();
                                TXB_CutsPackets_Remarks.Text = dt.Rows[0]["Cuts_PacketsRemarks"].ToString();

                                RBL_BackingStatus.SelectedValue = dt.Rows[0]["BackingStatus"].ToString();
                                TXB_BackingStatus_Remarks.Text = dt.Rows[0]["BackingStatusRemarks"].ToString();

                                RBL_ElongOval.SelectedValue = dt.Rows[0]["ElongOval"].ToString();
                                TXB_ElongOval_Remarks.Text = dt.Rows[0]["ElongOvalRemarks"].ToString();

                                RBL_Cupping.SelectedValue = dt.Rows[0]["Cupping"].ToString();
                                TXB_Cupping_Remarks.Text = dt.Rows[0]["CuppingRemarks"].ToString();

                                RBL_Impression.SelectedValue = dt.Rows[0]["Impression"].ToString();
                                TXB_Impression_Remarks.Text = dt.Rows[0]["ImpressionRemarks"].ToString();

                                RBL_SoggyStatus.SelectedValue = dt.Rows[0]["SoggyStatus"].ToString();
                                TXB_SoggyStatus_Remarks.Text = dt.Rows[0]["SoggyStatusRemarks"].ToString();

                                RBL_ForeignBody.SelectedValue = dt.Rows[0]["ForeignBody"].ToString();
                                TXB_ForeignBody_Remarks.Text = dt.Rows[0]["ForeignBodyRemarks"].ToString();

                                RBL_OffOdour.SelectedValue = dt.Rows[0]["OffOdour"].ToString();
                                TXB_OffOdour_Remarks.Text = dt.Rows[0]["OffOdourRemarks"].ToString();

                                TXB_Remarks.Text = dt.Rows[0]["Remarks"].ToString();

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