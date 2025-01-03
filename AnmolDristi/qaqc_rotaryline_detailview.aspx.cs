using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using static AnmolDristi.qaqc_rotaryline_detailview;

namespace AnmolDristi
{
    public partial class qaqc_rotaryline_detailview : System.Web.UI.Page
    {
        public static string PlantId = string.Empty;
        public static string PlantName = string.Empty;
        public static string PlantLine = string.Empty;
        public static string ProductCategory = string.Empty;
        public static string CategoryBrand = string.Empty;

        public static string JSON1 = string.Empty;
        public static string JSON2 = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["ID"] != null)
            {
                string ID = Request.QueryString["ID"];              
                PlantBinder();
                DataBinder(ID);
            }
        }

        private void DataBinder(string rlwt)
        {
            getBasicDetails(rlwt);
            BindGridView_LineWeights(rlwt);
            BindGridView_OvenEnd(rlwt);
        }
        private void PlantBinder()
        {
            string query = "SELECT plant_id, CONCAT(plant_name, '[', sap_code, ']') AS plant_name FROM MST_PlantDetails";
            string textField = "plant_name";
            string valueField = "plant_id";

            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Plant, textField, valueField, out recordsBound);

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
            string query = "SELECT category_id, category_name FROM MST_LineCategory WHERE plant_id = @PlantId AND line_id = @LineId";
            string textField = "category_name";
            string valueField = "category_id";

            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@PlantId", selectedPlantValue),
                new SqlParameter("@LineId", selectedPlantLineValue)
            };

            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_ProductCategory, textField, valueField, parameters, out recordsBound);

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


        //Basic Data
        void getBasicDetails(string rlwt)
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
                            P.linewt,
                            P.gaugeandweight,
                            P.*
                        FROM
                            TRN_RotaryLine_OvenEnd P
                        JOIN dbo.MST_PlantDetails A ON P.PlantName = A.plant_id
                        JOIN dbo.MST_Plant_Lines B ON P.Line = B.line_id
                        JOIN dbo.MST_LineCategory C ON P.ProductCategory = C.category_id
                        JOIN dbo.MST_LineCatBrands D ON P.ProductBrand = D.brand_id
                        WHERE P.Id = @RLWt";

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@RLWt", rlwt);

                        con.Open();
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            System.Data.DataTable dt = new System.Data.DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                DataRow row = dt.Rows[0];

                                string plantId = row["PlantID"].ToString();
                                string plantName = row["plant_name"].ToString();
                                DDL_Plant.SelectedItem.Text = plantName;
                                DDL_Plant.Enabled = false;

                                PlantLinesBinder(plantId);
                                string plantLine = row["Line"].ToString();
                                DDL_PlantLine.SelectedValue = plantLine;
                                DDL_PlantLine.Enabled = false;

                                LineProductsBinder(plantId, plantLine);
                                string productCategory = row["ProductCategory"].ToString();
                                DDL_ProductCategory.SelectedValue = productCategory;
                                DDL_ProductCategory.Enabled = false;

                                ProductBrandsBinder(plantId, plantLine, productCategory);
                                string categoryBrand = row["ProductBrand"].ToString();
                                DDL_ProductBrand.SelectedValue = categoryBrand;
                                DDL_ProductBrand.Enabled = false;

                                JSON1 = row["linewt"].ToString();
                                JSON2 = row["gaugeandweight"].ToString();
                            }
                            else
                            {
                                Response.Write("<script>alert('No data found for the given RLWt.');</script>");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                string errorMessage = ex.Message.Replace("'", "\\'");
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

        public class WeightData
        {
            public int sl { get; set; }
            public decimal weight { get; set; }
        }


        private void BindGridView_LineWeights(string rlwt)
        {
            Console.WriteLine($"Value of RLWt: {rlwt}");

            if (string.IsNullOrEmpty(rlwt))
            {
                throw new ArgumentException("The parameter RLWt cannot be null or empty.");
            }

            //string jsonData = GetLineWeightsFromDB(rlwt);
            string jsonData = JSON1;

            if (!string.IsNullOrEmpty(jsonData))
            {
                try
                {
                    List<WeightData> weightDataList = JsonConvert.DeserializeObject<List<WeightData>>(jsonData);

                    DataTable dataTable = new DataTable();
                    dataTable.Columns.Add("sl", typeof(int));
                    dataTable.Columns.Add("weight", typeof(decimal));

                    foreach (var item in weightDataList)
                    {
                        DataRow row = dataTable.NewRow();
                        row["sl"] = item.sl;
                        row["weight"] = item.weight;
                        dataTable.Rows.Add(row);
                    }

                    LineWeights_Grid.DataSource = dataTable;
                    LineWeights_Grid.DataBind();
                }
                catch (JsonException ex)
                {
                    Console.WriteLine($"Error deserializing JSON: {ex.Message}");
                }
            }
            else
            {
                LineWeights_Grid.DataSource = null;
                LineWeights_Grid.DataBind();
                Console.WriteLine("No RLWt value provided.");
            }
        }

        private string GetLineWeightsFromDB(string rlwt)
        {
            if (string.IsNullOrEmpty(rlwt))
            {
                throw new ArgumentException("The RLWt parameter cannot be null or empty.");
            }

            string jsonData = string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string query = @" SELECT linewt FROM TRN_RotaryLine_OvenEnd WHERE Id = @RLWt";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@RLWt", rlwt);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            jsonData = reader["linewt"] != DBNull.Value ? reader["linewt"].ToString() : string.Empty;
                        }
                    }
                }
            }
            return jsonData;
        }

        public class OvenEndData
        {
            public int sl { get; set; }
            public decimal ge { get; set; }
            public decimal wt { get; set; }
        }

        private void BindGridView_OvenEnd(string rlwt)
        {
            Console.WriteLine($"Value of RLWt: {rlwt}");

            if (string.IsNullOrEmpty(rlwt))
            {
                throw new ArgumentException("The parameter RLWt cannot be null or empty.");
            }

            //string jsonData = GetOvenWeightsFromDB(rlwt);
            string jsonData = JSON2;

            if (!string.IsNullOrEmpty(jsonData))
            {
                try
                {
                    List<OvenEndData> OvenEndDataList = JsonConvert.DeserializeObject<List<OvenEndData>>(jsonData);
   
                    DataTable dataTable = new DataTable();
                    dataTable.Columns.Add("sl", typeof(int));
                    dataTable.Columns.Add("ge", typeof(decimal));
                    dataTable.Columns.Add("wt", typeof(decimal));

                    foreach (var item in OvenEndDataList)
                    {
                        DataRow row = dataTable.NewRow();
                        row["sl"] = item.sl;
                        row["ge"] = item.ge;
                        row["wt"] = item.wt;
                        dataTable.Rows.Add(row);
                    }

                    OvenEnd_GridView.DataSource = dataTable;
                    OvenEnd_GridView.DataBind();
                }
                catch (JsonException ex)
                {
                    Console.WriteLine($"Error deserializing JSON: {ex.Message}");
                }
            }
            else
            {
                OvenEnd_GridView.DataSource = null;
                OvenEnd_GridView.DataBind();
                Console.WriteLine("No RLWt value provided.");
            }
        }

        private string GetOvenWeightsFromDB(string rlwt)
        {
            if (string.IsNullOrEmpty(rlwt))
            {
                throw new ArgumentException("The RLWt parameter cannot be null or empty.");
            }

            string jsonData = string.Empty;
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string query = @"SELECT gaugeandweight FROM TRN_RotaryLine_OvenEnd WHERE Id = @RLWt";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@RLWt", rlwt);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            jsonData = reader["gaugeandweight"].ToString();
                        }
                    }
                }
            }

            return jsonData;
        }


        protected void BtnApprove_Click(object sender, EventArgs e)
        {

        }
        protected void BtnReject_Click(object sender, EventArgs e)
        {

        }
    }
}


