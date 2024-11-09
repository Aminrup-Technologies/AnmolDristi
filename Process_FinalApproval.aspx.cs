using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using Newtonsoft.Json;

namespace AnmolDristi
{
    public partial class Process_FinalApproval : System.Web.UI.Page
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
                if (Request.QueryString["PcrNo"] != null) 
                {
                    string pcrNo = Request.QueryString["PcrNo"];

                    PlantBinder();
                    DataBinder(pcrNo);
                }
            }
        }

        private void DataBinder(string pcrNo)
        {
            getBasicDetails(pcrNo);         //Basic Data
            BindGridView_RawWeights(pcrNo); //Raw Weight
            getSpongDetails(pcrNo);         //Sponge
            getDoughDetails(pcrNo);         //Dough
            BindGridView_OvenTemps(pcrNo);  //Oven Temp
            getVerifiedDetails(pcrNo);      //Verified 
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

        //Basic Data
        void getBasicDetails(string pcrNo)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_PCR_ApprovalData", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PcrNo", pcrNo);
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

                                PlantLinesBinder(PlantId);
                                PlantLine = dt.Rows[0]["line"].ToString();
                                DDL_PlantLine.SelectedValue = PlantLine; //This is for binding the DDL using Value / ID

                                LineProductsBinder(PlantId,PlantLine);
                                ProductCategory = dt.Rows[0]["ProductCategory"].ToString();
                                DDL_ProductCategory.SelectedValue = ProductCategory;

                                ProductBrandsBinder(PlantId, PlantLine, ProductCategory);
                                CategoryBrand = dt.Rows[0]["ProductBrand"].ToString();
                                DDL_ProductBrand.SelectedValue = CategoryBrand;

                                BrandSKUBinder(CategoryBrand);
                                BrandSKU = dt.Rows[0]["SKUId"].ToString();
                                DDL_BrandSKU.SelectedValue = BrandSKU;

                                TB_ProcessWaterTemp.Text = dt.Rows[0]["ProcessWaterTemp"].ToString();
                                TB_WaterPH.Text = dt.Rows[0]["WaterPH"].ToString();
                                TB_WaterHardness.Text = dt.Rows[0]["WaterHardness"].ToString();
                                TB_WaterTest.Text = dt.Rows[0]["WaterTest"].ToString();
                                TB_TDS.Text = dt.Rows[0]["TDS"].ToString();

                                TB_MaidaBrand.Text = dt.Rows[0]["MaidaBrand"].ToString();
                                TB_MaidaBatchNo.Text = dt.Rows[0]["MaidaBatchNo"].ToString();
                                TB_MaidaMfg.Text = dt.Rows[0]["MaidaMfgDate"].ToString();

                                RBL_MaidaColorApp.SelectedValue = dt.Rows[0]["MaidaAppearanceColor"].ToString();
                                TXB_MaidaColorApp_Remarks.Text = dt.Rows[0]["CommentForMaidaColor"].ToString();

                                RBL_MaidaFlavorTaste.SelectedValue = dt.Rows[0]["MaidaFlavorAndTaste"].ToString();
                                TXB_MaidaFlavorTaste_Remarks.Text = dt.Rows[0]["CommentsForMaidaFlavourAndTaste"].ToString();

                                RBL_MaidaGrittiness.SelectedValue = dt.Rows[0]["MaidaGrittiness"].ToString();
                                TXB_MaidaGrittiness_Remarks.Text = dt.Rows[0]["CommentForGrittiness"].ToString();

                                RBL_BBColorApp.SelectedValue = dt.Rows[0]["BBAppearanceColor"].ToString();
                                TXB_BBColorApp_Remarks.Text = dt.Rows[0]["CommentForBBColor"].ToString();

                                RBL_BBMouthFeel.SelectedValue = dt.Rows[0]["BBMouthFeel"].ToString();
                                TXB_BBMouthFeel_Remarks.Text = dt.Rows[0]["CommentForBBMouthFeel"].ToString();

                                RBL_BBFlavorTaste.SelectedValue = dt.Rows[0]["BBFlavorAndTaste"].ToString();
                                TXB_BBFlavorTaste_Remarks.Text = dt.Rows[0]["CommentForBBFlavorAndTaste"].ToString();

                                RBL_HvoSmell.SelectedValue = dt.Rows[0]["HvoSmell"].ToString();
                                TXB_HvoSmell_Remarks.Text = dt.Rows[0]["CommentForHvoSmell"].ToString();

                                RBL_HvoTaste.SelectedValue = dt.Rows[0]["HvoTaste"].ToString();
                                TXB_HvoTaste_Remarks.Text = dt.Rows[0]["CommentForHvoTaste"].ToString();

                                TB_HvoTemp.Text = dt.Rows[0]["HvoTemp"].ToString();

                                RBL_SMPSmell.SelectedValue = dt.Rows[0]["SmpSmell"].ToString();
                                TXB_SMPSmell_Remarks.Text = dt.Rows[0]["CommentForSmpSmell"].ToString();

                                RBL_SMPTaste.SelectedValue = dt.Rows[0]["SmpTaste"].ToString();
                                TXB_SMPTaste_Remarks.Text = dt.Rows[0]["CommentForSmpTaste"].ToString();

                                RBL_SMPColor.SelectedValue = dt.Rows[0]["SmpColor"].ToString();
                                TXB_SMPColor_Remarks.Text = dt.Rows[0]["CommentForSmpColor"].ToString();

                                TB_SyrupTemp.Text = dt.Rows[0]["SyrupTemp"].ToString();

                                RBL_SyrupColor.SelectedValue = dt.Rows[0]["SyrupColor"].ToString();
                                TXB_SyrupColor_Remarks.Text = dt.Rows[0]["CommentForSyrupColor"].ToString();

                                TB_SyrupPH.Text = dt.Rows[0]["SyrupPH"].ToString();

                                RBL_InvertSyrupBucket.SelectedValue = dt.Rows[0]["InvertSyrpBucketFilter"].ToString();
                                TXB_InvertSyrupBucket_Remarks.Text = dt.Rows[0]["CommentForISBF"].ToString();

                                RBL_SugarSolBucket.SelectedValue = dt.Rows[0]["SugarSolBucketFilter"].ToString();
                                TXB_SugarSolBucket_Remarks.Text = dt.Rows[0]["CommentForSSBF"].ToString();

                                RBL_CreamerBucketFilter.SelectedValue = dt.Rows[0]["CreamerBucketFilter"].ToString();
                                TXB_CreamerBucket_Remarks.Text = dt.Rows[0]["CommentForCBF"].ToString();

                                RBL_SugarGrinder.SelectedValue = dt.Rows[0]["SugarGrindedSheet"].ToString();
                                TXB_SugarGrinder_Remarks.Text = dt.Rows[0]["CommentForSGS"].ToString();

                                RBL_OilSystem.SelectedValue = dt.Rows[0]["OilSystemBucketFilter"].ToString();
                                TXB_OilSystem_Remarks.Text = dt.Rows[0]["CommentForOSBF"].ToString();

                                RBL_OilSpray.SelectedValue = dt.Rows[0]["OilSpray"].ToString();
                                TXB_OilSpray_Remarks.Text = dt.Rows[0]["CommentForOilSpray"].ToString();

                                RBL_MilkSpray.SelectedValue = dt.Rows[0]["MilkSpray"].ToString();
                                TXB_MilkSpray_Remarks.Text = dt.Rows[0]["CommentForMilkSpray"].ToString();

                                TB_ColdRoomTemp.Text = dt.Rows[0]["ColdRoomTemp"].ToString();
                                TB_DeepFreezeTemp.Text = dt.Rows[0]["DeepFreezeTemp"].ToString();

                                imgMaida.ImageUrl = dt.Rows[0]["MaidaImageUrl"].ToString();
                                imgBB.ImageUrl = dt.Rows[0]["BBImageUrl"].ToString();

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


        // Weight data
        public class VarietyInfo
        {
            public string Sl { get; set; }
            public string Variety { get; set; }
            public string StandardWeight { get; set; }
            public string ActualWeight { get; set; }
            public string DeviationWeight { get; set; }
            public string DeviationPercentage { get; set; }
        }
        private void BindGridView_RawWeights(string pcrNo)
        {
            // Step 1: Retrieve the JSON data from the database
            string jsonData = GetRawMaterialWeightsFromDB(pcrNo);

            // Step 2: Deserialize the JSON data into a list of ZoneInfo objects
            if (!string.IsNullOrEmpty(jsonData))
            {
                var varietyInfoList = JsonConvert.DeserializeObject<List<VarietyInfo>>(jsonData);

                // Step 3: Bind the deserialized data to the GridView
                GridView1.DataSource = varietyInfoList;
                GridView1.DataBind();
            }
            else
            {
                // Handle the case where no data is found
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        private string GetRawMaterialWeightsFromDB(string pcrNo)
        {
            string jsonData = string.Empty;

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SP_PCR_ApprovalData", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@PcrNo", pcrNo);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            jsonData = reader["RM_Weights"].ToString();
                        }
                    }
                }
            }

            return jsonData;
        }

        //Spong Data
        void getSpongDetails(string pcrNo)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_PCR_ApprovalData", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PcrNo", pcrNo);
                        con.Open();
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            System.Data.DataTable dt = new System.Data.DataTable();
                            sda.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                DataRow row = dt.Rows[0];

                                TB_RoomTemp.Text = dt.Rows[0]["RoomTemp"].ToString();
                                TXB_RoomTemp_Remarks.Text = dt.Rows[0]["RoomTempCmnt"].ToString();

                                RBL_DrumCovered.SelectedValue = dt.Rows[0]["DrumCovered"].ToString();
                                TXB_DrumCovered_Remarks.Text = dt.Rows[0]["DrumCmnt"].ToString();

                                RBL_Quality.SelectedValue = dt.Rows[0]["Quality"].ToString();
                                TXB_Quality_Remarks.Text = dt.Rows[0]["QualityCmnt"].ToString();

                                TB_StandingTime.Text = dt.Rows[0]["StandingTime"].ToString();

                                TB_Temp.Text = dt.Rows[0]["Temp"].ToString();
                                TXB_Temp_Remarks.Text = dt.Rows[0]["TempCmnt"].ToString();
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

        //Dough Data
        void getDoughDetails(string pcrNo)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_PCR_ApprovalData", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PcrNo", pcrNo);
                        con.Open();
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            System.Data.DataTable dt = new System.Data.DataTable();
                            sda.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                DataRow row = dt.Rows[0];

                               TB_DoughTemp.Text = dt.Rows[0]["DoughTemp"].ToString();
                               TXB_DoughTemp_Remarks.Text = dt.Rows[0]["DoughTempCmnt"].ToString();

                               TB_DoughRestTime.Text = dt.Rows[0]["DoughRestTime"].ToString();
                               
                               RBL_MetalDectector.SelectedValue = dt.Rows[0]["MetalDetector"].ToString();
                               TXB_MetalDetector_Remarks.Text = dt.Rows[0]["DetectorCmnt"].ToString();

                               RBL_ProcessSequence.SelectedValue = dt.Rows[0]["ProcessSequence"].ToString();
                               TXB_ProcessSequence_Remarks.Text = dt.Rows[0]["ProcessCmnt"].ToString();
                                
                               TB_CreamingTime.Text = dt.Rows[0]["CreamingTime"].ToString();
                               TB_MixingTime.Text = dt.Rows[0]["MixingTime"].ToString();
                               TB_BakingTime.Text = dt.Rows[0]["BakingTime"].ToString();

                               TB_DiceRpm.Text = dt.Rows[0]["DiceRpm"].ToString();

                               RBL_DoughCondition.SelectedValue = dt.Rows[0]["DoughConditon"].ToString();
                               TXB_DoughCondition_Remarks.Text = dt.Rows[0]["DoughCmnt"].ToString() ;
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

        // Oven data
        public class ZoneInfo
        {
            public string Sl { get; set; }
            public string Zone { get; set; }
            public string OvenTop { get; set; }
            public string OvenBottom { get; set; }
            public string DamperTop { get; set; }
            public string DamperBottom { get; set; }
        }
        private void BindGridView_OvenTemps(string pcrNo)
        {
            // Step 1: Retrieve the JSON data from the database
            string jsonData = GetOvenTemperaturesFromDB(pcrNo);

            // Step 2: Deserialize the JSON data into a list of ZoneInfo objects
            if (!string.IsNullOrEmpty(jsonData))
            {
                var zoneInfoList = JsonConvert.DeserializeObject<List<ZoneInfo>>(jsonData);

                // Step 3: Bind the deserialized data to the GridView
                GridView2.DataSource = zoneInfoList;
                GridView2.DataBind();
            }
            else
            {
                // Handle the case where no data is found
                GridView2.DataSource = null;
                GridView2.DataBind();
            }
        }
        private string GetOvenTemperaturesFromDB(string pcrNo)
        {
            string jsonData = string.Empty;

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SP_PCR_ApprovalData", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@PcrNo", pcrNo);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            jsonData = reader["Oven_Temperatures"].ToString();
                        }
                    }
                }
            }

            return jsonData;
        }

        // Verified Data
        void getVerifiedDetails(string pcrNo)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SP_PCR_ApprovalData", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PcrNo", pcrNo);
                        con.Open();
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            System.Data.DataTable dt = new System.Data.DataTable();
                            sda.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                DataRow row = dt.Rows[0];

                                RBL_BalanceCondition.SelectedValue = dt.Rows[0]["WghBalanceCond"].ToString();
                                TXB_BalanceCondition_Remarks.Text = dt.Rows[0]["WghtBalanceCmnt"].ToString();

                                TB_RawBiscuitWgt.Text = dt.Rows[0]["RawBiscuitWgt"].ToString();
                                
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


