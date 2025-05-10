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

namespace AnmolDristi
{
    public partial class FullBodyHarnessInspection_Update : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["InspectionID"] != null)
                {
                    int inspectionID = Convert.ToInt32(Request.QueryString["InspectionID"]);
                    LoadInspectionData(inspectionID);
                }
            }
        }
        private void LoadInspectionData(int inspectionID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // 1. Load header details
                string headerQuery = @"SELECT EmployeeName, Site, InspectedBy, DateOfInspection
                               FROM InspectionHeader
                               WHERE InspectionID = @InspectionID";

                SqlCommand cmdHeader = new SqlCommand(headerQuery, conn);
                cmdHeader.Parameters.AddWithValue("@InspectionID", inspectionID);

                SqlDataReader reader = cmdHeader.ExecuteReader();
                if (reader.Read())
                {
                    txtDocNo.Text = reader["EmployeeName"].ToString();
                    txtSite.Text = reader["Site"].ToString();
                    txtInsBy.Text = reader["InspectedBy"].ToString();

                    DateTime inspectionDate;
                    if (DateTime.TryParse(reader["DateOfInspection"].ToString(), out inspectionDate))
                    {
                        txtdate.Text = inspectionDate.ToString("yyyy-MM-dd"); // for HTML5 date input
                    }
                }
                reader.Close();

                // 2. Load checklist data into DataTable for GridView
                string checklistQuery = @"
            SELECT 
                c.InspectionNo AS IdentificationNo,
                c.Location,
                MAX(CASE WHEN QuestionNumber = 1 THEN CASE WHEN IsOk = 1 THEN 'OK' ELSE 'Not OK' END END) AS Q1Status,
                MAX(CASE WHEN QuestionNumber = 1 THEN Remarks END) AS Q1Remarks,
                MAX(CASE WHEN QuestionNumber = 1 THEN PhotoPath END) AS Q1Photo,
                MAX(CASE WHEN QuestionNumber = 2 THEN CASE WHEN IsOk = 1 THEN 'OK' ELSE 'Not OK' END END) AS Q2Status,
                MAX(CASE WHEN QuestionNumber = 2 THEN Remarks END) AS Q2Remarks,
                MAX(CASE WHEN QuestionNumber = 2 THEN PhotoPath END) AS Q2Photo,
                MAX(CASE WHEN QuestionNumber = 3 THEN CASE WHEN IsOk = 1 THEN 'OK' ELSE 'Not OK' END END) AS Q3Status,
                MAX(CASE WHEN QuestionNumber = 3 THEN Remarks END) AS Q3Remarks,
                MAX(CASE WHEN QuestionNumber = 3 THEN PhotoPath END) AS Q3Photo,
                MAX(CASE WHEN QuestionNumber = 4 THEN CASE WHEN IsOk = 1 THEN 'OK' ELSE 'Not OK' END END) AS Q4Status,
                MAX(CASE WHEN QuestionNumber = 4 THEN Remarks END) AS Q4Remarks,
                MAX(CASE WHEN QuestionNumber = 4 THEN PhotoPath END) AS Q4Photo,
                MAX(CASE WHEN QuestionNumber = 5 THEN CASE WHEN IsOk = 1 THEN 'OK' ELSE 'Not OK' END END) AS Q5Status,
                MAX(CASE WHEN QuestionNumber = 5 THEN Remarks END) AS Q5Remarks,
                MAX(CASE WHEN QuestionNumber = 5 THEN PhotoPath END) AS Q5Photo
            FROM InspectionChecklist c
            WHERE c.InspectionID = @InspectionID
            GROUP BY c.InspectionNo, c.Location
            ORDER BY c.InspectionNo";

                SqlCommand cmdChecklist = new SqlCommand(checklistQuery, conn);
                cmdChecklist.Parameters.AddWithValue("@InspectionID", inspectionID);

                SqlDataAdapter da = new SqlDataAdapter(cmdChecklist);
                DataTable dtChecklist = new DataTable();
                da.Fill(dtChecklist);

                gvChecklist.DataSource = dtChecklist;
                gvChecklist.DataBind();
            }
        }


        protected void BtnDelInsp_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            // Get the IdentificationNo (i.e., InspectionNo)
            string identificationNo = ((Label)row.FindControl("lblIdentificationNo")).Text;

            int inspectionID = Convert.ToInt32(Request.QueryString["InspectionID"]); // Or retrieve however you store current ID

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string deleteQuery = @"DELETE FROM InspectionChecklist 
                               WHERE InspectionNo = @IdentificationNo AND InspectionID = @InspectionID";

                SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                cmd.Parameters.AddWithValue("@IdentificationNo", identificationNo);
                cmd.Parameters.AddWithValue("@InspectionID", inspectionID);

                try
                {
                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();

                    // Refresh the GridView
                    LoadInspectionData(inspectionID);
                }
                catch (Exception ex)
                {
                    
                }
            }
        }

        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("FullBodyHarnessInspection_View.aspx");
        }
        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            int inspectionID = Convert.ToInt32(Request.QueryString["InspectionID"]); // assuming InspectionID is passed via query string
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Update InspectionHeader
                string updateHeaderQuery = @"UPDATE InspectionHeader 
                                     SET EmployeeName = @EmployeeName,
                                         Site = @Site,
                                         InspectedBy = @InspectedBy,
                                         DateOfInspection = @DateOfInspection
                                     WHERE InspectionID = @InspectionID";

                using (SqlCommand cmdHeader = new SqlCommand(updateHeaderQuery, con))
                {
                    cmdHeader.Parameters.AddWithValue("@EmployeeName", txtDocNo.Text.Trim());
                    cmdHeader.Parameters.AddWithValue("@Site", txtSite.Text.Trim());
                    cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text.Trim());
                    cmdHeader.Parameters.AddWithValue("@DateOfInspection", txtdate.Text.Trim());
                    cmdHeader.Parameters.AddWithValue("@InspectionID", inspectionID);
                    cmdHeader.ExecuteNonQuery();
                }

                // Update each checklist row
                foreach (GridViewRow row in gvChecklist.Rows)
                {
                    string identificationNo = ((Label)row.FindControl("lblIdentificationNo")).Text;
                    string location = ((TextBox)row.FindControl("txtLocation")).Text;

                    for (int q = 1; q <= 5; q++)
                    {
                        string status = ((TextBox)row.FindControl($"txtQ{q}Status")).Text;
                        string remarks = ((TextBox)row.FindControl($"txtQ{q}Remarks")).Text;
                        FileUpload fuPhoto = (FileUpload)row.FindControl($"fuimgQ{q}Photo");
                        Label lblPhoto = (Label)row.FindControl($"lblimgQ{q}Photo");

                        string photoPath = lblPhoto.Text;

                        // Save new image if uploaded
                        if (fuPhoto.HasFile)
                        {
                            string fileName = Path.GetFileName(fuPhoto.FileName);
                            string savePath = Server.MapPath("~/images/") + fileName;
                            fuPhoto.SaveAs(savePath);
                            photoPath = "~/images/" + fileName;
                        }

                        // Update the database row
                        string updateChecklistQuery = @"UPDATE InspectionChecklist
                                                SET IsOk = @IsOk,
                                                    Remarks = @Remarks,
                                                    PhotoPath = @PhotoPath,
                                                    Location = @Location
                                                WHERE InspectionID = @InspectionID AND 
                                                      InspectionNo = @InspectionNo AND 
                                                      QuestionNumber = @QuestionNumber";

                        using (SqlCommand cmdChecklist = new SqlCommand(updateChecklistQuery, con))
                        {
                            cmdChecklist.Parameters.AddWithValue("@IsOk", status.Equals("OK", StringComparison.OrdinalIgnoreCase));
                            cmdChecklist.Parameters.AddWithValue("@Remarks", remarks);
                            cmdChecklist.Parameters.AddWithValue("@PhotoPath", photoPath);
                            cmdChecklist.Parameters.AddWithValue("@Location", location);
                            cmdChecklist.Parameters.AddWithValue("@InspectionID", inspectionID);
                            cmdChecklist.Parameters.AddWithValue("@InspectionNo", identificationNo);
                            cmdChecklist.Parameters.AddWithValue("@QuestionNumber", q);
                            cmdChecklist.ExecuteNonQuery();
                        }
                    }
                }

                lblMsg.Text = "Update successful!";
            }
        }


    }
}