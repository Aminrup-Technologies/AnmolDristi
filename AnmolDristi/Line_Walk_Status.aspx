<%@ Page Title="Line Walk Status" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Line_Walk_Status.aspx.cs" Inherits="AnmolDristi.Line_Walk_Status" %>

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

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>

        $(document).ready(function () {
            // Get ASP.NET Client IDs
            var nameBtnId = '<%= btnAddName.ClientID %>';
            var observationBtnId = '<%= btnAddObservation.ClientID %>';
            var recommendationBtnId = '<%= btnAddRecommendation.ClientID %>';
            var snapBtnId = '<%= btnAddSnap.ClientID %>';
            var areaBtnId = '<%= btnAddArea.ClientID %>';
            var responsibilityBtnId = '<%= btnAddResponsibility.ClientID %>';
            var targetDateBtnId = '<%= btnAddTargetDate.ClientID %>';
            var remarksBtnId = '<%= btnAddRemarks.ClientID %>';

            // Team Member Input
            $("#" + nameBtnId).click(function () {
                let newInput = `<div class="d-flex align-items-center mb-2 name-input-group">
                            <input type="text" class="form-control form-control-sm rounded me-2" placeholder="Enter team member name" />
                            <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                        </div>`;
                $("#nameInputContainer").append(newInput);
            });

            // Observation Input
            $("#" + observationBtnId).click(function () {
                let newInput = `<div class="d-flex align-items-center mb-2 observation-input-group">
                            <input type="text" class="form-control form-control-sm rounded me-2" placeholder="Observation" />
                            <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                        </div>`;
                $("#observationInputContainer").append(newInput);
            });

            // Recommendation Input
            $("#" + recommendationBtnId).click(function () {
                let newInput = `<div class="d-flex align-items-center mb-2 recommendation-input-group">
                            <input type="text" class="form-control form-control-sm rounded me-2" placeholder="Recommendation" />
                            <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                        </div>`;
                $("#recommendationInputContainer").append(newInput);
            });

            // Snap Upload Input
            $("#" + snapBtnId).click(function () {
                let newInput = `<div class="d-flex align-items-center mb-2 snap-upload-group">
                            <input type="file" class="form-control form-control-sm rounded me-2" />
                            <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                        </div>`;
                $("#snapUploadContainer").append(newInput);
            });

            // Area/Location Input
            $("#" + areaBtnId).click(function () {
                let newInput = `<div class="d-flex align-items-center mb-2 area-input-group">
                            <input type="text" class="form-control form-control-sm rounded me-2" placeholder="Area/Location" />
                            <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                        </div>`;
                $("#AreaInputContainer").append(newInput);
            });

            // Responsibility Input
            $("#" + responsibilityBtnId).click(function () {
                let newInput = `<div class="d-flex align-items-center mb-2 responsibility-input-group">
                            <input type="text" class="form-control form-control-sm rounded me-2" placeholder="Responsibility" />
                            <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                        </div>`;
                $("#responsibilityInputContainer").append(newInput);
            });

            // Target Date Input
            $("#" + targetDateBtnId).click(function () {
                let newInput = `<div class="d-flex align-items-center mb-2 target-date-input-group">
                            <input type="date" class="form-control form-control-sm rounded me-2" />
                            <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                        </div>`;
                $("#targetDateInputContainer").append(newInput);
            });

            // Remarks Input
            $("#" + remarksBtnId).click(function () {
                let newInput = `<div class="d-flex align-items-center mb-2 remarks-input-group">
                            <input type="text" class="form-control form-control-sm rounded me-2" placeholder="Remarks" />
                            <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                        </div>`;
                $("#remarksInputContainer").append(newInput);
            });

            // Common remove button logic
            $("body").on("click", ".btn-remove", function () {
                $(this).closest("div").remove();
            });
        });



    </script>


    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h2>Automation & Technical Services</h2>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Line Walk Status of COB</h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">
                            <!-- Row 1: Date, Job Description, Job ID -->
                            <!-- Step 1: Job Details -->

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
                                        <asp:RegularExpressionValidator ID="REV_TB_JD" runat="server" ValidationGroup="Submit" ControlToValidate="TB_JD" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <asp:TextBox ID="TB_JD" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_ID" runat="server" AssociatedControlID="TB_ID" Text="Job ID" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_ID" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_ID" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_ID" runat="server" ValidationGroup="Submit" ControlToValidate="TB_ID" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <asp:TextBox ID="TB_ID" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <!-- Row 2: Team Members, Upload Image -->
                            <!-- Step 2: Team Details -->
                            <hr>
                            <h2 class="green-heading">Step 2: Team Details</h2>
                            <hr />
                            <div class="row">

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_TM_Names" runat="server" AssociatedControlID="TB_TM_Names" Text="Team Members Present Names" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_TM_Names" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_TM_Names" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_TM_Names" runat="server" ValidationGroup="Submit" ControlToValidate="TB_TM_Names" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <div id="nameInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_TM_Names" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Enter name"></asp:TextBox>
                                                <asp:Button ID="btnAddName" runat="server" Text="Add more" CssClass="btn btn-success btn-sm" UseSubmitBehavior="false" OnClientClick="return false;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_TM_Images" runat="server" AssociatedControlID="File_TM_Images" Text="Upload Team Members Image" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RF_File_TM_Images" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="File_TM_Images" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <div id="imageUploadContainer">
                                            <div class="d-flex mb-2">
                                                <asp:FileUpload ID="File_TM_Images" runat="server" CssClass="form-control form-control-sm rounded me-2" />
                                                <%--                                                <button type="button" id="btnAddImage" class="btn btn-success btn-sm">+Add</button>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>

                            <!-- Row 3: location, Observation, Recommendation,  -->
                            <!-- Step 3: Observations and Recommendations -->
                            <hr>
                            <h2 class="green-heading">Step 3: Observations & Recommendations</h2>
                            <hr />
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_location" runat="server" AssociatedControlID="TB_location" Text="Area/Location" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_location" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_location" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_location" runat="server" ValidationGroup="Submit" ControlToValidate="TB_location" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <div id="AreaInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_location" runat="server" CssClass="form-control form-control-sm rounded me-2"></asp:TextBox>
                                                <asp:Button ID="btnAddArea" runat="server" Text="Add more" CssClass="btn btn-success btn-sm" UseSubmitBehavior="false" OnClientClick="return false;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Observation_Points" runat="server" AssociatedControlID="TB_Observation_Points" Text="Observation Points" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Observation_Points" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Observation_Points" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_Observation_Points" runat="server" ValidationGroup="Submit" ControlToValidate="TB_Observation_Points" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <div id="observationInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_Observation_Points" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Observation"></asp:TextBox>
                                                <asp:Button ID="btnAddObservation" runat="server" Text="Add more" CssClass="btn btn-success btn-sm" UseSubmitBehavior="false" OnClientClick="return false;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Recommendation_Points" runat="server" AssociatedControlID="TB_Recommendation_Points" Text="Recommendation Points" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Recommendation_Points" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Recommendation_Points" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_Recommendation_Points" runat="server" ValidationGroup="Submit" ControlToValidate="TB_Recommendation_Points" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <div id="recommendationInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_Recommendation_Points" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Recommendation"></asp:TextBox>
                                                <asp:Button ID="btnAddRecommendation" runat="server" Text="Add more" CssClass="btn btn-success btn-sm" UseSubmitBehavior="false" OnClientClick="return false;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>



                            </div>

                            <!-- Row 4: Responsibility,Target Date,Remarks, Upload Snaps -->
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Responsibility" runat="server" AssociatedControlID="TB_Responsibility" Text="Responsibility" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_Responsibility" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Responsibility" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_Responsibility" runat="server" ValidationGroup="Submit" ControlToValidate="TB_Responsibility" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                        <div id="responsibilityInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_Responsibility" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Responsibility"></asp:TextBox>
                                                <asp:Button ID="btnAddResponsibility" runat="server" Text="Add more" CssClass="btn btn-success btn-sm" UseSubmitBehavior="false" OnClientClick="return false;" />
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
                                                <asp:Button ID="btnAddTargetDate" runat="server" Text="Add more" CssClass="btn btn-success btn-sm" UseSubmitBehavior="false" OnClientClick="return false;" />
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
                                                <asp:Button ID="btnAddRemarks" runat="server" Text="Add more" CssClass="btn btn-success btn-sm" UseSubmitBehavior="false" OnClientClick="return false;" />
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
                                                <asp:Button ID="btnAddSnap" runat="server" Text="Add more" CssClass="btn btn-success btn-sm" UseSubmitBehavior="false" OnClientClick="return false;" />
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>



                        </div>
                        <!-- x_content -->

                    </div>
                    <!-- x_panel -->
                    <!-- Submit Button -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="mb-4 text-center">
                                <!-- Center-align content -->
                                <asp:Label ID="lbl_msg" runat="server" AssociatedControlID="BtnSubmit"
                                    Text="Click to SAVE!" ForeColor="Blue" Font-Bold="true" Font-Size="Small">
                                </asp:Label>

                                <div class="d-flex justify-content-center gap-2 mt-2">
                                    <!-- Centering buttons -->
                                    <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
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




