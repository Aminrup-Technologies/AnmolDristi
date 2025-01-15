using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Aata_Maida_Detailed : System.Web.UI.Page
    {
        public static string MaterialId = string.Empty;
        public static string MaterialName = string.Empty;
        public static string PlantId = string.Empty;
        public static string PlantName = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["DBID"] != null)
                {
                    string id = Request.QueryString["DBID"];

                    lbl_docname.Text = "QC - Atta/Refined Wheat Flour Report";
                    lbl_docnumber.Text = "ANMOL/DOC/CORP/QC/01-02";

                    MaterialBinder();
                    getDetails(id);
                }

                string source = Request.QueryString["source"];

                if (source == "submitter")
                {
                    BtnApprove.Visible = false;
                    BtnReject.Visible = false;
                    BtnBack.PostBackUrl = "~/Aata_Maida_Submitter.aspx";
                }
                else
                {
                    BtnBack.PostBackUrl = "~/Aata_Maida_Approval.aspx";
                }
            }
        }


        private void MaterialBinder()
        {
            string query = "SELECT Material_Id, Material_Name FROM RM_Material where Class = 6";
            string textField = "Material_Name";
            string valueField = "Material_Id";

            bool recordsBound;
            DatabaseHelper.BindDropDownList(query, DDL_Material, textField, valueField, out recordsBound);

            if (!recordsBound)
            {
                DatabaseHelper.BindWithDefaultNoRecords(DDL_Material);

                string MaterialBinder_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'An error occurred!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowRegionBinderErrorNotification", MaterialBinder_Error_script, false);
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

        void getDetails(string id)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                string query = @"
                    SELECT
	                P.MaterialName as MaterialId,
                    P.PlantName as PlantID,
	                M.Material_Name,
                    A.plant_name,
                    P.*
                FROM
                    TRN_Aata_Maida P
                LEFT JOIN dbo.RM_MATERIAL M ON P.MaterialName = M.Material_Id
                LEFT JOIN dbo.MST_PlantDetails A ON P.PlantName = A.plant_id
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

                                MaterialId = dt.Rows[0]["MaterialId"].ToString();
                                MaterialName = dt.Rows[0]["Material_Name"].ToString();
                                DDL_Material.SelectedItem.Text = MaterialName;
                                DDL_Material.Enabled = false;

                                PlantBinder();
                                PlantId = dt.Rows[0]["PlantId"].ToString();
                                PlantName = dt.Rows[0]["plant_name"].ToString();
                                DDL_Plant.SelectedValue = PlantId;
                                DDL_Plant.Enabled = false;

                                StandardValue_Binder(MaterialId, PlantId);

                                TB_Brand.Text = dt.Rows[0]["ProductBrand"].ToString();

                                TB_Quantity.Text = dt.Rows[0]["Quantity"].ToString();
                                TB_Supplier.Text = dt.Rows[0]["Supplier_Name"].ToString();

                                TB_Size.Text = dt.Rows[0]["Size"].ToString();

                                TB_ChallanNo.Text = dt.Rows[0]["Challan_No"].ToString();
                                TB_ChallanDate.Text = dt.Rows[0]["Challan_Date"].ToString();

                                TB_Mfg.Text = dt.Rows[0]["Mfg"].ToString();

                                TB_BatchNo.Text = dt.Rows[0]["BatchNo"].ToString();
                                TB_LotNo.Text = dt.Rows[0]["LotNo"].ToString();
                                TB_VehicleNo.Text = dt.Rows[0]["VehicleNo"].ToString();

                                RBL_ManufNameAdd.Text = dt.Rows[0]["MfgYesNo"].ToString();
                                //TXB_ManufNameAddRemarks.Text = dt.Rows[0]["MfgName"].ToString();

                                RBL_FassaiNoLogo.Text = dt.Rows[0]["fssaiYesNo"].ToString();
                                //TXB_FassaiNoLogoRemarks.Text = dt.Rows[0][""].ToString();

                                TB_MfgName.Text = dt.Rows[0]["MfgName"].ToString();

                                TB_BeforeDate.Text = dt.Rows[0]["BeforeDate"].ToString();

                                TB_FssaiNo.Text = dt.Rows[0]["FssaiNo"].ToString();

                                RBL_Fssai_Logo.Text = dt.Rows[0]["Fssai_Logo"].ToString();

                                RBL_Veg_Logo.Text = dt.Rows[0]["Veg_Logo"].ToString();

                                RBL_Packing_Condition.Text = dt.Rows[0]["Packing_Condition"].ToString();
                                TXB_PackingCondition_Remarks.Text = dt.Rows[0]["PackingCondition_Remarks"].ToString();

                                RBL_ColorApp.Text = dt.Rows[0]["ColorApp"].ToString();
                                TXB_ColorApp_Remarks.Text = dt.Rows[0]["ColorApp_Remarks"].ToString();

                                RBL_Odour.Text = dt.Rows[0]["Odour"].ToString();
                                TXB_Odour_Remarks.Text = dt.Rows[0]["Odour_Remarks"].ToString();

                                RBL_TasteFlavor.Text = dt.Rows[0]["TasteFlavor"].ToString();
                                TXB_TasteFlavor_Remarks.Text = dt.Rows[0]["TasteFlavor_Remarks"].ToString();

                                RBL_Impurities.Text = dt.Rows[0]["Impurities"].ToString();
                                TXB_Impurities_Remarks.Text = dt.Rows[0]["Impurities_Remarks"].ToString();

                                

                                TB_Moisture.Text = dt.Rows[0]["Moisture"].ToString();
                                TXB_Moisture_Remarks.Text = dt.Rows[0]["Moisture_Remarks"].ToString();

                                TB_TotalAsh.Text = dt.Rows[0]["TotalAsh"].ToString();
                                TXB_Ash_Remarks.Text = dt.Rows[0]["Ash_Remarks"].ToString();

                                TB_InsolubleAsh.Text = dt.Rows[0]["InsolubleAsh"].ToString();
                                TXB_InsolubleAsh_Remarks.Text = dt.Rows[0]["InsolubleAsh_Remarks"].ToString();

                                TB_GlutentContent.Text = dt.Rows[0]["GlutentContent"].ToString();
                                TXB_GlutentContent_Remarks.Text = dt.Rows[0]["GlutentContent_Remarks"].ToString();

                                TB_AlcoholicAcidity.Text = dt.Rows[0]["AlcoholicAcidity"].ToString();
                                TXB_AlcoholicAcidity_Remarks.Text = dt.Rows[0]["AlcoholicAcidity_Remarks"].ToString();

                                TB_Absorption.Text = dt.Rows[0]["Absorption"].ToString();
                                TXB_Absorption_Remarks.Text = dt.Rows[0]["Absorption_Remarks"].ToString();

                                TB_Sedimentation.Text = dt.Rows[0]["Sedimentation"].ToString();
                                TXB_Sedimentation_Remarks.Text = dt.Rows[0]["Sedimentation_Remarks"].ToString();

                                RBL_Grittiness.Text = dt.Rows[0]["Grittiness"].ToString();
                                TXB_Grittiness_Remarks.Text = dt.Rows[0]["Grittiness_Remarks"].ToString();

                                TB_Acidity.Text = dt.Rows[0]["Acidity"].ToString();
                                TXB_Acidity_Remarks.Text = dt.Rows[0]["Acidity_Remarks"].ToString();

                                TB_Granularity.Text = dt.Rows[0]["Granularity"].ToString();
                                TXB_Granularity_Remarks.Text = dt.Rows[0]["Granularity_Remarks"].ToString();

                                TB_GranularityRetention.Text = dt.Rows[0]["GranularityRetention"].ToString();
                                TXB_GranularityRetention_Remarks.Text = dt.Rows[0]["GranularityRetention_Remarks"].ToString();

                                TB_Retention.Text = dt.Rows[0]["Retention"].ToString();
                                TXB_Retention_Remarks.Text = dt.Rows[0]["Retention_Remarks"].ToString();

                                TB_Bromate.Text = dt.Rows[0]["Bromate"].ToString();

                                imgMaterial.ImageUrl = dt.Rows[0]["Material_Image"].ToString();

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


        public class ValidationCriteria
        {
            public string DisplayName { get; set; }
            public bool IsVisible { get; set; }
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


        private void StandardValue_Binder(string MaterialId, string PlantId)
        {
            //LoadApprovers(selectedPlantValue, "");
            DataTable dataTable = DatabaseHelper.GetBrandFieldsControlByMaterialIdAndPlantId(Convert.ToInt16(MaterialId), Convert.ToInt16(PlantId));


            // Example: Querying the DataTable for a specific field name
            //string fieldName = "no_of_pcs"; // Specify the field name you want to query
            //DataRow[] rows = dataTable.Select($"brand_id = {selectedProductBrandValue} AND field_name = '{fieldName}'");

            // Iterate through the filtered rows and extract validation criteria
            foreach (DataRow row in dataTable.Rows)
            {
                // Extract field name from the current row
                string fieldName = row["field_name"].ToString();
                string displayName = row["DisplayName"].ToString();

                // Extract validation criteria from the DataRow
                bool isVisible = Convert.ToBoolean(row["ViewMode"]);
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
                criteria.DisplayName = displayName;
                criteria.IsVisible = isVisible;
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
                SetUpValidatorsForField(fieldName, criteria);
            
        }
        }

        private void SetUpValidatorsForField(string fieldName, ValidationCriteria criteria)
        {
            switch (fieldName)
            {
                case "MoistureValue":

                    MoistureDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Moisture.Text = criteria.DisplayName;

                    RFV_TB_Moisture.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Moisture.Enabled = criteria.IsRequired;

                    TB_Moisture.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Moisture.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Moisture.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Moisture.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Moisture.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Moisture.Enabled = criteria.IsRangeRequired;

                    hdnMinMoistureValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxMoistureValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "TotalAshValue":

                    TotalAshDIV.Visible = criteria.IsVisible;
                    Lbl_TB_TotalAsh.Text = criteria.DisplayName;

                    RFV_TB_TotalAsh.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_TotalAsh.Enabled = criteria.IsRequired;

                    TB_TotalAsh.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_TotalAsh.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_TotalAsh.ValidationExpression = criteria.RegularExpression;
                    REV_TB_TotalAsh.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_TotalAsh.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_TotalAsh.Enabled = criteria.IsRangeRequired;

                    hdnMinTotalAshValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxTotalAshValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "InsolubleAshValue":

                    InsolubleAshDIV.Visible = criteria.IsVisible;
                    Lbl_TB_InsolubleAsh.Text = criteria.DisplayName;

                    RFV_TB_InsolubleAsh.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_InsolubleAsh.Enabled = criteria.IsRequired;

                    TB_InsolubleAsh.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_InsolubleAsh.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_InsolubleAsh.ValidationExpression = criteria.RegularExpression;
                    REV_TB_InsolubleAsh.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_InsolubleAsh.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_InsolubleAsh.Enabled = criteria.IsRangeRequired;

                    hdnMinInsolubleAshValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxInsolubleAshValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "GlutentContent":

                    GlutentContentDIV.Visible = criteria.IsVisible;
                    Lbl_TB_GlutentContent.Text = criteria.DisplayName;

                    RFV_TB_GlutentContent.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_GlutentContent.Enabled = criteria.IsRequired;

                    TB_GlutentContent.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_GlutentContent.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_GlutentContent.ValidationExpression = criteria.RegularExpression;
                    REV_TB_GlutentContent.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_GlutentContent.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_GlutentContent.Enabled = criteria.IsRangeRequired;

                    hdnMinGlutentContentValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxGlutentContentValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "AlcoholicAcidity":

                    AlcoholicAcidityDIV.Visible = criteria.IsVisible;
                    Lbl_TB_AlcoholicAcidity.Text = criteria.DisplayName;

                    RFV_TB_AlcoholicAcidity.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_AlcoholicAcidity.Enabled = criteria.IsRequired;

                    TB_AlcoholicAcidity.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_AlcoholicAcidity.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_AlcoholicAcidity.ValidationExpression = criteria.RegularExpression;
                    REV_TB_AlcoholicAcidity.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_AlcoholicAcidity.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_AlcoholicAcidity.Enabled = criteria.IsRangeRequired;

                    hdnMinAlcoholicAcidityValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxAlcoholicAcidityValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "Absorption":

                    AbsorptionDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Absorption.Text = criteria.DisplayName;

                    RFV_TB_Absorption.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Absorption.Enabled = criteria.IsRequired;

                    TB_Absorption.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Absorption.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Absorption.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Absorption.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Absorption.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Absorption.Enabled = criteria.IsRangeRequired;

                    hdnMinAbsorptionValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxAbsorptionValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "Sedimentation":

                    SedimentationDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Sedimentation.Text = criteria.DisplayName;

                    RFV_TB_Sedimentation.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Sedimentation.Enabled = criteria.IsRequired;

                    TB_Sedimentation.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Sedimentation.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Sedimentation.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Sedimentation.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Sedimentation.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Sedimentation.Enabled = criteria.IsRangeRequired;

                    hdnMinSedimentationValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxSedimentationValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "Acidity":

                    AcidityDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Acidity.Text = criteria.DisplayName;

                    RFV_TB_Acidity.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Acidity.Enabled = criteria.IsRequired;

                    TB_Acidity.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Acidity.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Acidity.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Acidity.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Acidity.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Acidity.Enabled = criteria.IsRangeRequired;

                    hdnMinAcidityValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxAcidityValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "Granularity":

                    GranularityDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Granularity.Text = criteria.DisplayName;

                    RFV_TB_Granularity.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Granularity.Enabled = criteria.IsRequired;

                    TB_Granularity.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Granularity.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Granularity.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Granularity.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Granularity.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Granularity.Enabled = criteria.IsRangeRequired;

                    hdnMinGranularityValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxGranularityValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "GranularityRetention":

                    GranularityRetentionDIV.Visible = criteria.IsVisible;
                    Lbl_TB_GranularityRetention.Text = criteria.DisplayName;

                    RFV_TB_GranularityRetention.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_GranularityRetention.Enabled = criteria.IsRequired;

                    TB_GranularityRetention.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_GranularityRetention.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_GranularityRetention.ValidationExpression = criteria.RegularExpression;
                    REV_TB_GranularityRetention.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_GranularityRetention.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_GranularityRetention.Enabled = criteria.IsRangeRequired;

                    hdnMinGranularityRetentionValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxGranularityRetentionValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "Retention":

                    RetentionDIV.Visible = criteria.IsVisible;
                    Lbl_TB_Retention.Text = criteria.DisplayName;

                    RFV_TB_Retention.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Retention.Enabled = criteria.IsRequired;

                    TB_Retention.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Retention.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Retention.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Retention.Enabled = criteria.IsRegularExpressionRequired;

                    CV_TB_Retention.ErrorMessage = criteria.RangeErrorMessage;
                    CV_TB_Retention.Enabled = criteria.IsRangeRequired;

                    hdnMinRetentionValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxRetentionValue.Value = criteria.MaximumValue.ToString();
                    break;

                case "Bromate":

                    BromateDIV.Visible = criteria.IsVisible;
                    Label_Bromate.Text = criteria.DisplayName;

                    RFV_TB_Bromate.ErrorMessage = criteria.RequiredFieldErrorMessage;
                    RFV_TB_Bromate.Enabled = criteria.IsRequired;

                    TB_Bromate.Attributes["placeholder"] = criteria.RangeErrorMessage;

                    REV_TB_Bromate.ErrorMessage = criteria.RegularExpressionErrorMessage;
                    REV_TB_Bromate.ValidationExpression = criteria.RegularExpression;
                    REV_TB_Bromate.Enabled = criteria.IsRegularExpressionRequired;

                    hdnMinBromateValue.Value = criteria.MinimumValue.ToString();
                    hdnMaxBromateValue.Value = criteria.MaximumValue.ToString();
                    break;

                default:
                    break;
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
