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
                SqlCommand cmd = new SqlCommand("SELECT * FROM Checklists", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewChecklists.DataSource = dt;
                GridViewChecklists.DataBind();
            }
        }

        protected void GridViewChecklists_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType.ToString() == "DataRow")
            {
                e.Row.Cells[1].Text = Convert.ToDateTime(e.Row.Cells[1].Text).ToShortDateString();
            }
        }
    }
} 