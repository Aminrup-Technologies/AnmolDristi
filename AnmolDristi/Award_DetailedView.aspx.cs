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
    public partial class Award_DetailedView : System.Web.UI.Page
    {
        
        // Connection string from Web.config
        string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Read ID from query string
                string adrId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(adrId))
                {
                    BindAwardDetails(adrId);
                }
            }
        }

        private void BindAwardDetails(string adrId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT 
                        a.DateOfAwardDistribution,
                        a.EventName,
                        a.EmpId,
                        a.EmpName,
                        a.Designation,
                        a.Award_ID,
                        a.SubmittedDate,
                        a.SubmittedTime,
                        a.ImagePath,
                        ac.AwardDescription
                    FROM AwardDistributionDetails a
                    LEFT JOIN AwardCategoryDescription ac
                        ON a.Award_ID = ac.Award_ID
                    WHERE a.ADR_ID = @ADR_ID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ADR_ID", adrId);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        gvAwardDetails.DataSource = dt;
                        gvAwardDetails.DataBind();
                    }
                }
            }
        }
    }
}
