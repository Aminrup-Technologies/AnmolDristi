using AnmolDristi.DAL.Datasets;
using AnmolDristi.DAL.Datasets.Checklist_details_datasetTableAdapters;
using AnmolDristi.DAL.Datasets.DataSet1TableAdapters;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Lifting_Belt : System.Web.UI.Page
    {
        public DataSet1 _dataset = new DataSet1();

        Dictionary<string, string> LiftingDictionary = new Dictionary<string, string>()
        {
            {"Belt sling tested or not.","LIFTING BELTS" },
            {"Any damage like cut on edges,middle portion etc.","LIFTING BELTS" },
            {"Condition of eye for any damage-cut ,worn out,open stitches etc.","LIFTING BELTS" },
            {"Sling is tested or not,Tag fixed or not.","WIRE ROPE SLING" },
            {"Rusting of sling, It should be lubricated.","WIRE ROPE SLING"},
            {"Sling should not be twisted & knots should not be there.","WIRE ROPE SLING"},
            {"Crimp condition of sling","WIRE ROPE SLING"},
            {"Check for any damages like kinks,protrusion,bird cage abration etc.","WIRE ROPE SLING" }
        };


        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var grouped = LiftingDictionary
         .GroupBy(kvp => kvp.Value) 
         .Select(g => new
         {
             GroupName = g.Key,
             Keys = g.Select((item, index) => new
             {
                 Serial = index + 1,
                 Requirement = item.Key,
                 GroupName = item.Value,
                 ChecklistInfoId = string.Empty
             }).ToList()
         })
         .ToList();

                string checklistId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(checklistId))
                {
                    LoadInfo(Convert.ToInt32(checklistId));
                    headng.Text = "UPDATE LIFTING BELTS & WIRE ROPE SLING CHECKLIST DATA";
                }
                else
                {
                    DictionaryRepeater.DataSource = grouped;
                    DictionaryRepeater.DataBind();
                }
            }
        }

        private void LoadInfo(int checklistId)
        {
            string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT * FROM LiftingBeltChecklist WHERE ID = @ChecklistID", con);
                cmd.Parameters.AddWithValue("@ChecklistID", checklistId);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtDate.Text = Convert.ToDateTime(reader["Date"]).ToString("yyyy-MM-dd");
                    txtJobsite.Text = reader["JobSite"].ToString();
                    txtJobID.Text = reader["JobID"].ToString();
                    txtJobDescription.Text = reader["JobDescription"].ToString();
                    txtAuditby.Text = reader["Audit_By"].ToString() ;
                    ChecklistId.Value = reader["ID"].ToString();

                }
                reader.Close();

                SqlCommand cmdInfo = new SqlCommand("SELECT * FROM LiftingBeltChecklistInfo WHERE Checklist_ID = @ChecklistID", con);
                SqlDataAdapter da = new SqlDataAdapter(cmdInfo);
                cmdInfo.Parameters.AddWithValue("@ChecklistID", checklistId);
                DataTable dt = new DataTable();
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


                DictionaryRepeater.DataSource = grouped;
                DictionaryRepeater.DataBind();

               
            }
        }






        protected void ChildRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ChecklistId.Value))
            {
                EditChecklist();
            }
            else
            {
                string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection sqlConnection = new SqlConnection(CS))
                {
                    LiftingBeltChecklistTableAdapter tableAdapter = new LiftingBeltChecklistTableAdapter();
                    SqlDataAdapter daChecklist = new SqlDataAdapter("SELECT * FROM LiftingBeltChecklistInfo", sqlConnection);

                    SqlCommandBuilder cbChecklistInfo = new SqlCommandBuilder(daChecklist);
                    daChecklist.Fill(_dataset, "LiftingBeltChecklistInfo");

                    tableAdapter.Connection = sqlConnection;

                    var ChecklistId = tableAdapter.InsertLiftingBeltChecklist(txtDate.Text, txtJobsite.Text, txtJobID.Text, txtJobDescription.Text, DateTime.Now,txtAuditby.Text);

                    //string ChecklistId = "LB-" + fullId.ToString(); 

                    foreach (RepeaterItem parentItem in DictionaryRepeater.Items)
                    {
                        Repeater ChildRepeater = (Repeater)parentItem.FindControl("ChildRepeater");
                        Label Grp_detail = (Label)parentItem.FindControl("Grp_detail");

                        foreach (RepeaterItem item in ChildRepeater.Items)
                        {
                            RadioButtonList rbl = (RadioButtonList)item.FindControl("result");
                            TextBox remark = (TextBox)item.FindControl("Remark_text");
                            FileUpload photo = (FileUpload)item.FindControl("Before_pic");
                            Label checkPoints = (Label)item.FindControl("Requirement");
                            TextBox note = (TextBox)item.FindControl("Note_text");
                            CheckBox CapaPoint = (CheckBox)item.FindControl("CapaPoint");

                            var LiftingInfoRow = _dataset.LiftingBeltChecklistInfo.NewLiftingBeltChecklistInfoRow();
                            LiftingInfoRow["Checklist_ID"] = ChecklistId;
                            LiftingInfoRow["Description"] = Grp_detail.Text;
                            LiftingInfoRow["CheckPoints"] = checkPoints.Text;
                            LiftingInfoRow["Result"] = rbl.SelectedValue;
                            LiftingInfoRow["Remarks"] = remark.Text.Trim();
                            LiftingInfoRow["Note"]= note.Text.Trim();

                            string filename = "";
                            if (photo.HasFile)
                            {
                                filename = Path.GetFileName(photo.FileName);
                                string folderPath = Server.MapPath("~/uploads/");
                                if (!Directory.Exists(folderPath))
                                {
                                    Directory.CreateDirectory(folderPath);
                                }

                                string filePath = Path.Combine(folderPath, filename);
                                photo.SaveAs(filePath);
                                LiftingInfoRow["BeforePhoto"] = filename;
                            }

                            string customid = "LB-" + ChecklistId.ToString();
                            LiftingInfoRow["Custom_ID"] = customid;

                            //  CAPA_ID logic
                            bool isCapaChecked = CapaPoint != null && CapaPoint.Checked;
                            if (rbl.SelectedValue == "NotOK" && isCapaChecked) // Result is "Not OK" and CAPA is checked
                            {

                                if (sqlConnection.State != ConnectionState.Open)
                                    sqlConnection.Open();

                                // Insert into tbl_CAPAMaster and get CAPAID...
                                string insertCapaSql = @"
                                INSERT INTO tbl_CAPAMaster 
                                (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate, SourceTable, Description)
                                VALUES 
                                (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate, @SourceTable, @Description);
                                SELECT SCOPE_IDENTITY();";

                                using (SqlCommand capaCmd = new SqlCommand(insertCapaSql, sqlConnection))
                                {
                                    capaCmd.Parameters.AddWithValue("@HeaderID", customid);
                                    capaCmd.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(filename) ? (object)DBNull.Value : filename);
                                    capaCmd.Parameters.AddWithValue("@Remarks", remark.Text);

                                    // Safely retrieve AssignedBy from Session
                                    string assignedBy = (Session["USERID"] != null) ? Session["USERID"].ToString() : "Unknown";
                                    capaCmd.Parameters.AddWithValue("@AssignedBy", assignedBy);
                                    capaCmd.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                                    capaCmd.Parameters.AddWithValue("@SourceTable", "Lifting Belt And Wire Rope Sling Checklist");
                                    capaCmd.Parameters.AddWithValue("@Description", checkPoints.Text);


                                    object result = capaCmd.ExecuteScalar();
                                    int newCapaId = Convert.ToInt32(result);


                                    LiftingInfoRow["CAPA_ID"] = newCapaId;
                                }
                            }
                            else
                            {
                                LiftingInfoRow["CAPA_ID"] = DBNull.Value;
                            }


                            _dataset.LiftingBeltChecklistInfo.Rows.Add(LiftingInfoRow);

                        }
                        daChecklist.Update(_dataset, "LiftingBeltChecklistInfo");
                    }
                    string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Sucess',
                                text: 'Checklist Saved Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";


                    ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);

                }
                //Response.Redirect("Lifting_BeltData.aspx");
            }
        }

        protected void EditChecklist()
        {
            var ChecklistRow = _dataset.LiftingBeltChecklist.NewLiftingBeltChecklistRow();
            ChecklistRow["ID"] = ChecklistId.Value.ToString();
            ChecklistRow["Date"] = txtDate.Text;
            ChecklistRow["JobSite"] = txtJobsite.Text;
            ChecklistRow["JobID"] = txtJobID.Text;
            ChecklistRow["JobDescription"] = txtJobDescription.Text;
            ChecklistRow["Audit_By"] = txtAuditby.Text;

            _dataset.LiftingBeltChecklist.Rows.Add(ChecklistRow);
            _dataset.LiftingBeltChecklist.Rows[0].AcceptChanges();
            _dataset.LiftingBeltChecklist.Rows[0].SetModified();

            //new implementation...
            string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            SqlDataAdapter daChecklistInfo = new SqlDataAdapter("SELECT * FROM LiftingBeltChecklistInfo WHERE Checklist_ID = @ChecklistID", CS);
            daChecklistInfo.SelectCommand.Parameters.AddWithValue("@ChecklistID", ChecklistId.Value);
            daChecklistInfo.MissingSchemaAction = MissingSchemaAction.AddWithKey;
            SqlCommandBuilder cbChecklistInfo = new SqlCommandBuilder(daChecklistInfo);

            daChecklistInfo.Fill(_dataset.LiftingBeltChecklistInfo);


            foreach (RepeaterItem parentItem in DictionaryRepeater.Items)
            {
                Repeater ChildRepeater = (Repeater)parentItem.FindControl("ChildRepeater");
                Label Grp_detail = (Label)parentItem.FindControl("Grp_detail");

                foreach (RepeaterItem item in ChildRepeater.Items)
                {
                    RadioButtonList rbl = (RadioButtonList)item.FindControl("result");
                    TextBox remark = (TextBox)item.FindControl("Remark_text");
                    FileUpload photo = (FileUpload)item.FindControl("Before_pic");
                    Label checkPoints = (Label)item.FindControl("Requirement");
                    Label existingimage = (Label)item.FindControl("Img");
                    TextBox note = (TextBox)item.FindControl("Note_text");
                    HiddenField hidChecklistInfoId = (HiddenField)item.FindControl("ChecklistInfoId");
                    CheckBox CapaPoint = (CheckBox)item.FindControl("CapaPoint");


                    int checklistInfoId = Convert.ToInt32(hidChecklistInfoId.Value);

                    DataRow checklistInfoRow = _dataset.LiftingBeltChecklistInfo.Rows.Find(checklistInfoId);

                    // Getting old result (default to "OK" if null)...
                    string oldResult = checklistInfoRow["Result"] != DBNull.Value ? checklistInfoRow["Result"].ToString() : "OK";

                    // Checking if old CAPA ID exists...
                    string oldCapaId = checklistInfoRow["CAPA_ID"] != DBNull.Value ? checklistInfoRow["CAPA_ID"].ToString() : null;


                    //checklistInfoRow["ID"] = Convert.ToInt32(((HiddenField)item.FindControl("ChecklistInfoId")).Value);
                    //checklistInfoRow["Checklist_ID"] = Convert.ToInt32(ChecklistId.Value);
                    checklistInfoRow["Description"] = Grp_detail.Text;
                    checklistInfoRow["CheckPoints"] = checkPoints.Text;
                    checklistInfoRow["Result"] = rbl.SelectedValue;
                    checklistInfoRow["Remarks"] = remark.Text;
                    checklistInfoRow["Note"] = note.Text.Trim();


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
                        checklistInfoRow["Beforephoto"] = filename;
                    }
                    else if (existingimage.Text != "" && rbl.SelectedValue == "NotOK")
                    {
                        checklistInfoRow["Beforephoto"] = existingimage.Text;
                    }
                    else
                    {
                        checklistInfoRow["Beforephoto"] = null;
                    }

                    string customid = "LB-" + ChecklistId.Value.ToString();
                    checklistInfoRow["Custom_ID"] = customid;

                    // Determining new result that is true = OK or NA, false = Not OK...
                    bool newResult = rbl.SelectedValue == "OK" || rbl.SelectedValue == "NA";

                    bool isCapaChecked = CapaPoint != null && CapaPoint.Checked;

                    if (!newResult && isCapaChecked)
                    {
                        // Only inserting new CAPA row if result changed from OK/NA to Not OK...
                        if (oldResult == "OK" || oldResult == "NA")
                        {
                            using (SqlConnection con = new SqlConnection(CS))
                            {
                                con.Open();

                                string filename = checklistInfoRow["Beforephoto"] != DBNull.Value ? checklistInfoRow["Beforephoto"].ToString() : null;

                                string insertCapaSql = @"
                                            INSERT INTO tbl_CAPAMaster 
                                            (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate, IsYes)
                                            VALUES 
                                            (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate, 0);
                                            SELECT SCOPE_IDENTITY();";

                                using (SqlCommand capaCmd = new SqlCommand(insertCapaSql, con))
                                {
                                    capaCmd.Parameters.AddWithValue("@HeaderID", customid);
                                    capaCmd.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(filename) ? (object)DBNull.Value : filename);
                                    capaCmd.Parameters.AddWithValue("@Remarks", remark.Text);
                                    capaCmd.Parameters.AddWithValue("@AssignedBy", txtAuditby.Text);
                                    capaCmd.Parameters.AddWithValue("@AssignedDate", DateTime.Now);

                                    object result = capaCmd.ExecuteScalar();
                                    int newCapaId = Convert.ToInt32(result);
                                    checklistInfoRow["CAPA_ID"] = newCapaId;

                                }
                            }
                        }
                        else
                        {
                            // if still not ok just keeping the old one...
                            checklistInfoRow["CAPA_ID"] = oldCapaId;
                        }
                    }
                    else
                    {
                        // If result is OK or CAPA checkbox not checked...
                        checklistInfoRow["CAPA_ID"] = oldCapaId;

                        if (!string.IsNullOrEmpty(oldCapaId))
                        {
                            using (SqlConnection con = new SqlConnection(CS))
                            {
                                con.Open();

                                string updateSql = "UPDATE tbl_CAPAMaster SET IsYes = 1 WHERE CAPAID = @CAPAID";
                                using (SqlCommand cmd = new SqlCommand(updateSql, con))
                                {
                                    cmd.Parameters.AddWithValue("@CAPAID", Convert.ToInt32(oldCapaId));
                                    cmd.ExecuteNonQuery();
                                }
                            }
                        }
                    }


                }
            }

            LiftingBeltChecklistTableAdapter tableAdapter = new LiftingBeltChecklistTableAdapter();
            tableAdapter.Update(_dataset);

            LiftingBeltChecklistInfoTableAdapter liftingInfo = new LiftingBeltChecklistInfoTableAdapter();
            liftingInfo.Update(_dataset);

            string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Sucess',
                                text: 'Checklist Updated Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

            ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);

        }

        protected void ChildRepeater_ItemDataBound1(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType.ToString() == "Item" || e.Item.ItemType.ToString() == "AlternatingItem")
            {
                var dataItem = e.Item.DataItem.GetType().GetProperties();

                if (dataItem.Length > 5)
                {
                    if (dataItem[3].GetValue(e.Item.DataItem).ToString() != "")
                    {
                        ((RadioButtonList)e.Item.Controls[9]).SelectedValue = dataItem[3].GetValue(e.Item.DataItem).ToString();
                    }

                    if (dataItem[4].GetValue(e.Item.DataItem).ToString() != "")
                    {
                        ((TextBox)e.Item.Controls[11]).Text = dataItem[4].GetValue(e.Item.DataItem).ToString();
                    }

                    if (dataItem[5].GetValue(e.Item.DataItem) != null)
                    {
                        ((Label)e.Item.FindControl("Img")).Text = dataItem[5].GetValue(e.Item.DataItem).ToString();
                        ((Label)e.Item.FindControl("Img")).Visible = true;
                    }
                    if (dataItem.Length > 6 && dataItem[6].GetValue(e.Item.DataItem) != null)
                    {
                        ((TextBox)e.Item.Controls[23]).Text = dataItem[6].GetValue(e.Item.DataItem).ToString();
                    }
                }
            }
        }

        protected void home_Click(object sender, EventArgs e)
        {
            Response.Redirect("qaqc_home.aspx");
        }

        
    }
}