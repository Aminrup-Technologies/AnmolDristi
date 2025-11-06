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
    public partial class KYT_DetailedView : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["ID"];
                if (!string.IsNullOrEmpty(id))
                {
                    LoadKYTData(id);
                }

            }
        }


        protected void gvKYTDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView dataItem = (DataRowView)e.Row.DataItem;

                HyperLink lnkCapa = (HyperLink)e.Row.FindControl("lnkCapa");
                if (lnkCapa != null)
                {
                    if (dataItem["CAPAID"] != DBNull.Value && !string.IsNullOrEmpty(dataItem["CAPAID"].ToString()))
                    {
                        string capaId = dataItem["CAPAID"].ToString();
                        string jobId = Request.QueryString["JobId"];  // 🔹 Current JobId

                        lnkCapa.Text = capaId;

                        string kytId = Request.QueryString["ID"]; 
                        lnkCapa.NavigateUrl = $"Universal_Capa.aspx?KYTID={kytId}&CAPAID={capaId}";

                    }
                    else
                    {
                        lnkCapa.Visible = false; // hide if no CAPA
                    }
                }
            }
        }


        private void LoadKYTData(string ID)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // ---- Table 1 (Header Info) ----
                SqlCommand cmd1 = new SqlCommand(@"
            SELECT 
                [ID],
                [KYT_WorksiteName],
                [KYT_Department],
                [KYT_Location],
                [KYT_Date],
                [KYT_JobID],
                [KYT_SOPNo],
                [KYT_Vendor]
            FROM [CSMS].[MahimaGupta_CSMS].[KYT_Table1]
            WHERE [ID] = @ID", conn);

                cmd1.Parameters.AddWithValue("@ID", ID);
                DataTable dt1 = new DataTable();
                new SqlDataAdapter(cmd1).Fill(dt1);

                gvKYTHeader.DataSource = dt1;
                gvKYTHeader.DataBind();

                // ---- Table 2 (Detail Info) ----
                SqlCommand cmd2 = new SqlCommand(@"
            SELECT 
                [KYT_Activity],
                [KYT_HiddenHazards],
                [KYT_Consequence],
                [KYT_CounterMeasures],
                [KYT_PriorityValue],
                [KYT_PhotographPath],
                [SubmissionDate],
                [SubmissionTime],
                [CAPAID]
            FROM [CSMS].[MahimaGupta_CSMS].[KYT_Table2]
            WHERE [ID] = @ID", conn);

                cmd2.Parameters.AddWithValue("@ID", ID);
                DataTable dt2 = new DataTable();
                new SqlDataAdapter(cmd2).Fill(dt2);

                gvKYTDetails.DataSource = dt2;
                gvKYTDetails.DataBind();
            }
        }


    }
}
