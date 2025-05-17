using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;




namespace AnmolDristi
{
    public partial class D_and_Bow_View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDandBowChecklistDetails();
            }
        }

        private void LoadDandBowChecklistDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                    SELECT
                        h.Id AS BasicID, h.Site, h.TagNo, h.InspectionDate,

                        sd.Question AS ShacklesChecklistQuestion, 
                        sd.IsYes AS ShacklesIsYes, 
                        sd.Remarks AS ShacklesRemarks, 
                        sd.PhotoPath AS ShacklesPhotoPath,

                        cd.Question AS ChainPulleyChecklistQuestion,
                        cd.IsYes AS ChainPulleyIsYes,
                        cd.Remarks AS ChainPulleyRemarks,
                        cd.PhotoPath AS ChainPulleyPhotoPath

                    FROM MahimaGupta_CSMS.ShacklesChecklist_BasicDetails h
                    LEFT JOIN MahimaGupta_CSMS.ShacklesChecklist_DBow sd ON h.Id = sd.HeaderID
                    LEFT JOIN MahimaGupta_CSMS.ShacklesChecklist_ChainPulley cd ON h.Id = cd.HeaderID

                    ORDER BY h.Id DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GvDandBowChecklist.DataSource = dt;
                        GvDandBowChecklist.DataBind();
                    }
                }
            }
        }

        protected void GvDandBowChecklist_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GvDandBowChecklist.EditIndex = e.NewEditIndex;
            LoadDandBowChecklistDetails();
        }

        protected void GvDandBowChecklist_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GvDandBowChecklist.EditIndex = -1;
            LoadDandBowChecklistDetails();
        }

        protected void GvDandBowChecklist_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(GvDandBowChecklist.DataKeys[e.RowIndex].Value);
            GridViewRow row = GvDandBowChecklist.Rows[e.RowIndex];

            string site = ((TextBox)row.Cells[0].Controls[0]).Text;
            string dateString = ((TextBox)row.Cells[1].Controls[0]).Text;
            string tagNo = ((TextBox)row.Cells[2].Controls[0]).Text;

            DateTime date;
            bool validDate = DateTime.TryParse(dateString, out date) &&
                             date >= (DateTime)System.Data.SqlTypes.SqlDateTime.MinValue &&
                             date <= (DateTime)System.Data.SqlTypes.SqlDateTime.MaxValue;

            if (!validDate)
            {
                // Optional: Show error to user or assign a default
                // For now, we stop execution
                // You can use a label or script alert to show message
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string updateQuery = @"
            UPDATE DandBow_Header
            SET Site = @Site, InspectionDate = @InspectionDate, TagNo = @TagNo
            WHERE Id = @BasicID";

                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@BasicID", id);
                    cmd.Parameters.AddWithValue("@Site", site);
                    cmd.Parameters.AddWithValue("@InspectionDate", date);
                    cmd.Parameters.AddWithValue("@TagNo", tagNo);

                    cmd.ExecuteNonQuery();
                }
            }

            GvDandBowChecklist.EditIndex = -1;
            LoadDandBowChecklistDetails();
        }

        protected void GvDandBowChecklist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GvDandBowChecklist.DataKeys[e.RowIndex].Value);

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(@"
            DELETE FROM MahimaGupta_CSMS.ShacklesChecklist_DBow WHERE HeaderID = @BasicID;
            DELETE FROM MahimaGupta_CSMS.ShacklesChecklist_ChainPulley WHERE HeaderID = @BasicID;
            DELETE FROM MahimaGupta_CSMS.ShacklesChecklist_BasicDetails WHERE Id = @BasicID;", conn))
                {
                    cmd.Parameters.AddWithValue("@BasicID", id);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadDandBowChecklistDetails();
        }

    }
}