<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Line_Walk.aspx.cs" Inherits="AnmolDristi.Line_Walk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>

        function showMemberModal(id) {
            if (id != null) {
                loadMemberData(id);
            }
            var myModal = new bootstrap.Modal(document.getElementById('employeeModal'));
            myModal.show();
        }

        //function showObservationModal(detailId) {
        //    if (detailId != null) {
        //        showDetailModal(detailId);
        //    }
        //    $('#observationModal').modal('show');
        //}

        function showObservationModal(detailId) {
            var modal = $('#observationModal');

            if (detailId != null) {
                // 🟢 Edit Mode
                showDetailModal(detailId); // loads data
                modal.find('.modal-title').text('Edit Observation Details');
            } else {
                // 🟢 Add Mode → clear fields
                modal.find('input[type=text], textarea, select').val('');
                modal.find('input:checkbox, input:radio').prop('checked', false);
                modal.find('input[type=file]').val('');
                modal.find('input[type=date]').val('');
                $('#lblExistingSnap').text('');
                $('#lblImmediateAttachment').text('');
                $('#txtRespoName').text('');

             
                // reset tab to first one
                modal.find('.nav-tabs a[href="#opening"]').tab('show');

                modal.find('.modal-title').text('Add Observation Details');
            }

            modal.modal('show');
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
                $(this).find('input, select, textarea').prop('disabled', false);
            });
        });

        function loadMemberData(id) {
            $.ajax({
                type: "POST",
                url: "Line_Walk.aspx/GetMemberId",
                data: JSON.stringify({ id: id }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    console.log(response);
                    const data = response.d;

                    $('#<%=txtEmpName.ClientID %>').val(data.TM_names);
                    $('#<%=txtEmpCode.ClientID %>').val(data.TM_Code);
                    $('#<%=rblEmpType.ClientID %>').val(data.TM_Type);
                    $('#<%=Entity_Id.ClientID %>').val(id);

                    $('#memberModal').modal('show');
                },
                error: function (xhr, status, error) {
                    console.error("Error loading member data:", error);
                }
            });
        }



       <%-- function showDetailModal(detailId) {
            $.ajax({
                type: "POST",
                url: "Line_Walk.aspx/GetLineWalkDetailById",
                data: JSON.stringify({ detailId: detailId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                        var data = response.d;
                        
                    if (data) {
                        $('#<%=Entity_Id.ClientID %>').val(detailId);
                        $('#<%=txtAreaLocation.ClientID %>').val(data.Location);
                        $('#<%=txtObservation.ClientID %>').val(data.Observation_Points);
                        $('#<%=txtRecommendation.ClientID %>').val(data.Recommendation_Points);
                        $('#<%=txtResponsibility.ClientID %>').val(data.Responsibility);
                        $('#<%=txtTargetDate.ClientID %>').val(data.Target_Date);
                        $('#<%=txtRemarks.ClientID %>').val(data.Remarks);
                        $('#<%=lblExistingSnap.ClientID %>').text(data.Snap_File_Path); // if you show image
                        $('#lblImmediateAttachment').text(data.ImmediateAction_Attachment || '');

                        //if (data.Snap_File_Path) {
                           // ValidatorEnable(document.getElementById('<%=RFV_fileSnap.ClientID %>'), false);
                         //} else {
                           // ValidatorEnable(document.getElementById('<%=RFV_fileSnap.ClientID %>'), true);
                        //}


                        var snapValidator = document.getElementById('<%=RFV_fileSnap.ClientID %>');
                        if (snapValidator) {
                            ValidatorEnable(snapValidator, !data.Snap_File_Path);
                        }


                        // Open modal first
                        $('#observationModal').modal('show');

                        setTimeout(function () {
                            const capaVal = data.Generate_CAPA;

                            console.log("Raw checkbox value from DB:", capaVal);

                            const isChecked = capaVal === true || capaVal === "true" || capaVal === 1 || capaVal === "1";

                            const chk = document.getElementById('ContentPlaceHolder1_chkGenerateCAPA');
                            if (chk) {
                                chk.checked = isChecked;
                                console.log("CAPA checkbox set to:", chk.checked);
                            } else {
                                console.warn("Checkbox not found.");
                            }
                        }, 100); // Keep the timeout short, just enough to ensure the modal is initialized


                    } else {
                        alert("No data found.");
                    }
                },
                error: function (xhr, status, error) {
                    console.error(error);
                }
            });
        }--%>



        function showDetailModal(detailId) {
            $.ajax({
                type: "POST",
                url: "Line_Walk.aspx/GetLineWalkDetailById",
                data: JSON.stringify({ detailId: detailId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var data = response.d;
                    if (data) {
                        $('#<%=Entity_Id.ClientID %>').val(detailId);
                 $('#<%=txtAreaLocation.ClientID %>').val(data.Location);
                 $('#<%=txtObservation.ClientID %>').val(data.Observation_Points);
                 $('#<%=txtRecommendation.ClientID %>').val(data.Recommendation_Points);
                 $('#<%=txtResponsibility.ClientID %>').val(data.Responsibility);
                 $('#<%=txtTargetDate.ClientID %>').val(data.Target_Date);
                 $('#<%=txtRemarks.ClientID %>').val(data.Remarks);
                 $('#<%=lblExistingSnap.ClientID %>').text(data.Snap_File_Path); // if you show image
                 $('#lblImmediateAttachment').text(data.ImmediateAction_Attachment || '');

                var snapValidator = document.getElementById('<%=RFV_fileSnap.ClientID %>');

                         if (snapValidator) {
                             ValidatorEnable(snapValidator, !data.Snap_File_Path);
                        }

                 document.getElementById('<%= chkGenerateCAPA.ClientID %>').checked = data.Generate_CAPA;

                 // Showing Immediate Action attachment file name (label)..
                 if (data.ImmediateAction_Attachment) {
                     $('#<%=lblImmediateAttachment.ClientID %>').text(data.ImmediateAction_Attachment);
                 } else {
                     $('#<%=lblImmediateAttachment.ClientID %>').text("");
                 }


                 $('#detailModal').modal('show');
             } else {
                 alert("No data found.");
             }
         },
         error: function (xhr, status, error) {
             console.error(error);
         }
     });
        } 








        document.addEventListener("DOMContentLoaded", function () {
            var fileInput = document.getElementById("<%= fileSnap.ClientID %>");
            var existingLabel = document.getElementById("lblExistingSnap");

            if (fileInput) {
                fileInput.addEventListener("change", function () {
                    if (fileInput.value) {
                        existingLabel.style.display = "none";
                    }
                });
            }
        });



        $(document).ready(function () {
            $('#<%= txtResponsibility.ClientID %>').on('change', function () {
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
                                $('#<%= txtRespoName.ClientID %>').text(response.d);
                            } else {
                                $('#<%= txtRespoName.ClientID %>').text("");
                                alert("Employee code not found!");
                            }
                        },
                        error: function (xhr, status, error) {
                            alert("AJAX error: " + error);
                        }
                    });
                } else {
                    $('#<%= txtRespoName.ClientID %>').text("");
                }
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

        /* Style for all tab links (inactive state) */

        /*.nav-tabs .nav-link {
                background-color: black;
                color: white;
                border: 1px solid #444;
                margin-right: 2px;
            }*/
        /* Style for the active tab link */
        /*.nav-tabs .nav-link.active {
                background-color: #333;
                color: #fff;
                border-color: #555 #555 #000;
            }*/

        /* Style for the content inside the tabs */
        /*.tab-content {
                background-color: #f8f9fa;
                padding: 20px;
                border: 1px solid #dee2e6;
                border-top: none;
            }*/

        .nav-tabs .nav-link.active {
            color: green !important;
            font-weight: bold;
            text-decoration: underline;
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />


    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left" style="text-align: center;">
                   <asp:Label ID="heading" runat="server" CssClass="h5 text-center font-weight-bold text-success"  Text="LINE WALK STATUS"></asp:Label>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 style="color:green">DOC: DOC/ATS/TSK/QMS/GC/013 REV : 00 ,EFT DATE : 01/02/2024</h2>
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
                                    <%--<asp:RegularExpressionValidator ID="REV_TB_ID" runat="server" ControlToValidate="TB_ID" ErrorMessage="* Only letters & numbers" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9 ]+$" Display="Dynamic" ValidationGroup="Submit" />--%>
                                </div>

                                <!-- Job Description -->
                                <div class="col-md-6 mb-3">
                                    <asp:Label ID="Lbl_JD" runat="server" Text="Job Description" AssociatedControlID="TB_JD" ForeColor="Blue" Font-Bold="true" />
                                    <asp:TextBox ID="TB_JD" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFV_TB_JD" runat="server" ControlToValidate="TB_JD" ErrorMessage="* Description required" ForeColor="Red" Display="Dynamic" ValidationGroup="Submit" />
                                    <%--<asp:RegularExpressionValidator ID="REV_TB_JD" runat="server" ControlToValidate="TB_JD" ErrorMessage="* Only alphabets allowed" ForeColor="Red" ValidationExpression="^[a-zA-Z\s,\/]+$" Display="Dynamic" ValidationGroup="Submit" />--%>
                                </div>
                            </div>


                            <div class="row">
                                <!-- Photo Upload -->
                                <div class="col-md-3 mb-3">
                                    <asp:Label ID="Lbl_Photo" runat="server" Text="Photo Upload" AssociatedControlID="grp_Photo" ForeColor="Blue" Font-Bold="true" />
                                    <asp:FileUpload ID="grp_Photo" runat="server" CssClass="form-control form-control-sm rounded" />
                                    <asp:Label ID="Lbl_SavedPhoto" runat="server" Visible="false" EnableViewState="true"></asp:Label>
                                </div>

                                <!-- Audit By -->
                                <div class="col-md-3 mb-3">
                                    <asp:Label ID="Lbl_AuditBy" runat="server" Text="Audit By" AssociatedControlID="TB_AuditBy" ForeColor="Blue" Font-Bold="true" />
                                    <asp:TextBox ID="TB_AuditBy" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFV_AuditBy" runat="server" ControlToValidate="TB_AuditBy"
                                        ErrorMessage="* Auditor name required" ForeColor="Red" Display="Dynamic" ValidationGroup="Submit" />
                                    <%--<asp:RegularExpressionValidator ID="REV_AuditBy" runat="server" ControlToValidate="TB_AuditBy"
                                        ErrorMessage="* Only letters allowed" ForeColor="Red" ValidationExpression="^[a-zA-Z\s]+$" Display="Dynamic" ValidationGroup="Submit" />--%>
                                </div>
                            </div>



                            <div class="d-flex justify-content-center">
                                <asp:Button ID="Save" runat="server" CssClass="btn btn-primary btn-sm ml-4" Text="Save" OnClick="Save_Click" ValidationGroup="Submit" />
                                <asp:Button ID="Home" runat="server" CssClass="btn btn-warning btn-sm ml-4" Text="Home" OnClick="Home_Click" CausesValidation="false" />
                            </div>

                            <!-- Step 2[A]: Team Members -->
                            <hr />
                            <h2 class="green-heading">Step 2: Team Members</h2>
                            <hr />

                            <div class="container mt-2">
                                <asp:Button ID="btnOpenModal" runat="server" Text="Add Employee" CssClass="btn btn-primary" OnClientClick="showMemberModal(); return false;" Enabled="false" />
                            </div>

                            <!-- Employee Modal -->
                            <div class="modal fade" id="employeeModal" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">

                                        <div class="modal-header">
                                            <h5 class="modal-title" style="color: #198754; font-weight: bold;">Employee Details</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>

                                        <div class="modal-body">
                                            <asp:HiddenField ID="Entity_Id" runat="server" />
                                            <!-- Employee Type -->
                                            <%--<div class="form-group">
                                                <asp:Label ID="Emp_type_lbl" runat="server" Text="Employee Type" ForeColor="Blue" Font-Bold="true" />
                                                <asp:RadioButtonList ID="rblEmpType" runat="server" CssClass="form-check form-check-inline" ClientIDMode="Static" RepeatDirection="Horizontal" ValidationGroup="SaveEmployee">
                                                    <asp:ListItem Text="Internal" Value="Internal" Selected="True" />
                                                    <asp:ListItem Text="External" Value="External" />
                                                </asp:RadioButtonList>
                                                <asp:RequiredFieldValidator ID="RFV_rblEmpType" runat="server" ControlToValidate="rblEmpType" InitialValue="" ErrorMessage="* Select Type" ForeColor="Red" Display="Dynamic" ValidationGroup="SaveEmployee" />
                                            </div>--%>


                                            <div class="form-group d-flex align-items-center">
                                                <asp:Label ID="Emp_type_lbl" runat="server" Text="Employee Type" ForeColor="Blue" Font-Bold="true"
                                                    CssClass="me-3" />

                                                <asp:RadioButtonList ID="rblEmpType" runat="server" RepeatDirection="Horizontal" ClientIDMode="Static"
                                                    CssClass="form-check form-check-inline d-flex gap-3" ValidationGroup="SaveEmployee">
                                                    <asp:ListItem Text="Internal" Value="Internal" Selected="True" />
                                                    <asp:ListItem Text="External" Value="External" />
                                                </asp:RadioButtonList>

                                                <asp:RequiredFieldValidator ID="RFV_rblEmpType" runat="server" ControlToValidate="rblEmpType"
                                                    InitialValue="" ErrorMessage="* Select Employee Type" ForeColor="Red" Display="Dynamic"
                                                    ValidationGroup="SaveEmployee" CssClass="ms-3" />
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
                                            <asp:Button ID="BtnSave" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="SaveEmployee" OnClick="BtnSave_Click1" />
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <!-- Employee Grid -->
                            <div class="row">
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" GridLines="None" HeaderStyle-CssClass="thead-dark" DataKeyNames="Desc_ID" OnRowCommand="gvTeamMembers_RowCommand">

                                    <Columns>
                                        <asp:BoundField DataField="TM_Type" HeaderText="Type" />
                                        <asp:BoundField DataField="TM_Code" HeaderText="Code" />
                                        <asp:BoundField DataField="TM_names" HeaderText="Name" />

                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>

                                                <asp:LinkButton ID="Edit_Member" runat="server" Text="Edit"
                                                    CssClass="btn btn-sm btn-primary"
                                                    OnClientClick='<%# "showMemberModal(" + Eval("Desc_ID") + "); return false;" %>' />
                                                <asp:LinkButton ID="Delete_Member" runat="server" Text="Delete" CommandName="DeleteMember" CommandArgument='<%# Eval("Desc_ID") %>'
                                                    OnClientClick="return confirm('Are you sure you want to delete this team member?');" CssClass="btn btn-sm btn-danger" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>

                            <!-- Step 3: Observations -->
                            <hr />
                            <h2 class="green-heading">Step 3: Observations & Recommendations</h2>
                            <hr />

                            <div class="container mt-2">
                                <asp:Button ID="btnOpenObservationModal" runat="server" Text="Add Observation" CssClass="btn btn-primary" OnClientClick="showObservationModal(); return false;" Enabled="false" />
                            </div>

                            <!-- Observation Modal -->
                            <div class="modal fade" id="observationModal" tabindex="-1" role="dialog">
                                <div class="modal-dialog modal-lg" role="document">
                                    <div class="modal-content">

                                        <div class="modal-header">
                                            <h5 class="modal-title" style="color: #198754; font-weight: bold;">Add Observation Details</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>

                                        <div class="modal-body">

                                            <!-- Observation Nav Tabs -->
                                            <ul class="nav nav-tabs" id="observationTabs" role="tablist">
                                                <li class="nav-item">
                                                    <a class="nav-link active" id="opening-tab" data-toggle="tab" href="#opening" role="tab">Opening Points</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" id="immediate-tab" data-toggle="tab" href="#immediate" role="tab">Immediate Action</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" id="future-tab" data-toggle="tab" href="#future" role="tab">Future Action</a>
                                                </li>
                                            </ul>

                                            <!-- Tab Content -->
                                            <div class="tab-content mt-3" id="observationTabsContent">
                                                <!-- Opening Points Tab -->
                                                <div class="tab-pane fade show active" id="opening" role="tabpanel" aria-labelledby="opening-tab">
                                                    <div class="form-group">
                                                        <asp:Label ID="Area_lbl" runat="server" Text="Area/Location" ForeColor="Blue" Font-Bold="true" />
                                                        <asp:TextBox ID="txtAreaLocation" runat="server" CssClass="form-control form-control-sm rounded" />
                                                        <asp:RequiredFieldValidator ID="RFV_txtAreaLocation" runat="server" ControlToValidate="txtAreaLocation" ErrorMessage="* Area required" ForeColor="Red" ValidationGroup="SaveObservation" Display="Dynamic" />
                                                    </div>

                                                    <div class="form-group">
                                                        <asp:Label ID="Observatio_lbl" runat="server" Text="Detailed Observation" ForeColor="Blue" Font-Bold="true" />
                                                        <asp:TextBox ID="txtObservation" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="3" />
                                                        <asp:RequiredFieldValidator ID="RFV_txtObservation" runat="server" ControlToValidate="txtObservation" ErrorMessage="* Observation required" ForeColor="Red" ValidationGroup="SaveObservation" Display="Dynamic" />
                                                    </div>

                                                    <!-- CheckBox for CAPA -->
                                                     <div class="form-group form-check mt-2">
                                                         <asp:CheckBox ID="chkGenerateCAPA" runat="server" CssClass="form-check-input" OnClick="handleCAPACheckbox(this)" />
                                                         <asp:Label ID="lblGenerateCAPA" runat="server" AssociatedControlID="chkGenerateCAPA"
                                                             Text="For generate CAPA Point, Please check the box!!" CssClass="form-check-label text-primary font-weight-bold" />
                                                     </div>

                                                    <div class="form-group">
                                                        <asp:Label ID="Snap_lbl" runat="server" Text="Attachment" ForeColor="Blue" Font-Bold="true" />
                                                        <asp:FileUpload ID="fileSnap" runat="server" CssClass="form-control-file" />
                                                        <asp:Label ID="lblExistingSnap" runat="server" CssClass="text-muted" ClientIDMode="Static" />
                                                        <asp:RequiredFieldValidator ID="RFV_fileSnap" runat="server" ControlToValidate="fileSnap" ErrorMessage="* Snaps required" ForeColor="Red" Display="Dynamic" Visible="false" />
                                                    </div>

                                                    <div class="form-group">
                                                        <asp:Label ID="Rexommendation_lbl" runat="server" Text="Recommendation" ForeColor="Blue" Font-Bold="true" />
                                                        <asp:TextBox ID="txtRecommendation" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="2" />
                                                        <asp:RequiredFieldValidator ID="RFV_txtRecommendation" runat="server" ControlToValidate="txtRecommendation" ErrorMessage="* Recommendation required" ForeColor="Red" Display="Dynamic" />
                                                    </div>


                                                    <asp:Button ID="BtnSaveObservation" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="SaveObservation" OnClick="BtnSaveObservation_Click" />



                                                </div>
                                                <!-- First Tab Content End-->

                                                <!-- Immediate Action Tab -->
                                                <div class="tab-pane fade" id="immediate" role="tabpanel" aria-labelledby="immediate-tab">
                                                    <div class="form-group">
                                                        <asp:Label ID="Remark_lbl" runat="server" Text="Remarks" ForeColor="Blue" Font-Bold="true" />
                                                        <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="2" />
                                                        <asp:RequiredFieldValidator ID="RFV_txtRemarks" runat="server" ControlToValidate="txtRemarks" ErrorMessage="* Remarks required" ForeColor="Red" Display="Dynamic" ValidationGroup="SaveImmediate Action" />
                                                    </div>

                                                    <div class="form-group">
                                                        <asp:Label ID="Attachment_lbl" runat="server" Text="Attachment" ForeColor="Blue" Font-Bold="true" />
                                                        <asp:FileUpload ID="IAction_Attachment" runat="server" CssClass="form-control-file" />
                                                        <asp:Label ID="lblImmediateAttachment" runat="server" CssClass="text-muted" ClientIDMode="Static" />
                                                    </div>

                                                    <asp:Button ID="BtnImmediateAction" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="SaveImmediate Action" OnClick="BtnImmediateAction_Click" />
                                                </div>

                                                <!-- Immediate Action Tab End-->

                                                <!-- Future Action Tab -->
                                                <div class="tab-pane fade" id="future" role="tabpanel" aria-labelledby="future-tab">
                                                    <div class="form-row">
                                                        <div class="form-group col-md-6">
                                                            <asp:Label ID="Responsibility_lbl" runat="server" Text="Responsibility" ForeColor="Blue" Font-Bold="true" />
                                                            <asp:TextBox ID="txtResponsibility" runat="server" CssClass="form-control form-control-sm rounded" />
                                                            <asp:Label ID="txtRespoName" runat="server" />
                                                            <asp:RequiredFieldValidator ID="RFV_txtResponsibility" runat="server" ControlToValidate="txtResponsibility" ErrorMessage="* Responsibility required" ForeColor="Red" ValidationGroup="SaveFutureAction" Display="Dynamic" />
                                                        </div>

                                                        <div class="form-group col-md-6">
                                                            <asp:Label ID="Targetdt_lbl" runat="server" Text="Target Date" ForeColor="Blue" Font-Bold="true" />
                                                            <asp:TextBox ID="txtTargetDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" />
                                                            <asp:RequiredFieldValidator ID="RFV_txtTargetDate" runat="server" ControlToValidate="txtTargetDate" ErrorMessage="* Target Date required" ForeColor="Red" ValidationGroup="SaveFutureAction" Display="Dynamic" />
                                                        </div>

                                                        <asp:Button ID="BtnFutureAction" runat="server" Text="Save" CssClass="btn btn-success" ValidationGroup="SaveFutureAction" OnClick="BtnFutureAction_Click" />

                                                    </div>
                                                </div>
                                                <!-- Future Action Tab End-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Observation Grid -->
                            <div class="row" style="overflow: auto;">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-striped" OnRowCommand="gvObservations_RowCommand" OnRowDataBound="GridView1_RowDataBound">
                                    <Columns>
                                        <asp:BoundField DataField="Location" HeaderText="Area" />
                                        <asp:BoundField DataField="Observation_Points" HeaderText="Observation" />

                                        <asp:TemplateField HeaderText="Snap">
                                            <ItemTemplate>
                                                <%-- //<a href='<%# ResolveUrl("~/Uploads/" + Eval("Snap_File_Path")) %>' target="_blank">View</a>--%>
                                                <asp:HyperLink ID="lnkSnap" runat="server" Text="View" Target="_blank" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Recommendation_Points" HeaderText="Recommendation" />
                                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                        <asp:TemplateField HeaderText="Immediate Action Attachment">
                                            <ItemTemplate>
                                                <%--<a href='<%# ResolveUrl("~/Uploads/" + Eval("ImmediateAction_Attachment")) %>' target="_blank">View</a>--%>
                                                <asp:HyperLink ID="lnkImmediate" runat="server" Text="View" Target="_blank" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Responsibility" HeaderText="Responsibility" />
                                        <asp:BoundField DataField="Target_Date" HeaderText="Target Date" DataFormatString="{0:yyyy-MM-dd}" />
                                        <asp:BoundField DataField="Status" HeaderText="Status" />
                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>
                                                <asp:Button ID="Edit_obsrv" runat="server" Text="Edit" CssClass="btn btn-sm btn-primary" OnClientClick='<%# "showObservationModal(" + Eval("Detail_ID") + "); return false;" %>' />
                                                

                                                <asp:LinkButton ID="Delete_observ" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger" CommandName="DeleteObservation"
                                                    CommandArgument='<%# Eval("Detail_ID") %>'
                                                    OnClientClick="return confirm('Are you sure you want to delete this observation?');" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>

                            <%-- <!-- Footer Buttons -->
                            <div class="container d-flex justify-content-center gap-2 mt-3">
                                <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" OnClick="BtnSubmit_Click" />
                                <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                                <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-danger btn-sm" CausesValidation="false" PostBackUrl="~/home.aspx" />
                            </div>--%>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>


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
