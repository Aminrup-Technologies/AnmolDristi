using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Line_walk_report : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLineWalkSummary(); // Load summary data on initial page load
            }
        }

        private void LoadLineWalkSummary()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT ID, WalkDate, JobDescription, JobID, time_stamp FROM Line_walk_status", con)) // Adjust table/columns as needed
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridViewLineWalk.DataSource = dt;
                    GridViewLineWalk.DataBind();
                }
            }
        }

        protected void GridViewLineWalk_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    // Load Team Members
                    using (SqlCommand cmd = new SqlCommand("SELECT TM_names, TM_Image FROM Line_walk_status_description WHERE WalkID = @WalkID", con))
                    {
                        cmd.Parameters.AddWithValue("@WalkID", id);
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GridViewTeamMembers.DataSource = dt;
                        GridViewTeamMembers.DataBind();
                    }

                    // Load Walk Details
                    using (SqlCommand cmd = new SqlCommand("SELECT Location, Observation_Points, Recommendation_Points, Responsibility, Target_Date, Remarks, Snap_File_Path FROM Line_walk_details WHERE WalkID = @WalkID", con))
                    {
                        cmd.Parameters.AddWithValue("@WalkID", id);
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GridViewWalkDetails.DataSource = dt;
                        GridViewWalkDetails.DataBind();
                    }

                    pnlDetails.Visible = true;
                }
            }
        }
    }
}
