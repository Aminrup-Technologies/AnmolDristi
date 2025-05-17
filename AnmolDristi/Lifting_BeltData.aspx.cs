using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace AnmolDristi
{
    public partial class Lifting_BeltData : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInfo();
            }
        }


        private void LoadInfo()
        {
            string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM LiftingBeltChecklist Order by ID desc", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewChecklists.DataSource = dt;
                GridViewChecklists.DataBind();
            }
        }



        protected void GridViewChecklists_RowCommand1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteChecklist")
            {
                string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                int checklistId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    string deleteChecklistQuery = "DELETE FROM LiftingBeltChecklist WHERE ID = @ID";
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

                LoadInfo();
            }
        }
    }
}