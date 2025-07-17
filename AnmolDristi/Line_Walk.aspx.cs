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

                System.Diagnostics.Debug.WriteLine("Page Load — Not PostBack");
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
            string Snap = "";
            bool generateCAPA = chkGenerateCAPA.Checked;

            if (fileSnap.HasFile)
            {
                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string filename = Guid.NewGuid().ToString() + "_" + Path.GetFileName(fileSnap.FileName);
                Snap = filename;
                fileSnap.SaveAs(Path.Combine(folderPath, filename));
                lblExistingSnap.Text = "";
            }
            else if (!string.IsNullOrEmpty(lblExistingSnap.Text))
            {
                Snap = lblExistingSnap.Text;
            }

            int mainID = Convert.ToInt32(ViewState["WalkStatusId"]);
            string statusToSave = "Open"; // Default status
            int? capaIdToUse = null;
            string customId = "LW-" + mainID;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                con.Open();

                bool isUpdate = !string.IsNullOrEmpty(Entity_Id.Value);
                int detailId = isUpdate ? Convert.ToInt32(Entity_Id.Value) : 0;

                if (generateCAPA)
                {
                    int newCapaId;
                    using (SqlCommand capaCmd = new SqlCommand(@"
                INSERT INTO tbl_CAPAMaster (SourceTable, HeaderID,Remarks, Description, PhotoPath, AssignedBy)
                VALUES (@SourceTable, @HeaderID, @Remarks, @Description, @PhotoPath, @AssignedBy);
                SELECT SCOPE_IDENTITY();", con))
                    {
                        capaCmd.Parameters.AddWithValue("@SourceTable", "Line_walk");
                        capaCmd.Parameters.AddWithValue("@HeaderID", customId);
                        capaCmd.Parameters.AddWithValue("@Description", Observation);
                        capaCmd.Parameters.AddWithValue("@Remarks", Recommandation);
                        capaCmd.Parameters.AddWithValue("@PhotoPath", string.IsNullOrEmpty(Snap) ? (object)DBNull.Value : Snap);

                        // Safely retrieve AssignedBy from Session
                        string assignedBy = (Session["USERID"] != null) ? Session["USERID"].ToString() : "Unknown";
                        capaCmd.Parameters.AddWithValue("@AssignedBy", assignedBy);

                        newCapaId = Convert.ToInt32(capaCmd.ExecuteScalar());
                        capaIdToUse = newCapaId;
                    }

                    using (SqlCommand getStatusCmd = new SqlCommand("SELECT Status FROM tbl_CAPAMaster WHERE CAPAID = @CAPAID", con))
                    {
                        getStatusCmd.Parameters.AddWithValue("@CAPAID", capaIdToUse.Value);
                        object statusObj = getStatusCmd.ExecuteScalar();
                        if (statusObj != null)
                            statusToSave = statusObj.ToString();
                    }
                }

                SqlCommand cmd;

                if (isUpdate)
                {
                    cmd = new SqlCommand(@"
                UPDATE Line_walk_details 
                SET 
                    Location = @Location,
                    Observation_Points = @Observation_Points,
                    Recommendation_Points = @Recommendation_Points,
                    Generate_CAPA = @Generate_CAPA,
                    Status = @Status,
                    Custom_ID = 'LW-' + CAST(ID AS VARCHAR)
                    " + (string.IsNullOrEmpty(Snap) ? "" : ", Snap_File_Path = @Snap_File_Path") + @"
                    , CAPA_ID = @CAPA_ID
                WHERE Detail_ID = @Detail_ID", con);

                    cmd.Parameters.AddWithValue("@Detail_ID", detailId);

                    if (!generateCAPA)
                    {
                        // If Unchecked capa checkbox IsYes = 1 in CAPA Master table 
                        using (SqlCommand updateCapaCmd = new SqlCommand(@"
                    UPDATE tbl_CAPAMaster 
                    SET IsYes = 1 
                    WHERE CAPAID = (
                        SELECT CAPA_ID 
                        FROM Line_walk_details 
                        WHERE Detail_ID = @Detail_ID AND CAPA_ID IS NOT NULL
                    )", con))
                        {
                            updateCapaCmd.Parameters.AddWithValue("@Detail_ID", detailId);
                            updateCapaCmd.ExecuteNonQuery();
                        }

                        // catching the existing CAPA_ID from DB to preserve it(later used)
                        using (SqlCommand getCapaCmd = new SqlCommand("SELECT CAPA_ID FROM Line_walk_details WHERE Detail_ID = @Detail_ID", con))
                        {
                            getCapaCmd.Parameters.AddWithValue("@Detail_ID", detailId);
                            object existingCapaId = getCapaCmd.ExecuteScalar();
                            capaIdToUse = existingCapaId != DBNull.Value ? Convert.ToInt32(existingCapaId) : (int?)null;
                        }
                    }
                }
                else
                {
                    cmd = new SqlCommand(@"
                INSERT INTO Line_walk_details 
                    (ID, Location, Observation_Points, Recommendation_Points, Snap_File_Path, Status, Generate_CAPA, CAPA_ID)
                VALUES 
                    (@ID, @Location, @Observation_Points, @Recommendation_Points, @Snap_File_Path, @Status, @Generate_CAPA, @CAPA_ID);
                SELECT SCOPE_IDENTITY();", con);
                }

                cmd.Parameters.AddWithValue("@ID", mainID);
                cmd.Parameters.AddWithValue("@Location", Area);
                cmd.Parameters.AddWithValue("@Observation_Points", Observation);
                cmd.Parameters.AddWithValue("@Recommendation_Points", Recommandation);
                cmd.Parameters.AddWithValue("@Status", statusToSave);
                cmd.Parameters.AddWithValue("@Generate_CAPA", generateCAPA);
                cmd.Parameters.AddWithValue("@Snap_File_Path", string.IsNullOrEmpty(Snap) ? (object)DBNull.Value : Snap);
                cmd.Parameters.AddWithValue("@CAPA_ID", capaIdToUse.HasValue ? (object)capaIdToUse.Value : DBNull.Value);

                if (isUpdate)
                {
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    int newDetailId = Convert.ToInt32(cmd.ExecuteScalar());

                    using (SqlCommand updateCustomCmd = new SqlCommand(@"
                UPDATE Line_walk_details 
                SET Custom_ID = @CustomID 
                WHERE Detail_ID = @Detail_ID", con))
                    {
                        updateCustomCmd.Parameters.AddWithValue("@CustomID", customId);
                        updateCustomCmd.Parameters.AddWithValue("@Detail_ID", newDetailId);
                        updateCustomCmd.ExecuteNonQuery();
                    }
                }
            }

            // Reset UI
            Entity_Id.Value = "";
            txtAreaLocation.Text = "";
            txtObservation.Text = "";
            chkGenerateCAPA.Checked = false;
            txtRecommendation.Text = "";
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
                            ImmediateAction_Attachment = reader["ImmediateAction_Attachment"]?.ToString() ?? "",
                            Generate_CAPA = Convert.ToBoolean(reader["Generate_CAPA"])

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

            if (IAction_Attachment.HasFile)
            {
                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string uniqueFileName = Guid.NewGuid().ToString() + "_" + Path.GetFileName(IAction_Attachment.FileName);
                attachmentFileName = uniqueFileName;
                IAction_Attachment.SaveAs(Path.Combine(folderPath, uniqueFileName));
            }

            if (string.IsNullOrEmpty(Entity_Id.Value))
            {
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
            string statusToSave = "Pending";
            bool isGenerateCAPA = false;
            int capaId = 0;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                con.Open();

                SqlCommand getCapaInfoCmd = new SqlCommand("SELECT Generate_CAPA, ISNULL(CAPA_ID, 0) FROM Line_walk_details WHERE Detail_ID = @Detail_ID", con);
                getCapaInfoCmd.Parameters.AddWithValue("@Detail_ID", detailId);

                using (SqlDataReader reader = getCapaInfoCmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        isGenerateCAPA = Convert.ToBoolean(reader.GetValue(0));
                        capaId = Convert.ToInt32(reader.GetValue(1));
                    }
                }

                if (isGenerateCAPA && capaId > 0)
                {
                    SqlCommand statusCmd = new SqlCommand("SELECT Status FROM tbl_CAPAMaster WHERE CAPAID = @CAPAID", con);
                    statusCmd.Parameters.AddWithValue("@CAPAID", capaId);
                    object statusObj = statusCmd.ExecuteScalar();
                    if (statusObj != null)
                    {
                        statusToSave = statusObj.ToString();
                    }

                    // Updating the tbl_CAPAMaster with CorrectiveAction, Photo, and Date.
                    SqlCommand updateCapaCmd = new SqlCommand(@"
                UPDATE tbl_CAPAMaster 
                SET CorrectiveAction = @CorrectiveAction, 
                    CA_Photo = @CAPhoto,
                    CA_Date = @CADate
                WHERE CAPAID = @CAPAID", con);

                    updateCapaCmd.Parameters.AddWithValue("@CorrectiveAction", remarks);
                    updateCapaCmd.Parameters.AddWithValue("@CAPAID", capaId);
                    updateCapaCmd.Parameters.AddWithValue("@CADate", DateTime.Now);
                    updateCapaCmd.Parameters.AddWithValue("@CAPhoto", string.IsNullOrEmpty(attachmentFileName) ? (object)DBNull.Value : attachmentFileName);

                    updateCapaCmd.ExecuteNonQuery();
                }

                //  Updating the Line_walk_details with Remarks, Attachment, and Correct Status(if not checked...by default status)
                string updateQuery = @"
            UPDATE Line_walk_details 
            SET Remarks = @Remarks,
                Status = @Status" +
                        (string.IsNullOrEmpty(attachmentFileName) ? "" : ", ImmediateAction_Attachment = @Attachment") +
                    " WHERE Detail_ID = @Detail_ID";

                SqlCommand cmd = new SqlCommand(updateQuery, con);
                cmd.Parameters.AddWithValue("@Remarks", remarks);
                cmd.Parameters.AddWithValue("@Status", statusToSave);
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

            ClientScript.RegisterStartupScript(this.GetType(), "ShowIASuccess", successScript, false);


        }

        protected void BtnFutureAction_Click(object sender, EventArgs e)
        {
           
            string responsibility = txtResponsibility.Text.Trim();
            string empName = txtRespoName.Text.Trim(); 
            string targetDate = txtTargetDate.Text.Trim();

            if (string.IsNullOrEmpty(Entity_Id.Value))
                return;

            int detailId = Convert.ToInt32(Entity_Id.Value);
            string statusToSave = "In Progress";
            bool isGenerateCAPA = false;
            int capaId = 0;

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            {
                con.Open();

                // Checking if CAPA is enabled for this detail
                SqlCommand getCapaCmd = new SqlCommand("SELECT Generate_CAPA, ISNULL(CAPA_ID, 0) FROM Line_walk_details WHERE Detail_ID = @Detail_ID", con);
                getCapaCmd.Parameters.AddWithValue("@Detail_ID", detailId);

                using (SqlDataReader reader = getCapaCmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        isGenerateCAPA = Convert.ToBoolean(reader.GetValue(0));
                        capaId = Convert.ToInt32(reader.GetValue(1));
                    }
                }

                // If CAPA is checked and CAPA_ID exists, updating the tbl tbl_CAPAMaster and getting status from it.
                if (isGenerateCAPA && capaId > 0)
                {
                    SqlCommand updateCapaCmd = new SqlCommand(@"
                UPDATE tbl_CAPAMaster
                SET ResponsiblePerson = @ResponsiblePerson,
                    TargetCompletionDate = @TargetDate
                WHERE CAPAID = @CAPAID", con);

                    updateCapaCmd.Parameters.AddWithValue("@ResponsiblePerson", responsibility);
                    updateCapaCmd.Parameters.AddWithValue("@TargetDate", targetDate);
                    updateCapaCmd.Parameters.AddWithValue("@CAPAID", capaId);
                    updateCapaCmd.ExecuteNonQuery();

                    // Getting CAPA Status...
                    SqlCommand statusCmd = new SqlCommand("SELECT Status FROM tbl_CAPAMaster WHERE CAPAID = @CAPAID", con);
                    statusCmd.Parameters.AddWithValue("@CAPAID", capaId);
                    object statusObj = statusCmd.ExecuteScalar();
                    if (statusObj != null)
                        statusToSave = statusObj.ToString();
                }

                // Updating the Line_walk_details
                SqlCommand cmd = new SqlCommand(@"
            UPDATE Line_walk_details 
            SET Responsibility = @Responsibility, 
                Target_Date = @TargetDate,
                Remarks = @Remarks,
                Status = @Status
            WHERE Detail_ID = @DetailID", con);

                cmd.Parameters.AddWithValue("@Responsibility", responsibility);
                cmd.Parameters.AddWithValue("@TargetDate", targetDate);
                cmd.Parameters.AddWithValue("@Remarks", empName); 
                cmd.Parameters.AddWithValue("@Status", statusToSave);
                cmd.Parameters.AddWithValue("@DetailID", detailId);
                cmd.ExecuteNonQuery();
            }

            txtResponsibility.Text = "";
            txtTargetDate.Text = "";
            txtRespoName.Text = "";
            ViewState["DetailID"] = null;

            BindObservation();

            string successScript = @"<script type='text/javascript'>
        new PNotify({
            title: 'Success',
            text: 'Future Action saved successfully!',
            type: 'success',
            styling: 'bootstrap3'
        });
    </script>";

            ClientScript.RegisterStartupScript(this.GetType(), "ShowFutureSuccess", successScript, false);


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

