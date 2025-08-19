using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Universal_Capa_form : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        
            // Mapping dictionary for Source Record Types
            private readonly Dictionary<string, string> prefixMap = new Dictionary<string, string>
        {
            
            { "GM", "Grinding Machine Checklist" },
            { "GS", "Gas Cutting Checklist" },
            { "DBC", "D and Bow Shackle + Chain Pulley Checklist" },
            { "JSC", "JobSite Checklist" },
           
            { "SF", "Safety audit" },
            { "KY", "Kyt form" }
        };

            protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    string capaId = Request.QueryString["CAPA_ID"];
                    if (!string.IsNullOrEmpty(capaId))
                    {
                        LoadCapaDetails(capaId);
                    }
                }
            }

            private void LoadCapaDetails(string capaId)
            {
                string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT * FROM tbl_CAPAMaster WHERE CAPAID = @CAPAID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@CAPAID", capaId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        // HeaderID prefix mapping
                        string headerId = reader["HeaderID"].ToString();
                        txtSourceRecordID.Text = headerId;
                        txtSourceRecordType.Text = GetRecordType(headerId);

                        // General Details
                        txtRaisedBy.Text = reader["AssignedBy"].ToString();
                        txtDescription.Text = reader["Description"].ToString();

                        // Corrective Actions
                        txtCorrectiveActions.Text = reader["CorrectiveAction"].ToString();
                        txtCorrectiveNote.Text = reader["CA_Note"].ToString();
                        txtCorrectivePhotoName.Text = reader["CA_Photo"].ToString();
                        imgCorrectivePhoto.ImageUrl = string.IsNullOrEmpty(reader["CA_Photo"].ToString())
                            ? "https://cdn-icons-png.flaticon.com/512/4218/4218934.png"
                            : reader["CA_Photo"].ToString();
                        txtCorrectiveDate.Text = reader["CA_Date"].ToString();
                        txtCorrectiveBy.Text = reader["CA_ActionBy"].ToString();

                        // Preventive Actions
                        txtPreventiveAction.Text = reader["PreventiveAction"].ToString();
                        txtPreventiveNote.Text = reader["PA_Note"].ToString();
                        txtPreventivePhotoName.Text = reader["PA_Photo"].ToString();
                        imgPreventivePhoto.ImageUrl = string.IsNullOrEmpty(reader["PA_Photo"].ToString())
                            ? "https://cdn-icons-png.flaticon.com/512/4218/4218934.png"
                            : reader["PA_Photo"].ToString();
                        txtPreventiveDate.Text = reader["PA_Date"].ToString();
                        txtPreventiveBy.Text = reader["PA_ActionBy"].ToString();

                        // Verification Status
                        txtTargetCompletion.Text = reader["TargetCompletionDate"].ToString();
                        txtResponsiblePerson.Text = reader["ResponsiblePerson"].ToString();
                        txtStatus.Text = reader["Status"].ToString();
                        txtRemarks.Text = reader["Remarks"].ToString();
                        txtUploadedPhotoName.Text = reader["PhotoPath"].ToString();
                        imgUploadedPhoto.ImageUrl = string.IsNullOrEmpty(reader["PhotoPath"].ToString())
                            ? "https://cdn-icons-png.flaticon.com/512/4218/4218934.png"
                            : reader["PhotoPath"].ToString();
                        txtReviewedBy.Text = reader["ReviewedBy"].ToString();
                        txtVerificationStatus.Text = reader["VerificationStatus"].ToString();
                    }
                    conn.Close();
                }
            }

            private string GetRecordType(string headerId)
            {
                foreach (var prefix in prefixMap.Keys)
                {
                    if (headerId.StartsWith(prefix))
                    {
                        return prefixMap[prefix];
                    }
                }
                return "Unknown Type";
            }
        }
    }

