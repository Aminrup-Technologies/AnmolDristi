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
using System.Web.Services;
using System.Web.Script.Services;

namespace AnmolDristi
{
    public partial class FullBodyHarnessInspection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                txtDocNo.Text = hfEmployeeName.Value;
            }
        }

        //Code to fetch the details from backend 
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetEmployeeName(string inspectionId)
        {
            string employeeName = string.Empty;

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string query = "SELECT EmployeeName FROM [CSMS].[dbo].[InspectionHeader] WHERE InspectedBy = @InspectionID";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@InspectionID", inspectionId);  // Assuming inspectionId is the 'InspectedBy'

                try
                {
                    conn.Open();
                    var result = cmd.ExecuteScalar(); // ExecuteScalar will return the first column of the first row
                    if (result != null)
                    {
                        employeeName = result.ToString();
                    }
                    else
                    {
                        employeeName = "Invalid Inspection ID";  // If no result is found, return an error message
                    }
                }
                catch (Exception ex)
                {
                    // Handle exception and log error if needed
                    employeeName = "Error occurred while fetching data";  // Return a generic error message
                }
            }

            return employeeName;
        }




        protected void txtInsBy_TextChanged(object sender, EventArgs e)
        {
            string inspectedBy = txtInsBy.Text.Trim();

            if (!string.IsNullOrEmpty(inspectedBy))
            {
                string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = @"SELECT TOP 1 EmployeeName 
                             FROM InspectionHeader 
                             WHERE InspectedBy = @InspectedBy 
                             ORDER BY DateOfInspection DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@InspectedBy", inspectedBy);
                        conn.Open();

                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            txtDocNo.Text = result.ToString();
                        }
                        else
                        {
                            txtDocNo.Text = "";
                            // Optional: show a message or highlight error
                        }
                    }
                }
            }
        }

        protected void btnAddChecklist_Click(object sender, EventArgs e)
        {
            DataTable dt;
            if (ViewState["ChecklistData"] == null)
            {
                dt = new DataTable();
                dt.Columns.Add("IdentificationNo");
                dt.Columns.Add("Location");

                dt.Columns.Add("Q1Status");
                dt.Columns.Add("Q1Remarks");
                dt.Columns.Add("Q1Photo");

                dt.Columns.Add("Q2Status");
                dt.Columns.Add("Q2Remarks");
                dt.Columns.Add("Q2Photo");

                dt.Columns.Add("Q3Status");
                dt.Columns.Add("Q3Remarks");
                dt.Columns.Add("Q3Photo");

                dt.Columns.Add("Q4Status");
                dt.Columns.Add("Q4Remarks");
                dt.Columns.Add("Q4Photo");

                dt.Columns.Add("Q5Status");
                dt.Columns.Add("Q5Remarks");
                dt.Columns.Add("Q5Photo");
            }
            else
            {
                dt = (DataTable)ViewState["ChecklistData"];
            }

            string Q1Photo = "";

            if (fuQ1.HasFile)
            {
                string fileExtension = Path.GetExtension(fuQ1.FileName).ToLower();
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblMsg1.Text = "Error: Only JPG, JPEG, and PNG files are allowed.";
                    lblMsg1.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                //string folderPath = Server.MapPath("~/images/");
                string folderPath = Server.MapPath("~/images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string uniqueFileName = Guid.NewGuid().ToString() + "_Before" + fileExtension;
                Q1Photo = "~/images/" + uniqueFileName;
                fuQ1.SaveAs(folderPath + uniqueFileName);
            }

            string Q2Photo = "";

            if (fuQ2.HasFile)
            {
                string fileExtension = Path.GetExtension(fuQ2.FileName).ToLower();
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblMsg1.Text = "Error: Only JPG, JPEG, and PNG files are allowed.";
                    lblMsg1.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                //string folderPath = Server.MapPath("~/images/");
                string folderPath = Server.MapPath("~/images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string uniqueFileName = Guid.NewGuid().ToString() + "_Before" + fileExtension;
                Q2Photo = "~/images/" + uniqueFileName;
                fuQ2.SaveAs(folderPath + uniqueFileName);
            }

            string Q3Photo = "";

            if (fuQ3.HasFile)
            {
                string fileExtension = Path.GetExtension(fuQ3.FileName).ToLower();
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblMsg1.Text = "Error: Only JPG, JPEG, and PNG files are allowed.";
                    lblMsg1.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                //string folderPath = Server.MapPath("~/images/");
                string folderPath = Server.MapPath("~/images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string uniqueFileName = Guid.NewGuid().ToString() + "_Before" + fileExtension;
                Q3Photo = "~/images/" + uniqueFileName;
                fuQ3.SaveAs(folderPath + uniqueFileName);
            }

            string Q4Photo = "";

            if (fuQ4.HasFile)
            {
                string fileExtension = Path.GetExtension(fuQ4.FileName).ToLower();
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblMsg1.Text = "Error: Only JPG, JPEG, and PNG files are allowed.";
                    lblMsg1.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                //string folderPath = Server.MapPath("~/images/");
                string folderPath = Server.MapPath("~/images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string uniqueFileName = Guid.NewGuid().ToString() + "_Before" + fileExtension;
                Q4Photo = "~/images/" + uniqueFileName;
                fuQ4.SaveAs(folderPath + uniqueFileName);
            }

            string Q5Photo = "";

            if (fuQ5.HasFile)
            {
                string fileExtension = Path.GetExtension(fuQ5.FileName).ToLower();
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblMsg1.Text = "Error: Only JPG, JPEG, and PNG files are allowed.";
                    lblMsg1.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                //string folderPath = Server.MapPath("~/images/");
                string folderPath = Server.MapPath("~/images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string uniqueFileName = Guid.NewGuid().ToString() + "_Before" + fileExtension;
                Q5Photo = "~/images/" + uniqueFileName;
                fuQ5.SaveAs(folderPath + uniqueFileName);
            }




            DataRow dr = dt.NewRow();
            dr["IdentificationNo"] = txtIdentity.Text.Trim();
            dr["Location"] = txtLoc.Text.Trim();

            dr["Q1Status"] = rdoQ1Ok.Checked ? "OK" : "Not OK";
            dr["Q1Remarks"] = txtQ1Remarks.Text.Trim();
            dr["Q1Photo"] = Q1Photo;

            dr["Q2Status"] = rdoQ2Ok.Checked ? "OK" : "Not OK";
            dr["Q2Remarks"] = txtQ2Remarks.Text.Trim();
            dr["Q2Photo"] = Q2Photo;

            dr["Q3Status"] = rdoQ3Ok.Checked ? "OK" : "Not OK";
            dr["Q3Remarks"] = txtQ3Remarks.Text.Trim();
            dr["Q3Photo"] = Q3Photo;

            dr["Q4Status"] = rdoQ4Ok.Checked ? "OK" : "Not OK";
            dr["Q4Remarks"] = txtQ4Remarks.Text.Trim();
            dr["Q4Photo"] = Q4Photo;

            dr["Q5Status"] = rdoQ5Ok.Checked ? "OK" : "Not OK";
            dr["Q5Remarks"] = txtQ5Remarks.Text.Trim();
            dr["Q5Photo"] = Q5Photo;

            dt.Rows.Add(dr);
            ViewState["ChecklistData"] = dt;

            gvChecklist.DataSource = dt;
            gvChecklist.DataBind();

            
            txtLoc.Text = "";
            txtQ1Remarks.Text = "";
            txtQ2Remarks.Text = "";
            txtQ3Remarks.Text = "";
            txtQ4Remarks.Text = "";
            txtQ5Remarks.Text = "";
            txtIdentity.Text = "";

        }

        protected void BtnDelIns_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            if (gvChecklist.DataKeys.Count == 0 || row.RowIndex < 0 || row.RowIndex >= gvChecklist.DataKeys.Count)
            {
                return; // Prevent out-of-range errors
            }

            string identificationNo = gvChecklist.DataKeys[row.RowIndex].Value.ToString();
            DataTable dt = ViewState["ChecklistData"] as DataTable; // Use the correct ViewState key

            if (dt != null)
            {
                DataRow[] rows = dt.Select("IdentificationNo = '" + identificationNo.Replace("'", "''") + "'");
                if (rows.Length > 0)
                {
                    dt.Rows.Remove(rows[0]);
                    dt.AcceptChanges();
                }

                if (dt.Rows.Count == 0)
                {
                    ViewState["ChecklistData"] = null;
                    gvChecklist.DataSource = null;
                    gvChecklist.DataBind();
                }
                else
                {
                    ViewState["ChecklistData"] = dt;
                    gvChecklist.DataSource = dt;
                    gvChecklist.DataBind();
                }
            }
        }
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("FullBodyHarnessInspection.aspx");
        }
        //protected void BtnSubmit_Click(object sender, EventArgs e)
        //{
        //    string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        //    using (SqlConnection conn = new SqlConnection(connStr))
        //    {
        //        conn.Open();

        //        SqlTransaction transaction = conn.BeginTransaction();

        //        try
        //        {
        //            // 1. Insert into InspectionHeader
        //            string insertHeaderQuery = @"INSERT INTO InspectionHeader (EmployeeName, Site, InspectedBy, DateOfInspection)
        //                                 OUTPUT INSERTED.InspectionID
        //                                 VALUES (@EmployeeName, @Site, @InspectedBy, @DateOfInspection)";

        //            SqlCommand cmdHeader = new SqlCommand(insertHeaderQuery, conn, transaction);
        //            cmdHeader.Parameters.AddWithValue("@EmployeeName", txtDocNo.Text.Trim());
        //            cmdHeader.Parameters.AddWithValue("@Site", txtSite.Text.Trim());
        //            cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text.Trim());
        //            cmdHeader.Parameters.AddWithValue("@DateOfInspection", Convert.ToDateTime(txtdate.Text.Trim()));

        //            int inspectionID = (int)cmdHeader.ExecuteScalar();

        //            // 2. Insert into InspectionChecklist for each row in the grid (from ViewState)
        //            DataTable checklistData = ViewState["ChecklistData"] as DataTable;

        //            if (checklistData != null)
        //            {
        //                foreach (DataRow row in checklistData.Rows)
        //                {
        //                    for (int qNum = 1; qNum <= 5; qNum++)
        //                    {
        //                        string questionStatus = row[$"Q{qNum}Status"].ToString();
        //                        string remarks = row[$"Q{qNum}Remarks"].ToString();
        //                        string photoPath = row[$"Q{qNum}Photo"].ToString();

        //                        string insertChecklistQuery = @"INSERT INTO InspectionChecklist 
        //                        (Location, InspectionNo, InspectionID, QuestionNumber, IsOk, Remarks, PhotoPath)
        //                        VALUES (@Location, @InspectionNo, @InspectionID, @QuestionNumber, @IsOk, @Remarks, @PhotoPath)";

        //                        SqlCommand cmdChecklist = new SqlCommand(insertChecklistQuery, conn, transaction);
        //                        cmdChecklist.Parameters.AddWithValue("@Location", row["Location"].ToString());
        //                        cmdChecklist.Parameters.AddWithValue("@InspectionNo", row["IdentificationNo"].ToString());
        //                        cmdChecklist.Parameters.AddWithValue("@InspectionID", inspectionID);
        //                        cmdChecklist.Parameters.AddWithValue("@QuestionNumber", qNum);
        //                        cmdChecklist.Parameters.AddWithValue("@IsOk", questionStatus == "OK" ? 1 : 0);
        //                        cmdChecklist.Parameters.AddWithValue("@Remarks", remarks);
        //                        cmdChecklist.Parameters.AddWithValue("@PhotoPath", photoPath);

        //                        cmdChecklist.ExecuteNonQuery();
        //                    }
        //                }
        //            }

        //            transaction.Commit();
        //            lblMsg.Text = "Inspection data saved successfully!";
        //        }
        //        catch (Exception ex)
        //        {
        //            transaction.Rollback();
        //            lblMsg.Text = "Error: " + ex.Message;
        //        }
        //    }
        //}

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // 1. Insert into InspectionHeader
                    string insertHeaderQuery = @"INSERT INTO InspectionHeader (EmployeeName, Site, InspectedBy, DateOfInspection)
                                         OUTPUT INSERTED.InspectionID
                                         VALUES (@EmployeeName, @Site, @InspectedBy, @DateOfInspection)";

                    SqlCommand cmdHeader = new SqlCommand(insertHeaderQuery, conn, transaction);
                    cmdHeader.Parameters.AddWithValue("@EmployeeName", hfEmployeeName.Value.Trim()); // ✅ Get from hidden field
                    cmdHeader.Parameters.AddWithValue("@Site", txtSite.Text.Trim());
                    cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text.Trim());
                    cmdHeader.Parameters.AddWithValue("@DateOfInspection", Convert.ToDateTime(txtdate.Text.Trim()));

                    int inspectionID = (int)cmdHeader.ExecuteScalar();

                    // 2. Insert into InspectionChecklist
                    DataTable checklistData = ViewState["ChecklistData"] as DataTable;

                    if (checklistData != null)
                    {
                        foreach (DataRow row in checklistData.Rows)
                        {
                            for (int qNum = 1; qNum <= 5; qNum++)
                            {
                                string questionStatus = row[$"Q{qNum}Status"].ToString();
                                string remarks = row[$"Q{qNum}Remarks"].ToString();
                                string photoPath = row[$"Q{qNum}Photo"].ToString();

                                string insertChecklistQuery = @"INSERT INTO InspectionChecklist 
                            (Location, InspectionNo, InspectionID, QuestionNumber, IsOk, Remarks, PhotoPath)
                            VALUES (@Location, @InspectionNo, @InspectionID, @QuestionNumber, @IsOk, @Remarks, @PhotoPath)";

                                SqlCommand cmdChecklist = new SqlCommand(insertChecklistQuery, conn, transaction);
                                cmdChecklist.Parameters.AddWithValue("@Location", row["Location"].ToString());
                                cmdChecklist.Parameters.AddWithValue("@InspectionNo", row["IdentificationNo"].ToString());
                                cmdChecklist.Parameters.AddWithValue("@InspectionID", inspectionID);
                                cmdChecklist.Parameters.AddWithValue("@QuestionNumber", qNum);
                                cmdChecklist.Parameters.AddWithValue("@IsOk", questionStatus == "OK" ? 1 : 0);
                                cmdChecklist.Parameters.AddWithValue("@Remarks", remarks);
                                cmdChecklist.Parameters.AddWithValue("@PhotoPath", photoPath);

                                cmdChecklist.ExecuteNonQuery();
                            }
                        }
                    }

                    transaction.Commit();
                    lblMsg.Text = "Inspection data saved successfully!";
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lblMsg.Text = "Error: " + ex.Message;
                }
            }
        }


        protected void gvChecklist_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                // Loop through header cells
                for (int i = 0; i < e.Row.Cells.Count; i++)
                {
                    string headerText = e.Row.Cells[i].Text.ToUpper();

                    if (headerText.Contains("Q1"))
                        e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#AED6F1"); // Light Blue
                    else if (headerText.Contains("Q2"))
                        e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#A9DFBF"); // Light Green
                    else if (headerText.Contains("Q3"))
                        e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#F9E79F"); // Light Yellow
                    else if (headerText.Contains("Q4"))
                        e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#F5B7B1"); // Light Red
                    else if (headerText.Contains("Q5"))
                        e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#D2B4DE"); // Light Purple
                    
                }
            }
        }


    }
}