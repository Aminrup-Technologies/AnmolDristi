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
    public partial class incident_View : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadIncidentData();
            }
        }


        private void LoadIncidentData()
{
    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

    using (SqlConnection conn = new SqlConnection(connectionString))
    {
        conn.Open();
        string query = @"
        SELECT 
         
    i.IncidentID, 
    i.IncidentClassification, 
    CONVERT(VARCHAR, i.DateOfIncident, 23) AS DateOfIncident, 
    i.TimeOfIncident AS TimeOfIncident,  
    i.Location, i.Section, i.Department, 
    p.VendorName, p.TotalInjuredPersons, p.NameOfPersonInvolved, 
    p.AnyWitness, p.WitnessNames, p.ReportedBy,
    inv.InvestigationTeamMembers, inv.TaskAndDescription, inv.RootCauseAnalysis, 
    inv.ReviewDate, inv.PreventiveActions, inv.CorrectiveActions

        FROM IncidentDetails i
        LEFT JOIN PeopleInvolved p ON i.IncidentID = p.IncidentID
        LEFT JOIN InvestigationActions inv ON i.IncidentID = inv.IncidentID
        ORDER BY i.IncidentID DESC";



        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);


                gvIncidentData.DataSource = dt;
                gvIncidentData.DataBind();
            }
        }
    }
}


protected void gvIncidentData_RowEditing(object sender, GridViewEditEventArgs e)
{
    gvIncidentData.EditIndex = e.NewEditIndex;
    LoadIncidentData();
}

protected void gvIncidentData_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
{
    gvIncidentData.EditIndex = -1;
    LoadIncidentData();
}

protected void gvIncidentData_RowUpdating(object sender, GridViewUpdateEventArgs e)
{
    int incidentID = Convert.ToInt32(gvIncidentData.DataKeys[e.RowIndex].Values["IncidentID"]);
    GridViewRow row = gvIncidentData.Rows[e.RowIndex];

    // Fetch updated values from GridView
    string incidentClassification = ((TextBox)row.FindControl("txtIncidentClassification")).Text;
    string dateOfIncident = ((TextBox)row.FindControl("txtDateOfIncident")).Text;
    string timeOfIncident = ((TextBox)row.FindControl("txtTimeOfIncident")).Text;
    string location = ((TextBox)row.FindControl("txtLocation")).Text;
    string section = ((TextBox)row.FindControl("txtSection")).Text;
    string department = ((TextBox)row.FindControl("txtDepartment")).Text;
    string vendorName = ((TextBox)row.FindControl("txtVendorName")).Text;
    string totalInjuredPersons = ((TextBox)row.FindControl("txtTotalInjuredPersons")).Text;
    string nameOfPersonInvolved = ((TextBox)row.FindControl("txtNameOfPersonInvolved")).Text;
    string InvestigationTeamMembers = ((TextBox)row.FindControl("txtInvestigationTeamMembers")).Text;
    string TaskAndDescription = ((TextBox)row.FindControl("txtTaskAndDescription")).Text;
    string rootCauseAnalysis = ((TextBox)row.FindControl("txtRootCauseAnalysis")).Text;
    string reviewDate = ((TextBox)row.FindControl("txtReviewDate")).Text;
    string preventiveActions = ((TextBox)row.FindControl("txtPreventiveActions")).Text;
    string correctiveActions = ((TextBox)row.FindControl("txtCorrectiveActions")).Text;

    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

    using (SqlConnection conn = new SqlConnection(connectionString))
    {
        conn.Open();
        string updateQuery = @"
                UPDATE IncidentDetails 
                SET IncidentClassification = @IncidentClassification, 
                    DateOfIncident = @DateOfIncident, 
                    TimeOfIncident = @TimeOfIncident, 
                    Location = @Location, 
                    Section = @Section, 
                    Department = @Department
                WHERE IncidentID = @IncidentID;

                UPDATE PeopleInvolved 
                SET NameOfPersonInvolved = @NameOfPersonInvolved,
                    VendorName = @VendorName, 
                    TotalInjuredPersons = @TotalInjuredPersons
                WHERE IncidentID = @IncidentID;

                UPDATE InvestigationActions 
                SET InvestigationTeamMembers = @InvestigationTeamMembers,
                    TaskAndDescription = @TaskAndDescription,
                    RootCauseAnalysis = @RootCauseAnalysis,
                    ReviewDate = @ReviewDate,
                    PreventiveActions = @PreventiveActions,
                    CorrectiveActions = @CorrectiveActions
                WHERE IncidentID = @IncidentID;
            ";

        using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
        {
            cmd.Parameters.AddWithValue("@IncidentID", incidentID);
            cmd.Parameters.AddWithValue("@IncidentClassification", incidentClassification);
            cmd.Parameters.AddWithValue("@DateOfIncident", dateOfIncident);
            cmd.Parameters.AddWithValue("@TimeOfIncident", timeOfIncident);
            cmd.Parameters.AddWithValue("@Location", location);
            cmd.Parameters.AddWithValue("@Section", section);
            cmd.Parameters.AddWithValue("@Department", department);
            cmd.Parameters.AddWithValue("@VendorName", vendorName);
            cmd.Parameters.AddWithValue("@TotalInjuredPersons", totalInjuredPersons);
            cmd.Parameters.AddWithValue("@NameOfPersonInvolved", nameOfPersonInvolved);
            cmd.Parameters.AddWithValue("@InvestigationTeamMembers", InvestigationTeamMembers);
            cmd.Parameters.AddWithValue("@TaskAndDescription", TaskAndDescription);
            cmd.Parameters.AddWithValue("@RootCauseAnalysis", rootCauseAnalysis);
            cmd.Parameters.AddWithValue("@ReviewDate", reviewDate);
            cmd.Parameters.AddWithValue("@PreventiveActions", preventiveActions);
            cmd.Parameters.AddWithValue("@CorrectiveActions", correctiveActions);

            cmd.ExecuteNonQuery();
        }
    }

    gvIncidentData.EditIndex = -1;
    LoadIncidentData();
}

protected void gvIncidentData_RowDeleting(object sender, GridViewDeleteEventArgs e)
{
    int incidentID = Convert.ToInt32(gvIncidentData.DataKeys[e.RowIndex].Values["IncidentID"]);
    string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

    using (SqlConnection conn = new SqlConnection(connectionString))
    {
        conn.Open();
        string deleteQuery = @"
                DELETE FROM PeopleInvolved WHERE IncidentID = @IncidentID;
                DELETE FROM InvestigationActions WHERE IncidentID = @IncidentID;
                DELETE FROM IncidentDetails WHERE IncidentID = @IncidentID;
            ";

        using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
        {
            cmd.Parameters.AddWithValue("@IncidentID", incidentID);
            cmd.ExecuteNonQuery();
        }
    }

    LoadIncidentData();
}
        }
    }












