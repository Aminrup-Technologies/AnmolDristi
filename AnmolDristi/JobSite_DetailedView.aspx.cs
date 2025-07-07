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
                string headerId = Request.QueryString["HeaderID"]; // CHANGED: treat as string

                if (!string.IsNullOrEmpty(headerId))
                {
                    LoadHeaderInfo(headerId);
                    LoadChecklistDetails(headerId);
                }
                else
                {
                    Response.Write("<div style='color:red;'>HeaderID parameter is missing or invalid in the URL.</div>");
                }
            }
        }


        private void LoadChecklistDetails(string headerId) // CHANGED: string type
        {
            string query = @"SELECT Question, IsYes, Remarks, PhotoPath
                             FROM MahimaGupta_CSMS.JobSiteChecklistDetails
                             WHERE HeaderID = @HeaderID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@HeaderID", SqlDbType.VarChar).Value = headerId;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvChecklistDetails.DataSource = dt;
                    gvChecklistDetails.DataBind();
                }
            }
        }

        private void LoadHeaderInfo(string headerId) // CHANGED: string type
        {
            string query = @"SELECT ChecklistDate, Area, CreatedAt 
                             FROM MahimaGupta_CSMS.JobSiteHeader
                             WHERE HeaderID = @HeaderID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@HeaderID", SqlDbType.VarChar).Value = headerId;
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