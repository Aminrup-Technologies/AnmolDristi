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
    public partial class JobSite_DetailedView : System.Web.UI.Page
    {
       
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int headerId = 0;
                if (Request.QueryString["headerId"] != null)
                {
                    int.TryParse(Request.QueryString["headerId"], out headerId);
                }

                LoadChecklistDetails(headerId);
                LoadHeaderInfo(headerId);
            }
        }

        private void LoadChecklistDetails(int headerId)
        {
            string query = @"SELECT Question, IsYes, Remarks, PhotoPath
                             FROM MahimaGupta_CSMS.JobSiteChecklistDetails
                             WHERE HeaderID = @HeaderID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvChecklistDetails.DataSource = dt;
                    gvChecklistDetails.DataBind();
                }
            }
        }

        private void LoadHeaderInfo(int headerId)
        {
            string query = @"SELECT ChecklistDate, Area, CreatedAt 
                     FROM MahimaGupta_CSMS.JobSiteHeader
                     WHERE HeaderID = @HeaderID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvHeader.DataSource = dt;
                    gvHeader.DataBind();
                }
            }
        }

    
}
}
