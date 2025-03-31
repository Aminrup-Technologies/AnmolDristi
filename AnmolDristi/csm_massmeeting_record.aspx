<%@ Page Title="CSM | Mass Meeting Record" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="csm_massmeeting_record.aspx.cs" Inherits="AnmolDristi.csm_massmeeting_record" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .btn-fixed-size {
            width: 100px;
            text-align: center;
            font-size: 14px;
            padding: 5px 0;
        }

        .points-input {
            margin-right: 10px;
        }

        .input-group-sm input, .form-control-sm {
            width: 100%;
        }

        #GridView1 th, #GridView1 td {
            white-space: nowrap;
        }


        .table-responsive {
            width: 100%;
            max-height: 400px; /* Adjust based on need */
            overflow-x: auto;
            overflow-y: auto;
            -webkit-overflow-scrolling: touch;
        }

        @media (max-width: 768px) {
            .table-responsive {
                max-height: 300px; /* Adjust based on your UI */
            }
        }

        .btnStyle {
            width: 120px;
            height: 35px;
            color: black;
            background-color: coral;
            font-size: 16px;
            text-align: center;
            border: none;
            border-radius: 5px;
        }
        /* GridView Main Styling */
        #gvAttendees {
            width: 100%;
            max-width: 100%;
            /*    border-collapse: collapse;*/
            font-family: Arial, sans-serif;
            font-size: 14px;
            margin-top: 10px;
        }

            /* Header Styling */
            #gvAttendees th {
                background-color: #007BFF; /* Blue header */
                color: white;
                padding: 50px;
                text-align: left;
                border: 1px solid #ddd;
            }

            /* Row Styling */
            #gvAttendees td {
                padding: 50px;
                border: 1px solid #ddd;
            }

            /* Alternating Row Colors */
            #gvAttendees tr:nth-child(even) {
                background-color: #f2f2f2; /* Light grey */
            }

            #gvAttendees tr:nth-child(odd) {
                background-color: #ffffff; /* White */
            }

            /* Hover Effect */
            #gvAttendees tr:hover {
                background-color: #d1ecf1; /* Light blue */
                transition: 0.3s;
            }

            /* Align Text Properly */
            #gvAttendees td, #gvAttendees th {
                text-align: center;
            }

            #gvAttendees th, #gvAttendees td {
                min-width: 120px; /* Prevents text from squeezing */
                white-space: nowrap; /* Prevents wrapping */
                text-align: center;
            }
        /* Default tab link styles */
        .nav-tabs .nav-link {
            color: #004085; /* Deep blue text */
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }

            /* Hover background colors */
            .nav-tabs .nav-link:hover {
                background-color: #cce5ff; /* Light Blue */
                color: #000;
                border-radius: 5px;
            }

            /* Active tab styling */
            .nav-tabs .nav-link.active {
                background-color: #cce5ff; /* Soft Yellow */
                color: #000;
                border-radius: 5px;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <%--<div class="page-title">
                <div class="title_left">
                    <h3>Mass Meeting Attendance Sheet</h3>
                </div>
            </div>--%>
            <div id="panelMeeting" class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>CSM | Mass Meeting Record</h2>

                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <div class="container mt-4">
                                <!-- Tab navigation -->
                                <ul class="nav nav-tabs" id="myTabs">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="Meeting-tab" data-bs-toggle="tab" href="#Meeting">Meeting Details</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="Attendees-tab" data-bs-toggle="tab" href="#Attendees">Attendees Details</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="Points-tab" data-bs-toggle="tab" href="#Points">Points Discussed</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="Feedback-tab" data-bs-toggle="tab" href="#Feedback">Feedback</a>
                                    </li>
                                </ul>

                                <!-- Tab content -->
                                <div class="tab-content mt-3">

                                    <div class="tab-pane fade show active" id="Meeting">
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_Date" runat="server" AssociatedControlID="TB_Date" Text="Meeting Date" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_TB_Date" runat="server" ErrorMessage="*" ControlToValidate="TB_Date" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_Date" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>

                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_StartTime" runat="server" AssociatedControlID="TB_StartTime" Text="Meeting Start Time" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_TB_StartTime" runat="server" ErrorMessage="*" ControlToValidate="TB_StartTime" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_StartTime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>



                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_EndTime" runat="server" AssociatedControlID="TB_EndTime" Text="MeetingEnd Time" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_TB_EndTime" runat="server" ErrorMessage="*" ControlToValidate="TB_EndTime" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_EndTime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>




                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_Duration" runat="server" AssociatedControlID="TB_Duration" Text="Duration" ReadOnly="true" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_Duration" runat="server" CssClass="form-control form-control-sm rounded" ReadOnly="true"></asp:TextBox>
                                                    <asp:HiddenField ID="hfDuration" runat="server" />
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_WorkRegion" runat="server" AssociatedControlID="DDL_WorkRegion" Text="Work Region" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_DDL_WorkRegion" runat="server" ErrorMessage="*" ControlToValidate="DDL_WorkRegion" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:DropDownList ID="DDL_WorkRegion" runat="server" CssClass="form-control form-control-sm rounded">
                                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                        <asp:ListItem Text="Region 1" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Region 2" Value="2"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_Company" runat="server" AssociatedControlID="DDL_Company" Text="Company" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_DDL_Company" runat="server" ErrorMessage="*" ControlToValidate="DDL_Company" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:DropDownList ID="DDL_Company" runat="server" CssClass="form-control form-control-sm rounded">
                                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                        <asp:ListItem Text="Company A" Value="A"></asp:ListItem>
                                                        <asp:ListItem Text="Company B" Value="B"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_Department" runat="server" AssociatedControlID="DDL_Department" Text="Department" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_DDL_Department" runat="server" ErrorMessage="*" ControlToValidate="DDL_Department" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:DropDownList ID="DDL_Department" runat="server" CssClass="form-control form-control-sm rounded">
                                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                        <asp:ListItem Text="HR" Value="HR"></asp:ListItem>
                                                        <asp:ListItem Text="IT" Value="IT"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_Location" runat="server" AssociatedControlID="DDL_Location" Text="Location" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_DDL_Location" runat="server" ErrorMessage="*" ControlToValidate="DDL_Location" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:DropDownList ID="DDL_Location" runat="server" CssClass="form-control form-control-sm rounded">
                                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                        <asp:ListItem Text="Site A" Value="A"></asp:ListItem>
                                                        <asp:ListItem Text="Site B" Value="B"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_ExactLocation" runat="server" AssociatedControlID="TB_ExactLocation" Text="Exact Location" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_TB_ExactLocation" runat="server" ErrorMessage="*" ControlToValidate="TB_ExactLocation" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_ExactLocation" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_TB_CoordinatorName" runat="server" AssociatedControlID="TB_CoordinatorName" Text="Co-Ordinator Name" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_TB_CoordinatorName" runat="server" ErrorMessage="*" ControlToValidate="TB_CoordinatorName" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_CoordinatorName" runat="server" CssClass="form-control form-control-sm rounded" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_btnsave1" runat="server" AssociatedControlID="btnsave1" Text="Click to Save" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <div class="input-group">
                                                    <asp:Button ID="btnsave1" runat="server" Text="Proceed Next" CssClass="btn btn-success" ValidationGroup="Save1" CausesValidation="true" OnClick="btnsave1_Click" />
                                                    <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>

                                                </div>
                                            </div>
                                        </div>
                                        <asp:HiddenField ID="HiddenField_MMId" runat="server" />
                                    </div>

                                    <div class="tab-pane fade" id="Attendees">
                                        <div class="col-md-6">
                                            <div class="mb-6">
                                                <asp:Label ID="lbl_rbAttendeeType" runat="server" AssociatedControlID="rbAttendeeType" Text="Attendees Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_rbAttendeeType" runat="server" ErrorMessage="Select any option" ValidationGroup="add2" ControlToValidate="rbAttendeeType" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:RadioButtonList ID="rbAttendeeType" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="2">
                                                        <asp:ListItem Text="Internal" Value="Internal"></asp:ListItem>
                                                        <asp:ListItem Text="External" Value="External"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div>
                                        </div>

                                        <asp:Panel ID="pnlDetails" runat="server" Style="display: none;">

                                            <div class="col-md-6">
                                                <div class="mb-6">
                                                    <asp:Label ID="lbl_txtAttendeeCode" runat="server" AssociatedControlID="txtAttendeeCode" Text="Ateendees Code" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="RFV_txtAttendeeCode" runat="server" ErrorMessage="*" ControlToValidate="txtAttendeeCode" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="REV_txtAttendeeCode" runat="server" ControlToValidate="txtAttendeeCode" ForeColor="Red" ErrorMessage="AlphaNumeric Only" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" Display="Dynamic"></asp:RegularExpressionValidator>

                                                    <div class="input-group-sm">
                                                        <asp:TextBox ID="txtAttendeeCode" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <asp:Label ID="lbl_txtEmployeeName" runat="server" AssociatedControlID="txtEmployeeName" Text="Employee Name" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="RFV_txtEmployeeName" runat="server" ErrorMessage="*" ControlToValidate="txtEmployeeName" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <asp:Label ID="lbl_txtdes" runat="server" AssociatedControlID="txtdes" Text="Designation" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="RFV_txtdes" runat="server" ErrorMessage="*" ControlToValidate="txtdes" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox ID="txtdes" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <asp:Label ID="lbl_txtgatepassno" runat="server" AssociatedControlID="txtgatepassno" Text="Gate Pass Number" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="RFV_txtgatepassno" runat="server" ErrorMessage="*" ControlToValidate="txtgatepassno" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox ID="txtgatepassno" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <asp:Label ID="lbl_imgupload" runat="server" AssociatedControlID="imgupload" Text="Upload Your Image" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="RFV_imgupload" runat="server" ErrorMessage="*" ControlToValidate="imgupload" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                    <div class="input-group-sm">
                                                        <asp:FileUpload ID="imgupload" runat="server" CssClass="form-control form-control-sm rounded" />
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <asp:Label ID="lbl_btnAddAttendees" runat="server" AssociatedControlID="btnAddAttendees" Text="Add Attendees" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group">
                                                        <asp:Button ID="btnAddAttendees" runat="server" CssClass="btn btn-primary" ValidationGroup="add2" CausesValidation="false" Text="Add Attendees" OnClientClick="addAttendee(); return false;" />
                                                        <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>

                                        <%--<asp:Panel ID="pnlAttendeeTable" runat="server">
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <asp:GridView ID="gvAttendees" runat="server" CssClass="tableStyle" ShowHeaderWhenEmpty="true" Width="100%" AutoGenerateColumns="False">
                                                        <HeaderStyle BackColor="#5F9EA0" ForeColor="Black" Font-Bold="True" />
                                                        <RowStyle BackColor="White" />
                                                        <AlternatingRowStyle BackColor="White" />
                                                        < Columns>
                                                            <asp:BoundField DataField="EmployeeOrNot" HeaderText="Employee?" />
                                                            <asp:BoundField DataField="AttendeeType" HeaderText="Attendee Type" />
                                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
                                                            <asp:BoundField DataField="AttendeeCode" HeaderText="Attendee Code" />
                                                            <asp:BoundField DataField="GatePassNo" HeaderText="Gate Pass No" />
                                                            <asp:BoundField DataField="Designation" HeaderText="Designation" />
                                                            <<asp:TemplateField HeaderText="Image Preview">
                                                                <ItemTemplate>
                                                                    <asp:Image ID="imgPreview" runat="server" ImageUrl='<%# Eval("ImagePath") %>' Width="50px" Height="50px" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </asp:Panel>--%>

                                        <div class="col-lg-12" id="AttendeesTable" runat="server" visible="true">
                                            <table id="<%= gvAttendees.ClientID %>" class="table table-striped table-hover table-bordered table-responsive table-sm dt-responsive">
                                                <thead>
                                                    <tr>
                                                        <th>Employee?</th>
                                                        <th>Attendee Type</th>
                                                        <th>Employee Name</th>
                                                        <th>Attendee Code</th>
                                                        <th>Gate Pass No</th>
                                                        <th>Designation</th>
                                                        <%--<th>Image Preview</th>--%>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                </tbody>
                                            </table>
                                        </div>

                                        <asp:Panel ID="pnlAttendeeTable" runat="server">
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <asp:GridView ID="gvAttendees" runat="server" CssClass="table table-striped table-hover table-bordered table-responsive table-sm dt-responsive" ShowHeaderWhenEmpty="true" Width="100%" EmptyDataText="No Data Found" AutoGenerateColumns="False">
                                                        <Columns>
                                                            <asp:BoundField DataField="EmployeeOrNot" HeaderText="Employee?" />
                                                            <asp:BoundField DataField="AttendeeType" HeaderText="Attendee Type" />
                                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
                                                            <asp:BoundField DataField="AttendeeCode" HeaderText="Attendee Code" />
                                                            <asp:BoundField DataField="GatePassNo" HeaderText="Gate Pass No" />
                                                            <asp:BoundField DataField="Designation" HeaderText="Designation" />
                                                        </Columns>
                                                        <HeaderStyle CssClass="text text-center" />
                                                        <EmptyDataTemplate>
                                                            <div class="grid">No Data Found</div>
                                                        </EmptyDataTemplate>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </asp:Panel>


                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_btnsave2" runat="server" AssociatedControlID="btnsave2" Text="Click to Save" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <div class="input-group">
                                                    <asp:Button ID="btnsave2" runat="server" Text="Save & proceed" CssClass="btn btn-success" CausesValidation="false" OnClientClick="return validateAttendeesBeforeSave();" OnClick="btnsave2_Click" />
                                                    <asp:Label ID="lbl_btnsave22" runat="server" ForeColor="Green"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <%--<div class="tab-pane fade" id="Points">
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" CssClass="table table-bordered table-hover table-responsive" OnRowCommand="GridView1_RowCommand">
                                                    <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
                                                    <Columns>
                                                        <asp:BoundField DataField="SLNO" HeaderText="SL.NO" />
                                                        <asp:TemplateField HeaderText="Agenda Title">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_txtAgendaTitle" runat="server" AssociatedControlID="txtAgendaTitle"></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RFV_txtAgendaTitle" runat="server" ErrorMessage="*" ControlToValidate="txtAgendaTitle" ValidationGroup="ADD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <asp:TextBox ID="txtAgendaTitle" runat="server" Text='<%# Bind("AgendaTitle") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Discussed By Code">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_txtDiscussedByCode" runat="server" AssociatedControlID="txtDiscussedByCode"></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RFV_txtDiscussedByCode" runat="server" ErrorMessage="*" ControlToValidate="txtDiscussedByCode" ValidationGroup="ADD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <asp:TextBox ID="txtDiscussedByCode" runat="server" Text='<%# Bind("DiscussedByCode") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Discussion Type">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_ddlDiscussionType" runat="server" AssociatedControlID="ddlDiscussionType"></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RFV_ddlDiscussionType" runat="server" ErrorMessage="*" ControlToValidate="ddlDiscussionType" ValidationGroup="ADD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <asp:DropDownList ID="ddlDiscussionType" runat="server">
                                                                    <asp:ListItem Text="Select" Value="" />
                                                                    <asp:ListItem Text="Technical" Value="Technical" />
                                                                    <asp:ListItem Text="Operational" Value="Operational" />
                                                                    <asp:ListItem Text="Compliance" Value="Compliance" />
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Company">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_ddlCompanyCode" runat="server" AssociatedControlID="ddlCompanyCode"></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RFV_ddlCompanyCode" runat="server" ErrorMessage="*" ControlToValidate="ddlCompanyCode" ValidationGroup="ADD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <asp:DropDownList ID="ddlCompanyCode" runat="server">
                                                                    <asp:ListItem Text="Select" Value="" />
                                                                    <asp:ListItem Text="Company A" Value="Company A" />
                                                                    <asp:ListItem Text="Company B" Value="Comapany B" />
                                                                    <asp:ListItem Text="Company C" Value="Comapany C" />
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Department">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_ddlDeptCode" runat="server" AssociatedControlID="ddlDeptCode"></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RFV_ddlDeptCode" runat="server" ErrorMessage="*" ControlToValidate="ddlDeptCode" ValidationGroup="ADD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <asp:DropDownList ID="ddlDeptCode" runat="server">
                                                                    <asp:ListItem Text="Select" Value="" />
                                                                    <asp:ListItem Text="Finance" Value="Finance" />
                                                                    <asp:ListItem Text="Mananger" Value="Manager" />
                                                                    <asp:ListItem Text="Developer" Value="Developer" />
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Point By">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_txtPointBy" runat="server" AssociatedControlID="txtPointBy"></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RFV_txtPointBy" runat="server" ErrorMessage="*" ControlToValidate="txtPointBy" ValidationGroup="ADD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <asp:TextBox ID="txtPointBy" runat="server" Text='<%# Bind("PointBy") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Agenda Point Description">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_txtAgendaDesc" runat="server" AssociatedControlID="txtAgendaDesc"></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RFV_txtAgendaDesc" runat="server" ErrorMessage="*" ControlToValidate="txtAgendaDesc" ValidationGroup="ADD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <asp:TextBox ID="txtAgendaDesc" runat="server" Text='<%# Bind("AgendaPointDescription") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Duration">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_txtDuration" runat="server" AssociatedControlID="txtDuration"></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RFV_txtDuration" runat="server" ErrorMessage="*" ControlToValidate="txtDuration" ValidationGroup="ADD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="REV_txtDuration" runat="server" ControlToValidate="txtDuration" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Only numbers are allowed" ValidationExpression="^\d+$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                <asp:TextBox ID="txtDuration" runat="server" Text='<%# Bind("Duration") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Ref. Photograph (Before)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_fuPhotoBefore" runat="server" AssociatedControlID="fuPhotoBefore"></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RFV_fuPhotoBefore" runat="server" ErrorMessage="*" ControlToValidate="fuPhotoBefore" ValidationGroup="ADD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <asp:FileUpload ID="fuPhotoBefore" runat="server" onchange="updateFilePath(this, 'txtPhotoBeforePath')" />
                                                                <asp:TextBox ID="txtPhotoBeforePath" runat="server" ReadOnly="false" CssClass="form-control"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Agenda Point Detailed Description (After)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_txtAgendaDescAfter" runat="server" AssociatedControlID="txtAgendaDescAfter"></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RFV_txtAgendaDescAfter" runat="server" ErrorMessage="*" ControlToValidate="txtAgendaDescAfter" ValidationGroup="ADD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <asp:TextBox ID="txtAgendaDescAfter" runat="server" Text='<%# Bind("AgendaPointAfter") %>'></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Ref. Photograph (After)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_fuPhotoAfter" runat="server" AssociatedControlID="fuPhotoAfter"></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RFV_fuPhotoAfter" runat="server" ErrorMessage="*" ControlToValidate="fuPhotoAfter" ValidationGroup="ADD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <asp:FileUpload ID="fuPhotoAfter" runat="server" onchange="updateFilePath(this, 'txtPhotoAfterPath')" />
                                                                <asp:TextBox ID="txtPhotoAfterPath" runat="server" ReadOnly="false" CssClass="form-control"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Action">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnAddMore" runat="server" CssClass="btn btn-primary btn-sm" ValidationGroup="ADD" CommandName="AddMore" Text="Add More" OmClick="btnAddMore_Click" />
                                                                <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                                                                <asp:Button ID="btnRemove" runat="server" CssClass="btn btn-danger btn-sm" CommandName="Remove" CommandArgument='<%# Container.DataItemIndex %>' Text="Remove" OnClientClick="return confirm('Are you sure you want to remove this row?');" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_btnsave3" runat="server" AssociatedControlID="btnsave3" Text="Click to Save" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <div class="input-group">
                                                    <asp:Button ID="btnsave3" runat="server" Text="Save" CssClass="btn btn-success btn-sm" CausesValidation="true" OnClick="btnsave3_Click" />
                                                </div>
                                            </div>
                                        </div>

                                    </div>--%>

                                    <div class="tab-pane fade" id="Points">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="ddlAgendaTitle" Text="Agenda Title" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:DropDownList ID="ddlAgendaTitle" runat="server" CssClass="form-control form-control-sm rounded">
                                                        <asp:ListItem Text="Select" Value="" />
                                                    </asp:DropDownList>
                                                </div>

                                                <div class="col-md-2">
                                                    <br />
                                                    <asp:Button ID="btnAddAgenda" runat="server" Text="+" CssClass="btn btn-primary" OnClientClick="openAgendaPopup(); return false;" />
                                                </div>

                                                <div class="col-md-6">
                                                    <asp:Label ID="Label2" runat="server" Text="Description" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:TextBox ID="txtAgendaDesc" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                </div>

                                                <div class="col-md-6">
                                                    <asp:Label ID="LabelType" runat="server" Text="Member Type" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <div>
                                                        <input type="radio" name="MemberType" value="Internal" onclick="toggleMemberType(this.value);" checked />
                                                        Internal&nbsp;&nbsp;<input type="radio" name="MemberType" value="External" onclick="toggleMemberType(this.value);" />
                                                        External
                                                    </div>
                                                </div>
                                                <div class="col-md-6" id="divEmpCode">
                                                    <asp:Label ID="Label3" runat="server" Text="Point Raised By (Emp Code)" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:TextBox ID="txtPointBy" runat="server" CssClass="form-control form-control-sm rounded" onblur="fetchEmployeeNameForPanel3();" />
                                                </div>
                                                <div class="col-md-6">
                                                    <asp:Label ID="Label4" runat="server" Text="Employee Name" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:TextBox ID="txtPointByName" runat="server" CssClass="form-control form-control-sm rounded" />
                                                </div>

                                                <div class="col-md-6">
                                                    <asp:Label ID="Label5" runat="server" Text="Discussion Time (Minutes)" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:DropDownList ID="ddlDiscussionTime" runat="server" CssClass="form-control form-control-sm rounded">
                                                        <asp:ListItem Text="Select" Value="" />
                                                        <asp:ListItem Text="10" Value="10" />
                                                        <asp:ListItem Text="20" Value="20" />
                                                        <asp:ListItem Text="30" Value="30" />
                                                    </asp:DropDownList>
                                                </div>

                                                <div class="col-md-6">
                                                    <asp:Label ID="Label6" runat="server" Text="Upload Photograph" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control form-control-sm rounded" onchange="previewFile();" />
                                                    <div id="previewContainer" style="margin-top: 10px;">
                                                        <asp:Image ID="previewImage" runat="server" CssClass="img-thumbnail" Width="150px" Style="display: none;" />
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <br />
                                                    <asp:Button ID="btnAddAgendaDetails" runat="server" Text="Add More" CssClass="btn btn-primary" OnClick="btnAddAgendaDetails_Click" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <asp:GridView ID="gvAgendaDetails" runat="server" CssClass="table table-striped table-hover table-bordered table-responsive table-sm dt-responsive" ShowHeaderWhenEmpty="true" Width="100%" EmptyDataText="No Data Found" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:BoundField DataField="AgendaTitle" HeaderText="Agenda Title" />
                                                        <asp:BoundField DataField="Description" HeaderText="Description" />
                                                        <asp:BoundField DataField="PointBy" HeaderText="Point Raised By" />
                                                        <asp:BoundField DataField="DiscussionTime" HeaderText="Discussion Time" />
                                                        <asp:TemplateField HeaderText="Photo">
                                                            <ItemTemplate>
                                                                <%# Eval("PhotoPath").ToString() == "No" ? "No" : Eval("PhotoPath") %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Action">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnRemove" runat="server" CssClass="btn btn-danger btn-sm" CommandName="Remove" CommandArgument='<%# Container.DataItemIndex %>' Text="Remove" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>

                                        <!-- Save Button -->
                                        <div class="col-md-3">
                                            <asp:Label ID="Label7" runat="server" Text="" Font-Bold="true"></asp:Label>
                                            <asp:Button ID="btnsave3" runat="server" Text="Save & Proceed" OnClick="btnsave3_Click" CssClass="btn btn-success" />
                                            <%--<asp:Button ID="btnSaveAgendaDetails" runat="server" Text="Save" CssClass="btn btn-success" OnClick="btnSaveAgendaDetails_Click" />--%>
                                        </div>
                                    </div>

                                    <div class="tab-pane fade" id="Feedback">

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_txtfeedname" runat="server" AssociatedControlID="txtfeedname" Text="Feedback by Name" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_txtfeedname" runat="server" ErrorMessage="*" ControlToValidate="txtfeedname" ValidationGroup="save4" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="txtfeedname" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_txtfeeddesc" runat="server" AssociatedControlID="txtfeeddesc" Text="Feedback Description" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_txtfeeddesc" runat="server" ErrorMessage="*" ControlToValidate="txtfeeddesc" ValidationGroup="save4" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="txtfeeddesc" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_ddlRating" runat="server" AssociatedControlID="ddlRating" Text="Rating" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_ddlRating" runat="server" ErrorMessage="*" ControlToValidate="ddlRating" ValidationGroup="save4" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-control">
                                                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>

                                        <%--Button--%>
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_btnsave4" runat="server" AssociatedControlID="btnsave4" Text="Click to Save" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <div class="input-group input-group-sm">
                                                    <asp:Button ID="btnsave4" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="save4" CausesValidation="false" OnClick="btnsave4_Click" />
                                                    <asp:Label ID="lbl_btnsave44" runat="server" ForeColor="Green"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>

                        <div class="modal fade" id="agendaModal" tabindex="-1" role="dialog" aria-labelledby="agendaModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="agendaModalLabel">Add New Agenda Title</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <label for="txtNewAgendaTitle">Agenda Title:</label>
                                        <input type="text" id="txtNewAgendaTitle" class="form-control" placeholder="Enter agenda title">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" onclick="closeAgendaPopup()">Cancel</button>
                                        <button type="button" class="btn btn-success" onclick="saveNewAgendaTitle()">Save</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>


                <div class="col-md-3">
                    <div class="mb-3">
                        <div class="input-group ">
                            <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                            <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/Home.aspx" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Hidden field to store active tab -->
    <asp:HiddenField ID="hfActiveTab" runat="server" ClientIDMode="Static" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        function showPNotify(title, text, type) {
            new PNotify({
                title: title,
                text: text,
                type: type,
                styling: 'bootstrap3',
                delay: 3000
            });
        }


        $(document).ready(function () {
            // Store active tab on click
            $('a[data-bs-toggle="tab"]').on('click', function () {
                var activeTab = $(this).attr('href');
                $('#hfActiveTab').val(activeTab);
            });

            // Restore active tab after postback
            var savedTab = $('#hfActiveTab').val();
            if (savedTab) {
                $('a[href="' + savedTab + '"]').tab('show');
            }
        });


        document.addEventListener("DOMContentLoaded", function () {
            function calculateDuration() {
                var startTime = document.getElementById('<%= TB_StartTime.ClientID %>')?.value || document.getElementById("txtStartTime")?.value;
                var endTime = document.getElementById('<%= TB_EndTime.ClientID %>')?.value || document.getElementById("txtEndTime")?.value;
                var durationField = document.getElementById('<%= TB_Duration.ClientID %>') || document.getElementById("txtDuration");
                var hiddenDuration = document.getElementById('<%= hfDuration.ClientID %>');

                if (startTime && endTime) {
                    var start = new Date("1970-01-01T" + startTime);
                    var end = new Date("1970-01-01T" + endTime);

                    var diff = (end - start) / 60000; // Convert milliseconds to minutes

                    if (diff < 0) {
                        showPNotify('Invalid Time', 'End time must be greater than start time.', 'warning');
                        durationField.value = "";
                        if (hiddenDuration) hiddenDuration.value = "";
                        return;
                    }

                    var durationText = diff + " minutes";
                    durationField.value = durationText;
                    if (hiddenDuration) hiddenDuration.value = durationText;
                }
            }

            var endTimeInput = document.getElementById('<%= TB_EndTime.ClientID %>') || document.getElementById("txtEndTime");
            if (endTimeInput) {
                endTimeInput.addEventListener("change", calculateDuration);
            }

            if (typeof Sys !== "undefined" && Sys.WebForms) {
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                    var endTimeInput = document.getElementById('<%= TB_EndTime.ClientID %>') || document.getElementById("txtEndTime");
                    if (endTimeInput) {
                        endTimeInput.addEventListener("change", calculateDuration);
                    }
                });
            }
        });

        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById('<%= btnsave1.ClientID %>').addEventListener("click", function (event) {
                if (!validateInputs()) {
                    event.preventDefault();
                }
            });

            function validateInputs() {
                let isValid = true;
                let errorMessages = [];

                function checkInput(id, message) {
                    let element = document.getElementById(id);
                    if (!element || element.value.trim() === "") {
                        isValid = false;
                        errorMessages.push(message);
                        element.classList.add("is-invalid");
                    } else {
                        element.classList.remove("is-invalid");
                    }
                }

                checkInput('<%= TB_Date.ClientID %>', 'Meeting Date is required.');
                checkInput('<%= TB_StartTime.ClientID %>', 'Start Time is required.');
                checkInput('<%= TB_EndTime.ClientID %>', 'End Time is required.');
                checkInput('<%= DDL_WorkRegion.ClientID %>', 'Work Region must be selected.');
                checkInput('<%= DDL_Company.ClientID %>', 'Company must be selected.');
                checkInput('<%= DDL_Department.ClientID %>', 'Department must be selected.');
                checkInput('<%= DDL_Location.ClientID %>', 'Location must be selected.');
                checkInput('<%= TB_ExactLocation.ClientID %>', 'Exact Location is required.');
                checkInput('<%= TB_CoordinatorName.ClientID %>', 'Co-Ordinator Name is required.');

                if (!isValid) {
                    showPNotify("Validation Error", errorMessages.join("<br>"), "warning");
                }

                return isValid;
            }

            function showPNotify(title, text, type) {
                new PNotify({
                    title: title,
                    text: text,
                    type: type,
                    styling: "bootstrap3",
                    delay: 3000
                });
            }
        });

        document.addEventListener("DOMContentLoaded", function () {
            // Ensure the first tab is active on load
            document.querySelectorAll(".tab-pane").forEach(div => div.classList.remove("show", "active"));
            document.getElementById("Meeting").classList.add("show", "active");
            // Attach event listeners to navigation buttons
            addEventListenerIfExists("btnsave1", "Meeting", "Attendees");
            addEventListenerIfExists("btnsave2", "Attendees", "Points");
            addEventListenerIfExists("btnsave3", "Points", "Feedback");
        });

        //function moveToNext(currentId, nextId) {
        //    let currentDiv = document.getElementById(currentId);
        //    let nextTab = document.querySelector(`a[href='#${nextId}']`);

        //    if (validateInputs(currentDiv)) {
        //        if (nextTab) {
        //            new bootstrap.Tab(nextTab).show();
        //        }
        //    } else {
        //        alert("Please fill all required fields before proceeding.");
        //    }
        //}

        function moveToNext(currentTab, nextTab) {
            var currentTabElement = document.getElementById(currentTab + "-tab");
            var nextTabElement = document.getElementById(nextTab + "-tab");

            if (currentTabElement && nextTabElement) {
                // Update hidden field BEFORE moving to the next tab
                $('#hfActiveTab').val("#" + nextTab);

                var nextTabInstance = new bootstrap.Tab(nextTabElement);
                nextTabInstance.show();
            }
        }

        function validateInputs(div) {
            let inputs = div.querySelectorAll("input[required], textarea[required], select[required]");
            return Array.from(inputs).every(input => input.value.trim() !== "");
        }

        function addEventListenerIfExists(buttonId, currentTab, nextTab) {
            var btn = document.getElementById(buttonId);
            if (btn) {
                btn.addEventListener("click", function (event) {
                    event.preventDefault();
                    moveToNext(currentTab, nextTab);
                });
            }
        }

        function updateFilePath(input, textboxId) {
            var file = input.files[0];
            if (file) {
                document.getElementById(textboxId).value = file.name;
            } else {
                document.getElementById(textboxId).value = '';
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            var attendeeTypeList = document.querySelectorAll('input[name$="rbAttendeeType"]');
            var employeeCodeField = document.getElementById("<%= txtAttendeeCode.ClientID %>");
            var employeeNameField = document.getElementById("<%= txtEmployeeName.ClientID %>");
            var addAttendeesButton = document.getElementById("<%= btnAddAttendees.ClientID %>");
            var panelDetails = document.getElementById("<%= pnlDetails.ClientID %>");

            if (!panelDetails) {
                console.error("Error: Panel 'pnlDetails' not found.");
                return;
            }

            function toggleAttendeeFields() {
                var selectedValue = document.querySelector('input[name$="rbAttendeeType"]:checked');

                if (selectedValue) {
                    panelDetails.style.display = "block"; // Show panel

                    if (selectedValue.value === "Internal") {
                        employeeCodeField.disabled = false;
                        employeeCodeField.value = "";
                        employeeNameField.readOnly = true;
                        employeeNameField.value = "";

                        employeeCodeField.addEventListener("change", function () {
                            fetchEmployeeDetails(employeeCodeField.value);
                        });
                    } else {
                        employeeCodeField.disabled = true;
                        employeeCodeField.value = "N/A"; // Mark it as not applicable
                        employeeNameField.readOnly = false;
                        employeeNameField.value = "";
                    }
                }
            }

            function fetchEmployeeDetails(employeeCode) {
                if (employeeCode.trim() !== "") {
                    $.ajax({
                        type: "POST",
                        url: "csm_massmeeting_record.aspx/GetEmployeeDetails",
                        data: JSON.stringify({ empCode: employeeCode }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var details = response.d;

                            if (details.EmployeeName !== "Not Found") {
                                document.getElementById("<%= txtEmployeeName.ClientID %>").value = details.EmployeeName;
                                document.getElementById("<%= txtdes.ClientID %>").value = details.Designation;
                                document.getElementById("<%= txtgatepassno.ClientID %>").value = details.GatePassNo;

                                showNotification("Success", "Employee details fetched successfully!", "success");
                            } else {
                                showNotification("Error", "Employee Code not found!", "error");
                                document.getElementById("<%= txtEmployeeName.ClientID %>").value = "";
                                document.getElementById("<%= txtdes.ClientID %>").value = "";
                                document.getElementById("<%= txtgatepassno.ClientID %>").value = "";
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Error fetching employee details:", error);
                            showNotification("Error", "An error occurred while fetching employee details.", "error");
                        }
                    });
                }
            }

            function validateAttendeeForm(event) {
                event.preventDefault();
                var selectedValue = document.querySelector('input[name$="rbAttendeeType"]:checked');

                if (!selectedValue) {
                    showNotification("Error", "Please select Attendee Type (Internal/External)", "error");
                    return;
                }

                if (selectedValue.value === "Internal") {
                    if (employeeCodeField.value.trim() === "") {
                        showNotification("Error", "Employee Code is required for Internal attendees!", "error");
                        return;
                    }

                    if (employeeNameField.value.trim() === "") {
                        showNotification("Error", "Employee Name not fetched. Please enter a valid Employee Code!", "error");
                        return;
                    }
                } else {
                    if (employeeNameField.value.trim() === "") {
                        showNotification("Error", "Employee Name is required for External attendees!", "error");
                        return;
                    }
                }

                showNotification("Success", "Attendee added successfully!", "success");
            }

            if (attendeeTypeList.length > 0) {
                attendeeTypeList.forEach(function (radio) {
                    radio.addEventListener("change", toggleAttendeeFields);
                });
            } else {
                console.error("Error: RadioButtonList 'rbAttendeeType' not found.");
            }

            if (addAttendeesButton) {
                addAttendeesButton.addEventListener("click", validateAttendeeForm);
            } else {
                console.error("Error: Button 'btnAddAttendees' not found.");
            }
        });

        function addAttendee() {
            var attendeeType = document.querySelector('input[name$="rbAttendeeType"]:checked');
            if (!attendeeType) {
                showNotification("Error", "Please select Attendee Type", "error");
                return;
            }

            var empCode = document.getElementById("<%= txtAttendeeCode.ClientID %>").value.trim();
            var empName = document.getElementById("<%= txtEmployeeName.ClientID %>").value.trim();
            var designation = document.getElementById("<%= txtdes.ClientID %>").value.trim();
            var gatePassNo = document.getElementById("<%= txtgatepassno.ClientID %>").value.trim();
            var imagePath = "default.png"; // Modify as needed

            if (attendeeType.value === "Internal" && empCode === "") {
                showNotification("Error", "Please enter Employee Code", "error");
                return;
            }
            if (empName === "") {
                showNotification("Error", "Employee Name cannot be empty", "error");
                return;
            }

            $.ajax({
                type: "POST",
                url: "csm_massmeeting_record.aspx/AddAttendee",
                data: JSON.stringify({
                    attendeeType: attendeeType.value,
                    empCode: empCode,
                    empName: empName,
                    designation: designation,
                    gatePassNo: gatePassNo
                    //imagePath: imagePath
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    showNotification("Success", "Attendee added successfully!", "success");
                    updateGridView(response.d);
                    clearAttendeeForm();
                    resetAttendeeSelection();
                },
                error: function (xhr, status, error) {
                    console.error("Error adding attendee:", error);
                    showNotification("Error", "An error occurred while adding attendee.", "error");
                }
            });
        }

        function clearAttendeeForm() {
            document.getElementById("<%= txtAttendeeCode.ClientID %>").value = "";
            document.getElementById("<%= txtEmployeeName.ClientID %>").value = "";
            document.getElementById("<%= txtdes.ClientID %>").value = "";
            document.getElementById("<%= txtgatepassno.ClientID %>").value = "";
        }

        function resetAttendeeSelection() {
            var panelDetails = document.getElementById("<%= pnlDetails.ClientID %>");
            panelDetails.style.display = "none"; // Hide panel

            var attendeeTypeRadios = document.querySelectorAll('input[name$="rbAttendeeType"]');
            attendeeTypeRadios.forEach(radio => radio.checked = false); // Uncheck both options
        }


        function updateGridView(attendees) {
            var grid = document.getElementById("<%= gvAttendees.ClientID %>");

            if (!grid) {
                console.error("Error: GridView 'gvAttendees' not found.");
                return;
            }

            // Find the <table> and insert rows into its <tbody>
            var tbody = grid.getElementsByTagName("tbody")[0];
            if (!tbody) {
                console.error("Error: GridView does not have a <tbody>.");
                return;
            }

            tbody.innerHTML = ""; // Clear existing rows

            attendees.forEach(function (attendee) {
                var row = "<tr>" +
                    "<td>" + attendee.EmployeeOrNot + "</td>" +
                    "<td>" + attendee.AttendeeType + "</td>" +
                    "<td>" + attendee.EmployeeName + "</td>" +
                    "<td>" + attendee.AttendeeCode + "</td>" +
                    "<td>" + attendee.GatePassNo + "</td>" +
                    "<td>" + attendee.Designation + "</td>" +
                    //"<td><img src='" + attendee.ImagePath + "' width='50' height='50'/></td>" +
                    "</tr>";

                tbody.innerHTML += row;
            });
        }


        function refreshGridView() {
            $.ajax({
                type: "POST",
                url: "csm_massmeeting_record.aspx/GetAttendees",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    updateGridView(response.d);
                },
                error: function (xhr, status, error) {
                    console.error("Error refreshing GridView:", error);
                    showNotification("Error", "Failed to refresh attendee list.", "error");
                }
            });
        }

        function showNotification(title, message, type) {
            new PNotify({
                title: title,
                text: message,
                type: type,
                styling: 'bootstrap3',
                delay: 3000
            });
        }

        document.addEventListener("DOMContentLoaded", function () {
            var btnSave2 = document.getElementById("<%= btnsave2.ClientID %>");
            if (btnSave2) {
                btnSave2.addEventListener("click", function (event) {
                    var gridView = document.getElementById("<%= gvAttendees.ClientID %>");
                    if (!gridView || gridView.rows.length <= 1) { // Checking if at least one attendee is added
                        showNotification("Error", "Please add at least one attendee before proceeding.", "error");
                        event.preventDefault(); // Prevent default action if validation fails
                        return;
                    }
                    moveToNext('currentTabId', 'nextTabId'); // Replace with actual tab IDs
                });
                } else {
                    console.error("Error: Button 'btnsave2' not found.");
                }
        });

            function validateAttendeesBeforeSave() {
                var table = document.getElementById('<%= gvAttendees.ClientID %>'); // Get the GridView table
                var rowCount = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr").length;

                if (rowCount === 0) {
                    new PNotify({
                        title: 'Error',
                        text: 'Please add at least one attendee before saving.',
                        type: 'error',
                        styling: 'bootstrap3',
                        delay: 3000
                    });
                    return false; // Prevent form submission
                }
    
                return true; // Allow form submission
            }


            function fetchEmployeeName() {
                var empCode = document.getElementById('<%= txtPointBy.ClientID %>').value;

                if (empCode.trim() !== "") {
                    // Simulate an AJAX call
                    setTimeout(function () {
                        document.getElementById('<%= txtPointByName.ClientID %>').value = "Employee Name"; // Replace with actual name from DB
                    }, 500);
                }
            }

            function openAgendaPopup() {
                $('#agendaModal').modal('show'); // Open the Bootstrap modal
            }

            function saveNewAgendaTitle() {
                var newTitle = document.getElementById("txtNewAgendaTitle").value.trim();

                if (newTitle === "") {
                    alert("Please enter an agenda title.");
                    return;
                }

                // Get dropdown list
                var ddlAgenda = document.getElementById('<%= ddlAgendaTitle.ClientID %>');

                // Check if the title already exists
                for (var i = 0; i < ddlAgenda.options.length; i++) {
                    if (ddlAgenda.options[i].value === newTitle) {
                        alert("Agenda title already exists.");
                        return;
                    }
                }

                // Add new option
                var newOption = document.createElement("option");
                newOption.text = newTitle;
                newOption.value = newTitle;
                ddlAgenda.add(newOption);

                // Select the newly added item
                ddlAgenda.value = newTitle;

                // Close the modal
                $('#agendaModal').modal('hide');
            }

            function closeAgendaPopup() {
                $('#agendaModal').modal('hide'); // Close the Bootstrap modal
            }

            // Toggle input fields based on selection
            function toggleMemberType(type) {
                if (type === "Internal") {
                    document.getElementById("divEmpCode").style.display = "block";
                    document.getElementById("<%= txtPointBy.ClientID %>").value = ""; // Clear previous data
                    document.getElementById("<%= txtPointByName.ClientID %>").value = "";
                } else {
                    document.getElementById("divEmpCode").style.display = "none";
                    document.getElementById("<%= txtPointBy.ClientID %>").value = ""; // Clear employee code
                    document.getElementById("<%= txtPointByName.ClientID %>").value = ""; // Allow manual entry
                }
            }

            function fetchEmployeeNameForPanel3() {
                var empCode = document.getElementById("<%= txtPointBy.ClientID %>").value.trim();
                if (empCode === "") {
                    document.getElementById("<%= txtPointByName.ClientID %>").value = "";
                    return;
                }
                fetch('csm_massmeeting_record.aspx/GetEmployeeName', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ empCode: empCode })
                })
                .then(response => response.json())
                .then(data => {
                    document.getElementById("<%= txtPointByName.ClientID %>").value = data.d;
                })
            .catch(error => console.error('Error:', error));
            }

            function uploadFile() {
                var fileInput = document.getElementById("fuPhoto");
                var file = fileInput.files[0];

                if (!file) {
                    alert("Please select a file to upload.");
                    return;
                }

                var formData = new FormData();
                formData.append("file", file);

                var xhr = new XMLHttpRequest();
                xhr.open("POST", "csm_massmeeting_record.aspx/UploadFile", true);
                xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");

                xhr.onload = function () {
                    if (xhr.status == 200) {
                        var response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            // Show preview
                            document.getElementById("previewImage").src = response.filePath;
                            document.getElementById("previewImage").style.display = "block";
                        } else {
                            alert("Error: " + response.message);
                        }
                    }
                };

                xhr.send(formData);
            }

            function previewFile() {
                var fileInput = document.getElementById('<%= fuPhoto.ClientID %>');
            var previewImage = document.getElementById('<%= previewImage.ClientID %>');

            if (fileInput.files && fileInput.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    previewImage.src = e.target.result;
                    previewImage.style.display = "block";
                };

                reader.readAsDataURL(fileInput.files[0]);
            }
        }

        function clearAgendaInputs() {
            document.getElementById("<%= ddlAgendaTitle.ClientID %>").selectedIndex = 0;
            document.getElementById("<%= txtAgendaDesc.ClientID %>").value = "";
            document.getElementById("<%= txtPointBy.ClientID %>").value = "";
            document.getElementById("<%= txtPointByName.ClientID %>").value = "";
            document.getElementById("<%= ddlDiscussionTime.ClientID %>").selectedIndex = 0;
        }

        // Call this function after postback using ASP.NET `onClientClick`
        document.addEventListener("DOMContentLoaded", function () {
            clearAgendaInputs();
        });
    </script>
</asp:Content>
