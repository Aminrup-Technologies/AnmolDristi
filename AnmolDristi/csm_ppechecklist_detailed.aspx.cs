using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace AnmolDristi
{

    public partial class csm_ppechecklist_detailed : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"]);
                    LoadPPEChecklistDetails(id);
                }
            }
        }

        //private void LoadPPEChecklistDetails(int id)
        //{
        //    using (SqlConnection conn = new SqlConnection(connStr))
        //    {
        //        string query = "SELECT * FROM Workers_PPE_Checklist WHERE id = @id";
        //        SqlCommand cmd = new SqlCommand(query, conn);
        //        cmd.Parameters.AddWithValue("@id", id);

        //        conn.Open();
        //        SqlDataReader reader = cmd.ExecuteReader();

        //        if (reader.Read())
        //        {
        //            // Assigning values to textboxes
        //            TB_Inspection.Text = reader["inspection_by"].ToString();
        //            TB_Date.Text = Convert.ToDateTime(reader["Submitted_date"]).ToString("yyyy-MM-dd");
        //            TB_WorkerID.Text = reader["worker_id"].ToString();
        //            TB_WorkerName.Text = reader["worker_name"].ToString();
        //            TB_Designation.Text = reader["designation"].ToString();
        //            TB_Remarks.Text = reader["remarks"].ToString();

        //            // Assigning values to RadioButtonLists
        //            rbl_SafetyShoe.SelectedValue = reader["safety_shoe"].ToString();
        //            rbl_SafetyHelmet.SelectedValue = reader["safety_helmet"].ToString();
        //            rbl_SafetyGoggles.SelectedValue = reader["safety_goggles"].ToString();
        //            rbl_SafetySpron.SelectedValue = reader["safety_spron"].ToString();
        //            rbl_HotProtectJacket.SelectedValue = reader["hot_protect_jacket"].ToString();
        //            rbl_HandGloves.SelectedValue = reader["hand_gloves"].ToString();
        //            rbl_HandSleeves.SelectedValue = reader["hand_sleeves"].ToString();
        //            rbl_EarPlug.SelectedValue = reader["ear_plug"].ToString();
        //            rbl_NoseMask.SelectedValue = reader["nose_mask"].ToString();
        //            rbl_LegGuard.SelectedValue = reader["leg_guard"].ToString();

        //            // Show remarks only if "Not Okay" is selected
        //            TB_NO_SafetyShoe.Text = (rbl_SafetyShoe.SelectedValue == "Not Okay") ? reader["safety_shoe_remark"].ToString() : "";
        //            TB_NO_SafetyHelmet.Text = (rbl_SafetyHelmet.SelectedValue == "Not Okay") ? reader["safety_helmet_remark"].ToString() : "";
        //            TB_NO_SafetyGoggles.Text = (rbl_SafetyGoggles.SelectedValue == "Not Okay") ? reader["safety_goggles_remark"].ToString() : "";
        //            TB_NO_SafetySpron.Text = (rbl_SafetySpron.SelectedValue == "Not Okay") ? reader["safety_spron_remark"].ToString() : "";
        //            TB_NO_HPJacket.Text = (rbl_HotProtectJacket.SelectedValue == "Not Okay") ? reader["hot_protect_jacket_remark"].ToString() : "";
        //            TB_NO_HandGloves.Text = (rbl_HandGloves.SelectedValue == "Not Okay") ? reader["hand_gloves_remark"].ToString() : "";
        //            TB_NO_HandSleeves.Text = (rbl_HandSleeves.SelectedValue == "Not Okay") ? reader["hand_sleeves_remark"].ToString() : "";
        //            TB_NO_EarPlug.Text = (rbl_EarPlug.SelectedValue == "Not Okay") ? reader["ear_plug_remark"].ToString() : "";
        //            TB_NO_NoseMask.Text = (rbl_NoseMask.SelectedValue == "Not Okay") ? reader["nose_mask_remark"].ToString() : "";
        //            TB_NO_LegGuard.Text = (rbl_LegGuard.SelectedValue == "Not Okay") ? reader["leg_guard_remark"].ToString() : "";
        //        }
        //        conn.Close();
        //    }
        //}


        //private void LoadPPEChecklistDetails(int id)
        //{
        //    using (SqlConnection conn = new SqlConnection(connStr))
        //    {
        //        string query = "SELECT * FROM Workers_PPE_Checklist WHERE id = @id";
        //        SqlCommand cmd = new SqlCommand(query, conn);
        //        cmd.Parameters.AddWithValue("@id", id);

        //        conn.Open();
        //        SqlDataReader reader = cmd.ExecuteReader();

        //        if (reader.Read())
        //        {
        //            // Assigning values to textboxes
        //            TB_Inspection.Text = reader["inspection_by"].ToString();
        //            TB_Date.Text = Convert.ToDateTime(reader["Submitted_date"]).ToString("yyyy-MM-dd");
        //            TB_WorkerID.Text = reader["worker_id"].ToString();
        //            TB_WorkerName.Text = reader["worker_name"].ToString();
        //            TB_Designation.Text = reader["designation"].ToString();
        //            TB_Remarks.Text = reader["remarks"].ToString();

        //            // Assigning values to RadioButtonLists
        //            rbl_SafetyShoe.SelectedValue = reader["safety_shoe"].ToString();
        //            rbl_SafetyHelmet.SelectedValue = reader["safety_helmet"].ToString();
        //            rbl_SafetyGoggles.SelectedValue = reader["safety_goggles"].ToString();
        //            rbl_SafetySpron.SelectedValue = reader["safety_spron"].ToString();
        //            rbl_HotProtectJacket.SelectedValue = reader["hot_protect_jacket"].ToString();
        //            rbl_HandGloves.SelectedValue = reader["hand_gloves"].ToString();
        //            rbl_HandSleeves.SelectedValue = reader["hand_sleeves"].ToString();
        //            rbl_EarPlug.SelectedValue = reader["ear_plug"].ToString();
        //            rbl_NoseMask.SelectedValue = reader["nose_mask"].ToString();
        //            rbl_LegGuard.SelectedValue = reader["leg_guard"].ToString();

        //            // Assigning values to remarks textboxes (if NOT OKAY is selected)
        //            TB_NO_SafetyShoe.Text = reader["safety_shoe_remark"].ToString();
        //            TB_NO_SafetyHelmet.Text = reader["safety_helmet_remark"].ToString();
        //            TB_NO_SafetyGoggles.Text = reader["safety_goggles_remark"].ToString();
        //            TB_NO_SafetySpron.Text = reader["safety_spron_remark"].ToString();
        //            TB_NO_HPJacket.Text = reader["hot_protect_jacket_remark"].ToString();
        //            TB_NO_HandGloves.Text = reader["hand_gloves_remark"].ToString();
        //            TB_NO_HandSleeves.Text = reader["hand_sleeves_remark"].ToString();
        //            TB_NO_EarPlug.Text = reader["ear_plug_remark"].ToString();
        //            TB_NO_NoseMask.Text = reader["nose_mask_remark"].ToString();
        //            TB_NO_LegGuard.Text = reader["leg_guard_remark"].ToString();

        //            // Make all textboxes readonly
        //            TB_Inspection.ReadOnly = true;
        //            TB_Date.ReadOnly = true;
        //            TB_WorkerID.ReadOnly = true;
        //            TB_WorkerName.ReadOnly = true;
        //            TB_Designation.ReadOnly = true;
        //            TB_Remarks.ReadOnly = true;

        //            TB_NO_SafetyShoe.ReadOnly = true;
        //            TB_NO_SafetyHelmet.ReadOnly = true;
        //            TB_NO_SafetyGoggles.ReadOnly = true;
        //            TB_NO_SafetySpron.ReadOnly = true;
        //            TB_NO_HPJacket.ReadOnly = true;
        //            TB_NO_HandGloves.ReadOnly = true;
        //            TB_NO_HandSleeves.ReadOnly = true;
        //            TB_NO_EarPlug.ReadOnly = true;
        //            TB_NO_NoseMask.ReadOnly = true;
        //            TB_NO_LegGuard.ReadOnly = true;

        //            // Disable all RadioButtonLists
        //            rbl_SafetyShoe.Enabled = false;
        //            rbl_SafetyHelmet.Enabled = false;
        //            rbl_SafetyGoggles.Enabled = false;
        //            rbl_SafetySpron.Enabled = false;
        //            rbl_HotProtectJacket.Enabled = false;
        //            rbl_HandGloves.Enabled = false;
        //            rbl_HandSleeves.Enabled = false;
        //            rbl_EarPlug.Enabled = false;
        //            rbl_NoseMask.Enabled = false;
        //            rbl_LegGuard.Enabled = false;
        //        }
        //        conn.Close();
        //    }
        //}

        //protected void btnUpdate_Click(object sender, EventArgs e)
        //{
        //    using (SqlConnection conn = new SqlConnection(connStr))
        //    {
        //        string query = @"UPDATE Workers_PPE_Checklist 
        //                 SET inspection_by=@inspection_by, Submitted_date=@date, worker_id=@worker_id, 
        //                     worker_name=@worker_name, designation=@designation, remarks=@remarks,
        //                     safety_shoe=@safety_shoe, safety_helmet=@safety_helmet, safety_goggles=@safety_goggles,
        //                     safety_spron=@safety_spron, hot_protect_jacket=@hot_protect_jacket, hand_gloves=@hand_gloves,
        //                     hand_sleeves=@hand_sleeves, ear_plug=@ear_plug, nose_mask=@nose_mask, leg_guard=@leg_guard,
        //                     safety_shoe_remark=@safety_shoe_remark, safety_helmet_remark=@safety_helmet_remark,
        //                     safety_goggles_remark=@safety_goggles_remark, safety_spron_remark=@safety_spron_remark,
        //                     hot_protect_jacket_remark=@hot_protect_jacket_remark, hand_gloves_remark=@hand_gloves_remark,
        //                     hand_sleeves_remark=@hand_sleeves_remark, ear_plug_remark=@ear_plug_remark,
        //                     nose_mask_remark=@nose_mask_remark, leg_guard_remark=@leg_guard_remark
        //                 WHERE id=@id";

        //        SqlCommand cmd = new SqlCommand(query, conn);
        //        cmd.Parameters.AddWithValue("@id", Request.QueryString["id"]);
        //        cmd.Parameters.AddWithValue("@inspection_by", TB_Inspection.Text);
        //        cmd.Parameters.AddWithValue("@date", TB_Date.Text);
        //        cmd.Parameters.AddWithValue("@worker_id", TB_WorkerID.Text);
        //        cmd.Parameters.AddWithValue("@worker_name", TB_WorkerName.Text);
        //        cmd.Parameters.AddWithValue("@designation", TB_Designation.Text);
        //        cmd.Parameters.AddWithValue("@remarks", TB_Remarks.Text);

        //        cmd.Parameters.AddWithValue("@safety_shoe", rbl_SafetyShoe.SelectedValue);
        //        cmd.Parameters.AddWithValue("@safety_helmet", rbl_SafetyHelmet.SelectedValue);
        //        cmd.Parameters.AddWithValue("@safety_goggles", rbl_SafetyGoggles.SelectedValue);
        //        cmd.Parameters.AddWithValue("@safety_spron", rbl_SafetySpron.SelectedValue);
        //        cmd.Parameters.AddWithValue("@hot_protect_jacket", rbl_HotProtectJacket.SelectedValue);
        //        cmd.Parameters.AddWithValue("@hand_gloves", rbl_HandGloves.SelectedValue);
        //        cmd.Parameters.AddWithValue("@hand_sleeves", rbl_HandSleeves.SelectedValue);
        //        cmd.Parameters.AddWithValue("@ear_plug", rbl_EarPlug.SelectedValue);
        //        cmd.Parameters.AddWithValue("@nose_mask", rbl_NoseMask.SelectedValue);
        //        cmd.Parameters.AddWithValue("@leg_guard", rbl_LegGuard.SelectedValue);

        //        cmd.Parameters.AddWithValue("@safety_shoe_remark", TB_NO_SafetyShoe.Text);
        //        cmd.Parameters.AddWithValue("@safety_helmet_remark", TB_NO_SafetyHelmet.Text);
        //        cmd.Parameters.AddWithValue("@safety_goggles_remark", TB_NO_SafetyGoggles.Text);
        //        cmd.Parameters.AddWithValue("@safety_spron_remark", TB_NO_SafetySpron.Text);
        //        cmd.Parameters.AddWithValue("@hot_protect_jacket_remark", TB_NO_HPJacket.Text);
        //        cmd.Parameters.AddWithValue("@hand_gloves_remark", TB_NO_HandGloves.Text);
        //        cmd.Parameters.AddWithValue("@hand_sleeves_remark", TB_NO_HandSleeves.Text);
        //        cmd.Parameters.AddWithValue("@ear_plug_remark", TB_NO_EarPlug.Text);
        //        cmd.Parameters.AddWithValue("@nose_mask_remark", TB_NO_NoseMask.Text);
        //        cmd.Parameters.AddWithValue("@leg_guard_remark", TB_NO_LegGuard.Text);

        //        conn.Open();
        //        cmd.ExecuteNonQuery();
        //        conn.Close();

        //        Response.Write("<script>alert('Record Updated Successfully!');</script>");
        //    }
        //}

        private void LoadPPEChecklistDetails(int id)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Workers_PPE_Checklist WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Assigning values to textboxes
                    TB_Inspection.Text = reader["inspection_by"].ToString();
                    TB_Date.Text = Convert.ToDateTime(reader["Submitted_date"]).ToString("yyyy-MM-dd");
                    TB_WorkerID.Text = reader["worker_id"].ToString();
                    TB_WorkerName.Text = reader["worker_name"].ToString();
                    TB_Designation.Text = reader["designation"].ToString();
                    TB_Remarks.Text = reader["remarks"].ToString();

                    // Making all fields read-only
                    TB_Inspection.ReadOnly = true;
                    TB_Date.ReadOnly = true;
                    TB_WorkerID.ReadOnly = true;
                    TB_WorkerName.ReadOnly = true;
                    TB_Designation.ReadOnly = true;
                    TB_Remarks.ReadOnly = true;

                    // Assigning values to RadioButtonLists and making them disabled
                    rbl_SafetyShoe.SelectedValue = reader["safety_shoe"].ToString();
                    rbl_SafetyHelmet.SelectedValue = reader["safety_helmet"].ToString();
                    rbl_SafetyGoggles.SelectedValue = reader["safety_goggles"].ToString();
                    rbl_SafetySpron.SelectedValue = reader["safety_spron"].ToString();
                    rbl_HotProtectJacket.SelectedValue = reader["hot_protect_jacket"].ToString();
                    rbl_HandGloves.SelectedValue = reader["hand_gloves"].ToString();
                    rbl_HandSleeves.SelectedValue = reader["hand_sleeves"].ToString();
                    rbl_EarPlug.SelectedValue = reader["ear_plug"].ToString();
                    rbl_NoseMask.SelectedValue = reader["nose_mask"].ToString();
                    rbl_LegGuard.SelectedValue = reader["leg_guard"].ToString();

                    // Disable all radio button lists
                    rbl_SafetyShoe.Enabled = false;
                    rbl_SafetyHelmet.Enabled = false;
                    rbl_SafetyGoggles.Enabled = false;
                    rbl_SafetySpron.Enabled = false;
                    rbl_HotProtectJacket.Enabled = false;
                    rbl_HandGloves.Enabled = false;
                    rbl_HandSleeves.Enabled = false;
                    rbl_EarPlug.Enabled = false;
                    rbl_NoseMask.Enabled = false;
                    rbl_LegGuard.Enabled = false;

                    // Dynamically show remarks only if "Not Okay" (0) is selected
                    TB_NO_SafetyShoe.Text = (reader["safety_shoe"].ToString() == "0") ? reader["safety_shoe_remark"].ToString() : "";
                    TB_NO_SafetyHelmet.Text = (reader["safety_helmet"].ToString() == "0") ? reader["safety_helmet_remark"].ToString() : "";
                    TB_NO_SafetyGoggles.Text = (reader["safety_goggles"].ToString() == "0") ? reader["safety_goggles_remark"].ToString() : "";
                    TB_NO_SafetySpron.Text = (reader["safety_spron"].ToString() == "0") ? reader["safety_spron_remark"].ToString() : "";
                    TB_NO_HPJacket.Text = (reader["hot_protect_jacket"].ToString() == "0") ? reader["hot_protect_jacket_remark"].ToString() : "";
                    TB_NO_HandGloves.Text = (reader["hand_gloves"].ToString() == "0") ? reader["hand_gloves_remark"].ToString() : "";
                    TB_NO_HandSleeves.Text = (reader["hand_sleeves"].ToString() == "0") ? reader["hand_sleeves_remark"].ToString() : "";
                    TB_NO_EarPlug.Text = (reader["ear_plug"].ToString() == "0") ? reader["ear_plug_remark"].ToString() : "";
                    TB_NO_NoseMask.Text = (reader["nose_mask"].ToString() == "0") ? reader["nose_mask_remark"].ToString() : "";
                    TB_NO_LegGuard.Text = (reader["leg_guard"].ToString() == "0") ? reader["leg_guard_remark"].ToString() : "";

                    // Making remark fields read-only
                    TB_NO_SafetyShoe.ReadOnly = true;
                    TB_NO_SafetyHelmet.ReadOnly = true;
                    TB_NO_SafetyGoggles.ReadOnly = true;
                    TB_NO_SafetySpron.ReadOnly = true;
                    TB_NO_HPJacket.ReadOnly = true;
                    TB_NO_HandGloves.ReadOnly = true;
                    TB_NO_HandSleeves.ReadOnly = true;
                    TB_NO_EarPlug.ReadOnly = true;
                    TB_NO_NoseMask.ReadOnly = true;
                    TB_NO_LegGuard.ReadOnly = true;
                }
                conn.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Enable TextBoxes
            TB_Inspection.ReadOnly = false;
            TB_Date.ReadOnly = false;
            TB_WorkerID.ReadOnly = false;
            TB_WorkerName.ReadOnly = false;
            TB_Designation.ReadOnly = false;
            TB_Remarks.ReadOnly = false;

            TB_NO_SafetyShoe.ReadOnly = false;
            TB_NO_SafetyHelmet.ReadOnly = false;
            TB_NO_SafetyGoggles.ReadOnly = false;
            TB_NO_SafetySpron.ReadOnly = false;
            TB_NO_HPJacket.ReadOnly = false;
            TB_NO_HandGloves.ReadOnly = false;
            TB_NO_HandSleeves.ReadOnly = false;
            TB_NO_EarPlug.ReadOnly = false;
            TB_NO_NoseMask.ReadOnly = false;
            TB_NO_LegGuard.ReadOnly = false;

            // Enable RadioButtonLists
            rbl_SafetyShoe.Enabled = true;
            rbl_SafetyHelmet.Enabled = true;
            rbl_SafetyGoggles.Enabled = true;
            rbl_SafetySpron.Enabled = true;
            rbl_HotProtectJacket.Enabled = true;
            rbl_HandGloves.Enabled = true;
            rbl_HandSleeves.Enabled = true;
            rbl_EarPlug.Enabled = true;
            rbl_NoseMask.Enabled = true;
            rbl_LegGuard.Enabled = true;

            // Disable Update button and Enable Save button
            btnUpdate.Enabled = false;
            btnSave.Enabled = true;
        }


        protected void btnDelete_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM Workers_PPE_Checklist WHERE id=@id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", Request.QueryString["id"]);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("ppe_report.aspx");
            }
        }








        //protected void btnSave_Click(object sender, EventArgs e)
        //{
        //    using (SqlConnection conn = new SqlConnection(connStr))
        //    {
        //        string query = @"INSERT INTO Workers_PPE_Checklist (inspection_by, Submitted_date, worker_id, worker_name, designation, remarks, 
        //                      safety_shoe, safety_helmet, safety_goggles, safety_spron, hot_protect_jacket, hand_gloves, hand_sleeves, 
        //                      ear_plug, nose_mask, leg_guard) 
        //                      VALUES (@inspection_by, @date, @worker_id, @worker_name, @designation, @remarks, 
        //                      @safety_shoe, @safety_helmet, @safety_goggles, @safety_spron, @hot_protect_jacket, 
        //                      @hand_gloves, @hand_sleeves, @ear_plug, @nose_mask, @leg_guard)";

        //        SqlCommand cmd = new SqlCommand(query, conn);
        //        cmd.Parameters.AddWithValue("@inspection_by", TB_Inspection.Text);
        //        cmd.Parameters.AddWithValue("@date", TB_Date.Text);
        //        cmd.Parameters.AddWithValue("@worker_id", TB_WorkerID.Text);
        //        cmd.Parameters.AddWithValue("@worker_name", TB_WorkerName.Text);
        //        cmd.Parameters.AddWithValue("@designation", TB_Designation.Text);
        //        cmd.Parameters.AddWithValue("@remarks", TB_Remarks.Text);

        //        cmd.Parameters.AddWithValue("@safety_shoe", rbl_SafetyShoe.SelectedValue);
        //        cmd.Parameters.AddWithValue("@safety_helmet", rbl_SafetyHelmet.SelectedValue);
        //        cmd.Parameters.AddWithValue("@safety_goggles", rbl_SafetyGoggles.SelectedValue);
        //        cmd.Parameters.AddWithValue("@safety_spron", rbl_SafetySpron.SelectedValue);
        //        cmd.Parameters.AddWithValue("@hot_protect_jacket", rbl_HotProtectJacket.SelectedValue);
        //        cmd.Parameters.AddWithValue("@hand_gloves", rbl_HandGloves.SelectedValue);
        //        cmd.Parameters.AddWithValue("@hand_sleeves", rbl_HandSleeves.SelectedValue);
        //        cmd.Parameters.AddWithValue("@ear_plug", rbl_EarPlug.SelectedValue);
        //        cmd.Parameters.AddWithValue("@nose_mask", rbl_NoseMask.SelectedValue);
        //        cmd.Parameters.AddWithValue("@leg_guard", rbl_LegGuard.SelectedValue);

        //        conn.Open();
        //        cmd.ExecuteNonQuery();
        //        conn.Close();

        //        Response.Write("<script>alert('Record Saved Successfully!');</script>");
        //        Response.Redirect("ppe_report.aspx");

        //    }
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"UPDATE Workers_PPE_Checklist 
                  SET inspection_by=@inspection_by, Submitted_date=@date, worker_id=@worker_id, 
                      worker_name=@worker_name, designation=@designation, remarks=@remarks,
                      safety_shoe=@safety_shoe, safety_helmet=@safety_helmet, safety_goggles=@safety_goggles,
                      safety_spron=@safety_spron, hot_protect_jacket=@hot_protect_jacket, hand_gloves=@hand_gloves,
                      hand_sleeves=@hand_sleeves, ear_plug=@ear_plug, nose_mask=@nose_mask, leg_guard=@leg_guard,
                      safety_shoe_remark=@safety_shoe_remark, safety_helmet_remark=@safety_helmet_remark,
                      safety_goggles_remark=@safety_goggles_remark, safety_spron_remark=@safety_spron_remark,
                      hot_protect_jacket_remark=@hot_protect_jacket_remark, hand_gloves_remark=@hand_gloves_remark,
                      hand_sleeves_remark=@hand_sleeves_remark, ear_plug_remark=@ear_plug_remark,
                      nose_mask_remark=@nose_mask_remark, leg_guard_remark=@leg_guard_remark
                  WHERE id=@id";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", Request.QueryString["id"]);
                cmd.Parameters.AddWithValue("@inspection_by", TB_Inspection.Text);
                cmd.Parameters.AddWithValue("@date", TB_Date.Text);
                cmd.Parameters.AddWithValue("@worker_id", TB_WorkerID.Text);
                cmd.Parameters.AddWithValue("@worker_name", TB_WorkerName.Text);
                cmd.Parameters.AddWithValue("@designation", TB_Designation.Text);
                cmd.Parameters.AddWithValue("@remarks", TB_Remarks.Text);

                cmd.Parameters.AddWithValue("@safety_shoe", rbl_SafetyShoe.SelectedValue);
                cmd.Parameters.AddWithValue("@safety_helmet", rbl_SafetyHelmet.SelectedValue);
                cmd.Parameters.AddWithValue("@safety_goggles", rbl_SafetyGoggles.SelectedValue);
                cmd.Parameters.AddWithValue("@safety_spron", rbl_SafetySpron.SelectedValue);
                cmd.Parameters.AddWithValue("@hot_protect_jacket", rbl_HotProtectJacket.SelectedValue);
                cmd.Parameters.AddWithValue("@hand_gloves", rbl_HandGloves.SelectedValue);
                cmd.Parameters.AddWithValue("@hand_sleeves", rbl_HandSleeves.SelectedValue);
                cmd.Parameters.AddWithValue("@ear_plug", rbl_EarPlug.SelectedValue);
                cmd.Parameters.AddWithValue("@nose_mask", rbl_NoseMask.SelectedValue);
                cmd.Parameters.AddWithValue("@leg_guard", rbl_LegGuard.SelectedValue);

                cmd.Parameters.AddWithValue("@safety_shoe_remark", TB_NO_SafetyShoe.Text);
                cmd.Parameters.AddWithValue("@safety_helmet_remark", TB_NO_SafetyHelmet.Text);
                cmd.Parameters.AddWithValue("@safety_goggles_remark", TB_NO_SafetyGoggles.Text);
                cmd.Parameters.AddWithValue("@safety_spron_remark", TB_NO_SafetySpron.Text);
                cmd.Parameters.AddWithValue("@hot_protect_jacket_remark", TB_NO_HPJacket.Text);
                cmd.Parameters.AddWithValue("@hand_gloves_remark", TB_NO_HandGloves.Text);
                cmd.Parameters.AddWithValue("@hand_sleeves_remark", TB_NO_HandSleeves.Text);
                cmd.Parameters.AddWithValue("@ear_plug_remark", TB_NO_EarPlug.Text);
                cmd.Parameters.AddWithValue("@nose_mask_remark", TB_NO_NoseMask.Text);
                cmd.Parameters.AddWithValue("@leg_guard_remark", TB_NO_LegGuard.Text);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            // After saving, make fields read-only again
            TB_Inspection.ReadOnly = true;
            TB_Date.ReadOnly = true;
            TB_WorkerID.ReadOnly = true;
            TB_WorkerName.ReadOnly = true;
            TB_Designation.ReadOnly = true;
            TB_Remarks.ReadOnly = true;

            TB_NO_SafetyShoe.ReadOnly = true;
            TB_NO_SafetyHelmet.ReadOnly = true;
            TB_NO_SafetyGoggles.ReadOnly = true;
            TB_NO_SafetySpron.ReadOnly = true;
            TB_NO_HPJacket.ReadOnly = true;
            TB_NO_HandGloves.ReadOnly = true;
            TB_NO_HandSleeves.ReadOnly = true;
            TB_NO_EarPlug.ReadOnly = true;
            TB_NO_NoseMask.ReadOnly = true;
            TB_NO_LegGuard.ReadOnly = true;

            // Disable RadioButtonLists again
            rbl_SafetyShoe.Enabled = false;
            rbl_SafetyHelmet.Enabled = false;
            rbl_SafetyGoggles.Enabled = false;
            rbl_SafetySpron.Enabled = false;
            rbl_HotProtectJacket.Enabled = false;
            rbl_HandGloves.Enabled = false;
            rbl_HandSleeves.Enabled = false;
            rbl_EarPlug.Enabled = false;
            rbl_NoseMask.Enabled = false;
            rbl_LegGuard.Enabled = false;

            // Enable Update button again and Disable Save button
            btnUpdate.Enabled = true;
            btnSave.Enabled = false;

            Response.Write("<script>alert('Record Updated Successfully!');</script>");
            Response.Redirect("ppe_report.aspx");

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ppe_report.aspx");
        }



    }
}