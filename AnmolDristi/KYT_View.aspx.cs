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
    public partial class KYT_View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadKYTIncidentDetails();
            }
        }

        private void LoadKYTIncidentDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                SELECT 
                    kyt.ID, kyt.KYT_WorksiteName, kyt.KYT_Department, kyt.KYT_Location, kyt.KYT_Date, kyt.KYT_JobID, 
                    kyt.KYT_Activity, kyt.KYT_SOPNo, kyt.KYT_Vendor,
                    hkyt.KYT_HiddenHazards, hkyt.KYT_Consequence, hkyt.KYT_CounterMeasures, 
                    hkyt.KYT_PriorityValue
                FROM KYT_Table1 kyt
                LEFT JOIN KYT_Table2 hkyt ON kyt.ID = hkyt.ID
                ORDER BY kyt.ID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GvKYTRecords.DataSource = dt;
                        GvKYTRecords.DataBind();
                    }
                }
            }
        }

        protected void GvKYTRecords_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GvKYTRecords.EditIndex = e.NewEditIndex;
            LoadKYTIncidentDetails();
        }

        protected void GvKYTRecords_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GvKYTRecords.EditIndex = -1;
            LoadKYTIncidentDetails();
        }

        protected void GvKYTRecords_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int kytID = Convert.ToInt32(GvKYTRecords.DataKeys[e.RowIndex].Value);
            GridViewRow row = GvKYTRecords.Rows[e.RowIndex];

            string worksite = ((TextBox)row.Cells[0].Controls[0]).Text;
            string department = ((TextBox)row.Cells[1].Controls[0]).Text;
            string location = ((TextBox)row.Cells[2].Controls[0]).Text;
            string jobID = ((TextBox)row.Cells[4].Controls[0]).Text;

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string updateQuery = @"
                UPDATE KYT_Table1 
                SET KYT_WorksiteName = @Worksite, KYT_Department = @Department, KYT_Location = @Location, KYT_JobID = @JobID 
                WHERE ID = @ID";

                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", kytID);
                    cmd.Parameters.AddWithValue("@Worksite", worksite);
                    cmd.Parameters.AddWithValue("@Department", department);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Parameters.AddWithValue("@JobID", jobID);

                    cmd.ExecuteNonQuery();
                }
            }

            GvKYTRecords.EditIndex = -1;
            LoadKYTIncidentDetails();
        }

        protected void GvKYTRecords_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int kytID = Convert.ToInt32(GvKYTRecords.DataKeys[e.RowIndex].Value);
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM KYT_Table2 WHERE ID = @ID; DELETE FROM KYT_Table1 WHERE ID = @ID;", conn))
                {
                    cmd.Parameters.AddWithValue("@ID", kytID);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadKYTIncidentDetails();
        }
    }
}
