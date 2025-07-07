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
                // Set all Panels to visible so JavaScript toggle works properly
                pnlForeHandle.Visible = true;
                pnlWheelGuard.Visible = true;
                pnlGrindWheel.Visible = true;
                pnlRearHandle.Visible = true;
                pnlCord.Visible = true;
                pnlTrigger.Visible = true;
                pnlSwitchLock.Visible = true;
                pnlPowerCable.Visible = true;
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
    gh.IdentificationNumber, gh.Location,gh.Final_Remarks, gh.JobID, gh.JobName,
    gc.Question AS ChecklistQuestion, gc.IsYes, gc.Remarks, gc.PhotoPath, gc.EntryDate
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
        //private string GenerateCAPAID(SqlConnection conn, SqlTransaction transaction)
        //{
        //    string newID = "CAPA0001";
        //    string query = "SELECT MAX(CAPA_ID) FROM GrindingMachine_Checklist WHERE CAPA_ID IS NOT NULL";

        //    using (SqlCommand cmd = new SqlCommand(query, conn, transaction))
        //    {
        //        object result = cmd.ExecuteScalar();

        //        if (result != DBNull.Value && result != null)
        //        {
        //            string lastID = result.ToString(); // e.g., "CAPA0012"
        //            int num = int.Parse(lastID.Substring(4));
        //            newID = "CAPA" + (num + 1).ToString("D4");
        //        }
        //    }

        //    return newID;
        //}


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
        private string GenerateNewHeaderID()
        {
            string newID = "GM-001";
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT TOP 1 HeaderID FROM GrindingMachine_Header WHERE HeaderID LIKE 'GM%' ORDER BY HeaderID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        string lastID = result.ToString(); // e.g., GM005
                        int number = int.Parse(lastID.Substring(2)); // 5
                        newID = "GM-" + (number + 1).ToString("D3");   // GM006
                    }
                }
            }

            return newID;
        }

        private void SaveGrindingMachineIncidentData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string headerId = GenerateNewHeaderID(); // now string like GM001

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
                        cmdHeader.Parameters.AddWithValue("@HeaderID", headerId);
                        cmdHeader.Parameters.AddWithValue("@Site", txtSite.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@DateOfInspection", txtDateOfInspection.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInspectedBy.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@SerialNo", txtSerialNo.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@IdentificationNumber", txtIdentificationNumber.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@Location", txtLocation.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@Final_Remarks", txtFinalRemarks.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@JobID", txtJobID.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@JobName", txtJobName.Text.Trim());

                        cmdHeader.ExecuteNonQuery();
                    }

                    SaveChecklist("1. Fore handle without damage", RbForeHandleYes.Checked, txtForeHandleRemarks, fuForeHandle, conn, transaction, headerId, chkForeHandleCAPA);
                    SaveChecklist("2. Wheel guard (covered 3/4th area)", RbWheelGuardYes.Checked, txtWheelGuardRemarks, fuWheelGuard, conn, transaction, headerId, chkWheelGuardCAPA);
                    SaveChecklist("3. Grinding wheel without any crack", RbGrindWheelYes.Checked, txtGrindWheelRemarks, fuGrindWheel, conn, transaction, headerId, chkGrindWheelCAPA);
                    SaveChecklist("4. Rear handles without damage", RbRearHandleYes.Checked, txtRearHandleRemarks, fuRearHandle, conn, transaction, headerId, chkRearHandleCAPA);
                    SaveChecklist("5. Presence of cord strain reliever", RbCordYes.Checked, txtCordRemarks, fuCord, conn, transaction, headerId, chkCordCAPA);
                    SaveChecklist("6. Trigger switch in working condition", RbTriggerYes.Checked, txtTriggerRemarks, fuTrigger, conn, transaction, headerId, chkTriggerCAPA);
                    SaveChecklist("7. Presence of switch lock", RbSwitchLockYes.Checked, txtSwitchLockRemarks, fuSwitchLock, conn, transaction, headerId, chkSwitchLockCAPA);
                    SaveChecklist("8. Power cable without cut", RbPowerCableYes.Checked, txtPowerCableRemarks, fuPowerCable, conn, transaction, headerId, chkPowerCableCAPA);

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

        private void SaveChecklist(string question, bool isYes, TextBox remarksBox, FileUpload photoUpload,
           SqlConnection conn, SqlTransaction transaction, string headerId, CheckBox capaCheck)
        {
            string remarks = remarksBox?.Text.Trim();
            string photoPath = null;
            object capaId = DBNull.Value;

            try
            {
                // Upload photo only if needed
                if (photoUpload.HasFile)
                {
                    string filename = Path.GetFileName(photoUpload.FileName);
                    string folderPath = Server.MapPath("~/Uploads/");
                    Directory.CreateDirectory(folderPath);
                    string fullPath = Path.Combine(folderPath, filename);
                    photoUpload.SaveAs(fullPath);
                    photoPath = "~/Uploads/" + filename;
                }

                // Insert CAPA if required
                if (!isYes && capaCheck != null && capaCheck.Checked)
                {
                    SqlCommand cmdCAPA = new SqlCommand(@"
                INSERT INTO tbl_CAPAMaster 
                (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate)
                OUTPUT INSERTED.CAPAID
                VALUES 
                (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate)", conn, transaction);

                    cmdCAPA.Parameters.AddWithValue("@HeaderID", headerId);
                    cmdCAPA.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);
                    cmdCAPA.Parameters.AddWithValue("@Remarks", (object)remarks ?? DBNull.Value);
                    cmdCAPA.Parameters.AddWithValue("@AssignedBy", txtInspectedBy.Text.Trim());
                    cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                    capaId = cmdCAPA.ExecuteScalar(); // Get newly created CAPA ID
                }

                using (SqlCommand cmdDetail = new SqlCommand("sp_InsertGrindingMachineChecklist", conn, transaction))
                {
                    cmdDetail.CommandType = CommandType.StoredProcedure;
                    cmdDetail.Parameters.AddWithValue("@HeaderID", headerId);
                    cmdDetail.Parameters.AddWithValue("@Question", question);
                    cmdDetail.Parameters.AddWithValue("@IsYes", isYes);
                    cmdDetail.Parameters.AddWithValue("@Remarks", (object)remarks ?? DBNull.Value);
                    cmdDetail.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);
                    cmdDetail.Parameters.AddWithValue("@CAPA_ID", capaId);

                    cmdDetail.ExecuteNonQuery();
                }
            }
            catch (Exception exDetail)
            {
                lblMessage.Text += $"<br/>Checklist Insert Error for: {question} → {exDetail.Message}";
                throw;
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

                txtFinalRemarks.Text = "";

            txtJobID.Text = "";         
            txtJobName.Text = "";
            lblMessage.Text = "";
            }
        }
    }
