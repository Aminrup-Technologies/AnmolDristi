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

        .final-root-cause-row {
    position: relative;
    top: 40px; /* Adjust this value as needed */
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

                                <div class="col-md-12">
                                    <hr />
                                </div>

                                <div class="col-md-12">
                                    <h4 class="text-left text-info">Witness Details</h4>
                                    <hr />
                                </div>


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
                               <%-- <div class="col-md-3" id="witnessSection" style="display: none;">
                                    <div class="mb-3">
                                        <asp:Label ID="lblWitnessName" runat="server" Text="Witness Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div id="witnessContainer">
                                            <div class="d-flex align-items-center mb-2">

                                                <%--<asp:PlaceHolder ID="phWitnessNames" runat="server"></asp:PlaceHolder>
                                                <asp:Button ID="btnAddWitness" runat="server" Text="Add Witness" OnClick="BtnAddWitness_Click" />--%>

                                                <%--<asp:TextBox ID="txtWitness1" runat="server" CssClass="form-control form-control-sm witness-input"></asp:TextBox>
                                                <!-- RequiredFieldValidator for Witness -->
                                                <asp:RequiredFieldValidator ID="rfvWitness1" runat="server"
                                                    ControlToValidate="txtWitness1"
                                                    ErrorMessage="Witness Name is required."
                                                    ForeColor="Red"
                                                    Display="Dynamic">
                                                </asp:RequiredFieldValidator>
                                                <button type="button" class="btn btn-primary btn-sm btn-fixed-size" onclick="addWitness()">Add</button>
                                                <button type="button" class="btn btn-danger btn-sm btn-fixed-size" onclick="removeWitness(this)">Remove</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>--%>

                                <!-- CSS to Fix Button Sizes and Add Proper Spacing -->
                               <%-- <style>
                                    .btn-fixed-size {
                                        width: 100px; /* Ensures both buttons are equal width */
                                        text-align: center;
                                        font-size: 14px;
                                        padding: 5px 0; /* Fix button height */
                                    }

                                    .witness-input {
                                        margin-right: 10px; /* Add spacing between input box and Add button */
                                    }
                                </style>--%>

                                <!-- JavaScript -->
                                <%--<script type="text/javascript">
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
                                </script>--%>




<!-- Witness Name Section (Initially Hidden) -->
<div class="col-md-3" id="witnessSection" style="display: none;">
    <div class="mb-3">
        <asp:Label ID="lblWitnessName" runat="server" Text="Witness Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

        <!-- Input + Add Button -->
        <div class="d-flex align-items-center mb-2">
            <asp:TextBox ID="txtWitness1" runat="server" CssClass="form-control form-control-sm witness-input" placeholder="Enter Witness Name"></asp:TextBox>

            <button type="button" class="btn btn-primary btn-sm ms-2" onclick="addWitness()" CausesValidation="false" UseSubmitBehavior="false">Add</button>
            <asp:HiddenField ID="hfWitnessList" runat="server" />
        </div>

        <!-- Witness list will appear here -->
        <div id="witnessList"></div>
    </div>
</div>

<!-- ✅ CSS -->
<style>
    .witness-input {
        flex: 1;
        margin-right: 12px; 
    }

    .add-witness-btn {
    min-width: 90px;       /* keeps consistent size */
    text-align: center;
    padding: 5px 10px;
    font-size: 14px;
}


    #witnessList {
        margin-top: 8px;
    }

    /* Each added witness row */
    .witness-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        background-color: #f8f9fa;
        border: 1px solid #ddd;
        border-radius: 6px;
        padding: 6px 10px;
        margin-bottom: 6px;
    }

    .witness-name {
        font-size: 14px;
        font-weight: 500;
        color: #333;
        margin-right: 10px;
        flex: 1;
        word-break: break-word;
    }

    .btn-remove {
        padding: 2px 8px;
        font-size: 12px;
        border-radius: 4px;
    }
</style>

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
        var input = document.getElementById("<%= txtWitness1.ClientID %>");
    var name = input.value.trim();
    if (name === "") {
        alert("Please enter a witness name.");
        return;
    }

    var container = document.getElementById("witnessList");

    var div = document.createElement("div");
    div.className = "witness-item";

    var label = document.createElement("span");
    label.textContent = name;
    label.className = "witness-name";

    var removeBtn = document.createElement("button");
    removeBtn.type = "button";
    removeBtn.className = "btn btn-danger btn-sm btn-remove";
    removeBtn.textContent = "Remove";
    removeBtn.onclick = function () {
        container.removeChild(div);
        updateWitnessHiddenField();
    };

    div.appendChild(label);
    div.appendChild(removeBtn);
    container.appendChild(div);

    input.value = "";

    updateWitnessHiddenField();
}

function updateWitnessHiddenField() {
    var names = [];
    document.querySelectorAll("#witnessList .witness-name").forEach(span => {
        names.push(span.textContent.trim());
    });
    document.getElementById("<%= hfWitnessList.ClientID %>").value = names.join(", ");
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

                                <div class="col-md-12">
                                    <hr />
                                </div>

                                <div class="col-md-12">
                                    <h4 class="text-left text-info">Injured Person Details</h4>
                                    <hr />
                                </div>

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

                                <div class="col-md-12">
                                    <hr />
                                </div>

                                <div class="col-md-12">
                                    <h4 class="text-left text-info">Investigation Team</h4>
                                    <hr />
                                </div>


                                <!-- Investigation Team Members -->
                               <%-- <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblInvestigationTeam" runat="server" Text="Investigation Team Members:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div id="investigationTeamContainer">
                                            <div class="d-flex align-items-center mb-2">




                                                <asp:TextBox ID="txtInvestigationMember1" runat="server" CssClass="form-control form-control-sm investigation-input"></asp:TextBox>
                                                <!-- RequiredFieldValidator for Investigation Member -->
                                                <asp:RequiredFieldValidator ID="rfvInvestigationMember1" runat="server"
                                                    ControlToValidate="txtInvestigationMember1"
                                                    ErrorMessage="Team Member Name is required."
                                                    ForeColor="Red"
                                                    Display="Dynamic">
                                                </asp:RequiredFieldValidator>
                                                <button type="button" class="btn btn-primary btn-sm btn-fixed-size" onclick="addInvestigationMember()">Add</button>

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
                                </script>--%>






                                <!-- Investigation Team Members -->
                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="lblInvestigationTeam" runat="server" 
                                                    Text="Investigation Team Members:" 
                                                    ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                                <!-- Input + Add Button -->
                                                <div class="d-flex align-items-center mb-2">
                                                    <asp:TextBox ID="txtInvestigationMember1" runat="server"
                                                        CssClass="form-control form-control-sm investigation-input"
                                                        placeholder="Enter Team Member"></asp:TextBox>

                                                    <button type="button" class="btn btn-primary btn-sm add-investigation-btn" onclick="addInvestigationMember()">Add</button>
                                                    <asp:HiddenField ID="hfInvestigationTeamList" runat="server" />
                                                </div>

                                                <!-- List of members -->
                                                <div id="investigationTeamList"></div>
                                            </div>
                                        </div>

                                        <!-- ✅ CSS -->
                                        <style>
                                            .investigation-input {
                                                flex: 1;
                                                margin-right: 12px; /* Space between textbox and button */
                                            }

                                            .add-investigation-btn {
                                                min-width: 90px;
                                                text-align: center;
                                                padding: 5px 10px;
                                                font-size: 14px;
                                            }

                                            #investigationTeamList {
                                                margin-top: 8px;
                                            }

                                            /* Each added member row */
                                            .investigation-item {
                                                display: flex;
                                                align-items: center;
                                                justify-content: space-between;
                                                background-color: #f8f9fa;
                                                border: 1px solid #ddd;
                                                border-radius: 6px;
                                                padding: 6px 10px;
                                                margin-bottom: 6px;
                                            }

                                            .investigation-name {
                                                font-size: 14px;
                                                font-weight: 500;
                                                color: #333;
                                                margin-right: 10px;
                                                flex: 1;
                                                word-break: break-word;
                                            }

                                            .btn-remove {
                                                padding: 2px 8px;
                                                font-size: 12px;
                                                border-radius: 4px;
                                            }
                                        </style>

                                        <!-- ✅ JavaScript -->
                                        <script type="text/javascript">
                                            function addInvestigationMember() {
                                                var input = document.getElementById("<%= txtInvestigationMember1.ClientID %>");
                                                var name = input.value.trim();
                                                if (name === "") {
                                                    alert("Please enter a team member name.");
                                                    return;
                                                }

                                                var container = document.getElementById("investigationTeamList");

                                                var div = document.createElement("div");
                                                div.className = "investigation-item";

                                                var label = document.createElement("span");
                                                label.textContent = name;
                                                label.className = "investigation-name";

                                                var removeBtn = document.createElement("button");
                                                removeBtn.type = "button";
                                                removeBtn.className = "btn btn-danger btn-sm btn-remove";
                                                removeBtn.textContent = "Remove";
                                                removeBtn.onclick = function () {
                                                    container.removeChild(div);
                                                    updateInvestigationHiddenField(); // update hidden field when removing
                                                };

                                                div.appendChild(label);
                                                div.appendChild(removeBtn);
                                                container.appendChild(div);

                                                input.value = "";

                                                updateInvestigationHiddenField(); // update hidden field when adding
                                            }


                                        </script>

                                   <script>
                                       function updateInvestigationHiddenField() {
                                           var members = [];
                                           document.querySelectorAll("#investigationTeamList .investigation-name").forEach(span => {
                                               members.push(span.textContent.trim());
                                           });
                                           document.getElementById("<%= hfInvestigationTeamList.ClientID %>").value = members.join(", ");
                                       }


                                   </script>









                                <div class="col-md-12">
                                    <hr />
                                </div>

                                <div class="col-md-12">
                                    <h4 class="text-left text-info">Incident Details</h4>
                                    <hr />
                                </div>

                                <!-- Merged Field: Task & Description -->
                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <asp:Label ID="lblTaskDescription" runat="server" Text="Incident Description:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
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
                                    <hr />
                                </div>

                                <div class="col-md-12">
                                    <h4 class="text-left text-info">Root Cause Analysis</h4>
                                    <hr />
                                </div>


                                <%-- Root Cause Analysis Table - Row Format --%>
                                <div class="col-md-12">
                                    <div class="table-responsive root-cause-table">
                                        <asp:Table ID="tblRootCauseAnalysis" runat="server" CssClass="table table-bordered text-start">

                                            <asp:TableHeaderRow CssClass="table-light">
                                                <asp:TableCell ColumnSpan="2" CssClass="text-center fw-bold" ForeColor="Blue">
                    <strong>Root Cause Analysis</strong>
                                                </asp:TableCell>
                                            </asp:TableHeaderRow>













                                            <%--  Row for Why 1 --%>
                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 1 (Loss)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy1" runat="server" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvWhy1" runat="server"
                                                        ControlToValidate="txtWhy1"
                                                        ErrorMessage="This field is required."
                                                        ForeColor="Red"
                                                        Display="Dynamic">
                                                    </asp:RequiredFieldValidator>
                                                </asp:TableCell>
                                            </asp:TableRow>


                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 2 (Incident)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy2" runat="server" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvWhy2" runat="server"
                                                        ControlToValidate="txtWhy2"
                                                        ErrorMessage="This field is required."
                                                        ForeColor="Red"
                                                        Display="Dynamic">
                                                    </asp:RequiredFieldValidator>
                                                </asp:TableCell>
                                            </asp:TableRow>


                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 3 (Immediate Cause)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy3" runat="server" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvWhy3" runat="server"
                                                        ControlToValidate="txtWhy3"
                                                        ErrorMessage="This field is required."
                                                        ForeColor="Red"
                                                        Display="Dynamic">
                                                    </asp:RequiredFieldValidator>
                                                </asp:TableCell>
                                            </asp:TableRow>


                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 4 (Underlying Cause)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy4" runat="server" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvWhy4" runat="server"
                                                        ControlToValidate="txtWhy4"
                                                        ErrorMessage="This field is required."
                                                        ForeColor="Red"
                                                        Display="Dynamic">
                                                    </asp:RequiredFieldValidator>
                                                </asp:TableCell>
                                            </asp:TableRow>


                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 5 (Root Cause)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy5" runat="server" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvWhy5" runat="server"
                                                        ControlToValidate="txtWhy5"
                                                        ErrorMessage="This field is required."
                                                        ForeColor="Red"
                                                        Display="Dynamic">
                                                    </asp:RequiredFieldValidator>
                                                </asp:TableCell>
                                            </asp:TableRow>


                                            <asp:TableRow>
                                                <asp:TableCell CssClass="fw-bold" ForeColor="MediumBlue">
                    Why 6 (How)
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtWhy6" runat="server" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvWhy6" runat="server"
                                                        ControlToValidate="txtWhy6"
                                                        ErrorMessage="This field is required."
                                                        ForeColor="Red"
                                                        Display="Dynamic">
                                                    </asp:RequiredFieldValidator>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </div>
                                </div>

                  <!-- Upload Supporting Image and Final Root Cause Section -->
<div class="col-md-6">
    <asp:Label runat="server" Text="Upload Supporting Image:" CssClass="fw-bold" ForeColor="MediumBlue" />
    <asp:FileUpload ID="fuRootCauseImage" runat="server" CssClass="form-control form-control-sm mb-1" />
</div>


                                
           <!-- Root Cause -->
<div class="col-md-12">
    <div class="mb-12">
        <asp:Label ID="lblRootCause" runat="server" Text=" Final Root Cause:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <div class="input-group-sm">
            <asp:TextBox ID="txtFinalRootCause" runat="server" CssClass="form-control form-control-sm rounded w-100" TextMode="MultiLine" Rows="3"></asp:TextBox>

            <!-- Validator -->
            <asp:RequiredFieldValidator ID="rfvFinalRootCause" runat="server"
                ControlToValidate="txtFinalRootCause"
                ErrorMessage="Please enter the final root cause."
                ForeColor="Red"
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </div>
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


                                <div class="col-md-12">
                                    <hr />
                                </div>

                                <div class="col-md-12">
                                    <h4 class="text-left text-info">Actionables</h4>
                                    <hr />
                                </div>

                                <!-- Corrective Actions -->
                                <div class="col-md-12">
                                    <div class="mb-12">
                                        <asp:Label ID="lblCorrectiveActions" runat="server" Text="Immediate Actions:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtCorrectiveActions" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control form-control-sm rounded w-100"></asp:TextBox>

                                            <!-- Validators -->
                                            <asp:RequiredFieldValidator ID="rfvCorrectiveActions" runat="server"
                                                ControlToValidate="txtCorrectiveActions"
                                                ErrorMessage="This field is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>

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

                                <!-- Preventive Actions (Same Row) -->
                                <div class="col-md-12">
                                    <div class="mb-12">
                                        <asp:Label ID="lblPreventiveActions" runat="server" Text="Preventive Actions:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtPreventiveActions" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control form-control-sm rounded"></asp:TextBox>

                                            <!-- Validators -->
                                            <asp:RequiredFieldValidator ID="rfvPreventiveActions" runat="server"
                                                ControlToValidate="txtPreventiveActions"
                                                ErrorMessage="This field is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>

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

                                <!-- Review Date -->
                               <%-- <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblReviewDate" runat="server" Text="Review Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtReviewDate" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Select Review Date" TextMode="Date"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvReviewDate" runat="server"
                                                ControlToValidate="txtReviewDate"
                                                ErrorMessage="Please select a review date."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>--%>




                            <script type="text/javascript">
                                function validateFormBeforeSubmit() {
                                    var isValid = true;
                                    var errorMessage = "";

                                    // Static fields check (Dropdowns and Textboxes)
                                    var fieldsToCheck = [
                                        { id: '<%= ddlIncidentClassification.ClientID %>', type: 'dropdown' },
                                        { id: '<%= txtDateOfIncident.ClientID %>', type: 'textbox' },
                                        { id: '<%= txtTimeOfIncident.ClientID %>', type: 'textbox' },
                                        { id: '<%= txtPersonInvolved.ClientID %>', type: 'textbox' },
                                        { id: '<%= txtLocation.ClientID %>', type: 'textbox' },
                                        { id: '<%= txtDepartment.ClientID %>', type: 'textbox' },
                                        { id: '<%= txtSection.ClientID %>', type: 'textbox' },
                                        { id: '<%= txtTaskDescription.ClientID %>', type: 'textbox' }, // New - Task & Incident Description
                                        { id: '<%= txtReportedBy.ClientID %>', type: 'textbox' },      // New - Reported By
                                        { id: '<%= txtVendorName.ClientID %>', type: 'textbox' },       // New - Vendor Name
                                        { id: '<%= txtInjuredPersons.ClientID %>', type: 'textbox' }    // New - Total No. of Injured Persons
                                    ];

                                    for (var i = 0; i < fieldsToCheck.length; i++) {
                                        var fieldInfo = fieldsToCheck[i];
                                        var field = document.getElementById(fieldInfo.id);
                                        if (field) {
                                            if (fieldInfo.type === 'textbox') {
                                                if (field.value.trim() === "") {
                                                    isValid = false;
                                                    errorMessage += "- Please fill " + getFriendlyName(field.id) + ".\n";
                                                    field.classList.add("is-invalid");
                                                } else {
                                                    field.classList.remove("is-invalid");
                                                }
                                            } else if (fieldInfo.type === 'dropdown') {
                                                if (field.value === "0" || field.selectedIndex === 0) {
                                                    isValid = false;
                                                    errorMessage += "- Please select " + getFriendlyName(field.id) + ".\n";
                                                    field.classList.add("is-invalid");
                                                } else {
                                                    field.classList.remove("is-invalid");
                                                }
                                            }
                                        }
                                    }

                                    // Witness section validation (if visible)
                                    //var witnessSection = document.getElementById("witnessSection");
                                    //if (witnessSection && witnessSection.style.display !== "none") {
                                    //    var witnessInputs = witnessSection.querySelectorAll("input[type='text']");
                                    //    witnessInputs.forEach(function (input, index) {
                                    //        if (input.value.trim() === "") {
                                    //            isValid = false;
                                    //            errorMessage += "- Please enter Witness Name #" + (index + 1) + ".\n";
                                    //            input.classList.add("is-invalid");
                                    //        } else {
                                    //            input.classList.remove("is-invalid");
                                    //        }
                                    //    });
                                    //}




                                    var witnessHidden = document.getElementById("<%= hfWitnessList.ClientID %>");
                                    if (witnessSection && witnessSection.style.display !== "none") {
                                        if (!witnessHidden.value.trim()) {
                                            isValid = false;
                                            errorMessage += "- Please enter at least one Witness Name.\n";
                                        }
                                    }






                                    // Investigation Team Members validation
                                    var investigationContainer = document.getElementById("investigationTeamContainer");
                                    if (investigationContainer) {
                                        var investigationInputs = investigationContainer.querySelectorAll("input[type='text']");
                                        investigationInputs.forEach(function (input, index) {
                                            if (input.value.trim() === "") {
                                                isValid = false;
                                                errorMessage += "- Please enter Investigation Team Member #" + (index + 1) + ".\n";
                                                input.classList.add("is-invalid");
                                            } else {
                                                input.classList.remove("is-invalid");
                                            }
                                        });
                                    }

                                    // Root Cause Analysis fields (Why1 to Why6)
                                    var whyFields = [
                                        '<%= txtWhy1.ClientID %>',
                                        '<%= txtWhy2.ClientID %>',
                                        '<%= txtWhy3.ClientID %>',
                                        '<%= txtWhy4.ClientID %>',
                                        '<%= txtWhy5.ClientID %>',
                                        '<%= txtWhy6.ClientID %>'
                                    ];
                                    for (var j = 0; j < whyFields.length; j++) {
                                        var whyInput = document.getElementById(whyFields[j]);
                                        if (whyInput && whyInput.value.trim() === "") {
                                            isValid = false;
                                            errorMessage += "- Please fill Why " + (j + 1) + ".\n";
                                            whyInput.classList.add("is-invalid");
                                        } else if (whyInput) {
                                            whyInput.classList.remove("is-invalid");
                                        }
                                    }

                                    // Review Date
                                   <%-- var reviewDate = document.getElementById('<%= txtReviewDate.ClientID %>');
                                    if (reviewDate && reviewDate.value.trim() === "") {
                                        isValid = false;
                                        errorMessage += "- Please select Review Date.\n";
                                        reviewDate.classList.add("is-invalid");
                                    } else if (reviewDate) {
                                        reviewDate.classList.remove("is-invalid");
                                    }--%>

                                    // Corrective Actions
                                    var correctiveActions = document.getElementById('<%= txtCorrectiveActions.ClientID %>');
                                    if (correctiveActions && correctiveActions.value.trim() === "") {
                                        isValid = false;
                                        errorMessage += "- Please fill Corrective Actions.\n";
                                        correctiveActions.classList.add("is-invalid");
                                    } else if (correctiveActions) {
                                        correctiveActions.classList.remove("is-invalid");
                                    }

                                    // Preventive Actions
                                    var preventiveActions = document.getElementById('<%= txtPreventiveActions.ClientID %>');
                            if (preventiveActions && preventiveActions.value.trim() === "") {
                                isValid = false;
                                errorMessage += "- Please fill Preventive Actions.\n";
                                preventiveActions.classList.add("is-invalid");
                            } else if (preventiveActions) {
                                preventiveActions.classList.remove("is-invalid");
                            }

                            if (!isValid) {
                                alert("Please complete all required fields:\n\n" + errorMessage);
                                return false;
                            }
                            return true;
                        }

                        function getFriendlyName(id) {
                            var nameMap = {
                                '<%= ddlIncidentClassification.ClientID %>': "Incident Classification",
                                    '<%= txtDateOfIncident.ClientID %>': "Date of Incident",
                                    '<%= txtTimeOfIncident.ClientID %>': "Time of Incident",
                                    '<%= txtPersonInvolved.ClientID %>': "Name of Person Involved",
                                    '<%= txtLocation.ClientID %>': "Location",
                                    '<%= txtDepartment.ClientID %>': "Department",
                                    '<%= txtSection.ClientID %>': "Section",
                                    '<%= txtTaskDescription.ClientID %>': "Task & Incident Description",
                                    '<%= txtReportedBy.ClientID %>': "Reported By",
                                    '<%= txtVendorName.ClientID %>': "Vendor Name",
                                    '<%= txtInjuredPersons.ClientID %>': "Total No. of Injured Persons"
                                };
                                return nameMap[id] || "this field";
                            }

                            window.onload = function () {
                                document.getElementById('<%= BtnSubmit.ClientID %>').onclick = function (e) {
                                        if (!validateFormBeforeSubmit()) {
                                            e.preventDefault();
                                        }
                                    };
                                };
                            </script>

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

                            <div class="col-md-12">
                                <hr />
                            </div>

                            <div class="col-md-12">
                                <h4 class="text-left text-info">Final Submission</h4>
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

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
