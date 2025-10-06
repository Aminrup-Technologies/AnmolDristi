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
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;
using System.Diagnostics;

namespace AnmolDristi
{
    public partial class WeldingMachineChecklist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindChecklist();
                BindChecklist_Terminals();
                BindChecklist_Cables();
                BindChecklist_ElectrodeHolder();
                BindChecklist_WorkArea();
            }
            else
            {
                // On postback, rebind the name from hidden field to textbox so it doesn't disappear
                txtDocNo.Text = hfEmployeeName.Value;
            }
        }

        [System.Web.Services.WebMethod]
        public static string GetEmployeeName(string empCode)
        {
            string empName = "";
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT EmployeeName FROM MST_UserMaster WHERE EmployeeCode = @EmployeeCode";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeCode", empCode);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        empName = result.ToString();
                    }
                }
            }

            return empName;
        }


        //[WebMethod]
        //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        //public static string GetEmployeeName(string inspectionId)
        //{
        //    string employeeName = string.Empty;

        //    string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //    string query = "SELECT EmployeeName FROM [CSMS].[dbo].[WeldingChecklistHeader] WHERE InspectedBy = @InspectedBy";

        //    using (SqlConnection conn = new SqlConnection(connStr))
        //    {
        //        SqlCommand cmd = new SqlCommand(query, conn);
        //        cmd.Parameters.AddWithValue("@InspectedBy", inspectionId);

        //        try
        //        {
        //            conn.Open();
        //            var result = cmd.ExecuteScalar();
        //            if (result != null)
        //            {
        //                employeeName = result.ToString();
        //            }
        //            else
        //            {
        //                employeeName = "Invalid Inspection ID";
        //            }
        //        }
        //        catch
        //        {
        //            employeeName = "Error occurred while fetching data";
        //        }
        //    }

        //    return employeeName;
        //}

        private void BindChecklist()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));
            dt.Rows.Add(1, "In good working condition.");
            dt.Rows.Add(2, "Provided with earthing in grounding.");
            dt.Rows.Add(3, "Fire extinguisher is available.");
            dt.Rows.Add(4, "Rubber mat available.");
            dt.Rows.Add(5, "Double earthing.");
            rptChecklist.DataSource = dt;
            rptChecklist.DataBind();
        }
        private void BindChecklist_Cables()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(10, "Is the cables free from heat.");
            dt.Rows.Add(11, "Properly insulated and no exposed cables.");
            dt.Rows.Add(12, "Size of cable suitable for voltage supply.");
            dt.Rows.Add(13, "Hang up to prevent tripping hazard.");
            dt.Rows.Add(14, "Hang on insulated hook or material.");
            dt.Rows.Add(15, "Cables and joints are properly and in good condition.");

            rptCables.DataSource = dt;
            rptCables.DataBind();
        }
        private void BindChecklist_Terminals()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(6, "In good working condition.");
            dt.Rows.Add(7, "Secured and effectively insulated.");
            dt.Rows.Add(8, "Is joint in healthy condition.");
            dt.Rows.Add(9, "Is the lugging was crimped with tool.");

            rptTerminals.DataSource = dt;
            rptTerminals.DataBind();
        }
        private void BindChecklist_ElectrodeHolder()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(16, "Electrode holder is free from defects.");
            dt.Rows.Add(17, "Return cable clamp is free from defects.");
            dt.Rows.Add(18, "Detech electrodes when not in use.");

            rptElectrodeHolder.DataSource = dt;
            rptElectrodeHolder.DataBind();
        }
        private void BindChecklist_WorkArea()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(19, "No combustible or flammable material.");
            dt.Rows.Add(20, "Fire Blanket is provided.");
            dt.Rows.Add(21, "Maintain good housekeeping.");
            dt.Rows.Add(22, "Flooring is free from water.");

            rptWorkArea.DataSource = dt;
            rptWorkArea.DataBind();
        }

        private string GenerateWCHeaderID()
        {
            string id = "";
            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT dbo.GenerateWCHeaderID()", con))
                {
                    con.Open();
                    id = cmd.ExecuteScalar().ToString();
                }
            }
            return id;
        }
       
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                
                con.Open();

                // 1. Generate unique string ID for Header
                string headerID = GenerateWCHeaderID(); // e.g., "HDR001"

                // 2. Insert into WeldingChecklistHeader
                string insertHeaderQuery = @"
                           INSERT INTO WeldingChecklistHeader 
                           (HeaderID, ChecklistDate, JobID, Location, EmployeeName, InspectedBy, Remarks)
                           VALUES 
                           (@HeaderID, @ChecklistDate, @JobID, @Location, @EmployeeName, @InspectedBy, @Remarks)";

                SqlCommand cmdHeader = new SqlCommand(insertHeaderQuery, con);
                cmdHeader.Parameters.AddWithValue("@HeaderID", headerID);
                cmdHeader.Parameters.AddWithValue("@ChecklistDate", Convert.ToDateTime(txtdate.Text));
                cmdHeader.Parameters.AddWithValue("@JobID", txtjobId.Text);
                cmdHeader.Parameters.AddWithValue("@Location", txtloc.Text);
                cmdHeader.Parameters.AddWithValue("@EmployeeName", hfEmployeeName.Value.Trim());  
                cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text);
                cmdHeader.Parameters.AddWithValue("@Remarks", txtnote.Text);

                cmdHeader.ExecuteNonQuery();

                // 3. Save checklist items from all repeaters
                SaveChecklistItemsFromRepeater(rptChecklist, con, headerID);
                SaveChecklistItemsFromRepeater(rptTerminals, con, headerID);
                SaveChecklistItemsFromRepeater(rptCables, con, headerID);
                SaveChecklistItemsFromRepeater(rptElectrodeHolder, con, headerID);
                SaveChecklistItemsFromRepeater(rptWorkArea, con, headerID);

                con.Close();
            }

            // PNotify after successful save
            ShowPNotify("Success", "Data saved successfully!", "success");
        }
            catch (Exception ex)
            {
                ShowPNotify("Error", "Error while saving data: " + ex.Message, "error");
    }
}

        private void SaveChecklistItemsFromRepeater(Repeater rpt, SqlConnection con, string headerID)
        {
            foreach (RepeaterItem item in rpt.Items)
            {
               
                HiddenField hfQuestionNumber = (HiddenField)item.FindControl("hfQuestionNumber");
                int questionNumber = Convert.ToInt32(hfQuestionNumber.Value);

                int qn = 0;
                if (hfQuestionNumber != null && int.TryParse(hfQuestionNumber.Value, out qn))
                {
                    questionNumber = qn;
                }


                RadioButton rdoYes = (RadioButton)item.FindControl("rdoYes");
                RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");
                RadioButton rdoNA = (RadioButton)item.FindControl("rdoNA");

                TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                CheckBox chkCapaReport = (CheckBox)item.FindControl("chkCapaReport");

                // --- Determine status ---
                string status = "";
                if (rdoYes != null && rdoYes.Checked)
                {
                    status = "Yes";
                }
                else if (rdoNo != null && rdoNo.Checked)
                {
                    status = "No";
                }
                else if (rdoNA != null && rdoNA.Checked)
                {
                    status = "NA";
                }

                // --- Convert to DB value for single column IsOk ---
                object isOkValue = status == "Yes" ? 1
                                  : status == "No" ? 0
                                  : (object)DBNull.Value; // NA

                string remarks = txtRemarks?.Text ?? "";
                //string photoPath = "";

               
                Label lblDescription = (Label)item.FindControl("lblDescription");
                string description = lblDescription?.Text ?? "";
                string checklistPhotoPath = "";
                if (fileUpload != null && fileUpload.HasFile)
                {
                    string fileName = Path.GetFileName(fileUpload.FileName);
                    string savePath = Server.MapPath("~/Uploads1/" + fileName);
                    fileUpload.SaveAs(savePath);
                    checklistPhotoPath = "~/Uploads1/" + fileName;
                }
                object capaReportID = DBNull.Value;

                
                if (chkCapaReport != null && chkCapaReport.Checked)
                {
                    SqlCommand cmdCAPA = new SqlCommand(@"
                        INSERT INTO tbl_CAPAMaster 
                        (HeaderID, PhotoPath, Remarks, AssignedBy, AssignedDate,Description)
                        OUTPUT INSERTED.CAPAID
                        VALUES 
                        (@HeaderID, @PhotoPath, @Remarks, @AssignedBy, @AssignedDate,@Description)", con);

                    cmdCAPA.Parameters.AddWithValue("@HeaderID", headerID);
                    cmdCAPA.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                    cmdCAPA.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
                    cmdCAPA.Parameters.AddWithValue("@AssignedBy", Session["UserName"]?.ToString() ?? "");
                    cmdCAPA.Parameters.AddWithValue("@AssignedDate", DateTime.Now);
                    cmdCAPA.Parameters.AddWithValue("@Description", lblDescription.Text);


                    capaReportID = cmdCAPA.ExecuteScalar(); // Get the newly inserted CAPAID
                }


                string insertDetailQuery = @"
            INSERT INTO WeldingChecklist (HeaderID, QuestionNumber, IsOk, Remarks, PhotoPath, description,CAPA_Report)
            VALUES (@HeaderID, @QuestionNumber, @IsOk, @Remarks, @PhotoPath,@description,@CAPA_Report)";

                SqlCommand cmdDetail = new SqlCommand(insertDetailQuery, con);
                cmdDetail.Parameters.AddWithValue("@HeaderID", headerID);
                cmdDetail.Parameters.AddWithValue("@QuestionNumber", questionNumber);
                cmdDetail.Parameters.AddWithValue("@IsOk", isOkValue);
                cmdDetail.Parameters.AddWithValue("@Remarks", remarks);
                cmdDetail.Parameters.AddWithValue("@PhotoPath", checklistPhotoPath);
                //cmdDetail.Parameters.AddWithValue("@NA", na);
                cmdDetail.Parameters.AddWithValue("@description", description);
                cmdDetail.Parameters.AddWithValue("@Capa_Report", capaReportID);
                cmdDetail.ExecuteNonQuery();
            }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("WeldingMachineChecklist.aspx");
        }

        private void ShowPNotify(string title, string message, string type)
        {
            string script = $@"
        new PNotify({{
            title: '{title}',
            text: '{message}',
            type: '{type}',  // success | error | info | notice
            styling: 'bootstrap3',
            delay: 2500,
            addclass: 'stack-topright'
        }});";

            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), script, true);
        }
    }
}