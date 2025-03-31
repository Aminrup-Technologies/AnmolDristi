using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CompanyReportSystem
{
    public partial class MassMeetingReport : Page
    {
        private const string SESSION_ATTENDANCE = "ReportAttendance";
        private const string SESSION_MEETING_DETAILS = "ReportMeetingDetails";
        private const string SESSION_FEEDBACK = "ReportFeedback";
        private const string SESSION_REPORT_INFO = "ReportInfo";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string reportId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(reportId))
                {
                    LoadReportFromDatabase(reportId);
                }
                else
                {
                    InitializeNewReport();
                }
                BindReportData();
            }
        }

        #region Data Initialization and Loading
        private void InitializeNewReport()
        {
            var reportInfo = new Dictionary<string, string>
            {
                { "MMRId", $"MMR{DateTime.Now:yyyyMMdd}-{new Random().Next(1000, 9999)}" },
                { "ReportDate", DateTime.Now.ToString("dd-MM-yyyy") },
                { "Department", "" },
                { "Location", "" },
                { "Submitter", "" },
                { "TSLMember", "" },
                { "Date", DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt") },
                { "Region", "" }
            };

            Session[SESSION_REPORT_INFO] = reportInfo;
            Session[SESSION_ATTENDANCE] = CreateAttendanceTable();
            Session[SESSION_MEETING_DETAILS] = CreateMeetingDetailsTable();
            Session[SESSION_FEEDBACK] = CreateFeedbackTable();
        }

        private void LoadReportFromDatabase(string reportId)
        {
            try
            {
                using (var conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ReportDBConnection"].ConnectionString))
                {
                    conn.Open();

                    var reportInfo = LoadReportInfo(conn, reportId);
                    Session[SESSION_REPORT_INFO] = reportInfo;

                    Session[SESSION_ATTENDANCE] = LoadAttendanceData(conn, reportId);
                    Session[SESSION_MEETING_DETAILS] = LoadMeetingDetailsData(conn, reportId);
                    Session[SESSION_FEEDBACK] = LoadFeedbackData(conn, reportId);
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                ShowError("Error loading report: " + ex.Message);
            }
        }

        private Dictionary<string, string> LoadReportInfo(SqlConnection conn, string reportId)
        {
            var reportInfo = new Dictionary<string, string>();
            using (var cmd = new SqlCommand("SELECT * FROM MassMeetingReports WHERE ReportId = @ReportId", conn))
            {
                cmd.Parameters.AddWithValue("@ReportId", reportId);
                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        reportInfo["MMRId"] = reader["MMRId"].ToString();
                        reportInfo["ReportDate"] = Convert.ToDateTime(reader["ReportDate"]).ToString("dd-MM-yyyy");
                        reportInfo["Department"] = reader["Department"].ToString();
                        reportInfo["Location"] = reader["Location"].ToString();
                        reportInfo["Submitter"] = reader["Submitter"].ToString();
                        reportInfo["TSLMember"] = reader["TSLMember"].ToString();
                        reportInfo["Date"] = Convert.ToDateTime(reader["Date"]).ToString("dd-MM-yyyy hh:mm:ss tt");
                        reportInfo["Region"] = reader["Region"].ToString();
                    }
                }
            }
            return reportInfo;
        }

        private DataTable LoadAttendanceData(SqlConnection conn, string reportId) => LoadTableData(conn, reportId, "MassMeetingAttendance", CreateAttendanceTable);
        private DataTable LoadMeetingDetailsData(SqlConnection conn, string reportId) => LoadTableData(conn, reportId, "MassMeetingDetails", CreateMeetingDetailsTable);
        private DataTable LoadFeedbackData(SqlConnection conn, string reportId) => LoadTableData(conn, reportId, "MassMeetingFeedback", CreateFeedbackTable);

        private DataTable LoadTableData(SqlConnection conn, string reportId, string tableName, Func<DataTable> tableCreator)
        {
            var dt = tableCreator();
            using (var cmd = new SqlCommand($"SELECT * FROM {tableName} WHERE ReportId = @ReportId", conn))
            {
                cmd.Parameters.AddWithValue("@ReportId", reportId);
                using (var reader = cmd.ExecuteReader())
                {
                    dt.Load(reader);
                }
            }
            return dt;
        }
        #endregion

        #region Table Schemas
        private DataTable CreateAttendanceTable()
        {
            var dt = new DataTable();
            dt.Columns.Add("SlNo", typeof(int));
            dt.Columns.Add("MemberType", typeof(string));
            dt.Columns.Add("EmployeeCode", typeof(string));
            dt.Columns.Add("EmployeeName", typeof(string));
            dt.Columns.Add("Designation", typeof(string));
            dt.Columns.Add("GatePassNo", typeof(string));
            return dt;
        }

        private DataTable CreateMeetingDetailsTable()
        {
            var dt = new DataTable();
            dt.Columns.Add("SlNo", typeof(int));
            dt.Columns.Add("PointType", typeof(string));
            dt.Columns.Add("RaisedBy", typeof(string));
            dt.Columns.Add("Description", typeof(string));
            dt.Columns.Add("Duration", typeof(string));
            dt.Columns.Add("RefPhoto", typeof(string));
            return dt;
        }

        private DataTable CreateFeedbackTable()
        {
            var dt = new DataTable();
            dt.Columns.Add("SlNo", typeof(int));
            dt.Columns.Add("FeedbackType", typeof(string));
            dt.Columns.Add("FeedbackBy", typeof(string));
            dt.Columns.Add("Description", typeof(string));
            dt.Columns.Add("BeforeImage", typeof(string));
            dt.Columns.Add("AfterImage", typeof(string));
            return dt;
        }
        #endregion

        #region UI Binding
        private void BindReportData()
        {
            var reportInfo = Session[SESSION_REPORT_INFO] as Dictionary<string, string>;
            if (reportInfo != null)
            {
                ltlMMRId.Text = txtMMRId.Text = reportInfo["MMRId"];
                ltlReportDate.Text = txtReportDate.Text = reportInfo["ReportDate"];
                ltlDepartment.Text = txtDepartment.Text = reportInfo["Department"];
                ltlLocation.Text = txtLocation.Text = reportInfo["Location"];
                ltlSubmitter.Text = txtSubmitter.Text = reportInfo["Submitter"];
                ltlTSLMember.Text = txtTSLMember.Text = reportInfo["TSLMember"];
                ltlDate.Text = reportInfo["Date"];
                ltlRegion.Text = txtRegion.Text = reportInfo["Region"];
            }

            BindGrid(gvAttendance, SESSION_ATTENDANCE);
            BindGrid(gvMeetingDetails, SESSION_MEETING_DETAILS);
            BindGrid(gvFeedback, SESSION_FEEDBACK);
            BindGrid(gvEditAttendance, SESSION_ATTENDANCE);
            BindGrid(gvEditMeetingDetails, SESSION_MEETING_DETAILS);
            BindGrid(gvEditFeedback, SESSION_FEEDBACK);

            UpdateSummary();
        }

        private void BindGrid(GridView grid, string sessionKey)
        {
            var dt = Session[sessionKey] as DataTable;
            if (dt != null)
            {
                grid.DataSource = dt;
                grid.DataBind();
            }
        }

        private void UpdateSummary()
        {
            ltlTotalParticipants.Text = ((DataTable)Session[SESSION_ATTENDANCE]).Rows.Count.ToString();
            ltlTopicsDiscussed.Text = ((DataTable)Session[SESSION_MEETING_DETAILS]).Rows.Count.ToString();
            ltlFeedbackReceived.Text = ((DataTable)Session[SESSION_FEEDBACK]).Rows.Count.ToString();
            // Add duration calculation logic if needed
            ltlTotalDuration.Text = "N/A"; // Placeholder
        }
        #endregion

        #region Event Handlers
        protected void btnSave_Click(object sender, EventArgs e)
        {
            UpdateSessionDataFromUI();
            SaveReportToDatabase();
            ShowMessage("Report saved successfully!");
            BindReportData();
        }

        protected void btnExportPDF_Click(object sender, EventArgs e)
        {
            UpdateSessionDataFromUI();
            ExportReport(); // Implement PDF export logic
        }

        protected void btnToggleEdit_Click(object sender, EventArgs e)
        {
            pnlEditor.Visible = !pnlEditor.Visible;
            btnToggleEdit.Text = pnlEditor.Visible ? "View Report" : "Edit Report";
        }

        protected void btnUpdateReport_Click(object sender, EventArgs e)
        {
            UpdateSessionDataFromUI();
            SaveReportToDatabase();
            pnlEditor.Visible = false;
            btnToggleEdit.Text = "Edit Report";
            BindReportData();
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            pnlEditor.Visible = false;
            btnToggleEdit.Text = "Edit Report";
            BindReportData();
        }

        protected void gvEditAttendance_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            HandleGridCommand(gvEditAttendance, SESSION_ATTENDANCE, e, AddAttendanceRow, RemoveRow);
        }

        protected void gvEditMeetingDetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            HandleGridCommand(gvEditMeetingDetails, SESSION_MEETING_DETAILS, e, AddMeetingDetailRow, RemoveRow);
        }

        protected void gvEditFeedback_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            HandleGridCommand(gvEditFeedback, SESSION_FEEDBACK, e, AddFeedbackRow, RemoveRow);
        }

        private void HandleGridCommand(GridView grid, string sessionKey, GridViewCommandEventArgs e, Action<GridView> addAction, Action<GridView, int> removeAction)
        {
            if (e.CommandName == "AddAttendee" || e.CommandName == "AddDetail" || e.CommandName == "AddFeedback")
            {
                addAction(grid);
            }
            else if (e.CommandName == "RemoveAttendee" || e.CommandName == "RemoveDetail" || e.CommandName == "RemoveFeedback")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                removeAction(grid, index);
            }
            BindReportData();
        }

        private void AddAttendanceRow(GridView grid)
        {
            var dt = (DataTable)Session[SESSION_ATTENDANCE];
            var row = dt.NewRow();
            row["SlNo"] = dt.Rows.Count + 1;
            row["MemberType"] = ((TextBox)grid.FooterRow.FindControl("txtNewMemberType")).Text;
            row["EmployeeCode"] = ((TextBox)grid.FooterRow.FindControl("txtNewEmployeeCode")).Text;
            row["EmployeeName"] = ((TextBox)grid.FooterRow.FindControl("txtNewEmployeeName")).Text;
            row["Designation"] = ((TextBox)grid.FooterRow.FindControl("txtNewDesignation")).Text;
            row["GatePassNo"] = ((TextBox)grid.FooterRow.FindControl("txtNewGatePassNo")).Text;
            dt.Rows.Add(row);
            Session[SESSION_ATTENDANCE] = dt;
        }

        private void AddMeetingDetailRow(GridView grid)
        {
            var dt = (DataTable)Session[SESSION_MEETING_DETAILS];
            var row = dt.NewRow();
            row["SlNo"] = dt.Rows.Count + 1;
            row["PointType"] = ((TextBox)grid.FooterRow.FindControl("txtNewPointType")).Text;
            row["RaisedBy"] = ((TextBox)grid.FooterRow.FindControl("txtNewRaisedBy")).Text;
            row["Description"] = ((TextBox)grid.FooterRow.FindControl("txtNewDescription")).Text;
            row["Duration"] = ((TextBox)grid.FooterRow.FindControl("txtNewDuration")).Text;
            dt.Rows.Add(row);
            Session[SESSION_MEETING_DETAILS] = dt;
        }

        private void AddFeedbackRow(GridView grid)
        {
            var dt = (DataTable)Session[SESSION_FEEDBACK];
            var row = dt.NewRow();
            row["SlNo"] = dt.Rows.Count + 1;
            row["FeedbackType"] = ((TextBox)grid.FooterRow.FindControl("txtNewFeedbackType")).Text;
            row["FeedbackBy"] = ((TextBox)grid.FooterRow.FindControl("txtNewFeedbackBy")).Text;
            row["Description"] = ((TextBox)grid.FooterRow.FindControl("txtNewDescription")).Text;
            dt.Rows.Add(row);
            Session[SESSION_FEEDBACK] = dt;
        }

        private void RemoveRow(GridView grid, int index)
        {
            var dt = (DataTable)Session[grid.ID == gvEditAttendance.ID ? SESSION_ATTENDANCE :
                                     grid.ID == gvEditMeetingDetails.ID ? SESSION_MEETING_DETAILS : SESSION_FEEDBACK];
            dt.Rows.RemoveAt(index);
            for (int i = 0; i < dt.Rows.Count; i++)
                dt.Rows[i]["SlNo"] = i + 1;
            Session[grid.ID == gvEditAttendance.ID ? SESSION_ATTENDANCE :
                    grid.ID == gvEditMeetingDetails.ID ? SESSION_MEETING_DETAILS : SESSION_FEEDBACK] = dt;
        }
        #endregion

        #region Data Persistence
        private void UpdateSessionDataFromUI()
        {
            var reportInfo = (Dictionary<string, string>)Session[SESSION_REPORT_INFO];
            reportInfo["MMRId"] = txtMMRId.Text;
            reportInfo["ReportDate"] = txtReportDate.Text;
            reportInfo["Department"] = txtDepartment.Text;
            reportInfo["Location"] = txtLocation.Text;
            reportInfo["Submitter"] = txtSubmitter.Text;
            reportInfo["TSLMember"] = txtTSLMember.Text;
            reportInfo["Date"] = DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt"); // Update date on save
            reportInfo["Region"] = txtRegion.Text;

            Session[SESSION_REPORT_INFO] = reportInfo;
        }

        private void SaveReportToDatabase()
        {
            try
            {
                var reportInfo = (Dictionary<string, string>)Session[SESSION_REPORT_INFO];
                var dtAttendance = (DataTable)Session[SESSION_ATTENDANCE];
                var dtMeetingDetails = (DataTable)Session[SESSION_MEETING_DETAILS];
                var dtFeedback = (DataTable)Session[SESSION_FEEDBACK];

                using (var conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ReportDBConnection"].ConnectionString))
                {
                    conn.Open();
                    using (var transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            // Save or update report info
                            string reportQuery = @"
                                IF EXISTS (SELECT 1 FROM MassMeetingReports WHERE MMRId = @MMRId)
                                    UPDATE MassMeetingReports SET
                                        ReportDate = @ReportDate,
                                        Department = @Department,
                                        Location = @Location,
                                        Submitter = @Submitter,
                                        TSLMember = @TSLMember,
                                        Date = @Date,
                                        Region = @Region
                                    WHERE MMRId = @MMRId
                                ELSE
                                    INSERT INTO MassMeetingReports (MMRId, ReportDate, Department, Location, Submitter, TSLMember, Date, Region)
                                    VALUES (@MMRId, @ReportDate, @Department, @Location, @Submitter, @TSLMember, @Date, @Region);
                                    
                                SELECT SCOPE_IDENTITY();";

                            int reportId;
                            using (var cmd = new SqlCommand(reportQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@MMRId", reportInfo["MMRId"]);
                                cmd.Parameters.AddWithValue("@ReportDate", DateTime.Parse(reportInfo["ReportDate"]));
                                cmd.Parameters.AddWithValue("@Department", reportInfo["Department"]);
                                cmd.Parameters.AddWithValue("@Location", reportInfo["Location"]);
                                cmd.Parameters.AddWithValue("@Submitter", reportInfo["Submitter"]);
                                cmd.Parameters.AddWithValue("@TSLMember", reportInfo["TSLMember"]);
                                cmd.Parameters.AddWithValue("@Date", DateTime.Parse(reportInfo["Date"]));
                                cmd.Parameters.AddWithValue("@Region", reportInfo["Region"]);
                                reportId = Convert.ToInt32(cmd.ExecuteScalar() ?? 0);
                            }

                            // Save related tables
                            SaveTableData(conn, transaction, "MassMeetingAttendance", reportId, dtAttendance, "DELETE FROM MassMeetingAttendance WHERE ReportId = @ReportId",
                                "INSERT INTO MassMeetingAttendance (ReportId, SlNo, MemberType, EmployeeCode, EmployeeName, Designation, GatePassNo) VALUES (@ReportId, @SlNo, @MemberType, @EmployeeCode, @EmployeeName, @Designation, @GatePassNo)");

                            SaveTableData(conn, transaction, "MassMeetingDetails", reportId, dtMeetingDetails, "DELETE FROM MassMeetingDetails WHERE ReportId = @ReportId",
                                "INSERT INTO MassMeetingDetails (ReportId, SlNo, PointType, RaisedBy, Description, Duration, RefPhoto) VALUES (@ReportId, @SlNo, @PointType, @RaisedBy, @Description, @Duration, @RefPhoto)");

                            SaveTableData(conn, transaction, "MassMeetingFeedback", reportId, dtFeedback, "DELETE FROM MassMeetingFeedback WHERE ReportId = @ReportId",
                                "INSERT INTO MassMeetingFeedback (ReportId, SlNo, FeedbackType, FeedbackBy, Description, BeforeImage, AfterImage) VALUES (@ReportId, @SlNo, @FeedbackType, @FeedbackBy, @Description, @BeforeImage, @AfterImage)");

                            transaction.Commit();
                        }
                        catch (Exception)
                        {
                            transaction.Rollback();
                            throw;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                ShowError("Error saving report: " + ex.Message);
            }
        }

        private void SaveTableData(SqlConnection conn, SqlTransaction transaction, string tableName, int reportId, DataTable dataTable, string deleteQuery, string insertQuery)
        {
            // Delete existing records
            using (var cmd = new SqlCommand(deleteQuery, conn, transaction))
            {
                cmd.Parameters.AddWithValue("@ReportId", reportId);
                cmd.ExecuteNonQuery();
            }

            // Insert new records
            foreach (DataRow row in dataTable.Rows)
            {
                using (var cmd = new SqlCommand(insertQuery, conn, transaction))
                {
                    cmd.Parameters.AddWithValue("@ReportId", reportId);
                    foreach (DataColumn col in dataTable.Columns)
                    {
                        cmd.Parameters.AddWithValue($"@{col.ColumnName}", row[col] ?? DBNull.Value);
                    }
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ExportReport()
        {
            // Placeholder for PDF export - Use a library like iTextSharp or PdfSharp
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", $"attachment;filename=MassMeetingReport_{DateTime.Now:yyyyMMdd}.pdf");
            Response.Write("PDF export functionality to be implemented");
            Response.End();
        }
        #endregion

        #region Utility Methods
        private void LogError(Exception ex)
        {
            string logPath = Server.MapPath("~/Logs");
            Directory.CreateDirectory(logPath);
            string logFile = Path.Combine(logPath, "error_log.txt");
            using (var sw = new StreamWriter(logFile, true))
            {
                sw.WriteLine($"Date: {DateTime.Now}");
                sw.WriteLine($"Error: {ex.Message}");
                sw.WriteLine($"Stack Trace: {ex.StackTrace}");
                sw.WriteLine(new string('-', 50));
            }
        }

        private void ShowError(string message)
        {
            // Assuming there's an error label in the ASPX
            var lblError = form1.FindControl("lblError") as Label;
            if (lblError != null)
            {
                lblError.Text = message;
                lblError.Visible = true;
            }
        }

        private void ShowMessage(string message)
        {
            // Assuming there's a message label in the ASPX
            var lblMessage = form1.FindControl("lblMessage") as Label;
            if (lblMessage != null)
            {
                lblMessage.Text = message;
                lblMessage.Visible = true;
            }
        }
        #endregion
    }
}