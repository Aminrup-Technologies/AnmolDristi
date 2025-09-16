using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Script.Serialization;
using System.Drawing;

namespace AnmolDristi
{
    public partial class WorkerCompetencyAssessment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
     
            }
        }
        protected void BtnReset_Click(Object sender, EventArgs e)
        {
            Response.Redirect("WorkerCompetencyAssessment.aspx");
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            // pull all values from the form
            string name = tb_NameOfWorkman.Text.Trim();
            string desig = tb_Designation.Text.Trim();
            int techKnow = int.Parse(tb_TechnicalKnowledge.Text);
            int techSkill = int.Parse(tb_TechnicalSkills.Text);
            int consistency = int.Parse(tb_ConsistencyInJob.Text);
            int jobQuality = int.Parse(tb_JobQuality.Text);
            int safety = int.Parse(tb_SafetyAwareness.Text);
            int totalMark = int.Parse(tb_TotalMark.Text);        // fixed at 25
            int score;
            if (!int.TryParse(tb_Score.Text.Trim(), out score))
            {
                lblMsg.ForeColor = Color.Red;
                lblMsg.Text = "Please enter a valid numeric value for Score.";
                return;
            }

            decimal pct = decimal.Parse(tb_Percentage.Text);
            string category = hf_Category.Value;                   
            string cs = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (var con = new SqlConnection(cs))
            {
                con.Open();
                using (var tx = con.BeginTransaction())
                {
                    try
                    {
                        const string sql = @"INSERT INTO dbo.WorkerCompetencyAssessment
   (NameOfWorkman, Designation, TechnicalKnowledge, TechnicalSkills,
    ConsistencyInJob, JobQuality, SafetyAwareness, TotalMark,
    Score, Percentage, EvaluationCategory,Date)
VALUES
   (@Name, @Desig, @TechKnow, @TechSkill,
    @Consistency, @JobQuality, @Safety, @TotalMark,
    @Score, @Pct, @Category,@Date)";


                        using (var cmd = new SqlCommand(sql, con, tx))
                        {
                            cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 100)
                               .Value = name;
                            cmd.Parameters.Add("@Desig", SqlDbType.NVarChar, 50)
                               .Value = desig;
                            cmd.Parameters.Add("@TechKnow", SqlDbType.Int)
                               .Value = techKnow;
                            cmd.Parameters.Add("@TechSkill", SqlDbType.Int)
                               .Value = techSkill;
                            cmd.Parameters.Add("@Consistency", SqlDbType.Int)
                               .Value = consistency;
                            cmd.Parameters.Add("@JobQuality", SqlDbType.Int)
                               .Value = jobQuality;
                            cmd.Parameters.Add("@Safety", SqlDbType.Int)
                               .Value = safety;
                            cmd.Parameters.Add("@TotalMark", SqlDbType.Int)
                               .Value = totalMark;
                            cmd.Parameters.Add("@Score", SqlDbType.Int)
                               .Value = score;
                            cmd.Parameters.Add("@Pct", SqlDbType.Decimal)
                               .Value = pct;
                            cmd.Parameters["@Pct"].Precision = 5;
                            cmd.Parameters["@Pct"].Scale = 2;
                            cmd.Parameters.Add("@Category", SqlDbType.VarChar, 20)
                               .Value = category;
                            cmd.Parameters.AddWithValue("@Date", Convert.ToDateTime(tb_Date.Text.Trim()));

                            cmd.ExecuteNonQuery();
                        }

                        tx.Commit();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotify",
                                         "new PNotify({ " +
                                         "title: 'Success'," +
                                         "text: 'Data saved successfully!'," +
                                         "type: 'success'," +
                                         "styling: 'bootstrap3'," +
                                         "delay: 2000 });", true);
                    }

                    catch (Exception ex)
                    {
                        tx.Rollback();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "pnotify",
                                        "new PNotify({ " +
                                        "title: 'Error'," +
                                        "text: 'Error saving data: " + ex.Message.Replace("'", "\\'") + "'," +
                                        "type: 'error'," +
                                        "styling: 'bootstrap3'," +
                                        "delay: 4000 });", true);

                    }
                }
            }
        }





    }

}