using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace AnmolDristi
{
    public partial class DandBowDetailedView : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int id = 0;
                if (Request.QueryString["id"] != null)
                {
                    int.TryParse(Request.QueryString["id"], out id);
                }
                LoadDBowChecklist(id);
                LoadChainPulleyChecklist(id);  // Using HeaderID
                   
                LoadBasicDetailsChecklist(id); // Using ID
            }
        }
        private void LoadDBowChecklist(int headerId)
        {
            string query = "SELECT Question, IsYes, Remarks, PhotoPath, CreatedDate FROM CSMS.MahimaGupta_CSMS.ShacklesChecklist_DBow WHERE HeaderID = @HeaderID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerId);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvDBow.DataSource = dt;
                    gvDBow.DataBind();
                }
            }
        }

        private void LoadChainPulleyChecklist(int headerId)
        {
            string query = "SELECT Question, IsYes, Remarks, PhotoPath, CreatedDate FROM CSMS.MahimaGupta_CSMS.ShacklesChecklist_ChainPulley WHERE HeaderID = @HeaderID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerId);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvChainPulley.DataSource = dt;
                    gvChainPulley.DataBind();
                }
            }
        }

        
        private void LoadBasicDetailsChecklist(int id)
        {
            string query = "SELECT Site, TagNo, InspectionDate, Remarks, JobID, JobName FROM CSMS.MahimaGupta_CSMS.ShacklesChecklist_BasicDetails WHERE Id = @ID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ID", id);

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
