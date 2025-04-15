using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;

namespace AnmolDristi
{
    public partial class practice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // WebMethod to Fetch Employee Name based on EmpCode
        [WebMethod]
        public static object GetEmployeeName(string empCode)
        {
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT EmployeeName FROM CSMS.dbo.Committee_MeetingIssues WHERE EmpCode = @EmpCode";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@EmpCode", empCode);
                    conn.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        return new
                        {
                            success = true,
                            employeeName = result.ToString()
                        };
                    }
                    else
                    {
                        return new { success = false, message = "Invalid Employee Code!" };
                    }
                }
            }
        }

        protected void rbAttendeeType_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool isInternal = rbAttendeeType.SelectedValue == "Internal";
            txtAttendeeCode.Text = isInternal ? "" : "N/A";
            txtAttendeeCode.Enabled = isInternal;
            pnlDetails.Visible = true;
            pnlDetails1.Visible = true;
        }

        protected void btnAddAttendees_Click(object sender, EventArgs e)
        {

        }

        protected void BtnDelAttendees_Click(object sender, EventArgs e)
        {

        }

        // WebMethod to Fetch Attendee Details
        [WebMethod]
        public static object GetAttendeeDetails(string attendeeCode)
        {
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT Name, Designation FROM Committee_MeetingAttendance WHERE AttendeeCode = @AttendeeCode";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@AttendeeCode", attendeeCode);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        return new
                        {
                            success = true,
                            name = reader["Name"].ToString(),
                            designation = reader["Designation"].ToString()
                        };
                    }
                    else
                    {
                        return new { success = false, message = "Attendee Code not found!" };
                    }
                }
            }
        }
    }
}
