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
    public partial class Line_Walk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["USERID"] == null || Session["USERNAME"] == null || Session["WORKMAN"] == null)
                {
                    Response.Redirect("login.aspx");
                }

                string Linewalkid = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(Linewalkid))
                {
                    ViewState["WalkStatusId"] = Linewalkid;

                    MainForm();
                    BindTeamGrid();
                    BindObservation();


                }
               
            }

            if (ViewState["WalkStatusId"] != null)
            {
                Save.Text = "Update";
                btnOpenModal.Enabled = true;
                btnOpenObservationModal.Enabled = true;
            }

            
        }

        //protected void BtnSubmit_Click(object sender, EventArgs e)
        //{
        //    DataSaver();
        //}

        //protected void DataSaver()
        //{
        //    try
        //    {
        //        string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
        //        using (SqlConnection con = new SqlConnection(connectionString))
        //        {
        //            con.Open();
        //            using (SqlTransaction transaction = con.BeginTransaction())
        //            {
        //                try
        //                {
        //                    // Insert the main Line Walk Status
        //                    string insertWalkStatusQuery = @"INSERT INTO [Line_walk_status] ([WalkDate], [JobDescription], [JobID]) VALUES (@WalkDate, @JobDescription, @JobID); SELECT SCOPE_IDENTITY();";
        //                    int walkStatusId;
        //                    using (SqlCommand cmd = new SqlCommand(insertWalkStatusQuery, con, transaction))
        //                    {
        //                        cmd.Parameters.AddWithValue("@WalkDate", DateTime.Today);
        //                        cmd.Parameters.AddWithValue("@JobDescription", TB_JD.Text.Trim());
        //                        cmd.Parameters.AddWithValue("@JobID", TB_ID.Text.Trim());

        //                        walkStatusId = Convert.ToInt32(cmd.ExecuteScalar());
        //                        if (walkStatusId <= 0)
        //                        {
        //                            throw new Exception("Failed to insert into Line_walk_status.");
        //                        }

        //                        ViewState["WalkStatusId"] = walkStatusId;
        //                    }

        //                    // Fetch team members and save them
        //                    //List<TeamMember> teamMembers = GetTeamMembersFromForm();
        //                    DataTable dt = ViewState["EmpData"] as DataTable;
        //                    if (dt != null && dt.Rows.Count > 0)
        //                    {
        //                        foreach (DataRow row in dt.Rows)
        //                        {
        //                            string insertTeamMemberQuery = @"INSERT INTO [Line_walk_status_description] ([ID], [TM_names]) VALUES (@ID, @TM_names);";
        //                            using (SqlCommand cmdTeam = new SqlCommand(insertTeamMemberQuery, con, transaction))
        //                            {
        //                                cmdTeam.Parameters.AddWithValue("@ID", walkStatusId);
        //                                cmdTeam.Parameters.AddWithValue("@TM_names", row["EmpName"]);
        //                                if (cmdTeam.ExecuteNonQuery() == 0)
        //                                    throw new Exception("Failed to insert into Line_walk_status_description.");
        //                            }
        //                        }
        //                    }


        //                    // Fetch observations from the session DataTable
        //                    DataTable dtObservations = ViewState["ObservationData"] as DataTable;

        //                    if (dtObservations != null && dtObservations.Rows.Count > 0)
        //                    {
        //                        foreach (DataRow row in dtObservations.Rows)
        //                        {
        //                            string insertWalkDetailQuery = @"INSERT INTO [Line_walk_details] 
        //                         ([ID], [Location], [Observation_Points], [Recommendation_Points], [Responsibility], 
        //                          [Target_Date], [Remarks], [Snap_File_Path]) 
        //                         VALUES (@ID, @Location, @Observation_Points, @Recommendation_Points, @Responsibility, 
        //                                 @Target_Date, @Remarks, @Snap_File_Path);";

        //                            using (SqlCommand cmdWalkDetail = new SqlCommand(insertWalkDetailQuery, con, transaction))
        //                            {
        //                                cmdWalkDetail.Parameters.AddWithValue("@ID", walkStatusId); // <== this is the walk ID
        //                                cmdWalkDetail.Parameters.AddWithValue("@Location", row["Area"]);
        //                                cmdWalkDetail.Parameters.AddWithValue("@Observation_Points", row["Observation"]);
        //                                cmdWalkDetail.Parameters.AddWithValue("@Recommendation_Points", row["Recommendation"]);
        //                                cmdWalkDetail.Parameters.AddWithValue("@Responsibility", row["Responsibility"]);
        //                                cmdWalkDetail.Parameters.AddWithValue("@Target_Date", Convert.ToDateTime(row["TargetDate"]));
        //                                cmdWalkDetail.Parameters.AddWithValue("@Remarks", row["Remarks"]);
        //                                cmdWalkDetail.Parameters.AddWithValue("@Snap_File_Path", row["FilePath"]);

        //                                if (cmdWalkDetail.ExecuteNonQuery() == 0)
        //                                    throw new Exception("Failed to insert into Line_walk_details.");
        //                            }
        //                        }
        //                    }

        //                    transaction.Commit();
        //                    string successScript = $"Swal.fire({{ title: 'Success!', text: 'All data saved successfully.', icon: 'success' }});";
        //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitSuccess", successScript, true);
        //                }
        //                catch (Exception ex)
        //                {
        //                    transaction.Rollback();
        //                    string errorScript = $"Swal.fire({{ title: 'Error!', text: '{ex.Message}', icon: 'error' }});";
        //                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitError", errorScript, true);
        //                }
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        string errorScript = $"Swal.fire({{ title: 'Error!', text: '{ex.Message}', icon: 'error' }});";
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitError", errorScript, true);
        //    }
        //}

        //protected void BtnReset_Click(object sender, EventArgs e)
        //{
        //    ViewState["EmpData"] = null;
        //    ViewState["ObservationData"] = null;
        //    Response.Redirect("Line_Walk.aspx");

        //}

        //protected void btnAddToGrid_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string area = txtAreaLocation.Text.Trim();
        //        string observation = txtObservation.Text.Trim();
        //        string recommendation = txtRecommendation.Text.Trim();
        //        string responsibility = txtResponsibility.Text.Trim();
        //        string targetDate = txtTargetDate.Text.Trim();
        //        string remarks = txtRemarks.Text.Trim();
        //        string filePath = "";

        //        if (fileSnap.HasFile)
        //        {
        //            string folderPath = Server.MapPath("~/Uploads/");
        //            if (!Directory.Exists(folderPath))
        //                Directory.CreateDirectory(folderPath);

        //            string filename = Guid.NewGuid().ToString() + "_" + Path.GetFileName(fileSnap.FileName);
        //            filePath = "~/Uploads/" + filename;
        //            fileSnap.SaveAs(Path.Combine(folderPath, filename));
        //        }

        //        DataTable dt = ViewState["ObservationData"] as DataTable;
        //        if (dt == null)
        //        {
        //            dt = new DataTable();
        //            dt.Columns.Add("Area");
        //            dt.Columns.Add("Observation");
        //            dt.Columns.Add("Recommendation");
        //            dt.Columns.Add("Responsibility");
        //            dt.Columns.Add("TargetDate");
        //            dt.Columns.Add("Remarks");
        //            dt.Columns.Add("FilePath");
        //        }

        //        dt.Rows.Add(area, observation, recommendation, responsibility, targetDate, remarks, filePath);

        //        ViewState["ObservationData"] = dt;
        //        GridView1.DataSource = dt;
        //        GridView1.DataBind();

        //        txtAreaLocation.Text = "";
        //        txtObservation.Text = "";
        //        txtRecommendation.Text = "";
        //        txtResponsibility.Text = "";
        //        txtTargetDate.Text = "";
        //        txtRemarks.Text = "";
        //    }
        //    catch (Exception ex)
        //    {
        //        ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Error saving observation: " + ex.Message + "');", true);
        //    }
        //}


        //protected void btnSave_Click(object sender, EventArgs e)

        //{
        //    try
        //    {
        //        string EmpType = rblEmpType.SelectedValue;
        //        string EmpCode = txtEmpCode.Text.Trim();
        //        string EmpName = txtEmpName.Text.Trim();

        //        // Validation
        //        if (EmpType == "Internal")
        //        {
        //            if (string.IsNullOrWhiteSpace(EmpCode))
        //            {
        //                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Employee Code is required for Internal employees.');", true);
        //                return;
        //            }

        //            if (string.IsNullOrWhiteSpace(EmpName))
        //            {
        //                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Employee Name not found for the given code.');", true);
        //                return;
        //            }
        //        }
        //        else if (EmpType == "External")
        //        {
        //            if (string.IsNullOrWhiteSpace(EmpName))
        //            {
        //                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Employee Name is required for External employees.');", true);
        //                return;
        //            }

        //            // Leave EmpCode as empty string
        //            EmpCode = string.Empty;
        //        }
        //        else
        //        {
        //            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please select employee type.');", true);
        //            return;
        //        }

        //        // Load or create session DataTable
        //        DataTable dt = ViewState["EmpData"] as DataTable;
        //        if (dt == null)
        //        {
        //            dt = new DataTable();
        //            dt.Columns.Add("EmpType");
        //            dt.Columns.Add("EmpCode");
        //            dt.Columns.Add("EmpName");
        //        }

        //        dt.Rows.Add(EmpType, EmpCode, EmpName);
        //        ViewState["EmpData"] = dt;
        //        GridView2.DataSource = dt;
        //        GridView2.DataBind();

        //        // Reset fields
        //        rblEmpType.ClearSelection();
        //        txtEmpCode.Text = "";
        //        txtEmpName.Text = "";

        //        // Close modal and show alert
        //        ScriptManager.RegisterStartupScript(this, GetType(), "CloseModalAndAlert", @"
        //    var modal = bootstrap.Modal.getInstance(document.getElementById('employeeModal'));
        //    if (modal) { modal.hide(); }
        //    showSuccessAlert();", true);
        //    }
        //    catch (Exception ex)
        //    {
        //        ClientScript.RegisterStartupScript(this.GetType(), "Error", "alert('Error saving Team members: " + ex.Message + "');", true);
        //    }
        //}


        

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

        protected void BtnSave_Click1(object sender, EventArgs e)
        {
            


            string emptype = rblEmpType.SelectedValue;
            string empcode = txtEmpCode.Text.Trim();
            string empname = txtEmpName.Text.Trim();
            int mainID = Convert.ToInt32(ViewState["WalkStatusId"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                con.Open();

                SqlCommand cmd;

                if (!string.IsNullOrEmpty(Entity_Id.Value)) 
                {
                    int descId = Convert.ToInt32(Entity_Id.Value);
                    cmd = new SqlCommand(@"UPDATE Line_walk_status_description 
                                   SET TM_names = @TM_names, TM_Code = @TM_Code, TM_Type = @TM_Type 
                                   WHERE Desc_ID = @Desc_ID", con);
                    cmd.Parameters.AddWithValue("@Desc_ID", descId);
                }
                else 
                {
                    cmd = new SqlCommand(@"INSERT INTO Line_walk_status_description (ID, TM_names, TM_Code, TM_Type) 
                                   VALUES (@ID, @TM_names, @TM_Code, @TM_Type)", con);
                    cmd.Parameters.AddWithValue("@ID", mainID);
                }

                cmd.Parameters.AddWithValue("@TM_names", empname);
                cmd.Parameters.AddWithValue("@TM_Code", empcode);
                cmd.Parameters.AddWithValue("@TM_Type", emptype);

                cmd.ExecuteNonQuery();
            }

            
            Entity_Id.Value = "";
            txtEmpCode.Text = "";
            txtEmpName.Text = "";
            rblEmpType.ClearSelection();

            BindTeamGrid();

            string Data_SuccessScript = @"<script type='text/javascript'>
        new PNotify({
            title: 'Success',
            text: 'Team Member Saved/Updated Successfully!',
            type: 'success',
            styling: 'bootstrap3'
        });
    </script>";

            ClientScript.RegisterStartupScript(this.GetType(), "ShowTeamMemberSuccessNotification", Data_SuccessScript, false);
        }

        private void BindTeamGrid()
        {
            if (ViewState["WalkStatusId"] != null)
            {
                int mainID = Convert.ToInt32(ViewState["WalkStatusId"]);

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
                {
                    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Line_walk_status_description WHERE ID = @ID", conn);
                    da.SelectCommand.Parameters.AddWithValue("@ID", mainID);


                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridView2.DataSource = dt;
                    GridView2.DataBind();
                }
            }
        }

        protected void Save_Click(object sender, EventArgs e)
        {

                string Date = TB_Date.Text.ToString();
                string JobID = TB_ID.Text.Trim();
                string JobDesc = TB_JD.Text.Trim();


            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {

                conn.Open();
                if (ViewState["WalkStatusId"] == null)
                {
                    SqlCommand cmd = new SqlCommand("INSERT INTO [Line_walk_status] ([WalkDate], [JobDescription], [JobID]) VALUES (@WalkDate, @JobDescription, @JobID);SELECT SCOPE_IDENTITY();", conn);
                    cmd.Parameters.AddWithValue("@WalkDate", Date);
                    cmd.Parameters.AddWithValue("@JobID", JobID);
                    cmd.Parameters.AddWithValue("@JobDescription", JobDesc);
                    int walkStatusId = Convert.ToInt32(cmd.ExecuteScalar());
                    ViewState["WalkStatusId"] = walkStatusId;


                    Save.Text = "Update";
                    btnOpenModal.Enabled = true;
                    btnOpenObservationModal.Enabled = true;


                    string Data_SuccessScript = @"<script type='text/javascript'>
                new PNotify({
                    title: 'Success',
                    text: 'Job Details Saved Successfully!!',
                    type: 'success',
                    styling: 'bootstrap3'
                });
            </script>";

                    ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
                

            }
                else
                {
                    int walkStatusId = Convert.ToInt32(ViewState["WalkStatusId"]);
                    SqlCommand cmd = new SqlCommand(@"
                UPDATE [Line_walk_status] 
                SET WalkDate = @WalkDate, 
                    JobDescription = @JobDescription, 
                    JobID = @JobID 
                WHERE ID = @ID", conn);

                    cmd.Parameters.AddWithValue("@WalkDate", Date);
                    cmd.Parameters.AddWithValue("@JobID", JobID);
                    cmd.Parameters.AddWithValue("@JobDescription", JobDesc);
                    cmd.Parameters.AddWithValue("@ID", walkStatusId);

                    cmd.ExecuteNonQuery();

                    string Data_SuccessScript = @"<script type='text/javascript'>
                new PNotify({
                    title: 'Success',
                    text: 'Job Details Updated Successfully!!',
                    type: 'success',
                    styling: 'bootstrap3'
                });
            </script>";

                    ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", Data_SuccessScript, false);
                }
            }
        }


            
           
        

        protected void BtnSaveObservation_Click(object sender, EventArgs e)
        {
            
            string Area = txtAreaLocation.Text.Trim();
            string Observation = txtObservation.Text.Trim();
            string Recommandation = txtRecommendation.Text.Trim();
            string Responsibility = txtResponsibility.Text.Trim();
            string TargetDate = DateTime.Parse(txtTargetDate.Text.Trim()).ToString("yyyy-MM-dd");
            string Remarks = txtRemarks.Text.Trim();
            string Snap = "";

            if (fileSnap.HasFile)
            {
                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string filename = Guid.NewGuid().ToString() + "_" + Path.GetFileName(fileSnap.FileName);
                Snap =  filename;
                fileSnap.SaveAs(Path.Combine(folderPath, filename));

                lblExistingSnap.Text = "";
            }
            else if (!string.IsNullOrEmpty(lblExistingSnap.Text))
            {
                Snap = lblExistingSnap.Text;
            }

            int mainID = Convert.ToInt32(ViewState["WalkStatusId"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd;

                if (!string.IsNullOrEmpty(Entity_Id.Value))  
                {
                    cmd = new SqlCommand(@"UPDATE Line_walk_details 
                                   SET Location = @Location, 
                                       Observation_Points = @Observation_Points, 
                                       Recommendation_Points = @Recommendation_Points, 
                                       Responsibility = @Responsibility, 
                                       Target_Date = @Target_Date, 
                                       Remarks = @Remarks" +
                                               (string.IsNullOrEmpty(Snap) ? "" : ", Snap_File_Path = @Snap_File_Path") +
                                          " WHERE Detail_ID = @Detail_ID", con);

                    cmd.Parameters.AddWithValue("@Detail_ID", Convert.ToInt32(Entity_Id.Value));
                }
                else  
                {
                    cmd = new SqlCommand(@"INSERT INTO Line_walk_details 
                                   (ID, Location, Observation_Points, Recommendation_Points, Responsibility, Target_Date, Remarks, Snap_File_Path) 
                                   VALUES 
                                   (@ID, @Location, @Observation_Points, @Recommendation_Points, @Responsibility, @Target_Date, @Remarks, @Snap_File_Path)", con);
                    cmd.Parameters.AddWithValue("@ID", mainID);
                }

                cmd.Parameters.AddWithValue("@Location", Area);
                cmd.Parameters.AddWithValue("@Observation_Points", Observation);
                cmd.Parameters.AddWithValue("@Recommendation_Points", Recommandation);
                cmd.Parameters.AddWithValue("@Responsibility", Responsibility);
                cmd.Parameters.AddWithValue("@Target_Date", TargetDate);
                cmd.Parameters.AddWithValue("@Remarks", Remarks);
                if (!string.IsNullOrEmpty(Snap))
                    cmd.Parameters.AddWithValue("@Snap_File_Path", Snap);

                cmd.ExecuteNonQuery();
            }

            // Reset
            Entity_Id.Value = "";
            txtAreaLocation.Text = "";
            txtObservation.Text = "";
            txtRecommendation.Text = "";
            txtResponsibility.Text = "";
            txtTargetDate.Text = "";
            txtRemarks.Text = "";
            fileSnap.Attributes.Clear();  
            lblExistingSnap.Text = "";

            BindObservation(); 

            string Data_SuccessScript = @"<script type='text/javascript'>
        new PNotify({
            title: 'Success',
            text: 'Observation Saved/Updated Successfully!',
            type: 'success',
            styling: 'bootstrap3'
        });
    </script>";

            ClientScript.RegisterStartupScript(this.GetType(), "ShowObservationSuccessNotification", Data_SuccessScript, false);

        }

        private void BindObservation()
        {
            if (ViewState["WalkStatusId"] != null)
            {
                int mainID = Convert.ToInt32(ViewState["WalkStatusId"]);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
                {
                    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Line_walk_details WHERE ID = @ID", con);
                    da.SelectCommand.Parameters.AddWithValue("@ID", mainID);

                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }

        [WebMethod]
        public static object GetMemberId(int id)
        {
            
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Line_walk_status_description WHERE Desc_ID = @Desc_ID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Desc_ID", id);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        reader.Read();
                        return new
                        {
                            Desc_ID = reader["Desc_ID"],
                            ID = reader["ID"],
                            TM_names = reader["TM_names"],
                            TM_Code = reader["TM_Code"],
                            TM_Type = reader["TM_Type"]
                        };
                    }
                    else
                    {
                        return null;
                    }

                }
            }
           
        }

        [WebMethod]
        public static object GetLineWalkDetailById(int detailId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Line_walk_details WHERE Detail_ID = @Detail_ID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Detail_ID", detailId);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        reader.Read();
                        return new
                        {
                            Detail_ID = reader["Detail_ID"],
                            ID = reader["ID"],
                            Location = reader["Location"],
                            Observation_Points = reader["Observation_Points"],
                            Recommendation_Points = reader["Recommendation_Points"],
                            Responsibility = reader["Responsibility"],
                            Target_Date = Convert.ToDateTime(reader["Target_Date"]).ToString("yyyy-MM-dd"), 
                            Remarks = reader["Remarks"],
                            Snap_File_Path = reader["Snap_File_Path"]
                        };
                    }
                    else
                    {
                        return null;
                    }
                }
            }

            
        }

        private void MainForm()
        {
            string CS = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(CS))
            {
                con.Open();

                int mainID = Convert.ToInt32(ViewState["WalkStatusId"]);
                SqlCommand cmd = new SqlCommand("SELECT * FROM Line_walk_status WHERE ID = @ID", con);
                cmd.Parameters.AddWithValue("@ID",mainID );  

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    TB_Date.Text = Convert.ToDateTime(reader["WalkDate"]).ToString("yyyy-MM-dd");
                    TB_ID.Text = reader["JobID"].ToString();
                    TB_JD.Text = reader["JobDescription"].ToString();
                    ViewState["WalkStatusId"] = reader["ID"].ToString(); 
                }
                reader.Close();
            }

        }

        protected void gvTeamMembers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteMember")
            {
                int descId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("DELETE FROM Line_walk_status_description WHERE Desc_ID = @Desc_ID", con);
                    cmd.Parameters.AddWithValue("@Desc_ID", descId);
                    cmd.ExecuteNonQuery();
                }

                BindTeamGrid(); 
            }
        }

        protected void gvObservations_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteObservation")
            {
                int detailId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("DELETE FROM Line_walk_details WHERE Detail_ID = @Detail_ID", con);
                    cmd.Parameters.AddWithValue("@Detail_ID", detailId);
                    cmd.ExecuteNonQuery();
                }

                BindObservation();
            }
        }


       


    }


}

