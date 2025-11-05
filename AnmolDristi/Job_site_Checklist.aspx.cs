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
using System.Drawing;
using System.Runtime.Remoting.Messaging;

namespace AnmolDristi
{
    public partial class Job_site_Checklist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
            }
        }
        private void LoadJobSiteChecklistDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = @"
        SELECT 
            h.HeaderID,
            h.ChecklistDate,
            h.Area,
            h.CreatedAt,
            d.ID AS DetailID,
            d.Question,
            d.IsYes,
            d.Remarks,
            d.PhotoPath,
            d.CreatedDate
        FROM CSMS.MahimaGupta_CSMS.JobSiteHeader h
        INNER JOIN CSMS.MahimaGupta_CSMS.JobSiteChecklistDetails d
            ON h.HeaderID = d.HeaderID
        ORDER BY h.HeaderID DESC, d.ID ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        //GridViewJobSiteChecklist.DataSource = dt;
                        //GridViewJobSiteChecklist.DataBind();
                    }
                }
            }
        }


        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                conn.Open();
                SqlTransaction tran = conn.BeginTransaction();
                string headerId;

                try
                {
                    // Step 1: Insert Header
                    using (SqlCommand cmd = new SqlCommand("MahimaGupta_CSMS.usp_InsertJobSiteHeader", conn, tran))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ChecklistDate", txtDate.Text.Trim());
                        cmd.Parameters.AddWithValue("@Area", txtArea.Text.Trim());

                        SqlParameter outParam = new SqlParameter("@HeaderID", SqlDbType.VarChar, 10)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outParam);

                        cmd.ExecuteNonQuery();
                        headerId = outParam.Value.ToString(); // Now it's a string like JSC-001
                    }

                    // Step 2: Insert Checklist Questions
                    SaveChecklist("Are the adequate safeguards at the point of operation / Job Execution?", rbMechGuardOk.Checked, txtMechGuardRemarks, fuMechGuard, conn, tran, headerId, chkMechGuardCAPA);
                    SaveChecklist("Are there any exposed moving parts (Chain, belts, gears, flywheels, etc.)?", rbExposedPartsOk.Checked, txtExposedPartsRemarks, fuExposedParts, conn, tran, headerId, chkExposedPartsCAPA);
                    SaveChecklist("Are there any other exposed mechanical parts that might be sharp or otherwise hazardous?", rbSharpPartsOk.Checked, txtSharpPartsRemarks, fuSharpParts, conn, tran, headerId, chkSharpPartsCAPA);
                    SaveChecklist("Is the machine properly anchored/fixed to the base as needed?", rbAnchoredOk.Checked, txtAnchoredRemarks, fuAnchored, conn, tran, headerId, chkAnchoredCAPA);

                    SaveChecklist("Is marking fix the prob on Machine/GB is available?", rbMarkingFixOk.Checked, txtMarkingFixRemarks, fuMarkingFix, conn, tran, headerId, chkMarkingFixCAPA);
                    SaveChecklist("Whether the marking visible to employees?", rbMarkingVisibleOk.Checked, txtMarkingVisibleRemarks, fuMarkingVisible, conn, tran, headerId, chkMarkingVisibleCAPA);
                    SaveChecklist("Whether those markings safe to take test?", rbMarkingSafeOk.Checked, txtMarkingSafeRemarks, fuMarkingSafe, conn, tran, headerId, chkMarkingSafeCAPA);
                    SaveChecklist("Guarding of rotating equipment adequate & safe during taking probe?", rbGuardingRotatingOk.Checked, txtGuardingRotatingRemarks, fuGuardingRotating, conn, tran, headerId, chkGuardingRotatingCAPA);
                    SaveChecklist("Position of workmen to take measurement is approachable & Safe?", rbWorkmenPositionOk.Checked, txtWorkmenPositionRemarks, fuWorkmenPosition, conn, tran, headerId, chkWorkmenPositionCAPA);
                    SaveChecklist("Is job executed by Contractor or TSK Employee safely?", rbExecutorOk.Checked, txtExecutorRemarks, fuExecutor, conn, tran, headerId, chkExecutorCAPA);
                    SaveChecklist("Are there other site hazards? (e.g. Hard to access, slippery surface)", rbOtherPointsOk.Checked, txtOtherPointsRemarks, fuOtherPoints, conn, tran, headerId, chkOtherPointsCAPA);

                    SaveChecklist("Is the machine grounded properly?", rbGroundedOk.Checked, txtGroundedRemarks, fuGrounded, conn, tran, headerId, chkGroundedCAPA);
                    SaveChecklist("Are there any shock hazards from open connections?", rbShockHazardOk.Checked, txtShockHazardRemarks, fuShockHazard, conn, tran, headerId, chkShockHazardCAPA);
                    SaveChecklist("Are any hazardous wires or other electrical components suitably labeled/Marked?", rbWiresLabeledOk.Checked, txtWiresLabeledRemarks, fuWiresLabeled, conn, tran, headerId, chkWiresLabeledCAPA);
                    SaveChecklist("Is the floor free of cords where workers need to move?", rbFloorCordFreeOk.Checked, txtFloorCordFreeRemarks, fuFloorCordFree, conn, tran, headerId, chkFloorCordFreeCAPA);

                    SaveChecklist("Is environment conducive to safe worker (temperature, humidity, radiation etc.)?", rbEnvSafeOk.Checked, txtEnvSafeRemarks, fuEnvSafe, conn, tran, headerId, chkEnvSafeCAPA);
                    SaveChecklist("Is lighting enough to operate the machine safely?", rbLightingOk.Checked, txtLightingRemarks, fuLighting, conn, tran, headerId, chkLightingCAPA);
                    SaveChecklist("Is the floor dry and safe for working?", rbFloorSafeOk.Checked, txtFloorSafeRemarks, fuFloorSafe, conn, tran, headerId, chkFloorSafeCAPA);

                    SaveChecklist("Is there master cut-offs to stop functioning of the machinery?", rbMasterCutoffOk.Checked, txtMasterCutoffRemarks, fuMasterCutoff, conn, tran, headerId, chkMasterCutoffCAPA);
                    SaveChecklist("Is starting and stopping control present and reachable?", rbStartStopOk.Checked, txtStartStopRemarks, fuStartStop, conn, tran, headerId, chkStartStopCAPA);
                    SaveChecklist("Is emergency response equipment available? What additional equipment is needed?", rbEmergencyEquipOk.Checked, txtEmergencyEquipRemarks, fuEmergencyEquip, conn, tran, headerId, chkEmergencyEquipCAPA);

                    SaveChecklist("Have all workers been trained for the job?", rbTrainingJobOk.Checked, txtTrainingJobRemarks, fuTrainingJob, conn, tran, headerId, chkTrainingJobCAPA);
                    SaveChecklist("Are workers trained on machine safety features?", rbTrainingFeaturesOk.Checked, txtTrainingFeaturesRemarks, fuTrainingFeatures, conn, tran, headerId, chkTrainingFeaturesCAPA);
                    SaveChecklist("Are workers trained on emergency response?", rbTrainingResponseOk.Checked, txtTrainingResponseRemarks, fuTrainingResponse, conn, tran, headerId, chkTrainingResponseCAPA);
                    SaveChecklist("Are all operating manuals/documentation/SOP in languages understood by workers?", rbTrainingManualsOk.Checked, txtTrainingManualsRemarks, fuTrainingManuals, conn, tran, headerId, chkTrainingManualsCAPA);


                    tran.Commit();
                    //  success
                    ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-success", @"
                        new PNotify({
                            title: 'Successful',
                            text: 'Checklist saved successfully.',
                            type: 'success',
                            styling: 'bootstrap3',
                            delay: 2500
                        });
                    ", true);
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-error", $@"
                            new PNotify({{
                                title: 'Failed',
                                text: 'Error: {ex.Message.Replace("'", " ")}',
                                type: 'error',
                                styling: 'bootstrap3',
                                delay: 3000
                            }});
                        ", true);
                }
            }
        }


        //    private void SaveChecklist(string question, bool isYes, TextBox remarksBox, FileUpload photoUpload,
        //SqlConnection conn, SqlTransaction transaction, int headerId, CheckBox capaCheck)
        //    {
        //        string remarks = remarksBox?.Text.Trim();
        //        string photoPath = null;
        //        string capaId = null;

        //        try
        //        {
        //            if (!isYes && photoUpload.HasFile)
        //            {
        //                string filename = Path.GetFileName(photoUpload.FileName);
        //                string folderPath = Server.MapPath("~/Uploads/");
        //                Directory.CreateDirectory(folderPath); // ensure the folder exists
        //                string fullPath = Path.Combine(folderPath, filename);
        //                photoUpload.SaveAs(fullPath);
        //                photoPath = "~/Uploads/" + filename;
        //            }

        //            // Generate CAPA_ID only if "Not Ok" and CAPA checkbox is checked
        //            //if (!isYes && capaCheck.Checked)
        //            //{
        //            //    capaId = GenerateCAPAID(conn, transaction); // your existing CAPA method
        //            //}

        //            using (SqlCommand cmd = new SqlCommand("MahimaGupta_CSMS.usp_InsertJobSiteChecklistDetail", conn, transaction))
        //            {
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                cmd.Parameters.AddWithValue("@HeaderID", headerId);
        //                cmd.Parameters.AddWithValue("@Question", question);
        //                cmd.Parameters.AddWithValue("@IsYes", isYes ? 1 : 0);
        //                cmd.Parameters.AddWithValue("@Remarks", (object)remarks ?? DBNull.Value);
        //                cmd.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);
        //                cmd.Parameters.AddWithValue("@CAPA_ID", (object)capaId ?? DBNull.Value);

        //                cmd.ExecuteNonQuery();
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            lblMessage.Text += $"<br/>Checklist Insert Error for: {question} → {ex.Message}";
        //            throw;
        //        }
        //    }
        private void SaveChecklist(string question, bool isYes, TextBox remarksBox, FileUpload photoUpload,
      SqlConnection conn, SqlTransaction transaction, string headerId, CheckBox capaCheck)
        {
            string remarks = remarksBox?.Text.Trim();
            string photoPath = null;
            object capaId = DBNull.Value;

            try
            {
                // Save photo if uploaded
                if (photoUpload.HasFile)
                {
                    string filename = Path.GetFileName(photoUpload.FileName);
                    string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/");
                    Directory.CreateDirectory(folderPath);
                    string fullPath = Path.Combine(folderPath, filename);
                    photoUpload.SaveAs(fullPath);
                    photoPath = "~/Uploads/" + filename;
                }

                // CAPA insert only when Not OK and checkbox checked
                if (!isYes && capaCheck != null && capaCheck.Checked)
                {
                    using (SqlCommand cmdCAPA = new SqlCommand(@"
                INSERT INTO tbl_CAPAMaster 
                (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate, Description, SourceTable)
                OUTPUT INSERTED.CAPAID
                VALUES 
                (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate, @Description)", conn, transaction))
                    {
                        cmdCAPA.Parameters.AddWithValue("@HeaderID", headerId);
                        cmdCAPA.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);
                        cmdCAPA.Parameters.AddWithValue("@Remarks", (object)remarks ?? DBNull.Value);
                        cmdCAPA.Parameters.AddWithValue("@AssignedBy", Session["UserName"] ?? "System"); 
                        cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                        cmdCAPA.Parameters.AddWithValue("@Description", question);
                        cmdCAPA.Parameters.AddWithValue("@SourceTable", "Job Site Checklist");

                        capaId = cmdCAPA.ExecuteScalar(); // Capture generated CAPAID
                    }
                }

                // Insert JobSite checklist detail
                using (SqlCommand cmd = new SqlCommand("MahimaGupta_CSMS.usp_InsertJobSiteChecklistDetail", conn, transaction))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@HeaderID", headerId); 
                    cmd.Parameters.AddWithValue("@Question", question);
                    cmd.Parameters.AddWithValue("@IsYes", isYes ? 1 : 0);
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



        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }


        protected void RbMechGuard_CheckedChanged(object sender, EventArgs e)
        {
            pnlMechGuard.Visible = rbMechGuardNotOk.Checked;
        }

        protected void RbExposedParts_CheckedChanged(object sender, EventArgs e)
        {
            pnlExposedParts.Visible = rbExposedPartsNotOk.Checked;
        }

        protected void RbSharpParts_CheckedChanged(object sender, EventArgs e)
        {
            pnlSharpParts.Visible = rbSharpPartsNotOk.Checked;
        }

        protected void RbAnchored_CheckedChanged(object sender, EventArgs e)
        {
            pnlAnchored.Visible = rbAnchoredNotOk.Checked;
        }

        //vibration

        protected void RbMarkingFix_CheckedChanged(object sender, EventArgs e)
        {
            pnlMarkingFix.Visible = rbMarkingFixNotOk.Checked;
        }

        protected void RbMarkingVisible_CheckedChanged(object sender, EventArgs e)
        {
            pnlMarkingVisible.Visible = rbMarkingVisibleNotOk.Checked;
        }

        protected void RbMarkingSafe_CheckedChanged(object sender, EventArgs e)
        {
            pnlMarkingSafe.Visible = rbMarkingSafeNotOk.Checked;
        }

        protected void RbGuardingRotating_CheckedChanged(object sender, EventArgs e)
        {
            pnlGuardingRotating.Visible = rbGuardingRotatingNotOk.Checked;
        }

        protected void RbWorkmenPosition_CheckedChanged(object sender, EventArgs e)
        {
            pnlWorkmenPosition.Visible = rbWorkmenPositionNotOk.Checked;
        }

        protected void RbExecutorOk_CheckedChanged(object sender, EventArgs e)
        {
            pnlExecutor.Visible = rbExecutorNotOk.Checked;
        }

        protected void RbOtherPointsOk_CheckedChanged(object sender, EventArgs e)
        {
            pnlOtherPoints.Visible = rbOtherPointsNotOk.Checked;
        }
        //electrical
        protected void RbGrounded_CheckedChanged(object sender, EventArgs e)
        {
            pnlGrounded.Visible = rbGroundedNotOk.Checked;
        }

        protected void RbShockHazard_CheckedChanged(object sender, EventArgs e)
        {
            pnlShockHazard.Visible = rbShockHazardNotOk.Checked;
        }

        protected void RbWiresLabeled_CheckedChanged(object sender, EventArgs e)
        {
            pnlWiresLabeled.Visible = rbWiresLabeledNotOk.Checked;
        }

        protected void RbFloorCordFree_CheckedChanged(object sender, EventArgs e)
        {
            pnlFloorCordFree.Visible = rbFloorCordFreeNotOk.Checked;
        }

        // ==================== OTHER HAZARDS ====================
        protected void RbEnvSafe_CheckedChanged(object sender, EventArgs e)
        {
            pnlEnvSafe.Visible = rbEnvSafeNotOk.Checked;
        }

        protected void RbLighting_CheckedChanged(object sender, EventArgs e)
        {
            pnlLighting.Visible = rbLightingNotOk.Checked;
        }


        protected void RbFloorSafe_CheckedChanged(object sender, EventArgs e)
        {
            pnlFloorSafe.Visible = rbFloorSafeNotOk.Checked;
        }

        // ==================== SAFEGUARDS ====================
        protected void RbMasterCutoff_CheckedChanged(object sender, EventArgs e)
        {
            pnlMasterCutoff.Visible = rbMasterCutoffNotOk.Checked;
        }

        protected void RbStartStop_CheckedChanged(object sender, EventArgs e)
        {
            pnlStartStop.Visible = rbStartStopNotOk.Checked;
        }

        protected void RbEmergencyEquip_CheckedChanged(object sender, EventArgs e)
        {
            pnlEmergencyEquip.Visible = rbEmergencyEquipNotOk.Checked;
        }

        // ==================== TRAINING ====================
        protected void RbTrainingJob_CheckedChanged(object sender, EventArgs e)
        {
            pnlTrainingJob.Visible = rbTrainingJobNotOk.Checked;
        }

        protected void RbTrainingFeatures_CheckedChanged(object sender, EventArgs e)
        {
            pnlTrainingFeatures.Visible = rbTrainingFeaturesNotOk.Checked;
        }

        protected void RbTrainingResponse_CheckedChanged(object sender, EventArgs e)
        {
            pnlTrainingResponse.Visible = rbTrainingResponseNotOk.Checked;
        }

        protected void RbTrainingManuals_CheckedChanged(object sender, EventArgs e)
        {
            pnlTrainingManuals.Visible = rbTrainingManualsNotOk.Checked;
        }

    }
};
