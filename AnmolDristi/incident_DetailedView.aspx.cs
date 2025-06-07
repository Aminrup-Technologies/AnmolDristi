using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace AnmolDristi
{
    public partial class incident_DetailedView : System.Web.UI.Page
    {
        // Read the connection string from Web.config
        string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string incidentID = Request.QueryString["IncidentID"];
                if (!string.IsNullOrEmpty(incidentID))
                {
                    LoadIncidentData(incidentID);
                }
            }
        }

        private void LoadIncidentData(string incidentID)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Incident Details
                SqlCommand cmdIncident = new SqlCommand(@"
                    SELECT IncidentID, IncidentClassification, DateOfIncident, TimeOfIncident, 
                           Location, Department, Section
                    FROM [MahimaGupta_CSMS].[IncidentDetails]
                    WHERE IncidentID = @IncidentID", conn);
                cmdIncident.Parameters.AddWithValue("@IncidentID", incidentID);

                SqlDataAdapter daIncident = new SqlDataAdapter(cmdIncident);
                DataTable dtIncident = new DataTable();
                daIncident.Fill(dtIncident);

                if (dtIncident.Rows.Count == 0)
                    return;

                DataRow combinedRow = dtIncident.Rows[0];

                string[] extraCols = new string[]
                {
                    "NameOfPersonInvolved", "TotalInjuredPersons", "VendorName",
                    "InvestigationTeamMembers", "TaskAndDescription", "FinalRootCause",
                    "Why1", "Why2", "Why3", "Why4", "Why5", "Why6",
                    "CorrectiveActions", "PreventiveActions", "SupportingImagePath"
                };
                foreach (var col in extraCols)
                {
                    if (!dtIncident.Columns.Contains(col))
                        dtIncident.Columns.Add(col);
                }

                // People Involved
                SqlCommand cmdPeople = new SqlCommand(@"
                    SELECT TOP 1 NameOfPersonInvolved, TotalInjuredPersons, VendorName
                    FROM [MahimaGupta_CSMS].[PeopleInvolved]
                    WHERE IncidentID = @IncidentID", conn);
                cmdPeople.Parameters.AddWithValue("@IncidentID", incidentID);
                SqlDataAdapter daPeople = new SqlDataAdapter(cmdPeople);
                DataTable dtPeople = new DataTable();
                daPeople.Fill(dtPeople);

                if (dtPeople.Rows.Count > 0)
                {
                    DataRow r = dtPeople.Rows[0];
                    combinedRow["NameOfPersonInvolved"] = r["NameOfPersonInvolved"];
                    combinedRow["TotalInjuredPersons"] = r["TotalInjuredPersons"];
                    combinedRow["VendorName"] = r["VendorName"];
                }

                // Investigation Details
                SqlCommand cmdInvestigation = new SqlCommand(@"
                    SELECT TOP 1 InvestigationTeamMembers, TaskAndDescription, FinalRootCause,
                                 Why1_Loss, Why2_Incident, Why3_ImmediateCause, Why4_UnderlyingCause,
                                 Why5_RootCause, Why6_How, CorrectiveActions, PreventiveActions, FinalRootCauseImagePath
                    FROM [MahimaGupta_CSMS].[InvestigationActions]
                    WHERE IncidentID = @IncidentID", conn);
                cmdInvestigation.Parameters.AddWithValue("@IncidentID", incidentID);
                SqlDataAdapter daInvestigation = new SqlDataAdapter(cmdInvestigation);
                DataTable dtInvestigation = new DataTable();
                daInvestigation.Fill(dtInvestigation);

                if (dtInvestigation.Rows.Count > 0)
                {
                    DataRow r = dtInvestigation.Rows[0];
                    combinedRow["InvestigationTeamMembers"] = r["InvestigationTeamMembers"];
                    combinedRow["TaskAndDescription"] = r["TaskAndDescription"];
                    combinedRow["FinalRootCause"] = r["FinalRootCause"];
                    combinedRow["Why1"] = r["Why1_Loss"];
                    combinedRow["Why2"] = r["Why2_Incident"];
                    combinedRow["Why3"] = r["Why3_ImmediateCause"];
                    combinedRow["Why4"] = r["Why4_UnderlyingCause"];
                    combinedRow["Why5"] = r["Why5_RootCause"];
                    combinedRow["Why6"] = r["Why6_How"];
                    combinedRow["CorrectiveActions"] = r["CorrectiveActions"];
                    combinedRow["PreventiveActions"] = r["PreventiveActions"];
                    combinedRow["SupportingImagePath"] = r["FinalRootCauseImagePath"];
                }

                // Bind to GridView or Repeater
                gvIncidentView.DataSource = dtIncident;
                gvIncidentView.DataBind();
            }
        }
    }
}