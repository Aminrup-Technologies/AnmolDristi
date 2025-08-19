using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class DandBowDetailedView : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];

                if (!string.IsNullOrEmpty(id))
                {
                    LoadDBowChecklist(id);
                    LoadChainPulleyChecklist(id);
                    LoadBasicDetailsChecklist(id);
                }
            }
        }

        private void LoadDBowChecklist(string headerId)
        {
            string query = "SELECT Question, IsYes, CAPA_ID, Remarks, PhotoPath, CreatedDate " +
                           "FROM CSMS.MahimaGupta_CSMS.ShacklesChecklist_DBow WHERE HeaderID = @HeaderID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvDBow.DataSource = dt;
                    gvDBow.DataBind();
                }
            }
        }

        private void LoadChainPulleyChecklist(string headerId)
        {
            string query = "SELECT Question, IsYes, CAPA_ID, Remarks, PhotoPath, CreatedDate " +
                           "FROM CSMS.MahimaGupta_CSMS.ShacklesChecklist_ChainPulley WHERE HeaderID = @HeaderID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvChainPulley.DataSource = dt;
                    gvChainPulley.DataBind();
                }
            }
        }
        protected void gvDBow_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var dataItem = (DataRowView)e.Row.DataItem;

                // CAPA hyperlink
                HyperLink lnkCapa = (HyperLink)e.Row.FindControl("lnkCapa");
                if (lnkCapa != null)
                {
                    bool isYes = dataItem["IsYes"] != DBNull.Value && Convert.ToBoolean(dataItem["IsYes"]);
                    if (!isYes && dataItem["CAPA_ID"] != DBNull.Value)
                    {
                        lnkCapa.Text = dataItem["CAPA_ID"].ToString();
                        lnkCapa.NavigateUrl = "Universal_Capa.aspx?CAPA_ID=" + dataItem["CAPA_ID"].ToString();
                        lnkCapa.Visible = true;
                    }
                    else
                    {
                        lnkCapa.Visible = false;
                    }
                }
            }
        }

        protected void gvChainPulley_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var dataItem = (DataRowView)e.Row.DataItem;

                HyperLink lnkCapa = (HyperLink)e.Row.FindControl("lnkCapa");
                if (lnkCapa != null)
                {
                    bool isYes = dataItem["IsYes"] != DBNull.Value && Convert.ToBoolean(dataItem["IsYes"]);
                    if (!isYes && dataItem["CAPA_ID"] != DBNull.Value)
                    {
                        lnkCapa.Text = dataItem["CAPA_ID"].ToString();
                        lnkCapa.NavigateUrl = "Universal_Capa.aspx?CAPA_ID=" + dataItem["CAPA_ID"].ToString();
                        lnkCapa.Visible = true;
                    }
                    else
                    {
                        lnkCapa.Visible = false;
                    }
                }
            }
        }

        private void LoadBasicDetailsChecklist(string id)
        {
            string query = "SELECT Site, TagNo, InspectionDate, Remarks, JobID, JobName FROM CSMS.MahimaGupta_CSMS.ShacklesChecklist_BasicDetails WHERE BasicID = @ID";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ID", id);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvBasicDetails.DataSource = dt;
                    gvBasicDetails.DataBind();
                }
            }
        }


    }
}
