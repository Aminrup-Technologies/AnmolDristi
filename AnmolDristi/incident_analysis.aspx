<%@ Page Title="Incident Analysis Report" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="incident_analysis.aspx.cs" Inherits="AnmolDristi.incident_analysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .remove-border {
            border: none !important;
        }

        .form-label {
            font-weight: bold;
            color: blue;
            display: block;
            margin-bottom: 10px; /* Adds space below the label */
        }

        .col-md-4 {
            margin-bottom: 20px; /* Adds space between rows */
        }

        .form-control {
            margin-top: 5px; /* Adds space between label and input */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>INCIDENT ANALYSIS REPORT</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Document No: SIG/CSM/AL/01 | Effective Date: 2021-10-01 | Revision No: 02</h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">





                                <!-- Incident Classification Dropdown -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblIncidentClassification" runat="server" Text="Incident Classification:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:DropDownList ID="ddlIncidentClassification" runat="server" CssClass="form-control form-control-sm rounded">
                                                <asp:ListItem Text="Select Classification" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Fatal" Value="Fatal"></asp:ListItem>
                                                <asp:ListItem Text="Lost time injury" Value="Lost time injury"></asp:ListItem>
                                                <asp:ListItem Text="Near Miss" Value="Near Miss"></asp:ListItem>
                                                <asp:ListItem Text="Property Damage" Value="Property Damage"></asp:ListItem>
                                                <asp:ListItem Text="Minor injury" Value="Minor injury"></asp:ListItem>
                                                <asp:ListItem Text="First Aids case" Value="First Aids case"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvIncidentClassification" runat="server"
                                                ControlToValidate="ddlIncidentClassification"
                                                InitialValue="0"
                                                ErrorMessage="Please select a valid incident classification."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Date of Incident -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblDateOfIncident" runat="server" Text="Date of Incident:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDateOfIncident" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Select Date" TextMode="Date"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDateOfIncident" runat="server"
                                                ControlToValidate="txtDateOfIncident"
                                                ErrorMessage="Please select a date for the incident."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Time of Incident -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblTimeOfIncident" runat="server" Text="Time of Incident:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtTimeOfIncident" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Select Time" TextMode="Time"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvTimeOfIncident" runat="server"
                                                ControlToValidate="txtTimeOfIncident"
                                                ErrorMessage="Please select a time for the incident."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Custom Validator for Date and Time -->
                                <asp:CustomValidator ID="cvIncidentDateTime" runat="server"
                                    ControlToValidate="txtDateOfIncident"
                                    ErrorMessage="Date and Time of Incident cannot be in the future."
                                    ForeColor="Red"
                                    Display="Dynamic"
                                    OnServerValidate="ValidateIncidentDateTime">
                                    
                                </asp:CustomValidator>





                                <!-- Name of Person Involved -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblPersonInvolved" runat="server" Text="Name of Person Involved:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtPersonInvolved" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Name"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvPersonInvolved" runat="server"
                                                ControlToValidate="txtPersonInvolved"
                                                ErrorMessage="Please enter the name of the person involved."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revPersonInvolved" runat="server"
                                                ControlToValidate="txtPersonInvolved"
                                                ValidationExpression="^[a-zA-Z\s]+$"
                                                ErrorMessage="Name should contain only letters and spaces."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Location -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblLocation" runat="server" Text="Location:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Location"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvLocation" runat="server"
                                                ControlToValidate="txtLocation"
                                                ErrorMessage="Please enter the location."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Department -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblDepartment" runat="server" Text="Department:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Department"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDepartment" runat="server"
                                                ControlToValidate="txtDepartment"
                                                ErrorMessage="Please enter the department."
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
                                                ErrorMessage="Please enter the section."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>



                                <!-- Witness Checkbox -->
                                <%--<div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblWitness" runat="server" Text="Any Witnesses?" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:RadioButtonList ID="rblWitness" runat="server" RepeatDirection="Horizontal" CssClass="form-control-sm">
                                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                </div>--%>

                                <!-- Witness Name (Multiple Inputs) -->
                                <%-- <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblWitnessName" runat="server" Text="Witness Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div id="witnessContainer">
                                            <asp:TextBox ID="txtWitness1" runat="server" CssClass="form-control form-control-sm rounded mb-2"></asp:TextBox>
                                        </div>
                                        <asp:Button ID="btnAddWitness" runat="server" CssClass="btn btn-primary btn-sm mt-2" Text="Add Witness" OnClientClick="addWitness(); return false;" />
                                    </div>
                                </div>--%>


                                <!-- JavaScript to Add Multiple Witness Names -->
                                <%-- <script type="text/javascript">
                                    function addWitness() {
                                        var container = document.getElementById("witnessContainer");
                                        var input = document.createElement("input");
                                        input.type = "text";
                                        input.className = "form-control form-control-sm rounded mb-2";
                                        input.placeholder = "Enter Witness Name";
                                        container.appendChild(input);
                                    }
                                </script>--%>


                                <!-- Witness Checkbox -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblWitness" runat="server" Text="Any Witnesses?" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:RadioButtonList ID="rblWitness" runat="server" RepeatDirection="Horizontal" CssClass="form-control-sm" OnChange="toggleWitnessSection();">
                                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                </div>

                                <!-- Witness Name Section (Initially Hidden) -->
                                <div class="col-md-3" id="witnessSection" style="display: none;">
                                    <div class="mb-3">
                                        <asp:Label ID="lblWitnessName" runat="server" Text="Witness Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div id="witnessContainer">
                                            <div class="d-flex align-items-center mb-2">

                                                <%--<asp:PlaceHolder ID="phWitnessNames" runat="server"></asp:PlaceHolder>
                                                <asp:Button ID="btnAddWitness" runat="server" Text="Add Witness" OnClick="BtnAddWitness_Click" />--%>

                                                <asp:TextBox ID="txtWitness1" runat="server" CssClass="form-control form-control-sm witness-input"></asp:TextBox>
                                                <button type="button" class="btn btn-primary btn-sm btn-fixed-size" onclick="addWitness()">Add</button>
                                                <button type="button" class="btn btn-danger btn-sm btn-fixed-size" onclick="removeWitness(this)">Remove</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- CSS to Fix Button Sizes and Add Proper Spacing -->
                                <style>
                                    .btn-fixed-size {
                                        width: 100px; /* Ensures both buttons are equal width */
                                        text-align: center;
                                        font-size: 14px;
                                        padding: 5px 0; /* Fix button height */
                                    }

                                    .witness-input {
                                        margin-right: 10px; /* Add spacing between input box and Add button */
                                    }
                                </style>

                                <!-- JavaScript -->
                                <script type="text/javascript">
                                    function toggleWitnessSection() {
                                        var witnessSection = document.getElementById("witnessSection");
                                        var radioButtons = document.getElementsByName("<%= rblWitness.UniqueID %>");

                                        for (var i = 0; i < radioButtons.length; i++) {
                                            if (radioButtons[i].checked && radioButtons[i].value === "Yes") {
                                                witnessSection.style.display = "block";
                                            } else if (radioButtons[i].checked && radioButtons[i].value === "No") {
                                                witnessSection.style.display = "none";
                                            }
                                        }
                                    }

                                    function addWitness() {
                                        var container = document.getElementById("witnessContainer");
                                        var div = document.createElement("div");
                                        div.className = "d-flex align-items-center mb-2";

                                        var input = document.createElement("input");
                                        input.type = "text";
                                        input.className = "form-control form-control-sm witness-input";
                                        input.placeholder = "Enter Witness Name";

                                        var addBtn = document.createElement("button");
                                        addBtn.type = "button";
                                        addBtn.className = "btn btn-primary btn-sm btn-fixed-size";
                                        addBtn.innerText = "Add";
                                        addBtn.onclick = addWitness;

                                        var removeBtn = document.createElement("button");
                                        removeBtn.type = "button";
                                        removeBtn.className = "btn btn-danger btn-sm btn-fixed-size";
                                        removeBtn.innerText = "Remove";
                                        removeBtn.onclick = function () {
                                            removeWitness(removeBtn);
                                        };

                                        div.appendChild(input);
                                        div.appendChild(addBtn);
                                        div.appendChild(removeBtn);
                                        container.appendChild(div);
                                    }

                                    function removeWitness(button) {
                                        var container = document.getElementById("witnessContainer");
                                        if (container.children.length > 1) {
                                            button.parentNode.remove();
                                        } else {
                                            alert("At least one witness name is required.");
                                        }
                                    }
                                </script>



                                <!-- Reported By (Required & Only Letters/Spaces) -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblReportedBy" runat="server" Text="Reported By:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtReportedBy" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Name"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvReportedBy" runat="server"
                                                ControlToValidate="txtReportedBy"
                                                ErrorMessage="This field is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revReportedBy" runat="server"
                                                ControlToValidate="txtReportedBy"
                                                ValidationExpression="^[a-zA-Z\s]+$"
                                                ErrorMessage="Name should contain only letters and spaces."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Vendor Name (Required & Only Letters/Spaces) -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblVendorName" runat="server" Text="Vendor Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtVendorName" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Vendor Name"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvVendorName" runat="server"
                                                ControlToValidate="txtVendorName"
                                                ErrorMessage="This field is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revVendorName" runat="server"
                                                ControlToValidate="txtVendorName"
                                                ValidationExpression="^[a-zA-Z\s]+$"
                                                ErrorMessage="Name should contain only letters and spaces."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Total No. of Injured Persons (Required & Only Numbers) -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblInjuredPersons" runat="server" Text="Total No. of Injured Persons:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtInjuredPersons" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Count"></asp:TextBox>

                                            <!-- Required Field Validator -->
                                            <asp:RequiredFieldValidator ID="rfvInjuredPersons" runat="server"
                                                ControlToValidate="txtInjuredPersons"
                                                ErrorMessage="This field is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>

                                            <!-- Regular Expression Validator for Numbers Only -->
                                            <asp:RegularExpressionValidator ID="revInjuredPersons" runat="server"
                                                ControlToValidate="txtInjuredPersons"
                                                ValidationExpression="^\d+$"
                                                ErrorMessage="Only numbers are allowed."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RegularExpressionValidator>

                                        </div>
                                    </div>
                                </div>




                                <!-- Investigation Team Members -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblInvestigationTeam" runat="server" Text="Investigation Team Members:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div id="investigationTeamContainer">
                                            <div class="d-flex align-items-center mb-2">

                                                <%-- <asp:PlaceHolder ID="phInvestigationTeam" runat="server"></asp:PlaceHolder>
                                                <asp:Button ID="btnAddInvestigationMember" runat="server" Text="Add Member" OnClick="BtnAddInvestigationMember_Click" />--%>


                                                <asp:TextBox ID="txtInvestigationMember1" runat="server" CssClass="form-control form-control-sm investigation-input"></asp:TextBox>
                                                <button type="button" class="btn btn-primary btn-sm btn-fixed-size" onclick="addInvestigationMember()">Add</button>
                                                <%-- <button type="button" class="btn btn-danger btn-sm btn-fixed-size" onclick="removeInvestigationMember(this)">Remove</button>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- CSS to Fix Button Sizes and Add Proper Spacing -->
                                <style>
                                    .btn-fixed-size {
                                        width: 100px; /* Ensures both buttons are equal width */
                                        text-align: center;
                                        font-size: 14px;
                                        padding: 5px 0; /* Fix button height */
                                    }

                                    .investigation-input {
                                        margin-right: 10px; /* Add spacing between input box and Add button */
                                    }
                                </style>

                                <!-- JavaScript for Dynamic Input Fields -->
                                <script type="text/javascript">
                                    function addInvestigationMember() {
                                        var container = document.getElementById("investigationTeamContainer");
                                        var div = document.createElement("div");
                                        div.className = "d-flex align-items-center mb-2";

                                        var input = document.createElement("input");
                                        input.type = "text";
                                        input.className = "form-control form-control-sm investigation-input";
                                        input.placeholder = "Enter Team Member";

                                        var addBtn = document.createElement("button");
                                        addBtn.type = "button";
                                        addBtn.className = "btn btn-primary btn-sm btn-fixed-size";
                                        addBtn.innerText = "Add";
                                        addBtn.onclick = addInvestigationMember;

                                        var removeBtn = document.createElement("button");
                                        removeBtn.type = "button";
                                        removeBtn.className = "btn btn-danger btn-sm btn-fixed-size";
                                        removeBtn.innerText = "Remove";
                                        removeBtn.onclick = function () {
                                            removeInvestigationMember(removeBtn);
                                        };

                                        div.appendChild(input);
                                        div.appendChild(addBtn);
                                        div.appendChild(removeBtn);
                                        container.appendChild(div);
                                    }

                                    function removeInvestigationMember(button) {
                                        var container = document.getElementById("investigationTeamContainer");
                                        if (container.children.length > 1) {
                                            button.parentNode.remove();
                                        } else {
                                            alert("At least one team member is required.");
                                        }
                                    }
                                </script>



                                <!-- Merged Field: Task & Description -->
                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <asp:Label ID="lblTaskDescription" runat="server" Text="Task & Incident Description:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtTaskDescription" runat="server" CssClass="form-control form-control-sm rounded"
                                                TextMode="MultiLine" Rows="4" MaxLength="500"></asp:TextBox>

                                            <!-- Required Field Validator -->
                                            <asp:RequiredFieldValidator ID="rfvTaskDescription" runat="server"
                                                ControlToValidate="txtTaskDescription"
                                                ErrorMessage="This field is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>

                                            <!-- Minimum Length Validator (At least 10 characters) -->
                                            <asp:RegularExpressionValidator ID="revTaskDescriptionMinLength" runat="server"
                                                ControlToValidate="txtTaskDescription"
                                                ValidationExpression="^.{10,}$"
                                                ErrorMessage="Description must be at least 10 characters long."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RegularExpressionValidator>

                                        </div>
                                    </div>
                                </div>












                                <%--       <!-- Task Being Performed -->
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <asp:Label ID="lblTask" runat="server" Text="Task Being Performed:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtTaskBeingPerformed" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>

                                            <!-- Required Field Validator -->
                                            <asp:RequiredFieldValidator ID="rfvTaskBeingPerformed" runat="server"
                                                ControlToValidate="txtTaskBeingPerformed"
                                                ErrorMessage="This field is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>

                                            <!-- Regular Expression Validator for Alphabetic Characters Only -->
                                            <asp:RegularExpressionValidator ID="revTaskBeingPerformed" runat="server"
                                                ControlToValidate="txtTaskBeingPerformed"
                                                ValidationExpression="^[A-Za-z\s]+$"
                                                ErrorMessage="Only alphabets and spaces are allowed."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RegularExpressionValidator>

                                        </div>
                                    </div>
                                </div>


                                <!-- JavaScript to Add Multiple Investigation Team Members -->
                                <%--  <script type="text/javascript">
                                    function addInvestigationMember() {
                                        var container = document.getElementById("investigationTeamContainer");
                                        var input = document.createElement("input");
                                        input.type = "text";
                                        input.className = "form-control form-control-sm rounded mb-2";
                                        input.placeholder = "Enter Team Member";
                                        container.appendChild(input);
                                    }
                                </script>--%>


                                <!-- Description of Incident (Textarea) -->
                                <%-- <div class="col-md-12">
                                    <div class="mb-3">
                                        <asp:Label ID="lblDescription" runat="server" Text="Description of Incident:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control form-control-sm rounded"
                                                TextMode="MultiLine" Rows="4"></asp:TextBox>

                                            <!-- Required Field Validator -->
                                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server"
                                                ControlToValidate="txtDescription"
                                                ErrorMessage="This field is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>

                                            <!-- Minimum Length Validator (At least 10 characters) -->
                                            <asp:RegularExpressionValidator ID="revDescriptionMinLength" runat="server"
                                                ControlToValidate="txtDescription"
                                                ValidationExpression="^.{10,}$"
                                                ErrorMessage="Description must be at least 10 characters long."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RegularExpressionValidator>

                                        </div>
                                    </div>
                                </div>--%>



                                <%-- <!-- Contributing Factors Section -->
                                <div class="col-md-12">
                                    <h4 class="form-label" style="color: Blue; font-weight: bold; font-size: small;">Contributing Factors</h4>
                                </div>

                                <!-- Environment Checklist -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <asp:Label ID="lblEnvironment" runat="server" Text="Environment:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <asp:CheckBoxList ID="chkEnvironment" runat="server" CssClass="form-check">
                                            <asp:ListItem Text="Noise" Value="Noise"></asp:ListItem>
                                            <asp:ListItem Text="Lighting" Value="Lighting"></asp:ListItem>
                                            <asp:ListItem Text="Vibration" Value="Vibration"></asp:ListItem>
                                            <asp:ListItem Text="Damaged/unstable floor" Value="DamagedFloor"></asp:ListItem>
                                            <asp:ListItem Text="Dust/Fume" Value="DustFume"></asp:ListItem>
                                            <asp:ListItem Text="Slip/trip hazard" Value="SlipTripHazard"></asp:ListItem>
                                            <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                        </asp:CheckBoxList>
                                        <span id="errEnvironment" style="color: red; display: none;">Please select at least one contributing factor from Environment.
                                        </span>
                                    </div>
                                </div>

                                <!-- Equipment/Materials Checklist -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <asp:Label ID="lblEquipment" runat="server" Text="Equipment/Materials:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <asp:CheckBoxList ID="chkEquipment" runat="server" CssClass="form-check">
                                            <asp:ListItem Text="Wrong equipment for the job" Value="WrongEquipment"></asp:ListItem>
                                            <asp:ListItem Text="Equipment failure" Value="EquipmentFailure"></asp:ListItem>
                                            <asp:ListItem Text="Inadequate maintenance" Value="InadequateMaintenance"></asp:ListItem>
                                            <asp:ListItem Text="Material/equipment too heavy/awkward" Value="HeavyMaterial"></asp:ListItem>
                                            <asp:ListItem Text="Inadequate guarding" Value="InadequateGuarding"></asp:ListItem>
                                            <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                        </asp:CheckBoxList>
                                        <span id="errEquipment" style="color: red; display: none;">Please select at least one contributing factor from Equipment/Materials.
                                        </span>
                                    </div>
                                </div>

                                <!-- Work System Checklist -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <asp:Label ID="lblWorkSystem" runat="server" Text="Work System:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <asp:CheckBoxList ID="chkWorkSystem" runat="server" CssClass="form-check">
                                            <asp:ListItem Text="Hazard not identified" Value="HazardNotIdentified"></asp:ListItem>
                                            <asp:ListItem Text="No/Inadequate risk assessment conducted" Value="NoRiskAssessment"></asp:ListItem>
                                            <asp:ListItem Text="Procedure not followed/Inadequate procedure" Value="ProcedureNotFollowed"></asp:ListItem>
                                            <asp:ListItem Text="No/Inadequate safe work procedure" Value="NoSafeProcedure"></asp:ListItem>
                                            <asp:ListItem Text="No/Inadequate controls implemented" Value="NoControls"></asp:ListItem>
                                            <asp:ListItem Text="Failure to report unsafe conditions" Value="FailureToReportUnsafe"></asp:ListItem>
                                            <asp:ListItem Text="Lack of job-specific training" Value="LackOfJobTraining"></asp:ListItem>
                                            <asp:ListItem Text="Failure to follow established safety protocols" Value="FailureToFollowProtocols"></asp:ListItem>
                                            <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                        </asp:CheckBoxList>
                                        <span id="errWorkSystem" style="color: red; display: none;">Please select at least one contributing factor from Work System.
                                        </span>
                                    </div>
                                </div>

                                <!-- People Checklist -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <asp:Label ID="lblPeople" runat="server" Text="People:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <asp:CheckBoxList ID="chkPeople" runat="server" CssClass="form-check">
                                            <asp:ListItem Text="Procedure not followed/no procedure" Value="NoProcedure"></asp:ListItem>
                                            <asp:ListItem Text="Drugs/alcohol" Value="DrugsAlcohol"></asp:ListItem>
                                            <asp:ListItem Text="Fatigue" Value="Fatigue"></asp:ListItem>
                                            <asp:ListItem Text="Time/production pressures" Value="TimePressure"></asp:ListItem>
                                            <asp:ListItem Text="Distraction/personal issues/stress" Value="Distraction"></asp:ListItem>
                                            <asp:ListItem Text="Lack of communication" Value="LackOfCommunication"></asp:ListItem>
                                            <asp:ListItem Text="Unsafe behavior" Value="UnsafeBehavior"></asp:ListItem>
                                            <asp:ListItem Text="Lack of personal protective equipment (PPE)" Value="NoPPE"></asp:ListItem>
                                            <asp:ListItem Text="Failure to follow safety warnings" Value="FailureToFollowWarnings"></asp:ListItem>
                                            <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                        </asp:CheckBoxList>
                                        <span id="errPeople" style="color: red; display: none;">Please select at least one contributing factor from People.
                                        </span>
                                    </div>
                                </div>

                                <!-- JavaScript Validation -->
                                <script type="text/javascript">
                                    document.addEventListener("DOMContentLoaded", function () {
                                        function validateCheckboxList(chkListId, errorMsgId) {
                                            var checkBoxList = document.getElementById(chkListId);
                                            var checkBoxes = checkBoxList.getElementsByTagName("input");
                                            var isChecked = false;

                                            for (var i = 0; i < checkBoxes.length; i++) {
                                                if (checkBoxes[i].type === "checkbox" && checkBoxes[i].checked) {
                                                    isChecked = true;
                                                    break;
                                                }
                                            }

                                            document.getElementById(errorMsgId).style.display = isChecked ? "none" : "block";
                                        }

                                        function attachValidation(chkListId, errorMsgId) {
                                            var checkBoxList = document.getElementById(chkListId);
                                            var checkBoxes = checkBoxList.getElementsByTagName("input");

                                            for (var i = 0; i < checkBoxes.length; i++) {
                                                checkBoxes[i].addEventListener("change", function () {
                                                    validateCheckboxList(chkListId, errorMsgId);
                                                });
                                            }
                                        }

                                        // Attach validation to all sections
                                        attachValidation("chkEnvironment", "errEnvironment");
                                        attachValidation("chkEquipment", "errEquipment");
                                        attachValidation("chkWorkSystem", "errWorkSystem");
                                        attachValidation("chkPeople", "errPeople");
                                    });
                                </script>--%>




                                <%-- Root Cause Analysis Table - Row Format --%>
                                <div class="col-md-12">
                                    <div class="table-responsive root-cause-table">
                                        <asp:Table ID="tblRootCauseAnalysis" runat="server" CssClass="table table-bordered text-start">
                                  
                                            <asp:TableHeaderRow CssClass="table-light">
                                                <asp:TableCell ColumnSpan="2" CssClass="text-center fw-bold" ForeColor="Blue">
                    <strong>Root Cause Analysis</strong>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>

                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 1 (Loss)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy1" runat="server" CssClass="form-control"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>

                                        
                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 2 (Incident)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy2" runat="server" CssClass="form-control"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>

                                         
                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 3 (Immediate Cause)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy3" runat="server" CssClass="form-control"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>

                                         
                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 4 (Underlying Cause)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy4" runat="server" CssClass="form-control"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>

                                          
                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 5 (Root Cause)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy5" runat="server" CssClass="form-control"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>

                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 6 (How)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy6" runat="server" CssClass="form-control"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </div>
                                </div>


                                <%--<div class="col-md-12">
                                    <div class="table-responsive">
                                        <asp:Table ID="tblRootCauseAnalysis" runat="server" CssClass="table table-bordered text-center">
                                            <asp:TableHeaderRow CssClass="table-light">
                                                <asp:TableCell ColumnSpan="6" CssClass="text-center fw-bold" ForeColor="Blue">
                    <strong>Root Cause Analysis</strong>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>
                                            <asp:TableHeaderRow CssClass="text-center" ForeColor="MediumBlue">
                                                <asp:TableCell><strong>Why 1 <br /> (Loss)</strong></asp:TableCell>
                                                <asp:TableCell><strong>Why 2 <br /> (Incident)</strong></asp:TableCell>
                                                <asp:TableCell><strong>Why 3 <br /> (Immediate Cause)</strong></asp:TableCell>
                                                <asp:TableCell><strong>Why 4 <br /> (Underlying Cause)</strong></asp:TableCell>
                                                <asp:TableCell><strong>Why 5 <br /> (Root Cause)</strong></asp:TableCell>
                                                <asp:TableCell><strong>Why 6 <br /> (How)</strong></asp:TableCell>
                                            </asp:TableHeaderRow>
                                            <asp:TableRow>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy1" runat="server" CssClass="form-control" AutoPostBack="false" EnableViewState="false"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy2" runat="server" CssClass="form-control" AutoPostBack="false" EnableViewState="false"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy3" runat="server" CssClass="form-control" AutoPostBack="false" EnableViewState="false"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy4" runat="server" CssClass="form-control" AutoPostBack="false" EnableViewState="false"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy5" runat="server" CssClass="form-control" AutoPostBack="false" EnableViewState="false"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy6" runat="server" CssClass="form-control" AutoPostBack="false" EnableViewState="false"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </div>
                                </div>

                                <style>
                                    @media (max-width: 720px) {
                                        .root-cause-table {
                                            display: block;
                                            overflow-x: auto;
                                            white-space: nowrap;
                                        }

                                            .root-cause-table table {
                                                width: 100%;
                                                min-width: 700px; /* Ensures table doesn't shrink too much */
                                            }

                                            .root-cause-table td,
                                            .root-cause-table th {
                                                font-size: 14px;
                                                padding: 5px;
                                            }

                                        .table-responsive {
                                            overflow-x: auto;
                                        }
                                    }
                                </style>--%>



                                <div class="row">
                                    <!-- Review Date -->
                                    <div class="col-md-4 offset-md-1">
                                        <div class="mb-3">
                                            <asp:Label runat="server" Text="Review Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                            <div class="input-group-sm">
                                                <asp:TextBox ID="txtReviewDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Corrective Actions -->
                                    <div class="col-md-4 offset-md-1">
                                        <div class="mb-3">
                                            <asp:Label ID="lblCorrectiveActions" runat="server" Text="Corrective Actions:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                            <div class="input-group-sm">
                                                <asp:TextBox ID="txtCorrectiveActions" runat="server" CssClass="form-control form-control-sm rounded w-100"></asp:TextBox>

                                                <!-- Required Field Validator -->
                                                <asp:RequiredFieldValidator ID="rfvCorrectiveActions" runat="server"
                                                    ControlToValidate="txtCorrectiveActions"
                                                    ErrorMessage="This field is required."
                                                    ForeColor="Red"
                                                    Display="Dynamic">
                                                </asp:RequiredFieldValidator>

                                                <!-- Regular Expression Validator for Alphabetic Characters and Spaces -->
                                                <asp:RegularExpressionValidator ID="revCorrectiveActions" runat="server"
                                                    ControlToValidate="txtCorrectiveActions"
                                                    ValidationExpression="^[A-Za-z\s]+$"
                                                    ErrorMessage="Only letters and spaces are allowed."
                                                    ForeColor="Red"
                                                    Display="Dynamic">
                                                </asp:RegularExpressionValidator>

                                            </div>
                                        </div>
                                    </div>
                                </div>



                                <%--  --%>

                                <%--                                <!-- Review Date -->
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <asp:Label runat="server" Text="Review Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtReviewDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="row">
                                        <!-- Corrective Actions -->
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <asp:Label ID="lblCorrectiveActions" runat="server" Text="Corrective Actions:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="txtCorrectiveActions" runat="server" CssClass="form-control form-control-sm rounded w-100"></asp:TextBox>

                                                    <!-- Required Field Validator -->
                                                    <asp:RequiredFieldValidator ID="rfvCorrectiveActions" runat="server"
                                                        ControlToValidate="txtCorrectiveActions"
                                                        ErrorMessage="This field is required."
                                                        ForeColor="Red"
                                                        Display="Dynamic">
                                                    </asp:RequiredFieldValidator>

                                                    <!-- Regular Expression Validator for Alphabetic Characters and Spaces -->
                                                    <asp:RegularExpressionValidator ID="revCorrectiveActions" runat="server"
                                                        ControlToValidate="txtCorrectiveActions"
                                                        ValidationExpression="^[A-Za-z\s]+$"
                                                        ErrorMessage="Only letters and spaces are allowed."
                                                        ForeColor="Red"
                                                        Display="Dynamic">
                                                    </asp:RegularExpressionValidator>

                                                </div>
                                            </div>
                                        </div>
                                    </div>--%>

                                <!-- Preventive Actions -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <asp:Label ID="lblPreventiveActions" runat="server" Text="Preventive Actions:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtPreventiveActions" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>

                                            <!-- Required Field Validator -->
                                            <asp:RequiredFieldValidator ID="rfvPreventiveActions" runat="server"
                                                ControlToValidate="txtPreventiveActions"
                                                ErrorMessage="This field is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>

                                            <!-- Regular Expression Validator for Alphabetic Characters and Spaces -->
                                            <asp:RegularExpressionValidator ID="revPreventiveActions" runat="server"
                                                ControlToValidate="txtPreventiveActions"
                                                ValidationExpression="^[A-Za-z\s]+$"
                                                ErrorMessage="Only letters and spaces are allowed."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RegularExpressionValidator>

                                        </div>
                                    </div>
                                </div>


                                <div class="col-md-12">
                                    <asp:GridView ID="gvIncidentData" runat="server" CssClass="table table-bordered table-striped"
                                        AutoGenerateColumns="false" DataKeyNames="IncidentID">
                                        <Columns>
                                            <asp:BoundField DataField="IncidentID" HeaderText="Incident ID" />
                                            <asp:BoundField DataField="IncidentClassification" HeaderText="Classification" />
                                            <asp:BoundField DataField="DateOfIncident" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                                            <asp:BoundField DataField="Location" HeaderText="Location" />
                                            <asp:BoundField DataField="Department" HeaderText="Department" />
                                            <asp:BoundField DataField="NameOfPersonInvolved" HeaderText="Person Involved" />
                                            <asp:BoundField DataField="AnyWitness" HeaderText="Any Witness?" />
                                            <asp:BoundField DataField="WitnessNames" HeaderText="Witness Names" />
                                            <asp:BoundField DataField="ReportedBy" HeaderText="Reported By" />
                                            <asp:BoundField DataField="DescriptionOfIncident" HeaderText="Description" />
                                            <asp:BoundField DataField="ContributingFactors_Environment" HeaderText="Contributing Factors" />
                                            <asp:BoundField DataField="CorrectiveActions" HeaderText="Corrective Actions" />
                                        </Columns>
                                    </asp:GridView>
                                </div>




                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group input-group-sm">
                                            <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
                                            <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                                            <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                        </div>
                                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true" />
                                    </div>
                                </div>



                                <!-- End row -->
                            </div>
                            <!-- End x_content -->
                        </div>
                        <!-- End x_panel -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
