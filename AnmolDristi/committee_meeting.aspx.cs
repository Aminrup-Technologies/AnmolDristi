using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class committee_meeting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void rbEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlAttendeeType.Visible = rbEmployee.SelectedValue == "Yes";
            pnlDetails.Visible = rbEmployee.SelectedValue == "No";
        }

        protected void rbAttendeeType_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool isInternal = rbAttendeeType.SelectedValue == "Internal";
            txtAttendeeCode.Text = isInternal ? "N/A" : "N/A";
            txtAttendeeCode.Enabled = isInternal;
            pnlDetails.Visible = true;
        }
        protected void btnAddAttendees_Click(object sender, EventArgs e)
        {
            DataTable dt;
            if (ViewState["Attendees"] == null)
            {
                dt = new DataTable();
                dt.Columns.Add("SNo");
                dt.Columns.Add("EmployeeOrNot");
                dt.Columns.Add("EmployeeName");
                dt.Columns.Add("AttendeeCode");
                dt.Columns.Add("AttendanceStatus");
                dt.Columns.Add("AttendeeType");
                dt.Columns.Add("Designation");
                dt.Columns.Add("ImagePath"); // New column for image path
            }
            else
            {
                dt = (DataTable)ViewState["Attendees"];
            }
            string imagePath = "";
            if (imgupload.HasFile)
            {
                string fileExtension = Path.GetExtension(imgupload.FileName).ToLower();
                if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
                {
                    lblMsg1.Text = "Error: Only JPG, JPEG, and PNG files are allowed.";
                    lblMsg1.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }
                string fileName = Path.GetFileName(imgupload.FileName);
                imagePath = "~/Uploads/" + fileName;
                imgupload.SaveAs(folderPath + fileName);
            }
            // Generating SNo dynamically
            int serialNo = dt.Rows.Count + 1;

            DataRow dr = dt.NewRow();
            dr["SNo"] = serialNo;
            dr["EmployeeOrNot"] = rbEmployee.SelectedItem != null ? rbEmployee.SelectedItem.Text : "";
            dr["AttendeeType"] = rbAttendeeType.SelectedItem != null ? rbAttendeeType.SelectedItem.Text : "";
            dr["EmployeeName"] = txtEmployeeName.Text.Trim();
            dr["AttendeeCode"] = txtAttendeeCode.Text.Trim();
            dr["AttendanceStatus"] = ddlAttendanceStatus.SelectedValue;
            dr["Designation"] = txtdes.Text.Trim();
            dr["ImagePath"] = imagePath; // Store image path
            dt.Rows.Add(dr);

            ViewState["Attendees"] = dt;
            gvAttendees.DataSource = dt;
            gvAttendees.DataBind();

            // Clear input fields for next attendee
            rbEmployee.ClearSelection();
            rbAttendeeType.ClearSelection();
            ddlAttendanceStatus.SelectedIndex = 0;
            txtEmployeeName.Text = "";
            txtAttendeeCode.Text = "";
            txtdes.Text = "";
        }

        protected void btnAddIssues_Click(object sender, EventArgs e)
        {
            DataTable dt;
            if (ViewState["Issues"] == null)
            {
                dt = new DataTable();
                dt.Columns.Add("SNo");
                dt.Columns.Add("AgendaTitle");
                dt.Columns.Add("IssuesDiscussed");
                dt.Columns.Add("ActionBy");
                dt.Columns.Add("TargetDate");
                dt.Columns.Add("ReviewDate");
                dt.Columns.Add("ReviewBy");
                dt.Columns.Add("Status");
            }
            else
            {
                dt = (DataTable)ViewState["Issues"];
            }
            // Generating SNo dynamically
            int serialNo = dt.Rows.Count + 1;

            DataRow dr = dt.NewRow();
            dr["SNo"] = serialNo;
            dr["AgendaTitle"] = txtAgendaTitle.Text.Trim();
            dr["ActionBy"] = txtActionBy.Text.Trim();
            dr["IssuesDiscussed"] = txtIssuesDes.Text.Trim();
            dr["TargetDate"] = txtTargetDate.Text.Trim();
            dr["ReviewDate"] = txtReviewDate.Text.Trim();
            dr["ReviewBy"] = txtReviewBy.Text.Trim();
            dr["Status"] = ddlStatus.SelectedValue;
            dt.Rows.Add(dr);

            ViewState["Issues"] = dt;
            gvIssues.DataSource = dt;
            gvIssues.DataBind();

            // Clear input fields for next attendee
            txtActionBy.Text = "";
            txtAgendaTitle.Text="";
            txtReviewBy.Text = "";
            txtTargetDate.Text = "";
            txtIssuesDes.Text = "";
            txtReviewDate.Text = "";
            ddlStatus.SelectedIndex = 0;
            
        }
        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            if (gvIssues.DataKeys.Count == 0 || row.RowIndex < 0 || row.RowIndex >= gvIssues.DataKeys.Count)
            {
                return; // Prevent out-of-range errors
            }

            int sNo = Convert.ToInt32(gvIssues.DataKeys[row.RowIndex].Value);
            DataTable dt = ViewState["Issues"] as DataTable;

            if (dt != null)
            {
                DataRow[] rows = dt.Select("SNo=" + sNo);
                if (rows.Length > 0)
                {
                    dt.Rows.Remove(rows[0]);
                    dt.AcceptChanges();
                }

                // **Renumber SNo** after deletion
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SNo"] = i + 1; // Reset SNo from 1 to N
                }

                if (dt.Rows.Count == 0)
                {
                    ViewState["Issues"] = null;
                    gvIssues.DataSource = null;
                    gvIssues.DataBind();
                }
                else
                {
                    ViewState["Issues"] = dt;
                    gvIssues.DataSource = dt;
                    gvIssues.DataBind();
                }
            }
        }

        protected void BtnDelAttendees_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;

            if (gvAttendees.DataKeys.Count == 0 || row.RowIndex < 0 || row.RowIndex >= gvAttendees.DataKeys.Count)
            {
                return; // Prevent out-of-range errors
            }

            int sNo = Convert.ToInt32(gvAttendees.DataKeys[row.RowIndex].Value);
            DataTable dt = ViewState["Attendees"] as DataTable;

            if (dt != null)
            {
                DataRow[] rows = dt.Select("SNo=" + sNo);
                if (rows.Length > 0)
                {
                    dt.Rows.Remove(rows[0]);
                    dt.AcceptChanges();
                }

                // **Renumber SNo** after deletion
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["SNo"] = i + 1; // Reset SNo from 1 to N
                }

                if (dt.Rows.Count == 0)
                {
                    ViewState["Attendees"] = null;
                    gvAttendees.DataSource = null;
                    gvAttendees.DataBind();
                }
                else
                {
                    ViewState["Attendees"] = dt;
                    gvAttendees.DataSource = dt;
                    gvAttendees.DataBind();
                }
            }
        }





    }
}