<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="QuickJCC_Checklist.aspx.cs" Inherits="AnmolDristi.QuickJCC_Checklist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


     <style>

           
          /* employee type rbl chng to btn*/
         
         .custom-rbl input[type="radio"] {
        display: none;
    }

    .custom-rbl label {
        margin-right: 0.5rem; /* Space between buttons */
        padding: 0.25rem 0.75rem; /* Smaller size */
        border: 1px solid #0d6efd;
        border-radius: 20px; /* Rounded corners */
        color: #0d6efd;
        cursor: pointer;
        background-color: #fff;
        font-size: 0.85rem;
        transition: 0.2s ease-in-out;
    }

    .custom-rbl input[type="radio"]:checked + label {
        background-color: #0d6efd;
        color: white;
        border-color: #0d6efd;
    }

    .custom-rbl label:hover {
        background-color: #e7f1ff;
    }
          
           /* employee type rbl chng to btn*/
 



     .custom-radio input[type="radio"] {
         display: none;
     }


     .custom-radio label {
         display: inline-block;
         padding: 8px 16px;
         border-radius: 5px;
         margin: 4px 4px 0 0;
         border: 1px solid #ccc;
         cursor: pointer;
         font-size: 0.9rem;
         flex: 1 1 auto;
         text-align: center;
         transition: all 0.2s;
         background-color: #f8f9fa;
         color: #333;
     }


     .custom-radio input[type="radio"]:checked + label {
         color: #fff;
     }


     .custom-radio input[type="radio"]:checked[value="OK"] + label {
         background-color: #28a745; /* Green */
         border-color: #28a745;
     }

     .custom-radio input[type="radio"]:checked[value="NotOK"] + label {
         background-color: #dc3545; /* Red */
         border-color: #dc3545;
     }

     .custom-radio input[type="radio"]:checked[value="NA"] + label {
         background-color: #6c757d; /* Grey */
         border-color: #6c757d;
     }

     .custom-file-label {
         overflow: hidden;
         text-overflow: ellipsis;
         white-space: nowrap;
     }

     .file-name-wrap {
         white-space: normal !important;
         word-break: break-word !important;
         overflow-wrap: break-word !important;
         display: block !important;
         width: 100% !important;
     }

     .is-invalid {
         border-color: red;
         background-color: #fff0f0;
     }

     /* Severity */
     .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
     }

     .file-name-wrap {
    white-space: normal !important;
    word-break: break-word !important;
    overflow-wrap: break-word !important;
    display: block !important;
    width: 100% !important;
}
 </style>

    <script type="text/javascript">

        document.addEventListener('DOMContentLoaded', function () {
            document.querySelectorAll('.custom-file-input').forEach(function (input) {
                input.addEventListener('change', function (e) {
                    var fileName = e.target.files[0]?.name || 'Choose file';
                    var label = e.target.nextElementSibling;
                    if (label) {
                        label.innerText = fileName;
                    }
                });
            });
        });









    function fetchEmployeeDetails() {
        var empCode = $('#<%= txtEmpCode.ClientID %>').val();

        if (empCode.trim() === "") return;

        $.ajax({
            type: "POST",
            url: "QuickJCC_Checklist.aspx/GetEmployeeDetails", // replace with actual page name
            data: JSON.stringify({ empCode: empCode }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var data = response.d;

                $('#<%= txtEmpName.ClientID %>').val(data.EmpName);
                $('#<%= txtDesignation.ClientID %>').val(data.Designation);
            },
            error: function (xhr, status, error) {
                alert("Error: " + error);
                console.log(xhr.responseText);
            }
        });
        }

        // Employee internal and external

        function bindEmpToggleHandlers() {
            //console.log("bindEmpToggleHandlers");

            const empRows = document.querySelectorAll(".emp-row");
            //console.log("Found rows:", empRows.length);

            empRows.forEach(row => {
                const empCode = row.querySelector(".emp-code");
                const empName = row.querySelector(".emp-name");
                const designation = row.querySelector(".designation");

                // Radio buttons rendered by ASP.NET
                const radios = row.querySelectorAll("input[type=radio][name*='rblEmpType']");

                if (!empCode || !empName || !designation || radios.length !== 2) {
                    //console.warn("Incomplete row:", row);
                    return;
                }

                const internalRadio = radios[0];
                const externalRadio = radios[1];

                function updateFields() {
                    if (internalRadio.checked) {
                        empCode.disabled = false;
                        empName.disabled = true;
                        designation.disabled = true;
                        empName.value = "";
                        designation.value = "";
                    } else if (externalRadio.checked) {
                        empCode.disabled = true;
                        empCode.value = "";
                        empName.disabled = false;
                        designation.disabled = false;
                        empName.value = "";
                        designation.value = "";
                    }
                }

                // Remove existing event handlers to avoid duplicates
                internalRadio.onchange = null;
                externalRadio.onchange = null;

                // Reattach
                internalRadio.addEventListener("change", updateFields);
                externalRadio.addEventListener("change", updateFields);

                updateFields();
            });
        }

        // Initial full load
        window.addEventListener('load', bindEmpToggleHandlers);

        // After every UpdatePanel postback
        if (typeof Sys !== "undefined" && Sys.WebForms) {
            Sys.Application.add_load(bindEmpToggleHandlers);
        }

        //Time validation
        function validateEndTime() {
            const startTime = document.getElementById('<%= txtStartTime.ClientID %>');
            const endTime = document.getElementById('<%= txtEndTime.ClientID %>');

        if (!startTime.value || !endTime.value) return;

        const start = new Date(`1970-01-01T${startTime.value}`);
        const end = new Date(`1970-01-01T${endTime.value}`);

        if (end <= start) {
            alert("End time must be after start time.");
            endTime.value = ""; // Clear invalid value
            endTime.focus();
        }
    }

    window.onload = function () {
        document.getElementById('<%= txtEndTime.ClientID %>').addEventListener("change", validateEndTime);
    };


        function validateChecklist(sender, args) {
            let isValid = true;

            document.querySelectorAll(".requirement-item").forEach(function (item) {
                const selectedResult = item.querySelector("input[type='radio']:checked");
                const remark = item.querySelector(".remark-input");

                if (selectedResult && selectedResult.value === "NotOK") {
                    const remarkText = remark ? remark.value.trim() : "";

                    if (remarkText === "") {
                        remark?.classList.add("is-invalid");
                        isValid = false;
                    } else {
                        remark?.classList.remove("is-invalid");
                    }
                } else {
                    remark?.classList.remove("is-invalid");
                }
            });

            args.IsValid = isValid;
        }


        function validateAll() {
            let severityValid = validateChecklistSeverity();
            let aspNetValid = Page_ClientValidate("save"); // Validate all other validators in group

            return severityValid && aspNetValid;
        }

        function validateChecklistSeverity() {
            let isValid = true;

            document.querySelectorAll(".requirement-item").forEach(function (item) {
                const result = item.querySelector("input[type='radio']:checked");
                const ddl = item.querySelector(".severity-input");

                if (result && result.value === "NotOK") {
                    if (!ddl || ddl.value.trim() === "") {
                        ddl?.classList.add("is-invalid");
                        isValid = false;
                    } else {
                        ddl?.classList.remove("is-invalid");
                    }
                } else {
                    ddl?.classList.remove("is-invalid");
                }
            });

            return isValid;
        }





        //Visibility
        document.addEventListener("DOMContentLoaded", function () {
            function updateVisibility(radio) {
                const container = radio.closest('.requirement-item');
                if (!container) return;

                const remarksPhoto = container.querySelectorAll('.remarks-photo-group');
                const note = container.querySelector('.note-group');

                switch (radio.value) {
                    case 'OK':
                        remarksPhoto.forEach(e => e.style.display = 'none');
                        if (note) note.style.display = '';

                        ResetRemarks(remarksPhoto);
                        resetSeverityInGroups(remarksPhoto);
                        break;
                    case 'NotOK':
                        remarksPhoto.forEach(e => e.style.display = '');
                        if (note) note.style.display = 'none';
                        break;
                    case 'NA':
                        remarksPhoto.forEach(e => e.style.display = 'none');
                        if (note) note.style.display = 'none';
                        ResetRemarks(remarksPhoto);
                        resetSeverityInGroups(remarksPhoto);
                        break;
                }
            }


            document.querySelectorAll('.result-selector input[type="radio"]').forEach(radio => {
                radio.addEventListener('change', function () {
                    updateVisibility(this);
                });


                if (radio.checked) {
                    updateVisibility(radio);
                }
            });
        });

        function ResetRemarks(remarksPhoto) {
            remarksPhoto.forEach(group => {
                //console.log(`Group:`, group);
                const inputs = group.querySelectorAll('textarea');
                inputs.forEach(input => {
                    input.value = '';
                });
            });
        }


        function resetSeverityInGroups(remarksPhoto) {
            //const groups = document.querySelectorAll('.remarks-photo-group');
            remarksPhoto.forEach(group => {
                const dropdown = group.querySelectorAll('select');
                dropdown.forEach(select => {
                    select.selectedIndex = -1;
                })
            });
        }
    </script>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left" style="text-align: center;">
                 <asp:Label ID="heading" runat="server" CssClass="h5 text-center font-weight-bold text-success" Text="QUICK JCC"></asp:Label>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="row">
            <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2 style="text-align: left; padding-left: 20px; font-weight: bold;" class="text-success">DOC/ATS/Q-JCC/MM(TSK) REV : 00 ,EFT DATE : 01/01/2025</h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        

                   <asp:ScriptManager ID="ScriptManager1" runat="server" />

                                <!-- Basic Details -->
                                <h4 class="text-white bg-success border border-success p-2 rounded w-100" style="font-size: 24px;">Basic Details</h4>
                                <div class="row mb-4">

                                    <div class="col-md-4 col-sm-12 mb-3">
                                        <asp:Label runat="server" AssociatedControlID="txtDate" CssClass="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Date:</asp:Label>
                                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" />
                                        <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtDate" CssClass="text-danger" ErrorMessage="Date is required" Display="Dynamic" ValidationGroup="save" />
                                    </div>

                                    <div class="col-md-4 col-sm-12 mb-3">
                                        <asp:Label runat="server" AssociatedControlID="txtJobID" CssClass="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Job ID:</asp:Label>
                                        <asp:TextBox ID="txtJobID" runat="server" CssClass="form-control form-control-sm rounded" />
                                        <asp:RequiredFieldValidator ID="rfvJobID" runat="server"
                                                 ControlToValidate="txtJobID" ErrorMessage="JobID is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                    </div>

                                    <div class="col-md-4 col-sm-12 mb-3">
                                        <asp:Label runat="server" AssociatedControlID="txtDepartment" CssClass="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Department:</asp:Label>
                                        <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control form-control-sm rounded" />
                                        <asp:RequiredFieldValidator ID="rfvDepartment" runat="server"
                                           ControlToValidate="txtDepartment" ErrorMessage="Department is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                        
                                    </div>

                                    <div class="col-md-4 col-sm-12 mb-3">
                                        <asp:Label runat="server" AssociatedControlID="txtLocation" CssClass="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Location:</asp:Label>
                                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control form-control-sm rounded" />
                                        <asp:RequiredFieldValidator ID="rfvLocation" runat="server"
                                             ControlToValidate ="txtLocation" ErrorMessage="Location is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                    </div>

                                    <div class="col-md-4 col-sm-12 mb-3">
                                        <asp:Label runat="server" AssociatedControlID="txtStartTime" CssClass="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Job Start Time:</asp:Label>
                                        <asp:TextBox ID="txtStartTime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time" />
                                        <asp:RequiredFieldValidator ID="rfvStartTime" runat="server"
                                               ControlToValidate ="txtStartTime" ErrorMessage="Start Time is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                    </div>

                                    <div class="col-md-4 col-sm-12 mb-3">
                                        <asp:Label runat="server" AssociatedControlID="txtEndTime" CssClass="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Job End Time:</asp:Label>
                                        <asp:TextBox ID="txtEndTime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time" />
                                        <asp:RequiredFieldValidator ID="rfvEndTime" runat="server"
                                                  ControlToValidate ="txtEndTime" ErrorMessage="End Time is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                    </div>

                                    <div class="col-md-4 col-sm-12 mb-3">
                                        <asp:Label runat="server" AssociatedControlID="txtauditby" CssClass="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Audit By</asp:Label>
                                        <asp:TextBox ID="txtauditby" runat="server" CssClass="form-control form-control-sm rounded"/>
                                        <asp:RequiredFieldValidator ID="rfvauditby" runat="server"
                                             ControlToValidate="txtauditby" ErrorMessage="Audit By is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                    </div>


                                    <div class="col-md-4 col-sm-12 mb-3">
                                        <asp:Label runat="server" AssociatedControlID="fuGroupPhoto" CssClass="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Group Photograph:</asp:Label>
                                        <asp:FileUpload ID="fuGroupPhoto" runat="server" CssClass="form-control form-control-sm rounded" />
                                        <asp:Label ID="lblExistingPhoto" runat="server" CssClass="text-muted" />
                                        <asp:HiddenField ID="hfExistingPhoto" runat="server" />
                                    </div>
                                    <asp:HiddenField ID="hfChecklistID" runat="server" />
                                </div>

                                <!-- Team Members -->
                                <h4 class="text-white bg-success border border-success p-2 rounded w-100" style="font-size: 24px;">Team Members</h4>
                                <asp:UpdatePanel ID="updTeam" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>

                                        <div class="emp-row">
                                        <div class="row mb-4" >
                                            <div class="col-md-2 col-sm-12 mb-3">
                                                <asp:Label runat="server" CssClass="form-label text-black emp-type" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Employee Type:</asp:Label>
                                                <asp:RadioButtonList ID="rblEmpType" runat="server" RepeatDirection="Horizontal" CssClass="btn-group-toggle custom-rbl">
                                                    <asp:ListItem Text="Internal" Value="Internal" />
                                                    <asp:ListItem Text="External" Value="External" />
                                                </asp:RadioButtonList>

                                                <asp:RequiredFieldValidator ID="rfvEmpType" runat="server"
                                                        ControlToValidate="rblEmpType"
                                                        InitialValue=""
                                                        ErrorMessage="Please select Employee Type."
                                                        Display="Dynamic"
                                                        CssClass="text-danger"
                                                        ValidationGroup="add" />
                                            </div>

                                            <div class="col-md-2 col-sm-12 mb-3">
                                                <asp:Label runat="server" AssociatedControlID="txtEmpCode" CssClass="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Employee Code:</asp:Label>
                                                <asp:TextBox ID="txtEmpCode" runat="server" CssClass="emp-code form-control form-control-sm rounded" onblur="fetchEmployeeDetails();" ></asp:TextBox>
                                               <%-- <asp:RequiredFieldValidator ID="rfvempcode" runat="server"
                                                            ControlToValidate="txtEmpCode" ErrorMessage="Empolyee code is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="add" />--%>
                                            </div>

                                            <div class="col-md-3 col-sm-12 mb-3">
                                                <asp:Label runat="server" AssociatedControlID="txtEmpName" CssClass="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Employee Name:</asp:Label>
                                                <asp:TextBox ID="txtEmpName" runat="server" CssClass="emp-name form-control form-control-sm rounded"  />
                                                <asp:RequiredFieldValidator ID="rfvempnme" runat="server"
                                                                             ControlToValidate="txtEmpName" ErrorMessage="Empolyee name is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="add" />
                                            </div>

                                            <div class="col-md-3 col-sm-12 mb-3">
                                                <asp:Label runat="server" AssociatedControlID="txtDesignation" CssClass="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Designation:</asp:Label>
                                                <asp:TextBox ID="txtDesignation" runat="server" CssClass="designation form-control form-control-sm rounded"  />
                                                <asp:RequiredFieldValidator ID="rfvdesignation" runat="server"
                                                           ControlToValidate="txtDesignation" ErrorMessage="Designation is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="add" />
                                                
                                            </div>

                                            <div class="col-md-2 col-sm-12 mb-3 d-flex align-items-end">
                                                <asp:Button ID="btnAddTeamMember" runat="server" Text="Add" CssClass="btn btn-sm btn-success" OnClick="btnAddTeamMember_Click" ValidationGroup="add"  />
                                            </div>
                                        </div>
                                            </div>
                                            
                              
                                        <!-- Optional: Team Member Preview Table -->
                                        <asp:GridView ID="gvTeamMembers" runat="server" CssClass="table table-bordered table-sm"  DataKeyNames="ID" AutoGenerateColumns="false" OnRowCommand="gvTeamMembers_RowCommand">
                                            <Columns>
                                                <asp:BoundField DataField="Employee_Type" HeaderText="Type" />
                                                <asp:BoundField DataField="Employee_Code" HeaderText="Code" />
                                                <asp:BoundField DataField="Employee_Name" HeaderText="Name" />
                                                <asp:BoundField DataField="Designation" HeaderText="Designation" />
                                               <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnEdit" runat="server" CommandName="EditRow" Text="Edit"
                                                            CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-sm btn-primary" />
                                                    
                                                        <asp:Button ID="btnDelete" runat="server" CommandName="DeleteRow" Text="Delete"
                                                             CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-sm btn-danger" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                        <asp:HiddenField ID="hfEditEmpCode" runat="server" />
                                    </ContentTemplate>

                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnAddTeamMember" EventName="Click" />
                                    </Triggers>
                                    
                                </asp:UpdatePanel>

                         <!-- Checklist Data-->
                           <h4 class="text-white bg-success border border-success p-2 rounded w-100" style="font-size: 24px;">Checklist</h4>
                           
                         <asp:Repeater ID="DictionaryRepeater" runat="server">
                             <ItemTemplate>
                                 <div class="card mb-4 shadow-sm">
                                     <div class="card-header d-flex justify-content-between align-items-center bg-primary text-white">
                                         <h6 class="mb-0">
                                             <asp:Label ID="Grp_detail" runat="server" Text='<%# Eval("GroupName") %>' />
                                         </h6>
                                         <a class="text-white text-decoration-none collapsed ml-auto" data-toggle="collapse"
                                             href='<%# "#collapse" + Container.ItemIndex %>' role="button"
                                             aria-expanded="false" aria-controls='<%# "collapse" + Container.ItemIndex %>'>
                                             <i class="fa fa-chevron-down collapse-toggle-icon"></i>
                                         </a>
                                     </div>

                                     <div id='<%# "collapse" + Container.ItemIndex %>' class="collapse card-body">
                                         <asp:Repeater ID="ChildRepeater" runat="server" DataSource='<%# Bind("Keys") %>' OnItemDataBound="ChildRepeater_ItemDataBound" >
                                             <ItemTemplate>
                                                 <asp:HiddenField runat="server" ID="ChecklistInfoId" Value='<%# Eval("ChecklistInfoId") %>' />


                                                 <div class="row requirement-item mb-4 p-3 border rounded bg-light">
                                                     <!-- First Row: Serial + Requirement -->
                                                     <div class="col-12 mb-2">
                                                         <asp:Label CssClass="form-label me-2" runat="server" Text='<%# Eval("Serial")+"." %>' ForeColor="Black" Font-Size="Medium" />
                                                         <asp:Label ID="Requirement" CssClass="form-label" runat="server" Text='<%# Bind("Requirement") %>' ForeColor="Blue" Font-Bold="true" Font-Size="Medium" />
                                                     </div>

                                                     <!-- Second Row: 3 Columns (Observation, Remarks, Photo) -->
                                                     <div class="col-12">
                                                         <div class="row g-2">
                                                             <!-- Add spacing between cols -->
                                                             <!-- Column 1: Observation -->
                                                             <div class="col-md-3">
                                                                 <asp:Label runat="server" CssClass="form-label d-block" Text="Observation" ForeColor="Black" Font-Size="Small" />
                                                                 <asp:RadioButtonList ID="result" runat="server"
                                                                     RepeatDirection="Horizontal"
                                                                     RepeatLayout="Flow"
                                                                     CssClass="btn-group d-flex flex-wrap custom-radio result-selector"
                                                                     AutoPostBack="false" >
                                                                     <asp:ListItem Text="OK" Value="OK" Selected="True" />
                                                                     <asp:ListItem Text="Not OK" Value="NotOK" />
                                                                     <asp:ListItem Text="NA" Value="NA" />
                                                                 </asp:RadioButtonList>
                                                             </div>

                                                             <!-- Column 2: Remarks -->
                                                             <div class="col-md-3 remarks-photo-group">
                                                                 <label class="form-label text-dark">Remarks:</label>
                                                                 <asp:TextBox ID="Remark_text" runat="server" CssClass="form-control remark-input" TextMode="MultiLine" Rows="2" />
                                                                 <asp:CustomValidator ID="cvChecklist" runat="server" ControlToValidate="Remark_text"
                                                                     ClientValidationFunction="validateChecklist"
                                                                     ErrorMessage="Remark is required."
                                                                     CssClass="text-danger"
                                                                     Display="Dynamic"
                                                                     ValidateEmptyText="true"
                                                                     ValidationGroup="save" />
                                                             </div>

                                                             <!-- Column 2: Severity -->
                                                             <div class="col-md-3 remarks-photo-group">
                                                                    <label class="form-label text-dark fw-semibold ">Severity:</label>
                                                                    <asp:DropDownList ID="ddlSeverity" runat="server" CssClass="form-select py-2 px-3 rounded shadow-sm border border-secondary m-2 severity-input" >
                                                                        <asp:ListItem Text="-- Select Severity --" Value="" />
                                                                        <asp:ListItem Text="High" Value="High" />
                                                                        <asp:ListItem Text="Medium" Value="Medium" />
                                                                        <asp:ListItem Text="Low" Value="Low" />
                                                                    </asp:DropDownList>

                                                                   <%-- <asp:CustomValidator ID="cvSeverity" runat="server"
                                                                            ClientValidationFunction="validateChecklistSeverity"
                                                                            ErrorMessage="Severity qqis required."
                                                                            CssClass="text-danger d-inline-block"
                                                                           Display="Dynamic"
                                                                        ValidateEmptyText="false"
                                                                            ValidationGroup="save"  />
                                                                 <asp:HiddenField ID="hdnRealSubmit" runat="server" ClientIDMode="Static" />--%>
                                                                 </div>

                                                             <div class="col-md-3 remarks-photo-group">
                                                                 <label class="form-label d-block text-dark">Before Photo:</label>
                                                                 <div class="custom-file w-100">
                                                                     <asp:FileUpload ID="Before_pic" runat="server" CssClass="custom-file-input" />
                                                                     <label class="custom-file-label" for="Before_pic">Choose file</label>
                                                                 </div>

                                                                 <asp:Label ID="Img" CssClass="d-block mt-2 text-muted" runat="server" Visible="false" />
                                                              

                                                            <!-- CAPA Applicable Checkbox  -->
                                                                    <div class="form-check mt-2">
                                                                        <asp:CheckBox ID="CapaPoint" runat="server" Checked="true" CssClass="form-check-input" OnClick="handleCAPACheckbox(this)" />
                                                                        <asp:Label AssociatedControlID="CapaPoint" runat="server" CssClass="form-check-label" Text="CAPA Applicable" ForeColor="Black" />
                                                                   </div>
                                                               </div>
                                                            </div>
                                                        </div>            

                                                         <!-- Note Multiline Texbox  -->
                                                          <div class="col-12 mt-3 note-group">
                                                            <label class="form-label fw-semibold text-dark">Note:</label>
                                                            <asp:TextBox ID="Note_text" runat="server" CssClass="form-control rounded-end" TextMode="MultiLine" Rows="3" placeholder="Enter any additional notes..." />
                                                       </div>
                                                   </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                         <div class="text-center mt-4">
                             <asp:Button ID="submit" runat="server" Text="Submit" OnClick="submit_Click" CssClass="btn btn-success px-4 py-2" ValidationGroup="save" CausesValidation="true" OnClientClick="return validateAll();" />
                             <asp:Button ID="reset" runat="server" Text="Reset" CssClass="btn btn-secondary px-4 py-2" OnClientClick="confirmReset(); return false;"/>
                             <asp:Button runat="server" ID="home" Text="Home" CssClass="btn btn-primary px-4 py-2" OnClick="home_Click"  />
                         </div>


                          </div>
                      </div>
                    </div>
                </div>
            </div>
        </div>








    <script type="text/javascript">
        function setupSingleEmpToggleHandler() {
            //console.log("setupSingleEmpToggleHandler");

            const row = document.querySelector(".emp-row");
            if (!row) return;

            const empCode = row.querySelector(".emp-code");
            const empName = row.querySelector(".emp-name");
            const designation = row.querySelector(".designation");
            const radios = row.querySelectorAll("input[type=radio][name*='rblEmpType']");

            if (!empCode || !empName || !designation || radios.length !== 2) {
                //console.warn("Required elements missing");
                return;
            }

            const internalRadio = radios[0];
            const externalRadio = radios[1];

            function updateFields() {
                if (internalRadio.checked) {
                    empCode.disabled = false;
                    empName.disabled = true;
                    designation.disabled = true;
                    empName.value = "";
                    designation.value = "";
                } else if (externalRadio.checked) {
                    empCode.disabled = true;
                    empCode.value = "";
                    empName.disabled = false;
                    designation.disabled = false;
                    //empName.value = "";
                    //designation.value = "";
                }
            }

            internalRadio.removeEventListener("change", updateFields);
            externalRadio.removeEventListener("change", updateFields);

            internalRadio.addEventListener("change", updateFields);
            externalRadio.addEventListener("change", updateFields);


            // Force trigger for current checked radio
            const checkedRadio = row.querySelector("input[type=radio][name*='rblEmpType']:checked");
            if (checkedRadio) {
                checkedRadio.dispatchEvent(new Event("change"));
            }
        }

        // On full page load
        window.addEventListener("load", setupSingleEmpToggleHandler);

        // On partial postback (e.g. Add button clicked)
        if (typeof Sys !== "undefined" && Sys.WebForms) {
            Sys.Application.add_load(setupSingleEmpToggleHandler);
        }
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


    <script type="text/javascript">
        function resetChecklist() {
            // Reset all radio buttons to "OK"
            document.querySelectorAll(".result-selector").forEach(function (rbl) {
                const okRadio = rbl.querySelector("input[type='radio'][value='OK']");
                if (okRadio) okRadio.checked = true;
            });

            document.querySelectorAll('input[type="text"], input[type="date"], textarea').forEach(function (input) {
                    input.value = "";
                });

            // Clear all remarks textboxes
            document.querySelectorAll(".remark-input").forEach(function (textbox) {
                textbox.value = "";
            });

            // Reset all severity dropdowns
            document.querySelectorAll(".severity-input").forEach(function (dropdown) {
                dropdown.selectedIndex = 0;
            });

            // Clear all file uploads 
            document.querySelectorAll("input[type='file']").forEach(function (fileInput) {
                fileInput.value = "";
            });

            // Hide any image preview labels
            document.querySelectorAll("label[id$='Img']").forEach(function (label) {
                label.style.display = "none";
            });

            // Re-check all CAPA checkboxes
            document.querySelectorAll("input[type='checkbox'].form-check-input").forEach(function (cb) {
                cb.checked = true;
            });

            // Clear all notes
            document.querySelectorAll(".note-group textarea").forEach(function (textarea) {
                textarea.value = "";
            });

            document.querySelectorAll('.remarks-photo-group').forEach(section => {
                section.style.display = 'none';
            });

            // Ensure Note section is always visible
            document.querySelectorAll('.note-group').forEach(section => {
                section.style.display = 'block';
            });

            document.querySelectorAll("input[type=time]").forEach(el => el.value = "");
        }

         function confirmReset() {
               if (confirm('Are you sure you want to clear all fields?')) {
               resetChecklist();
     }
 }
    </script>







</asp:Content>
