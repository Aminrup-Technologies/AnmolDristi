using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class view : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGridData();
            }
        }

        private void LoadGridData()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Workers_PPE_Checklist ORDER BY id DESC";
                using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            LoadGridData();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            LoadGridData();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

                string inspection_by = ((TextBox)row.Cells[1].Controls[0]).Text;
                DateTime submitted_date = Convert.ToDateTime(((TextBox)row.Cells[2].Controls[0]).Text);
                string worker_id = ((TextBox)row.Cells[3].Controls[0]).Text;
                string worker_name = ((TextBox)row.Cells[4].Controls[0]).Text;
                string designation = ((TextBox)row.Cells[5].Controls[0]).Text;
                int safety_shoe = Convert.ToInt32(((TextBox)row.Cells[6].Controls[0]).Text);
                int safety_helmet = Convert.ToInt32(((TextBox)row.Cells[7].Controls[0]).Text);
                int safety_goggles = Convert.ToInt32(((TextBox)row.Cells[8].Controls[0]).Text);
                int safety_spron = Convert.ToInt32(((TextBox)row.Cells[9].Controls[0]).Text);
                int hot_protect_jacket = Convert.ToInt32(((TextBox)row.Cells[10].Controls[0]).Text);
                int hand_gloves = Convert.ToInt32(((TextBox)row.Cells[11].Controls[0]).Text);
                int hand_sleeves = Convert.ToInt32(((TextBox)row.Cells[12].Controls[0]).Text);
                int ear_plug = Convert.ToInt32(((TextBox)row.Cells[13].Controls[0]).Text);
                int nose_mask = Convert.ToInt32(((TextBox)row.Cells[14].Controls[0]).Text);
                int leg_guard = Convert.ToInt32(((TextBox)row.Cells[15].Controls[0]).Text);
                string remarks = ((TextBox)row.Cells[16].Controls[0]).Text;
                string shoe_remark = ((TextBox)row.Cells[18].Controls[0]).Text;
                string helmet_remark = ((TextBox)row.Cells[19].Controls[0]).Text;
                string goggles_remark = ((TextBox)row.Cells[20].Controls[0]).Text;
                string spron_remark = ((TextBox)row.Cells[21].Controls[0]).Text;
                string jacket_remark = ((TextBox)row.Cells[22].Controls[0]).Text;
                string gloves_remark = ((TextBox)row.Cells[23].Controls[0]).Text;
                string sleeves_remark = ((TextBox)row.Cells[24].Controls[0]).Text;
                string ear_plug_remark = ((TextBox)row.Cells[25].Controls[0]).Text;
                string nose_mask_remark = ((TextBox)row.Cells[26].Controls[0]).Text;
                string leg_guard_remark = ((TextBox)row.Cells[27].Controls[0]).Text;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Workers_PPE_Checklist 
                                     SET inspection_by=@inspection_by, Submitted_date=@submitted_date, 
                                         worker_id=@worker_id, worker_name=@worker_name, designation=@designation, 
                                         safety_shoe=@safety_shoe, safety_helmet=@safety_helmet, safety_goggles=@safety_goggles, 
                                         safety_spron=@safety_spron, hot_protect_jacket=@hot_protect_jacket, 
                                         hand_gloves=@hand_gloves, hand_sleeves=@hand_sleeves, ear_plug=@ear_plug, 
                                         nose_mask=@nose_mask, leg_guard=@leg_guard, remarks=@remarks, 
                                         safety_shoe_remark=@shoe_remark, safety_helmet_remark=@helmet_remark, 
                                         safety_goggles_remark=@goggles_remark, safety_spron_remark=@spron_remark, 
                                         hot_protect_jacket_remark=@jacket_remark, hand_gloves_remark=@gloves_remark, 
                                         hand_sleeves_remark=@sleeves_remark, ear_plug_remark=@ear_plug_remark, 
                                         nose_mask_remark=@nose_mask_remark, leg_guard_remark=@leg_guard_remark 
                                     WHERE id=@id";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.Parameters.AddWithValue("@inspection_by", inspection_by);
                        cmd.Parameters.AddWithValue("@submitted_date", submitted_date);
                        cmd.Parameters.AddWithValue("@worker_id", worker_id);
                        cmd.Parameters.AddWithValue("@worker_name", worker_name);
                        cmd.Parameters.AddWithValue("@designation", designation);
                        cmd.Parameters.AddWithValue("@safety_shoe", safety_shoe);
                        cmd.Parameters.AddWithValue("@safety_helmet", safety_helmet);
                        cmd.Parameters.AddWithValue("@safety_goggles", safety_goggles);
                        cmd.Parameters.AddWithValue("@safety_spron", safety_spron);
                        cmd.Parameters.AddWithValue("@hot_protect_jacket", hot_protect_jacket);
                        cmd.Parameters.AddWithValue("@hand_gloves", hand_gloves);
                        cmd.Parameters.AddWithValue("@hand_sleeves", hand_sleeves);
                        cmd.Parameters.AddWithValue("@ear_plug", ear_plug);
                        cmd.Parameters.AddWithValue("@nose_mask", nose_mask);
                        cmd.Parameters.AddWithValue("@leg_guard", leg_guard);
                        cmd.Parameters.AddWithValue("@remarks", remarks);
                        cmd.Parameters.AddWithValue("@shoe_remark", shoe_remark);
                        cmd.Parameters.AddWithValue("@helmet_remark", helmet_remark);
                        cmd.Parameters.AddWithValue("@goggles_remark", goggles_remark);
                        cmd.Parameters.AddWithValue("@spron_remark", spron_remark);
                        cmd.Parameters.AddWithValue("@jacket_remark", jacket_remark);
                        cmd.Parameters.AddWithValue("@gloves_remark", gloves_remark);
                        cmd.Parameters.AddWithValue("@sleeves_remark", sleeves_remark);
                        cmd.Parameters.AddWithValue("@ear_plug_remark", ear_plug_remark);
                        cmd.Parameters.AddWithValue("@nose_mask_remark", nose_mask_remark);
                        cmd.Parameters.AddWithValue("@leg_guard_remark", leg_guard_remark);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                GridView1.EditIndex = -1;
                LoadGridData();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Workers_PPE_Checklist WHERE id=@id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadGridData();
        }
    }
}
