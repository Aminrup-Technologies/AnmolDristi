using AnmolDristi.DAL.Datasets;
using AnmolDristi.DAL.Datasets.Checklist_details_datasetTableAdapters;
using AnmolDristi.DAL.Datasets.DataSet3TableAdapters;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace AnmolDristi
{
    public partial class QuickJCC_Checklist : System.Web.UI.Page
    {
        public DataSet3 _dataset = new DataSet3();

        Dictionary<string, string> MyDictionary = new Dictionary<string, string>()
        {
            { "SOP for particulars Job/Inspection available and adequate.", "For All Jobs" },
            { "Six directional Hazard & Job-related hazards identified in work permit. ", "For All Jobs" },
            { "For all Hazards mitigation taken before job start up.", "For All Jobs" },
            { "Toolbox talk conducted before job start up .SOP steps, isolations method, Hazards & Precaution sare discussed in tool box talk.", "For All Jobs" },
            { "ESI document available & adequate", "Job Requiring Energy Solation" },
            { "Positive isolation of all energy source done as per ESI documents & locked by different agency", "Job Requiring Energy Solation" },
            { "JOB Site Hazard Checklist is filled by vendor safety officer /site supervisor as per applicablity of hazard.", "For All Jobs" },
            { "People engaged in job are well trained, skilled certified and right for the job. ", "Check - GatePass,HeightPaas etc." },
            { "Safe means of approach,working platform provoided for heingt jobs & adequateanchoring of safety belt ensured.", "W@H Jobs" },
            { "Hot work/ Gas permit taken while working in gas hazardous are & all precautions taken.", "Jobs in Gass Area" },
            { "Confined space permit taken from competent person before working in confined space", "Job in confined Space" }
        };
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var grouped = MyDictionary
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
                    LoadChecklistData(Convert.ToInt32(checklistId));
                    heading.Text = "UPDATE QUICK JCC CHECKLIST DATA";
                }
                else
                {
                    DictionaryRepeater.DataSource = grouped;
                    DictionaryRepeater.DataBind();
                }


                DataSet3 ds = ViewState["TeamDataset"] as DataSet3;
                if (ds != null)
                {
                    ds.JCC_Employee.DefaultView.RowStateFilter = DataViewRowState.CurrentRows;
                    gvTeamMembers.DataSource = ds.JCC_Employee;
                    gvTeamMembers.DataBind();
                }

            }
            
        }

        protected void submit_Click(object sender, EventArgs e)
        {

            // Validate team members
            DataSet3 teamDataset = ViewState["TeamDataset"] as DataSet3;
            if (teamDataset == null || teamDataset.JCC_Employee.Rows.Count == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please add at least one team member before submitting.');", true);
                return; // Stop further processing
            }


            if (!string.IsNullOrEmpty(hfChecklistID.Value))
            {
                EditJCCChecklist();
            }
            else
            {

                string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(CS))
                {
                    JCC_ChecklistTableAdapter tableAdapter = new JCC_ChecklistTableAdapter();
                    SqlDataAdapter daChecklist = new SqlDataAdapter("SELECT * FROM JCC_ChecklistInfo", con);

                    SqlCommandBuilder cbChecklistInfo = new SqlCommandBuilder(daChecklist);
                    daChecklist.Fill(_dataset, "JCC_ChecklistInfo");

                    tableAdapter.Connection = con;

                    string photoPath = null;

                    if (fuGroupPhoto.HasFile)
                    {
                        string extension = Path.GetExtension(fuGroupPhoto.FileName);
                        string uniqueFileName = Guid.NewGuid().ToString() + extension;
                        string folderPath = Server.MapPath("~/Uploads/");

                   
                        if (!Directory.Exists(folderPath))
                            Directory.CreateDirectory(folderPath);

                        string fullPath = Path.Combine(folderPath, uniqueFileName);
                        fuGroupPhoto.SaveAs(fullPath);

                        photoPath = uniqueFileName;
                    }

                    TimeSpan tsStart, tsEnd;

                    bool isStartTimeValid = TimeSpan.TryParse(txtStartTime.Text.Trim(), out tsStart);
                    bool isEndTimeValid = TimeSpan.TryParse(txtEndTime.Text.Trim(), out tsEnd);

                    if (!isStartTimeValid || !isEndTimeValid)
                    {
                        //lblError.Text = "Invalid time format. Use HH:mm (e.g., 14:30)";
                        return;
                    }

                    string startTimeStr = tsStart.ToString(@"hh\:mm");
                    string endTimeStr = tsEnd.ToString(@"hh\:mm");

                    var checklistId = tableAdapter.InsertChecklist(
                        txtDate.Text,
                        txtJobID.Text,
                        txtDepartment.Text,
                        txtLocation.Text,
                        startTimeStr,     
                        endTimeStr,
                        txtauditby.Text,
                        photoPath
                    );



                    _dataset = ViewState["TeamDataset"] as DataSet3;

                    foreach (DataSet3.JCC_EmployeeRow row in _dataset.JCC_Employee.Rows)
                    {
                        row.Checklist_ID = Convert.ToInt32(checklistId);
                    }

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
                            DropDownList severity = (DropDownList)item.FindControl("ddlSeverity");
                            CheckBox CapaPoint = (CheckBox)item.FindControl("CapaPoint");
                            HiddenField hidChecklistInfoId = (HiddenField)item.FindControl("ChecklistInfoId");

                            var jccrow = _dataset.JCC_ChecklistInfo.NewJCC_ChecklistInfoRow();
                            jccrow["Checklist_ID"] = checklistId;
                            jccrow["Applicability"] = Grp_detail.Text;
                            jccrow["CheckPoints"] = checkPoints.Text;
                            jccrow["Result"] = rbl.SelectedValue;
                            jccrow["Remarks"] = remark.Text.Trim();
                            jccrow["Severity"] = severity.SelectedValue;
                            jccrow["Note"] = note.Text.Trim();

                            string filename = "";
                            if (photo.HasFile)
                            {
                                filename = Guid.NewGuid().ToString() + "_" + Path.GetFileName(photo.FileName);
                                string folderPath = Server.MapPath("~/uploads/");
                                if (!Directory.Exists(folderPath))
                                {
                                    Directory.CreateDirectory(folderPath);
                                }

                                string filePath = Path.Combine(folderPath, filename);
                                photo.SaveAs(filePath);
                                jccrow["BeforePhoto"] = filename;
                            }

                            string customid = "JCC-" + checklistId.ToString();
                            jccrow["Custom_Id"] = customid;


                            //  CAPA_ID logic
                            bool isCapaChecked = CapaPoint != null && CapaPoint.Checked;
                            if (rbl.SelectedValue == "NotOK" && isCapaChecked) // Result is "Not OK" and CAPA is checked...
                            {

                                if (con.State != ConnectionState.Open)
                                    con.Open();

                                // Insert into tbl_CAPAMaster and get CAPAID.....
                                string insertCapaSql = @"
                                INSERT INTO tbl_CAPAMaster 
                                (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate, SourceTable, Description)
                                VALUES 
                                (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate, @SourceTable, @Description);
                                SELECT SCOPE_IDENTITY();";

                                using (SqlCommand capaCmd = new SqlCommand(insertCapaSql, con))
                                {
                                    capaCmd.Parameters.AddWithValue("@HeaderID", customid);
                                    capaCmd.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(filename) ? (object)DBNull.Value : filename);
                                    capaCmd.Parameters.AddWithValue("@Remarks", remark.Text);

                                    // Safely retrieve AssignedBy from Session
                                    string assignedBy = (Session["USERID"] != null) ? Session["USERID"].ToString() : "Unknown";
                                    capaCmd.Parameters.AddWithValue("@AssignedBy", assignedBy);
                                    capaCmd.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                                    capaCmd.Parameters.AddWithValue("@SourceTable", "Quick JCC Checklist");
                                    capaCmd.Parameters.AddWithValue("@Description", checkPoints.Text);


                                    object result = capaCmd.ExecuteScalar();
                                    int newCapaId = Convert.ToInt32(result);


                                    jccrow["CAPA_ID"] = newCapaId;
                                }
                            }
                            else
                            {
                                jccrow["CAPA_ID"] = DBNull.Value;
                            }


                            _dataset.JCC_ChecklistInfo.Rows.Add(jccrow);

                        }
                        
                    }
                    daChecklist.Update(_dataset, "JCC_ChecklistInfo");
                    JCC_EmployeeTableAdapter ta = new JCC_EmployeeTableAdapter();
                    ta.Update(_dataset.JCC_Employee);

                }

                string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Sucess',
                                text: 'Checklist Saved Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

                // RegisterStartupScript adds the JavaScript code to the page
                ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
            }

            //Response.Redirect("Quick_JCCData.aspx");
        }


        private void LoadChecklistData(int checklistId)
        {
            string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                // STEP 1: Load header (JCC_Checklist)
                SqlCommand cmdHeader = new SqlCommand("SELECT * FROM JCC_Checklist WHERE ID = @ID", con);
                cmdHeader.Parameters.AddWithValue("@ID", checklistId);

                using (SqlDataReader reader = cmdHeader.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtDate.Text = Convert.ToDateTime(reader["Date"]).ToString("yyyy-MM-dd");
                        txtJobID.Text = reader["JobID"].ToString();
                        txtDepartment.Text = reader["Department"].ToString();
                        txtLocation.Text = reader["Location"].ToString();
                        txtStartTime.Text = reader["StartTime"].ToString();
                        txtEndTime.Text = reader["EndTime"].ToString();
                        txtauditby.Text = reader["AuditBy"].ToString();

                        if (reader["Photo"] != DBNull.Value)
                        {
                            lblExistingPhoto.Text = reader["Photo"].ToString();
                        }
                        hfChecklistID.Value = checklistId.ToString(); 
                    }
                }


                // Load from adapter
                JCC_EmployeeTableAdapter empAdapter = new JCC_EmployeeTableAdapter();
                DataSet3 ds = new DataSet3();
                empAdapter.FillByChecklistID(ds.JCC_Employee, Convert.ToInt32(checklistId));

                // Save to ViewState for later use (editing)
                ViewState["TeamDataset"] = ds;

                //  Bind GridView from ViewState dataset (not new DataTable)
                gvTeamMembers.DataSource = ds.JCC_Employee;
                gvTeamMembers.DataBind();


                // Load checklist info (repeater)
                SqlDataAdapter daInfo = new SqlDataAdapter("SELECT * FROM JCC_ChecklistInfo WHERE Checklist_ID = @ChecklistID", con);
                daInfo.SelectCommand.Parameters.AddWithValue("@ChecklistID", checklistId);

                DataTable dtInfo = new DataTable();
                daInfo.Fill(dtInfo);

                var grouped = dtInfo.AsEnumerable()
                            .GroupBy(row => row.Field<string>("Applicability"))
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
                                        ddlSeverity = x.Field<string>("Severity"),
                                        Before_pic = x.Field<string>("Beforephoto"),
                                        Note = x.Field<string>("Note")
                                    }).ToList()
                            }).ToList();


                DictionaryRepeater.DataSource = grouped;
                DictionaryRepeater.DataBind();
            }

            submit.Text = "Update"; // Change button label to update on editing...
        }

        protected void EditJCCChecklist()
        {
            var checklistRow = _dataset.JCC_Checklist.NewJCC_ChecklistRow();

            checklistRow["ID"] = Convert.ToInt32(hfChecklistID.Value);
            checklistRow["Date"] = txtDate.Text;
            checklistRow["JobID"] = txtJobID.Text;
            checklistRow["Department"] = txtDepartment.Text;
            checklistRow["Location"] = txtLocation.Text;
            checklistRow["StartTime"] = txtStartTime.Text;
            checklistRow["EndTime"] = txtEndTime.Text;
            checklistRow["AuditBy"] = txtauditby.Text;

            if (fuGroupPhoto.HasFile)
            {
                string ext = Path.GetExtension(fuGroupPhoto.FileName);
                string filename = Guid.NewGuid().ToString() + ext;
                string path = Server.MapPath("~/Uploads/" + filename);
                fuGroupPhoto.SaveAs(path);
                checklistRow["Photo"] = "~/Uploads/" + filename;
            }
            else
            {
                checklistRow["Photo"] = lblExistingPhoto.Text;
            }

            _dataset.JCC_Checklist.Rows.Add(checklistRow);
            _dataset.JCC_Checklist.Rows[0].AcceptChanges();
            _dataset.JCC_Checklist.Rows[0].SetModified();

            
            DataSet3 ds = ViewState["TeamDataset"] as DataSet3;

            int checklistid = Convert.ToInt32(hfChecklistID.Value);

            foreach (var row in ds.JCC_Employee)
            {
                if (row.Checklist_ID == 0)
                    row.Checklist_ID = checklistid;
            }
            
            JCC_EmployeeTableAdapter adapter = new JCC_EmployeeTableAdapter();
            adapter.Update(ds.JCC_Employee);




            // Load ChecklistInfo
            string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM JCC_ChecklistInfo WHERE Checklist_ID = @ChecklistID", CS);
            da.SelectCommand.Parameters.AddWithValue("@ChecklistID", hfChecklistID.Value);
            da.MissingSchemaAction = MissingSchemaAction.AddWithKey;
            new SqlCommandBuilder(da).GetUpdateCommand();
            da.Fill(_dataset.JCC_ChecklistInfo);

            // Loop and update
            foreach (RepeaterItem parent in DictionaryRepeater.Items)
            {
                Repeater child = (Repeater)parent.FindControl("ChildRepeater");
                Label group = (Label)parent.FindControl("Grp_detail");

                foreach (RepeaterItem item in child.Items)
                {
                    HiddenField hidId = (HiddenField)item.FindControl("ChecklistInfoId");
                    int infoId = Convert.ToInt32(hidId.Value);
                    DataRow infoRow = _dataset.JCC_ChecklistInfo.Rows.Find(infoId);
                    if (infoRow == null) continue;

                    RadioButtonList rbl = (RadioButtonList)item.FindControl("result");
                    TextBox remark = (TextBox)item.FindControl("Remark_text");
                    TextBox note = (TextBox)item.FindControl("Note_text");
                    DropDownList severity = (DropDownList)item.FindControl("ddlSeverity");
                    CheckBox capa = (CheckBox)item.FindControl("CapaPoint");
                    FileUpload photo = (FileUpload)item.FindControl("Before_pic");
                    Label requirement = (Label)item.FindControl("Requirement");
                    Label existingImage = (Label)item.FindControl("Img");


                    // CAPA logic
                    string oldResult = infoRow["Result"] != DBNull.Value ? infoRow["Result"].ToString() : "OK";


                    string oldCapaId = infoRow["CAPA_ID"] != DBNull.Value ? infoRow["CAPA_ID"].ToString() : null;

                   

                    infoRow["Applicability"] = group.Text;
                    infoRow["CheckPoints"] = requirement.Text;
                    infoRow["Result"] = rbl.SelectedValue;
                    infoRow["Remarks"] = remark.Text;
                    infoRow["Note"] = note.Text;
                    infoRow["Severity"] = severity.SelectedValue;

                    if (photo.HasFile)
                    {
                        string filename = Guid.NewGuid().ToString() + "_" + Path.GetFileName(photo.FileName);
                        string folderPath = Server.MapPath("~/uploads/");
                        if (!Directory.Exists(folderPath))
                        {
                            Directory.CreateDirectory(folderPath);
                        }

                        string filePath = Path.Combine(folderPath, filename);
                        photo.SaveAs(filePath);
                        infoRow["Beforephoto"] = filename;
                    }
                    else if (existingImage.Text != "" && rbl.SelectedValue == "NotOK")
                    {
                        infoRow["Beforephoto"] = existingImage.Text;
                    }
                    else
                    {
                        infoRow["Beforephoto"] = null;
                    }

                    string customid = "JCC-" + hfChecklistID.Value.ToString();
                    infoRow["Custom_Id"] = customid;

                    bool newResult = rbl.SelectedValue == "OK" || rbl.SelectedValue == "NA";
                    bool isCapaChecked = capa != null && capa.Checked;

                    if (!newResult && isCapaChecked)
                    {
                        // creating a new CAPA if previous result was OK and now changed to Not OK
                        if (oldResult == "OK" || oldResult == "NA") 
                        {
                            using (SqlConnection con = new SqlConnection(CS))
                            {
                                con.Open();

                                string filename = infoRow["Beforephoto"] != DBNull.Value ? infoRow["Beforephoto"].ToString() : null;

                                string insertCapaSql = @"
                                                INSERT INTO tbl_CAPAMaster 
                                                (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate,SourceTable, Description)
                                                VALUES 
                                                (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate, @SourceTable, @Description);
                                                SELECT SCOPE_IDENTITY();";

                                using (SqlCommand capaCmd = new SqlCommand(insertCapaSql, con))
                                {
                                    capaCmd.Parameters.AddWithValue("@HeaderID", customid);
                                    capaCmd.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(filename) ? (object)DBNull.Value : filename);
                                    capaCmd.Parameters.AddWithValue("@Remarks", remark.Text);

                                    // Safely retrieve AssignedBy from Session
                                    string assignedBy = (Session["USERID"] != null) ? Session["USERID"].ToString() : "Unknown";
                                    capaCmd.Parameters.AddWithValue("@AssignedBy", assignedBy);
                                    capaCmd.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                                    capaCmd.Parameters.AddWithValue("@SourceTable", "Quick JCC Checklist");
                                    capaCmd.Parameters.AddWithValue("@Description", requirement.Text);

                                    object result = capaCmd.ExecuteScalar();
                                    int newCapaId = Convert.ToInt32(result);
                                    infoRow["CAPA_ID"] = newCapaId;

                                }
                            }
                        }
                        else
                        {
                            // Result is still Not OK, and was already Not OK before — reuse old CAPA ID
                            infoRow["CAPA_ID"] = oldCapaId;
                        }
                    }

                    else
                    {

                        infoRow["CAPA_ID"] = oldCapaId;

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

            // Update dataset
            new JCC_ChecklistTableAdapter().Update(_dataset);
            new JCC_EmployeeTableAdapter().Update(_dataset);
            new JCC_ChecklistInfoTableAdapter().Update(_dataset);

            string Data_SuccessScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Sucess',
                                text: 'Checklist Updated Successfully!!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

            // RegisterStartupScript adds the JavaScript code to the page
            ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
        }











        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public static object GetEmployeeDetails(string empCode)
        {
            string empName = "";
            string designation = "";

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT EmployeeName, Designation FROM EmployeeMaster WHERE EmployeeCode = @EmployeeCode";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeCode", empCode);
                    con.Open();
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            empName = rdr["EmployeeName"].ToString();
                            designation = rdr["Designation"].ToString();
                        }
                    }
                }
            }

            return new { EmpName = empName, Designation = designation };
        }

        private DataTable TeamTable
        {
            get
            {
                if (ViewState["TeamTable"] == null)
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("Employee_Type", typeof(string));
                    dt.Columns.Add("Employee_Code", typeof(string));
                    dt.Columns.Add("Employee_Name", typeof(string));
                    dt.Columns.Add("Designation", typeof(string));
                    ViewState["TeamTable"] = dt;
                }
                return (DataTable)ViewState["TeamTable"];
            }
            set
            {
                ViewState["TeamTable"] = value;
            }
        }

        protected void btnAddTeamMember_Click(object sender, EventArgs e)
        {
            // Initialize dataset if null
            

            if(ViewState["TeamDataset"] != null)
            {
                _dataset = ViewState["TeamDataset"] as DataSet3;
            }

            string empCode = txtEmpCode.Text.Trim();

            // Update mode
            if (btnAddTeamMember.Text == "Update" && !string.IsNullOrEmpty(hfEditEmpCode.Value))
            {
                var existingRow = _dataset.JCC_Employee.FirstOrDefault(r => r.Employee_Code == hfEditEmpCode.Value);
                if (existingRow != null)
                {
                    existingRow.Employee_Code = txtEmpCode.Text.Trim();
                    existingRow.Employee_Name = txtEmpName.Text.Trim();
                    existingRow.Designation = txtDesignation.Text.Trim();
                    existingRow.Employee_Type = rblEmpType.SelectedValue;

                    if (existingRow.RowState == DataRowState.Unchanged)
                    {
                        existingRow.AcceptChanges();
                        existingRow.SetModified();
                    }
                }

                // Reset form state
                btnAddTeamMember.Text = "Add";
                hfEditEmpCode.Value = "";
                txtEmpCode.Enabled = true;
            }
            else
            {
                // Prevent duplicates
                bool exists = _dataset.JCC_Employee.Any(r => r.Employee_Code == empCode);
                if (exists)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "dupe", "alert('Employee already added.');", true);
                    return;
                }

                string safeEmpCode = string.IsNullOrWhiteSpace(txtEmpCode.Text) ? "NA" : txtEmpCode.Text;

                DataSet3.JCC_EmployeeRow row = _dataset.JCC_Employee.NewJCC_EmployeeRow();
                row["Checklist_ID"] = 0;
                row["Employee_Type"] = rblEmpType.SelectedValue;
                row["Employee_Code"] = safeEmpCode;
                row["Employee_Name"] = txtEmpName.Text;
                row["Designation"] = txtDesignation.Text;

                _dataset.JCC_Employee.AddJCC_EmployeeRow(row);
            }

            // Save dataset to ViewState and bind
            ViewState["TeamDataset"] = _dataset;
            
            gvTeamMembers.DataSource = _dataset.JCC_Employee;
            gvTeamMembers.DataBind();

            // Clear form fields
            txtEmpCode.Text = "";
            txtEmpName.Text = "";
            txtDesignation.Text = "";
            rblEmpType.ClearSelection();
        }

        protected void gvTeamMembers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            DataSet3 ds = ViewState["TeamDataset"] as DataSet3;
            if (ds == null) return;

            int rowIndex = Convert.ToInt32(e.CommandArgument);
            string emp = gvTeamMembers.DataKeys[rowIndex].Value.ToString();

            if (e.CommandName == "EditRow")
            {
                //var row = ds.JCC_Employee.FirstOrDefault(r => r.Employee_Code == empCode);
                var row = ds.JCC_Employee[rowIndex];
                if (row != null)
                {
                    rblEmpType.SelectedValue = row.Employee_Type;
                    txtEmpCode.Text = row.Employee_Code;
                    txtEmpName.Text = row.Employee_Name;
                    txtDesignation.Text = row.Designation;

                    hfEditEmpCode.Value = row.Employee_Code;
                    txtEmpCode.Enabled = false;
                    btnAddTeamMember.Text = "Update";
                }
            }
            else if (e.CommandName == "DeleteRow")
            {
                var row = ds.JCC_Employee[rowIndex];
                if (row != null)
                {
                    row.Delete(); // Marks the row as deleted
                    //ds.JCC_Employee.Rows[0].AcceptChanges();
                    //ds.JCC_Employee.Rows[0].SetModified();// Permanently removes it
                }

                ViewState["TeamDataset"] = ds;

                // Rebind only remaining rows
                var currentRows = ds.JCC_Employee
                    .Where(r => r.RowState != DataRowState.Deleted)
                    .ToList();

                if (currentRows.Any())
                    gvTeamMembers.DataSource = currentRows.CopyToDataTable();
                else
                    gvTeamMembers.DataSource = null;

                gvTeamMembers.DataBind();


            } 
        }

        protected void ChildRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType.ToString() == "Item" || e.Item.ItemType.ToString() == "AlternatingItem")
            {
                var dataItem = e.Item.DataItem.GetType().GetProperties();

                int count = dataItem.Length;

                if (dataItem.Length > 7)
                {
                    if (dataItem[3].GetValue(e.Item.DataItem).ToString() != "")
                    {
                        ((RadioButtonList)e.Item.Controls[9]).SelectedValue = dataItem[3].GetValue(e.Item.DataItem).ToString();
                    }

                    if (dataItem[4].GetValue(e.Item.DataItem).ToString() != "")
                    {
                        ((TextBox)e.Item.Controls[11]).Text = dataItem[4].GetValue(e.Item.DataItem).ToString();
                    }

                    if (dataItem[5].GetValue(e.Item.DataItem).ToString() != "")
                    {
                        ((DropDownList)e.Item.Controls[15]).SelectedValue = dataItem[5].GetValue(e.Item.DataItem).ToString();
                    }

                    if (dataItem[6].GetValue(e.Item.DataItem) != null)
                    {
                        ((Label)e.Item.FindControl("Img")).Text = dataItem[6].GetValue(e.Item.DataItem).ToString();
                        ((Label)e.Item.FindControl("Img")).Visible = true;
                    }
                    if (dataItem.Length > 7 && dataItem[7].GetValue(e.Item.DataItem) != null)
                    {
                        ((TextBox)e.Item.Controls[26]).Text = dataItem[7].GetValue(e.Item.DataItem).ToString();
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