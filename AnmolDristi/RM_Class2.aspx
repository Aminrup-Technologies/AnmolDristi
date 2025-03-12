<%@ Page Title="RAW MATERIAL FORM" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="RM_Class2.aspx.cs" Inherits="AnmolDristi.RM_Class2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .hidden {
            display: none;
        }

        .remove-border {
            border: none !important; /* This will ensure the border is removed */
            /* Add any other necessary styling */
        }


        .custom-page-title {
            width: 100%;
            background-color: #f0f0f0; /* Example: Change background color */
            margin-top: 20px;
            padding-top: 35px;
            padding-right: 20px;
            padding-left: 20px;
            padding-bottom: 20px;
        }

            .custom-page-title .title_left h3 {
                font-size: 20px;
                color: #333333;
                font-weight: bold;
            }


        .approver-photo {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }

        .approver-flow {
            display: flex;
            align-items: center;
            justify-content: space-around;
            padding: 1rem;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: .25rem;
        }

        .flow-line {
            flex: 1;
            border-top: 2px solid #007bff;
            margin: 0 10px;
        }

        .approver-item {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        function showNotification(title, text, type) {
            new PNotify({
                title: title,
                text: text,
                type: type,
                styling: 'bootstrap3'
            });
        }

        //image
        function validateForm1() {
            var fileUpload = document.getElementById('<%= FU_MaterialImage.ClientID %>');
            var lblErrorMessage1 = document.getElementById('<%= lblErrorMessage1.ClientID %>');
            if (fileUpload.files.length === 0) {
                lblErrorMessage1.innerHTML = "Please upload file.";
                return false;
            } else {
                lblErrorMessage1.innerHTML = "";
                return true;
            }
        }

        function validateSubmit() {
            var fileUpload = document.getElementById('<%= FU_MaterialImage.ClientID %>'); // Get the FileUpload control
            var errorMessageLabel = document.getElementById('<%= lblErrorMessage1.ClientID %>'); // Get the error message label

            if (fileUpload.value === "") {
                errorMessageLabel.innerHTML = "Please select a file before submitting."; // Display error message
                errorMessageLabel.style.color = "red"; // Change color to red
                return false; // Prevent form submission
            }

            // File is selected, return true to allow form submission
            return true;
        }

        function toggleColorRemarksDiv(radioButtonList) {
            console.log("toggleColorRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("ColorRemarksDiv");
            console.log("DIV :" + remarksDiv);
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
                setTimeout(function () {
                    // Display a PNotify notification
                    new PNotify({
                        title: 'A Mail will be sent',
                        text: 'You have selected "Not Ok". Please provide additional remarks.',
                        type: 'warning',
                        styling: 'bootstrap3'
                    });
                }, 200); // Adjust delay as necessary
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleSmellRemarksDiv(radioButtonList) {
            console.log("toggleSmellRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("SmellRemarksDiv");
            console.log("DIV :" + remarksDiv);
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
                setTimeout(function () {
                    // Display a PNotify notification
                    new PNotify({
                        title: 'A Mail will be sent',
                        text: 'You have selected "Not Ok". Please provide additional remarks.',
                        type: 'warning',
                        styling: 'bootstrap3'
                    });
                }, 200); // Adjust delay as necessary
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleTasteFlavorRemarksDiv(radioButtonList) {
            console.log("toggleTasteFlavorRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("TasteFlavorRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
                setTimeout(function () {
                    // Display a PNotify notification
                    new PNotify({
                        title: 'A Mail will be sent',
                        text: 'You have selected "Not Ok". Please provide additional remarks.',
                        type: 'warning',
                        styling: 'bootstrap3'
                    });
                }, 200); // Adjust delay as necessary
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleConsistencyRemarksDiv(radioButtonList) {
            console.log("toggleConsistencyRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("ConsistencyRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
                setTimeout(function () {
                    // Display a PNotify notification
                    new PNotify({
                        title: 'A Mail will be sent',
                        text: 'You have selected "Not Ok". Please provide additional remarks.',
                        type: 'warning',
                        styling: 'bootstrap3'
                    });
                }, 200); // Adjust delay as necessary
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleKriesTestRemarksDiv(radioButtonList) {
            console.log("toggleKriesTestRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("KriesTestRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
                setTimeout(function () {
                    // Display a PNotify notification
                    new PNotify({
                        title: 'A Mail will be sent',
                        text: 'You have selected "Not Ok". Please provide additional remarks.',
                        type: 'warning',
                        styling: 'bootstrap3'
                    });
                }, 200); // Adjust delay as necessary
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleOilTestRemarksDiv(radioButtonList) {
            console.log("toggleOilTestRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("OilTestRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
                setTimeout(function () {
                    // Display a PNotify notification
                    new PNotify({
                        title: 'A Mail will be sent',
                        text: 'You have selected "Not Ok". Please provide additional remarks.',
                        type: 'warning',
                        styling: 'bootstrap3'
                    });
                }, 200); // Adjust delay as necessary
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleAppStatusRemarksDiv(radioButtonList) {
            console.log("toggleAppStatusRemarksDiv function called");

            // Get the actual IDs of the controls rendered by ASP.NET
            var remarksInput = document.getElementById('<%= TXB_AppStatus_Remarks.ClientID %>');
            var remarksValidator = document.getElementById('<%= RFV_TXB_AppStatus_Remarks.ClientID %>');

            if (!remarksInput || !remarksValidator) {
                console.error("Remarks input or validator not found in the DOM.");
                return;
            }

            var selectedValue = radioButtonList.querySelector("input:checked").value;
            console.log("Selected value: " + selectedValue);

            if (selectedValue === "0") { // "Rejected" selected
                remarksInput.required = true;
                remarksValidator.style.display = "inline"; // Show validation error if not provided
                setTimeout(function () {
                    // Display a PNotify notification
                    new PNotify({
                        title: 'Input Required',
                        text: 'You have selected "Rejected". Remarks are mandatory.',
                        type: 'warning',
                        styling: 'bootstrap3'
                    });
                }, 200); // Adjust delay as necessary
            } else { // "Accepted" selected
                remarksInput.required = false;
                remarksValidator.style.display = "none"; // Hide validation error
            }
        }

    </script>

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>
                        <asp:Label ID="lbl_docname" runat="server" Text=" Oils and Fats"></asp:Label></h3>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docnumber" runat="server" Text="ANMOL/DOC/CORP/QC/RM"></asp:Label></h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">

                            <div class="col-md-12">
                                <h4 class="text-left text-info">Step-1: RM Basic Details</h4>
                                <hr />
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl__DDL_Material" runat="server" Text="Material :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_DDL_Material" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_Material" Display="Dynamic" InitialValue="0" ValidationGroup="Submit"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Material" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_DDL_Plant" runat="server" Text="Plant :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--  [<asp:Label ID="lbl_DDL_Plant_Value" runat="server" AssociatedControlID="DDL_Plant" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
                                     <asp:RequiredFieldValidator ID="RFV_DDL_Plant" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_Plant" Display="Dynamic" InitialValue="0" ValidationGroup="Submit"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="CategoryDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_DDL_ProductCategory" runat="server" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_DDL_ProductCategory" runat="server" ErrorMessage="*"  ForeColor="Red" InitialValue="0" ValidationGroup="Submit" ControlToValidate="DDL_ProductCategory" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_DDL_ProductBrand" runat="server" Text="Product Brand :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%-- [<asp:Label ID="lbl_DDL_ProductBrand_Value" runat="server" AssociatedControlID="DDL_ProductBrand" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductBrand" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_ProductBrand" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Supplier" runat="server" Text="Supplier :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%-- <asp:RequiredFieldValidator ID="RFV_TB_Supplier" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_Supplier" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Supplier" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_ChalanNo" runat="server" Text="Chalan No. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_ChalanNo" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_ChalanNo" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_ChalanNo" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_ChalanDate" runat="server" Text="Chalan Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_ChalanDate" runat="server" ErrorMessage="*" ControlToValidate="TB_ChalanDate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_ChalanDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" Placeholder=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_LotNo" runat="server" Text="LOT/ Gate No. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_LotNo" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_LotNo" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_LotNo" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_VehicleNo" runat="server" Text="Vehicle No. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%-- <asp:RequiredFieldValidator ID="RFV_TB_VehicleNo" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_VehicleNo" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_VehicleNo" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_BatchNo" runat="server" Text="Batch No. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_BatchNo" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_BatchNo" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_BatchNo" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_Grade" runat="server" Text="Grade :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%-- <asp:RequiredFieldValidator ID="RFV_TB_Grade" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_Grade" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Grade" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <hr />
                            </div>

                            <div class="col-md-12">
                                <h4 class="text-left text-info">Step-2: Physical Test</h4>
                                <hr />
                            </div>

                            <div class="col-md-3" id="ColorDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Color" runat="server" Text=" Color  :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%-- <asp:RequiredFieldValidator ID="RFV_RBL_Color" runat="server" ErrorMessage="*"  ForeColor="Red" ValidationGroup="Submit" ControlToValidate="RBL_Color" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:RadioButtonList ID="RBL_Color" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleColorRemarksDiv(this);">
                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="ColorRemarksDiv" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_ColorRemarks" runat="server" Text="Color Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%-- <asp:RequiredFieldValidator ID="RFV_TB_ColorRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_ColorRemarks" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_ColorRemarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="SmellDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Smell" runat="server" Text="Odour/Smell :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_RBL_Smell" runat="server" ErrorMessage="*"  ForeColor="Red" ValidationGroup="Submit" ControlToValidate="RBL_Smell" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:RadioButtonList ID="RBL_Smell" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleSmellRemarksDiv(this);">
                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="SmellRemarksDiv" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_SmellRemarks" runat="server" Text="Odour/Smell Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%-- <asp:RequiredFieldValidator ID="RFV_TXB_Smell_Remarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_Smell_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Smell_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="TasteFlavorDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TasteFlavor" runat="server" Text="Taste :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_RBL_TasteFlavor" runat="server" ErrorMessage="*"  ValidationGroup="Submit" ForeColor="Red" ControlToValidate="RBL_TasteFlavor" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:RadioButtonList ID="RBL_TasteFlavor" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleTasteFlavorRemarksDiv(this);">
                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="TasteFlavorRemarksDiv" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TasteFlavorRemarks" runat="server" Text=" Taste Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_TasteFlavor_Remarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_TasteFlavor_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_TasteFlavor_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="ConsistencyDiv" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Consistency" runat="server" Text="Consistency :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_RBL_Consistency" runat="server" ErrorMessage="*"  ValidationGroup="Submit" ForeColor="Red" ControlToValidate="RBL_Consistency" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:RadioButtonList ID="RBL_Consistency" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleConsistencyRemarksDiv(this);">
                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="ConsistencyRemarksDiv" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_ConsistencyRemarks" runat="server" Text=" Consistency Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_ConsistencyRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_ConsistencyRemarks" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_ConsistencyRemarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <hr />
                            </div>

                            <div class="col-md-12">
                                <h4 class="text-left text-info">Step-3: Parameters with Standards</h4>
                                <hr />
                            </div>

                            <div class="col-md-3" id="ImpuritiesDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_Foreign_Impurities" runat="server"  Text="ForeignMatter/Impurities :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                  <%--  <asp:RequiredFieldValidator ID="RFV_TB_Foreign_Impurities" runat="server" ValidationGroup="Submit" ErrorMessage="Input Required"  ControlToValidate="TB_Foreign_Impurities" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Foreign_Impurities" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_MP" runat="server" Text="MP/CP  :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_MP" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_MP" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_MP" runat="server" ValidationGroup="Submit" ControlToValidate="TB_MP" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="^\d+(\.\d+)?$" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_MP" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Number"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_PV" runat="server" Text="PV (meq. O2 / kg)  :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_PV" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_PV" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_PV" runat="server" ValidationGroup="Submit" ControlToValidate="TB_PV" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="^\d+(\.\d+)?$" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_PV" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="MoistureDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_Moisture" runat="server" Text="Moisture(%) :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_Moisture" runat="server" ErrorMessage="*" ValidationGroup="Submit"  ControlToValidate="TB_Moisture" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_Moisture" runat="server"  ControlToValidate="TB_Moisture" ValidationGroup="Submit" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="^\d+(\.\d+)?$" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Moisture" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_IodineVal" runat="server" Text="Iodine Value :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_IodineVal" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_IodineVal" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_IodineVal" runat="server" ValidationGroup="Submit" ControlToValidate="TB_IodineVal" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="^\d+(\.\d+)?$" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_IodineVal" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_AcidValue" runat="server" Text="Acid Value/ FFA (%) :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_AcidValue" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_AcidValue" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_AcidValue" runat="server" ValidationGroup="Submit" ControlToValidate="TB_AcidValue" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="^\d+(\.\d+)?$" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_AcidValue" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="KriesTestDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_KriesTest" runat="server" Text="Kries Test :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%-- <asp:RequiredFieldValidator ID="RFV_RBL_KriesTest" runat="server" ErrorMessage="*"  ValidationGroup="Submit" ForeColor="Red" ControlToValidate="RBL_KriesTest" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:RadioButtonList ID="RBL_KriesTest" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleKriesTestRemarksDiv(this);">
                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="KriesTestRemarksDiv" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_KriesTestRemarks" runat="server" Text=" Kries Test Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_KriesTest_Remarks" runat="server"  ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_KriesTest_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_KriesTest_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="OilTestDiv" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_OilTest" runat="server" Text="Test of Argemone Oil/ Caster Oil :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%-- <asp:RequiredFieldValidator ID="RFV_RBL_OilTest" runat="server" ErrorMessage="*"  ValidationGroup="Submit" ForeColor="Red" ControlToValidate="RBL_OilTest" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:RadioButtonList ID="RBL_OilTest" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleOilTestRemarksDiv(this);">
                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="OilTestRemarksDiv" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="OilTestRemarks" runat="server" Text=" Test of Argemone Oil/ Caster Oil Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_OilTest_Remarks" runat="server"  ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_OilTest_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_OilTest_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <hr />
                            </div>

                            <div class="col-md-12">
                                <h4 class="text-left text-info">Step-4: Attachments</h4>
                                <hr />
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_FinalRemarks" runat="server" Text="Final Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_FinalRemarks" runat="server"  ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_FinalRemarks" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_FinalRemarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                             <div class="col-md-3" id="AppStatusDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="LabelAppStatus" runat="server" AssociatedControlID="RBL_AppStatus" Text="Approval Status :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_RBL_AppStatus" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="RBL_AppStatus" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:RadioButtonList ID="RBL_AppStatus" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleAppStatusRemarksDiv(this);">
                                            <asp:ListItem Text="Accepted" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Rejected" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="AppStatusRemarksDiv">
                                <div class="mb-3">
                                    <asp:Label ID="LabelAppStatusRemarks" runat="server" AssociatedControlID="TXB_AppStatus_Remarks" Text="Approval Status Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TXB_AppStatus_Remarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_AppStatus_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TXB_AppStatus_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3" id="FU_MaterialImage_Upldr" runat="server" visible="true">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_FU_MaterialImage" runat="server" AssociatedControlID="FU_MaterialImage" Text="Material Image" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_FU_MaterialImage" runat="server" ErrorMessage="*" ControlToValidate="FU_MaterialImage" Display="Dynamic" ValidationGroup="ValidationGroup1" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="CV_FU_MaterialImage" runat="server" ControlToValidate="FU_MaterialImage" Display="Dynamic" ValidationGroup="ValidationGroup1" ErrorMessage="Please upload file"></asp:CustomValidator>
                                    <asp:Label ID="lblErrorMessage1" runat="server" CssClass="text-danger"></asp:Label>
                                    <div class="input-group input-group-sm">
                                        <asp:FileUpload ID="FU_MaterialImage" runat="server" CssClass="form-control rounded" onchange="displayImage(this);" />
                                        <span class="input-group-btn">
                                            <asp:Button ID="BtnUploadFU_MaterialImage" runat="server" CssClass="btn btn-primary btn-sm" Text="Upload" OnClientClick="return validateForm1();" ValidationGroup="ValidationGroup1" CausesValidation="false" />
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="FU_MaterialImage_img" runat="server" visible="false">
                                <asp:Image ID="uploadedImage1" runat="server" CssClass="img-fluid" />
                            </div>

                            <%--Button--%>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group input-group-sm">
                                        <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" CausesValidation="true" ValidationGroup="Submit" />
                                        <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" />
                                        <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="Label6" runat="server" Text="Approval Matrix"></asp:Label></h2>
                            <div class="clearfix"></div>

                        </div>
                        <div class="x_content">
                            <!-- Approver Flow Diagram -->
                            <div class="approver-flow">
                                <div class="approver-item">
                                    <p>
                                        <asp:Label ID="Label9" runat="server" Text="Approver 1" />
                                    </p>
                                    <asp:Image ID="Image3" runat="server" ImageUrl="~/WebData/No_Image.jpg" class="approver-photo" />
                                    <p>
                                        <asp:Label ID="Approver1NameLabel" runat="server" Text='<%# Eval("Approver1Name") %>' />
                                    </p>
                                    <p>
                                        <asp:Label ID="Approver1CodeLabel" runat="server" Text='<%# Eval("Approver1EmployeeCode") %>' />
                                    </p>
                                </div>
                                <div class="flow-line"></div>
                                <div class="approver-item">
                                    <p>
                                        <asp:Label ID="Label10" runat="server" Text="Approver 2" />
                                    </p>
                                    <asp:Image ID="Image2" runat="server" ImageUrl="~/WebData/No_Image.jpg" class="approver-photo" />
                                    <p>
                                        <asp:Label ID="Approver2NameLabel" runat="server" Text='<%# Eval("Approver2Name") %>' />
                                    </p>
                                    <p>
                                        <asp:Label ID="Approver2CodeLabel" runat="server" Text='<%# Eval("Approver2EmployeeCode") %>' />
                                    </p>
                                </div>
                                <div class="flow-line"></div>
                                <div class="approver-item">
                                    <p>
                                        <asp:Label ID="Label11" runat="server" Text="Approver 3" />
                                    </p>
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/WebData/No_Image.jpg" class="approver-photo" />
                                    <p>
                                        <asp:Label ID="DottedLineApproverNameLabel" runat="server" Text='<%# Eval("DottedLineApproverName") %>' />
                                    </p>
                                    <p>
                                        <asp:Label ID="DottedLineApproverCodeLabel" runat="server" Text='<%# Eval("DottedLineApproverEmployeeCode") %>' />
                                    </p>
                                </div>
                            </div>

                            <hr />

                            <!-- GridView for Detailed Information -->
                            <asp:GridView ID="GridViewApprovers" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap" Visible="false">
                                <Columns>
                                    <asp:BoundField DataField="Approver1Name" HeaderText="Approver 1 Name" HtmlEncode="false" />
                                    <asp:BoundField DataField="Approver1EmployeeCode" HeaderText="Approver 1" HtmlEncode="false" />
                                    <asp:BoundField DataField="Approver2Name" HeaderText="Approver 2 Name" HtmlEncode="false" />
                                    <asp:BoundField DataField="Approver2EmployeeCode" HeaderText="Approver 2" HtmlEncode="false" />
                                    <asp:BoundField DataField="DottedLineApproverName" HeaderText="Dotted Line Approver Name" HtmlEncode="false" />
                                    <asp:BoundField DataField="DottedLineApproverEmployeeCode" HeaderText="Dotted Line Approver Code" HtmlEncode="false" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
