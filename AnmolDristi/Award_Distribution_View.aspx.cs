using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                string query = @"
            SELECT 
                h.Award_ID,
                h.DateOfAwardDistribution,
                h.EventName,
                d.EmpId,
                d.EmpName,
                d.Designation,
                d.AwardCategory,
                d.Award_ID AS DetailAwardID,
                d.ImagePath,
                d.ADR_ID
            FROM AwardDistributionHeader h
            INNER JOIN AwardDistributionDetails d
                ON h.Award_ID = d.Award_ID";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
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
            try
            {

                int ADR_ID = 0;
                var rawKey = GvAwards.DataKeys[e.RowIndex].Values["ADR_ID"]?.ToString();
                if (!int.TryParse(rawKey, out ADR_ID))
                    return;


                int Award_ID = 0;
                var headerKey = GvAwards.DataKeys[e.RowIndex].Values["Award_ID"]?.ToString();
                if (!int.TryParse(headerKey, out Award_ID))
                    return;


                TextBox txtDateOfAwardDistribution = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtDateOfAwardDistribution");
                TextBox txtEventName = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtEventName");
                TextBox txtEmpId = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtEmpId");
                TextBox txtEmpName = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtEmpName");
                TextBox txtDesignation = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtDesignation");
                DropDownList ddlEditAwardCategory = (DropDownList)GvAwards.Rows[e.RowIndex].FindControl("ddlEditAwardCategory");
                TextBox txtImagePath = (TextBox)GvAwards.Rows[e.RowIndex].FindControl("txtImagePath");

                string awardCategory = ddlEditAwardCategory.SelectedItem.Text;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();


                    using (SqlCommand cmdHeader = new SqlCommand(
                        @"UPDATE AwardDistributionHeader 
      SET EventName = @EventName,
          DateOfAwardDistribution = @DateOfAwardDistribution
      WHERE Award_ID = @Award_ID", con))
                    {
                        cmdHeader.Parameters.AddWithValue("@EventName", txtEventName.Text);


                        DateTime awardDate;
                        if (DateTime.TryParse(txtDateOfAwardDistribution.Text, out awardDate))
                            cmdHeader.Parameters.AddWithValue("@DateOfAwardDistribution", awardDate);
                        else
                            cmdHeader.Parameters.AddWithValue("@DateOfAwardDistribution", DBNull.Value);

                        cmdHeader.Parameters.AddWithValue("@Award_ID", Award_ID);
                        cmdHeader.ExecuteNonQuery();
                    }


                    using (SqlCommand cmdDetail = new SqlCommand(
                        @"UPDATE AwardDistributionDetails
              SET EmpId = @EmpId,
                  EmpName = @EmpName,
                  Designation = @Designation,
                  Award_ID = @Award_ID,
                  ImagePath = @ImagePath,
                  AwardCategory = @AwardCategory
              WHERE ADR_ID = @ADR_ID", con))
                    {
                        cmdDetail.Parameters.AddWithValue("@EmpId", txtEmpId.Text);
                        cmdDetail.Parameters.AddWithValue("@EmpName", txtEmpName.Text);
                        cmdDetail.Parameters.AddWithValue("@Designation", txtDesignation.Text);
                        cmdDetail.Parameters.AddWithValue("@Award_ID", Award_ID);
                        cmdDetail.Parameters.AddWithValue("@ImagePath", txtImagePath.Text);
                        cmdDetail.Parameters.AddWithValue("@AwardCategory", awardCategory);
                        cmdDetail.Parameters.AddWithValue("@ADR_ID", ADR_ID);

                        cmdDetail.ExecuteNonQuery();
                    }
                }


                GvAwards.EditIndex = -1;
                BindGrid();
                //  success
                ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-success", @"
                        new PNotify({
                            title: 'Update Successful',
                            text: 'Form updated successfully.',
                            type: 'success',
                            styling: 'bootstrap3',
                            delay: 2500
                        });
                    ", true);
            }
            catch (Exception ex)
            {
              
                ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-error", $@"
                    new PNotify({{
                        title: 'Update Failed',
                        text: 'Error: {ex.Message}',
                        type: 'error',
                        styling: 'bootstrap3',
                        delay: 3000
                    }});
                ", true);
            }
        }


        protected void GvAwards_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            int ADR_ID = 0;
            var rawKey = GvAwards.DataKeys[e.RowIndex].Value?.ToString();
            if (!int.TryParse(rawKey, out ADR_ID))
            {

                return;
            }


            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM AwardDistributionDetails WHERE ADR_ID = @ADR_ID", con);
                cmd.Parameters.AddWithValue("@ADR_ID", ADR_ID);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            BindGrid();
        }


    }
}
