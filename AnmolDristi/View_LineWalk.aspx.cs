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
    public partial class View_LineWalk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(id))
                {
                    GetData(Convert.ToInt32(id));
                }
            }
        }

        private void GetData(int id)
        {
            string cs = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
            using (SqlConnection con  = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Line_walk_status WHERE ID = @ID", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("@ID", id);
                DataTable dt = new DataTable();
                dt.Clear();
                da.Fill(dt);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if(dr.Read())
                {
                    date.Text = Convert.ToDateTime(dr["WalkDate"]).ToString("yyyy-MM-dd");
                    jobid.Text = dr["JobID"].ToString();
                    jobdesc.Text = dr["JobDescription"].ToString() ;
                }
                dr.Close();
                con.Close();

                SqlCommand tmCmd = new SqlCommand(@"
                SELECT 
TM_names,TM_Code,TM_Type
                FROM Line_walk_status_description 
                WHERE ID = @WalkID", con);
                tmCmd.Parameters.AddWithValue("@WalkID", id);

                SqlDataAdapter tmDa = new SqlDataAdapter(tmCmd);
                DataTable tmDt = new DataTable();
                tmDa.Fill(tmDt);

                TeamMemberGrid.DataSource = tmDt;
                TeamMemberGrid.DataBind();

                SqlCommand obsCmd = new SqlCommand(@"
            SELECT 
                Location, 
                Observation_Points, 
                Recommendation_Points, 
                Responsibility, 
                Target_Date, 
                Remarks, 
                Snap_File_Path 
            FROM Line_walk_details 
            WHERE ID = @WalkID", con);
                obsCmd.Parameters.AddWithValue("@WalkID", id);

                SqlDataAdapter obsDa = new SqlDataAdapter(obsCmd);
                DataTable obsDt = new DataTable();
                obsDa.Fill(obsDt);

                ObservGrid.DataSource = obsDt;
                ObservGrid.DataBind();



            }
        }
    }
}