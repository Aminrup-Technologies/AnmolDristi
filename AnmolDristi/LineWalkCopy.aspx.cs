using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class LineWalkCopy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["USERID"] == null || Session["USERNAME"] == null || Session["WORKMAN"] == null)
                {
                    Response.Redirect("login.aspx");
                }
                else
                {

                }
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            DataSaver();
        }

        protected void DataSaver()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    using (SqlTransaction transaction = con.BeginTransaction())
                    {
                        try
                        {
                            // Insert the main Line Walk Status
                            string insertWalkStatusQuery = @"INSERT INTO [Line_walk_status] ([WalkDate], [JobDescription], [JobID]) VALUES (@WalkDate, @JobDescription, @JobID); SELECT SCOPE_IDENTITY();";
                            int walkStatusId;
                            using (SqlCommand cmd = new SqlCommand(insertWalkStatusQuery, con, transaction))
                            {
                                cmd.Parameters.AddWithValue("@WalkDate", DateTime.Today);
                                cmd.Parameters.AddWithValue("@JobDescription", TB_JD.Text.Trim());
                                cmd.Parameters.AddWithValue("@JobID", TB_ID.Text.Trim());

                                walkStatusId = Convert.ToInt32(cmd.ExecuteScalar());
                                if (walkStatusId <= 0)
                                {
                                    throw new Exception("Failed to insert into Line_walk_status.");
                                }
                            }

                            // Fetch team members and save them
                            //List<TeamMember> teamMembers = GetTeamMembersFromForm();
                            DataTable dt = ViewState["EmpData"] as DataTable;
                            if (dt != null && dt.Rows.Count > 0)
                            {
                                foreach (DataRow row in dt.Rows)
                                {
                                    string insertTeamMemberQuery = @"INSERT INTO [Line_walk_status_description] ([ID], [TM_names]) VALUES (@ID, @TM_names);";
                                    using (SqlCommand cmdTeam = new SqlCommand(insertTeamMemberQuery, con, transaction))
                                    {
                                        cmdTeam.Parameters.AddWithValue("@ID", walkStatusId);
                                        cmdTeam.Parameters.AddWithValue("@TM_names", row["EmpName"]);
                                        if (cmdTeam.ExecuteNonQuery() == 0)
                                            throw new Exception("Failed to insert into Line_walk_status_description.");
                                    }
                                }
                            }


                            // Fetch observations from the session DataTable
                            DataTable dtObservations = ViewState["ObservationData"] as DataTable;

                            if (dtObservations != null && dtObservations.Rows.Count > 0)
                            {
                                foreach (DataRow row in dtObservations.Rows)
                                {
                                    string insertWalkDetailQuery = @"INSERT INTO [Line_walk_details] 
                                 ([ID], [Location], [Observation_Points], [Recommendation_Points], [Responsibility], 
                                  [Target_Date], [Remarks], [Snap_File_Path]) 
                                 VALUES (@ID, @Location, @Observation_Points, @Recommendation_Points, @Responsibility, 
                                         @Target_Date, @Remarks, @Snap_File_Path);";

                                    using (SqlCommand cmdWalkDetail = new SqlCommand(insertWalkDetailQuery, con, transaction))
                                    {
                                        cmdWalkDetail.Parameters.AddWithValue("@ID", walkStatusId); // <== this is the walk ID
                                        cmdWalkDetail.Parameters.AddWithValue("@Location", row["Area"]);
                                        cmdWalkDetail.Parameters.AddWithValue("@Observation_Points", row["Observation"]);
                                        cmdWalkDetail.Parameters.AddWithValue("@Recommendation_Points", row["Recommendation"]);
                                        cmdWalkDetail.Parameters.AddWithValue("@Responsibility", row["Responsibility"]);
                                        cmdWalkDetail.Parameters.AddWithValue("@Target_Date", Convert.ToDateTime(row["TargetDate"]));
                                        cmdWalkDetail.Parameters.AddWithValue("@Remarks", row["Remarks"]);
                                        cmdWalkDetail.Parameters.AddWithValue("@Snap_File_Path", row["FilePath"]);

                                        if (cmdWalkDetail.ExecuteNonQuery() == 0)
                                            throw new Exception("Failed to insert into Line_walk_details.");
                                    }
                                }
                            }

                            transaction.Commit();
                            string successScript = $"Swal.fire({{ title: 'Success!', text: 'All data saved successfully.', icon: 'success' }});";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitSuccess", successScript, true);
                        }
                        catch (Exception ex)
                        {
                            transaction.Rollback();
                            string errorScript = $"Swal.fire({{ title: 'Error!', text: '{ex.Message}', icon: 'error' }});";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitError", errorScript, true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                string errorScript = $"Swal.fire({{ title: 'Error!', text: '{ex.Message}', icon: 'error' }});";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitError", errorScript, true);
            }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            ViewState["EmpData"] = null;
            ViewState["ObservationData"] = null;
            Response.Redirect("Line_Walk.aspx");

        }

        protected void btnAddToGrid_Click(object sender, EventArgs e)
        {
            try
            {
                string area = txtAreaLocation.Text.Trim();
                string observation = txtObservation.Text.Trim();
                string recommendation = txtRecommendation.Text.Trim();
                string responsibility = txtResponsibility.Text.Trim();
                string targetDate = txtTargetDate.Text.Trim();
                string remarks = txtRemarks.Text.Trim();
                string filePath = "";

                if (fileSnap.HasFile)
                {
                    string folderPath = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(folderPath))
                        Directory.CreateDirectory(folderPath);

                    string filename = Guid.NewGuid().ToString() + "_" + Path.GetFileName(fileSnap.FileName);
                    filePath = "~/Uploads/" + filename;
                    fileSnap.SaveAs(Path.Combine(folderPath, filename));
                }

                DataTable dt = ViewState["ObservationData"] as DataTable;
                if (dt == null)
                {
                    dt = new DataTable();
                    dt.Columns.Add("Area");
                    dt.Columns.Add("Observation");
                    dt.Columns.Add("Recommendation");
                    dt.Columns.Add("Responsibility");
                    dt.Columns.Add("TargetDate");
                    dt.Columns.Add("Remarks");
                    dt.Columns.Add("FilePath");
                }

                dt.Rows.Add(area, observation, recommendation, responsibility, targetDate, remarks, filePath);

                ViewState["ObservationData"] = dt;
                GridView1.DataSource = dt;
                GridView1.DataBind();

                txtAreaLocation.Text = "";
                txtObservation.Text = "";
                txtRecommendation.Text = "";
                txtResponsibility.Text = "";
                txtTargetDate.Text = "";
                txtRemarks.Text = "";
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Error saving observation: " + ex.Message + "');", true);
            }
        }


        protected void btnSave_Click(object sender, EventArgs e)

        {
            try
            {
                string EmpType = rblEmpType.SelectedValue;
                string EmpCode = txtEmpCode.Text.Trim();
                string EmpName = txtEmpName.Text.Trim();

                // Validation
                if (EmpType == "Internal")
                {
                    if (string.IsNullOrWhiteSpace(EmpCode))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Employee Code is required for Internal employees.');", true);
                        return;
                    }

                    if (string.IsNullOrWhiteSpace(EmpName))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Employee Name not found for the given code.');", true);
                        return;
                    }
                }
                else if (EmpType == "External")
                {
                    if (string.IsNullOrWhiteSpace(EmpName))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Employee Name is required for External employees.');", true);
                        return;
                    }

                    // Leave EmpCode as empty string
                    EmpCode = string.Empty;
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select employee type.');", true);
                    return;
                }

                // Load or create session DataTable
                DataTable dt = ViewState["EmpData"] as DataTable;
                if (dt == null)
                {
                    dt = new DataTable();
                    dt.Columns.Add("EmpType");
                    dt.Columns.Add("EmpCode");
                    dt.Columns.Add("EmpName");
                }

                dt.Rows.Add(EmpType, EmpCode, EmpName);
                ViewState["EmpData"] = dt;
                GridView2.DataSource = dt;
                GridView2.DataBind();

                // Reset fields
                rblEmpType.ClearSelection();
                txtEmpCode.Text = "";
                txtEmpName.Text = "";

                // Close modal and show alert
                ScriptManager.RegisterStartupScript(this, GetType(), "CloseModalAndAlert", @"
            var modal = bootstrap.Modal.getInstance(document.getElementById('employeeModal'));
            if (modal) { modal.hide(); }
            showSuccessAlert();", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Error saving Team members: " + ex.Message + "');", true);
            }
        }




        [System.Web.Services.WebMethod]
        public static string GetEmployeeName(string empCode)
        {
            string empName = "";
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
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

    }

}

