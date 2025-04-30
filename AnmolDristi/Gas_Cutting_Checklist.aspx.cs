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
                // Set all Panels to invisible initially
                pnlGasColor.Visible = false;
                pnlNRV.Visible = false;
                pnlISICylinder.Visible = false;
                pnlUpright.Visible = false;
                pnlTorchDamage.Visible = false;
                pnlFlashback.Visible = false;
                pnlLeak.Visible = false;
                pnlSegregation.Visible = false;
                pnlBarricade.Visible = false;
                pnlMoved.Visible = false;
                pnlFireExt.Visible = false;
                pnlSpark.Visible = false;
                pnlHose.Visible = false;
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
    gh.HeaderID, gh.SiteName, gh.InspectionDate, gh.TagNo,
    gc.Question AS ChecklistQuestion, gc.IsYes, gc.Remarks, gc.PhotoPath
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



        private void SaveGasCuttingData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            int headerId;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // Insert Header
                    using (SqlCommand cmdHeader = new SqlCommand("sp_InsertGasCuttingHeader", conn, transaction))
                    {
                        cmdHeader.CommandType = CommandType.StoredProcedure;
                        cmdHeader.Parameters.AddWithValue("@SiteName", txtNameOfSite.Text.Trim());
                        cmdHeader.Parameters.AddWithValue("@InspectionDate", Convert.ToDateTime(txtDate.Text.Trim()));
                        cmdHeader.Parameters.AddWithValue("@TagNo", txtTagNo.Text.Trim());

                        SqlParameter outputParam = new SqlParameter("@HeaderID", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmdHeader.Parameters.Add(outputParam);

                        cmdHeader.ExecuteNonQuery();
                        headerId = (int)outputParam.Value;
                    }

                    // Insert checklist items
                    // Insert checklist items
                    SaveChecklist("1. Gas Cylinders colour as per Colour Code", RbGasColorYes.Checked, txtGasColorRemarks, fuGasColor, conn, transaction, headerId);
                    SaveChecklist("2. NRV/Flash back arrestor provided at regulator and torch side", RbNRVYes.Checked, txtNRVRemarks, fuNRV, conn, transaction, headerId);
                    SaveChecklist("3. ISI marked Cylinder, Valves & Expired value of Cylinder", RbISICylinderYes.Checked, txtISICylinderRemarks, fuISICylinder, conn, transaction, headerId);
                    SaveChecklist("4. Cylinder stored upright with cap", RbUprightYes.Checked, txtUprightRemarks, fuUpright, conn, transaction, headerId);
                    SaveChecklist("5. Cylinder and Torch free from damage", RbTorchDamageYes.Checked, txtTorchDamageRemarks, fuTorchDamage, conn, transaction, headerId);
                    SaveChecklist("6. Flashback arrester checked and within validity", RbFlashbackYes.Checked, txtFlashbackRemarks, fuFlashback, conn, transaction, headerId);
                    SaveChecklist("7. No Gas leak from hose, connection or torch", RbLeakYes.Checked, txtLeakRemarks, fuLeak, conn, transaction, headerId);
                    SaveChecklist("8. Proper segregation of filled and empty cylinders", RbSegregationYes.Checked, txtSegregationRemarks, fuSegregation, conn, transaction, headerId);
                    SaveChecklist("9. Welding area barricaded with fire resistant curtain", RbBarricadeYes.Checked, txtBarricadeRemarks, fuBarricade, conn, transaction, headerId);
                    SaveChecklist("10. Gas cutting cylinder moved only after closing valve and fixing valve cap", RbMovedYes.Checked, txtMovedRemarks, fuMoved, conn, transaction, headerId);
                    SaveChecklist("11. Fire extinguisher and sand bucket provided at site", RbFireExtYes.Checked, txtFireExtRemarks, fuFireExt, conn, transaction, headerId);
                    SaveChecklist("12. Cylinder kept away from heat, fire or electrical spark", RbSparkYes.Checked, txtSparkRemarks, fuSpark, conn, transaction, headerId);
                    SaveChecklist("13. Hoses are in good condition without cracks or damage", RbHoseYes.Checked, txtHoseRemarks, fuHose, conn, transaction, headerId);


                    transaction.Commit();
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

        private void SaveChecklist(string question, bool isYes, TextBox remarksBox, FileUpload photoUpload, SqlConnection conn, SqlTransaction transaction, int headerId)
        {
            try
            {
                string remarks = remarksBox != null ? remarksBox.Text.Trim() : "";
                string photoPath = null;

                if (!isYes && photoUpload.HasFile)
                {
                    string filename = Path.GetFileName(photoUpload.FileName);
                    string folderPath = Server.MapPath("~/Uploads/");
                    Directory.CreateDirectory(folderPath);
                    string fullPath = Path.Combine(folderPath, filename);
                    photoUpload.SaveAs(fullPath);
                    photoPath = "~/Uploads/" + filename;
                }

                using (SqlCommand cmd = new SqlCommand("sp_InsertGasCuttingChecklist", conn, transaction))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@HeaderID", headerId);
                    cmd.Parameters.AddWithValue("@Question", question);
                    cmd.Parameters.AddWithValue("@IsYes", isYes);
                    cmd.Parameters.AddWithValue("@Remarks", remarks);
                    cmd.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);

                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception)
            {
                // Optional: log individual question save errors
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