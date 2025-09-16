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

namespace AnmolDristi
{
    public partial class WorkerCompetencyUpdate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                int assessmentID;
                if (int.TryParse(Request.QueryString["AssessmentID"], out assessmentID))
                {
                    LoadDetails(assessmentID);
                }
            }


        }

        private void LoadDetails(int assessmentID)
        {
            string query = @"SELECT AssessmentID, Date, NameOfWorkman, Designation, TechnicalKnowledge, TechnicalSkills, 
                                    ConsistencyInJob, JobQuality, SafetyAwareness, TotalMark, Score, Percentage, EvaluationCategory
                             FROM WorkerCompetencyAssessment
                             WHERE AssessmentID = @AssessmentID";

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@AssessmentID", assessmentID);
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        tb_Date.Text = Convert.ToDateTime(reader["Date"]).ToString("yyyy-MM-dd");
                        tb_NameOfWorkman.Text = reader["NameOfWorkman"].ToString();
                        tb_Designation.Text = reader["Designation"].ToString();
                        tb_TechnicalKnowledge.Text = reader["TechnicalKnowledge"].ToString();
                        tb_TechnicalSkills.Text = reader["TechnicalSkills"].ToString();
                        tb_ConsistencyInJob.Text = reader["ConsistencyInJob"].ToString();
                        tb_JobQuality.Text = reader["JobQuality"].ToString();
                        tb_SafetyAwareness.Text = reader["SafetyAwareness"].ToString();

                        tb_TotalMark.Text = reader["TotalMark"].ToString();
                        tb_Score.Text = reader["Score"].ToString();
                        tb_Percentage.Text = reader["Percentage"].ToString();

                        // Set hidden fields and label for evaluation category
                        hf_Category.Value = reader["EvaluationCategory"].ToString();
                        lbl_CategoryDisplay.Text = hf_Category.Value;

                        // Also update the CSS class for evaluation category label according to your styles:
                        string catClass = hf_Category.Value.Trim();
                        lbl_CategoryDisplay.CssClass = "form-control form-control-sm eval-category " + catClass;
                    }
                    else
                    {
                        
                    }
                }
            }
        }

        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            int assessmentID;
            // Get the ID of the record being updated from the query string
            if (!int.TryParse(Request.QueryString["AssessmentID"], out  assessmentID))
            {
                lblMsg.Text = "Invalid record. Cannot update.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"
            UPDATE WorkerCompetencyAssessment SET
                NameOfWorkman = @NameOfWorkman,
                Designation = @Designation,
                TechnicalKnowledge = @TechnicalKnowledge,
                TechnicalSkills = @TechnicalSkills,
                ConsistencyInJob = @ConsistencyInJob,
                JobQuality = @JobQuality,
                SafetyAwareness = @SafetyAwareness,
                TotalMark = @TotalMark,
                Score = @Score,
                Percentage = @Percentage,
                EvaluationCategory = @EvaluationCategory,
                Date = @Date
            WHERE AssessmentID = @AssessmentID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@AssessmentID", assessmentID);
                    cmd.Parameters.AddWithValue("@NameOfWorkman", tb_NameOfWorkman.Text.Trim());
                    cmd.Parameters.AddWithValue("@Designation", tb_Designation.Text.Trim());
                    cmd.Parameters.AddWithValue("@TechnicalKnowledge", Convert.ToInt32(tb_TechnicalKnowledge.Text));
                    cmd.Parameters.AddWithValue("@TechnicalSkills", Convert.ToInt32(tb_TechnicalSkills.Text));
                    cmd.Parameters.AddWithValue("@ConsistencyInJob", Convert.ToInt32(tb_ConsistencyInJob.Text));
                    cmd.Parameters.AddWithValue("@JobQuality", Convert.ToInt32(tb_JobQuality.Text));
                    cmd.Parameters.AddWithValue("@SafetyAwareness", Convert.ToInt32(tb_SafetyAwareness.Text));
                    cmd.Parameters.AddWithValue("@TotalMark", Convert.ToInt32(tb_TotalMark.Text));
                    cmd.Parameters.AddWithValue("@Score", Convert.ToInt32(hf_Score.Value));
                    cmd.Parameters.AddWithValue("@Percentage", Convert.ToDecimal(hf_Percentage.Value));
                    cmd.Parameters.AddWithValue("@EvaluationCategory", hf_Category.Value);
                    cmd.Parameters.AddWithValue("@Date", Convert.ToDateTime(tb_Date.Text));

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();
                    con.Close();

                    if (rows > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotify",
                                            "new PNotify({ " +
                                            "title: 'Success'," +
                                            "text: 'Record updated successfully.'," +
                                            "type: 'success'," +
                                            "styling: 'bootstrap3'," +
                                            "delay: 2000 });", true);

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotify",
                                 "new PNotify({ " +
                                 "title: 'Error'," +
                                 "text: 'Update failed. Please try again.'," +
                                 "type: 'error'," +
                                 "styling: 'bootstrap3'," +
                                 "delay: 3000 });", true);
                    }
                }
            }
        }

        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("WorkerCompetencyView.aspx");
        }

    }
}