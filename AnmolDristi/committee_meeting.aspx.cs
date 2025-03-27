using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class committee_meeting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void rbEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlAttendeeType.Visible = rbEmployee.SelectedValue == "Yes";
            pnlDetails.Visible = rbEmployee.SelectedValue == "No";
        }

        protected void rbAttendeeType_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool isInternal = rbAttendeeType.SelectedValue == "Internal";
            txtAttendeeCode.Text = isInternal ? "" : "N/A";
            txtAttendeeCode.Enabled = isInternal;
            pnlDetails.Visible = true;
        }
        protected void btnAddAttendees_Click(object sender, EventArgs e)
        {
            DataTable dt;
            if (ViewState["Attendees"] == null)
            {
                dt = new DataTable();
                dt.Columns.Add("SNo");
                dt.Columns.Add("EmployeeOrNot");
                dt.Columns.Add("EmployeeName");
                dt.Columns.Add("AttendeeCode");
                dt.Columns.Add("AttendanceStatus");
                dt.Columns.Add("AttendeeType");
                dt.Columns.Add("Designation");
                dt.Columns.Add("ImagePath"); // New column for image path
            }
            else
            {
                dt = (DataTable)ViewState["Attendees"];
            }
            string imagePath = "";
            if (imgupload.HasFile)
            {
                string fileExtension = Path.GetExtension(imgupload.FileName).ToLower();
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblMsg1.Text = "Error: Only JPG, JPEG, and PNG files are allowed.";
                    lblMsg1.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
                string fileName = Path.GetFileName(imgupload.FileName);
                imagePath = "~/Uploads/" + fileName;
                imgupload.SaveAs(folderPath + fileName);
            }
            // Generating SNo dynamically
            int serialNo = dt.Rows.Count + 1;

            DataRow dr = dt.NewRow();
            dr["SNo"] = serialNo;
            dr["EmployeeOrNot"] = rbEmployee.SelectedItem != null ? rbEmployee.SelectedItem.Text : "";
            dr["AttendeeType"] = rbAttendeeType.SelectedItem != null ? rbAttendeeType.SelectedItem.Text : "";
            dr["EmployeeName"] = txtEmployeeName.Text.Trim();
            dr["AttendeeCode"] = txtAttendeeCode.Text.Trim();
            dr["AttendanceStatus"] = ddlAttendanceStatus.SelectedValue;
            dr["Designation"] = txtdes.Text.Trim();
            dr["ImagePath"] = imagePath; // Store image path
            dt.Rows.Add(dr);

            ViewState["Attendees"] = dt;
            gvAttendees.DataSource = dt;
            gvAttendees.DataBind();

            // Clear input fields for next attendee
            rbEmployee.ClearSelection();
            rbAttendeeType.ClearSelection();
            ddlAttendanceStatus.SelectedIndex = 0;
            txtEmployeeName.Text = "";
            txtAttendeeCode.Text = "";
            txtdes.Text = "";
        }

        protected void btnAddIssues_Click(object sender, EventArgs e)
        {
            DataTable dts;
            if (ViewState["Issues"] == null)
            {
                dts = new DataTable();
                dts.Columns.Add("SNo");
                dts.Columns.Add("AgendaTitle");
                dts.Columns.Add("IssuesDiscussed");
                dts.Columns.Add("ActionBy");
                dts.Columns.Add("TargetDate");
                dts.Columns.Add("ReviewDate");
                dts.Columns.Add("ReviewBy");
                dts.Columns.Add("Status");
            }
            else
            {
                dts = (DataTable)ViewState["Issues"];
            }
            // Generating SNo dynamically
            int serialNo = dts.Rows.Count + 1;

            DataRow dr = dts.NewRow();
            dr["SNo"] = serialNo;
            dr["AgendaTitle"] = txtAgendaTitle.Text.Trim();
            dr["ActionBy"] = txtActionBy.Text.Trim();
            dr["IssuesDiscussed"] = txtIssuesDes.Text.Trim();
            dr["TargetDate"] = txtTargetDate.Text.Trim();
            dr["ReviewDate"] = txtReviewDate.Text.Trim();
            dr["ReviewBy"] = txtReviewBy.Text.Trim();
            dr["Status"] = ddlStatus.SelectedValue;
            dts.Rows.Add(dr);

            ViewState["Issues"] = dts;
            gvIssues.DataSource = dts;
            gvIssues.DataBind();

            // Clear input fields for next attendee
            txtActionBy.Text = "";
            txtAgendaTitle.Text="";
            txtReviewBy.Text = "";
            txtTargetDate.Text = "";
            txtIssuesDes.Text = "";
            txtReviewDate.Text = "";
            ddlStatus.SelectedIndex = 0;
            
        }
        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            if (gvIssues.DataKeys.Count == 0 || row.RowIndex < 0 || row.RowIndex >= gvIssues.DataKeys.Count)
            {
                return; // Prevent out-of-range errors
            }

            int sNo = Convert.ToInt32(gvIssues.DataKeys[row.RowIndex].Value);
            DataTable dts = ViewState["Issues"] as DataTable;

            if (dts != null)
            {
                DataRow[] rows = dts.Select("SNo=" + sNo);
                if (rows.Length > 0)
                {
                    dts.Rows.Remove(rows[0]);
                    dts.AcceptChanges();
                }

                // **Renumber SNo** after deletion
                for (int i = 0; i < dts.Rows.Count; i++)
                {
                    dts.Rows[i]["SNo"] = i + 1; // Reset SNo from 1 to N
                }

                if (dts.Rows.Count == 0)
                {
                    ViewState["Issues"] = null;
                    gvIssues.DataSource = null;
                    gvIssues.DataBind();
                }
                else
                {
                    ViewState["Issues"] = dts;
                    gvIssues.DataSource = dts;
                    gvIssues.DataBind();
                }
            }
        }

        protected void BtnDelAttendees_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            if (gvAttendees.DataKeys.Count == 0 || row.RowIndex < 0 || row.RowIndex >= gvAttendees.DataKeys.Count)
            {
                return; // Prevent out-of-range errors
            }

            int sNo = Convert.ToInt32(gvAttendees.DataKeys[row.RowIndex].Value);
            DataTable dt = ViewState["Attendees"] as DataTable;

            if (dt != null)
            {
                DataRow[] rows = dt.Select("SNo=" + sNo);
                if (rows.Length > 0)
                {
                    dt.Rows.Remove(rows[0]);
                    dt.AcceptChanges();
                }

                // **Renumber SNo** after deletion
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SNo"] = i + 1; // Reset SNo from 1 to N
                }

                if (dt.Rows.Count == 0)
                {
                    ViewState["Attendees"] = null;
                    gvAttendees.DataSource = null;
                    gvAttendees.DataBind();
                }
                else
                {
                    ViewState["Attendees"] = dt;
                    gvAttendees.DataSource = dt;
                    gvAttendees.DataBind();
                }
            }
        }


        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("committee_meeting.aspx");
        }
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            if (ViewState["Attendees"] == null)
            {
                lblMsg1.Text = "No Attendance to save.";
                lblMsg1.ForeColor = System.Drawing.Color.Red;
                BtnSubmit.Enabled = true; // Re-enable button
                return;
            }
            DataTable dt = (DataTable)ViewState["Issues"];

            if (ViewState["Issues"] == null)
            {
                lblMsg1.Text = "No Issues to save.";
                lblMsg1.ForeColor = System.Drawing.Color.Red;
                BtnSubmit.Enabled = true; // Re-enable button
                return;
            }
            DataTable dts = (DataTable)ViewState["Issues"];

            DateTime? Meeting_Date = string.IsNullOrEmpty(txtdate.Text) ? (DateTime?)null : Convert.ToDateTime(txtdate.Text);
            TimeSpan? Meeting_Time = string.IsNullOrEmpty(txtTime.Text) ? (TimeSpan?)null : TimeSpan.Parse(txtTime.Text);

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();
                try
                {
                    int MeetingID;

                    // Step 1: Insert into Committee Meeting Table 
                    using (SqlCommand cmd = new SqlCommand("InsertCommitteeMeetingReview", conn, transaction))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        SqlParameter outputMeetingID = new SqlParameter("@MeetingID", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputMeetingID);
                        cmd.Parameters.AddWithValue("@Venue", txtVenue.Text.Trim());
                        cmd.Parameters.AddWithValue("@ChairedBy", txtChairedBy.Text.Trim());
                        cmd.Parameters.AddWithValue("@MeetingDate", Meeting_Date);
                        cmd.Parameters.AddWithValue("@MeetingTime", Meeting_Time);
                        cmd.Parameters.AddWithValue("@MeetingNo", txtMeetingNo.Text.Trim());

                        cmd.ExecuteNonQuery();
                        MeetingID = Convert.ToInt32(outputMeetingID.Value);
                    }

                    if (MeetingID == 0)
                    {
                        transaction.Rollback();
                        lblMsg.Text = "Error: Meeting ID not generated.";
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                        return;
                    }



                    // Step 2: Insert into Attendees Table
                    foreach (DataRow row in dt.Rows)
                    {
                        int AttendanceID;
                        using (SqlCommand cmd = new SqlCommand("InsertCommitteeMeetingAttendance", conn, transaction))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            SqlParameter outputAttendanceID = new SqlParameter("@AttendanceID", SqlDbType.Int)
                            {
                                Direction = ParameterDirection.Output
                            };
                            cmd.Parameters.Add(outputAttendanceID);
                            cmd.Parameters.AddWithValue("@MeetingID", MeetingID);
                            cmd.Parameters.AddWithValue("@Name", row["EmployeeName"].ToString());
                            cmd.Parameters.AddWithValue("@Designation", row["Designation"].ToString());
                            cmd.Parameters.AddWithValue("@AttendeeCode", row["AttendeeCode"].ToString());
                            cmd.Parameters.AddWithValue("@Attendee_Type", row["AttendeeType"].ToString());
                            cmd.Parameters.AddWithValue("@AttendanceStatus", row["AttendanceStatus"].ToString());
                            cmd.Parameters.AddWithValue("@Image_upload",row["ImagePath"] == DBNull.Value || row["ImagePath"] == null ? (object)DBNull.Value : row["ImagePath"].ToString());

                            
                            cmd.ExecuteNonQuery();
                            AttendanceID = Convert.ToInt32(outputAttendanceID.Value);
                        }
                    }

                    // Step 3: Insert into committee Issues table
                    foreach (DataRow row in dts.Rows)
                    {
                        int IssueID;
                        using (SqlCommand cmd = new SqlCommand("InsertCommitteeMeetingAttendance", conn, transaction))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            SqlParameter outputIssueID = new SqlParameter("@IssueID ", SqlDbType.Int)
                            {
                                Direction = ParameterDirection.Output
                            };
                            cmd.Parameters.Add(outputIssueID);
                            cmd.Parameters.AddWithValue("@MeetingID", MeetingID);
                            cmd.Parameters.AddWithValue("@AgendaTitle", row["AgendaTitle"].ToString());
                            cmd.Parameters.AddWithValue("@ResponsiblePerson", row["ActionBy"].ToString());
                            cmd.Parameters.AddWithValue("@IssueDescription", row["IssuesDiscussed"].ToString());
                            cmd.Parameters.AddWithValue("@ReviewBy", row["ReviewBy"].ToString());
                            cmd.Parameters.AddWithValue("@Status", row["Status"].ToString());
                            cmd.Parameters.AddWithValue("@TargetDate ",
                                string.IsNullOrEmpty(row["TargetDate"].ToString()) ? DBNull.Value : (object)Convert.ToDateTime(row["TargetDate"]));

                            cmd.Parameters.AddWithValue("@ReviewDate",
                                string.IsNullOrEmpty(row["ReviewDate"].ToString()) ? DBNull.Value : (object)Convert.ToDateTime(row["ReviewDate"]));


                            cmd.ExecuteNonQuery();
                            IssueID = Convert.ToInt32(outputIssueID.Value);
                        }
                    }


                    transaction.Commit();
                    lblMsg.Text = "Transaction completed successfully!";
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lblMsg.Text = "Transaction failed: " + ex.Message;
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }


    
}