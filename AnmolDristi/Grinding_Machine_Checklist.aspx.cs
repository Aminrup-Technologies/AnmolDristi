using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
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
            protected void RbForeHandle_CheckedChanged(object sender, EventArgs e)
            {
                pnlForeHandle.Visible = RbForeHandleNo.Checked;
            }

            // 2. Wheel Guard
            protected void RbWheelGuard_CheckedChanged(object sender, EventArgs e)
            {
                pnlWheelGuard.Visible = RbWheelGuardNo.Checked;
            }

            // 3. Grinding Wheel
            protected void RbGrindWheel_CheckedChanged(object sender, EventArgs e)
            {
                pnlGrindWheel.Visible = RbGrindWheelNo.Checked;
            }

            // 4. Rear Handle
            protected void RbRearHandle_CheckedChanged(object sender, EventArgs e)
            {
                pnlRearHandle.Visible = RbRearHandleNo.Checked;
            }

            // 5. Cord Strain Reliever
            protected void RbCord_CheckedChanged(object sender, EventArgs e)
            {
                pnlCord.Visible = RbCordNo.Checked;
            }

            // 6. Trigger Switch
            protected void RbTrigger_CheckedChanged(object sender, EventArgs e)
            {
                pnlTrigger.Visible = RbTriggerNo.Checked;
            }

            // 7. Switch Lock
            protected void RbSwitchLock_CheckedChanged(object sender, EventArgs e)
            {
                pnlSwitchLock.Visible = RbSwitchLockNo.Checked;
            }

            // 8. Power Cable
            protected void RbPowerCable_CheckedChanged(object sender, EventArgs e)
            {
                pnlPowerCable.Visible = RbPowerCableNo.Checked;
            }

        // Method to load incident details into GridView
        private void LoadGrindingMachineIncidentDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
SELECT 
    gh.HeaderID, gh.Site, gh.DateOfInspection, gh.InspectedBy, gh.SerialNo, 
    gh.IdentificationNumber, gh.Location,
    gc.Question AS ChecklistQuestion, gc.IsYes, gc.Remarks, gc.PhotoPath
FROM GrindingMachine_Header gh
LEFT JOIN GrindingMachine_Checklist gc ON gh.HeaderID = gc.HeaderID
ORDER BY gh.HeaderID DESC";  


                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                    }
                }
            }
        }


        protected void SubmitGrindingMachineIncidentData_Click(object sender, EventArgs e)
            {
                try
                {
                    SaveGrindingMachineIncidentData(); // Save form data
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Grinding Machine checklist saved successfully!";
                    BtnSubmit.Enabled = false;
                    BtnSubmit.Text = "Saved";
                    BtnSubmit.CssClass = "btn btn-success";

                    LoadGrindingMachineIncidentDetails(); // Refresh GridView
                }
                catch (Exception ex)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }

        private void SaveGrindingMachineIncidentData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            int headerId;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // Insert Header using stored procedure
                    using (SqlCommand cmdHeader = new SqlCommand("sp_InsertGrindingMachineHeader", conn, transaction))
                    {
                        cmdHeader.CommandType = CommandType.StoredProcedure;
                        cmdHeader.Parameters.AddWithValue("@Site", txtSite.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@DateOfInspection", txtDateOfInspection.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInspectedBy.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@SerialNo", txtSerialNo.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@IdentificationNumber", txtIdentificationNumber.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());

                        // Output parameter for HeaderID
                        SqlParameter outputParam = new SqlParameter("@HeaderID", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmdHeader.Parameters.Add(outputParam);

                        cmdHeader.ExecuteNonQuery();
                        headerId = (int)outputParam.Value;  // Get the generated HeaderID
                    }

                    // Save each checklist row
                    SaveChecklist("1. Fore handle without damage", RbForeHandleYes.Checked, txtForeHandleRemarks, fuForeHandle, conn, transaction, headerId);
                    SaveChecklist("2. Wheel guard (covered 3/4th area)", RbWheelGuardYes.Checked, txtWheelGuardRemarks, fuWheelGuard, conn, transaction, headerId);
                    SaveChecklist("3. Grinding wheel without any crack", RbGrindWheelYes.Checked, txtGrindWheelRemarks, fuGrindWheel, conn, transaction, headerId);
                    SaveChecklist("4. Rear handles without damage", RbRearHandleYes.Checked, txtRearHandleRemarks, fuRearHandle, conn, transaction, headerId);
                    SaveChecklist("5. Presence of cord strain reliever", RbCordYes.Checked, txtCordRemarks, fuCord, conn, transaction, headerId);
                    SaveChecklist("6. Trigger switch in working condition", RbTriggerYes.Checked, txtTriggerRemarks, fuTrigger, conn, transaction, headerId);
                    SaveChecklist("7. Presence of switch lock", RbSwitchLockYes.Checked, txtSwitchLockRemarks, fuSwitchLock, conn, transaction, headerId);
                    SaveChecklist("8. Power cable without cut", RbPowerCableYes.Checked, txtPowerCableRemarks, fuPowerCable, conn, transaction, headerId);

                    transaction.Commit();
                    lblMessage.Text = "Grinding machine checklist submitted successfully!";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        // Move the SaveChecklist method outside of the SaveGrindingMachineIncidentData method
        private void SaveChecklist(string question, bool isYes, TextBox remarksBox, FileUpload photoUpload, SqlConnection conn, SqlTransaction transaction, int headerId)
        {
            try
            {
                string remarks = remarksBox != null ? remarksBox.Text.Trim() : "";
                string photoPath = null;

                // Only upload photo if 'No' is selected
                if (!isYes && photoUpload.HasFile)
                {
                    string filename = Path.GetFileName(photoUpload.FileName);
                    string folderPath = Server.MapPath("~/Uploads/");
                    Directory.CreateDirectory(folderPath);
                    string fullPath = Path.Combine(folderPath, filename);
                    photoUpload.SaveAs(fullPath);
                    photoPath = "~/Uploads/" + filename; // Path stored in DB
                }

                using (SqlCommand cmdDetail = new SqlCommand("sp_InsertGrindingMachineChecklist", conn, transaction))
                {
                    cmdDetail.CommandType = CommandType.StoredProcedure;
                    cmdDetail.Parameters.AddWithValue("@HeaderID", headerId);  // Referencing HeaderID from table1
                    cmdDetail.Parameters.AddWithValue("@Question", question);  // Question text
                    cmdDetail.Parameters.AddWithValue("@IsYes", isYes);  // Yes/No checkbox result
                    cmdDetail.Parameters.AddWithValue("@Remarks", remarks);  // Remarks
                    cmdDetail.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);  // Photo path (nullable)

                    cmdDetail.ExecuteNonQuery();  // Execute stored procedure
                }
            }
            catch (Exception)
            {
                // Handle exception (optional)
            }
        }




        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                SaveGrindingMachineIncidentData(); // Save form data
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Grinding Machine checklist saved successfully!";
                BtnSubmit.Enabled = false;
                BtnSubmit.Text = "Saved";
                BtnSubmit.CssClass = "btn btn-success";

                LoadGrindingMachineIncidentDetails(); // Refresh GridView
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }



        protected void ValidateDateOfInspection(object source, ServerValidateEventArgs args)
        {
            DateTime inspectionDate;
            if (DateTime.TryParse(args.Value, out inspectionDate))
            {
                // Check if the selected date is in the future
                if (inspectionDate > DateTime.Now)
                {
                    args.IsValid = false; // Set to false if the date is in the future
                }
                else
                {
                    args.IsValid = true; // Set to true if the date is valid
                }
            }
            else
            {
                args.IsValid = false; // Set to false if the date is invalid
            }
        }


        protected void BtnReset_Click(object sender, EventArgs e)
            {
                txtSite.Text = "";
                txtDateOfInspection.Text = "";
                txtInspectedBy.Text = "";
                txtSerialNo.Text = "";
                txtIdentificationNumber.Text = "";
                txtLocation.Text = "";

                txtRemarks.Text = "";
                lblMessage.Text = "";
            }
        }
    }
