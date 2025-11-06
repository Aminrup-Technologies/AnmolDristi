using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;



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

            try
            {

                int incidentID = Convert.ToInt32(gvIncidentData.DataKeys[e.RowIndex].Values["IncidentID"]);
                GridViewRow row = gvIncidentData.Rows[e.RowIndex];

                // Fetch updated values from GridView
                DropDownList ddlIncidentClassification = (DropDownList)row.FindControl("ddlIncidentClassification");
                string incidentClassification = ddlIncidentClassification.SelectedValue;

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
                string why1_Loss = ((TextBox)row.FindControl("txtWhy1Loss")).Text;
                string why2_Incident = ((TextBox)row.FindControl("txtWhy2_Incident")).Text;
                string why3_ImmediateCause = ((TextBox)row.FindControl("txtWhy3_ImmediateCause")).Text;
                string why4_UnderlyingCause = ((TextBox)row.FindControl("txtWhy4_UnderlyingCause")).Text;
                string why5_RootCause = ((TextBox)row.FindControl("txtWhy5_RootCause")).Text;
                string why6_How = ((TextBox)row.FindControl("txtWhy6_How")).Text;

                //FileUpload fuImage = (FileUpload)row.FindControl("fuSupportingImage");
                //string fileName = null;

                //if (fuImage != null && fuImage.HasFile)
                //{
                //    fileName = Path.GetFileName(fuImage.FileName);
                //    string savePath = Server.MapPath("~/Uploads/") + fileName;
                //    fuImage.SaveAs(savePath);
                //}



                //string reviewDate = ((TextBox)row.FindControl("txtReviewDate")).Text;
                string preventiveActions = ((TextBox)row.FindControl("txtPreventiveActions")).Text;
                            string correctiveActions = ((TextBox)row.FindControl("txtCorrectiveActions")).Text;
                             string finalRootCause = ((TextBox)row.FindControl("txtFinalRootCause")).Text;

                            HiddenField hf = (HiddenField)row.FindControl("hfFinalRootCauseImage");
                            string existingImagePath = hf.Value;


                            TimeSpan timeOfIncidentValue;

                            // Handle Time
                            if (!TimeSpan.TryParse(timeOfIncident, out timeOfIncidentValue))
                            {
                                // Default to 00:00 if not valid
                                timeOfIncidentValue = new TimeSpan(0, 0, 0);
                            }


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

                                -- Your existing InvestigationActions update
                                UPDATE InvestigationActions 
                                SET InvestigationTeamMembers = @InvestigationTeamMembers,
                                    TaskAndDescription = @TaskAndDescription,
                                    Why1_Loss = @Why1_Loss,
                                    Why2_Incident = @Why2_Incident,
                                    Why3_ImmediateCause = @Why3_ImmediateCause,
                                    Why4_UnderlyingCause = @Why4_UnderlyingCause,
                                    Why5_RootCause = @Why5_RootCause,
                                    Why6_How = @Why6_How,
                                    PreventiveActions = @PreventiveActions,
                                    CorrectiveActions = @CorrectiveActions, 
                                    FinalRootCause = @FinalRootCause,
                                    FinalRootCauseImagePath = @FinalRootCauseImagePath
                                WHERE IncidentID = @IncidentID;

                                ";

                

                           using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                            {
                                cmd.Parameters.AddWithValue("@IncidentID", incidentID);
                                cmd.Parameters.AddWithValue("@IncidentClassification", incidentClassification);
                                cmd.Parameters.AddWithValue("@DateOfIncident", dateOfIncident);
                              //cmd.Parameters.AddWithValue("@TimeOfIncident", timeOfIncident);
                                cmd.Parameters.Add("@TimeOfIncident", SqlDbType.Time).Value = timeOfIncidentValue;
                                cmd.Parameters.AddWithValue("@Location", location);
                                cmd.Parameters.AddWithValue("@Section", section);
                                cmd.Parameters.AddWithValue("@Department", department);
                                cmd.Parameters.AddWithValue("@VendorName", vendorName);
                                cmd.Parameters.AddWithValue("@TotalInjuredPersons", totalInjuredPersons);
                                cmd.Parameters.AddWithValue("@NameOfPersonInvolved", nameOfPersonInvolved);
                                cmd.Parameters.AddWithValue("@InvestigationTeamMembers", InvestigationTeamMembers);
                                cmd.Parameters.AddWithValue("@TaskAndDescription", TaskAndDescription);
                                cmd.Parameters.AddWithValue("@Why1_Loss", why1_Loss);
                                cmd.Parameters.AddWithValue("@Why2_Incident", why2_Incident);
                                cmd.Parameters.AddWithValue("@Why3_ImmediateCause", why3_ImmediateCause);
                                cmd.Parameters.AddWithValue("@Why4_UnderlyingCause", why4_UnderlyingCause);
                                cmd.Parameters.AddWithValue("@Why5_RootCause", why5_RootCause);
                                cmd.Parameters.AddWithValue("@Why6_How", why6_How);
                                string imagePath = null;
                                FileUpload fuRootCauseImage = (FileUpload)gvIncidentData.Rows[e.RowIndex].FindControl("fuRootCauseImage");


                                //string fileName = null;


                                if (fuRootCauseImage != null && fuRootCauseImage.HasFile)
                                {
                                    string fileName = Path.GetFileName(fuRootCauseImage.FileName);
                                    imagePath = "~/Uploads/" + fileName;
                                    fuRootCauseImage.SaveAs(Server.MapPath(imagePath));
                                }
                                else
                                {
                                    // No new file uploaded — keep the existing image
                                    imagePath = existingImagePath;
                                }

                                cmd.Parameters.AddWithValue("@FinalRootCauseImagePath", (object)imagePath ?? DBNull.Value);



                                //cmd.Parameters.AddWithValue("@ReviewDate", reviewDate);
                                cmd.Parameters.AddWithValue("@PreventiveActions", preventiveActions);
                                cmd.Parameters.AddWithValue("@CorrectiveActions", correctiveActions);
                                cmd.Parameters.AddWithValue("@FinalRootCause", finalRootCause);
                               // cmd.Parameters.AddWithValue("@SupportingImage", DBNull.Value); // Or set actual path/value if needed

                                cmd.ExecuteNonQuery();
                           }
                        }

                     //  PNotify Success
                    ScriptManager.RegisterStartupScript(this, GetType(), "updateSuccess",
                        "new PNotify({title: 'Success', text: 'Record updated successfully!', type: 'success', styling: 'bootstrap3'});", true);


                    gvIncidentData.EditIndex = -1;
                    LoadIncidentData();
            }
            catch (Exception ex)
            {
                // PNotify Error
                ScriptManager.RegisterStartupScript(this, GetType(), "updateError",
                    $"new PNotify({{title: 'Error', text: 'Update failed: {ex.Message.Replace("'", "")}', type: 'error', styling: 'bootstrap3'}});", true);
            }
        }

        protected void gvIncidentData_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
           try
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
                    //  Show success notification
                    ScriptManager.RegisterStartupScript(this, GetType(), "deleteSuccess",
                        "new PNotify({ title: 'Deleted', text: 'Incident record deleted successfully!', type: 'success', styling: 'bootstrap3', delay: 2000 });", true);
           }
           catch (Exception ex)
           {
                    //  Show error notification
                    ScriptManager.RegisterStartupScript(this, GetType(), "deleteError",
                        $"new PNotify({{ title: 'Error', text: 'Failed to delete: {ex.Message.Replace("'", "")}', type: 'error', styling: 'bootstrap3' }});", true);
           }
        }


        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (gvIncidentData.Rows.Count > 0)
            {
                gvIncidentData.UseAccessibleHeader = true;
                gvIncidentData.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }
    }
}












