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
        h2.green-heading{
            color: #26B99A!important;
            font-weight: 500!important;
            font-size: 1.5rem!important;
        }
     
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>

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
            $("#btnAddImage").click(function () {
                let newImageInput = `<div class="d-flex align-items-center mb-2 image-upload-group">
                                 <input type="file" class="form-control form-control-sm rounded me-2 image-input" accept="image/*" />
                                 <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                             </div>`;
                $("#imageUploadContainer").append(newImageInput);
            });
            // Add new Image Upload input for Snaps
            $("#btnAddSnap").click(function () {
                let newSnapInput = `<div class="d-flex align-items-center mb-2 snap-upload-group">
                                 <input type="file" class="form-control form-control-sm rounded me-2 snap-input" accept="image/*" />
                                 <button type="button" class="btn btn-danger btn-sm btn-remove">Remove</button>
                             </div>`;
                $("#snapUploadContainer").append(newSnapInput);
            });


            // Remove dynamically added input fields
            $(document).on("click", ".btn-remove", function () {
                $(this).closest(".name-input-group, .observation-input-group, .recommendation-input-group,.image-upload-group, .snap-upload-group ").remove();
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

                                        <div id="nameInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_TM_Names" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Enter name"></asp:TextBox>
                                                <button type="button" id="btnAddName" class="btn btn-success btn-sm">+Add</button>
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
                                                <button type="button" id="btnAddImage" class="btn btn-success btn-sm">+Add</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>

                            <!-- Row 3: locaion, Observation, Recommendation, Responsibility -->
                            <!-- Step 3: Observations and Recommendations -->
                            <hr>
                            <h2 class="green-heading">Step 3: Observations & Recommendations</h2>
                            <hr />
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_location" runat="server" AssociatedControlID="TB_location" Text="Area/Location" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_location" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_location" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox ID="TB_location" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Observation_Points" runat="server" AssociatedControlID="TB_Observation_Points" Text="Observation Points" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Observation_Points" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Observation_Points" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <div id="observationInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_Observation_Points" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Observation"></asp:TextBox>
                                                <button type="button" id="btnAddObservation" class="btn btn-success btn-sm">+Add</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_Recommendation_Points" runat="server" AssociatedControlID="TB_Recommendation_Points" Text="Recommendation Points" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Recommendation_Points" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Recommendation_Points" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <div id="recommendationInputContainer">
                                            <div class="d-flex mb-2">
                                                <asp:TextBox ID="TB_Recommendation_Points" runat="server" CssClass="form-control form-control-sm rounded me-2" Placeholder="Recommendation"></asp:TextBox>
                                                <button type="button" id="btnAddRecommendation" class="btn btn-success btn-sm">+Add</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>

                            <!-- Row 4: Target Date,Remarks, Upload Snaps -->
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-4">
                                        <asp:Label ID="Lbl_resp" runat="server" AssociatedControlID="TB_resp" Text="Responsibility" ForeColor="Blue" Font-Bold="true"></asp:Label>
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
                                                <button type="button" id="btnAddSnap" class="btn btn-success btn-sm">+Add</button>
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
                                    <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" />
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




