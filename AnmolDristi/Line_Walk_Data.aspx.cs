using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace AnmolDristi
{
    public partial class Line_Walk_Data : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Line_walk_status order by ID desc", conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                View.DataSource = dt;
                View.DataBind();
            }
        }

        protected void View_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteWalk")
            {
                int walkId = Convert.ToInt32(e.CommandArgument);

                string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(cs))
                {
                    conn.Open();

                    SqlCommand deleteMain = new SqlCommand("DELETE FROM Line_walk_status WHERE ID = @ID", conn);
                    deleteMain.Parameters.AddWithValue("@ID", walkId);
                    deleteMain.ExecuteNonQuery();
                }

                string Data_SuccessScript = @"<script type='text/javascript'>
            new PNotify({
                title: 'Success',
                text: 'Walk record deleted successfully!',
                type: 'success',
                styling: 'bootstrap3'
            });
        </script>";

                ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);

                LoadData();
            }
        }

    }
}