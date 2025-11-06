using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Award_DetailedView : System.Web.UI.Page
    {

        string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string awardId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(awardId))
                {
                    BindHeaderRepeater(awardId);
                }
            }
        }

        private void BindHeaderRepeater(string awardId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
SELECT 
    h.Award_ID,
    h.DateOfAwardDistribution,
    h.EventName,
    h.SubmittedDate,
    h.SubmittedTime
FROM AwardDistributionHeader h
WHERE h.Award_ID = @Award_ID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Award_ID", awardId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dtHeader = new DataTable();
                da.Fill(dtHeader);

                // Build a nested structure
                var dataList = new List<object>();
                foreach (DataRow row in dtHeader.Rows)
                {
                    string currentAwardId = row["Award_ID"].ToString();


                    // Get awardee details for this Award_ID
                    SqlDataAdapter daDetails = new SqlDataAdapter(@"
                SELECT EmpId, EmpName, Designation, AwardCategory, ImagePath
                FROM AwardDistributionDetails
                WHERE Award_ID = @Award_ID", con);
                    daDetails.SelectCommand.Parameters.AddWithValue("@Award_ID", awardId);

                    DataTable dtDetails = new DataTable();
                    daDetails.Fill(dtDetails);

                    dataList.Add(new
                    {
                        Award_ID = row["Award_ID"],
                        DateOfAwardDistribution = row["DateOfAwardDistribution"],
                        EventName = row["EventName"],
                        SubmittedDate = row["SubmittedDate"],
                        SubmittedTime = row["SubmittedTime"],
                        Awardees = dtDetails
                    });
                }

                rptHeader.DataSource = dataList;
                rptHeader.DataBind();
            }


        }

        protected void rptHeader_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // Ensure we are dealing with a valid data item (not header/footer)
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Safely get the bound data (works for anonymous or DataRowView objects)
                dynamic headerData = e.Item.DataItem;

                // Find the nested Repeater inside the item template
                Repeater rptDetails = e.Item.FindControl("rptDetails") as Repeater;

                // Defensive check before binding
                if (rptDetails != null && headerData != null)
                {
                    try
                    {
                        // Access the child DataTable stored in "Awardees"
                        var awardeeTable = headerData.Awardees as DataTable;

                        // Only bind if we actually have rows
                        if (awardeeTable != null && awardeeTable.Rows.Count > 0)
                        {
                            rptDetails.DataSource = awardeeTable;
                            rptDetails.DataBind();
                        }
                    }
                    catch (Exception ex)
                    {
                        // Optional: log the error for debugging (no crash in production)
                        System.Diagnostics.Debug.WriteLine("Error binding rptDetails: " + ex.Message);
                    }
                }
            }
        }
    }
}
