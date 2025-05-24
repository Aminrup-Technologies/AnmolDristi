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
                TB_ID.Enabled = false;
                heading.Text = "UPDATE LINE WALK STATUS DATA";
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

            string Date = TB_Date.Text.Trim();
            string JobID = TB_ID.Text.Trim();
            string JobDesc = TB_JD.Text.Trim();
            string AuditBy = TB_AuditBy.Text.Trim();

            string Photo = null;

            if (grp_Photo.HasFile)
            {
                string ext = Path.GetExtension(grp_Photo.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png")
                {
                    string folderPath = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(folderPath))
                        Directory.CreateDirectory(folderPath);

                    string filename = Guid.NewGuid().ToString() + "_" + Path.GetFileName(grp_Photo.FileName);
                    grp_Photo.SaveAs(Path.Combine(folderPath, filename));
                    Photo = filename;

                    Lbl_SavedPhoto.Text = "Current Photo: " + Photo;
                    Lbl_SavedPhoto.Visible = true;
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "FileError", @"
                <script type='text/javascript'>
                    alert('Only JPG, JPEG, PNG files are allowed.');
                </script>", false);
                    return;
                }
            }

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                conn.Open();

                if (ViewState["WalkStatusId"] == null)
                {
                    // INSERT
                    SqlCommand cmdIn = new SqlCommand(@"
                INSERT INTO [Line_walk_status] 
                ([WalkDate], [JobDescription], [JobID], [Photo], [Audit_By]) 
                VALUES 
                (@WalkDate, @JobDescription, @JobID, @Photo, @Audit_By); 
                SELECT SCOPE_IDENTITY();", conn);

                    cmdIn.Parameters.AddWithValue("@WalkDate", Date);
                    cmdIn.Parameters.AddWithValue("@JobID", JobID);
                    cmdIn.Parameters.AddWithValue("@JobDescription", JobDesc);
                    cmdIn.Parameters.AddWithValue("@Audit_By", AuditBy);
                    cmdIn.Parameters.AddWithValue("@Photo", string.IsNullOrEmpty(Photo) ? (object)DBNull.Value : Photo);

                    int walkStatusId = Convert.ToInt32(cmdIn.ExecuteScalar());
                    ViewState["WalkStatusId"] = walkStatusId;

                    if (!string.IsNullOrEmpty(Photo))
                    {
                        Lbl_SavedPhoto.Text = "Current Photo: " + Photo;
                        Lbl_SavedPhoto.Visible = true;
                    }
                    else
                    {
                        Lbl_SavedPhoto.Visible = false;
                    }

                    Save.Text = "Update";
                    btnOpenModal.Enabled = true;
                    btnOpenObservationModal.Enabled = true;

                    ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", @"
                <script type='text/javascript'>
                    new PNotify({
                        title: 'Success',
                        text: 'Job Details Saved Successfully!!',
                        type: 'success',
                        styling: 'bootstrap3'
                    });
                </script>", false);
                }
                else
                {
                    // UPDATE
                    int walkStatusId = Convert.ToInt32(ViewState["WalkStatusId"]);

                    if (string.IsNullOrEmpty(Photo))
                    {
                        SqlCommand getCmd = new SqlCommand("SELECT Photo FROM Line_walk_status WHERE ID = @ID", conn);
                        getCmd.Parameters.AddWithValue("@ID", walkStatusId);
                        object result = getCmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            Photo = result.ToString();
                        }

                        if (!string.IsNullOrEmpty(Photo))
                        {
                            Lbl_SavedPhoto.Text = Photo;
                            Lbl_SavedPhoto.Visible = true;
                        }
                        else
                        {
                            Lbl_SavedPhoto.Text = "";
                            Lbl_SavedPhoto.Visible = false;
                        }
                    }
                    else
                    {
                        Lbl_SavedPhoto.Text = Photo;
                        Lbl_SavedPhoto.Visible = true;
                    }

                    SqlCommand cmd = new SqlCommand(@"
                UPDATE [Line_walk_status] 
                SET WalkDate = @WalkDate, 
                    JobDescription = @JobDescription, 
                    JobID = @JobID, 
                    Photo = @Photo,
                    Audit_By = @Audit_By
                WHERE ID = @ID", conn);

                        cmd.Parameters.AddWithValue("@WalkDate", Date);
                        cmd.Parameters.AddWithValue("@JobID", JobID);
                        cmd.Parameters.AddWithValue("@JobDescription", JobDesc);
                        cmd.Parameters.AddWithValue("@Audit_By", AuditBy);
                        cmd.Parameters.AddWithValue("@Photo", string.IsNullOrEmpty(Photo) ? (object)DBNull.Value : Photo);
                        cmd.Parameters.AddWithValue("@ID", walkStatusId);

                        cmd.ExecuteNonQuery();

                        


                        ClientScript.RegisterStartupScript(this.GetType(), "ShowDataSuccessNotification", @"
                <script type='text/javascript'>
                    new PNotify({
                        title: 'Success',
                        text: 'Job Details Updated Successfully!!',
                        type: 'success',
                        styling: 'bootstrap3'
                    });
                </script>", false);
                    }
                }
            }
        


        


            
           
        

        protected void BtnSaveObservation_Click(object sender, EventArgs e)
        {
            
            string Area = txtAreaLocation.Text.Trim();
            string Observation = txtObservation.Text.Trim();
            string Recommandation = txtRecommendation.Text.Trim();
            //string Responsibility = txtResponsibility.Text.Trim();
            //string TargetDate = DateTime.Parse(txtTargetDate.Text.Trim()).ToString("yyyy-MM-dd");
            //string Remarks = txtRemarks.Text.Trim();
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
                                       Recommendation_Points = @Recommendation_Points " +
                                               (string.IsNullOrEmpty(Snap) ? "" : ", Snap_File_Path = @Snap_File_Path") +
                                          " WHERE Detail_ID = @Detail_ID", con);

                    cmd.Parameters.AddWithValue("@Detail_ID", Convert.ToInt32(Entity_Id.Value));
                }
                else  
                {
                    cmd = new SqlCommand(@"INSERT INTO Line_walk_details 
                                   (ID, Location, Observation_Points, Recommendation_Points, Snap_File_Path,Status) 
                                   VALUES 
                                   (@ID, @Location, @Observation_Points, @Recommendation_Points, @Snap_File_Path,@Status)", con);
                    cmd.Parameters.AddWithValue("@ID", mainID);
                    cmd.Parameters.AddWithValue("@Status", "Open");
                }

                cmd.Parameters.AddWithValue("@Location", Area);
                cmd.Parameters.AddWithValue("@Observation_Points", Observation);
                cmd.Parameters.AddWithValue("@Recommendation_Points", Recommandation);
                //cmd.Parameters.AddWithValue("@Responsibility", Responsibility);
                // cmd.Parameters.AddWithValue("@Target_Date", TargetDate);
                //cmd.Parameters.AddWithValue("@Remarks", Remarks);
                cmd.Parameters.AddWithValue("@Snap_File_Path", string.IsNullOrEmpty(Snap) ? (object)DBNull.Value : Snap);


                cmd.ExecuteNonQuery();
            }

            // Reset
            Entity_Id.Value = "";
            txtAreaLocation.Text = "";
            txtObservation.Text = "";
            txtRecommendation.Text = "";
            //txtResponsibility.Text = "";
            //txtTargetDate.Text = "";
            //txtRemarks.Text = "";
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
                            Recommendation_Points = reader["Recommendation_Points"] == DBNull.Value ? "" : reader["Recommendation_Points"],
                            Responsibility = reader["Responsibility"],
                            Target_Date = reader["Target_Date"] == DBNull.Value ? "" : Convert.ToDateTime(reader["Target_Date"]).ToString("yyyy-MM-dd"),
                            Remarks = reader["Remarks"],
                            Snap_File_Path = reader["Snap_File_Path"] == DBNull.Value ? "" : reader["Snap_File_Path"],
                            ImmediateAction_Attachment = reader["ImmediateAction_Attachment"] == DBNull.Value ? "" : reader["ImmediateAction_Attachment"]
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
                    TB_AuditBy.Text = reader["Audit_By"].ToString();

                    string photo = reader["Photo"].ToString();
                    if (!string.IsNullOrEmpty(photo))
                    {
                        Lbl_SavedPhoto.Text = photo;
                        Lbl_SavedPhoto.Visible = true;
                    }
                    else
                    {
                        Lbl_SavedPhoto.Text = "";
                        Lbl_SavedPhoto.Visible = false;
                    }

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

        protected void Home_Click(object sender, EventArgs e)
        {
            Response.Redirect("qaqc_home.aspx");
        }

        protected void BtnImmediateAction_Click(object sender, EventArgs e)
        {
                string remarks = txtRemarks.Text.Trim();
                string attachmentFileName = "";

                // For optional file upload
                if (IAction_Attachment.HasFile)
                {
                    string folderPath = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(folderPath))
                        Directory.CreateDirectory(folderPath);

                    string uniqueFileName = Guid.NewGuid().ToString() + "_" + Path.GetFileName(IAction_Attachment.FileName);
                    attachmentFileName = uniqueFileName;
                    IAction_Attachment.SaveAs(Path.Combine(folderPath, uniqueFileName));
                }

                        // Get Detail_ID to update
                        if (string.IsNullOrEmpty(Entity_Id.Value))
                        {
                            // showing error if ID is missing.
                            string errorScript = @"<script type='text/javascript'>
                    new PNotify({
                        title: 'Error',
                        text: 'Unable to save. Record ID is missing.',
                        type: 'error',
                        styling: 'bootstrap3'
                    });
                </script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "ShowErrorNotification", errorScript, false);
                            return;
                        }

                        int detailId = Convert.ToInt32(Entity_Id.Value);

                        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
                        {
                            con.Open();

                            
                            string updateQuery = @"
                                UPDATE Line_walk_details 
                                SET Remarks = @Remarks,
                                Status = 'Pending' "+
                                (string.IsNullOrEmpty(attachmentFileName) ? "" : ", ImmediateAction_Attachment = @Attachment") +
                                " WHERE Detail_ID = @Detail_ID";

                            SqlCommand cmd = new SqlCommand(updateQuery, con);
                            cmd.Parameters.AddWithValue("@Remarks", remarks);
                            cmd.Parameters.AddWithValue("@Detail_ID", detailId);

                            if (!string.IsNullOrEmpty(attachmentFileName))
                                cmd.Parameters.AddWithValue("@Attachment", attachmentFileName);

                            cmd.ExecuteNonQuery();
                        }

                         BindObservation();

            
                        txtRemarks.Text = "";
                        IAction_Attachment.Attributes.Clear();

                       
                        string successScript = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Success',
                                text: 'Immediate Action saved successfully!',
                                type: 'success',
                                styling: 'bootstrap3'
                            });
                        </script>";

                        ClientScript.RegisterStartupScript(this.GetType(), "ShowSuccessNotification", successScript, false);
        }

        protected void BtnFutureAction_Click(object sender, EventArgs e)
        {
            string responsibility = txtResponsibility.Text.Trim();
            string empName = txtRespoName.Text.Trim();
            string targetDate = txtTargetDate.Text.Trim();

            int detailId = Convert.ToInt32(Entity_Id.Value); 

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"UPDATE Line_walk_details 
                                          SET Responsibility = @Responsibility, 
                                              Target_Date = @TargetDate, 
                                              Status = 'In Progress'
                                          WHERE Detail_ID = @DetailID", con);

                cmd.Parameters.AddWithValue("@Responsibility", responsibility);
                cmd.Parameters.AddWithValue("@TargetDate", targetDate);
                cmd.Parameters.AddWithValue("@Remarks", empName); 
                cmd.Parameters.AddWithValue("@DetailID", detailId);

                cmd.ExecuteNonQuery();
            }

          
            txtResponsibility.Text = "";
            txtTargetDate.Text = "";
            txtRespoName.Text = "";
            ViewState["DetailID"] = null;

            BindObservation(); 
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string snapPath = DataBinder.Eval(e.Row.DataItem, "Snap_File_Path")?.ToString();
                HyperLink snapLink = (HyperLink)e.Row.FindControl("lnkSnap");

                if (snapLink != null)
                {
                    snapLink.Visible = !string.IsNullOrEmpty(snapPath);
                    snapLink.NavigateUrl = "~/Uploads/" + snapPath;
                }

                string attachPath = DataBinder.Eval(e.Row.DataItem, "ImmediateAction_Attachment")?.ToString();
                HyperLink attachLink = (HyperLink)e.Row.FindControl("lnkImmediate");

                if (attachLink != null)
                {
                    attachLink.Visible = !string.IsNullOrEmpty(attachPath);
                    attachLink.NavigateUrl = "~/Uploads/" + attachPath;
                }
            }
        }
    }
    


}

