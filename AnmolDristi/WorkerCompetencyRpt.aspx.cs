using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Data.Entity.Infrastructure.Design.Executor;

namespace AnmolDristi
{
    public partial class WorkerCompetencyRpt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMeetingData();
            }
        }
        private void BindMeetingData()
        {
            string meetingId = Request.QueryString["AssessmentID"];
            if (!string.IsNullOrEmpty(meetingId))
            {
                DataTable dtMeetings = GetAssessmentById(meetingId);
                if (dtMeetings != null && dtMeetings.Rows.Count > 0)
                {
                    RepeaterMeeting.DataSource = dtMeetings;
                    RepeaterMeeting.DataBind();
                }
            }
        }


        private DataTable GetAssessmentById(string meetingId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand(@"SELECT Date ,NameOfWorkman ,Designation ,TechnicalKnowledge ,TechnicalSkills ,ConsistencyInJob ,JobQuality ,SafetyAwareness ,TotalMark ,Score ,Percentage ,EvaluationCategory 
                                                  FROM  WorkerCompetencyAssessment 
                                                  WHERE AssessmentID= @AssessmentID ", con))
                {
                    cmd.Parameters.AddWithValue("@AssessmentID", meetingId);
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

    }
}