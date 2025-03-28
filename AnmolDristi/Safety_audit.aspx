<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Safety_audit.aspx.cs" Inherits="AnmolDristi.Safety_audit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <style type="text/css">
        .remove-border {
            border: none !important;
        }

        .form-label {
            font-weight: bold;
            color: blue;
            display: block;
            margin-bottom: 10px;
        }

        .col-md-4 {
            margin-bottom: 20px;
        }

        .form-control {
            margin-top: 5px;
        }


        .radio-options label {
            margin-right: 15px; /* Adds space between radio buttons */
        }
    </style>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Safety Audit REPORT</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Reference No: ATS/TSK/TPA/01 </h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">

                                <!-- Department -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblDepartment" runat="server" Text="Department:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Department"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDepartment" runat="server"
                                                ControlToValidate="txtDepartment"
                                                ErrorMessage="Department is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Section -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblSection" runat="server" Text="Section:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtSection" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Section"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvSection" runat="server"
                                                ControlToValidate="txtSection"
                                                ErrorMessage="Section is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Date -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblDate" runat="server" Text="Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDate" runat="server"
                                                ControlToValidate="txtDate"
                                                ErrorMessage="Date is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Time -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblTime" runat="server" Text="Time:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtTime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvTime" runat="server"
                                                ControlToValidate="txtTime"
                                                ErrorMessage="Time is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <!-- Contractor Vendor Code -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblContractorVendorCode" runat="server" Text="Contractor Vendor Code:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtContractorVendorCode" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Contractor Vendor Code"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvContractorVendorCode" runat="server"
                                                ControlToValidate="txtContractorVendorCode"
                                                ErrorMessage="Contractor Vendor Code is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Total Contractor People -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblTotalContractorPeople" runat="server" Text="Total Contractor People:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtTotalContractorPeople" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Number" Placeholder="Enter Total Contractor People"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvTotalContractorPeople" runat="server"
                                                ControlToValidate="txtTotalContractorPeople"
                                                ErrorMessage="Total Contractor People is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Severity Level -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblSeverityLevel" runat="server" Text="Severity Level:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:DropDownList ID="ddlSeverityLevel" runat="server" CssClass="form-control form-control-sm rounded">
                                                <asp:ListItem Text="Select Severity Level" Value="" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="Untidy area minor issues sets poor example" Value="Untidy area minor issues sets poor example"></asp:ListItem>
                                                <asp:ListItem Text="Restricted access, Unacceptable trash, Disorderly" Value="Restricted access, Unacceptable trash, Disorderly"></asp:ListItem>
                                                <asp:ListItem Text="Rule or procedure Violation, Potential injury" Value="Rule or procedure Violation, Potential injury"></asp:ListItem>
                                                <asp:ListItem Text="Unsafe condition, Serious injury potential" Value="Unsafe condition, Serious injury potential"></asp:ListItem>
                                                <asp:ListItem Text="Immediate serious injury potential, Stop activity" Value="Immediate serious injury potential, Stop activity"></asp:ListItem>
                                                <asp:ListItem Text="Immediately and correct" Value="Immediately and correct"></asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:RequiredFieldValidator ID="rfvSeverityLevel" runat="server"
                                                ControlToValidate="ddlSeverityLevel"
                                                InitialValue=""
                                                ErrorMessage="Please select a Severity Level."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Team Members Section -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <asp:Label ID="lblTeamMembers" runat="server" Text="Team Members:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div id="teamMembersContainer">
                                            <div class="d-flex align-items-center mb-2">
                                                <asp:TextBox ID="txtTeamMember1" runat="server" CssClass="form-control form-control-sm team-member-input" placeholder="Enter Team Member Name"></asp:TextBox>
                                                <button type="button" class="btn btn-primary btn-sm btn-fixed-size" onclick="addTeamMember()">Add</button>
                                                <button type="button" class="btn btn-danger btn-sm btn-fixed-size" onclick="removeTeamMember(this)">Remove</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- JavaScript for Dynamic Team Members -->
                                <script type="text/javascript">
                                    function addTeamMember() {
                                        var container = document.getElementById("teamMembersContainer");
                                        var div = document.createElement("div");
                                        div.className = "d-flex align-items-center mb-2";

                                        var input = document.createElement("input");
                                        input.type = "text";
                                        input.className = "form-control form-control-sm team-member-input";
                                        input.placeholder = "Enter Team Member Name";

                                        var addBtn = document.createElement("button");
                                        addBtn.type = "button";
                                        addBtn.className = "btn btn-primary btn-sm btn-fixed-size";
                                        addBtn.innerText = "Add";
                                        addBtn.onclick = addTeamMember;

                                        var removeBtn = document.createElement("button");
                                        removeBtn.type = "button";
                                        removeBtn.className = "btn btn-danger btn-sm btn-fixed-size";
                                        removeBtn.innerText = "Remove";
                                        removeBtn.onclick = function () {
                                            removeTeamMember(removeBtn);
                                        };

                                        div.appendChild(input);
                                        div.appendChild(addBtn);
                                        div.appendChild(removeBtn);
                                        container.appendChild(div);
                                    }

                                    function removeTeamMember(button) {
                                        var container = document.getElementById("teamMembersContainer");
                                        if (container.children.length > 1) {
                                            button.parentNode.remove();
                                        } else {
                                            alert("At least one team member is required.");
                                        }
                                    }
                                </script>

                                <!-- CSS for Styling -->
                                <style>
                                    .btn-fixed-size {
                                        width: 100px;
                                        text-align: center;
                                        font-size: 14px;
                                        padding: 5px 0;
                                    }

                                    .team-member-input {
                                        margin-right: 10px;
                                    }
                                </style>


                                <table class="table table-bordered">
                                    <tr>
                                        <td><b>Description:</b></td>
                                        <td>
                                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <%--<tr>
                                        <td><b>Select Field:</b></td>
                                        <td>
                                            <asp:DropDownList ID="ddlDescriptionFields" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="DdlDescriptionFields_SelectedIndexChanged">
                                                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                <asp:ListItem Text="Good Citizens" Value="GoodCitizens"></asp:ListItem>
                                                <asp:ListItem Text="No. of Violations" Value="NoOfViolations"></asp:ListItem>
                                                <asp:ListItem Text="Severity" Value="Severity"></asp:ListItem>
                                                <asp:ListItem Text="Violation X Severity" Value="ViolationSeverity"></asp:ListItem>
                                                <asp:ListItem Text="4 & 5" Value="FourAndFive"></asp:ListItem>
                                                <asp:ListItem Text="Unsafe Act Conditions" Value="UnsafeAct"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td><b>Good Citizens
                                        </b></td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control form-control-sm rounded">
                                                <asp:ListItem Text="Select Severity Level" Value="" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="Untidy area minor issues sets poor example" Value="Untidy area minor issues sets poor example"></asp:ListItem>
                                                <asp:ListItem Text="Restricted access, Unacceptable trash, Disorderly" Value="Restricted access, Unacceptable trash, Disorderly"></asp:ListItem>
                                                <asp:ListItem Text="Rule or procedure Violation, Potential injury" Value="Rule or procedure Violation, Potential injury"></asp:ListItem>
                                                <asp:ListItem Text="Unsafe condition, Serious injury potential" Value="Unsafe condition, Serious injury potential"></asp:ListItem>
                                                <asp:ListItem Text="Immediate serious injury potential, Stop activity" Value="Immediate serious injury potential, Stop activity"></asp:ListItem>
                                                <asp:ListItem Text="Immediately and correct" Value="Immediately and correct"></asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DropDownList1" InitialValue="" ErrorMessage="Please select a Severity Level." ForeColor="Red" Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td><b>No. of Violations
                                        </b></td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control form-control-sm rounded">
                                                <asp:ListItem Text="Select Severity Level" Value="" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="Untidy area minor issues sets poor example" Value="Untidy area minor issues sets poor example"></asp:ListItem>
                                                <asp:ListItem Text="Restricted access, Unacceptable trash, Disorderly" Value="Restricted access, Unacceptable trash, Disorderly"></asp:ListItem>
                                                <asp:ListItem Text="Rule or procedure Violation, Potential injury" Value="Rule or procedure Violation, Potential injury"></asp:ListItem>
                                                <asp:ListItem Text="Unsafe condition, Serious injury potential" Value="Unsafe condition, Serious injury potential"></asp:ListItem>
                                                <asp:ListItem Text="Immediate serious injury potential, Stop activity" Value="Immediate serious injury potential, Stop activity"></asp:ListItem>
                                                <asp:ListItem Text="Immediately and correct" Value="Immediately and correct"></asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DropDownList2" InitialValue="" ErrorMessage="Please select a Severity Level." ForeColor="Red" Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <%--<tr>
                                        <td><b>Options:</b></td>
                                        <td>
                                            <asp:Panel ID="pnlRadioButtons" runat="server" CssClass="radio-options"></asp:Panel>
                                        </td>
                                    </tr>--%>
                                </table>



                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <div class="input-group input-group-sm">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="SubmitSafetyAudit_Click" />
                                            <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                                            <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                        </div>
                                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true" />

                                    </div>
                                </div>




                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
