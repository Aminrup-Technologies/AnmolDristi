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
    public partial class LeakAndSlant_Detailed : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {

            //if (!IsPostBack) // Ensure data binding happens only on the first page load
            //{
            //    string batchid = "241204193301B7AHO445"; // Manually assign the BatchID
            //    DataBinder(batchid);
            //}

            if (Request.QueryString["BatchID"] != null)
            {
                string batchid = Request.QueryString["BatchID"];
                DataBinder(batchid);
            }
            else
            {
                Response.Write("<script>alert('BatchID is missing in the query string.');</script>");
            }

        }

        private void DataBinder(string batchid)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                string query = @"
                    SELECT
                         A.plant_name AS Plant, 
                         B.line_name AS PlantLine, 
                         C.category_name AS ProductCategory, 
                         D.brand_name AS ProductBrand, 
                         E.SKU_name AS BrandSKU, 
                         P.Packing_MC_No AS PackingMCNo, 
                         P.LeakTestStatus AS LeakTestSealIntegrity, 
                         P.RemarksForFail AS PassFailRemarks, 
                         P.Slanted_Percent AS PercentageSlanted 
                     FROM
                         TRN_LeakSealSlanted_Data P
                     JOIN dbo.MST_PlantDetails A ON P.PlantName = A.plant_id
                     JOIN dbo.MST_Plant_Lines B ON P.Line = B.line_id
                     JOIN dbo.MST_LineCategory C ON P.ProductCategory = C.category_id
                     JOIN dbo.MST_LineCatBrands D ON P.ProductBrand = D.brand_id
                     JOIN dbo.MST_Brand_SKU E ON P.SKUId = E.SKUId  
                     WHERE P.BatchID = @BatchID";


                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@BatchID", batchid);

                        con.Open();
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            System.Data.DataTable dt = new System.Data.DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                gvData.DataSource = dt;
                                gvData.DataBind();
                            }
                            else
                            {
                                Response.Write("<script>alert('No data found for the given BatchID.');</script>");
                                gvData.DataSource = null;
                                gvData.DataBind();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error: {ex.Message}');</script>");
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