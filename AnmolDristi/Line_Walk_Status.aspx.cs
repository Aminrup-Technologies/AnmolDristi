using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace AnmolDristi
{
    public partial class Line_Walk_Status : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("SP_Line_Walk_Status", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    DateTime walkDate = DateTime.Today; // Replace with: Convert.ToDateTime(txtDate.Text);
                    string jobDescription = TB_JD.Text.Trim();
                    string jobId = TB_ID.Text.Trim();

                    cmd.Parameters.AddWithValue("@WalkDate", walkDate);
                    cmd.Parameters.AddWithValue("@JobDescription", jobDescription);
                    cmd.Parameters.AddWithValue("@JobID", jobId);

                    // Get real user input from the form
                    List<TeamMember> teamMembers = GetTeamMembersFromForm();
                    DataTable teamMembersTable = GetTeamMembersTable(teamMembers);
                    SqlParameter teamParam = cmd.Parameters.AddWithValue("@TeamMembers", teamMembersTable);
                    teamParam.SqlDbType = SqlDbType.Structured;
                    teamParam.TypeName = "dbo.TeamMembersType";

                    List<WalkDetail> walkDetails = GetWalkDetailsFromForm();
                    DataTable detailsTable = GetWalkDetailsTable(walkDetails);
                    SqlParameter detailParam = cmd.Parameters.AddWithValue("@WalkDetails", detailsTable);
                    detailParam.SqlDbType = SqlDbType.Structured;
                    detailParam.TypeName = "dbo.WalkDetailsType";

                    con.Open();
                    cmd.ExecuteNonQuery();

                    string successScript = $"Swal.fire({{ title: 'Success!', text: 'Data saved successfully.', icon: 'success' }});";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitSuccess", successScript, true);
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
            Response.Redirect("Line_Walk_Status.aspx");
        }

        private DataTable GetTeamMembersTable(List<TeamMember> teamMembers)
        {
            var table = new DataTable();
            table.Columns.Add("TM_names", typeof(string));
            table.Columns.Add("TM_Image", typeof(string));

            foreach (var member in teamMembers)
            {
                table.Rows.Add(member.Name, member.Image);
            }

            return table;
        }

        private DataTable GetWalkDetailsTable(List<WalkDetail> walkDetails)
        {
            var table = new DataTable();
            table.Columns.Add("Location", typeof(string));
            table.Columns.Add("Observation_Points", typeof(string));
            table.Columns.Add("Recommendation_Points", typeof(string));
            table.Columns.Add("Responsibility", typeof(string));
            table.Columns.Add("Target_Date", typeof(DateTime));
            table.Columns.Add("Remarks", typeof(string));
            table.Columns.Add("Snap_File_Path", typeof(string));

            foreach (var detail in walkDetails)
            {
                table.Rows.Add(detail.Location, detail.Observation, detail.Recommendation,
                               detail.Responsibility, detail.TargetDate, detail.Remarks, detail.SnapPath);
            }

            return table;
        }

        // Define the data models
        public class TeamMember
        {
            public string Name { get; set; }
            public string Image { get; set; }
        }

        public class WalkDetail
        {
            public string Location { get; set; }
            public string Observation { get; set; }
            public string Recommendation { get; set; }
            public string Responsibility { get; set; }
            public DateTime TargetDate { get; set; }
            public string Remarks { get; set; }
            public string SnapPath { get; set; }
        }

        // Replace these with logic to fetch actual form values
        private List<TeamMember> GetTeamMembersFromForm()
        {
            return new List<TeamMember>(); // Fill this from your frontend inputs
        }

        private List<WalkDetail> GetWalkDetailsFromForm()
        {
            return new List<WalkDetail>(); // Fill this from your frontend inputs
        }
    }
}
