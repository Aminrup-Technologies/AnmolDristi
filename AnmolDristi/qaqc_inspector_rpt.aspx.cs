using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi.qaqc
{
    public partial class qaqc_inspector_rpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbl_docname.Text = "QC - Inspector Report";
            lbl_docnumber.Text = "ANMOL/DOC/DAN/QA/02";

            NoOfPcs();
            GaugeValue();
            SetDryWeightValidators();
            SetDippedWeightValidators();
            SetVartyPktValidators();
            SetTextureBiteValidators();
            SetMoistureValidators();
            SetWeightWithOilValidators();
            SetWeightWithoutOilValidators();
            SetOilPercentageValidators();
            SetPacketWeightValidators();
        }


        private void NoOfPcs()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_NoOfPcs.ErrorMessage = "*";
            RFV_TB_NoOfPcs.InitialValue = "0";
            RFV_TB_NoOfPcs.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_NoOfPcs.ErrorMessage = "Numeric Only";
            REV_TB_NoOfPcs.ForeColor = System.Drawing.Color.Red;
            REV_TB_NoOfPcs.ValidationExpression = @"\d+"; // Regular expression for numeric input

            // Set properties of RangeValidator
            RV_TB_NoOfPcs.ErrorMessage = "[30 - 40]";
            RV_TB_NoOfPcs.ForeColor = System.Drawing.Color.Red;
            RV_TB_NoOfPcs.MinimumValue = "30";
            RV_TB_NoOfPcs.MaximumValue = "40";
        }

        private void GaugeValue()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_GaugeVal.ErrorMessage = "*";
            RFV_TB_GaugeVal.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_GaugeVal.ErrorMessage = "Decimal Only";
            REV_TB_GaugeVal.ForeColor = System.Drawing.Color.Red;
            REV_TB_GaugeVal.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_GaugeVal.ErrorMessage = "[10.00 - 100.00]";
            RV_TB_GaugeVal.ForeColor = System.Drawing.Color.Red;
            RV_TB_GaugeVal.MinimumValue = "10.00";
            RV_TB_GaugeVal.MaximumValue = "100.00";
        }

        private void SetDryWeightValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_DryWeight.ErrorMessage = "*";
            RFV_TB_DryWeight.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_DryWeight.ErrorMessage = "Decimal Only";
            REV_TB_DryWeight.ForeColor = System.Drawing.Color.Red;
            REV_TB_DryWeight.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_DryWeight.ErrorMessage = "[10.00 - 100.00]";
            RV_TB_DryWeight.ForeColor = System.Drawing.Color.Red;
            RV_TB_DryWeight.MinimumValue = "10.00";
            RV_TB_DryWeight.MaximumValue = "100.00";
        }

        private void SetDippedWeightValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_DippedWeight.ErrorMessage = "*";
            RFV_TB_DippedWeight.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_DippedWeight.ErrorMessage = "Decimal Only";
            REV_TB_DippedWeight.ForeColor = System.Drawing.Color.Red;
            REV_TB_DippedWeight.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_DippedWeight.ErrorMessage = "[0.00 - 1000.00]";
            RV_TB_DippedWeight.ForeColor = System.Drawing.Color.Red;
            RV_TB_DippedWeight.MinimumValue = "0.00";
            RV_TB_DippedWeight.MaximumValue = "1000.00";
        }


        private void SetVartyPktValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_VartyPkt.ErrorMessage = "*";
            RFV_TB_VartyPkt.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_VartyPkt.ErrorMessage = "Alphanumeric Only";
            REV_TB_VartyPkt.ForeColor = System.Drawing.Color.Red;
            REV_TB_VartyPkt.ValidationExpression = "^[a-zA-Z0-9]*$"; // Regular expression for alphanumeric input
        }


        private void SetTextureBiteValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_TextureBite.ErrorMessage = "*";
            RFV_TB_TextureBite.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_TextureBite.ErrorMessage = "Decimal Only";
            REV_TB_TextureBite.ForeColor = System.Drawing.Color.Red;
            REV_TB_TextureBite.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_TextureBite.ErrorMessage = "Texture bite should be between 0.00 and 10.00";
            RV_TB_TextureBite.ForeColor = System.Drawing.Color.Red;
            RV_TB_TextureBite.MinimumValue = "0.00";
            RV_TB_TextureBite.MaximumValue = "10.00";
        }

        private void SetMoistureValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_Moisture.ErrorMessage = "*";
            RFV_TB_Moisture.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_Moisture.ErrorMessage = "Decimal Only";
            REV_TB_Moisture.ForeColor = System.Drawing.Color.Red;
            REV_TB_Moisture.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_Moisture.ErrorMessage = "Moisture should be between 0.00% and 100.00%";
            RV_TB_Moisture.ForeColor = System.Drawing.Color.Red;
            RV_TB_Moisture.MinimumValue = "0.00";
            RV_TB_Moisture.MaximumValue = "100.00";
        }

        private void SetWeightWithOilValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_wgtwtoil.ErrorMessage = "*";
            RFV_TB_wgtwtoil.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_wgtwtoil.ErrorMessage = "Decimal Only";
            REV_TB_wgtwtoil.ForeColor = System.Drawing.Color.Red;
            REV_TB_wgtwtoil.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_wgtwtoil.ErrorMessage = "Weight with oil should be between 0.00 and 1000.00 kg";
            RV_TB_wgtwtoil.ForeColor = System.Drawing.Color.Red;
            RV_TB_wgtwtoil.MinimumValue = "0.00";
            RV_TB_wgtwtoil.MaximumValue = "1000.00";
        }

        private void SetWeightWithoutOilValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_wgtwoil.ErrorMessage = "*";
            RFV_TB_wgtwoil.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_wgtwoil.ErrorMessage = "Decimal Only";
            REV_TB_wgtwoil.ForeColor = System.Drawing.Color.Red;
            REV_TB_wgtwoil.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_wgtwoil.ErrorMessage = "Weight without oil should be between 0.00 and 1000.00 g";
            RV_TB_wgtwoil.ForeColor = System.Drawing.Color.Red;
            RV_TB_wgtwoil.MinimumValue = "0.00";
            RV_TB_wgtwoil.MaximumValue = "1000.00";
        }

        private void SetOilPercentageValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_oilpercent.ErrorMessage = "*";
            RFV_TB_oilpercent.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_oilpercent.ErrorMessage = "Decimal Only";
            REV_TB_oilpercent.ForeColor = System.Drawing.Color.Red;
            REV_TB_oilpercent.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_oilpercent.ErrorMessage = "Oil percentage should be between 0.00% and 100.00%";
            RV_TB_oilpercent.ForeColor = System.Drawing.Color.Red;
            RV_TB_oilpercent.MinimumValue = "0.00";
            RV_TB_oilpercent.MaximumValue = "100.00";
        }

        private void SetPacketWeightValidators()
        {
            // Set properties of RequiredFieldValidator
            RFV_TB_PktWgt.ErrorMessage = "*";
            RFV_TB_PktWgt.ForeColor = System.Drawing.Color.Red;

            // Set properties of RegularExpressionValidator
            REV_TB_PktWgt.ErrorMessage = "Decimal Only";
            REV_TB_PktWgt.ForeColor = System.Drawing.Color.Red;
            REV_TB_PktWgt.ValidationExpression = @"\d+(\.\d{1,2})?"; // Regular expression for decimal input

            // Set properties of RangeValidator
            RV_TB_PktWgt.ErrorMessage = "Packet weight should be between 0.00 and 1000.00 g";
            RV_TB_PktWgt.ForeColor = System.Drawing.Color.Red;
            RV_TB_PktWgt.MinimumValue = "0.00";
            RV_TB_PktWgt.MaximumValue = "1000.00";
        }

    }
}