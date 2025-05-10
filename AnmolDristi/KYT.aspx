<%@ Page Title="CSM - KYT" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="KYT.aspx.cs" Inherits="AnmolDristi.KYT" %>

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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        let kytData = [];
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("btnAddKYT").addEventListener("click", function () {

                const slNo = document.getElementById("<%= txtSlNo.ClientID %>").value.trim();
                const hazard = document.getElementById("<%= txtHiddenHazards.ClientID %>").value.trim();
                const consequence = document.getElementById("<%= txtConsequence.ClientID %>").value.trim();
                const measures = document.getElementById("<%= txtCounterMeasures.ClientID %>").value.trim();
                const priority = document.getElementById("<%= ddlPriority.ClientID %>").value;
                const photoControl = document.getElementById("<%= fuPhotograph.ClientID %>");
                const photoName = photoControl.files.length > 0 ? photoControl.files[0].name : "No file";

                if (!slNo || !hazard || !consequence || !measures || !priority) {
                    alert("Please fill in all fields before adding.");
                    return;
                }

                // Create observation object
                let observation = {
                    SlNo: parseInt(slNo),
                    HiddenHazards: hazard,
                    Consequence: consequence,
                    CounterMeasures: measures,
                    PriorityValue: priority,
                    PhotographPath: photoName
                };

                // Push to array
                kytData.push(observation);

                // Save to hidden field
                document.getElementById("<%= hfKYTGridData.ClientID %>").value = JSON.stringify(kytData);


                let grid = document.getElementById("KYTGrid");
                if (!grid) {
                    console.error("KYTGrid not found.");
                    return;
                }

                let table = document.getElementById("KYTTable");
                if (!table) {
                    table = document.createElement("table");
                    table.id = "KYTTable";
                    table.className = "table table-bordered small mt-3";
                    table.innerHTML = `
                    <thead class="table-light">
                        <tr>
                            <th>Sl. No.</th>
                            <th>Hidden Hazards</th>
                            <th>Consequence</th>
                            <th>Counter Measures</th>
                            <th>Priority</th>
                            <th>Photograph</th>
                        </tr>
                    </thead>
                    <tbody></tbody>`;
                    grid.appendChild(table);
                }

                const tbody = table.querySelector("tbody");
                const newRow = document.createElement("tr");

                [slNo, hazard, consequence, measures, priority, photoName].forEach(text => {
                    const td = document.createElement("td");
                    td.textContent = text;
                    newRow.appendChild(td);
                });

                tbody.appendChild(newRow);

                // Clear fields
                document.getElementById("<%= txtSlNo.ClientID %>").value = "";
                document.getElementById("<%= txtHiddenHazards.ClientID %>").value = "";
                document.getElementById("<%= txtConsequence.ClientID %>").value = "";
                document.getElementById("<%= txtCounterMeasures.ClientID %>").value = "";
                document.getElementById("<%= ddlPriority.ClientID %>").selectedIndex = 0;
                document.getElementById("<%= fuPhotograph.ClientID %>").value = "";
            });
        });
    </script>

    <div class="right_col" role="main">
        <div class="container">
            <%--<div class="page-title">
                <div class="title_left">
                    <h3>KYT REPORT</h3>
                </div>
            </div>--%>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h4>KYT REPORT</h4>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">

                                <!-- Date -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblDate" runat="server" Text="Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Select Date" TextMode="Date"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDate" runat="server"
                                                ControlToValidate="txtDate"
                                                ErrorMessage="Please enter Date."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <!-- Worksite -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblWorksite" runat="server" Text="Worksite:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtWorksite" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Worksite"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvWorksite" runat="server" ControlToValidate="txtWorksite" ErrorMessage="Worksite is required." ForeColor="Red" Display="Dynamic">
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
                                                ErrorMessage="Department is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
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
                                                ErrorMessage="Please enter Location."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>





                                <!-- JOB ID -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblJobID" runat="server" Text="Job ID:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtJobID" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Job ID"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvJobID" runat="server"
                                                ControlToValidate="txtJobID"
                                                ErrorMessage="Job ID is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>



                                <!-- Activity -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblActivity" runat="server" Text="Activity:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtActivity" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Activity"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvActivity" runat="server"
                                                ControlToValidate="txtActivity"
                                                ErrorMessage="Please enter Activity."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>



                                <!-- SOP NO -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblSOPNo" runat="server" Text="SOP NO:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtSOPNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter SOP NO"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvSOPNo" runat="server"
                                                ControlToValidate="txtSOPNo"
                                                ErrorMessage="Please enter SOP NO."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revSOPNo" runat="server"
                                                ControlToValidate="txtSOPNo"
                                                ValidationExpression="^[a-zA-Z0-9]+$"
                                                ErrorMessage="SOP NO must be alphanumeric."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>



                                <!-- Vender -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblVender" runat="server" Text="Vender:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtVender" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Vender"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvVender" runat="server"
                                                ControlToValidate="txtVender"
                                                ErrorMessage="Please enter Vender."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <div class="input-group input-group-sm">
                                            <asp:Button ID="btn_panel1" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="btn_panel1_Click" />
                                            <asp:Button ID="btn_reset1" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" PostBackUrl="~/KYT.aspx" />
                                            <asp:Button ID="btn_home1" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                        </div>
                                        <asp:Label ID="Label1" runat="server" ForeColor="Red" Font-Bold="true" />

                                    </div>
                                </div>

                                <div class="col-lg-12">
                                    <hr />
                                </div>

                                <div class="row col-lg-12">
                                    <div class="col-12 text-center">
                                        <h6 class="text-primary">Add Observation(s)</h6>
                                    </div>
                                </div>


                                <div class="col-lg-12">
                                    <hr />
                                </div>

                                <div class="col-lg-12 small">
                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <asp:Label ID="lblSlNo" runat="server" Text="Sl. No.:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                            <div class="input-group-sm">
                                                <asp:TextBox ID="txtSlNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Number" TextMode="Number"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvSlNo" runat="server"
                                                    ControlToValidate="txtSlNo"
                                                    ErrorMessage="Please enter Sl. No.."
                                                    ForeColor="Red"
                                                    Display="Dynamic">
                                                </asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <asp:Label ID="lblHiddenHazards" runat="server" Text="Hidden Hazards:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                            <div class="input-group-sm">
                                                <asp:TextBox ID="txtHiddenHazards" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Hidden Hazards"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvHiddenHazards" runat="server"
                                                    ControlToValidate="txtHiddenHazards"
                                                    ErrorMessage="Please enter Hidden Hazards."
                                                    ForeColor="Red"
                                                    Display="Dynamic">
                                                </asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <asp:Label ID="lblConsequence" runat="server" Text="Consequence:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                            <div class="input-group-sm">
                                                <asp:TextBox ID="txtConsequence" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Consequence"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvConsequence" runat="server" ControlToValidate="txtConsequence" ErrorMessage="Please enter Consequence." ForeColor="Red" Display="Dynamic">
                                                </asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <asp:Label ID="lblCounterMeasures" runat="server" Text="Counter Measures:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                            <div class="input-group-sm">
                                                <asp:TextBox ID="txtCounterMeasures" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Counter Measures"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvCounterMeasures" runat="server" ControlToValidate="txtCounterMeasures" ErrorMessage="Please enter Counter Measures." ForeColor="Red" Display="Dynamic">
                                                </asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <asp:Label ID="lblPriority" runat="server" Text="Priority:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                            <div class="input-group-sm">
                                                <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-control form-control-sm rounded">
                                                    <asp:ListItem Text="Select Priority" Value="" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="P1" Value="P1"></asp:ListItem>
                                                    <asp:ListItem Text="P2" Value="P2"></asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="rfvPriority" runat="server" ControlToValidate="ddlPriority" InitialValue="" ErrorMessage="Please select a Priority." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <asp:Label ID="lblPhotograph" runat="server" Text="Upload Photograph:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                            <div class="input-group-sm">
                                                <asp:FileUpload ID="fuPhotograph" runat="server" CssClass="form-control form-control-sm rounded" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="fuPhotograph"></asp:RequiredFieldValidator>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- KYT Add More Button -->
                                <div class="row col-lg-12">
                                    <div class="col-12 text-center">
                                        <button type="button" id="btnAddKYT" class="btn btn-success btn-sm">Add More KYT</button>
                                    </div>
                                </div>

                                <asp:HiddenField ID="hfKYTGridData" runat="server" />
                                <script type="text/javascript">
                                    function validateFormBeforeSubmit() {
                                        var isValid = true;
                                        var errorMessage = "";

                                        // Static fields check (Dropdowns and Textboxes)
                                        var fieldsToCheck = [
                                            { id: '<%= txtWorksite.ClientID %>', type: 'textbox', name: 'Worksite' },
                                            { id: '<%= txtDepartment.ClientID %>', type: 'textbox', name: 'Department' },
                                            { id: '<%= txtLocation.ClientID %>', type: 'textbox', name: 'Location' },
                                            { id: '<%= txtDate.ClientID %>', type: 'textbox', name: 'Date (dd-mm-yyyy)' },
                                            { id: '<%= txtJobID.ClientID %>', type: 'textbox', name: 'Job ID' },
                                            { id: '<%= txtActivity.ClientID %>', type: 'textbox', name: 'Activity' },
                                            { id: '<%= txtSOPNo.ClientID %>', type: 'textbox', name: 'SOP NO' },
                                            { id: '<%= txtVender.ClientID %>', type: 'textbox', name: 'Vendor' },
                                          //  { id: '<%= txtSlNo.ClientID %>', type: 'textbox', name: 'Sl. No.' },
                                          //  { id: '<%= txtHiddenHazards.ClientID %>', type: 'textbox', name: 'Hidden Hazards' },
                                          //  { id: '<%= txtConsequence.ClientID %>', type: 'textbox', name: 'Consequence' },
                                          //  { id: '<%= txtCounterMeasures.ClientID %>', type: 'textbox', name: 'Counter Measures' },
                                          //  { id: '<%= ddlPriority.ClientID %>', type: 'dropdown', name: 'Priority' },
                                         //   { id: '<%= fuPhotograph.ClientID %>', type: 'file', name: 'Photograph' }
                                        ];

                                        for (var i = 0; i < fieldsToCheck.length; i++) {
                                            var fieldInfo = fieldsToCheck[i];
                                            var field = document.getElementById(fieldInfo.id);
                                            if (field) {
                                                if (fieldInfo.type === 'textbox') {
                                                    if (field.value.trim() === "") {
                                                        isValid = false;
                                                        errorMessage += "- Please fill " + fieldInfo.name + ".\n";
                                                        field.classList.add("is-invalid");
                                                    } else {
                                                        field.classList.remove("is-invalid");
                                                    }
                                                } else if (fieldInfo.type === 'dropdown') {
                                                    if (field.value === "0" || field.selectedIndex === 0) {
                                                        isValid = false;
                                                        errorMessage += "- Please select " + fieldInfo.name + ".\n";
                                                        field.classList.add("is-invalid");
                                                    } else {
                                                        field.classList.remove("is-invalid");
                                                    }
                                                } else if (fieldInfo.type === 'file') {
                                                    if (field.files.length === 0) {
                                                        isValid = false;
                                                        errorMessage += "- Please upload a Photograph.\n";
                                                        field.classList.add("is-invalid");
                                                    } else {
                                                        field.classList.remove("is-invalid");
                                                    }
                                                }
                                            }
                                        }

                                        // If there are any validation errors, show the error messages
                                        if (!isValid) {
                                            alert("Please complete all required fields:\n\n" + errorMessage);
                                            return false;
                                        }
                                        return true;
                                    }

                                    function getFriendlyName(id) {
                                        var nameMap = {
                                            '<%= txtWorksite.ClientID %>': "Worksite",
                                            '<%= txtDepartment.ClientID %>': "Department",
                                            '<%= txtLocation.ClientID %>': "Location",
                                            '<%= txtDate.ClientID %>': "Date (dd-mm-yyyy)",
                                            '<%= txtJobID.ClientID %>': "Job ID",
                                            '<%= txtActivity.ClientID %>': "Activity",
                                            '<%= txtSOPNo.ClientID %>': "SOP NO",
                                            '<%= txtVender.ClientID %>': "Vendor",
                                            '<%= txtSlNo.ClientID %>': "Sl. No.",
                                            //   '<%= txtHiddenHazards.ClientID %>': "Hidden Hazards",
                                            //   '<%= txtConsequence.ClientID %>': "Consequence",
                                            //   '<%= txtCounterMeasures.ClientID %>': "Counter Measures",
                                            //   '<%= ddlPriority.ClientID %>': "Priority",
                                            //   '<%= fuPhotograph.ClientID %>': "Photograph"
                                            };
                                            return nameMap[id] || "this field";
                                        }

                                        window.onload = function () {
                                        document.getElementById('<%= btnSubmit.ClientID %>').onclick = function (e) {
                                            if (!validateFormBeforeSubmit()) {
                                                e.preventDefault();
                                            }
                                        };
                                    };
                                </script>


                                <!-- KYT Data Table -->
                                <div class="col-lg-12" id="KYTGrid">
                                </div>

                                <div class="col-md-3">
                                    <div class="mb-3 text-center">
                                        <div class="d-flex justify-content-center gap-2">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm fw-bold px-3" ValidationGroup="Submit" CausesValidation="true" OnClick="SubmitKYTIncidentData_Click" />
                                            <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm fw-bold px-3" CausesValidation="false" OnClick="BtnReset_Click" />
                                            <asp:Button ID="btn_home" runat="server" Text="Home" CssClass="btn btn-danger btn-sm fw-bold px-3" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                        </div>

                                        <div class="mt-2">
                                            <asp:Label ID="lblMessage" runat="server" CssClass="fw-bold" />
                                        </div>
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
