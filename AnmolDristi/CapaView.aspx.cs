using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class JCCCapaView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                if (Request.UrlReferrer != null)
                {
                    ViewState["PreviousPage"] = Request.UrlReferrer.ToString();
                }


                string capaid = Request.QueryString["capaid"];
                string id = Request.QueryString["id"];

                if (!string.IsNullOrEmpty(capaid))
                {
                    int capaIdValue; 

                    if (int.TryParse(capaid, out capaIdValue))
                    {
                        LoadCAPADetails(capaIdValue);
                    }
                    else
                    {
                        //lblMessage.Text = "Invalid CAPA ID.";
                    }
                }
            }
        }

        private void LoadCAPADetails(int capaId)
        {
            string query = @"
        SELECT 
               *
        FROM tbl_CAPAMaster
        WHERE CAPAID = @CAPAID";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@CAPAID", capaId);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Text fields
                        txtSourceRecordType.Text = SafeGetValue(reader, "SourceTable");
                        txtSourceRecordID.Text = SafeGetValue(reader, "HeaderID");   // safer for int
                        txtRaisedBy.Text = SafeGetValue(reader, "AssignedBy");
                        txtDescription.Text = SafeGetValue(reader, "Description");
                        phototxtbox.Text = BuildUploadPath(SafeGetValue(reader, "PhotoPath"));

                        // Corrective actions
                        txtCorrectiveActions.Text = SafeGetValue(reader, "CorrectiveAction");
                        txtCorrectiveNote.Text = SafeGetValue(reader, "CA_Note");
                        txtCorrectivePhotoName.Text = BuildUploadPath(SafeGetValue(reader, "CA_Photo"));
                        txtCorrectiveDate.Text = FormatDate(SafeGetValue(reader, "CA_Date"));
                        txtCorrectiveBy.Text = SafeGetValue(reader, "CA_ActionBy");

                        // Preventive actions
                        txtPreventiveAction.Text = SafeGetValue(reader, "PreventiveAction");
                        txtPreventiveNote.Text = SafeGetValue(reader, "PA_Note");
                        txtPreventivePhotoName.Text = BuildUploadPath(SafeGetValue(reader, "PA_Photo"));
                        txtPreventiveDate.Text = FormatDate(SafeGetValue(reader, "PA_Date"));
                        txtPreventiveBy.Text = SafeGetValue(reader, "PA_ActionBy");

                        // Target & review
                        txtTargetCompletion.Text = FormatDate(SafeGetValue(reader, "TargetCompletionDate"));
                        txtResponsiblePerson.Text = SafeGetValue(reader, "ResponsiblePerson");
                        txtRemarks.Text = SafeGetValue(reader, "CAPARemarks");
                        txtReviewedBy.Text = SafeGetValue(reader, "ReviewedBy");
                        txtVerificationStatus.Text = SafeGetValue(reader, "VerificationStatus");
                        txtStatus.Text = SafeGetValue(reader, "Status");
                        txtUploadedPhotoName.Text = BuildUploadPath(SafeGetValue(reader, "CAPAFilePath"));

                        // Images
                        imgtxtbox.ImageUrl = BuildImagePath(SafeGetValue(reader, "PhotoPath"), "https://cdn-icons-png.flaticon.com/512/4218/4218934.png");
                        imgCorrectivePhoto.ImageUrl = BuildImagePath(SafeGetValue(reader, "CA_Photo"), "https://cdn-icons-png.flaticon.com/512/4218/4218934.png");
                        imgPreventivePhoto.ImageUrl = BuildImagePath(SafeGetValue(reader, "PA_Photo"), "https://cdn-icons-png.flaticon.com/512/4218/4218934.png");
                        imgUploadedPhoto.ImageUrl = BuildImagePath(SafeGetValue(reader, "CAPAFilePath"), "https://cdn-icons-png.flaticon.com/512/4218/4218934.png");
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(
                                        this,
                                        this.GetType(),
                                        "NoDataAlert",
                                        "alert('No CAPA details found for this ID.');",
                                        true
                                    );

                        return; 
                    }
                }
            }
        }

        private string SafeGetValue(SqlDataReader reader, string column)
        {
            // Check if column exists
            for (int i = 0; i < reader.FieldCount; i++)
            {
                if (reader.GetName(i).Equals(column, StringComparison.OrdinalIgnoreCase))
                {
                    return reader.IsDBNull(i) ? string.Empty : reader[i].ToString();
                }
            }
            return string.Empty; // if Column not found
        }

        private string BuildUploadPath(string fileName)
        {
            if (string.IsNullOrWhiteSpace(fileName))
                return string.Empty;

            fileName = fileName.Replace("\\", "/").Trim();

            // If already a virtual path (starts with ~/), keep as is
            if (fileName.StartsWith("~/"))
            {
                return fileName;
            }

            // Clean dangerous relative paths
            fileName = fileName.Replace("../", "").Replace("..\\", "");

            // Otherwise, put it under Uploads
            return "~/Uploads/" + fileName.TrimStart('/', '\\');
        }




        private string BuildImagePath(string fileName, string defaultUrl)
        {
            if (string.IsNullOrWhiteSpace(fileName))
                return defaultUrl;

            fileName = fileName.Replace("\\", "/").Trim();

            // If already a virtual path (starts with ~/), return as is
            if (fileName.StartsWith("~/"))
            {
                return fileName;
            }

            // Otherwise, assume it belongs to Uploads
            return "~/Uploads/" + fileName.TrimStart('/', '\\');
        }




        private string FormatDate(string value)
        {
            DateTime date;
            if (DateTime.TryParse(value, out date))
            {
                return date.ToString("yyyy-MM-dd"); // for "dd-MMM-yyyy"
            }
            return "";
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            if (ViewState["PreviousPage"] != null)
            {
                Response.Redirect(ViewState["PreviousPage"].ToString());
            }
            else
            {
                Response.Redirect("~/Home.aspx"); // fallback page
            }
        }
    }
}