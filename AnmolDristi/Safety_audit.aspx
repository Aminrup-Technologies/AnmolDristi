<%@ Page Title="CSM | Safety Audit" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Safety_audit.aspx.cs" Inherits="AnmolDristi.Safety_audit" %>

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
            margin-right: 15px;
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
                                            <asp:RequiredFieldValidator ID="rfvDepartment" runat="server" ControlToValidate="txtDepartment" ErrorMessage="Department is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Section -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblSection" runat="server" Text="Section:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtSection" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Section"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvSection" runat="server" ControlToValidate="txtSection" ErrorMessage="Section is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                                ControlToValidate="txtDate" ErrorMessage="Date is required." ForeColor="Red" Display="Dynamic">
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
                                            <asp:RequiredFieldValidator ID="rfvContractorVendorCode" runat="server" ControlToValidate="txtContractorVendorCode" ErrorMessage="Contractor Vendor Code is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblTotalContractorPeople" runat="server" Text="Total Contractor People:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtTotalContractorPeople" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Number" Placeholder="Enter Total Contractor People"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvTotalContractorPeople" runat="server" ControlToValidate="txtTotalContractorPeople" ErrorMessage="Total Contractor People is required." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>



                                <!-- Team member section -->

                                <!-- Team member section -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-6">
                                            <asp:Label ID="Lbl_EmployeeType" runat="server" Text="Select Member Type : " ForeColor="Blue" Font-Bold="true"></asp:Label>

                                            <!-- Move the main radio button beside Own Employee -->
                                            <label>
                                                <asp:RadioButton ID="rbOwnEmployee" runat="server" GroupName="EmployeeType" onclick="toggleFields()" ClientIDMode="Static" />
                                                Own Employee
                                            </label>

                                            <!-- Move the other radio button beside External Member -->
                                            <label>
                                                <asp:RadioButton ID="rbExternalMember" runat="server" GroupName="EmployeeType" onclick="toggleFields()" ClientIDMode="Static" />
                                                External Member
                                            </label>

                                        </div>

                                        <!-- Employee Code Input -->
                                        <div id="employeeCodeDiv" style="display: none;">
                                            <asp:Label ID="lblEmployeeCode" runat="server" Text="Enter Vendor Code" Font-Bold="true"></asp:Label>
                                            <asp:TextBox ID="txtEmployeeCode" runat="server" CssClass="form-control form-control-sm" ClientIDMode="Static" onkeyup="fetchEmployeeName()"></asp:TextBox>
                                            <label id="lblEmployeeName" style="color: green; font-weight: bold;"></label>
                                        </div>

                                        <!-- External Member Name Input -->
                                        <div id="externalMemberDiv" style="display: none;">
                                            <asp:Label ID="lblExternalName" runat="server" Text="Enter Name" Font-Bold="true"></asp:Label>
                                            <asp:TextBox ID="txtExternalName" runat="server" CssClass="form-control form-control-sm" ClientIDMode="Static"></asp:TextBox>
                                        </div>

                                        <!-- Add Button -->
                                        <button type="button" class="btn btn-primary btn-sm mt-2" onclick="addMember()">Add Member</button>
                                    </div>
                                </div>



                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="mb-12">
                                            <h4 class="mt-6">Added Members</h4>
                                            <table id="membersGrid" class="col-lg-12 table table-bordered table-responsive">
                                                <tr>
                                                    <th>SL</th>
                                                    <th>Type of Employee</th>
                                                    <th>Vendor Code</th>
                                                    <th>Employee Name</th>
                                                </tr>
                                            </table>
                                        </div>
                                        <button type="button" class="btn btn-success btn-sm mt-2" onclick="saveMembersToDB()">Save Members</button>
                                    </div>
                                </div>


                                <script>
                                    var membersList = [];
                                    function toggleFields() {
                                        var isOwnEmployee = document.getElementById('<%= rbOwnEmployee.ClientID %>').checked;
                                        document.getElementById('employeeCodeDiv').style.display = isOwnEmployee ? 'block' : 'none';
                                        document.getElementById('externalMemberDiv').style.display = isOwnEmployee ? 'none' : 'block';
                                    }



                                    function fetchEmployeeName() {
                                        var empCode = document.getElementById('<%= txtEmployeeCode.ClientID %>').value.trim();
                                        if (empCode === "") {
                                            document.getElementById('lblEmployeeName').innerText = "";
                                            return;
                                        }

                                        if (typeof PageMethods !== "undefined") {
                                            PageMethods.GetEmployeeName(empCode, function (response) {
                                                document.getElementById('lblEmployeeName').innerText = response ? "Employee Name: " + response : "Employee not found.";
                                                if (!response) {
                                                    showNotification("Warning", "Employee not found!", "warning");
                                                }
                                            }, function (error) {
                                                console.error("Error fetching employee name:", error);
                                                showNotification("Error", "Failed to fetch employee name.", "error");
                                            });
                                        } else {
                                            console.error("PageMethods is not enabled.");
                                            showNotification("Error", "PageMethods is not enabled.", "error");
                                        }
                                    }



                                    function addMember() {
                                        var type = document.getElementById('<%= rbOwnEmployee.ClientID %>').checked ? "Own Employee" : "External Member";
                                        var empCode = document.getElementById('<%= txtEmployeeCode.ClientID %>').value.trim();
                                        var empName = document.getElementById('<%= rbOwnEmployee.ClientID %>').checked ? document.getElementById('lblEmployeeName').innerText.replace("Employee Name: ", "").trim() : document.getElementById('<%= txtExternalName.ClientID %>').value.trim();

                                        if (type === "Own Employee" && (empCode === "" || empName === "")) {
                                            showNotification("Warning", "Please enter a valid Employee Code.", "warning");
                                            return;
                                        }
                                        if (type === "External Member" && empName === "") {
                                            showNotification("Warning", "Please enter the Name for the Internal / External Member.", "warning");
                                            return;
                                        }

                                        membersList.push({ type: type, code: empCode, name: empName });
                                        updateGridView();

                                        document.getElementById('<%= txtEmployeeCode.ClientID %>').value = "";
                                        document.getElementById('lblEmployeeName').innerText = "";
                                        document.getElementById('<%= txtExternalName.ClientID %>').value = "";

                                        showNotification("Success", "Member added successfully!", "success");
                                    }

                                    function updateGridView() {
                                        var grid = document.getElementById("membersGrid");
                                        grid.innerHTML = "<tr><th>SL</th><th>Type of Employee</th><th>Employee Code</th><th>Employee Name</th><th>Action</th></tr>";

                                        membersList.forEach((member, index) => {
                                            grid.innerHTML += `<tr>
                    <td>${index + 1}</td>
                    <td>${member.type}</td>
                    <td>${member.code}</td>
                    <td>${member.name}</td>
                    <td><button class="btn btn-danger btn-sm" onclick="removeMember(${index})">Remove</button></td>
                </tr>`;
                                        });
                                    }



                                    function removeMember(index) {
                                        membersList.splice(index, 1);
                                        updateGridView();
                                        showNotification("Info", "Member removed successfully!", "info");
                                    }

                                    function saveMembersToDB() {
                                        if (membersList.length === 0) {
                                            showNotification("error", "No members to save!");
                                            return;
                                        }

                                        var internalEmployees = [];
                                        var externalMembers = [];

                                        membersList.forEach(member => {
                                            if (member.type === "Own Employee") {
                                                internalEmployees.push(member.code);
                                            } else {
                                                externalMembers.push(member.name);
                                            }
                                        });

                                        var dataToSend = {
                                            internalEmployeesCSV: internalEmployees.join(","),
                                            externalMembersCSV: externalMembers.join(",")
                                        };

                                        if (typeof PageMethods !== "undefined") {
                                            PageMethods.SaveMembers(dataToSend.internalEmployeesCSV, dataToSend.externalMembersCSV, function (response) {
                                                showNotification("success", response);
                                                membersList = [];
                                                updateGridView();
                                            }, function (error) {
                                                console.error("Error saving members:", error);
                                                showNotification("error", "Error saving members.");
                                            });
                                        } else {
                                            console.error("PageMethods is not enabled.");
                                            showNotification("error", "PageMethods is not enabled.");
                                        }
                                    }


                                    function showNotification(title, text, type) {
                                        new PNotify({
                                            title: title,
                                            text: text,
                                            type: type,
                                            styling: 'bootstrap3',
                                            delay: 2000 // Auto-hide after 2 seconds
                                        });
                                    }



                                </script>





                                <table class="table table-bordered" id="observationTable">
                                    <tr>
                                        <td><b>Description:</b></td>
                                        <td>
                                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>Good Citizens</b></td>
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>No. of Violations</b></td>
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>Severity</b></td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-control form-control-sm rounded">
                                                <asp:ListItem Text="Select Severity Level" Value="" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="Untidy area minor issues sets poor example" Value="Untidy area minor issues sets poor example"></asp:ListItem>
                                                <asp:ListItem Text="Restricted access, Unacceptable trash, Disorderly" Value="Restricted access, Unacceptable trash, Disorderly"></asp:ListItem>
                                                <asp:ListItem Text="Rule or procedure Violation, Potential injury" Value="Rule or procedure Violation, Potential injury"></asp:ListItem>
                                                <asp:ListItem Text="Unsafe condition, Serious injury potential" Value="Unsafe condition, Serious injury potential"></asp:ListItem>
                                                <asp:ListItem Text="Immediate serious injury potential, Stop activity" Value="Immediate serious injury potential, Stop activity"></asp:ListItem>
                                                <asp:ListItem Text="Immediately and correct" Value="Immediately and correct"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td><b>Violation X Severity</b></td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-control form-control-sm rounded">
                                                <asp:ListItem Text="Select Severity Level" Value="" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="Untidy area minor issues sets poor example" Value="Untidy area minor issues sets poor example"></asp:ListItem>
                                                <asp:ListItem Text="Restricted access, Unacceptable trash, Disorderly" Value="Restricted access, Unacceptable trash, Disorderly"></asp:ListItem>
                                                <asp:ListItem Text="Rule or procedure Violation, Potential injury" Value="Rule or procedure Violation, Potential injury"></asp:ListItem>
                                                <asp:ListItem Text="Unsafe condition, Serious injury potential" Value="Unsafe condition, Serious injury potential"></asp:ListItem>
                                                <asp:ListItem Text="Immediate serious injury potential, Stop activity" Value="Immediate serious injury potential, Stop activity"></asp:ListItem>
                                                <asp:ListItem Text="Immediately and correct" Value="Immediately and correct"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>






                                    <tr>
                                        <td><b>4 &5 </b></td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList5" runat="server" CssClass="form-control form-control-sm rounded">
                                                <asp:ListItem Text="Select Severity Level" Value="" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="Untidy area minor issues sets poor example" Value="Untidy area minor issues sets poor example"></asp:ListItem>
                                                <asp:ListItem Text="Restricted access, Unacceptable trash, Disorderly" Value="Restricted access, Unacceptable trash, Disorderly"></asp:ListItem>
                                                <asp:ListItem Text="Rule or procedure Violation, Potential injury" Value="Rule or procedure Violation, Potential injury"></asp:ListItem>
                                                <asp:ListItem Text="Unsafe condition, Serious injury potential" Value="Unsafe condition, Serious injury potential"></asp:ListItem>
                                                <asp:ListItem Text="Immediate serious injury potential, Stop activity" Value="Immediate serious injury potential, Stop activity"></asp:ListItem>
                                                <asp:ListItem Text="Immediately and correct" Value="Immediately and correct"></asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="DropDownList2" InitialValue="" ErrorMessage="Please select a Severity Level." ForeColor="Red" Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td><b>Unsafe Act Conditions</b></td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList6" runat="server" CssClass="form-control form-control-sm rounded">
                                                <asp:ListItem Text="Select Severity Level" Value="" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="Untidy area minor issues sets poor example" Value="Untidy area minor issues sets poor example"></asp:ListItem>
                                                <asp:ListItem Text="Restricted access, Unacceptable trash, Disorderly" Value="Restricted access, Unacceptable trash, Disorderly"></asp:ListItem>
                                                <asp:ListItem Text="Rule or procedure Violation, Potential injury" Value="Rule or procedure Violation, Potential injury"></asp:ListItem>
                                                <asp:ListItem Text="Unsafe condition, Serious injury potential" Value="Unsafe condition, Serious injury potential"></asp:ListItem>
                                                <asp:ListItem Text="Immediate serious injury potential, Stop activity" Value="Immediate serious injury potential, Stop activity"></asp:ListItem>
                                                <asp:ListItem Text="Immediately and correct" Value="Immediately and correct"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>

                                <button type="button" id="btnAddObservation" class="btn btn-primary">Add More Observation</button>

                                <script>
                                    document.getElementById("btnAddObservation").addEventListener("click", function () {
                                        var table = document.getElementById("observationTable");
                                        var clone = table.cloneNode(true);
                                        document.body.appendChild(clone);
                                    });
                                </script>





                                <%--                                    <tr>
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
