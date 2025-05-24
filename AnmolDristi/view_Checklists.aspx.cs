using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
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
                con.Open();
                SqlCommand cmdChecklist = new SqlCommand("SELECT * FROM Checklists WHERE ID = @ChecklistID", con);
                cmdChecklist.Parameters.AddWithValue("@ChecklistID", checklistId);

                SqlDataReader reader = cmdChecklist.ExecuteReader();
                if (reader.Read())
                {
                    Datelbl.Text = Convert.ToDateTime(reader["Date"]).ToString("yyyy-MM-dd");
                    Deptlbl.Text = reader["Department"].ToString();
                    Joblbl.Text = reader["Job"].ToString();
                    Loclbl.Text = reader["Location"].ToString();
                    Audlbl.Text = reader["Audit_By"].ToString();
                    //ChecklistId.Value = reader["ID"].ToString();
                }
                reader.Close();



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
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label statusLabel = (Label)e.Item.Controls[1];
                if (statusLabel.Text == "OK")
                {
                    statusLabel.Text = "✅";
                }
                else
                {
                    statusLabel.Text = "❌";
                }

                Image img = (Image)e.Item.Controls[3];
                if (!string.IsNullOrEmpty(img.ImageUrl))
                {
                    string relativePath = "~/uploads/" + img.ImageUrl;
                    string physicalPath = Server.MapPath(relativePath);

                    if (File.Exists(physicalPath))
                    {
                        img.ImageUrl = relativePath;
                    }
                    else
                    {
                        img.ImageUrl = "~/uploads/no_image.jpg"; // fallback image
                        img.ToolTip = "Image not found";
                    }
                }
                //else
                //{
                //    img.ImageUrl = "~/uploads/no_image.jpg"; // for empty ImageUrl
                //    img.ToolTip = "No image provided";
                //}
            }
        }

    }
}