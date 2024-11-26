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
using Newtonsoft.Json.Linq;
using System.IO;
using System.Windows;
using System.Xml.Linq;

namespace AnmolDristi
{
    public partial class Material_Master_DetailView : System.Web.UI.Page
    {
        public static string MaterialType = string.Empty;
        public static string MaterialClassification = string.Empty;
        public static string OperationalStatus = string.Empty;
        public static string MaintenanceFrequency = string.Empty;
        public static string UnitOfMeasure = string.Empty;
        public static string CalibrationTenure = string.Empty;
        public static string ImgLink1 = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["Id"] != null)
                {
                    string id = Request.QueryString["Id"];
                    hdf_id.Value = id;
                    DataBinder();
                    GetDetails(id);


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

        private void PopulateClassificationDropdown()
        {
            DDL_Classification.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_Classification.Items.Add(new ListItem("Departmental Usage", "Departmental Usage"));
            DDL_Classification.Items.Add(new ListItem("Functional Category", "Functional Category"));
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

        private void PopulateTenureDropdown()
        {
            DDL_Tenure.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_Tenure.Items.Add(new ListItem("3 months", "3"));
            DDL_Tenure.Items.Add(new ListItem("6 months", "6"));
            DDL_Tenure.Items.Add(new ListItem("12 months", "12"));
        }

        private void PopulateStatusDropdown()
        {
            DDL_Status.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_Status.Items.Add(new ListItem("Operational", "Operational"));
            DDL_Status.Items.Add(new ListItem("Obsolete", "Obsolete"));
        }

        private void PopulateUnitsDropdown()
        {
            DDL_UnitOfMeasure.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_UnitOfMeasure.Items.Add(new ListItem("Kg", "Kg"));
            DDL_UnitOfMeasure.Items.Add(new ListItem("Peices", "Peices"));
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

        private void DivBinders(string MaterialType)
        {
            SetControlsVisible(Page.Controls, false);
            FU_FitnessDocImage_img.Visible = false;

            // Show relevant controls based on the selected material
            switch (MaterialType)
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
                    //FU_FitnessDocImage_img.Visible = true;

                    break;

                default:
                    // Optionally handle a default case
                    break;
            }
        }

        void GetDetails(string id)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                string query = "Select * from MST_Material where Id = @Id";

                using (SqlConnection con = new SqlConnection(connectionString))
                {

                    Cancel.Visible = false;
                    ToggleFields(this, false);
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

                                MaterialType = dt.Rows[0]["MaterialType"].ToString();
                                DDL_MaterialType.SelectedValue = MaterialType;
                                DivBinders(MaterialType);

                                MaterialClassification = dt.Rows[0]["MaterialClassification"].ToString();
                                DDL_Classification.SelectedValue = MaterialClassification;

                                OperationalStatus = dt.Rows[0]["OperationalStatus"].ToString();
                                DDL_Status.SelectedValue = OperationalStatus;

                                MaintenanceFrequency = dt.Rows[0]["MaintenanceFrequency"].ToString();
                                DDL_MaintenanceFrequency.SelectedValue= MaintenanceFrequency;

                                UnitOfMeasure = dt.Rows[0]["UnitOfMeasure"].ToString();
                                DDL_UnitOfMeasure.SelectedValue = UnitOfMeasure;
                                //DDL_UnitOfMeasure.SelectedItem.Text = UnitOfMeasure;

                                CalibrationTenure = dt.Rows[0]["CalibrationTenure"].ToString();
                                //DDL_Tenure.SelectedItem.Text = CalibrationTenure;
                                DDL_Tenure.SelectedValue = CalibrationTenure;

                                TB_ModelNo.Text = dt.Rows[0]["ModelNumber"].ToString();

                                TB_MaterialBrand.Text = dt.Rows[0]["MaterialBrand"].ToString();

                                TB_FriendlyName.Text = dt.Rows[0]["FriendlyName"].ToString();

                                TB_SerialNo.Text = dt.Rows[0]["SerialNumber"].ToString();

                                TB_Mfg.Text = dt.Rows[0]["ManufacturingOrMakeYear"].ToString();

                                TB_PrintedRate.Text = dt.Rows[0]["PrintedRate"].ToString();

                                TB_PurchaseRate.Text = dt.Rows[0]["PurchaseRate"].ToString();

                                TB_PurchaseOrderNo.Text = dt.Rows[0]["PurchaseOrderNo"].ToString();

                                TB_Description.Text = dt.Rows[0]["MaterialDescription"].ToString();

                                TB_ReoderLevel.Text = dt.Rows[0]["ReorderLevel"].ToString();

                                TB_OpeningStockQuantity.Text = dt.Rows[0]["OpeningStockQuantity"].ToString();

                                imgFitnessDocument.ImageUrl = dt.Rows[0]["FitnessDocument"].ToString();

                                string PurchaseDate = dt.Rows[0]["PurchaseDate"].ToString();
                                if (!string.IsNullOrEmpty(PurchaseDate))
                                {
                                    DateTime _PurchaseDate = DateTime.ParseExact(PurchaseDate, "dd-MM-yyyy hh:mm:ss tt", null);
                                    TB_PurchaseDate.Text = _PurchaseDate.ToString("yyyy-MM-dd");
                                }
                                else {
                                    TB_PurchaseDate.Text = string.Empty;
                                }


                                string WarrantyDate = dt.Rows[0]["WarrantyEndDate"].ToString();
                                if (!string.IsNullOrEmpty(WarrantyDate))
                                {
                                    DateTime _WarrantyDate = DateTime.ParseExact(WarrantyDate, "dd-MM-yyyy hh:mm:ss tt", null);
                                    TB_WarrantyDate.Text = _WarrantyDate.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    TB_WarrantyDate.Text = string.Empty;
                                }


                                string EndLife = dt.Rows[0]["EndOfLife"].ToString();
                                if (!string.IsNullOrEmpty(EndLife))
                                {
                                    DateTime _EndLife = DateTime.ParseExact(EndLife, "dd-MM-yyyy hh:mm:ss tt", null);
                                    TB_EndLife.Text = _EndLife.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    TB_EndLife.Text = string.Empty;
                                }

                                string Installation = dt.Rows[0]["InstallationDate"].ToString();
                                if (!string.IsNullOrEmpty(Installation))
                                {
                                    DateTime _Installation = DateTime.ParseExact(Installation, "dd-MM-yyyy hh:mm:ss tt", null);
                                    TB_Installation.Text = _Installation.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    TB_Installation.Text = string.Empty;
                                }


                                string LastMaintenance = dt.Rows[0]["LastMaintenanceDate"].ToString();
                                if (!string.IsNullOrEmpty(LastMaintenance))
                                {
                                    DateTime _LastMaintenance = DateTime.ParseExact(LastMaintenance, "dd-MM-yyyy hh:mm:ss tt", null);
                                    TB_LastMaintenance.Text = _LastMaintenance.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    TB_LastMaintenance.Text = string.Empty;
                                }

                                string CalibrationDate = dt.Rows[0]["CalibrationDate"].ToString();
                                if (!string.IsNullOrEmpty(CalibrationDate))
                                {
                                    DateTime _CalibrationDate = DateTime.ParseExact(CalibrationDate, "dd-MM-yyyy hh:mm:ss tt", null);
                                    TB_CalibrationDate.Text = _CalibrationDate.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    TB_CalibrationDate.Text = string.Empty;
                                }

                                string DueDate = dt.Rows[0]["CalibrationDueDate"].ToString();
                                if (!string.IsNullOrEmpty(DueDate))
                                {
                                    DateTime _DueDate = DateTime.ParseExact(DueDate, "dd-MM-yyyy hh:mm:ss tt", null);
                                    TB_DueDate.Text = _DueDate.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    TB_DueDate.Text = string.Empty;
                                }

                                string FitnessCertificationDate = dt.Rows[0]["FitnessCertificateDate"].ToString();
                                if (!string.IsNullOrEmpty(FitnessCertificationDate))
                                {
                                    DateTime _FitnessCertificationDate = DateTime.ParseExact(FitnessCertificationDate, "dd-MM-yyyy hh:mm:ss tt", null);
                                    TB_FitnessCertificationDate.Text = _FitnessCertificationDate.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    TB_FitnessCertificationDate.Text = string.Empty;
                                }

                                string FitnessDueDate = dt.Rows[0]["FitnessDueDate"].ToString();
                                if (!string.IsNullOrEmpty(FitnessDueDate))
                                {
                                    DateTime _FitnessDueDate = DateTime.ParseExact(FitnessDueDate, "dd-MM-yyyy hh:mm:ss tt", null);
                                    TB_FitnessDueDate.Text = _FitnessDueDate.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    TB_FitnessDueDate.Text = string.Empty;
                                }


                                string ShelfLife = dt.Rows[0]["ShelfLife"].ToString();
                                if (!string.IsNullOrEmpty(ShelfLife))
                                {
                                    DateTime _ShelfLife = DateTime.ParseExact(ShelfLife, "dd-MM-yyyy hh:mm:ss tt", null);
                                    TB_ShelfLife.Text = _ShelfLife.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    TB_ShelfLife.Text = string.Empty;
                                }
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

        protected void Back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Material_MasterView.aspx");
        }

        protected void Cancel_Click(object sender, EventArgs e)
        {
            SetViewMode();
            //FU_FitnessDocImage_Upldr.Visible = false;
            LoadDefaults();
        }

        protected void Update_Click(object sender, EventArgs e)
        {
            if (Update.Text == "Update")
            {
                SetEditMode();
            }
            else if (Update.Text == "Save")
            {
                SaveData();
                SetViewMode();
            }
        }


        private void SetViewMode()
        {
            // Set to view mode: fields read-only, show "Update" and "Back"
            ToggleFields(this, false);
            Update.Text = "Update";
            Update.Visible = true;
            Back.Visible = true;
            Cancel.Visible = false;
        }

        private void SetEditMode()
        {
            // Set to edit mode: fields editable, show "Save" and "Cancel"
            ToggleFields(this, true);
            Update.Text = "Save";
            Back.Visible = false;
            Cancel.Visible = true;
            DDL_MaterialType.SelectedItem.Text = MaterialType;
            //if (MaterialType == "Non-Consumables")
            //{
            //    FU_FitnessDocImage_Upldr.Visible = true; // only for non consumables image required
            //}
            //else
            //{
            //    FU_FitnessDocImage_Upldr.Visible = false; //  for  consumables image not required
            //}
            //DDL_Tenure_SelectedIndexChanged(this, EventArgs.Empty);
        }
        
        private void ToggleFields(Control parent, bool isEnabled)
        {
            foreach (Control control in parent.Controls)
            {
                if (control is TextBox)
                {
                    TextBox txt = (TextBox)control;
                    txt.ReadOnly = !isEnabled;
                    if (txt.TextMode == TextBoxMode.Date)
                    {
                        txt.Enabled = isEnabled;  // Enable or disable the date picker for Date TextBox
                    }
                }
                else if (control is DropDownList)
                {
                    DropDownList ddl = (DropDownList)control;

                    if (ddl.ID == "DDL_MaterialType")
                    {
                        // Keep MaterialType dropdown disabled regardless of mode
                        ddl.Enabled = false;
                    }
                    else
                    {
                        // Enable or disable other dropdowns based on isEnabled
                        ddl.Enabled = isEnabled;

                        // Retain the selected value after enabling/disabling                    
                        string selectedValue = ddl.SelectedItem.Text;
                        ddl.SelectedItem.Text = selectedValue;

                    }
                }

                else if (control is FileUpload)
                {
                    FileUpload fileUpload = (FileUpload)control;
                    fileUpload.Enabled = isEnabled;

                }
                else if (control is Image)
                {
                    Image img = (Image)control;
                    img.Visible = true;

                }


                // Check if the control contains other child controls (like panels or placeholders)
                if (control.HasControls())
                {
                    ToggleFields(control, isEnabled); // Recursive call for child controls
                }
            }
        }


        private void SaveData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            //string MaterialNumber = GenerateUniqueMno();
            //string MaterialType = DDL_MaterialType.SelectedItem.Text;
            string ModelNumber = string.IsNullOrEmpty(TB_ModelNo.Text) ? null : TB_ModelNo.Text;
            string MaterialBrand = string.IsNullOrEmpty(TB_MaterialBrand.Text) ? null : TB_MaterialBrand.Text;
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
                    string query = "UPDATE MST_Material SET MaterialType = @MaterialType, ModelNumber = @ModelNumber, MaterialBrand = @MaterialBrand, FriendlyName = @FriendlyName, SerialNumber = @SerialNumber," +
                                                         "ManufacturingOrMakeYear = @ManufacturingOrMakeYear, PrintedRate = @PrintedRate, PurchaseRate = @PurchaseRate, PurchaseDate = @PurchaseDate, PurchaseOrderNo = @PurchaseOrderNo," +
                                                         " WarrantyEndDate = @WarrantyEndDate, EndOfLife = @EndOfLife, MaterialClassification = @MaterialClassification, InstallationDate = @InstallationDate, " +
                                                         "MaintenanceFrequency = @MaintenanceFrequency, ReorderLevel = @ReorderLevel, ShelfLife = @ShelfLife, LastMaintenanceDate = @LastMaintenanceDate, " +
                                                         "OpeningStockQuantity = @OpeningStockQuantity, UnitOfMeasure = @UnitOfMeasure, CalibrationDate = @CalibrationDate, CalibrationTenure = @CalibrationTenure, " +
                                                         "CalibrationDueDate = @CalibrationDueDate, FitnessCertificateDate = @FitnessCertificateDate, FitnessDueDate = @FitnessDueDate, OperationalStatus = @OperationalStatus " +
                                          "WHERE Id = @Id";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {

                        // Add parameters
                        //command.Parameters.AddWithValue("@MaterialNumber", (object)MaterialNumber ?? DBNull.Value);
                        command.Parameters.AddWithValue("@MaterialType", (object)MaterialType ?? DBNull.Value);
                        command.Parameters.AddWithValue("@ModelNumber", (object)ModelNumber ?? DBNull.Value);
                        command.Parameters.AddWithValue("@MaterialBrand", (object)MaterialBrand ?? DBNull.Value);
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

                        command.Parameters.AddWithValue("@Id", Request.QueryString["Id"]);

                        // Execute the query
                        command.ExecuteNonQuery();

                        //Update.Enabled = false;
                        //Update.Text = "SAVED";
                        Update.CssClass = "btn btn-sm btn-warning";

                        string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Data Updated Success',
                                text: 'Recorded Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

                        // RegisterStartupScript adds the JavaScript code to the page
                        ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
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

        protected void DDL_Tenure_SelectedIndexChanged(object sender, EventArgs e)
        {
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

        private void LoadDefaults()
        {
            string Id = hdf_id.Value;
            GetDetails(Id);
        }

        
    }
}

