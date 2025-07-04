using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Security.Claims;

namespace AnmolDristi
{
    public partial class D_and_Bow_Shackles_Chain_Pulley_Checklist : System.Web.UI.Page
    {
protected void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack)
    {
        pnlTested.Visible = true;
        pnlThread.Visible = true;
        pnlRust.Visible = true;
        pnlWorn.Visible = true;
        pnlStrength.Visible = true;

        pnlChainTested.Visible = true;
        pnlChainDamage.Visible = true;
        pnlCondition.Visible = true;
        pnlLatch.Visible = true;
        pnlHookWear.Visible = true;

        LoadCombinedChecklistDetails();
    }
}


        private void LoadCombinedChecklistDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"

SELECT
    h.Id AS BasicID, h.Site, h.TagNo, h.InspectionDate, h.JobID,
    h.JobName,

    sd.Question AS ShacklesChecklistQuestion, 
    sd.IsYes AS ShacklesIsYes, 
    sd.Remarks AS ShacklesRemarks, 
    sd.PhotoPath AS ShacklesPhotoPath,

    cd.Question AS ChainPulleyChecklistQuestion,
    cd.IsYes AS ChainPulleyIsYes,
    cd.Remarks AS ChainPulleyRemarks,
    cd.PhotoPath AS ChainPulleyPhotoPath

FROM MahimaGupta_CSMS.ShacklesChecklist_BasicDetails h
LEFT JOIN MahimaGupta_CSMS.ShacklesChecklist_DBow sd ON h.Id = sd.HeaderID
LEFT JOIN MahimaGupta_CSMS.ShacklesChecklist_ChainPulley cd ON h.Id = cd.HeaderID

ORDER BY h.Id DESC";


                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Bind to a GridView or store for further use
                        // GridViewCombined.DataSource = dt;
                        // GridViewCombined.DataBind();
                    }
                }
            }
        }

        protected void RbTested_CheckedChanged(object sender, EventArgs e)
        {
            pnlTested.Visible = rbTestedNotOk.Checked;
        }

        protected void RbThread_CheckedChanged(object sender, EventArgs e)
        {
            pnlThread.Visible = rbThreadNotOk.Checked;
        }

        protected void RbRust_CheckedChanged(object sender, EventArgs e)
        {
            pnlRust.Visible = rbRustNotOk.Checked;
        }

        protected void RbWorn_CheckedChanged(object sender, EventArgs e)
        {
            pnlWorn.Visible = rbWornNotOk.Checked;
        }

        protected void RbStrength_CheckedChanged(object sender, EventArgs e)
        {
            pnlStrength.Visible = rbStrengthNotOk.Checked;
        }






        protected void RbChainTested_CheckedChanged(object sender, EventArgs e)
        {
            pnlChainTested.Visible = rbChainTestedNotOk.Checked;
        }

        protected void RbChainDamage_CheckedChanged(object sender, EventArgs e)
        {
            pnlChainDamage.Visible = rbChainDamageNotOk.Checked;
        }

        protected void RbCondition_CheckedChanged(object sender, EventArgs e)
        {
            pnlCondition.Visible = rbConditionNotOk.Checked;
        }

        protected void RbLatch_CheckedChanged(object sender, EventArgs e)
        {
            pnlLatch.Visible = rbLatchNotOk.Checked;
        }

        protected void RbPadeye_CheckedChanged(object sender, EventArgs e)
        {
            pnlPadeye.Visible = rbPadeyeNotOk.Checked;
        }

        protected void RbHookWear_CheckedChanged(object sender, EventArgs e)
        {
            pnlHookWear.Visible = rbHookWearNotOk.Checked;
        }



        //private int _lastCAPANumber = -1; // Initialized only once per request
        //private string GenerateNewCAPAID(SqlConnection con, SqlTransaction transaction)
        //{
        //    if (_lastCAPANumber == -1)
        //    {
        //        string query = @"
        //    SELECT MAX(CAPA_ID)
        //    FROM (
        //        SELECT CAPA_ID FROM MahimaGupta_CSMS.ShacklesChecklist_DBow WHERE CAPA_ID IS NOT NULL
        //        UNION
        //        SELECT CAPA_ID FROM MahimaGupta_CSMS.ShacklesChecklist_ChainPulley WHERE CAPA_ID IS NOT NULL
        //    ) AS CombinedCAPA";

        //        using (SqlCommand cmd = new SqlCommand(query, con, transaction))
        //        {
        //            object result = cmd.ExecuteScalar();
        //            if (result != DBNull.Value && result != null)
        //            {
        //                string lastID = result.ToString(); // e.g., "CAPA0005"
        //                _lastCAPANumber = int.Parse(lastID.Substring(4));
        //            }
        //            else
        //            {
        //                _lastCAPANumber = 0;
        //            }
        //        }
        //    }

        //    _lastCAPANumber++;
        //    return "CAPA" + _lastCAPANumber.ToString("D4"); // CAPA0006, CAPA0007, etc.
        //}








        private void SaveChecklistData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            int headerId;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlTransaction tran = conn.BeginTransaction();

                try
                {
                    // Insert Basic Details
                    using (SqlCommand cmd = new SqlCommand("MahimaGupta_CSMS.Insert_ShacklesChecklist_BasicDetails", conn, tran))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Site", txtSite.Text.Trim());
                        cmd.Parameters.AddWithValue("@TagNo", txtTagNo.Text.Trim());
                        cmd.Parameters.AddWithValue("@InspectionDate", txtDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
                        cmd.Parameters.AddWithValue("@JobID", txtJobID.Text.Trim()); 
                        cmd.Parameters.AddWithValue("@JobName", txtJobName.Text.Trim());

                        SqlParameter outParam = new SqlParameter("@BasicID", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outParam);

                        cmd.ExecuteNonQuery();
                        headerId = (int)outParam.Value;
                    }

                    // Insert Shackles Checklist Details (Table 2)
                    SaveChecklistDetail("D & Bow shackle tested or not, tag fixed or not", rbTestedOk.Checked, txtTestedRemarks, fuTested, conn, tran, headerId, "MahimaGupta_CSMS.Insert_ShacklesChecklist_DBow", chkTestedCAPA);
                    SaveChecklistDetail("Thread of the pin should not be damaged", rbThreadOk.Checked, txtThreadRemarks, fuThread, conn, tran, headerId, "MahimaGupta_CSMS.Insert_ShacklesChecklist_DBow", chkThreadCAPA);
                    SaveChecklistDetail("No part should be worn more than 10% of original dimension", rbWornOk.Checked, txtWornRemarks, fuWorn, conn, tran, headerId, "MahimaGupta_CSMS.Insert_ShacklesChecklist_DBow", chkWornCAPA);
                    SaveChecklistDetail("Strength of pin should be checked", rbStrengthOk.Checked, txtStrengthRemarks, fuStrength, conn, tran, headerId, "MahimaGupta_CSMS.Insert_ShacklesChecklist_DBow", chkStrengthCAPA);
                    SaveChecklistDetail("No rusting on body or pin", rbRustOk.Checked, txtRustRemarks, fuRust, conn, tran, headerId, "MahimaGupta_CSMS.Insert_ShacklesChecklist_DBow", chkRustCAPA);

                    // Insert Chain Pulley Block Checklist (Table 3)
                    SaveChecklistDetail("Chain block is tested or not, testing & due date of testing is ok or not", rbChainTestedOk.Checked, txtChainTestedRemarks, fuChainTested, conn, tran, headerId, "MahimaGupta_CSMS.Insert_ShacklesChecklist_ChainPulley", chkChainTestedCAPA);
                    SaveChecklistDetail("Any damaged chain links", rbChainDamageOk.Checked, txtChainDamageRemarks, fuChainDamage, conn, tran, headerId, "MahimaGupta_CSMS.Insert_ShacklesChecklist_ChainPulley", chkChainDamageCAPA);
                    SaveChecklistDetail("Chain & hook condition for any twist, wear, bend, corrosion & cracks", rbConditionOk.Checked, txtConditionRemarks, fuCondition, conn, tran, headerId, "MahimaGupta_CSMS.Insert_ShacklesChecklist_ChainPulley", chkConditionCAPA);
                    SaveChecklistDetail("Safety latch & latch spring available and functioning properly", rbLatchOk.Checked, txtLatchRemarks, fuLatch, conn, tran, headerId, "MahimaGupta_CSMS.Insert_ShacklesChecklist_ChainPulley", chkLatchCAPA);
                    SaveChecklistDetail("Check padeye/hook is standard & welded properly", rbPadeyeOk.Checked, txtPadeyeRemarks, fuPadeye, conn, tran, headerId, "MahimaGupta_CSMS.Insert_ShacklesChecklist_ChainPulley", chkPadeyeCAPA);
                    SaveChecklistDetail("Any part of hook should not be worn 10% of original dimension", rbHookWearOk.Checked, txtHookWearRemarks, fuHookWear, conn, tran, headerId, "MahimaGupta_CSMS.Insert_ShacklesChecklist_ChainPulley", chkHookWearCAPA);

                    tran.Commit();
                }
                catch
                {
                    tran.Rollback();
                    throw;
                }
            }
        }

        private void SaveChecklistDetail(string question, bool isYes, TextBox remarksBox, FileUpload uploadControl,
                                   SqlConnection conn, SqlTransaction tran, int headerId, string spName,
                                   CheckBox chkCAPA = null)
        {
            string remarks = remarksBox?.Text.Trim();
            string photoPath = null;
            object capaId = DBNull.Value;

            try
            {
                // Upload Photo
                if (uploadControl != null && uploadControl.HasFile)
                {
                    string filename = Path.GetFileName(uploadControl.FileName);
                    string folderPath = Server.MapPath("~/Uploads/");
                    Directory.CreateDirectory(folderPath);
                    string fullPath = Path.Combine(folderPath, filename);
                    uploadControl.SaveAs(fullPath);
                    photoPath = "~/Uploads/" + filename;
                }

                // Insert into CAPA master if required
                if (!isYes && chkCAPA != null && chkCAPA.Checked)
                {
                    using (SqlCommand cmdCAPA = new SqlCommand(@"
                INSERT INTO tbl_CAPAMaster 
                (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate)
                OUTPUT INSERTED.CAPAID
                VALUES 
                (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate)", conn, tran))
                    {
                        cmdCAPA.Parameters.AddWithValue("@HeaderID", headerId);
                        cmdCAPA.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);
                        cmdCAPA.Parameters.AddWithValue("@Remarks", (object)remarks ?? DBNull.Value);
                        cmdCAPA.Parameters.AddWithValue("@AssignedBy", txtSite.Text.Trim()); // ensure this control is available
                        cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                        capaId = cmdCAPA.ExecuteScalar(); // Get CAPA ID
                    }
                }

                // Insert into checklist table using passed SP
                using (SqlCommand cmd = new SqlCommand(spName, conn, tran))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@BasicId", headerId);
                    cmd.Parameters.AddWithValue("@Question", question);
                    cmd.Parameters.AddWithValue("@IsYes", isYes);
                    cmd.Parameters.AddWithValue("@Remarks", (object)remarks ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@CAPA_ID", capaId);

                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text += $"<br/>Checklist Insert Error for: {question} → {ex.Message}";
                throw;
            }
        }


        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                SaveChecklistData();
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Checklist saved successfully!";
                BtnSubmit.Enabled = false;
                BtnSubmit.Text = "Saved";
                BtnSubmit.CssClass = "btn btn-success";
                LoadCombinedChecklistDetails();
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }


        protected void BtnReset_Click(object sender, EventArgs e)
        {
            // Reset basic fields (update with your actual IDs if different)
            txtSite.Text = "";
            txtTagNo.Text = "";
            txtDate.Text = "";
            txtJobName.Text = "";
            txtJobID.Text = "";


            pnlTested.Visible = false;
            txtTestedRemarks.Text = "";

            pnlThread.Visible = false;
            txtThreadRemarks.Text = "";

            pnlWorn.Visible = false;
            txtWornRemarks.Text = "";

            pnlStrength.Visible = false;
            txtStrengthRemarks.Text = "";

            pnlRust.Visible = false;
            txtRustRemarks.Text = "";

            // Reset panels and remarks for Chain Pulley Block
            pnlChainTested.Visible = false;
            txtChainTestedRemarks.Text = "";

            pnlChainDamage.Visible = false;
            txtChainDamageRemarks.Text = "";

            pnlCondition.Visible = false;
            txtConditionRemarks.Text = "";

            pnlLatch.Visible = false;
            txtLatchRemarks.Text = "";

            pnlPadeye.Visible = false;
            txtPadeyeRemarks.Text = "";

            pnlHookWear.Visible = false;
            txtHookWearRemarks.Text = "";

            txtRemarks.Text = "";
        }

     





    }
}