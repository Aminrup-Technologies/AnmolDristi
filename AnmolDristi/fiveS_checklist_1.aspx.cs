using AnmolDristi.DAL.Datasets;
using AnmolDristi.DAL.Datasets.Checklist_details_datasetTableAdapters;
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
                {"Are cleaning schedules available and displayed?","SHINE-SEISO" },
                {"Are floors, walls, windows, doors etc. maintained at a high level of cleanliness?","SHINE-SEISO"},
                {"Are Items stored according to frequency of use?","SHINE-SEISO" },
                {"Are machines, equipment, tools, furniture maintained at a high level of cleanliness and their maintenance schedules displayed?","SHINE-SEISO"},
                {"Is there a general appearance of cleanliness all round?","SHINE-SEISO" },
                {"Are all 5S procedures standardized?","STANDARDIZE-SEIKETSU" },
                {"Are standard checklists used to regularly inspect 5S?","STANDARDIZE-SEIKETSU" },
                {"Are labels, notices etc. standardized?","STANDARDIZE-SEIKETSU" },
                {"Do aisles/gangways have a standard size and colour?","STANDARDIZE-SEIKETSU" },
                {"Are pipes, cables etc. colour-coded?","STANDARDIZE-SEIKETSU" },
                {"Is there a system for how and when the 5S activities will be implemented?","SUSTAIN-SHITSUKE" },
                {"Does management provide support to the 5S programme by recognition, resources and leadership?","SUSTAIN-SHITSUKE" },
                {"Have first 3S’s become a part of the daily work?","SUSTAIN-SHITSUKE" },
                {"Do employees show positive interest in 5S activities?","SUSTAIN-SHITSUKE" },
        };


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var grouped = myDictionary
                     .GroupBy(x => x.Value)
                     .Select((g, groupIndex) => new
                     {
                         GroupSerial = (groupIndex + 1).ToString(),
                         GroupName = g.Key,
                         Keys = g.Select((x, itemIndex) => new
                         {
                             Serial = $"{groupIndex + 1}.{itemIndex + 1}",
                             Requirement = x.Key,
                             ID = string.Empty
                         }).ToList()
                     }).ToList();



                string checklistId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(checklistId))
                {
                    LoadChecklistsInfo(Convert.ToInt32(checklistId));
                }
                else
                {
                    DictionaryRepeater.DataSource = grouped;
                    DictionaryRepeater.DataBind();
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
                    txtDate.Text = Convert.ToDateTime(reader["Date"]).ToString("yyyy-MM-dd");
                    txtDepartment.Text = reader["Department"].ToString();
                    txtJob.Text = reader["Job"].ToString();
                    ID.Value = reader["ID"].ToString();
                }
                reader.Close();

                SqlCommand cmd = new SqlCommand("SELECT * FROM ChecklistInfo WHERE Checklist_ID = @ChecklistID", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("@ChecklistID", checklistId);
                DataTable dt = new DataTable();
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
                Requirement = x.Field<string>("Requirements"),
                ID = x.Field<int>("ID"),
                IsOk = x.Field<bool>("Result"),
                Remarks = x.Field<string>("Remark"),
                PhotoPath = "~/uploads/" + x.Field<string>("Before_photo")
            }).ToList()
        }).ToList();

                DictionaryRepeater.DataSource = grouped;
                DictionaryRepeater.DataBind();
            }
        }


        protected void editChecklist()
        {
            var checklistRow = _dataSource.Checklists.NewChecklistsRow();
            checklistRow["ID"] = ID.Value;
            checklistRow["Date"] = txtDate.Text;
            checklistRow["Department"] = txtDepartment.Text;
            checklistRow["Job"] = txtJob.Text;

            _dataSource.Checklists.Rows.Add(checklistRow);
            _dataSource.Checklists.Rows[0].AcceptChanges();
            _dataSource.Checklists.Rows[0].SetModified();

            ChecklistsTableAdapter checklisttable = new ChecklistsTableAdapter();
            checklisttable.Update(_dataSource);

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
                    checklistInfoRow["Checklist_ID"] = Convert.ToInt32(ID.Value);
                    checklistInfoRow["Group_Name"] = GrpDetails.Text;

                    //Wrap the Requirement.Text assignment like this to guarantee it doesn't break regardless of database column length:
                    //This ensures you're not violating the MaxLength constraint even if the database allows larger values but the in-memory schema is outdated or limited.
                    string reqText = Requirement.Text;
                    int maxLength = _dataSource.ChecklistInfo.Columns["Requirements"].MaxLength;
                    if (maxLength > 0 && reqText.Length > maxLength)
                    {
                        reqText = reqText.Substring(0, maxLength);
                    }
                    checklistInfoRow["Requirements"] = reqText;

                    //checklistInfoRow["Requirements"] = Requirement.Text;
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
                    _dataSource.ChecklistInfo.Rows[0].AcceptChanges();
                    _dataSource.ChecklistInfo.Rows[0].SetModified();
                }
            }

            ChecklistInfoTableAdapter checklistInfo = new ChecklistInfoTableAdapter();
            checklistInfo.Update(_dataSource);
        }


    
        protected void submit_Click(object sender, EventArgs e)
        {
            //editChecklist();
            String CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection sqlConnection = new SqlConnection(CS))
            {
                ChecklistsTableAdapter checklisttable = new ChecklistsTableAdapter();
                // Adapter for ChecklistInfo
                SqlDataAdapter daChecklistInfo = new SqlDataAdapter("SELECT * FROM ChecklistInfo", sqlConnection);

                //This ensures that the structure of your in-memory DataTable (like _dataSource.ChecklistInfo) accurately mirrors the database table
                daChecklistInfo.MissingSchemaAction = MissingSchemaAction.AddWithKey;

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

                        //Wrap the Requirement.Text assignment like this to guarantee it doesn't break regardless of database column length:
                        //This ensures you're not violating the MaxLength constraint even if the database allows larger values but the in-memory schema is outdated or limited.
                        string reqText = Requirement.Text;
                        int maxLength = _dataSource.ChecklistInfo.Columns["Requirements"].MaxLength;
                        if (maxLength > 0 && reqText.Length > maxLength)
                        {
                            reqText = reqText.Substring(0, maxLength);
                        }
                        checklistInfoRow["Requirements"] = reqText;

                        //checklistInfoRow["Requirements"] = Requirement.Text;
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
            Response.Redirect("qaqc_home.aspx");
        }
    }
}