using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace AnmolDristi
{
    public partial class trail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnsave1_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(DDL_WorkRegion.SelectedValue) ||
                  string.IsNullOrEmpty(DDL_Company.SelectedValue) ||
                  string.IsNullOrEmpty(DDL_Location.SelectedValue))
            {
                lblMsg.Text = "Please select all required fields.";
                return;
            }
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string meetingId = Guid.NewGuid().ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO csm_massmeting_records 
                                (MM_Id, MM_DocNo, Meeting_Date, Meeting_StartTime, Meeting_EndTime, 
                                SubmitterCode, RegionCode, CompanyCode, DeptCode, LocationCode, 
                                ExactLocation, Coordinator_Name, LastModifiedOn, LastModifiedByCode) 
                                VALUES 
                                (@MM_Id, @MM_DocNo, @Meeting_Date, @Meeting_StartTime, @Meeting_EndTime, 
                                @SubmitterCode, @RegionCode, @CompanyCode, @DeptCode, @LocationCode, 
                                @ExactLocation, @Coordinator_Name, GETDATE(), @LastModifiedByCode)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                    cmd.Parameters.AddWithValue("@MM_DocNo", "ATS/DOC/MM/0010");
                    cmd.Parameters.AddWithValue("@Meeting_Date", TB_Date.Text);
                    cmd.Parameters.AddWithValue("@Meeting_StartTime", TB_StartTime.Text);
                    cmd.Parameters.AddWithValue("@Meeting_EndTime", TB_EndTime.Text);
                    cmd.Parameters.AddWithValue("@SubmitterCode", "SUB001"); // Update with actual submitter ID
                    cmd.Parameters.AddWithValue("@RegionCode", DDL_WorkRegion.SelectedValue);
                    cmd.Parameters.AddWithValue("@CompanyCode", DDL_Company.SelectedValue);
                    cmd.Parameters.AddWithValue("@DeptCode", DDL_Department.SelectedValue);
                    cmd.Parameters.AddWithValue("@LocationCode", DDL_Location.SelectedValue);
                    cmd.Parameters.AddWithValue("@ExactLocation", TB_ExactLocation.Text);
                    cmd.Parameters.AddWithValue("@Coordinator_Name", TB_CoordinatorName.Text);
                    cmd.Parameters.AddWithValue("@LastModifiedByCode", "USER001"); // Replace with actual user ID

                    try
                    {
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            lblMsg.Text = "Record inserted successfully!";
                            HiddenField_MMId.Value = meetingId;
                            ViewState["MM_Id"] = meetingId;
                            lblMsg.Text += $" (Meeting ID: {meetingId})"; // Debug output
                        }
                        else
                        {
                            lblMsg.Text = "Failed to insert record.";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMsg.Text = "Error: " + ex.Message;
                    }
                }
            }
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
                dt.Columns.Add("EmployeeOrNot");
                dt.Columns.Add("EmployeeName");
                dt.Columns.Add("AttendeeCode");
                dt.Columns.Add("GatePassNo");
                dt.Columns.Add("AttendeeType");
                dt.Columns.Add("Designation");
            }
            else
            {
                dt = (DataTable)ViewState["Attendees"];
            }

            DataRow dr = dt.NewRow();
            dr["EmployeeOrNot"] = rbEmployee.SelectedItem != null ? rbEmployee.SelectedItem.Text : "";
            dr["AttendeeType"] = rbAttendeeType.SelectedItem != null ? rbAttendeeType.SelectedItem.Text : "";
            dr["EmployeeName"] = txtEmployeeName.Text.Trim();
            dr["AttendeeCode"] = txtAttendeeCode.Text.Trim();
            dr["GatePassNo"] = txtgatepassno.Text.Trim();
            dr["Designation"] = txtdes.Text.Trim();
            dt.Rows.Add(dr);

            ViewState["Attendees"] = dt;
            gvAttendees.DataSource = dt;
            gvAttendees.DataBind();

            // Clear input fields for next attendee
            rbEmployee.ClearSelection();
            rbAttendeeType.ClearSelection();
            txtEmployeeName.Text = "";
            txtAttendeeCode.Text = "";
            txtgatepassno.Text = "";
            txtdes.Text = "";
        }
        protected void btnsave2_Click(object sender, EventArgs e)
        {
            // Ensure GridView has data
            if (gvAttendees.Rows.Count > 0)
            {
                // Retrieve MM_Id from the first div (assuming it's stored in a hidden field)
                string meetingId = HiddenField_MMId.Value; // Make sure you set this value when saving Meeting records

                if (string.IsNullOrEmpty(meetingId) && ViewState["MM_Id"] != null)
                {
                    meetingId = ViewState["MM_Id"].ToString();
                }

                // ✅ Debugging: Show what MM_Id is retrieved
                lbl_btnsave22.Text = $"Retrieved Meeting ID: {meetingId}";

                if (string.IsNullOrEmpty(meetingId))
                {
                    lbl_btnsave22.Text = "Error: Meeting ID is missing!";
                    lbl_btnsave22.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Initialize variables for comma-separated values
                List<string> attendeeCodes = new List<string>();
                List<string> employeeNames = new List<string>();
                List<string> attendeeTypes = new List<string>();
                List<string> designations = new List<string>();
                List<string> gatePassNos = new List<string>();

                // Iterate through GridView rows and collect data
                foreach (GridViewRow row in gvAttendees.Rows)
                {
                    attendeeCodes.Add(row.Cells[2].Text.Trim()); // AttendeeCode
                    employeeNames.Add(row.Cells[1].Text.Trim()); // EmployeeName
                    attendeeTypes.Add(row.Cells[4].Text.Trim()); // Attendee_Type
                    designations.Add(row.Cells[5].Text.Trim()); // Designation
                    gatePassNos.Add(row.Cells[3].Text.Trim()); // Gate Pass No
                }

                // Convert lists to comma-separated strings
                string strAttendeeCodes = string.Join(",", attendeeCodes);
                string strEmployeeNames = string.Join(",", employeeNames);
                string strAttendeeTypes = string.Join(",", attendeeTypes);
                string strDesignations = string.Join(",", designations);
                string strGatePassNos = string.Join(",", gatePassNos);

                byte[] imageBytes = null;
                if (imgupload.HasFile)
                {
                    using (System.IO.BinaryReader br = new System.IO.BinaryReader(imgupload.PostedFile.InputStream))
                    {
                        imageBytes = br.ReadBytes(imgupload.PostedFile.ContentLength);
                    }
                }

                // Database connection
                string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = @"INSERT INTO csm_massmeting_attendee 
                            (MM_Id, AttendeeCode, EmployeeName, Attendee_Type, Designation, Gate_passno,Image_upload) 
                            VALUES (@MM_Id, @AttendeeCode, @EmployeeName, @Attendee_Type, @Designation, @Gate_passno, @Image_upload)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MM_Id", meetingId);
                        cmd.Parameters.AddWithValue("@AttendeeCode", strAttendeeCodes);
                        cmd.Parameters.AddWithValue("@EmployeeName", strEmployeeNames);
                        cmd.Parameters.AddWithValue("@Attendee_Type", strAttendeeTypes);
                        cmd.Parameters.AddWithValue("@Designation", strDesignations);
                        cmd.Parameters.AddWithValue("@Gate_passno", strGatePassNos);

                        if (imageBytes != null)
                        {
                            cmd.Parameters.Add("@Image_upload", SqlDbType.VarBinary).Value = imageBytes;
                        }
                        else
                        {
                            cmd.Parameters.Add("@Image_upload", SqlDbType.VarBinary).Value = DBNull.Value;
                        }



                        int rowsInserted = cmd.ExecuteNonQuery();
                        if (rowsInserted > 0)
                        {
                            lbl_btnsave22.Text = "Attendees saved successfully!";
                            lbl_btnsave22.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            lbl_btnsave22.Text = "Failed to save attendees!";
                            lbl_btnsave22.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
            else
            {
                lbl_btnsave22.Text = "No attendees to save!";
                lbl_btnsave22.ForeColor = System.Drawing.Color.Red;
            }
        }

       

    }
}