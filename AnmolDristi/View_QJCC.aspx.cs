using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace AnmolDristi
{
    public partial class View_QJCC : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string checklistId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(checklistId))
                {
                    LoadChecklistInfo(Convert.ToInt32(checklistId));
                }
            }
        }

        private void LoadChecklistInfo(int checklistId)
        {

            string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                // Load main checklist info
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM JCC_Checklist WHERE ID = @ChecklistID", con))
                {
                    cmd.Parameters.AddWithValue("@ChecklistID", checklistId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            Datelbl.Text = Convert.ToDateTime(reader["Date"]).ToString("yyyy-MM-dd");
                            JobIDlbl.Text = reader["JobID"].ToString();
                            Deptlbl.Text = reader["Department"].ToString();
                            Loclbl.Text = reader["Location"].ToString();
                            TimeSpan startTime = (TimeSpan)reader["StartTime"];
                            strttimelbl.Text = startTime.ToString(@"hh\:mm");
                            TimeSpan endTime = (TimeSpan)reader["EndTime"];
                            Endtimelbl.Text = endTime.ToString(@"hh\:mm");
                            Audlbl.Text = reader["AuditBy"].ToString();

                            // Check for null photo
                            var photoPath = reader["Photo"] as string;
                            photolbl.ImageUrl = string.IsNullOrEmpty(photoPath) ? "~/Images/no-image.png" : photoPath;
                        }
                    }
                }

                // Load employee data for GridView
                using (SqlCommand cmdEmp = new SqlCommand("SELECT * FROM JCC_Employee WHERE Checklist_ID = @ChecklistID", con))
                {
                    cmdEmp.Parameters.AddWithValue("@ChecklistID", checklistId);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmdEmp))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvChecklist.HeaderStyle.BackColor = System.Drawing.Color.SlateGray;
                        gvChecklist.HeaderStyle.ForeColor = System.Drawing.Color.White;
                        gvChecklist.HeaderStyle.Font.Bold = true;

                        gvChecklist.DataSource = dt;
                        gvChecklist.DataBind();
                    }
                }

                // Load checklist info for grouped Repeater
                using (SqlCommand cmdInfo = new SqlCommand("SELECT * FROM JCC_ChecklistInfo WHERE Checklist_ID = @ChecklistID", con))
                {
                    cmdInfo.Parameters.AddWithValue("@ChecklistID", checklistId);

                    using (SqlDataAdapter daInfo = new SqlDataAdapter(cmdInfo))
                    {
                        DataTable dtInfo = new DataTable();
                        daInfo.Fill(dtInfo);

                        // Safe handling for grouping and Result/BeforePhoto
                        var grouped = dtInfo.AsEnumerable()
                            .GroupBy(row => row.Field<string>("Applicability"))
                            .Select((g, groupIndex) => new
                            {
                                GroupSerial = (groupIndex + 1).ToString(),
                                GroupName = g.Key,
                                Keys = g.Select((x, itemIndex) => new
                                {
                                    Serial = $"{groupIndex + 1}.{itemIndex + 1}",
                                    Requirements = x.Field<string>("CheckPoints"),
                                    ID = x.Field<int>("ID"),
                                    Result = x["Result"]?.ToString(),
                                    Capa_ID = x["Capa_ID"] == DBNull.Value ? "" : x["Capa_ID"].ToString(),
                                    Remark = x["Remarks"]?.ToString(),
                                    Severity = x["Severity"]?.ToString(),
                                    Before_photo = "~/uploads/" + (x["BeforePhoto"]?.ToString() )
                                }).ToList()
                            }).ToList();

                        ParentRepeter.DataSource = grouped;
                        ParentRepeter.DataBind();
                    }
                }
            }
        }

        protected void RepeaterChecklist_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label statusLabel = (Label)e.Item.Controls[1];

                HyperLink lnkCapa = (HyperLink)e.Item.FindControl("lnkCapa");

                if (statusLabel.Text == "OK")
                {
                    statusLabel.Text = "✅";
                    lnkCapa.Visible = false;
                }
                else if (statusLabel.Text == "NotOK")
                {
                    statusLabel.Text = "❌";
                    lnkCapa.Visible = true;
                }
                else
                {
                    statusLabel.Text = "NA";
                    lnkCapa.Visible = false;
                }

                //Label sev = (Label)e.Item.Controls[4];
                //if (sev)

                Image img = (Image)e.Item.Controls[7];
                if (!string.IsNullOrEmpty(img.ImageUrl))
                {
                    string relativePath =  img.ImageUrl;
                    string physicalPath = Server.MapPath(relativePath);

                    if (File.Exists(physicalPath))
                    {
                        img.ImageUrl = relativePath;
                    }
                    else
                    {
                        img.ImageUrl = ""; // fallback image
                        //img.ToolTip = "Image not found";
                    }
                }
                //else
                //{
                //    img.ImageUrl = "~/uploads/no_image.jpg"; // for empty ImageUrl
                //    img.ToolTip = "No image provided";
                //}


                
                string capaId = DataBinder.Eval(e.Item.DataItem, "Capa_ID")?.ToString();

                if (!string.IsNullOrEmpty(capaId))
                {
                    // current "id" from query string
                    string currentId = Request.QueryString["id"];

                    // new URL for JCC capaview page
                    string url = $"CapaView.aspx?id={currentId}&capaid={capaId}";

                    lnkCapa.NavigateUrl = url;
                    lnkCapa.Text =  capaId;
                    
                }
                else
                {
                    lnkCapa.Visible = false;
                }

            }
        }
    }
} 
