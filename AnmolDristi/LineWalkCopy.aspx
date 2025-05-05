<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Line_Walk.aspx.cs" Inherits="AnmolDristi.Line_Walk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>

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


        $(document).ready(function () {
            var rblEmpType = $('#<%= rblEmpType.ClientID %>');
           var txtEmpCode = $('#<%= txtEmpCode.ClientID %>');
           var txtEmpName = $('#<%= txtEmpName.ClientID %>');

           function toggleFields() {
               if ($('#<%= rblEmpType.ClientID %>_0').is(':checked')) {
            // Internal selected
            txtEmpCode.prop('disabled', false).val('');
            txtEmpName.prop('readonly', true).val('');
        } else if ($('#<%= rblEmpType.ClientID %>_1').is(':checked')) {
            // External selected
            txtEmpCode.prop('disabled', true).val('');
            txtEmpName.prop('readonly', false).val('');
        }
    }

    function toggleCodeValidator() {
        var isInternal = $('#<%= rblEmpType.ClientID %>_0').is(':checked');
        var validator = document.getElementById('<%= RFV_txtEmpCode.ClientID %>');
        if (validator) {
            validator.enabled = isInternal;
        }
    }

    rblEmpType.change(function () {
        toggleFields();
        toggleCodeValidator();
    });

    toggleFields();
    toggleCodeValidator();

    $('#<%= txtEmpCode.ClientID %>').on('change', function () {
        var empCode = $(this).val().trim();
        if (empCode !== "") {
            $.ajax({
                type: "POST",
                url: "Line_Walk.aspx/GetEmployeeName",
                data: JSON.stringify({ empCode: empCode }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d) {
                        $('#<%= txtEmpName.ClientID %>').val(response.d);
                    } else {
                        $('#<%= txtEmpName.ClientID %>').val("");
                        alert("Employee code not found!");
                    }
                },
                error: function (xhr, status, error) {
                    alert("AJAX error: " + error);
                }
            });
        }
    });
       });


        $(document).ready(function () {
            // Reset modal inputs when closed
            $('#employeeModal').on('hidden.bs.modal', function () {
                // Clear all inputs, selects, textareas inside the modal
                $(this).find('input[type=text], input[type=hidden], input[type=number], textarea').val('');
                $(this).find('input[type=radio], input[type=checkbox]').prop('checked', false);
                $(this).find('select').prop('selectedIndex', 0);
                $(this).find('input, select, textarea').prop('disabled', false); // optionally re-enable all
            });
        });

    </script>


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

        input:disabled {
    background-color: #eee;
}
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />


    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5>Main Heading</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Sub Heading</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <h2 class="green-heading">Step 1: Job Details</h2>
                            <hr />

                            <div class="row">
                                <!-- Date -->
                                <div class="col-md-3 mb-3">
                                    <asp:Label ID="Lbl_Date" runat="server" Text="Date" AssociatedControlID="TB_Date" ForeColor="Blue" Font-Bold="true" />
                                    <asp:TextBox ID="TB_Date" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Date" runat="server" ControlToValidate="TB_Date" ErrorMessage="* Date required" ForeColor="Red" Display="Dynamic" ValidationGroup="Submit" />
                                </div>

                                <!-- Job ID -->
                                <div class="col-md-3 mb-3">
                                    <asp:Label ID="Lbl_ID" runat="server" Text="Job ID" AssociatedControlID="TB_ID" ForeColor="Blue" Font-Bold="true" />
                                    <asp:TextBox ID="TB_ID" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFV_TB_ID" runat="server" ControlToValidate="TB_ID" ErrorMessage="* Job ID required" ForeColor="Red" Display="Dynamic" ValidationGroup="Submit" />
                                    <asp:RegularExpressionValidator ID="REV_TB_ID" runat="server" ControlToValidate="TB_ID" ErrorMessage="* Only letters & numbers" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9 ]+$" Display="Dynamic" ValidationGroup="Submit" />
                                </div>

                                <!-- Job Description -->
                                <div class="col-md-6 mb-3">
                                    <asp:Label ID="Lbl_JD" runat="server" Text="Job Description" AssociatedControlID="TB_JD" ForeColor="Blue" Font-Bold="true" />
                                    <asp:TextBox ID="TB_JD" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFV_TB_JD" runat="server" ControlToValidate="TB_JD" ErrorMessage="* Description required" ForeColor="Red" Display="Dynamic" ValidationGroup="Submit" />
                                    <asp:RegularExpressionValidator ID="REV_TB_JD" runat="server" ControlToValidate="TB_JD" ErrorMessage="* Only alphabets allowed" ForeColor="Red" ValidationExpression="^[a-zA-Z\s,\/]+$" Display="Dynamic" ValidationGroup="Submit" />
                                </div>

                                <asp:Button ID="Save" runat="server" CssClass="btn btn-primary btn-sm" />

                            </div>

                            <!-- Step 2[A]: Team Members -->
                            <hr />
                            <h2 class="green-heading">Step 2[A]: Team Members</h2>
                            <hr />

                            <div class="container mt-2">
                                <asp:Button ID="btnOpenModal" runat="server" Text="Add Employee" CssClass="btn btn-primary" OnClientClick="showBootstrapModal(); return false;" />
                            </div>

                            <!-- Employee Modal -->
                            <div class="modal fade" id="employeeModal" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">

                                        <div class="modal-header">
                                            <h5 class="modal-title">Employee Details</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>

                                        <div class="modal-body">

                                            <!-- Employee Type -->
                                            <div class="form-group">
                                                <asp:Label ID="Emp_type_lbl" runat="server" Text="Employee Type" ForeColor="Blue" Font-Bold="true" />
                                                <asp:RadioButtonList ID="rblEmpType" runat="server" CssClass="form-check form-check-inline" ClientIDMode="Static" RepeatDirection="Horizontal" ValidationGroup="SaveEmployee" >
                                                    <asp:ListItem Text="Internal" Value="Internal" Selected="True"/>
                                                    <asp:ListItem Text="External" Value="External" />
                                                </asp:RadioButtonList>
                                                <asp:RequiredFieldValidator ID="RFV_rblEmpType" runat="server" ControlToValidate="rblEmpType" InitialValue="" ErrorMessage="* Select Type" ForeColor="Red" Display="Dynamic" ValidationGroup="SaveEmployee" />
                                            </div>

                                            <!-- Employee Code -->
                                            <div class="form-group">
                                                <asp:Label ID="Empcode_lbl" runat="server" Text="Employee Code" ForeColor="Blue" Font-Bold="true" />
                                                <asp:TextBox ID="txtEmpCode" runat="server" CssClass="form-control form-control-sm rounded" ClientIDMode="Static" />
                                                <asp:RequiredFieldValidator ID="RFV_txtEmpCode" runat="server" ControlToValidate="txtEmpCode" ErrorMessage="* Code required" ForeColor="Red" Display="Dynamic" ValidationGroup="SaveEmployee" />
                                            </div>

                                            <!-- Employee Name -->
                                            <div class="form-group">
                                                <asp:Label ID="Empname_lbl" runat="server" Text="Employee Name" ForeColor="Blue" Font-Bold="true" />
                                                <asp:TextBox ID="txtEmpName" runat="server" CssClass="form-control form-control-sm rounded" ClientIDMode="Static" />
                                                <asp:RequiredFieldValidator ID="RFV_txtEmpName" runat="server" ControlToValidate="txtEmpName" ErrorMessage="* Name required" ForeColor="Red" Display="Dynamic" ValidationGroup="SaveEmployee" />
                                            </div>

                                        </div>

                                        <div class="modal-footer">
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="SaveEmployee" OnClick="btnSave_Click" />
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <!-- Employee Grid -->
                            <div class="row">
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" GridLines="None" HeaderStyle-CssClass="thead-dark">
                                    <Columns>
                                        <asp:BoundField DataField="EmpType" HeaderText="Type" />
                                        <asp:BoundField DataField="EmpCode" HeaderText="Code" />
                                        <asp:BoundField DataField="EmpName" HeaderText="Name" />
                                    </Columns>
                                </asp:GridView>
                            </div>

                            <!-- Step 3: Observations -->
                            <hr />
                            <h2 class="green-heading">Step 3: Observations & Recommendations</h2>
                            <hr />

                            <div class="container mt-2">
                                <asp:Button ID="btnOpenObservationModal" runat="server" Text="Add Observation" CssClass="btn btn-primary" OnClientClick="showObservationModal(); return false;" />
                            </div>

                            <!-- Observation Modal -->
                            <div class="modal fade" id="observationModal" tabindex="-1" role="dialog">
                                <div class="modal-dialog modal-lg" role="document">
                                    <div class="modal-content">

                                        <div class="modal-header">
                                            <h5 class="modal-title">Add Observation Details</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>

                                        <div class="modal-body">

                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <asp:Label ID="Area_lbl" runat="server" Text="Area/Location" ForeColor="Blue" Font-Bold="true" />
                                                    <asp:TextBox ID="txtAreaLocation" runat="server" CssClass="form-control form-control-sm rounded" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtAreaLocation" runat="server" ControlToValidate="txtAreaLocation" ErrorMessage="* Area required" ForeColor="Red" ValidationGroup="SaveObservation" Display="Dynamic" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="Observatio_lbl" runat="server" Text="Observation" ForeColor="Blue" Font-Bold="true" />
                                                <asp:TextBox ID="txtObservation" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="3" />
                                                <asp:RequiredFieldValidator ID="RFV_txtObservation" runat="server" ControlToValidate="txtObservation" ErrorMessage="* Observation required" ForeColor="Red" ValidationGroup="SaveObservation" Display="Dynamic" />
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="Rexommendation_lbl" runat="server" Text="Recommendation" ForeColor="Blue" Font-Bold="true" />
                                                <asp:TextBox ID="txtRecommendation" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="2" />
                                                <asp:RequiredFieldValidator ID="RFV_txtRecommendation" runat="server" ControlToValidate="txtRecommendation" ErrorMessage="* Recommendation required" ForeColor="Red" ValidationGroup="SaveObservation" Display="Dynamic" />
                                            </div>

                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <asp:Label ID="Responsibility_lbl" runat="server" Text="Responsibility" ForeColor="Blue" Font-Bold="true" />
                                                    <asp:TextBox ID="txtResponsibility" runat="server" CssClass="form-control form-control-sm rounded" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtResponsibility" runat="server" ControlToValidate="txtResponsibility" ErrorMessage="* Responsibility required" ForeColor="Red" ValidationGroup="SaveObservation" Display="Dynamic" />
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <asp:Label ID="Targetdt_lbl" runat="server" Text="Target Date" ForeColor="Blue" Font-Bold="true" />
                                                    <asp:TextBox ID="txtTargetDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" />
                                                    <asp:RequiredFieldValidator ID="RFV_txtTargetDate" runat="server" ControlToValidate="txtTargetDate" ErrorMessage="* Target Date required" ForeColor="Red" ValidationGroup="SaveObservation" Display="Dynamic" />
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="Remark_lbl" runat="server" Text="Remarks" ForeColor="Blue" Font-Bold="true" />
                                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="2" />
                                                <asp:RequiredFieldValidator ID="RFV_txtRemarks" runat="server" ControlToValidate="txtRemarks" ErrorMessage="* Remarks required" ForeColor="Red" ValidationGroup="SaveObservation" Display="Dynamic" />
                                            </div>

                                            <div class="form-group">
                                                <asp:Label ID="Snap_lbl" runat="server" Text="Upload Snap" ForeColor="Blue" Font-Bold="true" />
                                                <asp:FileUpload ID="fileSnap" runat="server" CssClass="form-control-file" />
                                                <asp:RequiredFieldValidator ID="RFV_fileSnap" runat="server" ControlToValidate="fileSnap" ErrorMessage="* Snaps required" ForeColor="Red" ValidationGroup="SaveObservation" Display="Dynamic" />
                                            </div>

                                        </div>

                                        <div class="modal-footer">
                                            <asp:Button ID="btnSaveObservation" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="SaveObservation" OnClick="btnAddToGrid_Click" />
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <!-- Observation Grid -->
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

                            <!-- Footer Buttons -->
                            <div class="container d-flex justify-content-center gap-2 mt-3">
                                <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" OnClick="BtnSubmit_Click" />
                                <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                                <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-danger btn-sm" CausesValidation="false" PostBackUrl="~/home.aspx" />
                            </div>



                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>


</asp:Content>
