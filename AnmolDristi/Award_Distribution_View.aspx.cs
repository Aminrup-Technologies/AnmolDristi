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
    public partial class Award_Distribution_View : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Bind the GridView with award distribution data
                BindGrid();
            }
        }
  

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM AwardDistributionDetails", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GvAwards.DataSource = dt;
                GvAwards.DataBind();
            }
        }

        protected void GvAwards_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // Set the row to edit mode
            GvAwards.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void GvAwards_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // Cancel edit mode and rebind the GridView
            GvAwards.EditIndex = -1;
            BindGrid();
        }

        protected void GvAwards_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Get the ID of the row being edited
       //     int ADR_ID = Convert.ToInt32(GvAwards.DataKeys[e.RowIndex].Value);



            int ADR_ID = 0;
var rawKey = GvAwards.DataKeys[e.RowIndex].Value?.ToString();
if (!int.TryParse(rawKey, out ADR_ID))
{
    // Handle error gracefully (e.g., show message or return early)
    return;
}

            // Get the new values entered in the edit row
            TextBox txtEventName = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtEventName");
            TextBox txtEmpId = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtEmpId");
            TextBox txtEmpName = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtEmpName");
            TextBox txtDesignation = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtDesignation");
            TextBox txtAward_ID = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtAward_ID");
            TextBox txtSubmittedDate = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtSubmittedDate");
            TextBox txtSubmittedTime = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtSubmittedTime");
            TextBox txtImagePath = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtImagePath");

            // Update the database with the new values
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE AwardDistributionDetails SET EventName = @EventName, EmpId = @EmpId, EmpName = @EmpName, Designation = @Designation, Award_ID = @Award_ID, SubmittedDate = @SubmittedDate, SubmittedTime = @SubmittedTime, ImagePath = @ImagePath WHERE ADR_ID = @ADR_ID", con);
                cmd.Parameters.AddWithValue("@EventName", txtEventName.Text);
                cmd.Parameters.AddWithValue("@EmpId", txtEmpId.Text);
                cmd.Parameters.AddWithValue("@EmpName", txtEmpName.Text);
                cmd.Parameters.AddWithValue("@Designation", txtDesignation.Text);
                cmd.Parameters.AddWithValue("@Award_ID", txtAward_ID.Text);
                cmd.Parameters.AddWithValue("@SubmittedDate", txtSubmittedDate.Text);
                cmd.Parameters.AddWithValue("@SubmittedTime", txtSubmittedTime.Text);
                cmd.Parameters.AddWithValue("@ImagePath", txtImagePath.Text);
                cmd.Parameters.AddWithValue("@ADR_ID", ADR_ID);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            // Exit edit mode and refresh the GridView
            GvAwards.EditIndex = -1;
            BindGrid();
        }

        //protected void GvAwards_RowDeleting(object sender, GridViewDeleteEventArgs e)
        //{
        //    // Get the ID of the row to delete
        //    int ADR_ID = Convert.ToInt32(GvAwards.DataKeys[e.RowIndex].Value);

        //    // Delete the record from the database
        //    using (SqlConnection con = new SqlConnection(connectionString))
        //    {
        //        SqlCommand cmd = new SqlCommand("DELETE FROM AwardDistributionDetails WHERE ADR_ID = @ADR_ID", con);
        //        cmd.Parameters.AddWithValue("@ADR_ID", ADR_ID);

        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //        con.Close();
        //    }

        //    // Refresh the GridView after deletion
        //    BindGrid();


        protected void GvAwards_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Try to parse the key safely
            int ADR_ID = 0;
            var rawKey = GvAwards.DataKeys[e.RowIndex].Value?.ToString();
            if (!int.TryParse(rawKey, out ADR_ID))
            {
                // Log error or alert user
                return;
            }

            // Delete the record from the database
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM AwardDistributionDetails WHERE ADR_ID = @ADR_ID", con);
                cmd.Parameters.AddWithValue("@ADR_ID", ADR_ID);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            // Refresh the GridView after deletion
            BindGrid();
        }

    
}
}
