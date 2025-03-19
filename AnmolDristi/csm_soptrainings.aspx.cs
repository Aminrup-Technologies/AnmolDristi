using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class csm_soptrainings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvParticipants.Visible = false; // Initially hide the GridView
                gvSOPFeedback.Visible = false; // Initially hide SOP Feedback GridView
            }
        }

        protected void btnAddParticipant_Click(object sender, EventArgs e)
        {
            gvParticipants.Visible = true; // Show GridView when button is clicked

            DataTable dt = new DataTable();
            dt.Columns.Add("RowNumber");
            // This loop adds an empty row for every existing participant in the GridView
            foreach (GridViewRow row in gvParticipants.Rows)
            {
                DataRow dr = dt.NewRow();
                dr["RowNumber"] = (row.RowIndex + 1).ToString();
                dt.Rows.Add(dr);
            }

            // Adding a new row
            DataRow newRow = dt.NewRow();
            newRow["RowNumber"] = (dt.Rows.Count + 1).ToString();
            dt.Rows.Add(newRow);

            gvParticipants.DataSource = dt;
            gvParticipants.DataBind();
        }

        protected void gvParticipants_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int participantId = Convert.ToInt32(gvParticipants.DataKeys[e.RowIndex].Value);
            DeleteParticipant(participantId);
            BindGridView(); // Refresh GridView after deletion
        }

        private void DeleteParticipant(int participantId)
        {
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "DELETE FROM Participants WHERE ParticipantID = @ParticipantID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ParticipantID", participantId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("csm_soptrainings.aspx");
        }

        private void BindGridView()
        {
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT ParticipantID, EmployeeName, Designation FROM Participants";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            gvParticipants.DataSource = dt;
                            gvParticipants.DataBind();
                            gvParticipants.Visible = true; // Show GridView if data is available
                        }
                        else
                        {
                            gvParticipants.Visible = false; // Hide GridView if no data
                        }
                    }
                }
            }
        }

        protected void btnAddFeedback_Click(object sender, EventArgs e)
        {
            gvSOPFeedback.Visible = true; // Show GridView when button is clicked

            DataTable dt = new DataTable();
            dt.Columns.Add("RowNumber");
            // This loop adds an empty row for every existing feedback in the GridView
            foreach (GridViewRow row in gvSOPFeedback.Rows)
            {
                DataRow dr = dt.NewRow();
                dr["RowNumber"] = (row.RowIndex + 1).ToString();
                dt.Rows.Add(dr);
            }

            // Adding a new row for feedback
            DataRow newRow = dt.NewRow();
            newRow["RowNumber"] = (dt.Rows.Count + 1).ToString();
            dt.Rows.Add(newRow);

            gvSOPFeedback.DataSource = dt;
            gvSOPFeedback.DataBind();
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string sopNumber = txtSOPNumber.Text;
            DateTime trainingDate = DateTime.Parse(txtTrainingDate.Text);
            TimeSpan time = TimeSpan.Parse(txtTime.Text);
            string description = txtDescription.Text;
            string faculty = txtFaculty.Text;
            int durationMinutes = int.Parse(txtDuration.Text);

            // Add SOP training details to the database
            SaveTrainingSession(sopNumber, trainingDate, time, description, faculty, durationMinutes);

            // Add SOP feedback if provided
            foreach (GridViewRow row in gvSOPFeedback.Rows)
            {
                string feedback = (row.FindControl("txtFeedback") as TextBox).Text;
                SaveFeedback(feedback);
            }

            // Clear the GridView and form fields after submit
            gvParticipants.Visible = false;
            gvSOPFeedback.Visible = false;
            txtSOPNumber.Text = "";
            txtTrainingDate.Text = "";
            txtTime.Text = "";
            txtDescription.Text = "";
            txtFaculty.Text = "";
            txtDuration.Text = "";
        }

        private void SaveTrainingSession(string sopNumber, DateTime trainingDate, TimeSpan time, string description, string faculty, int durationMinutes)
        {
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "INSERT INTO TrainingSessions (SOPNumber, TrainingDate, Time, Description, Faculty, DurationMinutes) " +
                               "VALUES (@SOPNumber, @TrainingDate, @Time, @Description, @Faculty, @DurationMinutes)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SOPNumber", sopNumber);
                    cmd.Parameters.AddWithValue("@TrainingDate", trainingDate);
                    cmd.Parameters.AddWithValue("@Time", time);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@Faculty", faculty);
                    cmd.Parameters.AddWithValue("@DurationMinutes", durationMinutes);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void SaveFeedback(string feedback)
        {
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "INSERT INTO SOPFeedback (Feedback) VALUES (@Feedback)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Feedback", feedback);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}