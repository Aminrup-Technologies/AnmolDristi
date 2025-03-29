<%@ Page Title="CSM : Line Walk Report" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Line_Walk_Status.aspx.cs" Inherits="AnmolDristi.Line_Walk_Status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- SweetAlert2 CDN -->
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
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // Add new Team Member input
            $("#btnAddName").click(function () {
                let newNameInput = `<div class="d-flex align-items-center mb-2 name-input-group">
                                <input type="text" class="form-control form-control-sm rounded me-2 name-input" placeholder="Enter team member name" />
                                <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                            </div>`;
                $("#nameInputContainer").append(newNameInput);
            });

            // Add new Observation Point input
            $("#btnAddObservation").click(function () {
                let newObservationInput = `<div class="d-flex align-items-center mb-2 observation-input-group">
                                       <input type="text" class="form-control form-control-sm rounded me-2 observation-input" placeholder="Enter observation point" />
                                       <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                                   </div>`;
                $("#observationInputContainer").append(newObservationInput);
            });

            // Add new Recommendation Point input
            $("#btnAddRecommendation").click(function () {
                let newRecommendationInput = `<div class="d-flex align-items-center mb-2 recommendation-input-group">
                                          <input type="text" class="form-control form-control-sm rounded me-2 recommendation-input" placeholder="Enter recommendation point" />
                                          <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                                      </div>`;
                $("#recommendationInputContainer").append(newRecommendationInput);
            });

            // Add new Image Upload input
            //$("#btnAddImage").click(function () {
            //    let newImageInput = `<div class="d-flex align-items-center mb-2 image-upload-group">
            //                     <input type="file" class="form-control form-control-sm rounded me-2 image-input" accept="image/*" />
            //                     <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
            //                 </div>`;
            //    $("#imageUploadContainer").append(newImageInput);
            //});

            // Add new Image Upload input for Snaps
            //$("#btnAddSnap").click(function () {
            //    let newSnapInput = `<div class="d-flex align-items-center mb-2 snap-upload-group">
            //                     <input type="file" class="form-control form-control-sm rounded me-2 snap-input" accept="image/*" />
            //                     <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
            //                 </div>`;
            //    $("#snapUploadContainer").append(newSnapInput);
            //});


            // Remove dynamically added input fields
            $(document).on("click", ".btn-remove", function () {
                $(this).closest(".name-input-group, .observation-input-group, .recommendation-input-group,.image-upload-group, .snap-upload-group ").remove();
            });

        });

        function showNotification(title, text, type) {
            new PNotify({
                title: title,
                text: text,
                type: type,
                styling: 'bootstrap3',
                delay: 2000 // Auto-hide after 2 seconds
            });
        }

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
    </script>

    <div class="right_col" role="main">
        <div class="container">
            <%--<div class="page-title">
                <div class="title_left">
                    <h2>Automation & Technical Services</h2>
                </div>
            </div>--%>

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
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Date" runat="server" AssociatedControlID="TB_Date" Text="Date" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Date" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Date" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="TB_Date" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_JD" runat="server" AssociatedControlID="TB_JD" Text="Job Description" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_JD" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_JD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="TB_JD" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_ID" runat="server" AssociatedControlID="TB_ID" Text="Job ID" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_ID" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_ID" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="TB_ID" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <hr>
                            <h2 class="green-heading">Step 2[A]: Team Members</h2>
                            <hr />


                            <%--<div class="row">
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_TM_Names" runat="server" AssociatedControlID="TB_TM_Names" Text="Team Members Present Names" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_TM_Names" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_TM_Names" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <div id="nameInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_TM_Names" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Enter name"></asp:TextBox>
                                                <button type="button" id="btnAddName" class="btn btn-success btn-sm">+Add</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>--%>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-6">
                                        <asp:Label ID="Lbl_EmployeeType" runat="server" Text="Select Member Type : " ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RadioButton ID="rbOwnEmployee" runat="server" GroupName="EmployeeType" Text=" Own Employee" onclick="toggleFields()" ClientIDMode="Static" />
                                        <asp:RadioButton ID="rbExternalMember" runat="server" GroupName="EmployeeType" Text=" External Member" onclick="toggleFields()" ClientIDMode="Static" />

                                    </div>
                                    <!-- Employee Code Input -->
                                    <div id="employeeCodeDiv" style="display: none;">
                                        <asp:Label ID="lblEmployeeCode" runat="server" Text="Enter Employee Code" Font-Bold="true"></asp:Label>
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
                                                <th>Employee Code</th>
                                                <th>Employee Name</th>
                                            </tr>
                                        </table>
                                    </div>
                                    <button type="button" class="btn btn-success btn-sm mt-2" onclick="saveMembersToDB()">Save Members</button>
                                </div>
                            </div>

                            <hr>
                            <h2 class="green-heading">Step 2[B]: Team Members Photograph</h2>
                            <hr />
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_TM_Images" runat="server" AssociatedControlID="File_TM_Images" Text="Upload Team Members Image" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RF_File_TM_Images" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="File_TM_Images" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <div id="imageUploadContainer">
                                            <div class="d-flex mb-2">
                                                <asp:FileUpload ID="File_TM_Images" runat="server" CssClass="form-control form-control-sm rounded me-2" />
                                                <button type="button" id="btnAddImage" class="btn btn-success btn-sm">Upload</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>



                            <hr>
                            <h2 class="green-heading">Step 3: Observations & Recommendations</h2>
                            <hr />


                            <div class=" row repeator">
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_location" runat="server" AssociatedControlID="TB_location" Text="Area/Location" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_location" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_location" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox ID="TB_location" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Observation_Points" runat="server" AssociatedControlID="TB_Observation_Points" Text="Detailed Observation Point" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Observation_Points" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Observation_Points" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <div id="observationInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_Observation_Points" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Observation"></asp:TextBox>
                                                <%--<button type="button" id="btnAddObservation" class="btn btn-success btn-sm">+Add</button>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Recommendation_Points" runat="server" AssociatedControlID="TB_Recommendation_Points" Text="Recommendation Given" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Recommendation_Points" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Recommendation_Points" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <div id="recommendationInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_Recommendation_Points" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Recommendation"></asp:TextBox>
                                                <%--<button type="button" id="btnAddRecommendation" class="btn btn-success btn-sm">+Add</button>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_resp" runat="server" AssociatedControlID="TB_resp" Text="Responsibility Given To" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_resp" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_resp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="TB_resp" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_targetDate" runat="server" AssociatedControlID="TB_targetDate" Text="Target Date" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_targetDate" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_targetDate" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="TB_targetDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_remarks" runat="server" AssociatedControlID="TB_remarks" Text="Remarks/Compliance" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_remarks" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_remarks" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="TB_remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Snaps" runat="server" AssociatedControlID="File_Snaps" Text="Upload Snaps" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_File_Snaps" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="File_Snaps" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <div id="snapUploadContainer">
                                            <div class="d-flex mb-2">
                                                <asp:FileUpload ID="File_Snaps" runat="server" CssClass="form-control form-control-sm rounded me-2" />
                                                <button type="button" id="btnAddSnap" class="btn btn-success btn-sm">Upload</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Label1" runat="server" Text="Click to Add More" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <button type="button" id="btnAddMore" class="btn btn-primary btn-sm mt-3 form-control form-control-sm">+ Add More</button>
                                    </div>
                                </div>
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
                                        <asp:Button ID="BtnSubmit" runat="server" Text="Submit Record" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" />
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
    </div>

</asp:Content>
