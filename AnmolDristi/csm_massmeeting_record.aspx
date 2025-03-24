<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="csm_massmeeting_record.aspx.cs" Inherits="AnmolDristi.csm_massmeeting_record" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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
    color: #000 ;
    border-radius: 5px;
}

      
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Mass Meeting Attendance Sheet</h3>

                </div>
            </div>
            <div id="panelMeeting" class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>ATS/DOC/MM/0010</h2>

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


                                    <%-- FIRST PANEL--%>
                                        <div class="tab-pane fade show active" id="Meeting">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_Date" runat="server" AssociatedControlID="TB_Date" Text="Date" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_TB_Date" runat="server" ErrorMessage="*" ControlToValidate="TB_Date" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_Date" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>

                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_StartTime" runat="server" AssociatedControlID="TB_StartTime" Text="Start Time" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_TB_StartTime" runat="server" ErrorMessage="*" ControlToValidate="TB_StartTime" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_StartTime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>



                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_EndTime" runat="server" AssociatedControlID="TB_EndTime" Text="End Time" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_TB_EndTime" runat="server" ErrorMessage="*" ControlToValidate="TB_EndTime" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_EndTime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>




                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_Duration" runat="server" AssociatedControlID="TB_Duration" Text="Duration" ReadOnly="true" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_Duration" runat="server" CssClass="form-control form-control-sm rounded" ReadOnly="true"></asp:TextBox>
                                                    <asp:HiddenField ID="hfDuration" runat="server" />
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-md-6">
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


                                        <div class="col-md-6">
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


                                        <div class="col-md-6">
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


                                        <div class="col-md-6">
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
                                                    <asp:TextBox ID="TB_CoordinatorName" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>


                                        <%--Button--%>
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_btnsave1" runat="server" AssociatedControlID="btnsave1" Text="Click to Save" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <div class="input-group">
                                                    <asp:Button ID="btnsave1" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="Save1" CausesValidation="true" OnClientClick="saveMeetingData(); return false;" OnClick="btnsave1_Click" />
                                                    <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>

                                                </div>
                                            </div>
                                        </div>
                                             <asp:HiddenField ID="HiddenField_MMId" runat="server" />
                                    </div>                                    


                                   <%-- <%-- SECOND PANEL--%>


                                    <div class="tab-pane fade" id="Attendees">
                                     <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_rbEmployee" runat="server" AssociatedControlID="rbEmployee" Text="Employee of this company?" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_rbEmployee" runat="server" ErrorMessage="Select any option" ValidationGroup="add2" ControlToValidate="rbEmployee" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:RadioButtonList ID="rbEmployee" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbEmployee_SelectedIndexChanged">
                                                        <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                        <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div>
                                        </div>

                                        <asp:Panel ID="pnlAttendeeType" runat="server" Visible="false">

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <asp:Label ID="lbl_rbAttendeeType" runat="server" AssociatedControlID="rbAttendeeType" Text="Attendees Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="RFV_rbAttendeeType" runat="server" ErrorMessage="Select any option" ValidationGroup="add2" ControlToValidate="rbAttendeeType" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                    <div class="input-group-sm">
                                                        <asp:RadioButtonList ID="rbAttendeeType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbAttendeeType_SelectedIndexChanged">
                                                            <asp:ListItem Text="Internal" Value="Internal"></asp:ListItem>
                                                            <asp:ListItem Text="External" Value="External"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>

                                        <asp:Panel ID="pnlDetails" runat="server" Visible="false">

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <asp:Label ID="lbl_txtAttendeeCode" runat="server" AssociatedControlID="txtAttendeeCode" Text="Ateendees Code" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="RFV_txtAttendeeCode" runat="server" ErrorMessage="*" ControlToValidate="txtAttendeeCode"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="REV_txtAttendeeCode" runat="server" ControlToValidate="txtAttendeeCode" ForeColor="Red"  ErrorMessage="AlphaNumeric Only" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" Display="Dynamic"></asp:RegularExpressionValidator>

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
                                                        <asp:Button ID="btnAddAttendees" Text="Add Attendees" runat="server" CssClass="btn btnStyle " ValidationGroup="add2" CausesValidation="true" OnClick="btnAddAttendees_Click" />
                                                         <asp:Label ID="lblMsg1" runat="server" ></asp:Label>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>

                                        <asp:Panel ID="pnlAttendeeTable" runat="server">
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <asp:GridView ID="gvAttendees" runat="server" CssClass="tableStyle" Width="100%" AutoGenerateColumns="False">
                                                        <HeaderStyle BackColor="#5F9EA0" ForeColor="Black" Font-Bold="True" />
                                                        <RowStyle BackColor="White" />
                                                        <AlternatingRowStyle BackColor="White" />
                                                        <Columns>
                                                            <asp:BoundField DataField="EmployeeOrNot" HeaderText="Employee?" />
                                                            <asp:BoundField DataField="AttendeeType" HeaderText="Attendee Type" />
                                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
                                                            <asp:BoundField DataField="AttendeeCode" HeaderText="Attendee Code" />
                                                            <asp:BoundField DataField="GatePassNo" HeaderText="Gate Pass No" />
                                                            <asp:BoundField DataField="Designation" HeaderText="Designation" />
                                                            <asp:TemplateField HeaderText="Image Preview">
                                                              <ItemTemplate>
                                                                <asp:Image ID="imgPreview" runat="server" ImageUrl='<%# Eval("ImagePath") %>' Width="50px" Height="50px" />
                                                               </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </asp:Panel>


                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_btnsave2" runat="server" AssociatedControlID="btnsave2" Text="Click to Save" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <div class="input-group">
                                                    <asp:Button ID="btnsave2" runat="server" Text="Save" CssClass="btn btn-success"   OnClick="btnsave2_Click" />
                                                    <asp:Label ID="lbl_btnsave22" runat="server" ForeColor="Green"></asp:Label>

                                                </div>
                                            </div>
                                        </div>



                                    </div>



                                    <%-- THIRD PANEL--%>

                                     <div class="tab-pane fade" id="Points">
      <div class="table-responsive">
          <div class="col-md-12">
              <div class="mb-3">
                  <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" CssClass="table table-bordered table-hover " OnRowCommand="GridView1_RowCommand">
                      <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
                      <Columns>
                          <asp:BoundField DataField="SLNO" HeaderText="SL.NO" />
                          <asp:TemplateField HeaderText="Agenda Title">
                              <ItemTemplate>
                                  <asp:Label ID="lbl_txtAgendaTitle" runat="server" AssociatedControlID="txtAgendaTitle"  ></asp:Label>
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
                                  <asp:FileUpload ID="fuPhotoBefore" runat="server" onchange="updateFilePath(this, 'txtPhotoBeforePath')"  />
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
      </div>

      <div class="col-md-3">
          <div class="mb-3">
              <asp:Label ID="lbl_btnsave3" runat="server" AssociatedControlID="btnsave3" Text="Click to Save" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
              <div class="input-group">
                  <asp:Button ID="btnsave3" runat="server" Text="Save" CssClass="btn btn-success btn-sm"  CausesValidation="true"  OnClick="btnsave3_Click" />
              </div>
          </div>
      </div>


  </div>



                                    <%-- FOURTH PANEL--%>
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
                                                    <asp:Button ID="btnsave4" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="save4" CausesValidation="true"  OnClick="btnsave4_Click" />
                                                    <asp:Label ID="lbl_btnsave44" runat="server" ForeColor="Green"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
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
    <script type="text/javascript">

        document.addEventListener("DOMContentLoaded", function () {
            // Function to calculate duration
            function calculateDuration() {
                var startTime = document.getElementById('<%= TB_StartTime.ClientID %>').value;
                    var endTime = document.getElementById('<%= TB_EndTime.ClientID %>').value;
                    var durationField = document.getElementById('<%= TB_Duration.ClientID %>');
                    var hiddenDuration = document.getElementById('<%= hfDuration.ClientID %>');

                if (startTime && endTime) {
                    var start = new Date("1970-01-01T" + startTime + "Z");
                    var end = new Date("1970-01-01T" + endTime + "Z");
                    var diff = (end - start) / 60000; // Convert ms to minutes
                    if (diff < 0) diff += 1440; // Handle cases where endTime is past midnight

                    var durationText = diff + " minutes";
                    durationField.value = durationText;
                    hiddenDuration.value = durationText; // Store value in hidden field
                }
            }

            // Attach the function to the End Time field change event
            document.getElementById('<%= TB_EndTime.ClientID %>').addEventListener("change", calculateDuration);
        });






    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  
    <script type="text/javascript">
        function calculateDuration() {
            var startTime = document.getElementById("txtStartTime").value;
            var endTime = document.getElementById("txtEndTime").value;
            var durationField = document.getElementById("txtDuration");

            if (startTime && endTime) {
                var start = new Date("1970-01-01T" + startTime);
                var end = new Date("1970-01-01T" + endTime);

                if (end > start) {
                    var duration = (end - start) / (1000 * 60); // Convert ms to minutes
                    durationField.value = duration + " minutes";
                    return true;
                } else {
                    alert("End time must be greater than start time.");
                    durationField.value = "";
                    return false;
                }
            }
            return false;
        }

        function enableNextPanel(currentBtnId, nextPanelId) {
            if (calculateDuration()) {
                var panel = document.getElementById(nextPanelId);
                if (panel) {
                    panel.style.display = "block"; // Show next panel
                }

                var currentButton = document.getElementById(currentBtnId);
                if (currentButton) {
                    currentButton.disabled = true; // Disable current Save button
                }
            }
        }
    </script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".tab-pane").forEach(div => div.classList.remove("show", "active"));
            document.getElementById("Meeting").classList.add("show", "active");

            function moveToNext(currentId, nextId, event) {
                event.preventDefault(); // Prevent form submission
                let currentDiv = document.getElementById(currentId);
                let nextDiv = document.getElementById(nextId);

                if (validateInputs(currentDiv)) {
                    let nextTab = document.querySelector(`a[href='#${nextId}']`);
                    if (nextTab) {
                        new bootstrap.Tab(nextTab).show();
                    }
                } else {
                    alert("Please fill all required fields before proceeding.");
                }
            }

            function validateInputs(div) {
                let inputs = div.querySelectorAll("input[required], textarea[required], select[required]");
                for (let input of inputs) {
                    if (!input.value.trim()) {
                        return false;
                    }
                }
                return true;
            }

            document.getElementById("btnsave1").addEventListener("click", function (event) {
                moveToNext("Meeting", "Attendees", event);
            });

            document.getElementById("btnsave2").addEventListener("click", function (event) {
                moveToNext("Attendees", "Points", event);
            });

            document.getElementById("btnsave3").addEventListener("click", function (event) {
                moveToNext("Points", "Feedback", event);
            });
        });
    </script>

    <script type="text/javascript">
        function updateFilePath(input, textboxId) {
            var file = input.files[0]; // Get the selected file
            if (file) {
                document.getElementById(textboxId).value = file.name; // Set only the filename
            } else {
                document.getElementById(textboxId).value = ''; // Clear if no file is selected
            }
        }
    </script>

</asp:Content>
