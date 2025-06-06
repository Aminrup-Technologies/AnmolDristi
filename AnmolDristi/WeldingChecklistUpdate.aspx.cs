using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Remoting.Messaging;
using static System.Net.Mime.MediaTypeNames;
using System.IO;
using System.Drawing;

namespace AnmolDristi
{
    public partial class WeldingChecklistUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int headerID;
                if (int.TryParse(Request.QueryString["HeaderID"], out headerID))
                {
                    LoadDetails(headerID);        // Load header
                    BindChecklist();              // Bind structure
                    BindChecklist_Terminals();
                    BindChecklist_Cables();
                    BindChecklist_ElectrodeHolder();
                    BindChecklist_WorkArea();

                    LoadChecklistItems(headerID); // Load data into repeaters
                }
            }

        }
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

        private void LoadDetails(int headerID)
        {
            string query = @"SELECT HeaderID,ChecklistDate,JobID,Location,EmployeeName,InspectedBy ,Remarks from  WeldingChecklistHeader where HeaderID=@HeaderID ";


            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerID);
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtdate.Text = Convert.ToDateTime(reader["ChecklistDate"]).ToString("yyyy-MM-dd");
                        txtloc.Text = reader["Location"].ToString();
                        txtnote.Text = reader["Remarks"].ToString();
                        txtjobId.Text = reader["JobID"].ToString();
                        txtInsBy.Text = reader["InspectedBy"].ToString();
                        txtDocNo.Text = reader["EmployeeName"].ToString();
                    }
                    else
                    {

                    }
                }
            }
        }

        private void LoadChecklistItems(int headerID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string query = "SELECT * FROM WeldingChecklist WHERE HeaderID = @HeaderID";

            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@HeaderID", headerID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            LoadRepeaterWithData(rptChecklist, dt);
            LoadRepeaterWithData(rptTerminals, dt);
            LoadRepeaterWithData(rptCables, dt);
            LoadRepeaterWithData(rptElectrodeHolder, dt);
            LoadRepeaterWithData(rptWorkArea, dt);
        }
        private void LoadRepeaterWithData(Repeater repeater, DataTable checklistData)
        {
            foreach (RepeaterItem item in repeater.Items)
            {
                HiddenField hfQuestionNumber = (HiddenField)item.FindControl("hfQuestionNumber");
                int questionNumber = Convert.ToInt32(hfQuestionNumber.Value);

                DataRow[] rows = checklistData.Select("QuestionNumber = " + questionNumber);
                if (rows.Length > 0)
                {
                    DataRow row = rows[0];

                    RadioButton rdoYes = (RadioButton)item.FindControl("rdoYes");
                    RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");
                    RadioButton rdoNA = (RadioButton)item.FindControl("rdoNA");

                    if (Convert.ToBoolean(row["IsOk"]))
                        rdoYes.Checked = true;
                    else if (Convert.ToBoolean(row["NA"]))
                        rdoNA.Checked = true;
                    else
                        rdoNo.Checked = true;

                    TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                    txtRemarks.Text = row["Remarks"].ToString();
                    var lblDescription = (Label)item.FindControl("lblDescription");
                    if (lblDescription != null)
                        lblDescription.Text = row["Description"].ToString();

                    HiddenField hfImagePath = (HiddenField)item.FindControl("hfImagePath");
                    FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                    System.Web.UI.WebControls.Image imgPreview = (System.Web.UI.WebControls.Image)item.FindControl("imgPreview");

                    string photoPath = row["PhotoPath"].ToString();
                    if (!string.IsNullOrEmpty(photoPath))
                    {
                        string physicalPath = Server.MapPath(photoPath);
                        if (System.IO.File.Exists(physicalPath))
                        {
                            imgPreview.ImageUrl = photoPath;
                            imgPreview.Visible = true;
                            hfImagePath.Value = photoPath;
                        }
                        else
                        {
                            imgPreview.Visible = false;
                        }
                    }
                    else
                    {
                        imgPreview.Visible = false;
                    }
                     if (!Convert.ToBoolean(row["IsOk"]) && !Convert.ToBoolean(row["NA"]))
                     {
                       txtRemarks.Style["display"] = "block";
                       fileUpload.Style["display"] = "block";
                     }
                }
            }
        }
       
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int headerID;
            if (!int.TryParse(Request.QueryString["HeaderID"], out headerID))
            {
                // Invalid header ID
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // Update Header
                SqlCommand cmdUpdateHeader = new SqlCommand(@"
            UPDATE WeldingChecklistHeader SET
                ChecklistDate = @ChecklistDate,
                JobID = @JobID,
                Location = @Location,
                EmployeeName = @EmployeeName,
                InspectedBy = @InspectedBy,
                Remarks = @Remarks
            WHERE HeaderID = @HeaderID", con);

                cmdUpdateHeader.Parameters.AddWithValue("@ChecklistDate", txtdate.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@JobID", txtjobId.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@Location", txtloc.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@EmployeeName", txtDocNo.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@Remarks", txtnote.Text);
                cmdUpdateHeader.Parameters.AddWithValue("@HeaderID", headerID);

                cmdUpdateHeader.ExecuteNonQuery();

                // Delete existing checklist items first
                SqlCommand cmdDeleteChecklist = new SqlCommand("DELETE FROM WeldingChecklist WHERE HeaderID = @HeaderID", con);
                cmdDeleteChecklist.Parameters.AddWithValue("@HeaderID", headerID);
                cmdDeleteChecklist.ExecuteNonQuery();

                // Save updated checklist items
                SaveChecklistItems(rptChecklist, headerID, con);
                SaveChecklistItems(rptTerminals, headerID, con);
                SaveChecklistItems(rptCables, headerID, con);
                SaveChecklistItems(rptElectrodeHolder, headerID, con);
                SaveChecklistItems(rptWorkArea, headerID, con);

                con.Close();
            }

            // Redirect or show success message
            lblMsg.Text = "Checklist updated successfully.";
            lblMsg.ForeColor = System.Drawing.Color.Green;
        }


        private void SaveChecklistItems(Repeater repeater, int headerID, SqlConnection con)
        {
            foreach (RepeaterItem item in repeater.Items)
            {
                HiddenField hfQuestionNumber = (HiddenField)item.FindControl("hfQuestionNumber");
                RadioButton rdoYes = (RadioButton)item.FindControl("rdoYes");
                RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");
                RadioButton rdoNA = (RadioButton)item.FindControl("rdoNA");
                TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");
                HiddenField hfImagePath = (HiddenField)item.FindControl("hfImagePath");
                Label lblDescription = (Label)item.FindControl("lblDescription");

                int questionNumber = Convert.ToInt32(hfQuestionNumber.Value);
                bool isOk = rdoYes.Checked;
                bool na = rdoNA.Checked;
                string description = lblDescription?.Text?.Trim() ?? "";

                string remarks = "";
                string photoPath = "";

                // Only allow remarks and photo if "No" is selected
                if (rdoNo.Checked)
                {
                    remarks = txtRemarks.Text.Trim();

                    if (fileUpload.HasFile)
                    {
                        string fileName = Path.GetFileName(fileUpload.FileName);
                        string savePath = Server.MapPath("~/Uploads/" + fileName);
                        fileUpload.SaveAs(savePath);
                        photoPath = "~/Uploads/" + fileName;
                    }
                    else
                    {
                        photoPath = hfImagePath?.Value ?? "";
                    }
                }

                SqlCommand cmdInsert = new SqlCommand(@"
            INSERT INTO WeldingChecklist 
            (HeaderID, QuestionNumber, IsOk, NA, Remarks, PhotoPath, Description)
            VALUES 
            (@HeaderID, @QuestionNumber, @IsOk, @NA, @Remarks, @PhotoPath, @Description)", con);

                cmdInsert.Parameters.AddWithValue("@HeaderID", headerID);
                cmdInsert.Parameters.AddWithValue("@QuestionNumber", questionNumber);
                cmdInsert.Parameters.AddWithValue("@IsOk", isOk);
                cmdInsert.Parameters.AddWithValue("@NA", na);
                cmdInsert.Parameters.AddWithValue("@Remarks", remarks);
                cmdInsert.Parameters.AddWithValue("@PhotoPath", photoPath);
                cmdInsert.Parameters.AddWithValue("@Description", description);

                cmdInsert.ExecuteNonQuery();
            }
        }

        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("WeldingChecklistView.aspx");
        }


    }
}