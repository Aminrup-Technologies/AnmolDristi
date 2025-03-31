<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TrainingSession.aspx.cs" Inherits="TrainingSession" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Training Session Form</title>
    <link href="bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Training Session Registration</h2>

            <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="true"></asp:Label>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Topic</label>
                        <asp:TextBox ID="txtTopic" runat="server" CssClass="form-control" required></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Trainer Name</label>
                        <asp:TextBox ID="txtTrainerName" runat="server" CssClass="form-control" required></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Date</label>
                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" required></asp:TextBox>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>Time</label>
                        <asp:TextBox ID="txtTime" runat="server" CssClass="form-control" TextMode="Time" required></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Duration (Minutes)</label>
                        <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" TextMode="Number" required></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Department</label>
                        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control" required></asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label>Section</label>
                <asp:TextBox ID="txtSection" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Session Photograph</label>
                <asp:FileUpload ID="filePhotograph" runat="server" CssClass="form-control-file" />
            </div>

            <h3>Participants</h3>
            <asp:Table ID="participantsTable" runat="server" CssClass="table">
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell>Participant Code</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Participant Name</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Designation</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Signature</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Feedback</asp:TableHeaderCell>
                </asp:TableHeaderRow>
            </asp:Table>

            <asp:Button ID="btnAddParticipant" runat="server" Text="Add Participant"
                CssClass="btn btn-secondary" OnClick="AddParticipantRow_Click" />

            <h3>Discussion Points</h3>
            <asp:Table ID="discussionPointsTable" runat="server" CssClass="table">
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell>Discussion Point</asp:TableHeaderCell>
                </asp:TableHeaderRow>
            </asp:Table>

            <asp:Button ID="btnAddDiscussionPoint" runat="server" Text="Add Discussion Point"
                CssClass="btn btn-secondary" OnClick="AddDiscussionPoint_Click" />

            <div class="form-group">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit Training Session"
                    CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </form>
</body>
</html>
