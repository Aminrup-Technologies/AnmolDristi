using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace AnmolDristi
{
    public partial class csm_ppechecklist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;


            string inspection_by = TB_Inspection.Text.Trim(); // TB captures user input

            DateTime? Submitted_date = string.IsNullOrEmpty(TB_Date.Text) ? (DateTime?)null : Convert.ToDateTime(TB_Date.Text).Date;  //  submitted_date stores only the date part (00:00:00 as default time) i.e, This ensures time is set to 00:00:00

            string worker_id = TB_WorkerID.Text.Trim();

            string worker_name = TB_WorkerName.Text;

            string designation = TB_Designation.Text.Trim();


            int safety_shoe = Convert.ToInt32(rbl_SafetyShoe.SelectedValue); // Safety Shoe Selection         

            int safety_helmet = Convert.ToInt32(rbl_SafetyHelmet.SelectedValue); // Safety Helmet Selection

            int safety_goggles = Convert.ToInt32(rbl_SafetyGoggles.SelectedValue); // Safety Goggles Selection

            int safety_spron = Convert.ToInt32(rbl_SafetySpron.SelectedValue); // Safety Spron Selection

            int hot_protect_jacket = Convert.ToInt32(rbl_HotProtectJacket.SelectedValue); // //Hot Protect Jacket Selection

            int hand_gloves = Convert.ToInt32(rbl_HandGloves.SelectedValue);  // Hand Gloves Selection

            int hand_sleeves = Convert.ToInt32(rbl_HandSleeves.SelectedValue);  // Hand Sleeves Selection

            int ear_plug = Convert.ToInt32(rbl_EarPlug.SelectedValue);// Ear Plug Selection

            int nose_mask = Convert.ToInt32(rbl_NoseMask.SelectedValue); // //Nose Mask Selection

            int leg_guard = Convert.ToInt32(rbl_LegGuard.SelectedValue); //   //Leg Guard Selection



            string remarks = TB_Remarks.Text;   //Remarks

            DateTime time_stamp = DateTime.Now; // time_stamp stores the current date and time (if needed).



            string safety_shoe_remarks = (safety_shoe == 0) ? TB_NO_SafetyShoe.Text.Trim() : null;  // Safety Shoe Remarks (If Not Okay)

            string safety_helmet_remarks = (safety_helmet == 0) ? TB_NO_SafetyHelmet.Text.Trim() : null;  // Safety Helmet Remarks (If Not Okay)

            string safety_goggles_remarks = (safety_goggles == 0) ? TB_NO_SafetyGoggles.Text.Trim() : null;  // Safety Goggles Remarks (If Not Okay)

            string safety_spron_remarks = (safety_spron == 0) ? TB_NO_SafetySpron.Text.Trim() : null;  // Safety Spron Remarks (If Not Okay)

            string hot_protect_jacket_remarks = (hot_protect_jacket == 0) ? TB_NO_HPJacket.Text.Trim() : null; // Hot Protect Jacket Remarks (If Not Okay)

            string hand_gloves_remarks = (hand_gloves == 0) ? TB_NO_HandGloves.Text.Trim() : null;  //  Hand Gloves Remarks (If Not Okay)

            string hand_sleeves_remarks = (hand_sleeves == 0) ? TB_NO_HandSleeves.Text.Trim() : null; //  Hand Sleeves Remarks (If Not Okay)

            string ear_plug_remarks = (ear_plug == 0) ? TB_NO_EarPlug.Text.Trim() : null; //  Ear Plug Remarks (If Not Okay)

            string nose_mask_remarks = (nose_mask == 0) ? TB_NO_NoseMask.Text.Trim() : null; //  // Nose Mask Remarks (If Not Okay)

            string leg_guard_remarks = (leg_guard == 0) ? TB_NO_LegGuard.Text.Trim() : null; //Leg Guard Remarks (If Not Okay)



            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("SP_Workers_PPE_Checklist", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        //Adding Parameters
                        command.Parameters.AddWithValue("@inspection_by", inspection_by);
                        command.Parameters.AddWithValue("@Submitted_date", Submitted_date);
                        command.Parameters.AddWithValue("@worker_id", worker_id);
                        command.Parameters.AddWithValue("@worker_name", worker_name);
                        command.Parameters.AddWithValue("@designation", designation);
                        command.Parameters.AddWithValue("@safety_shoe", safety_shoe);
                        command.Parameters.AddWithValue("@safety_helmet", safety_helmet);
                        command.Parameters.AddWithValue("@safety_goggles", safety_goggles);
                        command.Parameters.AddWithValue("@safety_spron", safety_spron);
                        command.Parameters.AddWithValue("@hot_protect_jacket", hot_protect_jacket);
                        command.Parameters.AddWithValue("@hand_gloves", hand_gloves);
                        command.Parameters.AddWithValue("@hand_sleeves", hand_sleeves);
                        command.Parameters.AddWithValue("@ear_plug", ear_plug);
                        command.Parameters.AddWithValue("@nose_mask", nose_mask);
                        command.Parameters.AddWithValue("@leg_guard", leg_guard);
                        command.Parameters.AddWithValue("@remarks", remarks);
                        command.Parameters.AddWithValue("@Time_stamp", time_stamp);
                        command.Parameters.AddWithValue("@safety_shoe_remark", safety_shoe_remarks);
                        command.Parameters.AddWithValue("@safety_helmet_remark", safety_helmet_remarks);
                        command.Parameters.AddWithValue("@safety_goggles_remark", safety_goggles_remarks);
                        command.Parameters.AddWithValue("@safety_spron_remark", safety_spron_remarks);
                        command.Parameters.AddWithValue("@hot_protect_jacket_remark", hot_protect_jacket_remarks);
                        command.Parameters.AddWithValue("@hand_gloves_remark", hand_gloves_remarks);
                        command.Parameters.AddWithValue("@hand_sleeves_remark", hand_sleeves_remarks);
                        command.Parameters.AddWithValue("@ear_plug_remark", ear_plug_remarks);
                        command.Parameters.AddWithValue("@nose_mask_remark", nose_mask_remarks);
                        command.Parameters.AddWithValue("@leg_guard_remark", leg_guard_remarks);


                        //Execute the query
                        command.ExecuteNonQuery();



                    }
                    connection.Close();
                }
                //Show SweetAlert2 after successful submission
                string script = "Swal.fire({ title: 'Success!', text: 'Data submitted successfully.', icon: 'success' });";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitSuccess", script, true);

            }


            catch (Exception ex)
            {
                lbl_msg.Text = "Error: " + ex.Message;
                lbl_msg.ForeColor = System.Drawing.Color.Red;

                // ❌ Show SweetAlert2 on error
                string errorScript = $"Swal.fire({{ title: 'Error!', text: '{ex.Message}', icon: 'error' }});";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitError", errorScript, true);
            }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("csm_ppechecklist.aspx");
        }
    }


}
