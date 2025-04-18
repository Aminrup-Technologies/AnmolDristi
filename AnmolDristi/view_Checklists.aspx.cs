using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class viewChecklists : System.Web.UI.Page
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
                SqlCommand cmd = new SqlCommand("SELECT * FROM ChecklistInfo WHERE Checklist_ID = @ChecklistID", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("@ChecklistID", checklistId);
                DataTable dt = new DataTable();
                dt.Clear();
                da.Fill(dt);

                var grouped = dt.AsEnumerable()
                    .GroupBy(row => row.Field<string>("Group_Name"))
                    .Select((g, groupIndex) => new
                    {
                        GroupSerial = (groupIndex + 1).ToString(),
                        GroupName = g.Key,
                        Keys = g.Select((x, itemIndex) => new
                        {
                            Serial = $"{groupIndex + 1}.{itemIndex + 1}",
                            Requirements = x.Field<string>("Requirements"),
                            ID = x.Field<int>("ID"),
                            Result = x.Field<bool>("Result"),
                            Remark = x.Field<string>("Remark"),
                            Before_photo = x.Field<string>("Before_photo")
                        }).ToList()
                    }).ToList();

                ParentRepeter.DataSource = grouped;
                ParentRepeter.DataBind();
            }
        }

        protected void RepeaterChecklist_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType.ToString() == "Item" || e.Item.ItemType.ToString() == "AlternatingItem")
            {
                if (((Label)e.Item.Controls[1]).Text == "OK")
                {
                    ((Label)e.Item.Controls[1]).Text = "✅";
                }
                else
                {
                    ((Label)e.Item.Controls[1]).Text = "❌";
                }

                if (((Image)e.Item.Controls[3]).ImageUrl != "")
                {
                    ((Image)e.Item.Controls[3]).ImageUrl = "~/uploads/"+ ((Image)e.Item.Controls[3]).ImageUrl;
                }

            }
        }
    }
}