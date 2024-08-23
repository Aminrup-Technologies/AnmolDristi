using AnmolDristi.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class qaqc_ProcessChecking_rpt : System.Web.UI.Page
    {
        public static string ImgLink1 = string.Empty;
        public static string ImgLink2 = string.Empty;
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

                    lbl_docname.Text = "QA - Process Checking Report";
                    lbl_docnumber.Text = "ANMOL/DOC/CORP/QA/02";
                    PlantBinder();
                    PlantBinder1();
                    PlantBinder2();
                    PlantBinder3();
                    PlantBinder4();
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
        private void PlantBinder1()
        {
            string query = "SELECT plant_id, CONCAT(plant_name, '[', sap_code, ']') AS plant_name FROM MST_PlantDetails";
            string textField = "plant_name";
            string valueField = "plant_id";

            bool recordsBound;

            // Bind the DropDownList and get the flag indicating whether records were bound
            DatabaseHelper.BindDropDownList(query, DDL_Plant1, textField, valueField, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Plant1);
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
        private void PlantBinder2()
        {
            string query = "SELECT plant_id, CONCAT(plant_name, '[', sap_code, ']') AS plant_name FROM MST_PlantDetails";
            string textField = "plant_name";
            string valueField = "plant_id";

            bool recordsBound;

            // Bind the DropDownList and get the flag indicating whether records were bound
            DatabaseHelper.BindDropDownList(query, DDL_Plant2, textField, valueField, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Plant2);
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
        private void PlantBinder3()
        {
            string query = "SELECT plant_id, CONCAT(plant_name, '[', sap_code, ']') AS plant_name FROM MST_PlantDetails";
            string textField = "plant_name";
            string valueField = "plant_id";

            bool recordsBound;

            // Bind the DropDownList and get the flag indicating whether records were bound
            DatabaseHelper.BindDropDownList(query, DDL_Plant3, textField, valueField, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Plant3);
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
        private void PlantBinder4()
        {
            string query = "SELECT plant_id, CONCAT(plant_name, '[', sap_code, ']') AS plant_name FROM MST_PlantDetails";
            string textField = "plant_name";
            string valueField = "plant_id";

            bool recordsBound;

            // Bind the DropDownList and get the flag indicating whether records were bound
            DatabaseHelper.BindDropDownList(query, DDL_Plant4, textField, valueField, out recordsBound);

            // Check if any records were bound
            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Plant4);
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
        public class ValidationCriteria
        {
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
        protected void DDL_Plant_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Plant.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                PlantLinesBinder(selectedPlantValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_PlantLine);

                string DDL_Plant_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantInvalidErrorNotification", DDL_Plant_Error_script, false);
            }
        }
        protected void DDL_Plant1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Plant1.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant1.SelectedValue.ToString();
                //PlantLinesBinder(selectedPlantValue);
            }
            else
            {
                //DatabaseHelper.BindWithDefaultNoRecords(DDL_PlantLine);

                string DDL_Plant1_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantInvalidErrorNotification", DDL_Plant1_Error_script, false);
            }
        }
        protected void DDL_Plant2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Plant2.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant2.SelectedValue.ToString();
                //PlantLinesBinder(selectedPlantValue);
                ScriptManager.RegisterStartupScript(this, GetType(), "activateTab", "activateTab('rawMaterial-tab');", true);

            }
            else
            {
                //DatabaseHelper.BindWithDefaultNoRecords(DDL_PlantLine);

                string DDL_Plant2_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantInvalidErrorNotification", DDL_Plant2_Error_script, false);
            }
        }
        protected void DDL_Plant3_SelectedIndexChanged1(object sender, EventArgs e)
        {
            if (DDL_Plant3.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant3.SelectedValue.ToString();
                //PlantLinesBinder(selectedPlantValue);
            }
            else
            {
                //DatabaseHelper.BindWithDefaultNoRecords(DDL_PlantLine);

                string DDL_Plant3_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantInvalidErrorNotification", DDL_Plant3_Error_script, false);
            }
        }
        protected void DDL_Plant4_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Plant4.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant4.SelectedValue.ToString();
                //  PlantLinesBinder(selectedPlantValue);
            }
            else
            {
                //DatabaseHelper.BindWithDefaultNoRecords(DDL_PlantLine);

                string DDL_Plant4_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantInvalidErrorNotification", DDL_Plant4_Error_script, false);
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

        protected void DDL_PlantLine_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_PlantLine.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantLineValue = DDL_PlantLine.SelectedValue.ToString();
                LineProductsBinder(selectedPlantValue, selectedPlantLineValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_ProductCategory);

                string DDL_PlantLine_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantInvalidErrorNotification", DDL_PlantLine_Error_script, false);
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

        protected void DDL_ProductCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_ProductCategory.SelectedIndex != 0)
            {
                string selectedPlantValue = DDL_Plant.SelectedValue.ToString();
                string selectedPlantLineValue = DDL_PlantLine.SelectedValue.ToString();
                string selectedProductCategoryValue = DDL_ProductCategory.SelectedValue.ToString();
                ProductBrandsBinder(selectedPlantValue, selectedPlantLineValue, selectedProductCategoryValue);
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_ProductBrand);

                string DDL_PlantLine_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowPlantInvalidErrorNotification", DDL_PlantLine_Error_script, false);
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

        protected void DDL_ProductBrand_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_ProductBrand.SelectedIndex != 0)
            {
                string selectedProductBrandValue = DDL_ProductBrand.SelectedValue.ToString();
                BrandSKUBinder(selectedProductBrandValue);

                DataTable dataTable = DatabaseHelper.GetBrandFieldsControlByBrandId(Convert.ToInt16(selectedProductBrandValue));


                // Example: Querying the DataTable for a specific field name
                //string fieldName = "no_of_pcs"; // Specify the field name you want to query
                //DataRow[] rows = dataTable.Select($"brand_id = {selectedProductBrandValue} AND field_name = '{fieldName}'");

                // Iterate through the filtered rows and extract validation criteria
                foreach (DataRow row in dataTable.Rows)
                {
                    // Extract field name from the current row
                    string fieldName = row["field_name"].ToString();

                    // Extract validation criteria from the DataRow
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
                    //SetUpValidatorsForField(fieldName, criteria);
                }
            }
            else
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_ProductBrand);

                string DDL_ProductBrand_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowSKUInvalidErrorNotification", DDL_ProductBrand_Error_script, false);
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
        protected void BtnUploadFU_MaidaImage_Click(object sender, EventArgs e)
        {
            //Maida image
            if (UploadImage1() == true)
            {
                string UI_1_Successscript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Upload Success',
                                text: 'Image Saved!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowImage1SuccessNotification", UI_1_Successscript, false);
            }
        }

        private bool UploadImage1()
        {
            bool imgSaved = false;

            try
            {
                string TBPhotoId = "QAPC";
                DateTime now = DateTime.Now;

                // Define the target folder path
                string targetFolderPath = Server.MapPath("~/UploadedFiles/QAPC/MaidaImage/");

                // Check if the target folder exists, if not, create it
                if (!Directory.Exists(targetFolderPath))
                {
                    Directory.CreateDirectory(targetFolderPath);
                }

                // Check if a file is posted
                if (FU_MaidaImage.PostedFile != null)
                {
                    // Check the extension of the image
                    string extension = Path.GetExtension(FU_MaidaImage.FileName);
                    if (extension.ToLower() == ".png" || extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg")
                    {
                        // Get the uploaded image stream
                        Stream strm = FU_MaidaImage.PostedFile.InputStream;
                        using (var uploadedImage = System.Drawing.Image.FromStream(strm))
                        {

                            // Resize the image
                            int maxWidth = 800;
                            int newWidth = uploadedImage.Width > maxWidth ? maxWidth : uploadedImage.Width;
                            int newHeight = (int)((double)newWidth / uploadedImage.Width * uploadedImage.Height);
                            using (var resizedImage = uploadedImage.GetThumbnailImage(newWidth, newHeight, null, IntPtr.Zero))
                            {
                                string fileName = $"{TBPhotoId}_{DateTime.Now:yyyyMMddHHmmss}.jpg";
                                // Save the resized image to the target folder
                                string targetPath = Path.Combine(targetFolderPath, fileName);
                                resizedImage.Save(targetPath, System.Drawing.Imaging.ImageFormat.Jpeg);

                                // Set the image link for database
                                ImgLink1 = "~/UploadedFiles/QAPC/MaidaImage/" + fileName;
                                //imgfilename = fileName;

                                // Show the image instantly
                                FU_MaidaImage_img.Visible = true;
                                uploadedImage1.ImageUrl = ImgLink1;

                                // Image saved successfully
                                imgSaved = true;

                                FU_MaidaImage_Upldr.Visible = false;
                            }
                        }
                    }
                    else
                    {
                        // Display error notification for inappropriate file type
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception or display an error message
            }

            return imgSaved;
        }

        private bool UploadImage2()
        {
            bool imgSaved = false;

            try
            {
                string TBPhotoId = "QAPC";
                DateTime now = DateTime.Now;

                // Define the target folder path
                string targetFolderPath = Server.MapPath("~/UploadedFiles/QAPC/BBImage/");

                // Check if the target folder exists, if not, create it
                if (!Directory.Exists(targetFolderPath))
                {
                    Directory.CreateDirectory(targetFolderPath);
                }

                // Check if a file is posted
                if (FU_BBImage.PostedFile != null)
                {
                    // Check the extension of the image
                    string extension = Path.GetExtension(FU_BBImage.FileName);
                    if (extension.ToLower() == ".png" || extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg")
                    {
                        // Get the uploaded image stream
                        Stream strm = FU_BBImage.PostedFile.InputStream;
                        using (var uploadedImage = System.Drawing.Image.FromStream(strm))
                        {

                            // Resize the image
                            int maxWidth = 800;
                            int newWidth = uploadedImage.Width > maxWidth ? maxWidth : uploadedImage.Width;
                            int newHeight = (int)((double)newWidth / uploadedImage.Width * uploadedImage.Height);
                            using (var resizedImage = uploadedImage.GetThumbnailImage(newWidth, newHeight, null, IntPtr.Zero))
                            {
                                string fileName = $"{TBPhotoId}_{DateTime.Now:yyyyMMddHHmmss}.jpg";
                                // Save the resized image to the target folder
                                string targetPath = Path.Combine(targetFolderPath, fileName);
                                resizedImage.Save(targetPath, System.Drawing.Imaging.ImageFormat.Jpeg);

                                // Set the image link for database
                                ImgLink2 = "~/UploadedFiles/QAPC/BBImage/" + fileName;
                                //imgfilename = fileName;

                                // Show the image instantly
                                FU_BBImage_Img.Visible = true;
                                uploadedImage2.ImageUrl = ImgLink2;

                                // Image saved successfully
                                imgSaved = true;

                                FU_BBImage_Upldr.Visible = false;
                            }
                        }
                    }
                    else
                    {
                        // Display error notification for inappropriate file type
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception or display an error message
            }

            return imgSaved;
        }

        protected void BtnUploadFU_BBImage_Click(object sender, EventArgs e)
        {
            //Broken biscuit image
            if (UploadImage2() == true)
            {
                string UI_2_Successscript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Upload Success',
                                text: 'Image Saved!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowImage2SuccessNotification", UI_2_Successscript, false);
            }
        }

        protected void BasicBtnSubmit_Click(object sender, EventArgs e)
        {
            // Retrieve values from controls
            string plantName = DDL_Plant.SelectedValue;
            string line = DDL_PlantLine.SelectedValue;
            string productCategory = DDL_ProductCategory.SelectedValue;
            string productBrand = DDL_ProductBrand.SelectedValue;
            decimal processWaterTemp = Convert.ToDecimal(TB_ProcessWaterTemp.Text);
            decimal waterPh = Convert.ToDecimal(TB_WaterPH.Text);
            decimal waterHardness = Convert.ToDecimal(TB_WaterHardness.Text);
            decimal waterTest = Convert.ToDecimal(TB_WaterTest.Text);
            decimal tds = Convert.ToDecimal(TB_TDS.Text);
            string maidaBrand = TB_MaidaBrand.Text;
            int maidaBatchNo = Convert.ToInt32(TB_MaidaBatchNo.Text);
            int maidaMfg = Convert.ToInt32(TB_MaidaMfg.Text);
            int maidaAppColor = Convert.ToInt32(RBL_MaidaColorApp.SelectedValue);
            string commentForMaidaAppColor = TXB_MaidaColorApp_Remarks.Text;
            int maidaFlavorTaste = Convert.ToInt32(RBL_MaidaFlavorTaste.SelectedValue);
            string commentForMaidaFlavorTaste = TXB_MaidaFlavorTaste_Remarks.Text;
            int maidaGrittiness = Convert.ToInt32(RBL_MaidaGrittiness.SelectedValue);
            string commentsForMaidaGrittiness = TXB_MaidaGrittiness_Remarks.Text;
            int bbAppColor = Convert.ToInt32(RBL_BBColorApp.SelectedValue);
            string commentForBBColor = TXB_BBColorApp_Remarks.Text;
            int bbMouthFeel = Convert.ToInt32(RBL_BBMouthFeel.SelectedValue);
            string commentForBBMouthFeel = TXB_BBMouthFeel_Remarks.Text;
            int bbFlavorTaste = Convert.ToInt32(RBL_BBFlavorTaste.SelectedValue);
            string commentForBBFlavorTaste = TXB_BBFlavorTaste_Remarks.Text;
            int hvoSmell = Convert.ToInt32(RBL_HvoSmell.SelectedValue);
            string commentForHvoSmell = TXB_HvoSmell_Remarks.Text;
            int hvoTaste = Convert.ToInt32(RBL_HvoTaste.SelectedValue);
            string commentForHvoTaste = TXB_HvoTaste_Remarks.Text;
            decimal hvoTemp = Convert.ToDecimal(TB_HvoTemp.Text);
            int smpSmell = Convert.ToInt32(RBL_SMPSmell.SelectedValue);
            string commentForSmpSmell = TXB_SMPSmell_Remarks.Text;
            int smpTaste = Convert.ToInt32(RBL_SMPTaste.SelectedValue);
            string commentForSmpTaste = TXB_SMPSmell_Remarks.Text;
            int smpColor = Convert.ToInt32(RBL_SMPColor.SelectedValue);
            string commentForSmpColor = TXB_SMPColor_Remarks.Text;
            decimal syrupTemp = Convert.ToDecimal(TB_SyrupTemp.Text);
            int syrupColor = Convert.ToInt32(RBL_SyrupColor.SelectedValue);
            string commentForSyrupColor = TXB_SyrupColor_Remarks.Text;
            decimal syrupPh = Convert.ToDecimal(TB_SyrupPH.Text);
            int invertSyrup = Convert.ToInt32(RBL_InvertSyrupBucket.SelectedValue);
            string commentForInvertSyrup = TXB_InvertSyrupBucket_Remarks.Text;
            int sugarSol = Convert.ToInt32(RBL_SugarSolBucket.SelectedValue);
            string commentForSugarSol = TXB_SugarSolBucket_Remarks.Text;
            int creamerBucket = Convert.ToInt32(RBL_CreamerBucketFilter.SelectedValue);
            string commentForCreamerBucket = TXB_CreamerBucket_Remarks.Text;
            int sugarGrinder = Convert.ToInt32(RBL_SugarGrinder.SelectedValue);
            string commentForSugarGrinder = TXB_SugarGrinder_Remarks.Text;
            int oilSystem = Convert.ToInt32(RBL_OilSystem.SelectedValue);
            string commentForOilSystem = TXB_OilSystem_Remarks.Text;
            int oilSpray = Convert.ToInt32(RBL_OilSpray.SelectedValue);
            string commentForOilSpray = TXB_OilSystem_Remarks.Text;
            int milkSpray = Convert.ToInt32(RBL_MilkSpray.SelectedValue);
            string commentForMilkSpray = TXB_MilkSpray_Remarks.Text;
            decimal coldRoomTemp = Convert.ToDecimal(TB_ColdRoomTemp.Text);
            decimal DeepFreezeTemp = Convert.ToDecimal(TB_DeepFreezeTemp.Text);
            //date //shift //time
            char shift = 'A';

            QAProcessCheckingDataAcess dataAccess = new QAProcessCheckingDataAcess();

            try
            {
                // Call the InsertBasicData method with the retrieved values
                dataAccess.InsertBasicData(plantName, line, productCategory, productBrand, DateTime.Now.Date, shift, DateTime.Now.TimeOfDay, processWaterTemp, waterPh,
                                            waterHardness, waterTest, tds, maidaBrand, maidaBatchNo, maidaMfg, maidaAppColor, commentForMaidaAppColor,
                                            maidaFlavorTaste, commentForMaidaFlavorTaste, maidaGrittiness, commentsForMaidaGrittiness, bbAppColor,
                                            commentForBBColor, bbMouthFeel, commentForBBMouthFeel, bbFlavorTaste, commentForBBFlavorTaste, hvoSmell,
                                            commentForHvoSmell, hvoTaste, commentForHvoTaste, hvoTemp, smpSmell, commentForSmpSmell, smpTaste, commentForSmpTaste,
                                            smpColor, commentForSmpColor, syrupTemp, syrupColor, commentForSyrupColor, syrupPh, invertSyrup, commentForInvertSyrup,
                                            sugarSol, commentForSugarSol, creamerBucket, commentForCreamerBucket, sugarGrinder, commentForSugarGrinder, oilSystem,
                                            commentForOilSystem, oilSpray, commentForOilSpray, milkSpray, commentForMilkSpray, coldRoomTemp, DeepFreezeTemp);


                //Make the inputs readonly
                MakeInputsReadOnly();
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
        protected void BasicBtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("qaqc_process_rpt.aspx");
        }
        private void MakeInputsReadOnly()
        {
            //BasicData
            DDL_Plant.Enabled = false;
            DDL_PlantLine.Enabled = false;
            DDL_ProductCategory.Enabled = false;
            DDL_ProductBrand.Enabled = false;
            DDL_BrandSKU.Enabled = false;
            TB_ProcessWaterTemp.ReadOnly = true;
            TB_WaterHardness.ReadOnly = true;
            TB_WaterTest.ReadOnly = true;
            TB_TDS.ReadOnly = true;
            TB_MaidaBrand.ReadOnly = true;
            TB_MaidaBatchNo.ReadOnly = true;
            TB_MaidaMfg.ReadOnly = true;
            RBL_MaidaColorApp.Enabled = false;
            TXB_MaidaColorApp_Remarks.ReadOnly = true;
            RBL_MaidaFlavorTaste.Enabled = false;
            TXB_MaidaFlavorTaste_Remarks.ReadOnly = true;
            RBL_MaidaGrittiness.Enabled = false;
            TXB_MaidaGrittiness_Remarks.ReadOnly = true;
            RBL_BBColorApp.Enabled = false;
            TXB_BBColorApp_Remarks.ReadOnly = true;
            RBL_BBFlavorTaste.Enabled = false;
            TXB_BBFlavorTaste_Remarks.ReadOnly = true;
            RBL_BBMouthFeel.Enabled = false;
            TXB_BBMouthFeel_Remarks.ReadOnly = true;
            RBL_HvoSmell.Enabled = false;
            TXB_HvoSmell_Remarks.ReadOnly = true;
            RBL_HvoTaste.Enabled = false;
            TXB_HvoTaste_Remarks.ReadOnly = true;
            TB_HvoTemp.ReadOnly = true;
            RBL_SMPSmell.Enabled = false;
            TXB_SMPSmell_Remarks.ReadOnly = true;
            RBL_SMPTaste.Enabled = false;
            TXB_SMPTaste_Remarks.ReadOnly = true;
            RBL_SMPColor.Enabled = false;
            TXB_SMPColor_Remarks.ReadOnly = true;
            TB_SyrupTemp.ReadOnly = true;
            RBL_SyrupColor.Enabled = false;
            TXB_SyrupColor_Remarks.ReadOnly = true;
            TB_SyrupPH.ReadOnly = true;
            RBL_InvertSyrupBucket.Enabled = false;
            TXB_InvertSyrupBucket_Remarks.ReadOnly = true;
            RBL_SugarSolBucket.Enabled = false;
            TXB_SugarSolBucket_Remarks.ReadOnly = true;
            RBL_CreamerBucketFilter.Enabled = false;
            TXB_CreamerBucket_Remarks.ReadOnly = true;
            RBL_SugarGrinder.Enabled = false;
            TXB_SugarGrinder_Remarks.ReadOnly = true;
            RBL_OilSystem.Enabled = false;
            TXB_OilSystem_Remarks.ReadOnly = true;
            RBL_OilSpray.Enabled = false;
            TXB_OilSpray_Remarks.ReadOnly = true;
            RBL_MilkSpray.Enabled = false;
            TXB_MilkSpray_Remarks.ReadOnly = true;
            TB_ColdRoomTemp.ReadOnly = true;
            TB_DeepFreezeTemp.ReadOnly = true;


            BasicBtnSubmit.Enabled = false;
            BasicBtnSubmit.Text = "SAVED";
            BasicBtnSubmit.CssClass = "btn btn-sm btn-success";

            string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Data Success',
                                text: 'Recorded Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

            // RegisterStartupScript adds the JavaScript code to the page
            ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SwitchTab", "document.getElementById('rawMaterial-tab').click();", true);

        }

        protected void RawBtnSubmit_Click(object sender, EventArgs e)
        {
            // Retrieve values from controls
            string plantName1 = DDL_Plant1.SelectedValue;
            string maidaBrandName = TB_MaidaBrandName.Text;
            decimal maidaWgt = Convert.ToDecimal(TB_MaidaActWgt.Text);
            decimal sugarWgt = Convert.ToDecimal(TB_SugarActWgt.Text);
            decimal butter = Convert.ToDecimal(TB_ButterActWgt.Text);
            decimal smp = Convert.ToDecimal(TB_SMPActWgt.Text);
            decimal processWater = Convert.ToDecimal(TB_PWActWgt.Text);
            decimal lecithin = Convert.ToDecimal(TB_LecithinActWgt.Text);
            decimal gms = Convert.ToDecimal(TB_GMSActWgt.Text);
            decimal ssl = Convert.ToDecimal(TB_SSLActWgt.Text);
            decimal glucose = Convert.ToDecimal(TB_GlucoseActWgt.Text);
            decimal hvo = Convert.ToDecimal(TB_HVOActWgt.Text);
            decimal syrup = Convert.ToDecimal(TB_SyrupActWgt.Text);
            decimal malt = Convert.ToDecimal(TB_MaltActWgt.Text);
            decimal bb = Convert.ToDecimal(TB_BBActWgt.Text);
            decimal abc = Convert.ToDecimal(TB_ABCActWgt.Text);
            decimal sbc = Convert.ToDecimal(TB_SBCActWgt.Text);
            decimal smbs = Convert.ToDecimal(TB_SMBSActWgt.Text);
            decimal wheyPowder = Convert.ToDecimal(TB_WheyPowderActWgt.Text);
            decimal condenceMilk = Convert.ToDecimal(TB_MilkActWgt.Text);
            decimal salt = Convert.ToDecimal(TB_SaltActWgt.Text);
            decimal yeast = Convert.ToDecimal(TB_YeastActWgt.Text);
            decimal e1 = Convert.ToDecimal(TB_E1ActWgt.Text);
            decimal caramel = Convert.ToDecimal(TB_CaramelActWgt.Text);

            QAProcessCheckingDataAcess dataAccess = new QAProcessCheckingDataAcess();

            try
            {
                // Call the InsertBasicData method with the retrieved values
                dataAccess.InsertRawMaterialData(plantName1, maidaBrandName, maidaWgt, sugarWgt, butter, smp, processWater, lecithin, gms, ssl, glucose, hvo, syrup,
                                            malt, bb, abc, sbc, smbs, wheyPowder, condenceMilk, salt, yeast, e1, caramel);

                //Make the inputs readonly
                MakeInputsReadOnly1();
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
        protected void RawBtnReset_Click(object sender, EventArgs e)
        {
            //ScriptManager.RegisterStartupScript(this, GetType(), "clearFields", "document.getElementById('rawMaterial-tab').value = '';", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "activateTab", "activateTab('rawMaterial-tab');", true);
            //or
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "clearAndActivate", "clearFields('rawMaterial-tab'); activateTab();", true);
        }
        private void MakeInputsReadOnly1()
        {
            //Raw Material Data
            DDL_Plant.Enabled = false;
            DDL_PlantLine.Enabled = false;
            DDL_ProductCategory.Enabled = false;
            DDL_ProductBrand.Enabled = false;
            DDL_BrandSKU.Enabled = false;
            TB_MaidaActWgt.ReadOnly = true;
            TB_SugarActWgt.ReadOnly = true;
            TB_ButterActWgt.ReadOnly = true;
            TB_SMPActWgt.ReadOnly = true;
            TB_ProcessWaterTemp.ReadOnly = true;
            TB_LecithinActWgt.ReadOnly = true;
            TB_GMSActWgt.ReadOnly = true;
            TB_SSLActWgt.ReadOnly = true;
            TB_GlucoseActWgt.ReadOnly = true;
            TB_HVOActWgt.ReadOnly = true;
            TB_SyrupActWgt.ReadOnly = true;
            TB_MaltActWgt.ReadOnly = true;
            TB_BBActWgt.ReadOnly = true;
            TB_ABCActWgt.ReadOnly = true;
            TB_SBCActWgt.ReadOnly = true;
            TB_SMBSActWgt.ReadOnly = true;
            TB_WheyPowderActWgt.ReadOnly = true;
            TB_MilkActWgt.ReadOnly = true;
            TB_SaltActWgt.ReadOnly = true;
            TB_YeastActWgt.ReadOnly = true;
            TB_E1ActWgt.ReadOnly = true;
            TB_CaramelActWgt.ReadOnly = true;

            ImgLink1 = string.Empty;
            ImgLink2 = string.Empty;

            BasicBtnSubmit.Enabled = false;
            BasicBtnSubmit.Text = "SAVED";
            BasicBtnSubmit.CssClass = "btn btn-sm btn-success";

            string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Data Success',
                                text: 'Recorded Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

            // RegisterStartupScript adds the JavaScript code to the page
            ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SwitchTab", "document.getElementById('spongeData-tab').click();", true);
        }

        protected void SpongeBtnSubmit_Click(object sender, EventArgs e)
        {
            // Retrieve values from controls
            string plantName2 = DDL_Plant2.SelectedValue;
            decimal roomTemp = Convert.ToDecimal(TB_RoomTemp.Text);
            int drumCovered = Convert.ToInt32(RBL_DrumCovered.SelectedValue);
            string commentForDrumCovered = TXB_DrumCovered_Remarks.Text;
            int quality = Convert.ToInt32(RBL_Quality.SelectedValue);
            string commentForQuality = TXB_Quality_Remarks.Text;
            string standingTime = TB_StandingTime.Text;
            decimal temp = Convert.ToDecimal(TB_Temp.Text);

            QAProcessCheckingDataAcess dataAccess = new QAProcessCheckingDataAcess();

            try
            {
                // Call the InsertBasicData method with the retrieved values
                dataAccess.InsertSpongeData(plantName2, roomTemp, drumCovered, commentForDrumCovered, quality, commentForQuality, standingTime, temp);

                //Make the inputs readonly
                MakeInputsReadOnly2();
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
        protected void Spongebtn_Reset_Click(object sender, EventArgs e)
        {

        }
        private void MakeInputsReadOnly2()
        {
            //BasicData
            DDL_Plant.Enabled = false;
            TB_RoomTemp.ReadOnly = true;
            RBL_DrumCovered.Enabled = false;
            TXB_DrumCovered_Remarks.ReadOnly = true;
            RBL_Quality.Enabled = false;
            TXB_Quality_Remarks.ReadOnly = true;
            TB_StandingTime.ReadOnly = true;
            TB_Temp.ReadOnly = true;

            BasicBtnSubmit.Enabled = false;
            BasicBtnSubmit.Text = "SAVED";
            BasicBtnSubmit.CssClass = "btn btn-sm btn-success";

            string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Data Success',
                                text: 'Recorded Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

            // RegisterStartupScript adds the JavaScript code to the page
            ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SwitchTab", "document.getElementById('doughData-tab').click();", true);

        }


        protected void DoughBtnSubmit_Click(object sender, EventArgs e)
        {
            // Retrieve values from controls
            string plantName3 = DDL_Plant3.SelectedValue;
            decimal doughTemp = Convert.ToDecimal(TB_DoughTemp.Text);
            string restTime = TB_DoughRestTime.Text;
            int metalDetector = Convert.ToInt32(RBL_MetalDectector.SelectedValue);
            string commentForMetalDetector = TXB_MetalDectector_Remarks.Text;
            int processSequence = Convert.ToInt32(RBL_ProcessSequence.SelectedValue);
            string commentForProcessSequence = TXB_ProcessSequence_Remarks.Text;
            string creamingTime = TB_CreamingTime.Text;
            string mixingTime = TB_MixingTime.Text;
            string bakingTime = TB_BakingTime.Text;
            int diceRmp = Convert.ToInt32(TB_DiceRpm.Text);
            int doughCondition = Convert.ToInt32(RBL_DoughCondition.SelectedValue);
            string commentForDoughCondition = TXB_DoughCondition_Remarks.Text;

            QAProcessCheckingDataAcess dataAccess = new QAProcessCheckingDataAcess();

            try
            {
                // Call the InsertBasicData method with the retrieved values
                dataAccess.InsertDoughData(plantName3, doughTemp, restTime, metalDetector, commentForMetalDetector, processSequence, commentForProcessSequence,
                                        creamingTime, mixingTime, bakingTime, diceRmp, doughCondition, commentForDoughCondition);

                //Make the inputs readonly
                MakeInputsReadOnly3();
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
        protected void DoughBtnReset_Click(object sender, EventArgs e)
        {

        }
        private void MakeInputsReadOnly3()
        {
            //BasicData
            DDL_Plant.Enabled = false;
            TB_DoughTemp.ReadOnly = true;
            TB_DoughRestTime.ReadOnly = true;
            RBL_MetalDectector.Enabled = false;
            TXB_MetalDectector_Remarks.ReadOnly = true;
            RBL_ProcessSequence.Enabled = false;
            TXB_ProcessSequence_Remarks.ReadOnly = true;
            TB_CreamingTime.ReadOnly = true;
            TB_MixingTime.ReadOnly = true;
            TB_BakingTime.ReadOnly = true;
            TB_DiceRpm.ReadOnly = true;
            RBL_DoughCondition.Enabled = false;
            TXB_DoughCondition_Remarks.ReadOnly = true;


            BasicBtnSubmit.Enabled = false;
            BasicBtnSubmit.Text = "SAVED";
            BasicBtnSubmit.CssClass = "btn btn-sm btn-success";

            string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Data Success',
                                text: 'Recorded Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

            // RegisterStartupScript adds the JavaScript code to the page
            ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SwitchTab", "document.getElementById('ovenData-tab').click();", true);

        }

        protected void OvenBtnSubmit_Click(object sender, EventArgs e)
        {
            // Retrieve values from controls
            string plantName4 = DDL_Plant4.SelectedValue;
            string zone1Top = TB_Zone1Top.Text;
            string zone1Bottom = TB_Zone1Bottom.Text;
            string zone2Top = TB_Zone2Top.Text;
            string zone2Bottom = TB_Zone2Bottom.Text;
            string zone3Top = TB_Zone3Top.Text;
            string zone3Bottom = TB_Zone3Bottom.Text;
            string zone4Top = TB_Zone4Top.Text;
            string zone4Bottom = TB_Zone4Bottom.Text;
            string zone5Top = TB_Zone5Top.Text;
            string zone5Bottom = TB_Zone5Bottom.Text;
            string zone6Top = TB_Zone6Top.Text;
            string zone6Bottom = TB_Zone6Bottom.Text;

            string DPzone1Top = TB_DPZone1Top.Text;
            string DPzone1Bottom = TB_DPZone1Bottom.Text;
            string DPzone2Top = TB_DPZone2Top.Text;
            string DPzone2Bottom = TB_DPZone2Bottom.Text;
            string DPzone3Top = TB_DPZone3Top.Text;
            string DPzone3Bottom = TB_DPZone3Bottom.Text;
            string DPzone4Top = TB_DPZone4Top.Text;
            string DPzone4Bottom = TB_DPZone4Bottom.Text;
            string DPzone5Top = TB_DPZone5Top.Text;
            string DPzone5Bottom = TB_DPZone5Bottom.Text;
            string DPzone6Top = TB_DPZone6Top.Text;
            string DPzone6Bottom = TB_DPZone6Bottom.Text;

            QAProcessCheckingDataAcess dataAccess = new QAProcessCheckingDataAcess();

            try
            {
                // Call the InsertBasicData method with the retrieved values
                dataAccess.InsertOvenData(plantName4, zone1Top, zone1Bottom, zone2Top, zone2Bottom, zone3Top, zone3Bottom, zone4Top, zone4Bottom, zone5Top,
                                        zone5Bottom, zone6Top, zone6Bottom, DPzone1Top, DPzone1Bottom, DPzone2Top, DPzone2Bottom, DPzone3Top, DPzone3Bottom,
                                        DPzone4Top, DPzone4Bottom, DPzone5Top, DPzone5Bottom, DPzone6Top, DPzone6Bottom);

                //Make the inputs readonly
                MakeInputsReadOnly4();

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
        protected void OvenBtnReset_Click(object sender, EventArgs e)
        {

        }
        private void MakeInputsReadOnly4()
        {
            //BasicData
            DDL_Plant.Enabled = false;
            TB_Zone1Top.ReadOnly = true;
            TB_Zone1Bottom.ReadOnly = true;
            TB_Zone2Top.ReadOnly = true;
            TB_Zone2Bottom.ReadOnly = true;
            TB_Zone3Top.ReadOnly = true;
            TB_Zone3Bottom.ReadOnly = true;
            TB_Zone4Top.ReadOnly = true;
            TB_Zone4Bottom.ReadOnly = true;
            TB_Zone5Top.ReadOnly = true;
            TB_Zone5Bottom.ReadOnly = true;
            TB_Zone6Top.ReadOnly = true;
            TB_Zone6Bottom.ReadOnly = true;

            TB_DPZone1Top.ReadOnly = true;
            TB_DPZone1Bottom.ReadOnly = true;
            TB_DPZone2Top.ReadOnly = true;
            TB_DPZone2Bottom.ReadOnly = true;
            TB_DPZone3Top.ReadOnly = true;
            TB_DPZone3Bottom.ReadOnly = true;
            TB_DPZone4Top.ReadOnly = true;
            TB_DPZone4Bottom.ReadOnly = true;
            TB_DPZone5Top.ReadOnly = true;
            TB_DPZone5Bottom.ReadOnly = true;
            TB_DPZone6Top.ReadOnly = true;
            TB_DPZone6Bottom.ReadOnly = true;


            BasicBtnSubmit.Enabled = false;
            BasicBtnSubmit.Text = "SAVED";
            BasicBtnSubmit.CssClass = "btn btn-sm btn-success";

            string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Data Success',
                                text: 'Recorded Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

            // RegisterStartupScript adds the JavaScript code to the page
            ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SwitchTab", "document.getElementById('verificationData-tab').click();", true);

        }


        protected void FinalBtnSubmit_Click(object sender, EventArgs e)
        {
            // Retrieve values from controls
            int balanceCond = Convert.ToInt32(RBL_BalanceCondition.Text);
            string commentForBalanceCond = TXB_BalanceCondition_Remarks.Text;
            string rawBiscuitWgt = TB_RawBiscuitWgt.Text;

            int submittedById = 1;
            string SubmittedByPNo = Session["USERID"].ToString();

            QAProcessCheckingDataAcess dataAccess = new QAProcessCheckingDataAcess();

            try
            {
                // Call the InsertQCInspectorData method with the retrieved values
                dataAccess.InsertVerifiedData(balanceCond, commentForBalanceCond, rawBiscuitWgt, submittedById, DateTime.Now.Date,
                                                    DateTime.Now.TimeOfDay, SubmittedByPNo);

                //Make the inputs readonly
                MakeInputsReadOnly5();

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
        protected void FinalBtnReset_Click(object sender, EventArgs e)
        {


        }
        private void MakeInputsReadOnly5()
        {
            //BasicData
            DDL_Plant.Enabled = false;
            RBL_BalanceCondition.Enabled = false;
            TXB_BalanceCondition_Remarks.ReadOnly = true;
            TB_RawBiscuitWgt.ReadOnly = true;


            BasicBtnSubmit.Enabled = false;
            BasicBtnSubmit.Text = "SAVED";
            BasicBtnSubmit.CssClass = "btn btn-sm btn-success";

            string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Data Success',
                                text: 'Recorded Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

            // RegisterStartupScript adds the JavaScript code to the page
            ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);

        }
    }
}