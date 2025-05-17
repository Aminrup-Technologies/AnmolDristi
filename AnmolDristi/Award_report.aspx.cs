using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


namespace AnmolDristi
{
    public partial class Award_report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblDate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                BindAwardDetails();
            }
        }

        private void BindAwardDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT 
                        ROW_NUMBER() OVER (ORDER BY SubmittedDate, SubmittedTime) AS SerialNo,
                        EmpName,
                        Designation,
                        (SELECT AwardDescription FROM AwardCategoryDescription WHERE Award_ID = a.Award_ID) AS AwardCategory,
                        EventName,
                        ImagePath
                    FROM AwardDistributionDetails a
                ";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    conn.Open();
                    da.Fill(dt);
                    rptAwardDetails.DataSource = dt;
                    rptAwardDetails.DataBind();
                }
            }
        }
    }
}