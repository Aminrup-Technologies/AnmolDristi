using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Material_Master : System.Web.UI.Page
    {
        public static string ImgLink1 = string.Empty;
        public static string MaterialNumber = string.Empty;
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
                    lbl_docname.Text = "Material Master";

                    // Call a helper method to make all controls visible
                    SetControlsVisible(Page.Controls, true);

                    DataBinder();

                    FU_FitnessDocImage_Upldr.Visible = false;
                    FU_FitnessDocImage_img.Visible = false;

                }

            }
        }

        private void DataBinder()
        {
            PopulateTypeDropdown();
            PopulateClassificationDropdown();
            PopulateFreaquencyDropdown();
            PopulateTenureDropdown();
            PopulateStatusDropdown();
            PopulateUnitsDropdown();
        }

        private void PopulateTypeDropdown()
        {
            DDL_MaterialType.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_MaterialType.Items.Add(new ListItem("Consumables", "Consumables"));
            DDL_MaterialType.Items.Add(new ListItem("Non-Consumables", "Non-Consumables"));
        }
        protected void DDL_MaterialType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_MaterialType.SelectedIndex != 0)
            {
                string selectedMaterialType = DDL_MaterialType.SelectedValue.ToString();

                // Call method to show relevant controls based on selected material
                DivBinders(selectedMaterialType);
            }
            else
            {
                string DDL_MaterialType_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowTypeInvalidErrorNotification", DDL_MaterialType_Error_script, false);

            }
        }

        private void PopulateClassificationDropdown()
        {
            DDL_Classification.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_Classification.Items.Add(new ListItem("Departmental Usage", "Departmental Usage"));
            DDL_Classification.Items.Add(new ListItem("Functional Category", "Functional Category"));
        }
        protected void DDL_Classification_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Classification.SelectedItem.Text == "Select")
            {
                string DDL_Classification_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowClassificationnvalidErrorNotification", DDL_Classification_Error_script, false);

            }
        }

        private void PopulateFreaquencyDropdown()
        {
            DDL_MaintenanceFrequency.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_MaintenanceFrequency.Items.Add(new ListItem("Daily", "Daily"));
            DDL_MaintenanceFrequency.Items.Add(new ListItem("Monthly", "Monthly"));
            DDL_MaintenanceFrequency.Items.Add(new ListItem("Quarterly", "Quarterly"));
            DDL_MaintenanceFrequency.Items.Add(new ListItem("Yearly", "Yearly"));
        }
        protected void DDL_MaintenanceFrequency_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_MaintenanceFrequency.SelectedItem.Text == "Select")
            {
                string DDL_MaintenanceFrequency_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowFrequencyInvalidErrorNotification", DDL_MaintenanceFrequency_Error_script, false);

            }

        }

        private void PopulateTenureDropdown()
        {
            DDL_Tenure.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_Tenure.Items.Add(new ListItem("3 months", "3"));
            DDL_Tenure.Items.Add(new ListItem("6 months", "6"));
            DDL_Tenure.Items.Add(new ListItem("12 months", "12"));
        }
        protected void DDL_Tenure_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Check if the tenure is valid
            if (DDL_Tenure.SelectedValue == "0") // Assuming "0" is the default value
            {
                string DDL_Tenure_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowStatusInvalidErrorNotification", DDL_Tenure_Error_script, false);
                return; // Exit if tenure is invalid
            }

            // Validate and parse the Calibration Date
            DateTime calibrationDate;
            if (DateTime.TryParse(TB_CalibrationDate.Text, out calibrationDate))
            {
                // Parse the selected tenure months
                int tenureMonths;
                if (int.TryParse(DDL_Tenure.SelectedValue, out tenureMonths))
                {
                    // Calculate the due date                    
                    DateTime dueDate = calibrationDate.AddMonths(tenureMonths);

                    // Display the due date in the TextBox
                    TB_DueDate.Text = dueDate.ToString("dd-MM-yyyy");
                }
                else
                {
                    TB_DueDate.Text = "Invalid tenure selected";
                }
            }
            else
            {
                TB_DueDate.Text = "Enter a valid calibration date";
            }
        }

        private void PopulateStatusDropdown()
        {
            DDL_Status.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_Status.Items.Add(new ListItem("Operational", "Operational"));
            DDL_Status.Items.Add(new ListItem("Obsolete", "Obsolete"));
        }
        protected void DDL_Status_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_Status.SelectedItem.Text == "Select")
            {
                string DDL_Status_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowStatusInvalidErrorNotification", DDL_Status_Error_script, false);

            }
        }

        private void PopulateUnitsDropdown()
        {
            DDL_UnitOfMeasure.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_UnitOfMeasure.Items.Add(new ListItem("Kg", "Kg"));
            DDL_UnitOfMeasure.Items.Add(new ListItem("Peices", "Peices"));
        }
        protected void DDL_UnitOfMeasure_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_UnitOfMeasure.SelectedItem.Text == "Select")
            {
                string DDL_Unit_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowUnitInvalidErrorNotification", DDL_Unit_Error_script, false);
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string MaterialNumber = GenerateUniqueMno();
            string MaterialType = DDL_MaterialType.SelectedItem.Text;
            string ModelNumber = string.IsNullOrEmpty(TB_ModelNo.Text) ? null : TB_ModelNo.Text;
            string MaterialBrand = string.IsNullOrEmpty(TB_MaterialBrand.Text) ? null : TB_MaterialBrand.Text;
            //string MaterialMechanicalName = string.IsNullOrEmpty(TB_MechName.Text? null : TB_MechName.Text;
            string FriendlyName = string.IsNullOrEmpty(TB_FriendlyName.Text) ? null : TB_FriendlyName.Text;
            string SerialNumber = string.IsNullOrEmpty(TB_SerialNo.Text) ? null : TB_SerialNo.Text;
            int? ManufacturingOrMakeYear = string.IsNullOrEmpty(TB_Mfg.Text) ? (int?)null : Convert.ToInt32(TB_Mfg.Text);
            decimal? PrintedRate = !string.IsNullOrWhiteSpace(TB_PrintedRate.Text) ? Convert.ToDecimal(TB_PrintedRate.Text) : (decimal?)null;
            decimal? PurchaseRate = !string.IsNullOrWhiteSpace(TB_PurchaseRate.Text) ? Convert.ToDecimal(TB_PurchaseRate.Text) : (decimal?)null;
            DateTime? PurchaseDate = string.IsNullOrEmpty(TB_PurchaseDate.Text) ? (DateTime?)null : DateTime.Parse(TB_PurchaseDate.Text).Date;
            string PurchaseOrderNo = string.IsNullOrEmpty(TB_PurchaseOrderNo.Text) ? null : TB_PurchaseOrderNo.Text;
            DateTime? WarrantyEndDate = string.IsNullOrEmpty(TB_WarrantyDate.Text) ? (DateTime?)null : DateTime.Parse(TB_WarrantyDate.Text).Date;
            DateTime? EndOfLife = string.IsNullOrEmpty(TB_EndLife.Text) ? (DateTime?)null : DateTime.Parse(TB_EndLife.Text).Date;
            string MaterialClassification = string.IsNullOrEmpty(DDL_Classification.SelectedItem.Text) ? null : DDL_Classification.Text;
            DateTime? InstallationDate = string.IsNullOrEmpty(TB_Installation.Text) ? (DateTime?)null : DateTime.Parse(TB_Installation.Text).Date;
            string MaintenanceFrequency = string.IsNullOrEmpty(DDL_MaintenanceFrequency.SelectedItem.Text) ? null : DDL_MaintenanceFrequency.Text;
            int? ReorderLevel = string.IsNullOrEmpty(TB_ReoderLevel.Text) ? (int?)null : Convert.ToInt32(TB_ReoderLevel.Text);
            DateTime? ShelfLife = string.IsNullOrEmpty(TB_ShelfLife.Text) ? (DateTime?)null : DateTime.Parse(TB_ShelfLife.Text).Date;
            decimal? OpeningStockQuantity = !string.IsNullOrWhiteSpace(TB_OpeningStockQuantity.Text) ? Convert.ToDecimal(TB_OpeningStockQuantity.Text) : (decimal?)null;
            string UnitOfMeasure = string.IsNullOrEmpty(DDL_UnitOfMeasure.SelectedItem.Text) ? null : DDL_UnitOfMeasure.Text;
            DateTime? LastMaintenanceDate = string.IsNullOrEmpty(TB_LastMaintenance.Text) ? (DateTime?)null : DateTime.Parse(TB_LastMaintenance.Text).Date;
            DateTime? CalibrationDate = string.IsNullOrEmpty(TB_CalibrationDate.Text) ? (DateTime?)null : DateTime.Parse(TB_CalibrationDate.Text).Date;
            string CalibrationTenure = string.IsNullOrEmpty(DDL_Tenure.SelectedItem.Text) ? null : DDL_Tenure.Text;
            DateTime? CalibrationDueDate = string.IsNullOrEmpty(TB_DueDate.Text) ? (DateTime?)null : DateTime.Parse(TB_DueDate.Text).Date;
            DateTime? FitnessCertificateDate = string.IsNullOrEmpty(TB_FitnessCertificationDate.Text) ? (DateTime?)null : DateTime.Parse(TB_FitnessCertificationDate.Text).Date;
            DateTime? FitnessDueDate = string.IsNullOrEmpty(TB_FitnessDueDate.Text) ? (DateTime?)null : DateTime.Parse(TB_FitnessDueDate.Text).Date;
            string OperationalStatus = string.IsNullOrEmpty(DDL_Status.SelectedItem.Text) ? null : DDL_Status.Text;
            string MaterialDescription = string.IsNullOrEmpty(TB_Description.Text) ? null : TB_Description.Text;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "INSERT INTO MST_Material (MaterialNumber, MaterialType ,ModelNumber ,MaterialBrand ,FriendlyName ,SerialNumber ,ManufacturingOrMakeYear ,PrintedRate ," +
                                                       "PurchaseRate ,PurchaseDate ,PurchaseOrderNo,WarrantyEndDate ,EndOfLife ,MaterialClassification ,InstallationDate ,MaintenanceFrequency , ReorderLevel, " +
                                                       "ShelfLife, LastMaintenanceDate ,OpeningStockQuantity, UnitOfMeasure, CalibrationDate ,CalibrationTenure ,CalibrationDueDate ,FitnessCertificateDate ," +
                                                       "FitnessDueDate ,FitnessDocument ,OperationalStatus ,MaterialDescription) " +

                            "VALUES (@MaterialNumber, @MaterialType ,@ModelNumber ,@MaterialBrand, @FriendlyName , @SerialNumber , @ManufacturingOrMakeYear , @PrintedRate , @PurchaseRate ,@PurchaseDate ," + "@PurchaseOrderNo ," +
                                       "@WarrantyEndDate ,@EndOfLife ,@MaterialClassification ,@InstallationDate ,@MaintenanceFrequency , @ReorderLevel, @ShelfLife, @LastMaintenanceDate , @OpeningStockQuantity, @UnitOfMeasure," +
                                     "@CalibrationDate ,@CalibrationTenure , @CalibrationDueDate ,@FitnessCertificateDate ,@FitnessDueDate ,@FitnessDocument ,@OperationalStatus ,@MaterialDescription )";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {

                        // Add parameters
                        command.Parameters.AddWithValue("@MaterialNumber", (object)MaterialNumber ?? DBNull.Value);
                        command.Parameters.AddWithValue("@MaterialType", (object)MaterialType ?? DBNull.Value);
                        command.Parameters.AddWithValue("@ModelNumber", (object)ModelNumber ?? DBNull.Value);
                        command.Parameters.AddWithValue("@MaterialBrand", (object)MaterialBrand ?? DBNull.Value);
                        //command.Parameters.AddWithValue("@MaterialMechanicalName", (object)MaterialMechanicalName ?? DBNull.Value);
                        command.Parameters.AddWithValue("@FriendlyName", (object)FriendlyName ?? DBNull.Value);
                        command.Parameters.AddWithValue("@SerialNumber", (object)SerialNumber ?? DBNull.Value);
                        command.Parameters.AddWithValue("@ManufacturingOrMakeYear", (object)ManufacturingOrMakeYear ?? DBNull.Value);
                        command.Parameters.AddWithValue("@PrintedRate", (object)PrintedRate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@PurchaseRate", (object)PurchaseRate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@PurchaseDate", (object)PurchaseDate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@PurchaseOrderNo", (object)PurchaseOrderNo ?? DBNull.Value);
                        command.Parameters.AddWithValue("@WarrantyEndDate", (object)WarrantyEndDate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@EndOfLife", (object)EndOfLife ?? DBNull.Value);
                        command.Parameters.AddWithValue("@MaterialClassification", (object)MaterialClassification ?? DBNull.Value);
                        command.Parameters.AddWithValue("@InstallationDate", (object)InstallationDate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@MaintenanceFrequency", (object)MaintenanceFrequency ?? DBNull.Value);
                        command.Parameters.AddWithValue("@ReorderLevel", (object)ReorderLevel ?? DBNull.Value);
                        command.Parameters.AddWithValue("@ShelfLife", (object)ShelfLife ?? DBNull.Value);
                        command.Parameters.AddWithValue("@LastMaintenanceDate", (object)LastMaintenanceDate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@OpeningStockQuantity", (object)OpeningStockQuantity ?? DBNull.Value);
                        command.Parameters.AddWithValue("@UnitOfMeasure", (object)UnitOfMeasure ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CalibrationDate", (object)CalibrationDate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CalibrationTenure", (object)CalibrationTenure ?? DBNull.Value);
                        command.Parameters.AddWithValue("@CalibrationDueDate", (object)CalibrationDueDate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@FitnessCertificateDate", (object)FitnessCertificateDate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@FitnessDueDate", (object)FitnessDueDate ?? DBNull.Value);
                        command.Parameters.AddWithValue("@FitnessDocument", (object)ImgLink1 ?? DBNull.Value);
                        command.Parameters.AddWithValue("@OperationalStatus", (object)OperationalStatus ?? DBNull.Value);
                        command.Parameters.AddWithValue("@MaterialDescription", (object)MaterialDescription ?? DBNull.Value);

                        // Execute the query
                        command.ExecuteNonQuery();
                        MakeInputsReadOnly();
                    }
                    connection.Close();
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
        private void MakeInputsReadOnly()
        {
            DDL_MaterialType.Enabled = false;
            TB_ModelNo.ReadOnly = true;
            DDL_MaterialType.Enabled = true;
            TB_ModelNo.ReadOnly = true;
            TB_MaterialBrand.ReadOnly = true;
            //TB_MechName.ReadOnly = true;
            TB_FriendlyName.ReadOnly = true;
            TB_SerialNo.ReadOnly = true;
            TB_Mfg.ReadOnly = true;
            TB_PrintedRate.ReadOnly = true;
            TB_PurchaseRate.ReadOnly = true;
            TB_PurchaseDate.ReadOnly = true;
            TB_PurchaseOrderNo.ReadOnly = true;
            TB_WarrantyDate.ReadOnly = true;
            TB_EndLife.ReadOnly = true;
            DDL_Classification.Enabled = false;
            TB_Installation.ReadOnly = true;
            DDL_MaintenanceFrequency.Enabled = false;
            TB_LastMaintenance.ReadOnly = true;
            TB_CalibrationDate.ReadOnly = true;
            DDL_Tenure.Enabled = false;
            TB_DueDate.ReadOnly = true;
            TB_FitnessCertificationDate.ReadOnly = true;
            TB_FitnessDueDate.ReadOnly = true;
            DDL_Status.Enabled = false;
            TB_Description.ReadOnly = true;
            TB_ReoderLevel.ReadOnly = true;
            TB_ShelfLife.ReadOnly = true;

            BtnSubmit.Enabled = false;
            BtnSubmit.Text = "SAVED";
            BtnSubmit.CssClass = "btn btn-sm btn-success";

            string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Data Success',
                                text: 'Recorded Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                            setTimeout(function() {
                                window.location.href = 'Material_MasterView.aspx'; 
                            }, 3000); 
                        </script>";

            // RegisterStartupScript adds the JavaScript code to the page
            ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
        }
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("Material_Master.aspx");
        }

        private bool UploadImage1()
        {
            bool imgSaved = false;

            try
            {
                string TBPhotoId = "MaterialMaster";
                DateTime now = DateTime.Now;

                // Define the target folder path
                string targetFolderPath = Server.MapPath("~/UploadedFiles/MaterialMaster/FitnessDocumentImage/");

                // Check if the target folder exists, if not, create it
                if (!Directory.Exists(targetFolderPath))
                {
                    Directory.CreateDirectory(targetFolderPath);
                }

                // Check if a file is posted
                if (FU_FitnessDocImage.PostedFile != null)
                {
                    // Check the extension of the image
                    string extension = Path.GetExtension(FU_FitnessDocImage.FileName);
                    if (extension.ToLower() == ".png" || extension.ToLower() == ".jpg" || extension.ToLower() == ".jpeg")
                    {
                        // Get the uploaded image stream
                        Stream strm = FU_FitnessDocImage.PostedFile.InputStream;
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
                                ImgLink1 = "~/UploadedFiles/MaterialMaster/FitnessDocumentImage/" + fileName;
                                //imgfilename = fileName;

                                // Show the image instantly
                                FU_FitnessDocImage_img.Visible = true;
                                uploadedImage1.ImageUrl = ImgLink1;

                                // Image saved successfully
                                imgSaved = true;

                                FU_FitnessDocImage_Upldr.Visible = false;
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
                throw ex;
            }

            return imgSaved;
        }
        protected void BtnUploadFU_FitnessDocImage_Click(object sender, EventArgs e)
        {
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

        private string GenerateUniqueMno()
        {
            string newMnoValue;
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // Fetch the maximum value of MAT in the MST_Material table
                    string query = "SELECT ISNULL(MAX(CAST(SUBSTRING(MaterialNumber, 5, LEN(MaterialNumber) - 4) AS INT)), 0) FROM MST_Material";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        object result = command.ExecuteScalar();
                        int maxMATValue = Convert.ToInt32(result);

                        // Increment the numeric part
                        int numericPart = maxMATValue + 1;

                        // Format the new value with a hyphen and four digits (e.g., MAT-0001, MAT-0002)
                        newMnoValue = $"MAT-{numericPart:D4}";
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Console.WriteLine("Error generating MaterialNumber: " + ex.Message);
                throw;
            }

            MaterialNumber = newMnoValue;
            return newMnoValue;
        }

        private decimal? TryParseDecimal(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                // Return null if the input is null, empty, or consists only of whitespace
                return null;
            }

            decimal result;
            return decimal.TryParse(value, out result) ? (decimal?)result : null;
        }
        private int? TryParseInt(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                // Return null if the input is null, empty, or consists only of whitespace
                return null;
            }

            int result;
            return int.TryParse(value, out result) ? (int?)result : null;
        }

        private void SetControlsVisible(ControlCollection controls, bool visible)
        {
            foreach (Control ctrl in controls)
            {
                // Only hide/show divs that are not related to the Plant dropdown
                if (ctrl is HtmlGenericControl && (ctrl as HtmlGenericControl).TagName == "div")
                {
                    // Assuming you have named your divs properly or added IDs to them (e.g., divSupplierSection, divOtherSection, etc.)
                    if (ctrl.ID != "MaterialTypeDIV")
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

        private void DivBinders(string selectedMaterialValue)
        {
            string selectedMaterialType = DDL_MaterialType.SelectedItem.Text;

            SetControlsVisible(Page.Controls, false);
            FU_FitnessDocImage_Upldr.Visible = false;
            FU_FitnessDocImage_img.Visible = false;

            // Show relevant controls based on the selected material
            switch (selectedMaterialType)
            {
                case "Consumables":

                    //------for both type---------
                    //ModelNumber	
                    ModelDIV.Visible = true;

                    //MaterialBrand	
                    MaterialBrandDIV.Visible = true;

                    //FriendlyName	
                    FriendlyDIV.Visible = true;

                    //SerialNumber
                    SeriallDIV.Visible = true;

                    //ManufacturingOrMakeYear
                    MfgDIV.Visible = true;

                    //PrintedRate	
                    PrintedRateDIV.Visible = true;

                    //PurchaseOrderNo
                    PurchaseOrderDIV.Visible = true;

                    //PurchaseRate
                    PurchaseRateDIV.Visible = true;

                    //PurchaseDate
                    PurchaseDateDIV.Visible = true;

                    //MaterialClassification
                    ClassificationDIV.Visible = true;

                    //OperationalStatus	
                    StatusDIV.Visible = true;

                    //MaterialDescription
                    DescriptionDIV.Visible = true;

                    //OpeningStockQuantity	
                    QuantityDIV.Visible = true;

                    //UnitOfMeasure
                    UnitMeasureDIV.Visible = true;

                    //--------only for consumables------------
                    //EndOfLife	
                    EndLifeDIV.Visible = true;

                    //MaintenanceFrequency	
                    FrenquencyDIV.Visible = true;

                    //ReorderLevel
                    ReorderDIV.Visible = true;

                    //ShelfLife
                    ShelfLifeDIV.Visible = true;


                    break;

                case "Non-Consumables":

                    //------for both type---------
                    //ModelNumber	
                    ModelDIV.Visible = true;

                    //MaterialBrand	
                    MaterialBrandDIV.Visible = true;

                    //FriendlyName	
                    FriendlyDIV.Visible = true;

                    //SerialNumber
                    SeriallDIV.Visible = true;

                    //ManufacturingOrMakeYear
                    MfgDIV.Visible = true;

                    //PrintedRate	
                    PrintedRateDIV.Visible = true;

                    //PurchaseOrderNo
                    PurchaseOrderDIV.Visible = true;

                    //PurchaseRate
                    PurchaseRateDIV.Visible = true;

                    //PurchaseDate
                    PurchaseDateDIV.Visible = true;

                    //MaterialClassification
                    ClassificationDIV.Visible = true;

                    //OperationalStatus	
                    StatusDIV.Visible = true;

                    //MaterialDescription
                    DescriptionDIV.Visible = true;

                    //OpeningStockQuantity	
                    QuantityDIV.Visible = true;

                    //UnitOfMeasure
                    UnitMeasureDIV.Visible = true;

                    //-------only for non-consumables-------------
                    //WarrantyEndDate
                    WarrantyDateDIV.Visible = true;

                    //MaintenanceFrequency
                    FrenquencyDIV.Visible = true;

                    //InstallationDate
                    InstallationDIV.Visible = true;

                    //LastMaintenanceDate
                    MaintenanceDIV.Visible = true;

                    //CalibrationDate	
                    CalibrationDIV.Visible = true;

                    //CalibrationTenure	
                    TenureDIV.Visible = true;

                    //CalibrationDueDate	
                    DueDateDIV.Visible = true;

                    //FitnessCertificateDate
                    FitnessCertificateDIV.Visible = true;

                    //FitnessDueDate	
                    FitnessDueDateDIV.Visible = true;

                    //FitnessDocument
                    //FU_FitnessDocImage_Upldr.Visible = true;
                    //FU_FitnessDocImage_img.Visible = true;

                    break;

                default:
                    // Optionally handle a default case
                    break;
            }
        }

    }
}