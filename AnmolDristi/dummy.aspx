<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MassMeetingReport.aspx.cs" Inherits="CompanyReportSystem.MassMeetingReport" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mass Meeting Report</title>
    <style type="text/css">
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-color: #f5f5f5;
        }

        .report-container {
            width: 21cm; /* A4 width */
            min-height: 29.7cm; /* A4 height */
            background: white;
            margin: 0 auto;
            padding: 2cm;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .report-header {
            text-align: center;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 15px;
            border-bottom: 2px solid #0056b3;
        }

        .logo-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .logo {
            height: 60px;
            width: auto;
        }

        .report-title {
            color: #0056b3;
            font-size: 24px;
            font-weight: bold;
            margin: 10px 0;
        }

        .report-info {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin: 20px 0;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
            border-left: 4px solid #0056b3;
        }

        .info-item {
            width: 48%;
            margin-bottom: 10px;
        }

        .info-label {
            font-weight: bold;
            color: #0056b3;
        }

        .section-title {
            background-color: #0056b3;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            margin: 25px 0 15px 0;
            font-size: 18px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th {
            background-color: #e6f2ff;
            color: #0056b3;
            padding: 12px 8px;
            text-align: left;
            border: 1px solid #ccc;
        }

        td {
            padding: 10px 8px;
            border: 1px solid #ccc;
            vertical-align: top;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f0f7ff;
        }

        .summary-section {
            background-color: #f0f7ff;
            padding: 15px;
            border-radius: 5px;
            margin: 25px 0;
            border-left: 4px solid #0056b3;
        }

        .summary-item {
            display: inline-block;
            margin-right: 25px;
            margin-bottom: 10px;
        }

        .summary-value {
            font-weight: bold;
            font-size: 18px;
            color: #0056b3;
        }

        .signature-section {
            margin-top: 50px;
            display: flex;
            justify-content: space-between;
        }

        .signature-block {
            width: 45%;
        }

        .signature-line {
            border-top: 1px solid #333;
            padding-top: 5px;
            margin-top: 50px;
        }

        @media print {
            body {
                background-color: white;
            }

            .report-container {
                box-shadow: none;
                padding: 0;
            }

            .no-print, .no-print * {
                display: none !important;
                visibility: hidden !important;
                height: 0 !important;
            }
        }


        .action-buttons {
            position: fixed;
            top: 20px;
            right: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .action-button {
            padding: 10px 20px;
            background-color: #0056b3;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            text-align: center;
        }

            .action-button:hover {
                background-color: #003d80;
            }

        .form-editor {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .form-section {
            margin-bottom: 20px;
        }

        .input-group {
            margin-bottom: 15px;
        }

        .input-label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .editor-button {
            padding: 10px 15px;
            background-color: #0056b3;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }

        .view-toggle {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="action-buttons no-print">
            <asp:Button ID="btnPrint" runat="server" Text="Print Report" CssClass="action-button" OnClientClick="window.print(); return false;" />
            <asp:Button ID="btnToggleEdit" runat="server" Text="Edit Report" CssClass="action-button" OnClick="btnToggleEdit_Click" Visible="false" />
            <asp:Button ID="btnExportPDF" runat="server" Text="Export to PDF" CssClass="action-button" OnClick="btnExportPDF_Click" />
            <asp:Button ID="btnSave" runat="server" Text="Save Report" CssClass="action-button" OnClick="btnSave_Click" />
        </div>

        <asp:Panel ID="pnlEditor" runat="server" CssClass="form-editor no-print" Visible="false">
            <h2>Edit Mass Meeting Report</h2>

            <div class="form-section">
                <h3>Report Information</h3>
                <div class="input-group">
                    <asp:Label ID="lblMMRId" runat="server" CssClass="input-label" Text="MMR ID:"></asp:Label>
                    <asp:TextBox ID="txtMMRId" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="input-group">
                    <asp:Label ID="lblReportDate" runat="server" CssClass="input-label" Text="Report Date:"></asp:Label>
                    <asp:TextBox ID="txtReportDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                <div class="input-group">
                    <asp:Label ID="lblDepartment" runat="server" CssClass="input-label" Text="Department:"></asp:Label>
                    <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="input-group">
                    <asp:Label ID="lblLocation" runat="server" CssClass="input-label" Text="Location:"></asp:Label>
                    <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="input-group">
                    <asp:Label ID="lblSubmitter" runat="server" CssClass="input-label" Text="Submitter Name:"></asp:Label>
                    <asp:TextBox ID="txtSubmitter" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="input-group">
                    <asp:Label ID="lblTSLMember" runat="server" CssClass="input-label" Text="TSL Team Member:"></asp:Label>
                    <asp:TextBox ID="txtTSLMember" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="input-group">
                    <asp:Label ID="lblRegion" runat="server" CssClass="input-label" Text="Region:"></asp:Label>
                    <asp:TextBox ID="txtRegion" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="form-section">
                <h3>Attendance</h3>
                <asp:GridView ID="gvEditAttendance" runat="server" AutoGenerateColumns="false" ShowFooter="true"
                    OnRowCommand="gvEditAttendance_RowCommand" DataKeyNames="RowIndex" CssClass="grid-view">
                    <Columns>
                        <asp:TemplateField HeaderText="Sl.No">
                            <ItemTemplate>
                                <asp:Label ID="lblSlNo" runat="server" Text='<%# Eval("SlNo") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewSlNo" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Member Type">
                            <ItemTemplate>
                                <asp:TextBox ID="txtMemberType" runat="server" Text='<%# Eval("MemberType") %>' CssClass="form-control"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewMemberType" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Employee Code">
                            <ItemTemplate>
                                <asp:TextBox ID="txtEmployeeCode" runat="server" Text='<%# Eval("EmployeeCode") %>' CssClass="form-control"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewEmployeeCode" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Employee Fullname">
                            <ItemTemplate>
                                <asp:TextBox ID="txtEmployeeName" runat="server" Text='<%# Eval("EmployeeName") %>' CssClass="form-control"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewEmployeeName" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Designation">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDesignation" runat="server" Text='<%# Eval("Designation") %>' CssClass="form-control"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewDesignation" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Gate Pass No">
                            <ItemTemplate>
                                <asp:TextBox ID="txtGatePassNo" runat="server" Text='<%# Eval("GatePassNo") %>' CssClass="form-control"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewGatePassNo" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandName="RemoveAttendee"
                                    CommandArgument='<%# Container.DataItemIndex %>' CssClass="editor-button" />
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Button ID="btnAddAttendee" runat="server" Text="Add Attendee" CommandName="AddAttendee" CssClass="editor-button" />
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <div class="form-section">
                <h3>Meeting Details</h3>
                <asp:GridView ID="gvEditMeetingDetails" runat="server" AutoGenerateColumns="false" ShowFooter="true"
                    OnRowCommand="gvEditMeetingDetails_RowCommand" DataKeyNames="RowIndex" CssClass="grid-view">
                    <Columns>
                        <asp:TemplateField HeaderText="Sl.No">
                            <ItemTemplate>
                                <asp:Label ID="lblSlNo" runat="server" Text='<%# Eval("SlNo") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewSlNo" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Point Type">
                            <ItemTemplate>
                                <asp:TextBox ID="txtPointType" runat="server" Text='<%# Eval("PointType") %>' CssClass="form-control"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewPointType" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Point Raised By">
                            <ItemTemplate>
                                <asp:TextBox ID="txtRaisedBy" runat="server" Text='<%# Eval("RaisedBy") %>' CssClass="form-control"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewRaisedBy" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>' CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Duration">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDuration" runat="server" Text='<%# Eval("Duration") %>' CssClass="form-control"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewDuration" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandName="RemoveDetail"
                                    CommandArgument='<%# Container.DataItemIndex %>' CssClass="editor-button" />
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Button ID="btnAddDetail" runat="server" Text="Add Detail" CommandName="AddDetail" CssClass="editor-button" />
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <div class="form-section">
                <h3>Feedback</h3>
                <asp:GridView ID="gvEditFeedback" runat="server" AutoGenerateColumns="false" ShowFooter="true"
                    OnRowCommand="gvEditFeedback_RowCommand" DataKeyNames="RowIndex" CssClass="grid-view">
                    <Columns>
                        <asp:TemplateField HeaderText="Sl.No">
                            <ItemTemplate>
                                <asp:Label ID="lblSlNo" runat="server" Text='<%# Eval("SlNo") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewSlNo" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Feedback Type">
                            <ItemTemplate>
                                <asp:TextBox ID="txtFeedbackType" runat="server" Text='<%# Eval("FeedbackType") %>' CssClass="form-control"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewFeedbackType" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Feedback By">
                            <ItemTemplate>
                                <asp:TextBox ID="txtFeedbackBy" runat="server" Text='<%# Eval("FeedbackBy") %>' CssClass="form-control"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewFeedbackBy" runat="server" CssClass="form-control"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server" Text='<%# Eval("Description") %>' CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandName="RemoveFeedback"
                                    CommandArgument='<%# Container.DataItemIndex %>' CssClass="editor-button" />
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Button ID="btnAddFeedback" runat="server" Text="Add Feedback" CommandName="AddFeedback" CssClass="editor-button" />
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <div class="form-section">
                <asp:Button ID="btnUpdateReport" runat="server" Text="Update Report" OnClick="btnUpdateReport_Click" CssClass="editor-button" />
                <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" OnClick="btnCancelEdit_Click" CssClass="editor-button" />
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlReport" runat="server" CssClass="report-container">
            <div class="report-header">
                <div class="logo-container">
                    <asp:Image ID="imgLogoLeft" runat="server" CssClass="logo" ImageUrl="~/WebData/Aminrup_Logo.png" AlternateText="Company Logo" />
                    <asp:Image ID="imgLogoRight" runat="server" CssClass="logo" ImageUrl="~/WebData/Aminrup_Logo.png" AlternateText="Company Logo" />
                </div>
                <div class="report-title">MASS MEETING REPORT</div>
                <div style="font-weight: bold;">
                    <asp:Literal ID="ltlMMRId" runat="server"></asp:Literal>
                    |
                    <asp:Literal ID="ltlReportDate" runat="server"></asp:Literal>
                </div>
            </div>

            <div class="report-info">
                <div class="info-item">
                    <span class="info-label">DEPARTMENT:</span>
                    <asp:Literal ID="ltlDepartment" runat="server"></asp:Literal>
                </div>
                <div class="info-item">
                    <span class="info-label">LOCATION:</span>
                    <asp:Literal ID="ltlLocation" runat="server"></asp:Literal>
                </div>
                <div class="info-item">
                    <span class="info-label">SUBMITTER NAME:</span>
                    <asp:Literal ID="ltlSubmitter" runat="server"></asp:Literal>
                </div>
                <div class="info-item">
                    <span class="info-label">TSL TEAM MEMBER:</span>
                    <asp:Literal ID="ltlTSLMember" runat="server"></asp:Literal>
                </div>
                <div class="info-item">
                    <span class="info-label">DATE:</span>
                    <asp:Literal ID="ltlDate" runat="server"></asp:Literal>
                </div>
                <div class="info-item">
                    <span class="info-label">REGION:</span>
                    <asp:Literal ID="ltlRegion" runat="server"></asp:Literal>
                </div>
            </div>

            <div class="section-title" id="Div_Atten" runat="server">ATTENDANCE OF THIS MASS MEETING</div>
            <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="false" CssClass="grid-view">
                <Columns>
                    <asp:BoundField DataField="SlNo" HeaderText="Sl.No" />
                    <asp:BoundField DataField="MemberType" HeaderText="Member Type" />
                    <asp:BoundField DataField="EmployeeCode" HeaderText="Employee Code" />
                    <asp:BoundField DataField="EmployeeName" HeaderText="Employee Fullname" />
                    <asp:BoundField DataField="Designation" HeaderText="Designation" />
                    <asp:BoundField DataField="GatePassNo" HeaderText="Gate Pass No" />
                </Columns>
            </asp:GridView>

            <div class="section-title">DETAILS OF THIS MMR REPORT</div>
            <asp:GridView ID="gvMeetingDetails" runat="server" AutoGenerateColumns="false" CssClass="grid-view">
                <Columns>
                    <asp:BoundField DataField="SlNo" HeaderText="Sl.No" />
                    <asp:BoundField DataField="PointType" HeaderText="Point Type" />
                    <asp:BoundField DataField="RaisedBy" HeaderText="Point Raised By" />
                    <asp:BoundField DataField="Description" HeaderText="Point Detailed Description" />
                    <asp:BoundField DataField="Duration" HeaderText="Duration of Discussion" />
                    <asp:BoundField DataField="RefPhoto" HeaderText="Ref. Photograph" />
                </Columns>
            </asp:GridView>

            <div class="section-title">FEEDBACK FROM PARTICIPANTS</div>
            <asp:GridView ID="gvFeedback" runat="server" AutoGenerateColumns="false" CssClass="grid-view">
                <Columns>
                    <asp:BoundField DataField="SlNo" HeaderText="Sl.No" />
                    <asp:BoundField DataField="FeedbackType" HeaderText="Feedback Type" />
                    <asp:BoundField DataField="FeedbackBy" HeaderText="Feedback By" />
                    <asp:BoundField DataField="Description" HeaderText="Feedback Description" />
                    <asp:BoundField DataField="BeforeImage" HeaderText="Before Image" />
                    <asp:BoundField DataField="AfterImage" HeaderText="After Image" />
                </Columns>
            </asp:GridView>

            <div class="section-title">SUMMARY</div>
            <div class="summary-section">
                <div class="summary-item">
                    <div>Total Participants</div>
                    <div class="summary-value">
                        <asp:Literal ID="ltlTotalParticipants" runat="server"></asp:Literal></div>
                </div>
                <div class="summary-item">
                    <div>Topics Discussed</div>
                    <div class="summary-value">
                        <asp:Literal ID="ltlTopicsDiscussed" runat="server"></asp:Literal></div>
                </div>
                <div class="summary-item">
                    <div>Total Discussion Duration</div>
                    <div class="summary-value">
                        <asp:Literal ID="ltlTotalDuration" runat="server"></asp:Literal></div>
                </div>
                <div class="summary-item">
                    <div>Feedback Received</div>
                    <div class="summary-value">
                        <asp:Literal ID="ltlFeedbackReceived" runat="server"></asp:Literal></div>
                </div>
            </div>

            <div class="signature-section">
                <div class="signature-block">
                    <div class="signature-line">Approved by</div>
                </div>
                <div class="signature-block">
                    <div class="signature-line">Submitted by</div>
                </div>
            </div>
        </asp:Panel>
    </form>
</body>
</html>
