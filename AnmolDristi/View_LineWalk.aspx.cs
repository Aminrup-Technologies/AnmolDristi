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

                    string photoFileName = dr["Photo"] != DBNull.Value ? dr["Photo"].ToString() : null;

                    if (!string.IsNullOrEmpty(photoFileName))
                    {
                        jobimg.ImageUrl = "~/Uploads/" + photoFileName;
                        jobimg.Visible = true;
                    }
                    else
                    {
                        jobimg.Visible = false;
                    }

                    Auditby.Text = dr["Audit_By"].ToString();
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
                Snap_File_Path,
              ImmediateAction_Attachment,
              Status
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

        protected void ObservGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Hide Snap image if Snap_File_Path is empty
                Image imgSnap = (Image)e.Row.FindControl("imgSnap");
                string snapPath = DataBinder.Eval(e.Row.DataItem, "Snap_File_Path") as string;
                if (string.IsNullOrEmpty(snapPath) && imgSnap != null)
                {
                    imgSnap.Visible = false;
                }

                // Hide Immediate Action Attachment image if path is empty
                Image imgAttach = (Image)e.Row.FindControl("imgImmediateAttachment");
                string attachPath = DataBinder.Eval(e.Row.DataItem, "ImmediateAction_Attachment") as string;
                if (string.IsNullOrEmpty(attachPath) && imgAttach != null)
                {
                    imgAttach.Visible = false;
                }


                //  for coloring the status label as advised in meeting
                Label lblStatus = (Label)e.Row.FindControl("lblStatus");
                if (lblStatus != null)
                {
                    string status = lblStatus.Text.Trim().ToLower();
                    switch (status)
                    {
                        case "open":
                            lblStatus.ForeColor = System.Drawing.Color.Green;
                            break;
                        case "pending":
                            lblStatus.ForeColor = System.Drawing.Color.Red;
                            break;
                        case "in Progress":
                            lblStatus.ForeColor = System.Drawing.Color.Orange;
                            break;
                        default:
                            lblStatus.ForeColor = System.Drawing.Color.Gray;
                            break;
                    }
                }
            }
        }
    }
}