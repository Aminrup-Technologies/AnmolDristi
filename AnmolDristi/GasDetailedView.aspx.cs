using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class GasDetailedView : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string headerId = Request.QueryString["HeaderID"];
                if (!string.IsNullOrEmpty(headerId))
                {
                    BindGasHeader(headerId);
                    BindGasChecklist(headerId);
                }
            }
        }

        private void BindGasHeader(string headerId)
        {
            string query = @"SELECT SiteName, InspectionDate, TagNo, SubmittedDate, SubmittedTime, GasCutterName, JobID 
                             FROM [CSMS].[MahimaGupta_CSMS].[GasCutting_Header] 
                             WHERE HeaderID = @HeaderID";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerId);
                conn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvGasHeader.DataSource = dt;
                    gvGasHeader.DataBind();
                }
            }
        }

        private void BindGasChecklist(string headerId)
        {
            string query = @"SELECT Question, IsYes, CAPA_ID, Remarks, PhotoPath, FinalRemarks 
                     FROM [CSMS].[MahimaGupta_CSMS].[GasCutting_Checklist] 
                     WHERE HeaderID = @HeaderID";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerId);
                conn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvGasChecklist.DataSource = dt;
                    gvGasChecklist.DataBind();
                }
            }
        }

        protected void gvGasChecklist_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var dataItem = (DataRowView)e.Row.DataItem;

                // ✅ Handle IsYes tick/cross
                bool isYes = dataItem["IsYes"] != DBNull.Value && Convert.ToBoolean(dataItem["IsYes"]);
                Literal lit = (Literal)e.Row.FindControl("litIsYes");
                if (lit != null)
                {
                    lit.Text = isYes
                        ? "<span class='tick'>&#10004;</span>"
                        : "<span class='cross'>&#10008;</span>";
                }

                // ✅ Handle CAPA hyperlink visibility
                HyperLink lnkCapa = (HyperLink)e.Row.FindControl("lnkCapa");
                if (lnkCapa != null)
                {
                    if (!isYes && dataItem["CAPA_ID"] != DBNull.Value)
                    {
                        lnkCapa.Text = dataItem["CAPA_ID"].ToString();
                        lnkCapa.NavigateUrl = "Universal_Capa.aspx?CAPA_ID=" + dataItem["CAPA_ID"].ToString();
                        lnkCapa.Visible = true;
                    }
                    else
                    {
                        lnkCapa.Visible = false; // hide if Yes or NULL
                    }
                }

                // ✅ Handle Photo
                Image img = (Image)e.Row.FindControl("imgPhoto");
                if (img != null)
                {
                    string path = dataItem["PhotoPath"].ToString();
                    img.Visible = !string.IsNullOrEmpty(path);
                    if (img.Visible)
                        img.ImageUrl = ResolveUrl(path);
                }
            }
        }
    }
}