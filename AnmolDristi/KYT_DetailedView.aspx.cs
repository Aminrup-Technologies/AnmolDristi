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

                SqlCommand cmd = new SqlCommand(@"
                            SELECT 
                                t1.KYT_WorksiteName,
                                t1.KYT_Department,
                                t1.KYT_Location,
                                t1.KYT_Date,
                                t1.KYT_JobID,
                                t1.KYT_SOPNo,
                                t1.KYT_Vendor,
                                t2.KYT_Activity,
                                t2.KYT_HiddenHazards,
                                t2.KYT_Consequence,
                                t2.KYT_CounterMeasures,
                                t2.KYT_PriorityValue,
                                t2.KYT_PhotographPath,
                                t2.SubmissionDate,
                                t2.SubmissionTime,
                                t2.CAPAID
                            FROM [MahimaGupta_CSMS].[KYT_Table1] t1
                            INNER JOIN [MahimaGupta_CSMS].[KYT_Table2] t2 
                                ON t1.ID = t2.ID     
                            WHERE t1.ID = @ID", conn);



                cmd.Parameters.AddWithValue("@ID", ID);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvKYTDetails.DataSource = dt;
                gvKYTDetails.DataBind();
            }
        }
    }
}
