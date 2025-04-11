using AnmolDristi.DAL.Datasets;
using AnmolDristi.DAL.Datasets.Checklist_details_datasetTableAdapters;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class fiveS_checklist_1 : System.Web.UI.Page
    {
        public Checklist_details_dataset _dataSource = new Checklist_details_dataset();

        Dictionary<string, string> myDictionary = new Dictionary<string, string>()
            {
                {"Is this floor area free of unwanted items?","Sort Out - SEIRI" },
                {"Are tops and insides of all cupboards, shelves, tables,etc.free of unwanted items?","Sort Out - SEIRI" },
                {"Are Items stored according to frequencyof use?","Sort Out - SEIRI" },
                {"Are walls free of old posters, calendars, pictures,notices etc.?","Sort Out - SEIRI"},
                {"Is there a general clutter free appearance?","Sort Out - SEIRI" },
                {"Are direction indications available to all facilities from the entrance onwards?","SET IN ORDER-SEITON" },
                {"Do all items of equipment have identification labels?","SET IN ORDER-SEITON"},
                {"Are all rooms, cubicles and similar areas clearly numbered or named?","SET IN ORDER-SEITON" },
                {"Are specific areas demarcated for garbage/rejects/waste, etc.?","SET IN ORDER-SEITON"},
                {"Are switches, fan regulators, controls, etc. labelled?","SET IN ORDER-SEITON" },
                {"Are all cables, wires, pipes etc, neat and straight?","SET IN ORDER-SEITON" },
                {"Is colour coding used effctively for easy identification","SET IN ORDER-SEITON" },
                {"Is there a general apperance of orderliness?","SET IN ORDER-SEITON" },
                {"Is it easy to find any item/document without delay? ","SET IN ORDER-SEITON" },

            };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var grouped = myDictionary
                     .GroupBy(x => x.Value)
                     .Select((g, groupIndex) => new
                     {
                         GroupSerial = (groupIndex + 1).ToString(), // 1, 2, 3...
                         Value = g.Key,
                         Keys = g.Select((x, itemIndex) => new
                         {
                             Serial = $"{groupIndex + 1}.{itemIndex + 1}", // 1.1, 1.2, etc.
                             key = x.Key
                         }).ToList()
                     }).ToList();


                DictionaryRepeater.DataSource = grouped;
                DictionaryRepeater.DataBind();
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            String CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection sqlConnection = new SqlConnection(CS))
            {
                ChecklistsTableAdapter checklisttable = new ChecklistsTableAdapter();
                // Adapter for ChecklistInfo
                SqlDataAdapter daChecklistInfo = new SqlDataAdapter("SELECT * FROM ChecklistInfo", sqlConnection);
                SqlCommandBuilder cbChecklistInfo = new SqlCommandBuilder(daChecklistInfo);
                daChecklistInfo.Fill(_dataSource, "ChecklistInfo");

                checklisttable.Connection = sqlConnection;

                var checklistId = checklisttable.InsertChecklist(txtDate.Text, txtDepartment.Text, txtJob.Text, "test", DateTime.Now);

                //  ChecklistInfo rows
                foreach (RepeaterItem parentItem in DictionaryRepeater.Items)
                {
                    Repeater childRepeater = (Repeater)parentItem.FindControl("ChildRepeater");
                    Label GrpDetails = (Label)parentItem.FindControl("Grp_detail");

                    foreach (RepeaterItem item in childRepeater.Items)
                    {
                        RadioButtonList rbl = (RadioButtonList)item.FindControl("result");
                        TextBox remark = (TextBox)item.FindControl("Remark_text");
                        FileUpload photo = (FileUpload)item.FindControl("Before_pic");
                        Label Requirement = (Label)item.FindControl("Requirement");

                        var checklistInfoRow = _dataSource.ChecklistInfo.NewChecklistInfoRow();
                        checklistInfoRow["Checklist_ID"] = checklistId;
                        checklistInfoRow["Group_Name"] = GrpDetails.Text;
                        checklistInfoRow["Requirements"] = Requirement.Text;
                        checklistInfoRow["Result"] = Convert.ToBoolean(rbl.SelectedValue);
                        checklistInfoRow["Remark"] = remark.Text;

                        if (photo.HasFile)
                        {
                            string filename = Path.GetFileName(photo.FileName);
                            string folderPath = Server.MapPath("~/uploads/");
                            if (!Directory.Exists(folderPath))
                            {
                                Directory.CreateDirectory(folderPath);
                            }

                            string filePath = Path.Combine(folderPath, filename);
                            photo.SaveAs(filePath);
                            checklistInfoRow["Before_photo"] = filename;
                        }

                        _dataSource.ChecklistInfo.Rows.Add(checklistInfoRow);
                    }
                }

                daChecklistInfo.Update(_dataSource, "ChecklistInfo");
            }
        }

        protected void reset_Click(object sender, EventArgs e)
        {

        }

        protected void home_Click(object sender, EventArgs e)
        {
            Response.Redirect("/qaqc_home.aspx");
        }
    }
}