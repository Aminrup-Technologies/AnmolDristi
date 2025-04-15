using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class test : System.Web.UI.Page
    {
        // Database Connection String (Modify it as per your DB settings)
        private string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAttendees(); // Load existing records on page load
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    con.Open();
                    string query = "INSERT INTO Committee_MeetingAttendance (MeetingID, Name, Designation, AttendeeCode, Attendee_Type, Image_upload, AttendanceStatus) " +
                                   "VALUES (@MeetingID, @Name, @Designation, @AttendeeCode, @AttendeeType, @ImageUpload, @AttendanceStatus)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        // Assuming MeetingID is static or predefined
                        cmd.Parameters.AddWithValue("@MeetingID", 1); // Replace with dynamic MeetingID if needed
                        cmd.Parameters.AddWithValue("@Name", txtEmployeeName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Designation", txtdes.Text.Trim());
                        cmd.Parameters.AddWithValue("@AttendeeCode", txtAttendeeCode.Text.Trim());
                        cmd.Parameters.AddWithValue("@AttendeeType", rbAttendeeType.SelectedValue);
                        cmd.Parameters.AddWithValue("@AttendanceStatus", ddlAttendanceStatus.SelectedValue);

                        // Handling File Upload
                        if (imgupload.HasFile)
                        {
                            string fileName = System.IO.Path.GetFileName(imgupload.PostedFile.FileName);
                            string filePath = "~/Uploads/" + fileName;
                            imgupload.SaveAs(Server.MapPath(filePath));
                            cmd.Parameters.AddWithValue("@ImageUpload", filePath);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@ImageUpload", DBNull.Value);
                        }

                        // Execute Query
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMsg.Text = "Attendee added successfully!";
                            lblMsg.ForeColor = System.Drawing.Color.Green;
                            LoadAttendees(); // Refresh GridView after adding data
                            ClearFields();
                        }
                        else
                        {
                            lblMsg.Text = "Error adding attendee.";
                            lblMsg.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void LoadAttendees()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    string query = "SELECT AttendanceID, Name AS EmployeeName, Designation, AttendeeCode, Attendee_Type AS AttendeeType, Image_upload AS ImagePath, AttendanceStatus " +
                                   "FROM Committee_MeetingAttendance";

                    using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvAttendees.DataSource = dt;
                        gvAttendees.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error loading data: " + ex.Message;
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            ClearFields();
        }

        private void ClearFields()
        {
            txtEmployeeName.Text = "";
            txtdes.Text = "";
            txtAttendeeCode.Text = "";
            rbAttendeeType.ClearSelection();
            ddlAttendanceStatus.SelectedIndex = 0;
        }

        protected void BtnDelAttendees_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                GridViewRow row = (GridViewRow)btn.NamingContainer;
                int attendanceID = Convert.ToInt32(gvAttendees.DataKeys[row.RowIndex].Value);

                using (SqlConnection con = new SqlConnection(connString))
                {
                    con.Open();
                    string query = "DELETE FROM Committee_MeetingAttendance WHERE AttendanceID = @AttendanceID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@AttendanceID", attendanceID);
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMsg.Text = "Attendee deleted successfully!";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                LoadAttendees();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }
    }