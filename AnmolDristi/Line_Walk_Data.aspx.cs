using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Line_Walk_Data : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Line_walk_status order by ID desc", conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                View.DataSource = dt;
                View.DataBind();
            }
        }


        protected void View_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteWalk")
            {
                int walkId = Convert.ToInt32(e.CommandArgument);

                string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(cs))
                {
                    conn.Open();

                    SqlCommand deleteMain = new SqlCommand("DELETE FROM Line_walk_status WHERE ID = @ID", conn);
                    deleteMain.Parameters.AddWithValue("@ID", walkId);
                    deleteMain.ExecuteNonQuery();
                }

                string Data_SuccessScript = @"<script type='text/javascript'>
            new PNotify({
                title: 'Success',
                text: 'Walk record deleted successfully!',
                type: 'success',
                styling: 'bootstrap3'
            });
        </script>";

                ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);

                LoadData();
            }
        }


        protected void LoadFilterData(string status, string fromDate, string toDate)
        {
            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using(SqlConnection con = new SqlConnection(cs))
            {
                    string query = @"
                SELECT DISTINCT s.ID, s.WalkDate, s.JobDescription, s.JobID
                FROM Line_walk_status s
                INNER JOIN Line_walk_details d ON s.ID = d.ID
                WHERE 1 = 1
                    AND (@Status = '' OR d.Status = @Status)
                    AND (@FromDate = '' OR CAST(s.WalkDate AS DATE) >= @FromDate)
                    AND (@ToDate = '' OR CAST(s.WalkDate AS DATE) <= @ToDate)
                ORDER BY s.ID DESC";

                    SqlCommand cmd = new SqlCommand(query,con);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@FromDate", string.IsNullOrEmpty(fromDate) ? "" : fromDate);
                    cmd.Parameters.AddWithValue("@ToDate", string.IsNullOrEmpty(toDate) ? "" : toDate);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    View.DataSource = dt;
                    View.DataBind();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string selectedStatus = ddlStatus.SelectedValue;
            string fromDate = txtFromDate.Text;
            string toDate = txtToDate.Text;

            LoadFilterData(selectedStatus, fromDate, toDate);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedIndex = 0;        
            txtFromDate.Text = "";              
            txtToDate.Text = "";                

           LoadData();
        }

    }
}
