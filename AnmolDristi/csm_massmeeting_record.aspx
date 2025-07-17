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
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />

     <div class="right_col" role="main">
 <div class="container">
     <div class="page-title">
         <div class="title_left" style="text-align: center;">
             <asp:Label ID="heading" runat="server" CssClass="h5 text-center font-weight-bold text-success" Text="MASS MEETING" />
         </div>
     </div>
     <div class="row">
         <div class="col-md-12 col-sm-12  ">
             <div class="x_panel">
                 <div class="x_title">
                     <h2 style="text-align: left; padding-left: 20px; font-weight: bold;" class="text-success">ATS/DOC/MM/0010 || REV 00 || EFFT DATE- 19/12/18</h2>
                     <ul class="nav navbar-right panel_toolbox">
                         <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                     </ul>

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


                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lbl_TB_Photo" runat="server" AssociatedControlID="TB_Photo" Text="Photo" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                                <div class="input-group-sm">
                                                    <asp:FileUpload ID="TB_Photo" runat="server" />
                                                    <asp:Label ID="Lbl_SavedPhoto" runat="server" Visible="false" EnableViewState="true"></asp:Label>
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

                                    <!-- Attendee Tab Start -->

                                    <div class="tab-pane fade" id="Attendees">
                                    <asp:UpdatePanel ID="UpdatePanelGrid" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>

                                            <!-- Attendee Type Selection -->
                                            <div class="col-md-6">
                                                <div class="mb-6">
                                                    <asp:Label ID="lbl_rbAttendeeType" runat="server" AssociatedControlID="rbAttendeeType"
                                                        Text="Attendee Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
                                                    <asp:RequiredFieldValidator ID="RFV_rbAttendeeType" runat="server"
                                                        ErrorMessage="Select any option" ValidationGroup="add2" ControlToValidate="rbAttendeeType"
                                                        Display="Dynamic" ForeColor="Red" />
                                                    <div class="input-group-sm">
                                                        <asp:RadioButtonList ID="rbAttendeeType" runat="server" RepeatDirection="Horizontal"
                                                            RepeatLayout="Table" RepeatColumns="2"
                                                              ValidationGroup="add2">
                                                            <asp:ListItem Text="Internal" Value="Internal" />
                                                            <asp:ListItem Text="External" Value="External" />
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Attendee Details Panel -->
                                            <asp:Panel ID="pnlDetails" runat="server" Visible="true">
                                                <div class="col-md-6">
                                                    <div class="mb-6">
                                                        <asp:Label ID="lbl_txtAttendeeCode" runat="server" AssociatedControlID="txtAttendeeCode"
                                                            Text="Attendee Code" ForeColor="Blue" Font-Bold="true" />
                                                        <asp:RequiredFieldValidator ID="RFV_txtAttendeeCode" runat="server" ErrorMessage="Attendee Code is Required."
                                                            ControlToValidate="txtAttendeeCode" ValidationGroup="add2" Display="Dynamic" ForeColor="Red" />
                                                        <asp:RegularExpressionValidator ID="REV_txtAttendeeCode" runat="server" ControlToValidate="txtAttendeeCode"
                                                            ForeColor="Red" ErrorMessage="AlphaNumeric Only" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$"
                                                            Display="Dynamic" ValidationGroup="add2" />
                                                        <div class="input-group-sm">
                                                            <asp:TextBox ID="txtAttendeeCode" runat="server" CssClass="form-control form-control-sm rounded" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <asp:Label ID="lbl_txtEmployeeName" runat="server" AssociatedControlID="txtEmployeeName"
                                                            Text="Employee Name" ForeColor="Blue" Font-Bold="true" />
                                                        <asp:RequiredFieldValidator ID="RFV_txtEmployeeName" runat="server" ErrorMessage="Employee Name is Required."
                                                            ControlToValidate="txtEmployeeName" ValidationGroup="add2" Display="Dynamic" ForeColor="Red" />
                                                        <div class="input-group-sm">
                                                            <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="form-control form-control-sm rounded" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <asp:Label ID="lbl_txtdes" runat="server" AssociatedControlID="txtdes" Text="Designation"
                                                            ForeColor="Blue" Font-Bold="true" />
                                                        <asp:RequiredFieldValidator ID="RFV_txtdes" runat="server" ErrorMessage="Designation is required."
                                                            ControlToValidate="txtdes" ValidationGroup="add2" Display="Dynamic" ForeColor="Red" />
                                                        <div class="input-group-sm">
                                                            <asp:TextBox ID="txtdes" runat="server" CssClass="form-control form-control-sm rounded" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <asp:Label ID="lbl_txtgatepassno" runat="server" AssociatedControlID="txtgatepassno"
                                                            Text="Gate Pass Number" ForeColor="Blue" Font-Bold="true" />
                                                        <asp:RequiredFieldValidator ID="RFV_txtgatepassno" runat="server" ErrorMessage="GatePass No is Required."
                                                            ControlToValidate="txtgatepassno" ValidationGroup="add2" Display="Dynamic" ForeColor="Red" />
                                                        <div class="input-group-sm">
                                                            <asp:TextBox ID="txtgatepassno" runat="server" CssClass="form-control form-control-sm rounded" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>


                                            <div class="table-responsive">
                                            <asp:GridView ID="gvAttendees" runat="server" CssClass="table table-striped table-hover table-bordered table-sm" ClientIDMode="Static"
                                                        AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" Width="100%" DataKeyNames="ID" OnRowCommand="gvAttendees_RowCommand" ChildrenAsTriggers="true">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Attendee Type">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblAttendeeType" runat="server" Text='<%# Eval("Attendee_Type") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Attendee Code">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblAttendeeCode" runat="server" Text='<%# Eval("AttendeeCode") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Employee Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblEmployeeName" runat="server" Text='<%# Eval("EmployeeName") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Designation">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDesignation" runat="server" Text='<%# Eval("Designation") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Gate Pass No">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblGatePassNo" runat="server" Text='<%# Eval("Gate_passno") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Actions">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="EditAttendee" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CssClass="btn btn-sm btn-primary" />
                                                                <asp:LinkButton ID="lnkDelete" runat="server"
                                                                                Text="Delete"
                                                                                CommandName="DeleteAttendee"
                                                                                CommandArgument='<%# ((GridViewRow)Container).RowIndex %>'
                                                                                CssClass="btn btn-sm btn-danger"
                                                                                OnClientClick="return confirm('Are you sure you want to delete this attendee?');" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                              </div>



                                            <!-- Hidden button for manual partial postback trigger -->
                                            <asp:Button ID="btnRefreshGrid" runat="server" OnClick="btnRefreshGrid_Click" Style="display: none" />

                                            <!-- Save & Proceed button -->
                                            <div class="col-md-3">
                                                <div class="mb-3">
                                                    <asp:Label ID="lbl_btnsave2" runat="server" AssociatedControlID="btnsave2"
                                                        Text="Click to Save" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
                                                    <div class="input-group">
                                                        <asp:Button ID="btnsave2" runat="server" Text="Save & proceed" CssClass="btn btn-success"
                                                              OnClick="btnsave2_Click" ValidationGroup="add2"/>
                                                        <asp:Label ID="lbl_btnsave22" runat="server" ForeColor="Green" />
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:HiddenField ID="HiddenField_AttendeeId" runat="server" />
                                        </ContentTemplate>
                                        <%--<Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="gvAttendees" EventName="RowCommand" />
                                        </Triggers>--%>
                                        
                                    </asp:UpdatePanel>
                                    
                                        </div>




                                    <div class="tab-pane fade" id="Points">
                                    <asp:UpdatePanel ID="upMOM" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>

                                                    <div class="row">

                                                        <!-- Agenda Title -->
                                                        <div class="col-md-4 mb-3">
                                                            <asp:Label ID="lblAgendaTitle" runat="server" Text="Agenda Title" ForeColor="Blue" Font-Bold="true" AssociatedControlID="ddlAgendaTitle" />
                                                            <asp:DropDownList ID="ddlAgendaTitle" runat="server" CssClass="form-control form-control-sm rounded" OnSelectedIndexChanged="ddlAgendaTitle_SelectedIndexChanged" AutoPostBack="true" />
                                                            <asp:RequiredFieldValidator ID="rfvAgendaTitle" runat="server" ControlToValidate="ddlAgendaTitle"
                                                                InitialValue="" ErrorMessage="Please Select Agenda Title." ForeColor="Red" Display="Dynamic" ValidationGroup="momVal" />
                                                        </div>


                                                        <div class="col-md-4 mb-3">
                                                            <asp:Panel ID="pnlOtherAgenda" runat="server" Visible="false">
                                                                <asp:Label ID="lblOtherAgenda" runat="server" Text="Other Agenda" ForeColor="Blue" Font-Bold="true" AssociatedControlID="txtOtherAgenda" />
                                                                <asp:TextBox ID="txtOtherAgenda" runat="server" CssClass="form-control form-control-sm rounded" />
                                                                <asp:RequiredFieldValidator ID="rfvOtherAgenda" runat="server" ControlToValidate="txtOtherAgenda"
                                                                    ErrorMessage="Please enter other agenda." ForeColor="Red" Display="Dynamic"
                                                                    ValidationGroup="momVal" Enabled="false" />
                                                            </asp:Panel>
                                                        </div>
                                                   </div>


                                                    <div class="row">
                                                        <!-- Employee Type -->
                                                        <div class="col-md-3 mb-3">
                                                            <asp:Label ID="lblEmpType" runat="server" Text="Employee Type" ForeColor="Blue" Font-Bold="true" />
                                                            <asp:RadioButtonList ID="rblEmpType" runat="server" RepeatDirection="Horizontal" CssClass="form-check-group ms-3 mt-2 d-flex align-items-center">
                                                                <asp:ListItem Text="Internal" Value="Internal" />
                                                                <asp:ListItem Text="External" Value="External" />
                                                            </asp:RadioButtonList>
                                                            <asp:RequiredFieldValidator 
                                                                ID="rfvEmpType" 
                                                                runat="server" 
                                                                ControlToValidate="rblEmpType"
                                                                InitialValue=""
                                                                ErrorMessage="Please select employee type."
                                                                ForeColor="Red"
                                                                ValidationGroup="momVal"
                                                                Display="Dynamic" />
                                                        </div>


                                                         <!-- Point Raised By -->
                                                          <div class="col-md-4 mb-3">
                                                              <asp:Label ID="lblPointBy" runat="server" Text="Point Raised By" ForeColor="Blue" Font-Bold="true" AssociatedControlID="txtPointBy" />
                                                               <asp:TextBox ID="txtPointBy" runat="server" CssClass="form-control form-control-sm rounded" onBlur="fetchEmployeeNameForPanel3();" />

                                                          </div>


                                                        <!-- Employee Name -->
                                                        <div class="col-md-4 mb-3">
                                                            <asp:Label ID="lblEmpName" runat="server" Text="Employee Name" ForeColor="Blue" Font-Bold="true" AssociatedControlID="txtEmpName" />
                                                            <asp:TextBox ID="txtEmpName" runat="server" CssClass="form-control form-control-sm rounded" />
                                                            <asp:RequiredFieldValidator 
                                                                ID="RfvtxtEmpName" 
                                                                runat="server" 
                                                                ControlToValidate="txtEmpName"
                                                                InitialValue=""
                                                                ErrorMessage="Please Enter Employee Name."
                                                                ForeColor="Red"
                                                                ValidationGroup="momVal"
                                                                Display="Dynamic" />
                                                        </div>
                                                   </div>

                                                    <div class="row">
                                                        <!-- Description -->
                                                        <div class="col-md-6 mb-3">
                                                            <asp:Label ID="lblDescription" runat="server" Text="Description" ForeColor="Blue" Font-Bold="true" AssociatedControlID="txtDescription" />
                                                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="3" />
                                                            <asp:RequiredFieldValidator
                                                                ID="RFVtxtDescription"
                                                                runat="server"
                                                                ControlToValidate="txtDescription" 
                                                                InitialValue="" 
                                                                ErrorMessage="Please Enter Description."
                                                                ForeColor="Red"
                                                                ValidationGroup="momVal" 
                                                                Display="Dynamic" />
                                                        </div>


                                                        
                                                        <!-- CAPA Checkbox -->
                                                            <div class="col-md-2 mb-3">
                                                                <div class="form-check">
                                                                <asp:CheckBox ID="chkGenerateCAPA" runat="server" CssClass="form-check-input" OnClick="handleCAPACheckbox(this)" />
                                                                <asp:Label AssociatedControlID="chkGenerateCAPA" runat="server" CssClass="form-check-label" Text="For generate CAPA Point, Please check the box!!" />
                                                            </div>
                                                         </div>

                                                       

                                                        <!-- Discussion Time -->
                                                        <div class="col-md-4 mb-3">
                                                            <asp:Label ID="lblTime" runat="server" Text="Discussion Time (min)" ForeColor="Blue" Font-Bold="true" AssociatedControlID="ddlTime" />
                                                            <asp:DropDownList ID="ddlTime" runat="server" CssClass="form-control form-control-sm rounded">
                                                                <asp:ListItem Text="Select" Value="" />
                                                                <asp:ListItem Text="5" Value="5" />
                                                                <asp:ListItem Text="10" Value="10" />
                                                                <asp:ListItem Text="20" Value="20" />
                                                                <asp:ListItem Text="30" Value="30" />
                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator 
                                                                    ID="rfvTime" 
                                                                    runat="server" 
                                                                    ControlToValidate="ddlTime" 
                                                                    InitialValue="" 
                                                                    ErrorMessage="Please select discussion time." 
                                                                    ForeColor="Red"
                                                                    Display="Dynamic"
                                                                    ValidationGroup="momVal" />
                                                        </div>
                                                        </div>

                                                       <div class="row">
                                                        <!-- Save Button -->
                                                            <div class="col-md-3 d-flex flex-column align-items-start mb-3">
                                                                    <asp:Label 
                                                                        ID="Label1" 
                                                                        runat="server" 
                                                                        AssociatedControlID="btnAddPoint"
                                                                        Text="Click to Save" 
                                                                        ForeColor="Blue" 
                                                                        Font-Bold="true" 
                                                                        Font-Size="Small" 
                                                                        CssClass="mb-2 text-nowrap" />

                                                            <asp:Button ID="btnAddPoint" runat="server" Text="Save" CssClass="btn btn-success btn-md"
                                                                OnClick="btnAddPoint_Click" ValidationGroup="momVal" />
                                                        </div>
                                                    </div>

                                                    <!-- GridView for saved MOM points -->
                                                    <div style="max-height: 300px; overflow: auto;">
                                                    <asp:GridView ID="gvPoints" runat="server" AutoGenerateColumns="False"
                                                        CssClass="table table-striped table-bordered table-sm mt-3"
                                                        ShowHeaderWhenEmpty="True" EmptyDataText="No points added" OnRowCommand="gvPoints_RowCommand" DataKeyNames="MOM_Id,IsCAPAGenerated">
                                                       <Columns>
                                                    <asp:TemplateField HeaderText="Point Title">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPointTitle" runat="server" Text='<%# Eval("AgendaTitle") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Employee Type">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmployeeType" runat="server" Text='<%# Eval("EmployeeType") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                     <asp:TemplateField HeaderText="Point By">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPointBy" runat="server" Text='<%# Eval("PointRaisedBy") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Employee Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEmployeeName" runat="server" Text='<%# Eval("EmployeeName") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Description">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Description") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>



                                                           <asp:TemplateField HeaderText="Generate CAPA">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkGenerateCAPA" runat="server"
                                                                                Checked='<%# Eval("IsCAPAGenerated") != DBNull.Value && Convert.ToBoolean(Eval("IsCAPAGenerated")) %>'
                                                                                Enabled="false" /> 
                                                                </ItemTemplate>
                                                            </asp:TemplateField>


                                                    

                                                    <asp:TemplateField HeaderText="Discussion Time (min)">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDiscussionTime" runat="server" Text='<%# Eval("DiscussionTime") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="text-center">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkEditPoint" runat="server" CommandName="EditPoint" CommandArgument='<%# Container.DataItemIndex %>'
                                                                CssClass="btn btn-sm btn-primary">Edit</asp:LinkButton>
                                                            <asp:LinkButton ID="lnkDeletePoint" runat="server" CommandName="DeletePoint" CommandArgument='<%# Container.DataItemIndex %>'
                                                                CssClass="btn btn-sm btn-danger ms-2">Delete</asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                    </asp:GridView>
                                                        </div>

                                                    <!-- HiddenField and Success Message -->
                                                    <asp:HiddenField ID="hfMomId" runat="server" />
                                                    <asp:Label ID="lblPointMsg" runat="server" ForeColor="Green" CssClass="mt-2" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
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


        function onEmpCodeChange() {
            var employeeCode = document.getElementById("<%= txtAttendeeCode.ClientID %>").value;
               fetchEmployeeDetails(employeeCode);
        }

        function toggleAttendeeFields() {
            var employeeCodeField = document.getElementById("<%= txtAttendeeCode.ClientID %>");
            var employeeNameField = document.getElementById("<%= txtEmployeeName.ClientID %>");
            var panelDetails = document.getElementById("<%= pnlDetails.ClientID %>");
            var selectedValue = document.querySelector('input[name$="rbAttendeeType"]:checked');


            if (!employeeCodeField || !employeeNameField || !panelDetails || !selectedValue) {
                console.warn("Required elements not found. Possibly due to UpdatePanel.");
                return;
            }

            //panelDetails.style.display = "block";

            if (selectedValue.value === "Internal") {
                employeeCodeField.disabled = false;
                employeeCodeField.value = "";
                employeeNameField.readOnly = true;
                employeeNameField.value = "";

                // Prevent duplicate bindings
                employeeCodeField.removeEventListener("change", onEmpCodeChange);
                employeeCodeField.addEventListener("change", onEmpCodeChange);
            } else {
                employeeCodeField.disabled = true;
                employeeCodeField.value = "N/A";
                employeeNameField.readOnly = false;
                employeeNameField.value = "";

                employeeCodeField.removeEventListener("change", onEmpCodeChange);
            }
        }

        Sys.Application.add_load(function () {
            var radioButtons = document.querySelectorAll('input[name$="rbAttendeeType"]');
            radioButtons.forEach(function (rb) {
                rb.addEventListener("change", toggleAttendeeFields);
            });

            //toggleAttendeeFields(); // Run it initially too
        });



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

        function validateAttendeesBeforeSave() {
            var table = document.getElementById("<%= gvAttendees.ClientID %>"); // ID is now stable
            if (!table) {
                console.error("GridView element not found.");
                return false;
            }

            var tbody = table.getElementsByTagName("tbody")[0];
            var rowCount = tbody ? tbody.getElementsByTagName("tr").length : 0;

            if (rowCount === 0 || (rowCount === 1 && tbody.rows[0].cells[0].innerText.includes("No Data Found"))) {
                new PNotify({
                    title: 'Error',
                    text: 'Please add at least one attendee before saving.',
                    type: 'error',
                    styling: 'bootstrap3',
                    delay: 3000
                });
                return false;
            }

            return true;
        }



        <%--function fetchEmployeeName() {
            var empCode = document.getElementById('<%= txtPointBy.ClientID %>').value;

            if (empCode.trim() !== "") {
                // Simulate an AJAX call
                setTimeout(function () {
                    document.getElementById('<%= txtEmpName.ClientID %>').value = "Employee Name"; // Replace with actual name from DB
                }, 500);
            }
        }--%>

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

        function toggleMemberType(type, clearFields = true) {
            var empCodeDiv = document.getElementById("divEmpCode");
            var txtPointBy = document.getElementById("<%= txtPointBy.ClientID %>");
            var txtPointByName = document.getElementById("<%= txtEmpName.ClientID %>");

            if (type === "Internal") {
                txtPointBy.disabled = false;
                if (clearFields) {
                    txtPointBy.value = "";
                    txtPointByName.value = "";
                }
            } else {
                txtPointBy.disabled = true;
                if (clearFields) {
                    txtPointBy.value = "";
                    txtPointByName.value = "";
                }
            }
        }


        Sys.Application.add_load(function () {
            var radios = document.querySelectorAll('input[name*="rblEmpType"]');
            radios.forEach(function (radio) {
                radio.addEventListener("click", function () {
                    toggleMemberType(this.value, true); // Re-bind on each partial postback
                });
            });
        });





       <%-- function fetchEmployeeNameForPanel3() {
            var empCode = document.getElementById("<%= txtPointBy.ClientID %>").value.trim();
            if (empCode === "") {
                document.getElementById("<%= txtEmpName.ClientID %>").value = "";
                return;
            }
            fetch('csm_massmeeting_record.aspx/GetEmployeeName', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ empCode: empCode })
            })
                .then(response => response.json())
                .then(data => {
                    document.getElementById("<%= txtEmpName.ClientID %>").value = data.d;
                })
                .catch(error => console.error('Error:', error));
        }--%>


        function fetchEmployeeNameForPanel3() {
            var empCode = document.getElementById("<%= txtPointBy.ClientID %>").value.trim();

            if (empCode === "") {
                document.getElementById("<%= txtEmpName.ClientID %>").value = "";
                  return;
            }

                    $.ajax({
                        type: "POST",
                        url: "csm_massmeeting_record.aspx/GetEmployeeName",
                        data: JSON.stringify({ empCode: empCode }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var empName = response.d;
                            document.getElementById("<%= txtEmpName.ClientID %>").value = empName || "";
                            if (!empName) {
                                showNotification("Info", "No employee found for this code.", "info");
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Error:", error);
                            showNotification("Error", "Failed to fetch employee name.", "error");
                        }
                    });
        }

               <%-- Sys.Application.add_load(function () {
                    var txtPointBy = document.getElementById("<%= txtPointBy.ClientID %>");
                    if (txtPointBy) {
                        txtPointBy.removeEventListener("change", fetchEmployeeNameForPanel3);
                        txtPointBy.addEventListener("change", fetchEmployeeNameForPanel3);
                    }
                });--%>





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


        $(document).ready(function () {
            $('.agenda-dropdown').change(function () {
                var selectedVal = $(this).val();
                if (selectedVal === "Other") {
                    $('.custom-agenda').show();
                } else {
                    $('.custom-agenda').hide();
                }
            });
        });


    </script>



    <script type="text/javascript">
        function handleCAPACheckbox(checkbox) {
            if (!checkbox.checked) {
                var confirmResult = confirm("Disabling CAPA may compromise corrective action tracking. Proceed at your own risk.");
                if (!confirmResult) {
                    checkbox.checked = true; // Re-check it if user cancels
                }
            }
        }
    </script>

</asp:Content>
