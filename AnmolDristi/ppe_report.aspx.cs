using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class ppe_report : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPPERecords(); // Fetch data on initial page load
            }
        }

        private void LoadPPERecords()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"SELECT id, inspection_by, Submitted_date, worker_id, worker_name, designation 
                                 FROM Workers_PPE_Checklist 
                                ORDER BY Submitted_date DESC"; // Fetching data directly from the table

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                    else
                    {
                        GridView1.DataSource = null;
                        GridView1.DataBind();
                    }
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewMore")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("csm_ppechecklist_detailed.aspx?id=" + id); // Redirecting to details page
            }
        }
    }
}






