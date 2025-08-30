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
    public partial class CAPA_MASTER : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
   
            if (!IsPostBack)
            {
                string reportIdStr = Request.QueryString["report"];
                if (!string.IsNullOrEmpty(reportIdStr))
                {
                    int reportId;
                    if (int.TryParse(reportIdStr, out reportId))
                    {
                        LoadCAPADetails(reportId);
                    }
                    else
                    {
                        // optional: show error message if report is not valid integer
                       // lblMsg.Text = "Invalid CAPA Report ID.";
                        //lblMsg.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }

        }

        private void LoadCAPADetails(int reportId)
        {
            string constr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                string query = @"SELECT TOP 1 * 
                         FROM [CSMS].[dbo].[tbl_CAPAMaster] 
                         WHERE CAPAID = @CAPAID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@CAPAID", SqlDbType.Int).Value = reportId;

                    con.Open();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            // General Details
                            // txtSourceRecordType.Text = dr["SourceTable"].ToString();
                            string headerId = dr["HeaderID"].ToString();

                            // 🔹 Step 1: Determine Source Record Type based on prefix
                            string sourceRecordType = "Unknown Type"; // default

                            if (!string.IsNullOrEmpty(headerId))
                            {
                                if (headerId.StartsWith("FE")) sourceRecordType = "Fire Extinguisher Checklist";
                                else if (headerId.StartsWith("FAB")) sourceRecordType = "First Aid Checklist";
                                else if (headerId.StartsWith("WC")) sourceRecordType = "Welding Checklist";
                                else if (headerId.StartsWith("COM")) sourceRecordType = "Committee Meeting";
                                else if (headerId.StartsWith("HKM")) sourceRecordType = "Housekeeping";
                                else if (headerId.StartsWith("FBH")) sourceRecordType = "Full Body Harness";
                               
                            }

                            // 🔹 Step 2: Assign values to form fields
                            txtSourceRecordType.Text = sourceRecordType;
                            txtSourceRecordType.ReadOnly = true; // prevent editing
                            txtSourceRecordID.Text = headerId;
                            //txtSourceRecordID.Text = dr["HeaderID"].ToString();
                            txtRaisedBy.Text = dr["AssignedBy"].ToString();
                            txtDescription.Text = dr["Description"].ToString();

                            txtphoto.Text = dr["PhotoPath"].ToString();
                            if (!string.IsNullOrEmpty(dr["PhotoPath"].ToString()))
                                imgphoto.ImageUrl = dr["PhotoPath"].ToString();


                            // Corrective Actions
                            txtCorrectiveActions.Text = dr["CorrectiveAction"].ToString();
                            txtCorrectiveNote.Text = dr["CA_Note"].ToString();
                            
                            txtCorrectivePhotoName.Text = dr["CA_Photo"].ToString();
                            if (!string.IsNullOrEmpty(dr["CA_Photo"].ToString()))
                                imgCorrectivePhoto.ImageUrl = dr["CA_Photo"].ToString();
                            
                            
                            if (dr["CA_Date"] != DBNull.Value)
                                txtCorrectiveDate.Text = Convert.ToDateTime(dr["CA_Date"]).ToString("yyyy-MM-dd");
                            txtCorrectiveBy.Text = dr["CA_ActionBy"].ToString();

                            // Preventive Actions
                            txtPreventiveAction.Text = dr["PreventiveAction"].ToString();
                            txtPreventiveNote.Text = dr["PA_Note"].ToString();
                            txtPreventivePhotoName.Text = dr["PA_Photo"].ToString();
                            if (!string.IsNullOrEmpty(dr["PA_Photo"].ToString()))
                                imgPreventivePhoto.ImageUrl = dr["PA_Photo"].ToString();
                            if (dr["PA_Date"] != DBNull.Value)
                                txtPreventiveDate.Text = Convert.ToDateTime(dr["PA_Date"]).ToString("yyyy-MM-dd");
                            txtPreventiveBy.Text = dr["PA_ActionBy"].ToString();

                            // Verification Status
                            if (dr["TargetCompletionDate"] != DBNull.Value)
                                txtTargetCompletion.Text = Convert.ToDateTime(dr["TargetCompletionDate"]).ToString("yyyy-MM-dd");
                            txtResponsiblePerson.Text = dr["ResponsiblePerson"].ToString();
                            txtStatus.Text = dr["Status"].ToString();
                            txtRemarks.Text = dr["CAPARemarks"].ToString();

                            txtUploadedPhotoName.Text = dr["CAPAFilePath"].ToString();
                            if (!string.IsNullOrEmpty(dr["CAPAFilePath"].ToString()))
                                imgUploadedPhoto.ImageUrl =dr["CAPAFilePath"].ToString();

                            txtReviewedBy.Text = dr["ReviewedBy"].ToString();
                            txtVerificationStatus.Text = dr["VerificationStatus"].ToString();
                        }
                    }
                }
            }
        }


        protected void btnBack_Click(object sender, EventArgs e)
        {
            string headerId = txtSourceRecordID.Text.Trim(); // Get Source Record ID (e.g. HKM-1091)

            if (string.IsNullOrEmpty(headerId))
            {
                // If no headerId, goto home page (fallback)
                Response.Redirect("~/Default.aspx");
                return;
            }

            // Determine source record type based on prefix
            string redirectUrl = "~/Home.aspx"; // fallback page

            if (headerId.StartsWith("FE"))
                redirectUrl = "~/FireExtinguisherChecklistView.aspx";
            else if (headerId.StartsWith("FAB"))
                redirectUrl = "~/FirstAidBoxView.aspx";
            else if (headerId.StartsWith("WC"))
                redirectUrl = "~/WeldingChecklistView.aspx";
            else if (headerId.StartsWith("COM"))
                redirectUrl = "~/committee_meeting_report.aspx";
            else if (headerId.StartsWith("HKM"))
                redirectUrl = "~/housekeeping_audit_report.aspx";
            else if (headerId.StartsWith("FBH"))
                redirectUrl = "~/FullBodyHarnessInspection_View.aspx";

            // Redirect to the respective page
            Response.Redirect(redirectUrl);
        }



    }
}

