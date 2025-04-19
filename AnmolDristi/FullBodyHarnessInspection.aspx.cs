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
    public partial class FullBodyHarnessInspection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           

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

            DataRow dr = dt.NewRow();
            dr["IdentificationNo"] = txtIdentity.Text.Trim();
            dr["Location"] = txtLoc.Text.Trim();

            dr["Q1Status"] = rdoQ1Ok.Checked ? "OK" : "Not OK";
            dr["Q1Remarks"] = txtQ1Remarks.Text.Trim();
            dr["Q1Photo"] = fuQ1.HasFile ? fuQ1.FileName : "";

            dr["Q2Status"] = rdoQ2Ok.Checked ? "OK" : "Not OK";
            dr["Q2Remarks"] = txtQ2Remarks.Text.Trim();
            dr["Q2Photo"] = fuQ2.HasFile ? fuQ2.FileName : "";

            dr["Q3Status"] = rdoQ3Ok.Checked ? "OK" : "Not OK";
            dr["Q3Remarks"] = txtQ3Remarks.Text.Trim();
            dr["Q3Photo"] = fuQ3.HasFile ? fuQ3.FileName : "";

            dr["Q4Status"] = rdoQ4Ok.Checked ? "OK" : "Not OK";
            dr["Q4Remarks"] = txtQ4Remarks.Text.Trim();
            dr["Q4Photo"] = fuQ4.HasFile ? fuQ4.FileName : "";

            dr["Q5Status"] = rdoQ5Ok.Checked ? "OK" : "Not OK";
            dr["Q5Remarks"] = txtQ5Remarks.Text.Trim();
            dr["Q5Photo"] = fuQ5.HasFile ? fuQ5.FileName : "";

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
                    string insertHeaderQuery = @"INSERT INTO InspectionHeader (DocumentNo, Site, InspectedBy, DateOfInspection)
                                         OUTPUT INSERTED.InspectionID
                                         VALUES (@DocumentNo, @Site, @InspectedBy, @DateOfInspection)";

                    SqlCommand cmdHeader = new SqlCommand(insertHeaderQuery, conn, transaction);
                    cmdHeader.Parameters.AddWithValue("@DocumentNo", txtDocNo.Text.Trim());
                    cmdHeader.Parameters.AddWithValue("@Site", txtSite.Text.Trim());
                    cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text.Trim());
                    cmdHeader.Parameters.AddWithValue("@DateOfInspection", Convert.ToDateTime(txtdate.Text.Trim()));

                    int inspectionID = (int)cmdHeader.ExecuteScalar();

                    // 2. Insert into InspectionChecklist for each row in the grid (from ViewState)
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



    }
}