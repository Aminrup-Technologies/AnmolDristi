using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class fiveS_checklist_2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadChecklists();
            }
        }


        private void LoadChecklists()
        {
            string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Checklists order by ID desc", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewChecklists.DataSource = dt;
                GridViewChecklists.DataBind();
            }
        }

        protected void GridViewChecklists_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (!string.IsNullOrEmpty(e.Row.Cells[1].Text))
            { 
                if (e.Row.RowType.ToString() == "DataRow")
                {
                    e.Row.Cells[1].Text = Convert.ToDateTime(e.Row.Cells[1].Text).ToShortDateString();
                }
            }
        }

        protected void GridViewChecklists_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteChecklist")
            {
                string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                int checklistId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    string deleteChecklistQuery = "DELETE FROM Checklists WHERE ID = @ID";
                    using (SqlCommand cmdChecklist = new SqlCommand(deleteChecklistQuery, conn))
                    {
                        cmdChecklist.Parameters.AddWithValue("@ID", checklistId);
                        cmdChecklist.ExecuteNonQuery();
                    }

                    conn.Close();
                }

                string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Sucess',
                                text: 'Checklist Deleted Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);

                LoadChecklists();
            }
        }
    }
} 