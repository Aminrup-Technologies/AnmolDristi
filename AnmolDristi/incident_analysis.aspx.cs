



using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class incident_analysis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadIncidentData(); // Load existing records
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
                i.IncidentID, i.IncidentClassification, i.DateOfIncident, i.Location, i.Department, 
                p.NameOfPersonInvolved, p.AnyWitness, p.WitnessNames, p.ReportedBy, 
                inv.DescriptionOfIncident, inv.ContributingFactors_Environment, inv.CorrectiveActions
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


        protected void ValidateIncidentDateTime(object source, ServerValidateEventArgs args)
        {
            DateTime selectedDate;
            TimeSpan selectedTime;

            if (!DateTime.TryParse(txtDateOfIncident.Text, out selectedDate))
            {
                args.IsValid = false; // Invalid date format
                return;
            }

            if (!TimeSpan.TryParse(txtTimeOfIncident.Text, out selectedTime))
            {
                args.IsValid = false; // Invalid time format
                return;
            }

            DateTime incidentDateTime = selectedDate.Date + selectedTime;

            if (incidentDateTime > DateTime.Now)
            {
                args.IsValid = false; // Validation failed
            }
            else
            {
                args.IsValid = true; // Validation passed
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                InsertIncidentData(); // Save form data
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Incident data saved successfully!";

                LoadIncidentData(); // Refresh GridView with new data
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }


        protected void BtnReset_Click(object sender, EventArgs e)
        {
            // Clear all input fields
            txtDateOfIncident.Text = "";
            txtTimeOfIncident.Text = "";
            txtLocation.Text = "";
            txtDepartment.Text = "";
            txtSection.Text = "";
            txtPersonInvolved.Text = "";
            txtWitness1.Text = "";
            txtReportedBy.Text = "";
            txtVendorName.Text = "";
            txtInjuredPersons.Text = "";
            txtTaskBeingPerformed.Text = "";
            txtDescription.Text = "";
            txtWhy1.Text = "";
            txtCorrectiveActions.Text = "";
            txtPreventiveActions.Text = "";
            txtReviewDate.Text = "";

            lblMessage.Text = "Form reset successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Blue;
        }

        private void InsertIncidentData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            int incidentID;

            string incidentClassification = ddlIncidentClassification.SelectedValue;
            DateTime dateOfIncident = DateTime.Parse(txtDateOfIncident.Text);
            TimeSpan timeOfIncident = TimeSpan.Parse(txtTimeOfIncident.Text);
            string location = txtLocation.Text;
            string department = txtDepartment.Text;
            string section = txtSection.Text;
            string nameOfPersonInvolved = txtPersonInvolved.Text;
            string anyWitness = rblWitness.SelectedValue;
            string witnessNames = txtWitness1.Text;
            string reportedBy = txtReportedBy.Text;
            string vendorName = txtVendorName.Text;
            int totalInjuredPersons = int.Parse(txtInjuredPersons.Text);

            string investigationTeamMembers = txtInvestigationMember1.Text;
            string taskBeingPerformed = txtTaskBeingPerformed.Text;
            string descriptionOfIncident = txtDescription.Text;
            string contributingFactorsEnvironment = chkEnvironment.Text;
            string contributingFactorsEquipmentMaterials = chkEquipment.Text;
            string contributingFactorsWorkSystems = chkWorkSystem.Text;
            string contributingFactorsPeople = chkPeople.Text;
            string rootCauseAnalysis = txtWhy1.Text;
            string correctiveActions = txtCorrectiveActions.Text;
            string preventiveActions = txtPreventiveActions.Text;
            DateTime reviewDate = DateTime.Parse(txtReviewDate.Text);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // Step 1: Insert into IncidentDetails
                    using (SqlCommand cmd = new SqlCommand("InsertIncidentDetails", conn, transaction))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IncidentClassification", incidentClassification);
                        cmd.Parameters.AddWithValue("@DateOfIncident", dateOfIncident);
                        cmd.Parameters.AddWithValue("@TimeOfIncident", timeOfIncident);
                        cmd.Parameters.AddWithValue("@Location", location);
                        cmd.Parameters.AddWithValue("@Department", department);
                        cmd.Parameters.AddWithValue("@Section", section);

                        SqlParameter outputIdParam = new SqlParameter("@IncidentID", System.Data.SqlDbType.Int)
                        {
                            Direction = System.Data.ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputIdParam);
                        cmd.ExecuteNonQuery();
                        incidentID = (int)outputIdParam.Value;
                    }

                    // Step 2: Insert into PeopleInvolved
                    //using (SqlCommand cmd = new SqlCommand("InsertPeopleInvolved", conn, transaction))
                    using (SqlCommand cmd = new SqlCommand("InsertIncidentPeople", conn, transaction))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IncidentID", incidentID);
                        cmd.Parameters.AddWithValue("@NameOfPersonInvolved", nameOfPersonInvolved);
                        cmd.Parameters.AddWithValue("@AnyWitness", anyWitness);
                        cmd.Parameters.AddWithValue("@WitnessNames", witnessNames);
                        cmd.Parameters.AddWithValue("@ReportedBy", reportedBy);
                        cmd.Parameters.AddWithValue("@VendorName", vendorName);
                        cmd.Parameters.AddWithValue("@TotalInjuredPersons", totalInjuredPersons);
                        cmd.ExecuteNonQuery();
                    }

                    // Step 3: Insert into InvestigationActions
                    using (SqlCommand cmd = new SqlCommand("InsertInvestigationActions", conn, transaction))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IncidentID", incidentID);
                        cmd.Parameters.AddWithValue("@InvestigationTeamMembers", investigationTeamMembers);
                        cmd.Parameters.AddWithValue("@TaskBeingPerformed", taskBeingPerformed);
                        cmd.Parameters.AddWithValue("@DescriptionOfIncident", descriptionOfIncident);
                        cmd.Parameters.AddWithValue("@ContributingFactors_Environment", contributingFactorsEnvironment);
                        cmd.Parameters.AddWithValue("@ContributingFactors_Equipment_Materials", contributingFactorsEquipmentMaterials);
                        cmd.Parameters.AddWithValue("@ContributingFactors_WorkSystems", contributingFactorsWorkSystems);
                        cmd.Parameters.AddWithValue("@ContributingFactors_People", contributingFactorsPeople);
                        cmd.Parameters.AddWithValue("@RootCauseAnalysis", rootCauseAnalysis);
                        cmd.Parameters.AddWithValue("@CorrectiveActions", correctiveActions);
                        cmd.Parameters.AddWithValue("@PreventiveActions", preventiveActions);
                        cmd.Parameters.AddWithValue("@ReviewDate", reviewDate);
                        cmd.ExecuteNonQuery();
                    }

                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    throw new Exception("Transaction failed: " + ex.Message);
                }
            }
        }
    }
}
























//using System;
//using System.Collections.Generic;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;
//using System.Web.UI;
//using System.Web.UI.WebControls;

//namespace AnmolDristi
//{
//    public partial class incident_analysis : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                LoadIncidentData(); // Load existing records
//            }

//        }

//        protected void BtnAddWitness_Click(object sender, EventArgs e)
//        {
//            TextBox txtNewWitness = new TextBox
//            {
//                ID = "txtWitness" + (phWitnessNames.Controls.Count + 1)
//            };
//            phWitnessNames.Controls.Add(txtNewWitness);
//            phWitnessNames.Controls.Add(new LiteralControl("<br/>"));
//        }

//        protected void BtnAddInvestigationMember_Click(object sender, EventArgs e)
//        {
//            TextBox txtNewInvestigator = new TextBox
//            {
//                ID = "txtInvestigator" + (phInvestigationTeam.Controls.Count + 1)
//            };

//            phInvestigationTeam.Controls.Add(txtNewInvestigator);
//            phInvestigationTeam.Controls.Add(new LiteralControl("<br/>"));

//        }






//        private void LoadIncidentData()
//        {
//            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;


//            using (SqlConnection conn = new SqlConnection(connectionString))
//            {
//                conn.Open();
//                string query = @"
//            SELECT 
//                i.IncidentID, i.IncidentClassification, i.DateOfIncident, i.Location, i.Department, 
//                p.NameOfPersonInvolved, p.AnyWitness, p.WitnessNames, p.ReportedBy, 
//                inv.DescriptionOfIncident, inv.ContributingFactors_Environment, inv.CorrectiveActions
//            FROM IncidentDetails i
//            LEFT JOIN PeopleInvolved p ON i.IncidentID = p.IncidentID
//            LEFT JOIN InvestigationActions inv ON i.IncidentID = inv.IncidentID
//            ORDER BY i.IncidentID DESC";

//                using (SqlCommand cmd = new SqlCommand(query, conn))
//                {
//                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
//                    {
//                        DataTable dt = new DataTable();
//                        da.Fill(dt);
//                        gvIncidentData.DataSource = dt;
//                        gvIncidentData.DataBind();
//                    }
//                }
//            }
//        }


//        protected void ValidateIncidentDateTime(object source, ServerValidateEventArgs args)
//        {
//            DateTime selectedDate;
//            if (!DateTime.TryParse(txtDateOfIncident.Text, out selectedDate))
//            {
//                args.IsValid = false; // Invalid date format
//                return;
//            }

//            TimeSpan selectedTime;
//            if (!TimeSpan.TryParse(txtTimeOfIncident.Text, out selectedTime))
//            {
//                args.IsValid = false; // Invalid time format
//                return;
//            }

//            DateTime incidentDateTime = selectedDate.Date + selectedTime;
//            args.IsValid = incidentDateTime <= DateTime.Now;
//        }

//        protected void BtnSubmit_Click(object sender, EventArgs e)
//        {
//            try
//            {
//                InsertIncidentData(); // Save form data
//                lblMessage.ForeColor = System.Drawing.Color.Green;
//                lblMessage.Text = "Incident data saved successfully!";

//                LoadIncidentData(); // Refresh GridView with new data
//            }
//            catch (Exception ex)
//            {
//                lblMessage.ForeColor = System.Drawing.Color.Red;
//                lblMessage.Text = "Error: " + ex.Message;
//            }
//        }


//        protected void BtnReset_Click(object sender, EventArgs e)
//        {
//            // Clear all input fields
//            txtDateOfIncident.Text = "";
//            txtTimeOfIncident.Text = "";
//            txtLocation.Text = "";
//            txtDepartment.Text = "";
//            txtSection.Text = "";
//            txtPersonInvolved.Text = "";
//            //txtWitness1.Text = "";
//            txtReportedBy.Text = "";
//            txtVendorName.Text = "";
//            txtInjuredPersons.Text = "";
//            txtTaskBeingPerformed.Text = "";
//            txtDescription.Text = "";
//            txtWhy1.Text = "";
//            txtCorrectiveActions.Text = "";
//            txtPreventiveActions.Text = "";
//            txtReviewDate.Text = "";

//            lblMessage.Text = "Form reset successfully!";
//            lblMessage.ForeColor = System.Drawing.Color.Blue;
//        }

//        private void InsertIncidentData()
//        {
//            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
//            int incidentID;

//            string incidentClassification = ddlIncidentClassification.SelectedValue;
//            DateTime dateOfIncident = DateTime.Parse(txtDateOfIncident.Text);
//            TimeSpan timeOfIncident = TimeSpan.Parse(txtTimeOfIncident.Text);
//            string location = txtLocation.Text;
//            string department = txtDepartment.Text;
//            string section = txtSection.Text;
//            string nameOfPersonInvolved = txtPersonInvolved.Text;
//            string anyWitness = rblWitness.SelectedValue;
//            //string witnessNames = txtWitness1.Text;
//            string reportedBy = txtReportedBy.Text;
//            string vendorName = txtVendorName.Text;
//            int totalInjuredPersons = int.Parse(txtInjuredPersons.Text);

//            //string investigationTeamMembers = txtInvestigationMember1.Text;
//            string taskBeingPerformed = txtTaskBeingPerformed.Text;
//            string descriptionOfIncident = txtDescription.Text;
//            string contributingFactorsEnvironment = chkEnvironment.Text;
//            string contributingFactorsEquipmentMaterials = chkEquipment.Text;
//            string contributingFactorsWorkSystems = chkWorkSystem.Text;
//            string contributingFactorsPeople = chkPeople.Text;
//            string rootCauseAnalysis = txtWhy1.Text;
//            string correctiveActions = txtCorrectiveActions.Text;
//            string preventiveActions = txtPreventiveActions.Text;
//            DateTime reviewDate = DateTime.Parse(txtReviewDate.Text);

//            // **Collect all Witness Names as a comma-separated string**
//            List<string> witnessList = new List<string>();
//            foreach (Control control in phWitnessNames.Controls)
//            {
//                //if (control is TextBox txtWitness && !string.IsNullOrWhiteSpace(txtWitness.Text))
//                //{
//                //    witnessList.Add(txtWitness.Text);
//                //}
//                if (control is TextBox) // Check if it's a TextBox first
//                {
//                    TextBox txtWitness = (TextBox)control; 
//                    if (!string.IsNullOrWhiteSpace(txtWitness.Text))
//                    {
//                        witnessList.Add(txtWitness.Text);
//                    }
//                }
//            }
//            string witnessNames = string.Join(", ", witnessList);  // Convert List to CSV string

//            // **Collect all Investigation Team Members as a comma-separated string**
//            List<string> investigatorList = new List<string>();
//            foreach (Control control in phInvestigationTeam.Controls)
//            {
//                //if (control is TextBox txtInvestigator && !string.IsNullOrWhiteSpace(txtInvestigator.Text))
//                //{
//                //    investigatorList.Add(txtInvestigator.Text);
//                //}
//                if (control is TextBox)
//                {
//                    TextBox txtInvestigator = (TextBox)control; // Explicit cast
//                    if (!string.IsNullOrWhiteSpace(txtInvestigator.Text))
//                    {
//                        investigatorList.Add(txtInvestigator.Text);
//                    }
//                }
//            }
//            string investigationTeamMembers = string.Join(", ", investigatorList);
































//            using (SqlConnection conn = new SqlConnection(connectionString))
//            {
//                conn.Open();
//                SqlTransaction transaction = conn.BeginTransaction();

//                try
//                {
//                    // Step 1: Insert into IncidentDetails
//                    using (SqlCommand cmd = new SqlCommand("InsertIncidentDetails", conn, transaction))
//                    {
//                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
//                        cmd.Parameters.AddWithValue("@IncidentClassification", incidentClassification);
//                        cmd.Parameters.AddWithValue("@DateOfIncident", dateOfIncident);
//                        cmd.Parameters.AddWithValue("@TimeOfIncident", timeOfIncident);
//                        cmd.Parameters.AddWithValue("@Location", location);
//                        cmd.Parameters.AddWithValue("@Department", department);
//                        cmd.Parameters.AddWithValue("@Section", section);

//                        SqlParameter outputIdParam = new SqlParameter("@IncidentID", System.Data.SqlDbType.Int)
//                        {
//                            Direction = System.Data.ParameterDirection.Output
//                        };
//                        cmd.Parameters.Add(outputIdParam);
//                        cmd.ExecuteNonQuery();
//                        incidentID = (int)outputIdParam.Value;
//                    }

//                    // Step 2: Insert into PeopleInvolved
//                    //using (SqlCommand cmd = new SqlCommand("InsertPeopleInvolved", conn, transaction))
//                    using (SqlCommand cmd = new SqlCommand("InsertIncidentPeople", conn, transaction))
//                    {
//                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
//                        cmd.Parameters.AddWithValue("@IncidentID", incidentID);
//                        cmd.Parameters.AddWithValue("@NameOfPersonInvolved", nameOfPersonInvolved);
//                        cmd.Parameters.AddWithValue("@AnyWitness", anyWitness);
//                        cmd.Parameters.AddWithValue("@WitnessNames", witnessNames);
//                        cmd.Parameters.AddWithValue("@ReportedBy", reportedBy);
//                        cmd.Parameters.AddWithValue("@VendorName", vendorName);
//                        cmd.Parameters.AddWithValue("@TotalInjuredPersons", totalInjuredPersons);
//                        cmd.ExecuteNonQuery();
//                    }

//                    // Step 3: Insert into InvestigationActions
//                    using (SqlCommand cmd = new SqlCommand("InsertInvestigationActions", conn, transaction))
//                    {
//                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
//                        cmd.Parameters.AddWithValue("@IncidentID", incidentID);
//                        cmd.Parameters.AddWithValue("@InvestigationTeamMembers", investigationTeamMembers);
//                        cmd.Parameters.AddWithValue("@TaskBeingPerformed", taskBeingPerformed);
//                        cmd.Parameters.AddWithValue("@DescriptionOfIncident", descriptionOfIncident);
//                        cmd.Parameters.AddWithValue("@ContributingFactors_Environment", contributingFactorsEnvironment);
//                        cmd.Parameters.AddWithValue("@ContributingFactors_Equipment_Materials", contributingFactorsEquipmentMaterials);
//                        cmd.Parameters.AddWithValue("@ContributingFactors_WorkSystems", contributingFactorsWorkSystems);
//                        cmd.Parameters.AddWithValue("@ContributingFactors_People", contributingFactorsPeople);
//                        cmd.Parameters.AddWithValue("@RootCauseAnalysis", rootCauseAnalysis);
//                        cmd.Parameters.AddWithValue("@CorrectiveActions", correctiveActions);
//                        cmd.Parameters.AddWithValue("@PreventiveActions", preventiveActions);
//                        cmd.Parameters.AddWithValue("@ReviewDate", reviewDate);
//                        cmd.ExecuteNonQuery();
//                    }

//                    transaction.Commit();
//                }
//                catch (Exception ex)
//                {
//                    transaction.Rollback();
//                    throw new Exception("Transaction failed: " + ex.Message);
//                }
//            }
//        }
//    }
//}
















// Store values in variables
//        string incidentClassification = ddlIncidentClassification.SelectedValue;
//        string nameOfPersonInvolved = txtPersonInvolved.Text;
//        string location = txtLocation.Text;
//        string department = txtDepartment.Text;
//        string section = txtSection.Text;
//        string anyWitness = rblWitness.SelectedValue;
//        string witnessNames = txtWitness1.Text;
//        string reportedBy = txtReportedBy.Text;
//        string vendorName = txtVendorName.Text;
//        string totalInjuredPersons = txtInjuredPersons.Text;
//        string investigationTeamMembers = txtInvestigationMember1.Text;
//        string taskBeingPerformed = txtTaskBeingPerformed.Text;
//        string descriptionOfIncident = txtDescription.Text;
//        string contributingFactorsEnvironment = chkEnvironment.Text;
//        string contributingFactorsEquipmentMaterials = chkEquipment.Text;
//        string contributingFactorsWorkSystems = chkWorkSystem.Text;
//        string contributingFactorsPeople = chkPeople.Text;
//        string rootCauseAnalysis = txtWhy1.Text;
//        string correctiveActions = txtCorrectiveActions.Text;
//        string preventiveActions = txtPreventiveActions.Text;

//        // Parse Date and Time properly
//        DateTime dateOfIncident;
//        TimeSpan timeOfIncident;

//        bool isDateValid = DateTime.TryParse(txtDateOfIncident.Text, out dateOfIncident);
//        bool isTimeValid = TimeSpan.TryParse(txtTimeOfIncident.Text, out timeOfIncident);

//        if (!isDateValid || !isTimeValid)
//        {
//            // Handle invalid date/time (e.g., show an error message)
//            return;
//        }

//        // Combine Date and Time into a single DateTime object
//        DateTime incidentDateTime = dateOfIncident.Date + timeOfIncident;

//        // Parse Review Date (if applicable)
//        DateTime reviewDate;
//        bool isReviewDateValid = DateTime.TryParse(txtReviewDate.Text, out reviewDate);
//        if (!isReviewDateValid)
//        {
//            reviewDate = DateTime.MinValue; // Default to avoid errors
//        }

//        using (SqlConnection conn = new SqlConnection(connectionString))
//        {
//            string query = @"
//        INSERT INTO IncidentAnalysis 
//        (IncidentClassification, DateOfIncident, TimeOfIncident, NameOfPersonInvolved, Location, Department, 
//        Section, AnyWitness, WitnessNames, ReportedBy, VendorName, TotalInjuredPersons, 
//        InvestigationTeamMembers, TaskBeingPerformed, DescriptionOfIncident, 
//        ContributingFactors_Environment, ContributingFactors_Equipment_Materials, 
//        ContributingFactors_WorkSystems, ContributingFactors_People, RootCauseAnalysis, 
//        CorrectiveActions, PreventiveActions, ReviewDate)
//        VALUES 
//        (@IncidentClassification, @DateOfIncident, @TimeOfIncident, @NameOfPersonInvolved, @Location, @Department, 
//        @Section, @AnyWitness, @WitnessNames, @ReportedBy, @VendorName, @TotalInjuredPersons, 
//        @InvestigationTeamMembers, @TaskBeingPerformed, @DescriptionOfIncident, 
//        @ContributingFactors_Environment, @ContributingFactors_Equipment_Materials, 
//        @ContributingFactors_WorkSystems, @ContributingFactors_People, @RootCauseAnalysis, 
//        @CorrectiveActions, @PreventiveActions, @ReviewDate)";

//            using (SqlCommand cmd = new SqlCommand(query, conn))
//            {
//                // Assign variables to parameters
//                cmd.Parameters.AddWithValue("@IncidentClassification", incidentClassification);
//                cmd.Parameters.AddWithValue("@DateOfIncident", dateOfIncident);  // Store only the date part
//                cmd.Parameters.AddWithValue("@TimeOfIncident", timeOfIncident.ToString());  // Convert TimeSpan to string

//                cmd.Parameters.AddWithValue("@NameOfPersonInvolved", nameOfPersonInvolved);
//                cmd.Parameters.AddWithValue("@Location", location);
//                cmd.Parameters.AddWithValue("@Department", department);
//                cmd.Parameters.AddWithValue("@Section", section);
//                cmd.Parameters.AddWithValue("@AnyWitness", anyWitness);
//                cmd.Parameters.AddWithValue("@WitnessNames", witnessNames);
//                cmd.Parameters.AddWithValue("@ReportedBy", reportedBy);
//                cmd.Parameters.AddWithValue("@VendorName", vendorName);
//                cmd.Parameters.AddWithValue("@TotalInjuredPersons", totalInjuredPersons);
//                cmd.Parameters.AddWithValue("@InvestigationTeamMembers", investigationTeamMembers);
//                cmd.Parameters.AddWithValue("@TaskBeingPerformed", taskBeingPerformed);
//                cmd.Parameters.AddWithValue("@DescriptionOfIncident", descriptionOfIncident);
//                cmd.Parameters.AddWithValue("@ContributingFactors_Environment", contributingFactorsEnvironment);
//                cmd.Parameters.AddWithValue("@ContributingFactors_Equipment_Materials", contributingFactorsEquipmentMaterials);
//                cmd.Parameters.AddWithValue("@ContributingFactors_WorkSystems", contributingFactorsWorkSystems);
//                cmd.Parameters.AddWithValue("@ContributingFactors_People", contributingFactorsPeople);
//                cmd.Parameters.AddWithValue("@RootCauseAnalysis", rootCauseAnalysis);
//                cmd.Parameters.AddWithValue("@CorrectiveActions", correctiveActions);
//                cmd.Parameters.AddWithValue("@PreventiveActions", preventiveActions);
//                cmd.Parameters.AddWithValue("@ReviewDate", reviewDate);

//                conn.Open();
//                cmd.ExecuteNonQuery();
//            }
//        }
//    }
//}
