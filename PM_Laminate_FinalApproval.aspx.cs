using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class PM_Laminate_FinalApproval : System.Web.UI.Page
    {
        public static string PlantId = string.Empty;
        public static string PlantName = string.Empty;
        public static string CategoryBrand = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["LTRID"] != null)
                {
                    string ltrId = Request.QueryString["LTRID"];

                    PlantBinder();
                    getDetails(ltrId);
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
        private void ProductBrandsBinder(string selectedPlantValue)
        {
            // Construct the SQL query with parameters
            string query = "SELECT brand_id, brand_name FROM MST_LineCatBrands WHERE plant_id = @PlantId ";
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
        void getDetails(string ltrId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_PM_Laminate_ApprovalData", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@LTRID", ltrId);
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


                                ProductBrandsBinder(PlantId);
                                CategoryBrand = dt.Rows[0]["ProductBrand"].ToString();
                                DDL_ProductBrand.SelectedValue = CategoryBrand; //This is for binding the DDL using Value / ID


                                TB_Supplier.Text = dt.Rows[0]["Supplier_Name"].ToString();

                                RBL_Smell.SelectedValue = dt.Rows[0]["Smell"].ToString();
                                TXB_Smell_Remarks.Text = dt.Rows[0]["Smell_Remarks"].ToString();

                                TB_ChallanNo.Text = dt.Rows[0]["Challan_No"].ToString();
                                TB_ChallanDate.Text = dt.Rows[0]["Challan_Date"].ToString();
                                TB_LotNo.Text = dt.Rows[0]["Lot_No"].ToString();
                                TB_VehicleNo.Text = dt.Rows[0]["Vehicle_No"].ToString();

                                TB_Bond.Text = dt.Rows[0]["Bond_Strength"].ToString();
                                TB_Seal.Text = dt.Rows[0]["Seal_Strength"].ToString();

                                Literal_Std_Length.Text = dt.Rows[0]["Std_Length"].ToString();
                                TB_Length.Text = dt.Rows[0]["Obs_Length"].ToString();
                                TXB_Length_Remarks.Text = dt.Rows[0]["Length_Remarks"].ToString();

                                Literal_Std_Width.Text = dt.Rows[0]["Std_Width"].ToString();
                                TB_Width.Text = dt.Rows[0]["Obs_Width"].ToString();
                                TXB_Width_Remarks.Text = dt.Rows[0]["Width_Remarks"].ToString();

                                Literal_Std_Height.Text = dt.Rows[0]["Std_Height"].ToString();
                                TB_Height.Text = dt.Rows[0]["Obs_Height"].ToString();
                                TXB_Height_Remarks.Text = dt.Rows[0]["Height_Remarks"].ToString();

                                Literal_Std_GSM.Text = dt.Rows[0]["GMS_Std"].ToString();
                                TB_GSM.Text = dt.Rows[0]["GSM_Obs"].ToString();
                                TXB_GSM_Remarks.Text = dt.Rows[0]["GSM_Remarks"].ToString();

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