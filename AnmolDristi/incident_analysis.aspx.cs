
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
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
    i.IncidentID, 
    i.IncidentClassification, 
    i.DateOfIncident, 
    i.Location, 
    i.Department, 
i.TimeOfIncident,   
 i.Section,  
    i.SubmittedDate,                    
    i.SubmittedTime,
    p.NameOfPersonInvolved, 
    p.AnyWitness, 
    p.WitnessNames, 
    p.ReportedBy, 
 p.VendorName,   
p.TotalInjuredPersons, 
    inv.CorrectiveActions,
    inv.PreventiveActions,
    inv.InvestigationTeamMembers,
    inv.TaskAndDescription,
    inv.FinalRootCause,
    inv.Why1_Loss,
    inv.Why2_Incident,
    inv.Why3_ImmediateCause,
    inv.Why4_UnderlyingCause,
    inv.Why5_RootCause,
    inv.Why6_How,
inv.FinalRootCauseImagePath
FROM IncidentDetails i
LEFT JOIN PeopleInvolved p ON i.IncidentID = p.IncidentID
LEFT JOIN InvestigationActions inv ON i.IncidentID = inv.IncidentID
ORDER BY i.IncidentID DESC;
";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                    //    gvIncidentData.DataSource = dt;
                     //   gvIncidentData.DataBind();
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
                                      //lblMessage.ForeColor = System.Drawing.Color.Green;
                                      //lblMessage.Text = "Incident data saved successfully!";

                //  Show success notification
                ScriptManager.RegisterStartupScript(this, GetType(), "saveSuccess",
                    "new PNotify({ title: 'Success', text: 'Incident data saved successfully!', type: 'success', styling: 'bootstrap3', delay: 2500 });", true);


                LoadIncidentData(); // Refresh GridView with new data
            }
            catch (Exception ex)
            {
                //  Show error notification
                ScriptManager.RegisterStartupScript(this, GetType(), "saveError",
                    $"new PNotify({{ title: 'Error', text: 'Error while saving: {ex.Message.Replace("'", "")}', type: 'error', styling: 'bootstrap3' }});", true);
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
            txtTaskDescription.Text = ""; // Merged field
            txtWhy1.Text = "";
            txtWhy2.Text = "";
            txtWhy3.Text = "";
            txtWhy4.Text = "";
            txtWhy5.Text = "";
            txtWhy6.Text = "";
            txtCorrectiveActions.Text = "";
            txtPreventiveActions.Text = "";
            // txtReviewDate.Text = "";
            txtFinalRootCause.Text = "";


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
            string witnessNames = hfWitnessList.Value;
            string reportedBy = txtReportedBy.Text;
            string vendorName = txtVendorName.Text;
            DateTime submittedDateTime = DateTime.Now;
            DateTime submittedDate = submittedDateTime.Date;
            TimeSpan submittedTime = submittedDateTime.TimeOfDay;

            int totalInjuredPersons = int.Parse(txtInjuredPersons.Text);

            string investigationTeamMembers = hfInvestigationTeamList.Value;


            string taskAndDescription = txtTaskDescription.Text;


            //string taskBeingPerformed = txtTaskBeingPerformed.Text;
            //string descriptionOfIncident = txtDescription.Text;
            //  string contributingFactorsEnvironment = chkEnvironment.Text;
            //  string contributingFactorsEquipmentMaterials = chkEquipment.Text;
            //   string contributingFactorsWorkSystems = chkWorkSystem.Text;
            //   string contributingFactorsPeople = chkPeople.Text;
            string why1_Loss = txtWhy1.Text.Trim();
            string why2_Incident = txtWhy2.Text.Trim();
            string why3_ImmediateCause = txtWhy3.Text.Trim();
            string why4_UnderlyingCause = txtWhy4.Text.Trim();
            string why5_RootCause = txtWhy5.Text.Trim();
            string why6_How = txtWhy6.Text.Trim();

            string finalRootCause = txtFinalRootCause.Text;
            string correctiveActions = txtCorrectiveActions.Text;
            string preventiveActions = txtPreventiveActions.Text;
            //DateTime reviewDate = DateTime.Parse(txtReviewDate.Text);

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
                        cmd.Parameters.AddWithValue("@SubmittedDate", submittedDate);
                        cmd.Parameters.AddWithValue("@SubmittedTime", submittedTime);


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
                        cmd.Parameters.AddWithValue("@TaskAndDescription", taskAndDescription);


                        //cmd.Parameters.AddWithValue("@TaskBeingPerformed", taskBeingPerformed);
                        //cmd.Parameters.AddWithValue("@DescriptionOfIncident", descriptionOfIncident);
                        //   cmd.Parameters.AddWithValue("@ContributingFactors_Environment", contributingFactorsEnvironment);
                        //   cmd.Parameters.AddWithValue("@ContributingFactors_Equipment_Materials", contributingFactorsEquipmentMaterials);
                        //   cmd.Parameters.AddWithValue("@ContributingFactors_WorkSystems", contributingFactorsWorkSystems);
                        //   cmd.Parameters.AddWithValue("@ContributingFactors_People", contributingFactorsPeople);

                        //cmd.Parameters.AddWithValue("@RootCauseAnalysis", rootCauseAnalysis);
                        
                            cmd.Parameters.AddWithValue("@Why1_Loss", txtWhy1.Text.Trim());
                            cmd.Parameters.AddWithValue("@Why2_Incident", txtWhy2.Text.Trim());
                            cmd.Parameters.AddWithValue("@Why3_ImmediateCause", txtWhy3.Text.Trim());
                            cmd.Parameters.AddWithValue("@Why4_UnderlyingCause", txtWhy4.Text.Trim());
                            cmd.Parameters.AddWithValue("@Why5_RootCause", txtWhy5.Text.Trim());
                            cmd.Parameters.AddWithValue("@Why6_How", txtWhy6.Text.Trim());

                            cmd.Parameters.AddWithValue("@CorrectiveActions", correctiveActions);
                            cmd.Parameters.AddWithValue("@PreventiveActions", preventiveActions);
                            cmd.Parameters.AddWithValue("@FinalRootCause", txtFinalRootCause.Text.Trim());


                        string imagePath = null;
                        if (fuRootCauseImage.HasFile)
                        {
                            string fileName = Path.GetFileName(fuRootCauseImage.FileName);
                            imagePath = "~/Uploads/" + fileName;  // virtual path for storing in DB
                            string physicalPath = Server.MapPath(imagePath);
                            fuRootCauseImage.SaveAs(physicalPath);
                        }

                        cmd.Parameters.AddWithValue("@FinalRootCauseImagePath", (object)imagePath ?? DBNull.Value);

           

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






