using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class View_LiftingBelt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string checklistId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(checklistId))
                {
                    LoadChecklistsInfo(Convert.ToInt32(checklistId));
                }
            }
        }


        private void LoadChecklistsInfo(int checklistId)
        {
            string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                SqlCommand cmdCheck = new SqlCommand("SELECT * FROM LiftingBeltChecklist WHERE ID = @ChecklistID", con);
                cmdCheck.Parameters.AddWithValue("@ChecklistID", checklistId);

                SqlDataReader reader = cmdCheck.ExecuteReader();
                if (reader.Read())
                {
                    lblDte.Text = Convert.ToDateTime(reader["Date"]).ToString("yyyy-MM-dd");
                    lbljbsite.Text = reader["JobSite"].ToString();
                    lbljbID.Text = reader["JobID"].ToString();
                    lbljbdesc.Text = reader["JobDescription"].ToString();
                    lblaudit.Text = reader["Audit_By"].ToString();
                    lblID.Text = reader["ID"].ToString();

                }
                reader.Close();





                SqlCommand cmd = new SqlCommand("SELECT * FROM LiftingBeltChecklistInfo WHERE Checklist_ID = @ChecklistID", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("@ChecklistID", checklistId);
                DataTable dt = new DataTable();
                dt.Clear();
                da.Fill(dt);


                var grouped = dt.AsEnumerable()
    .GroupBy(row => row.Field<string>("Description"))
    .Select(g => new
    {
        GroupName = g.Key,
        Keys = g
            .OrderBy(x => x.Field<string>("CheckPoints"))
            .Select((x, itemIndex) => new
            {
                Serial = (itemIndex + 1).ToString(),
                Requirement = x.Field<string>("CheckPoints"),
                ChecklistInfoId = x.Field<int>("ID"),
                IsOk = x.Field<string>("Result"),
                Remark_text = x.Field<string>("Remarks"),
                Before_pic = x.Field<string>("Beforephoto"),
                Note = x.Field<string>("Note")
            }).ToList()
    }).ToList();


                ParentRepeter.DataSource = grouped;
                ParentRepeter.DataBind();
            }
        }


        protected void RepeaterChecklist_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {


                Image img = (Image)(((PlaceHolder)e.Item.Controls[5]).Controls[2]);
                Label rmrk = (Label)(((PlaceHolder)e.Item.Controls[5]).Controls[1]);
                if (!string.IsNullOrEmpty(img.ImageUrl))
                {
                    string relativePath = "~/uploads/" + img.ImageUrl;
                    string physicalPath = Server.MapPath(relativePath);

                    if (File.Exists(physicalPath))
                    {
                        img.ImageUrl = relativePath;
                    }
                }
                else
                {
                    //img.ImageUrl = "~/uploads/no_image.jpg"; 
                    //img.ToolTip = "Image not found";
                    img.Visible = false;
                    rmrk.Visible = false;
                }




            }
        }
    
    }

}