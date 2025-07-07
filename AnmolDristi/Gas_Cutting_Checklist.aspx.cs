using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace AnmolDristi
{
    public partial class Gas_Cutting_Checklist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // All panels need to render for JS toggle to work
                pnlGasColor.Visible = true;
                pnlNRV.Visible = true;
                pnlISICylinder.Visible = true;
                pnlUpright.Visible = true;
                pnlTorchDamage.Visible = true;
                pnlFlashback.Visible = true;
                pnlLeak.Visible = true;
                pnlSegregation.Visible = true;
                pnlBarricade.Visible = true;
                pnlMoved.Visible = true;
                pnlFireExt.Visible = true;
                pnlSpark.Visible = true;
                pnlHose.Visible = true;
            }
        }




        protected void RbGasColor_CheckedChanged(object sender, EventArgs e)
        {
            pnlGasColor.Visible = RbGasColorNo.Checked;
        }

        protected void RbNRV_CheckedChanged(object sender, EventArgs e)
        {
            pnlNRV.Visible = RbNRVNo.Checked;
        }

        protected void RbISICylinder_CheckedChanged(object sender, EventArgs e)
        {
            pnlISICylinder.Visible = RbISICylinderNo.Checked;
        }
        protected void RbUpright_CheckedChanged(object sender, EventArgs e)
        {
            pnlUpright.Visible = RbUprightNo.Checked;
        }

        protected void RbTorchDamage_CheckedChanged(object sender, EventArgs e)
        {
            pnlTorchDamage.Visible = RbTorchDamageNo.Checked;
        }

        protected void RbFlashback_CheckedChanged(object sender, EventArgs e)
        {
            pnlFlashback.Visible = RbFlashbackNo.Checked;
        }

        protected void RbLeak_CheckedChanged(object sender, EventArgs e)
        {
            pnlLeak.Visible = RbLeakNo.Checked;
        }

        protected void RbSegregation_CheckedChanged(object sender, EventArgs e)
        {
            pnlSegregation.Visible = RbSegregationNo.Checked;
        }

        protected void RbBarricade_CheckedChanged(object sender, EventArgs e)
        {
            pnlBarricade.Visible = RbBarricadeNo.Checked;
        }

        protected void RbMoved_CheckedChanged(object sender, EventArgs e)
        {
            pnlMoved.Visible = RbMovedNo.Checked;
        }

        protected void RbFireExt_CheckedChanged(object sender, EventArgs e)
        {
            pnlFireExt.Visible = RbFireExtNo.Checked;
        }

        protected void RbSpark_CheckedChanged(object sender, EventArgs e)
        {
            pnlSpark.Visible = RbSparkNo.Checked;
        }

        protected void RbHose_CheckedChanged(object sender, EventArgs e)
        {
            pnlHose.Visible = RbHoseNo.Checked;
        }
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
           
            lblMessage.Text = "Form Submitted Successfully!";
        }
        private void LoadGasCuttingIncidentDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
SELECT 
    gh.HeaderID, gh.SiteName, gh.InspectionDate, gh.TagNo,gh.JobID,
    gh.GasCutterName,gh.SubmittedDate, gh.SubmittedTime,
    gc.Question AS ChecklistQuestion, gc.IsYes, gc.Remarks, gc.PhotoPath,  gc.FinalRemarks    
FROM GasCutting_Header gh
LEFT JOIN GasCutting_Checklist gc ON gh.HeaderID = gc.HeaderID
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
        //private int _lastCAPANumber = -1;

        //private string GenerateNewCAPAID(SqlConnection con, SqlTransaction transaction)
        //{
        //    if (_lastCAPANumber == -1)
        //    {
        //        string query = "SELECT MAX(CAPA_ID) FROM GasCutting_Checklist WHERE CAPA_ID IS NOT NULL";
        //        using (SqlCommand cmd = new SqlCommand(query, con, transaction))
        //        {
        //            object result = cmd.ExecuteScalar();
        //            if (result != DBNull.Value && result != null)
        //            {
        //                string lastID = result.ToString(); // e.g., "CAPA0012"
        //                _lastCAPANumber = int.Parse(lastID.Substring(4));
        //            }
        //            else
        //            {
        //                _lastCAPANumber = 0;
        //            }
        //        }
        //    }

        //    _lastCAPANumber++; // increment for next CAPA
        //    return "CAPA" + _lastCAPANumber.ToString("D4");
        //}



        protected void SubmitGasCuttingIncidentData_Click(object sender, EventArgs e)
        {
            try
            {
                SaveGasCuttingData(); // Save form data
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Gas Cutting checklist saved successfully!";
                BtnSubmit.Enabled = false;
                BtnSubmit.Text = "Saved";
                BtnSubmit.CssClass = "btn btn-success";

                LoadGasCuttingIncidentDetails(); // Refresh GridView
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }


        private string GenerateNewGasCuttingHeaderID()
        {
            string newID = "GS-001";
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT TOP 1 HeaderID FROM GasCutting_Header WHERE HeaderID LIKE 'GS-%' ORDER BY HeaderID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        string lastID = result.ToString();  // e.g., GS-005
                        int num = int.Parse(lastID.Substring(3));  // "005" -> 5
                        newID = "GS-" + (num + 1).ToString("D3");   // -> GS-006
                    }
                }
            }

            return newID;
        }

        private void SaveGasCuttingData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string headerId = GenerateNewGasCuttingHeaderID();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // Insert Header with custom HeaderID
                    using (SqlCommand cmdHeader = new SqlCommand("MahimaGupta_CSMS.sp_InsertGasCuttingHeader", conn, transaction))
                    {
                        cmdHeader.CommandType = CommandType.StoredProcedure;
                        cmdHeader.Parameters.AddWithValue("@HeaderID", headerId);
                        cmdHeader.Parameters.AddWithValue("@SiteName", txtNameOfSite.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@InspectionDate", Convert.ToDateTime(txtDate.Text.Trim()));
                        cmdHeader.Parameters.AddWithValue("@TagNo", txtTagNo.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@JobID", txtJobID.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@GasCutterName", txtGasCutterName.Text.Trim());

                        cmdHeader.ExecuteNonQuery();
                    }

                    // Insert checklist items
                    SaveChecklist("1. Gas Cylinders colour as per Colour Code", RbGasColorYes.Checked, txtGasColorRemarks, fuGasColor, conn, transaction, headerId, chkGasColorCAPA);
                    SaveChecklist("2. NRV/Flash back arrestor provided at regulator and torch side", RbNRVYes.Checked, txtNRVRemarks, fuNRV, conn, transaction, headerId, chkNRVCAPA);
                    SaveChecklist("3. ISI marked Cylinder, Valves & Expired value of Cylinder", RbISICylinderYes.Checked, txtISICylinderRemarks, fuISICylinder, conn, transaction, headerId, chkISICylinderCAPA);
                    SaveChecklist("4. Cylinder stored upright with cap", RbUprightYes.Checked, txtUprightRemarks, fuUpright, conn, transaction, headerId, chkUprightCAPA);
                    SaveChecklist("5. Cylinder and Torch free from damage", RbTorchDamageYes.Checked, txtTorchDamageRemarks, fuTorchDamage, conn, transaction, headerId, chkTorchDamageCAPA);
                    SaveChecklist("6. Flashback arrester checked and within validity", RbFlashbackYes.Checked, txtFlashbackRemarks, fuFlashback, conn, transaction, headerId, chkFlashbackCAPA);
                    SaveChecklist("7. No Gas leak from hose, connection or torch", RbLeakYes.Checked, txtLeakRemarks, fuLeak, conn, transaction, headerId, chkLeakCAPA);
                    SaveChecklist("8. Proper segregation of filled and empty cylinders", RbSegregationYes.Checked, txtSegregationRemarks, fuSegregation, conn, transaction, headerId, chkSegregationCAPA);
                    SaveChecklist("9. Welding area barricaded with fire resistant curtain", RbBarricadeYes.Checked, txtBarricadeRemarks, fuBarricade, conn, transaction, headerId, chkBarricadeCAPA);
                    SaveChecklist("10. Gas cutting cylinder moved only after closing valve and fixing valve cap", RbMovedYes.Checked, txtMovedRemarks, fuMoved, conn, transaction, headerId, chkMovedCAPA);
                    SaveChecklist("11. Fire extinguisher and sand bucket provided at site", RbFireExtYes.Checked, txtFireExtRemarks, fuFireExt, conn, transaction, headerId, chkFireExtCAPA);
                    SaveChecklist("12. Cylinder kept away from heat, fire or electrical spark", RbSparkYes.Checked, txtSparkRemarks, fuSpark, conn, transaction, headerId, chkSparkCAPA);
                    SaveChecklist("13. Hoses are in good condition without cracks or damage", RbHoseYes.Checked, txtHoseRemarks, fuHose, conn, transaction, headerId, chkHoseCAPA);

                    transaction.Commit();

                    // ✅ Set success message only after commit
                    lblMessage.Text = "Gas Cutting checklist submitted successfully!";
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

        private void SaveChecklist(string question, bool isYes, TextBox remarksBox, FileUpload uploadControl,
    SqlConnection conn, SqlTransaction transaction, string headerId, CheckBox capaCheck)
        {
            string remarks = remarksBox?.Text.Trim();
            string photoPath = null;
            object capaId = DBNull.Value;

            try
            {
                // Save photo if uploaded
                if (uploadControl != null && uploadControl.HasFile)
                {
                    string fileName = Path.GetFileName(uploadControl.FileName);
                    string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/");

                    Directory.CreateDirectory(folderPath);
                    string savedPath = Path.Combine(folderPath, fileName);
                    uploadControl.SaveAs(savedPath);

                    photoPath = "~/Uploads/" + fileName;
                }

                // Insert into CAPA Master only if Not OK and CAPA checkbox is checked
                if (!isYes && capaCheck != null && capaCheck.Checked)
                {
                    using (SqlCommand cmdCAPA = new SqlCommand(@"
                INSERT INTO tbl_CAPAMaster 
                (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate)
                OUTPUT INSERTED.CAPAID
                VALUES 
                (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate)", conn, transaction))
                    {
                        cmdCAPA.Parameters.AddWithValue("@HeaderID", headerId);
                        cmdCAPA.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);
                        cmdCAPA.Parameters.AddWithValue("@Remarks", (object)remarks ?? DBNull.Value);
                        cmdCAPA.Parameters.AddWithValue("@AssignedBy", txtGasCutterName.Text.Trim());  // You can change if needed
                        cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                        capaId = cmdCAPA.ExecuteScalar(); // Get new CAPAID
                    }
                }

                // Insert checklist detail
                using (SqlCommand cmdDetail = new SqlCommand("MahimaGupta_CSMS.sp_InsertGasCuttingChecklist", conn, transaction))
                {
                    cmdDetail.CommandType = CommandType.StoredProcedure;
                    cmdDetail.Parameters.AddWithValue("@HeaderID", headerId);
                    cmdDetail.Parameters.AddWithValue("@Question", question);
                    cmdDetail.Parameters.AddWithValue("@IsYes", isYes ? 1 : 0);
                    cmdDetail.Parameters.AddWithValue("@Remarks", (object)remarks ?? DBNull.Value);
                    cmdDetail.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);
                    cmdDetail.Parameters.AddWithValue("@FinalRemarks", txtFinalRemarks.Text.Trim());
                    cmdDetail.Parameters.AddWithValue("@CAPA_ID", capaId);

                    cmdDetail.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text += $"<br/>Checklist Insert Error for: {question} → {ex.Message}";
                throw;
            }
        }






        protected void BtnReset_Click(object sender, EventArgs e)
        {
           
            txtNameOfSite.Text = string.Empty;
            txtDate.Text = string.Empty;
            txtTagNo.Text = string.Empty;

            
        }



        protected void ValidateDate(object source, ServerValidateEventArgs args)
        {
            DateTime enteredDate;
            if (DateTime.TryParse(txtDate.Text, out enteredDate))
            {
                // Check if the date is not in the future
                args.IsValid = enteredDate <= DateTime.Today;
            }
            else
            {
                args.IsValid = false;
            }
        }




    }
}