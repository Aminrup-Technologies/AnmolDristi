using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class GrindingDetailedView : System.Web.UI.Page
    {
        // Store connection string once here
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string headerId = Request.QueryString["HeaderID"]; // CHANGED: treat as string directly
                if (!string.IsNullOrEmpty(headerId))
                {
                    BindGrindingHeader(headerId);
                    BindGrindingChecklist(headerId);
                }
                else
                {
                    Response.Write("<div style='color:red;'>HeaderID parameter is missing in the URL.</div>");
                }
            }
        }

        private void BindGrindingHeader(string headerId) // CHANGED: string instead of int
        {
            string query = @"
        SELECT Site, DateOfInspection, InspectedBy, SerialNo, IdentificationNumber, Location, Final_Remarks, JobID, JobName
        FROM [CSMS].[MahimaGupta_CSMS].[GrindingMachine_Header]
        WHERE HeaderID = @HeaderID";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@HeaderID", SqlDbType.VarChar).Value = headerId; // CHANGED: VarChar
                    conn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        if (dt.Rows.Count == 0)
                        {
                            Response.Write($"<div style='color:red;'>No Grinding Header data found for HeaderID = {headerId}</div>");
                        }
                        gvGrindingHeader.DataSource = dt;
                        gvGrindingHeader.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<div style='color:red;'>Error loading Grinding Header data: {ex.Message}</div>");
            }
        }

        private void BindGrindingChecklist(string headerId) // CHANGED: string instead of int
        {
            string query = @"
        SELECT Question, IsYes,CAPA_ID, Remarks, PhotoPath, EntryDate
        FROM [CSMS].[MahimaGupta_CSMS].[GrindingMachine_Checklist]
        WHERE HeaderID = @HeaderID";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@HeaderID", SqlDbType.VarChar).Value = headerId; // CHANGED: VarChar
                    conn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        if (dt.Rows.Count == 0)
                        {
                            Response.Write($"<div style='color:red;'>No Grinding Checklist data found for HeaderID = {headerId}</div>");
                        }
                        gvGrindingChecklist.DataSource = dt;
                        gvGrindingChecklist.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<div style='color:red;'>Error loading Grinding Checklist data: {ex.Message}</div>");
            }
        }

        protected void gvGrindingChecklist_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView dataItem = (DataRowView)e.Row.DataItem;

                // ✅ Handle IsYes (tick/cross)
                bool isYes = dataItem["IsYes"] != DBNull.Value && Convert.ToBoolean(dataItem["IsYes"]);
                Literal lit = (Literal)e.Row.FindControl("litIsYes");
                if (lit != null)
                {
                    lit.Text = isYes
                        ? "<span class='tick'>&#10004;</span>"  // ✔ green tick
                        : "<span class='cross'>&#10008;</span>"; // ✖ red cross
                }

                // ✅ Handle CAPA_ID
                Literal litCAPA = (Literal)e.Row.FindControl("litCAPAID");
                if (litCAPA != null)
                {
                    if (!isYes && dataItem["CAPA_ID"] != DBNull.Value)   // show only if Not OK
                    {
                        litCAPA.Text = dataItem["CAPA_ID"].ToString();
                    }
                    else
                    {
                        litCAPA.Text = "";   // hide when OK or NULL
                    }
                }

                // ✅ Handle Photo
                Image img = (Image)e.Row.FindControl("imgPhoto");
                if (img != null)
                {
                    string path = dataItem["PhotoPath"].ToString();
                    if (!string.IsNullOrEmpty(path))
                    {
                        img.ImageUrl = ResolveUrl(path);
                    }
                    else
                    {
                        img.Visible = false;
                    }
                }
            }
        }
    }}

