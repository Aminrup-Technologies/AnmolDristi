<%@ Page Title="CSM : Line Walk Report" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Line_Walk_Status.aspx.cs" Inherits="AnmolDristi.Line_Walk_Status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style type="text/css">
        button, .buttons, .btn, .modal-footer .btn + .btn {
            margin-bottom: 5px;
            margin-left: 5px !important;
            padding: 0.1rem !important 0.375rem;
        }

        h2.green-heading {
            color: #26B99A !important;
            font-weight: 500 !important;
            font-size: 1.5rem !important;
        }

        .form-check-inline input[type="radio"] {
            margin-right: 5px;
            margin-left: 10px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />

    <script type="text/javascript">
        let members = [];

        window.onload = function () {
            setupRadioChange();
            toggleEmpFields();
        };

        <%--function setupRadioChange() {
            const radios = document.getElementsByName('<%= RBL_EmpType.UniqueID %>');
            radios.forEach(radio => {
                radio.addEventListener("change", toggleEmpFields);
            });
        }--%>

       <%-- function toggleEmpFields() {
            const selectedType = document.querySelector(`input[name="<%= RBL_EmpType.UniqueID %>"]:checked`).value;
            const empCode = document.getElementById("<%= TB_EmpCode.ClientID %>");
            const empName = document.getElementById("<%= TB_EmpName.ClientID %>");

            if (selectedType === "Internal") {
                empCode.disabled = false;
                empName.readOnly = true;
                empName.value = "";
            } else {
                empCode.value = "";
                empCode.disabled = true;
                empName.readOnly = false;
                empName.value = "";
            }
        }--%>

       <%-- function fetchEmpName() {
            const empCode = document.getElementById("<%= TB_EmpCode.ClientID %>").value.trim();
            if (empCode !== "") {
                PageMethods.GetEmpName(empCode,
                    function (result) {
                        document.getElementById("<%= TB_EmpName.ClientID %>").value = result;
                    },
                    function () {
                        showNotification("Error", "Failed to fetch employee name.", "error");
                    });
            }
        }--%>

       <%-- function addMember() {
            const type = document.querySelector(`input[name="<%= RBL_EmpType.UniqueID %>"]:checked`).value;
                const code = document.getElementById("<%= TB_EmpCode.ClientID %>").value.trim();
                const name = document.getElementById("<%= TB_EmpName.ClientID %>").value.trim();

                if ((type === "Internal" && (!code || !name)) || (type === "External" && !name)) {
                    showNotification("Validation", "Please fill all required fields.", "warning");
                    return;
                }

                members.push({ type, code, name });
                updateTable();

                document.getElementById("<%= TB_EmpCode.ClientID %>").value = "";
                document.getElementById("<%= TB_EmpName.ClientID %>").value = "";
            toggleEmpFields();
        }--%>

        function updateTable() {
            const tbody = document.querySelector("#tblMembers tbody");
            tbody.innerHTML = "";

            members.forEach((m, i) => {
                const row = tbody.insertRow();
                row.insertCell(0).innerText = m.type;
                row.insertCell(1).innerText = m.code || "-";
                row.insertCell(2).innerText = m.name;
                row.insertCell(3).innerHTML = `<button class='btn btn-danger btn-sm' type='button' onclick='removeMember(${i})'>Delete</button>`;
            });

            document.getElementById("<%= HF_MemberList.ClientID %>").value = JSON.stringify(members);
        }

        function removeMember(index) {
            members.splice(index, 1);
            updateTable();
        }

       <%-- function validateFormBeforeSubmit() {
            const lbl = document.getElementById("<%= lbl_panel2_msg.ClientID %>");
            if (members.length === 0) {
                lbl.innerText = "❌ Please add at least one member before proceeding.";
                lbl.style.color = "red";
                showNotification("Required", "Please add at least one member to proceed.", "error");
                return false;
            }

            lbl.innerText = "✅ Validation passed. Proceeding...";
            lbl.style.color = "green";
            return true;
        }--%>

        function showNotification(title, text, type) {
            new PNotify({
                title: title,
                text: text,
                type: type,
                styling: 'bootstrap3',
                delay: 3000,
            });
        }

        let observationRows = []; // To hold the added observation rows

       <%-- function addMore() {
            const areaLocation = document.getElementById('<%= TB_location.ClientID %>').value;
            const observation = document.getElementById('<%= TB_Observation_Points.ClientID %>').value;
            const recommendation = document.getElementById('<%= TB_Recommendation_Points.ClientID %>').value;
            const responsibility = document.getElementById('<%= TB_Responsibility.ClientID %>').value;
            const targetDate = document.getElementById('<%= TB_TargetDate.ClientID %>').value;
            const remarks = document.getElementById('<%= TB_Remarks.ClientID %>').value;
            const snapFile = document.getElementById('<%= File_Snaps.ClientID %>').value;

            if (!areaLocation || !observation || !recommendation || !responsibility || !targetDate || !remarks || !snapFile) {
                alert("Please fill all fields and upload a file.");
                return;
            }

            __doPostBack('<%= btnAddToGrid.UniqueID %>', '');
        }--%>


        function showBootstrapModal() {
            var myModal = new bootstrap.Modal(document.getElementById('employeeModal'));
            myModal.show();
        }

        function showObservationModal() {
            $('#observationModal').modal('show');
        }

        function closeObservationModal() {
            $('#observationModal').modal('hide');
        }

    </script>

    <asp:HiddenField ID="HF_MemberList" runat="server" />

    <div class="right_col" role="main">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>CSM : Line Walk Report</h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">
                            <h2 class="green-heading">Step 1: Job Details</h2>
                            <hr />

                            <div class="row">
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_Date" runat="server" AssociatedControlID="TB_Date" Text="Date" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Date" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Date" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="TB_Date" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_ID" runat="server" AssociatedControlID="TB_ID" Text="Job ID" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_ID" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_ID" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_ID" runat="server" ValidationGroup="Submit" ControlToValidate="TB_ID" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <asp:TextBox ID="TB_ID" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-6">
                                        <asp:Label ID="Lbl_JD" runat="server" AssociatedControlID="TB_JD" Text="Job Description" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_JD" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_JD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_JD" runat="server" ValidationGroup="Submit" ControlToValidate="TB_JD" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <asp:TextBox ID="TB_JD" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>


                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="mb-4 text-center">
                                        <asp:Label ID="lbl_panel1_msg" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SUBMIT!" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="d-flex justify-content-center gap-2 mt-2">
                                            <asp:Button ID="btn_panel1_save" runat="server" Text="Proceed Next" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" />
                                            <asp:Button ID="btn_panel1_rst" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" />
                                            <asp:Button ID="btn_panel1_cncl" runat="server" Text="HOME" CssClass="btn btn-danger btn-sm" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <hr>
                            <h2 class="green-heading">Step 2[A]: Team Members</h2>
                            <hr />

                            <%--<div class="row">
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_EmployeeType" runat="server" Text="Employee Type" ForeColor="Blue" Font-Bold="true"></asp:Label><br />
                                        <asp:RadioButtonList ID="RBL_EmpType" runat="server" RepeatDirection="Horizontal" CssClass="form-check-inline">
                                            <asp:ListItem Text="Internal" Value="Internal" Selected="True" />
                                            <asp:ListItem Text="External" Value="External" />
                                        </asp:RadioButtonList>
                                    </div>
                                </div>

                                <div class="col-md-3" id="divEmpCode" runat="server">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_EmpCode" runat="server" AssociatedControlID="TB_EmpCode" Text="Employee Code" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:TextBox ID="TB_EmpCode" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="false" onblur="fetchEmpName();" />
                                    </div>
                                </div>

                                <div class="col-md-3" id="divEmpName" runat="server">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_EmpName" runat="server" AssociatedControlID="TB_EmpName" Text="Employee Name" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:TextBox ID="TB_EmpName" runat="server" CssClass="form-control form-control-sm rounded"  />
                                    </div>
                                </div>

                                <div class="col-md-2 d-flex align-items-center">
                                    <asp:Button ID="Btn_AddMember" runat="server" Text="Add Member" CssClass="btn btn-success btn-sm w-100" OnClick="Btn_AddMember_Click" OnClientClick="addMember(); return false;" />
                                </div>

                            </div>

                            <div class="row">
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered">
                                    <Columns>
                                        <asp:BoundField DataField="EmpType" HeaderText="Type" />
                                        <asp:BoundField DataField="EmpCode" HeaderText="Code" />
                                        <asp:BoundField DataField="EmpName" HeaderText="Name" />
                                    </Columns>
                                </asp:GridView>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="mb-4 text-center">
                                        <asp:Label ID="lbl_panel2_msg" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SUBMIT!" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="d-flex justify-content-center gap-2 mt-2">
                                            <asp:Button ID="btn_panel2_save" runat="server" Text="Proceed next" CssClass="btn btn-primary btn-sm" OnClientClick="return validateFormBeforeSubmit();" />
                                            <asp:Button ID="btn_panel2_rst" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" />
                                            <asp:Button ID="btn_panel2_cncl" runat="server" Text="HOME" CssClass="btn btn-danger btn-sm" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>--%>


                            <!-- Trigger Button -->
                            <div class="container mt-5">
                                <asp:Button ID="btnOpenModal" runat="server" CssClass="btn btn-primary" Text="Add Employee"
                                    OnClientClick="showBootstrapModal(); return false;" />
                            </div>

                            
                            <div class="modal fade" id="employeeModal" tabindex="-1" role="dialog" aria-labelledby="employeeModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">

                                        <div class="modal-header">
                                            <h5 class="modal-title" id="employeeModalLabel">Employee Details</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>

                                        <div class="modal-body">


                                            <div class="form-group">
                                                <asp:Label ID="Emp_type_lbl" runat="server" Text="Employee Type"  ForeColor="Blue" Font-Bold="true" />
                                                <asp:RadioButtonList ID="rblEmpType" runat="server" CssClass="form-check form-check-inline" RepeatDirection="Horizontal">
                                                    <asp:ListItem Text="Internal" Value="Internal" />
                                                    <asp:ListItem Text="External" Value="External" />
                                                </asp:RadioButtonList>
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="Empcode_lbl" runat="server" Text="Employee Code" ForeColor="Blue" Font-Bold="true"/>
                                                <asp:TextBox ID="txtEmpCode" runat="server" CssClass="form-control form-control-sm rounded" />
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="Empname_lbl" runat="server" Text="Employee Name" ForeColor="Blue" Font-Bold="true"/>
                                                <asp:TextBox ID="txtEmpName" runat="server" CssClass="form-control form-control-sm rounded" />
                                            </div>
                                        </div>

                                        <div class="modal-footer">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" OnClick="btnSave_Click" />
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false"
                                    CssClass="table table-bordered table-hover table-striped"
                                    HeaderStyle-CssClass="thead-dark"
                                    GridLines="None">
                                    <Columns>
                                        <asp:BoundField DataField="EmpType" HeaderText="Type" SortExpression="EmpType" />
                                        <asp:BoundField DataField="EmpCode" HeaderText="Code" SortExpression="EmpCode" />
                                        <asp:BoundField DataField="EmpName" HeaderText="Name" SortExpression="EmpName" />
                                       
                                    </Columns>
                                </asp:GridView>
                            </div>


                            <hr>
                            <h2 class="green-heading">Step 3: Observations & Recommendations</h2>
                            <hr />


                            <%-- <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_location" runat="server" AssociatedControlID="TB_location" Text="Area/Location" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_location" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_location" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_location" runat="server" ValidationGroup="Submit" ControlToValidate="TB_location" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <div id="AreaInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_location" runat="server" CssClass="form-control form-control-sm rounded me-2"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Observation_Points" runat="server" AssociatedControlID="TB_Observation_Points" Text="Detailed Observation Point" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Observation_Points" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Observation_Points" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_Observation_Points" runat="server" ValidationGroup="Submit" ControlToValidate="TB_Observation_Points" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <div id="observationInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_Observation_Points" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Observation"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Recommendation_Points" runat="server" AssociatedControlID="TB_Recommendation_Points" Text="Recommendation Given" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Recommendation_Points" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Recommendation_Points" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_Recommendation_Points" runat="server" ValidationGroup="Submit" ControlToValidate="TB_Recommendation_Points" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <div id="recommendationInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_Recommendation_Points" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Recommendation"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Responsibility" runat="server" AssociatedControlID="TB_Responsibility" Text="Responsibility" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_Responsibility" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Responsibility" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_Responsibility" runat="server" ValidationGroup="Submit" ControlToValidate="TB_Responsibility" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <div id="responsibilityInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_Responsibility" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Responsibility"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_TargetDate" runat="server" AssociatedControlID="TB_TargetDate" Text="Target Date" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TargetDate" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_TargetDate" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <div id="targetDateInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_TargetDate" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="YYYY-MM-DD" TextMode="Date"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Remarks" runat="server" AssociatedControlID="TB_Remarks" Text="Remarks" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_Remarks" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Remarks" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_Remarks" runat="server" ValidationGroup="Submit" ControlToValidate="TB_Remarks" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <div id="remarksInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_Remarks" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Remarks"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Snaps" runat="server" AssociatedControlID="File_Snaps" Text="Upload Snaps" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_File_Snaps" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="File_Snaps" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <div id="snapUploadContainer">
                                            <div class="d-flex mb-2">
                                                <asp:FileUpload ID="File_Snaps" runat="server" CssClass="form-control form-control-sm rounded me-2" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Button ID="btnAddToGrid" runat="server" OnClick="btnAddToGrid_Click" Style="display: none;" />
                                        <button type="button" class="btn btn-success" onclick="addMore()">Add More</button>
                                    </div>
                                </div>
                            </div>--%>


                            <asp:Button ID="btnOpenObservationModal" runat="server" Text="Add Observation"
                                CssClass="btn btn-primary" OnClientClick="showObservationModal(); return false;" />

                            
                            <div class="modal fade" id="observationModal" tabindex="-1" role="dialog" aria-labelledby="observationModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg" role="document">
                                    <div class="modal-content">

                                        <div class="modal-header">
                                            <h5 class="modal-title" id="observationModalLabel" >Add Observation Details</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>

                                        <div class="modal-body">
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <asp:Label  ID="Area_lbl" runat ="server" Text="Area/Location" ForeColor="Blue" Font-Bold="true"/>
                                                    <asp:TextBox ID="txtAreaLocation" runat="server" CssClass="form-control form-control-sm rounded" />
                                                </div>
                                                
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="Observatio_lbl" runat="server" Text="Observation" ForeColor="Blue" Font-Bold="true"/>
                                                <asp:TextBox ID="txtObservation" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="3" />
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="Rexommendation_lbl" runat="server" Text="Recommendation Given" ForeColor="Blue" Font-Bold="true"/>
                                                <asp:TextBox ID="txtRecommendation" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="2" />
                                            </div>

                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <asp:Label ID="Responsibility_lbl" runat="server" Text="Responsibility" ForeColor="Blue" Font-Bold="true"/>
                                                    <asp:TextBox ID="txtResponsibility" runat="server" CssClass="form-control form-control-sm rounded" />
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <asp:Label ID="Targetdt_lbl" runat="server" Text="Target Date" ForeColor="Blue" Font-Bold="true"/>
                                                    <asp:TextBox ID="txtTargetDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="Remark_lbl" runat="server" Text="Remarks" ForeColor="Blue" Font-Bold="true"/>
                                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="2" />
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="Snap_lbl" runat="server" Text="Upload Snap" ForeColor="Blue" Font-Bold="true"/>
                                                <asp:FileUpload ID="fileSnap" runat="server" CssClass="form-control-file" />
                                            </div>

                                            
                                        </div>

                                        <div class="modal-footer">
                                            <asp:Button ID="btnSaveObservation" runat="server" Text="Save" CssClass="btn btn-success"  />
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>

                                    </div>
                                </div>
                            </div>



                            <div class="row">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered">
                                    <Columns>
                                        <asp:BoundField DataField="Area" HeaderText="Area" />
                                        <asp:BoundField DataField="Observation" HeaderText="Observation" />
                                        <asp:BoundField DataField="Recommendation" HeaderText="Recommendation" />
                                        <asp:BoundField DataField="Responsibility" HeaderText="Responsibility" />
                                        <asp:BoundField DataField="TargetDate" HeaderText="Target Date" />
                                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                        <asp:TemplateField HeaderText="Snap">
                                            <ItemTemplate>
                                                <a href='<%# ResolveUrl(Eval("FilePath").ToString()) %>' target="_blank">View</a>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>

                        <hr>
                        <h2 class="green-heading">Step-4 : Final Submission</h2>
                        <hr />

                        <div class="row">
                            <div class="col-md-12">
                                <div class="mb-4 text-center">
                                    <asp:Label ID="lbl_msg" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SUBMIT!" ForeColor="Blue" Font-Bold="true" Font-Size="Small">
                                    </asp:Label>

                                    <div class="d-flex justify-content-center gap-2 mt-2">
                                        <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" CausesValidation="true" OnClick="BtnSubmit_Click" />
                                        <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                                        <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-danger btn-sm" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
</asp:Content>
