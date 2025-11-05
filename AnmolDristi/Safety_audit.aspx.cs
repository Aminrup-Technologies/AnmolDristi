using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace AnmolDristi
{
    public partial class Safety_audit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["USERID"] == null || Session["USERNAME"] == null || Session["WORKMAN"] == null)
                {
                    Response.Redirect("login.aspx");
                }

                
                LoadSafetyAuditDetails();// Clear existing controls
            }
        }

        protected void DdlGoodCitizens_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl != null)
            {
                string selectedValue = ddl.SelectedValue;
                Console.WriteLine(selectedValue); // Example of using the variable
            }


        }

        protected void ShowRadioButtons(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl != null)
            {
                
                string selectedValue = ddl.SelectedValue;

                // Perform any action based on the selected value
                if (!string.IsNullOrEmpty(selectedValue))
                {
                    // Example: Show or enable certain radio buttons based on selection
                    Console.WriteLine(selectedValue);  
                }
            }
        }


        protected void DdlUnsafeAct_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl != null)
            {
                string selectedValue = ddl.SelectedValue;

                if (!string.IsNullOrEmpty(selectedValue))
                {
                    Console.WriteLine(selectedValue);
                }
            }
        }


        //protected void DdlDescriptionFields_SelectedIndexChanged(object sender, EventArgs e)
        //{

        //    //pnlRadioButtons.Controls.Clear(); // Clear previous radio buttons

        //    string selectedValue = ddlDescriptionFields.SelectedValue;
        //    ViewState["SelectedDDLValue"] = selectedValue;


        //    if (selectedValue == "GoodCitizens")
        //    {
        //        pnlRadioButtons.Controls.Add(new Literal { Text = "<b>Good Citizens:</b><br/>" });
        //        pnlRadioButtons.Controls.Add(CreateRadioButton("GoodCitizens", "Yes", "Yes"));
        //        pnlRadioButtons.Controls.Add(new Literal { Text = "&nbsp;&nbsp;" }); // Adding space
        //        pnlRadioButtons.Controls.Add(CreateRadioButton("GoodCitizens", "No", "No"));
        //    }
        //    else if (selectedValue == "NoOfViolations" || selectedValue == "Severity" || selectedValue == "ViolationSeverity" || selectedValue == "FourAndFive")
        //    {
        //        pnlRadioButtons.Controls.Add(new Literal { Text = "<b>Choose a Value:</b><br/>" });
        //        for (int i = 0; i <= 6; i++)
        //        {
        //            pnlRadioButtons.Controls.Add(CreateRadioButton(selectedValue, i.ToString(), i.ToString()));
        //            pnlRadioButtons.Controls.Add(new Literal { Text = "&nbsp;&nbsp;" }); // Add space between buttons
        //        }
        //    }
        //    else if (selectedValue == "UnsafeAct")
        //    {
        //        pnlRadioButtons.Controls.Add(new Literal { Text = "<b>Unsafe Act & Condition:</b><br/>" });
        //        pnlRadioButtons.Controls.Add(CreateRadioButton("UnsafeAct", "Good", "Good"));
        //        pnlRadioButtons.Controls.Add(new Literal { Text = "&nbsp;&nbsp;" }); // Add space
        //        pnlRadioButtons.Controls.Add(CreateRadioButton("UnsafeAct", "Bad", "Bad"));
        //    }
        //}


        //private RadioButton CreateRadioButton(string groupName, string value, string text)
        //{
        //    RadioButton rb = new RadioButton
        //    {
        //        GroupName = groupName,
        //        Text = text,
        //        ID = "rb_" + groupName + "_" + value
        //    };
        //    return rb;
        //}


        private string GenerateSafetyAuditCAPAID(SqlConnection conn, SqlTransaction transaction)
        {
            string newID = "SF001";
            string query = "SELECT MAX(CAPAID) FROM SafetyAudit_Description WHERE CAPAID IS NOT NULL";

            using (SqlCommand cmd = new SqlCommand(query, conn, transaction))
            {
                object result = cmd.ExecuteScalar();
                if (result != DBNull.Value && result != null)
                {
                    string lastID = result.ToString(); // e.g., "SF010"
                    int num = int.Parse(lastID.Substring(2)); // get 010 -> 10
                    newID = "SF" + (num + 1).ToString("D3");
                }
            }

            return newID;
        }



        private void LoadSafetyAuditDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = @"
                    SELECT 
    sa.ID, sa.Department, sa.Section, sa.Date, sa.Time, 
    sa.ContractorVendorCode, sa.TotalContractorPeople, 
    sev.AuditID, sev.InternalEmployees, sev.ExternalMembers,
    sdesc.Description, sdesc.GoodCitizens, sdesc.NoOfViolations, 
    sdesc.Severity, sdesc.ViolationXSeverity, sdesc.FourAndFive, 
    sdesc.UnsafeActConditions, sdesc.SubmittedDate, sdesc.SubmittedTime,
    sdesc.CAPAID  
FROM SafetyAudit_Main sa
LEFT JOIN SafetyAudit_Severity sev ON sa.ID = sev.AuditID
LEFT JOIN SafetyAudit_Description sdesc ON sa.ID = sdesc.AuditID
ORDER BY sa.Date DESC
";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                        }
                    }
                }
                catch (SqlException ex)
                {
                    Console.WriteLine("SQL Error: " + ex.Message);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error: " + ex.Message);
                }
            }
        }


        protected void BtnAddSection_Click(object sender, EventArgs e)
        {
            int sectionIndex = (int)(ViewState["SectionCount"] ?? 0) + 1;
            ViewState["SectionCount"] = sectionIndex;

            string capaId;

            // Maintain a list of generated CAPAIDs in ViewState
            if (ViewState["CAPAIDList"] == null)
                ViewState["CAPAIDList"] = new List<string>();

            List<string> capaIdList = (List<string>)ViewState["CAPAIDList"];
            string lastGeneratedCAPAID = capaIdList.Count > 0 ? capaIdList.Last() : null;

            if (string.IsNullOrEmpty(lastGeneratedCAPAID))
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
                {
                    conn.Open();
                    using (SqlTransaction tx = conn.BeginTransaction())
                    {
                        lastGeneratedCAPAID = GenerateSafetyAuditCAPAID(conn, tx);  // e.g., SF011
                        tx.Commit();
                    }
                }
            }
            else
            {
                int num = int.Parse(lastGeneratedCAPAID.Substring(2));
                lastGeneratedCAPAID = "SF" + (num + 1).ToString("D3"); // e.g., SF012
            }

            capaIdList.Add(lastGeneratedCAPAID);             // Save for future reference
            ViewState["CAPAIDList"] = capaIdList;
            capaId = lastGeneratedCAPAID;

            AddSection(sectionIndex, capaId);
        }


        private void AddSection(int index, string capaId)

        {
            // Create a new table
            Table newSection = new Table();
            newSection.CssClass = "table table-bordered mb-3";

            // ===== Row 1: Description =====
            TableRow row1 = new TableRow();
            row1.Cells.Add(new TableCell { Text = "<b>Description:</b>" });

            TextBox txtDescription = new TextBox
            {
                ID = $"txtDescription_{index}",
                CssClass = "form-control",
                TextMode = TextBoxMode.MultiLine,
                Rows = 3
            };

            RequiredFieldValidator rfvDescription = new RequiredFieldValidator
            {
                ControlToValidate = txtDescription.ID,
                ErrorMessage = "Description is required.",
                ForeColor = System.Drawing.Color.Red,
                Display = ValidatorDisplay.Dynamic,
                ID = $"rfvDescription_{index}"
            };

            TableCell cell1 = new TableCell();
            cell1.Controls.Add(txtDescription);
            cell1.Controls.Add(rfvDescription);
            row1.Cells.Add(cell1);
            newSection.Rows.Add(row1);

            // ===== Row 2: Dropdown for Good Citizens =====
            TableRow row2 = new TableRow();
            row2.Cells.Add(new TableCell { Text = "<b>Good Citizens:</b>" });

            DropDownList ddl = new DropDownList
            {
                ID = $"ddlGoodCitizens_{index}",
                CssClass = "form-control form-control-sm rounded"
            };
            ddl.Items.Add(new ListItem("-- Select --", ""));
            ddl.Items.Add(new ListItem("Yes", "Yes"));
            ddl.Items.Add(new ListItem("No", "No"));

            RequiredFieldValidator rfvDdl = new RequiredFieldValidator
            {
                ControlToValidate = ddl.ID,
                ErrorMessage = "Selection is required.",
                ForeColor = System.Drawing.Color.Red,
                Display = ValidatorDisplay.Dynamic,
                InitialValue = "",
                ID = $"rfvDdl_{index}"
            };

            TableCell cell2 = new TableCell();
            cell2.Controls.Add(ddl);
            cell2.Controls.Add(rfvDdl);
            row2.Cells.Add(cell2);
            newSection.Rows.Add(row2);

            // Add section to a PlaceHolder or Panel on your page
            //   SectionPlaceHolder.Controls.Add(newSection);
            TableCell capaCell = new TableCell();
            capaCell.Controls.Add(new Label
            {
                ID = $"lblCAPAID_{index}",
                Text = capaId,
                CssClass = "form-label text-primary"
            });
            TableRow capaRow = new TableRow();
            capaRow.Cells.Add(new TableCell { Text = "<b>CAPA ID:</b>" });
            capaRow.Cells.Add(capaCell);
            newSection.Rows.Add(capaRow);

            // Add to placeholder
            SectionPlaceHolder.Controls.Add(newSection);
        }



        [WebMethod]
        public static string GetEmployeeName(string empCode)
        {
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string query = "SELECT EmployeeName FROM MST_UserMaster WHERE EmployeeCode = @EmpCode";
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmpCode", empCode);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    return result != null ? result.ToString() : "";
                }
            }
        }

        [WebMethod]
        public static string SaveMembers(string internalEmployeesCSV, string externalMembersCSV)
        {
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string teamMembers = (internalEmployeesCSV + "," + externalMembersCSV).Trim(',');
            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();
                string query = "INSERT INTO tbl_Members (InternalEmployees, ExternalMembers) VALUES (@Internal, @External)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Internal", string.IsNullOrEmpty(internalEmployeesCSV) ? (object)DBNull.Value : internalEmployeesCSV);
                    cmd.Parameters.AddWithValue("@External", string.IsNullOrEmpty(externalMembersCSV) ? (object)DBNull.Value : externalMembersCSV);
                    //cmd.ExecuteNonQuery();
                }
            }
            return "Members saved successfully!";
        }






        protected void SubmitSafetyAudit_Click(object sender, EventArgs e)
        {
            try
            {
                SaveSafetyAuditData();
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Safety Audit Report saved successfully!";
                btnSubmit.Enabled = false;
                btnSubmit.Text = "Saved";
                btnSubmit.CssClass = "btn btn-success";
                LoadSafetyAuditDetails();
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }



        private void SaveSafetyAuditData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            int auditID;

            string department = txtDepartment.Text;
            string section = txtSection.Text;
            string date = txtDate.Text;
            string time = txtTime.Text;
            string vendorCode = txtContractorVendorCode.Text;
            int totalPeople = Convert.ToInt32(txtTotalContractorPeople.Text);

            string observationDataJson = hdnObservationData.Value;
            List<Observation> observations = new List<Observation>();

            if (!string.IsNullOrEmpty(observationDataJson))
            {
                observations = JsonConvert.DeserializeObject<List<Observation>>(observationDataJson);
            }

            string internalEmployeesCSV = hdnInternalEmployees.Value;
            string externalMembersCSV = hdnExternalMembers.Value;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // Insert into SafetyAudit_Main
                    using (SqlCommand cmd = new SqlCommand("[MahimaGupta_CSMS].usp_InsertSafetyAuditMain", conn, transaction))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@Department", department);
                        cmd.Parameters.AddWithValue("@Section", section);
                        cmd.Parameters.AddWithValue("@Date", date);
                        cmd.Parameters.AddWithValue("@Time", time);
                        cmd.Parameters.AddWithValue("@ContractorVendorCode", vendorCode);
                        cmd.Parameters.AddWithValue("@TotalContractorPeople", totalPeople);

                        SqlParameter outputIdParam = new SqlParameter("@AuditID", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputIdParam);

                        cmd.ExecuteNonQuery();
                        auditID = (int)outputIdParam.Value;
                    }

                    // Insert Team Members
                    using (SqlCommand cmd = new SqlCommand("[MahimaGupta_CSMS].usp_InsertSafetyAuditSeverity", conn, transaction))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@AuditID", auditID);
                        cmd.Parameters.AddWithValue("@InternalEmployees", string.IsNullOrEmpty(internalEmployeesCSV) ? (object)DBNull.Value : internalEmployeesCSV);
                        cmd.Parameters.AddWithValue("@ExternalMembers", string.IsNullOrEmpty(externalMembersCSV) ? (object)DBNull.Value : externalMembersCSV);

                        cmd.ExecuteNonQuery();
                    }

                    String customid = "SF" + auditID.ToString();

                    
                    // Insert Observations
                    if (observations != null && observations.Any())
                    {
                        foreach (var obs in observations)
                        {
                            //string newCapaid = null;
                            int? newCapaid = null;

                            if (obs.RequiresCAPA)
                            {
                                // Generate CAPA ID (e.g., SF001)
                                //capaId = GenerateSafetyAuditCAPAID(conn, transaction);

                                // Insert into tbl_CAPAMaster
                                using (SqlCommand cmdCAPA = new SqlCommand(@"
                                                INSERT INTO tbl_CAPAMaster 
                                                (HeaderID, Remarks, AssignedBy, AssignedDate, Description, SourceTable)
                                                VALUES (@HeaderID, @Remarks, @AssignedBy, @AssignedDate,@Description,@SourceTable); SELECT SCOPE_IDENTITY();", conn, transaction))
                                {
                                    cmdCAPA.Parameters.AddWithValue("@HeaderID", customid);
                                    cmdCAPA.Parameters.AddWithValue("@Remarks", obs.Description ?? (object)DBNull.Value);
                                    cmdCAPA.Parameters.AddWithValue("@AssignedBy", Session["UserName"] ?? "System");
                                    cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                                    cmdCAPA.Parameters.AddWithValue("@Description", obs.Description);
                                    cmdCAPA.Parameters.AddWithValue("@SourceTable", "Safety Audit");

                                   object result = cmdCAPA.ExecuteScalar();
                                     newCapaid = Convert.ToInt32(result);
                                }
                            }

                           
                            // Insert into SafetyAudit_Description
                            using (SqlCommand cmd = new SqlCommand("MahimaGupta_CSMS.usp_InsertSafetyAuditDescription", conn, transaction))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;

                                cmd.Parameters.Add("@AuditID", SqlDbType.Int).Value = auditID;
                                cmd.Parameters.Add("@Description", SqlDbType.NVarChar, 1000).Value = obs.Description ?? (object)DBNull.Value;
                                cmd.Parameters.Add("@GoodCitizens", SqlDbType.NVarChar, 10).Value = obs.GoodCitizens ?? (object)DBNull.Value;
                                cmd.Parameters.Add("@NoOfViolations", SqlDbType.Int).Value = string.IsNullOrEmpty(obs.Violations) ? (object)DBNull.Value : Convert.ToInt32(obs.Violations);
                                cmd.Parameters.Add("@Severity", SqlDbType.Int).Value = string.IsNullOrEmpty(obs.Severity) ? (object)DBNull.Value : Convert.ToInt32(obs.Severity);
                                cmd.Parameters.Add("@ViolationSeverity", SqlDbType.Int).Value = string.IsNullOrEmpty(obs.ViolationXSeverity) ? (object)DBNull.Value : Convert.ToInt32(obs.ViolationXSeverity);
                                cmd.Parameters.Add("@FourAndFive", SqlDbType.Int).Value = string.IsNullOrEmpty(obs.FourAndFive) ? (object)DBNull.Value : Convert.ToInt32(obs.FourAndFive);
                                cmd.Parameters.Add("@UnsafeAct", SqlDbType.NVarChar, 50).Value = obs.UnsafeActs ?? (object)DBNull.Value;
                                // CAPAID should be null when not generated

                                cmd.Parameters.Add("@CAPAID", SqlDbType.NVarChar, 10).Value =
                                    newCapaid.HasValue ? newCapaid.ToString() : (object)DBNull.Value;

                                cmd.Parameters.Add("@Custom_ID", SqlDbType.NVarChar, 50).Value = customid;
                                cmd.Parameters.Add("@GenerateCAPA", SqlDbType.Bit).Value = obs.RequiresCAPA;

                                DateTime safeSubmittedDate = obs.SubmittedDate < new DateTime(1753, 1, 1)
                                    ? DateTime.Now
                                    : obs.SubmittedDate;

                                TimeSpan safeSubmittedTime = obs.SubmittedTime == TimeSpan.Zero
                                    ? DateTime.Now.TimeOfDay
                                    : obs.SubmittedTime;

                                cmd.Parameters.AddWithValue("@SubmittedDate", safeSubmittedDate);
                                cmd.Parameters.AddWithValue("@SubmittedTime", safeSubmittedTime);

                                cmd.ExecuteNonQuery();
                            }
                        }
                    }

                    transaction.Commit();
                    //  success
                    ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-success", @"
                        new PNotify({
                            title: 'Successful',
                            text: 'Form saved successfully.',
                            type: 'success',
                            styling: 'bootstrap3',
                            delay: 2500
                        });
                    ", true);
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    ScriptManager.RegisterStartupScript(this, GetType(), "pnotify-error", $@"
                            new PNotify({{
                                title: 'Failed',
                                text: 'Error: {ex.Message.Replace("'", " ")}',
                                type: 'error',
                                styling: 'bootstrap3',
                                delay: 3000
                            }});
                        ", true);
                }
            }
        }


        public class Observation
        {
            public string Description { get; set; }
            public string GoodCitizens { get; set; }
            public string Violations { get; set; }
            public string Severity { get; set; }
            public string ViolationXSeverity { get; set; }
            public string FourAndFive { get; set; }
            public string UnsafeActs { get; set; }
            public DateTime SubmittedDate { get; set; }
            public TimeSpan SubmittedTime { get; set; }
            public bool RequiresCAPA { get; set; }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            txtDepartment.Text = "";
            txtSection.Text = "";
            txtDate.Text = "";
            txtTime.Text = "";
            txtContractorVendorCode.Text = "";
            txtTotalContractorPeople.Text = "";
            txtExternalName.Text = "";
            hdnObservationData.Value = "";

        

            lblMessage.Text = "Form reset successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Blue;
        }
    }
}