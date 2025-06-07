using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace AnmolDristi
{
    public partial class DandBowDetailedView : System.Web.UI.Page
    {
        // Use your connection string name exactly as in your Web.config
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Optionally get an ID from querystring if you want to filter
                int id = 0;
                if (Request.QueryString["id"] != null)
                {
                    int.TryParse(Request.QueryString["id"], out id);
                }

                LoadChainPulleyChecklist(id);
                LoadDBowChecklist(id);
                LoadBasicDetailsChecklist(id);
            }
        }

        private void LoadChainPulleyChecklist(int id)
        {
            string query = "SELECT Question, IsYes, Remarks, PhotoPath, CreatedDate FROM CSMS.MahimaGupta_CSMS.ShacklesChecklist_ChainPulley";
            if (id > 0) query += " WHERE ID = @ID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (id > 0) cmd.Parameters.AddWithValue("@ID", id);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvChainPulley.DataSource = dt;
                    gvChainPulley.DataBind();
                }
            }
        }

        private void LoadDBowChecklist(int id)
        {
            string query = "SELECT Question, IsYes, Remarks, PhotoPath, CreatedDate FROM CSMS.MahimaGupta_CSMS.ShacklesChecklist_DBow";
            if (id > 0) query += " WHERE ID = @ID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (id > 0) cmd.Parameters.AddWithValue("@ID", id);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvDBow.DataSource = dt;
                    gvDBow.DataBind();
                }
            }
        }

        private void LoadBasicDetailsChecklist(int id)
        {
            string query = "SELECT Site, TagNo, InspectionDate, Remarks, JobID, JobName FROM CSMS.MahimaGupta_CSMS.ShacklesChecklist_BasicDetails";
            if (id > 0) query += " WHERE ID = @ID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (id > 0) cmd.Parameters.AddWithValue("@ID", id);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvBasicDetails.DataSource = dt;
                    gvBasicDetails.DataBind();
                }
            }
        }
    }
}
