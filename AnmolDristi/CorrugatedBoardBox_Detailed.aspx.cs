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
    public partial class CorrugatedBoardBox_Detailed : System.Web.UI.Page
    {
        public static string PlantId = string.Empty;
        public static string PlantName = string.Empty;
        public static string CategoryBrand = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["DBID"] != null)
                {
                    string id = Request.QueryString["DBID"];

                    PlantBinder();
                    getDetails(id);
                }

                string source = Request.QueryString["source"];

                if (source == "report")
                {
                    BtnApprove.Visible = false;
                    BtnReject.Visible = false;
                    BtnBack.PostBackUrl = "~/CorrugatedBoardBox_View.aspx";
                }
                else
                {
                    BtnBack.PostBackUrl = "~/CorrugatedBoardBox_Approval.aspx";
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


        void getDetails(string id)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                string query = @"
                    SELECT
                        P.PlantName as PlantID,
                        A.plant_name,
                        D.brand_name,
                        P.*
                    FROM
                        TRN_Corrugated_Board_Box_Report P
                    LEFT JOIN dbo.MST_PlantDetails A ON P.PlantName = A.plant_id
                    LEFT JOIN dbo.MST_LineCatBrands D ON P.ProductBrand = D.brand_id
                    WHERE P.Id = @Id";


                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
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


                                TB_Supplier.Text = dt.Rows[0]["SupplierName"].ToString();

                                TB_ChallanNo.Text = dt.Rows[0]["ChallanNo"].ToString();
                                TB_ChallanDate.Text = dt.Rows[0]["ChallanDate"].ToString();
                                TB_LotNo.Text = dt.Rows[0]["LotGateNo"].ToString();
                                TB_VehicleNo.Text = dt.Rows[0]["VehicleNo"].ToString();

                                Label_Std_Length.Text = dt.Rows[0]["DimensionStd_L"].ToString();
                                TB_Length.Text = dt.Rows[0]["DimensionObs_L"].ToString();
                                TXB_Length_Remarks.Text = dt.Rows[0]["RemarkForDimensionStd_L"].ToString();

                                Label_Std_Width.Text = dt.Rows[0]["DimensionStd_W"].ToString();
                                TB_Width.Text = dt.Rows[0]["DimensionObs_W"].ToString();
                                TXB_Width_Remarks.Text = dt.Rows[0]["RemarkForDimensionStd_W"].ToString();

                                Label_Std_Height.Text = dt.Rows[0]["DimensionStd_H"].ToString();
                                TB_Height.Text = dt.Rows[0]["DimensionObs_H"].ToString();
                                TXB_Height_Remarks.Text = dt.Rows[0]["RemarkForDimensionStd_H"].ToString();

                                Label_Std_GSM.Text = dt.Rows[0]["GMS_Std"].ToString();
                                TB_GSM.Text = dt.Rows[0]["GSM_Obs"].ToString();
                                TXB_GSM_Remarks.Text = dt.Rows[0]["RemarkForGSM_Std"].ToString();

                                TB_BurstingStrength.Text = dt.Rows[0]["BS_KgPerCm2"].ToString();
                                TB_CompressionStrength.Text = dt.Rows[0]["Comp_Strength"].ToString();
                                TB_FlutePercent.Text = dt.Rows[0]["Flute_Percentage"].ToString();
                                TB_MoisturePercent.Text = dt.Rows[0]["Moisture_Percentage"].ToString();

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