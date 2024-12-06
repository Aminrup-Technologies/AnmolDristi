using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;


namespace AnmolDristi
{
    public partial class Critical_Incident_Detailed : System.Web.UI.Page
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
                // Declare incidentId outside the if block
                int incidentId;

                // Get the query string parameter and validate it
                string incidentIdString = Request.QueryString["Id"];
                if (!string.IsNullOrEmpty(incidentIdString) && int.TryParse(incidentIdString, out incidentId))
                {

                    PlantBinder();
                    //PlantLinesBinder(PlantId);
                    //LineProductsBinder(PlantId, PlantLine);
                    //ProductBrandsBinder(PlantId, PlantLine, ProductCategory);
                    //BrandSKUBinder(CategoryBrand);
                    LoadFormData(incidentId);

                }
                else
                {
                    // Handle the case where the Id is not valid
                    ShowErrorNotification("Invalid Incident ID.");
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
        private void LoadFormData(int incidentId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM TRN_Critical_Incident WHERE Id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = incidentId;

                    try
                    {
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Bind plant dropdown and dependent controls
                                string plantId = reader["PlantName"].ToString();
                                DDL_Plant.SelectedValue = plantId;

                                PlantLinesBinder(plantId);
                                DDL_PlantLine.SelectedValue = reader["Line"].ToString();

                                string plantLine = reader["Line"].ToString();
                                LineProductsBinder(plantId, plantLine);
                                DDL_ProductCategory.SelectedValue = reader["ProductCategory"].ToString();

                                string productCategory = reader["ProductCategory"].ToString();
                                ProductBrandsBinder(plantId, plantLine, productCategory);
                                DDL_ProductBrand.SelectedValue = reader["ProductBrand"].ToString();

                                string productBrand = reader["ProductBrand"].ToString();
                                BrandSKUBinder(productBrand);
                                DDL_BrandSKU.SelectedValue = reader["SKUId"].ToString();

                                // Bind textboxes and other controls
                                TB_BatchCode.Text = reader["BatchCode"].ToString();
                                TB_QCI.Text = reader["QCI_EmpCode"].ToString();
                                TB_SftInCharge.Text = reader["SftInCharge_EmpCode"].ToString();
                                TB_qaqcInCharge.Text = reader["QAQCInCharge"].ToString();
                                TB_qiDetails.Text = reader["QIDetails"].ToString();
                                TB_r_hQuantity.Text = reader["RjtdQty"].ToString();
                                TB_Observed.Text = Convert.ToDateTime(reader["WhenObserved"]).ToString("yyyy-MM-dd");
                                TB_ImmediateTakenAction.Text = reader["ImmediateAction"].ToString();
                                TB_c_pActions.Text = reader["CorrectiveAction"].ToString();
                                TB_TargetDtCom.Text = Convert.ToDateTime(reader["TgtDtOfComp"]).ToString("yyyy-MM-dd");
                                TB_Responsibility.Text = reader["Responsibility_EmpCode"].ToString();
                                RBL_DispatchApp.SelectedValue = reader["DispatchAppRB"].ToString();
                                TB_Remarks.Text = reader["DispatchApp"].ToString();

                                // Handle visibility of DispatchAppRemarksDiv
                                DispatchAppRemarksDiv.Style["display"] = RBL_DispatchApp.SelectedValue == "0" ? "block" : "none";
                            }
                            else
                            {
                                // Show notification if no data is found
                                ShowErrorNotification("Incident not found.");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowErrorNotification($"An error occurred while loading the incident data: {ex.Message}");
                    }
                }
            }
        }
        
        protected void BtnApprove_Click(object sender, EventArgs e)
        {

        }

        protected void BtnReject_Click(object sender, EventArgs e)
        {

        }
        private void ShowErrorNotification(string message)
        {
            string errorScript = $@"
            <script type='text/javascript'>
                new PNotify({{
                    Title: 'Error',
                    text: '{message}',
                    type: 'error',
                    styling: 'bootstrap3'
                }});
            </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "ShowErrorNotification", errorScript, false);
        }
    }
}