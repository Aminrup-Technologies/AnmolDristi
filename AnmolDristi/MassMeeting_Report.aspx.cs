using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class MassMeeting_Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMeetings();
            }
        }
        private void LoadMeetings()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT 
                                 ID,
                                 MM_DocNo,
                                 CONVERT(VARCHAR(10), Meeting_Date, 23) AS Meeting_Date,
                                 SubmitterCode,
                                 DeptCode,
                                 ExactLocation,
                                 CompanyCode,
                                 Coordinator_Name
                                 FROM  csm_massmeting_records
                                 WHERE MM_Id is not null";



                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);


                    GVMeetings.DataSource = dt;
                    GVMeetings.DataBind();
                }
            }
        }
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {

        }
        protected void BtnReset_Click(object sender, EventArgs e)
        {

        }
        protected void BtnEdit_Click(object sender, EventArgs e)
        {

        }
        protected void BtnDelete_Click(object sender, EventArgs e)
        {

        }


    }
}