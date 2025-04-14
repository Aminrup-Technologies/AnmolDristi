using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Grinding_Machine_Checklist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set all Panels to invisible initially
                pnlForeHandle.Visible = false;
                pnlWheelGuard.Visible = false;
                pnlGrindWheel.Visible = false;
                pnlRearHandle.Visible = false;
                pnlCord.Visible = false;
                pnlTrigger.Visible = false;
                pnlSwitchLock.Visible = false;
                pnlPowerCable.Visible = false;
            }
        }

        // 1. Fore Handle
        protected void rbForeHandle_CheckedChanged(object sender, EventArgs e)
        {
            pnlForeHandle.Visible = rbForeHandleNo.Checked;
        }

        // 2. Wheel Guard
        protected void rbWheelGuard_CheckedChanged(object sender, EventArgs e)
        {
            pnlWheelGuard.Visible = rbWheelGuardNo.Checked;
        }

        // 3. Grinding Wheel
        protected void rbGrindWheel_CheckedChanged(object sender, EventArgs e)
        {
            pnlGrindWheel.Visible = rbGrindWheelNo.Checked;
        }

        // 4. Rear Handle
        protected void rbRearHandle_CheckedChanged(object sender, EventArgs e)
        {
            pnlRearHandle.Visible = rbRearHandleNo.Checked;
        }

        // 5. Cord Strain Reliever
        protected void rbCord_CheckedChanged(object sender, EventArgs e)
        {
            pnlCord.Visible = rbCordNo.Checked;
        }

        // 6. Trigger Switch
        protected void rbTrigger_CheckedChanged(object sender, EventArgs e)
        {
            pnlTrigger.Visible = rbTriggerNo.Checked;
        }

        // 7. Switch Lock
        protected void rbSwitchLock_CheckedChanged(object sender, EventArgs e)
        {
            pnlSwitchLock.Visible = rbSwitchLockNo.Checked;
        }

        // 8. Power Cable
        protected void rbPowerCable_CheckedChanged(object sender, EventArgs e)
        {
            pnlPowerCable.Visible = rbPowerCableNo.Checked;
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            
            string site = txtSite.Text.Trim();
            string dateOfInspection = txtDateOfInspection.Text.Trim();
            string inspectedBy = txtInspectedBy.Text.Trim();
            string serialNo = txtSerialNo.Text.Trim();
            string identificationNumber = txtIdentificationNumber.Text.Trim();
            string location = txtLocation.Text.Trim();
            string verifiedBy = txtVerifiedBy.Text.Trim();
            string remarks = txtRemarks.Text.Trim();


            lblMessage.Text = "Form submitted successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            txtSite.Text = "";
            txtDateOfInspection.Text = "";
            txtInspectedBy.Text = "";
            txtSerialNo.Text = "";
            txtIdentificationNumber.Text = "";
            txtLocation.Text = "";
            txtVerifiedBy.Text = "";
            txtRemarks.Text = "";
            lblMessage.Text = "";
        }


        protected void ValidateDateOfInspection(object source, ServerValidateEventArgs args)
        {
            DateTime selectedDate;
            bool isValidDate = DateTime.TryParse(txtDateOfInspection.Text, out selectedDate);

            if (isValidDate)
            {
                // Example: disallow future dates
                args.IsValid = selectedDate <= DateTime.Today;
            }
            else
            {
                args.IsValid = false;
            }
        }



    }
}