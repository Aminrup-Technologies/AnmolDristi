<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Material_Master.aspx.cs" Inherits="AnmolDristi.Material_Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript">

        //image
        function validateForm1() {
            var fileUpload = document.getElementById('<%= FU_FitnessDocImage.ClientID %>');
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
            var fileUpload = document.getElementById('<%= FU_FitnessDocImage.ClientID %>'); // Get the FileUpload control
            var errorMessageLabel = document.getElementById('<%= lblErrorMessage1.ClientID %>'); // Get the error message label

            if (fileUpload.value === "") {
                errorMessageLabel.innerHTML = "Please select a file before submitting."; // Display error message
                errorMessageLabel.style.color = "red"; // Change color to red
                return false; // Prevent form submission
            }

            // File is selected, return true to allow form submission
            return true;
        }

       


    </script>

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>
                        <asp:Label ID="lbl_docname" runat="server" Text="N/A"></asp:Label>
                    </h3>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">

                        <div class="x_content">

                            <div class="col-md-3" id="MaterialTypeDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_DDL_MaterialType" runat="server" AssociatedControlID="DDL_MaterialType" Text="Material Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_MaterialType" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_MaterialType" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_MaterialType" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_MaterialType_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="ModelDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_ModelNo" runat="server" AssociatedControlID="TB_ModelNo" Text="Model Number :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_ModelNo" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_ModelNo" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_ModelNo" runat="server" ControlToValidate="TB_ModelNo" ForeColor="Red" ValidationGroup="Submit" ErrorMessage=" Alphanumeric Only " ValidationExpression="^[A-Z]+-\d+$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_ModelNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Eg:-MOD-1234"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="MaterialBrandDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_MaterialBrand" runat="server" AssociatedControlID="TB_MaterialBrand" Text="Material Brand :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_MaterialBrand" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_MaterialBrand" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_MaterialBrand" runat="server" ControlToValidate="TB_MaterialBrand" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphabet Only" ValidationExpression="^[a-zA-Z ]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_MaterialBrand" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Eg:- BrandX"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <%--<div class="col-md-3" id="MechanicalDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_MechName" runat="server" AssociatedControlID="TB_MechName" Text="Material Mechanical Name :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_MechName" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_MechName" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_MechName" runat="server" ControlToValidate="TB_MechName" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphabet Only" ValidationExpression="^[a-zA-Z ]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_MechName" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Eg:- Mechanical Part X-200"></asp:TextBox>
                                    </div>
                                </div>
                            </div>--%>

                            <div class="col-md-3" id="FriendlyDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_FriendlyName" runat="server" AssociatedControlID="TB_FriendlyName" Text="Friendly Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_FriendlyName" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_FriendlyName" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_FriendlyName" runat="server" ControlToValidate="TB_FriendlyName" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphabet Only" ValidationExpression="^[a-zA-Z ]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_FriendlyName" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Friendly Component Name"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="SeriallDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_SerialNo" runat="server" AssociatedControlID="TB_SerialNo" Text="Serial Number :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_SerialNo" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_SerialNo" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_SerialNo" runat="server" ControlToValidate="TB_SerialNo" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[A-Za-z]+-\d+$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_SerialNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Eg:- SN-0011223344"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="MfgDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_Mfg" runat="server" AssociatedControlID="TB_Mfg" Text="Manufacturing/MakeYear" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Mfg" runat="server" ErrorMessage="Date is required " ValidationGroup="Submit" ControlToValidate="TB_Mfg" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_Mfg" runat="server" ControlToValidate="TB_Mfg" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Year only" ValidationExpression="^[1-9]\d{3}$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Mfg" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Eg:-2023"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="PrintedRateDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_PrintedRate" runat="server" AssociatedControlID="TB_PrintedRate" Text="PrintedRate" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_PrintedRate" runat="server" ErrorMessage="Rate is required " ValidationGroup="Submit" ControlToValidate="TB_PrintedRate" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_PrintedRate" runat="server" ControlToValidate="TB_PrintedRate" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Decimal only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_PrintedRate" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Printed Rate"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="PurchaseRateDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_PurchaseRate" runat="server" AssociatedControlID="TB_PurchaseRate" Text="Purchase Rate" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_PurchaseRate" runat="server" ErrorMessage="Rate is required " ValidationGroup="Submit" ControlToValidate="TB_PurchaseRate" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_PurchaseRate" runat="server" ControlToValidate="TB_PurchaseRate" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Decimal only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_PurchaseRate" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Purchase Rate"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="PurchaseDateDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_PurchaseDate" runat="server" AssociatedControlID="TB_PurchaseDate" Text="Purchase Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_PurchaseDate" runat="server" ErrorMessage="Date is required " ValidationGroup="Submit" ControlToValidate="TB_PurchaseDate" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_PurchaseDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="ClassificationDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_DDL_Classification" runat="server" AssociatedControlID="DDL_Classification" Text="Material Classification" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_Classification" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_Classification" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Classification" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_Classification_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="StatusDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_DDL_Status" runat="server" AssociatedControlID="DDL_Status" Text="Operational Status" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_Status" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_Status" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Status" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_Status_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="DescriptionDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_Description" runat="server" AssociatedControlID="TB_Description" Text="Material Description:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Description" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Description" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_Description" runat="server" ControlToValidate="TB_Description" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphabet Only" ValidationExpression="^[a-zA-Z ]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Description" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Material Description"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="PurchaseOrderDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_PurchaseOrderNo" runat="server" AssociatedControlID="TB_PurchaseOrderNo" Text="Purchase Order Number :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_PurchaseOrderNo" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_PurchaseOrderNo" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_PurchaseOrderNo" runat="server" ControlToValidate="TB_PurchaseOrderNo" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[A-Z]+-\d+$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_PurchaseOrderNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Eg:- PO-2024"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="EndLifeDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_EndLife" runat="server" AssociatedControlID="TB_EndLife" Text="End Of Life Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_EndLife" runat="server" ErrorMessage="Date is required " ValidationGroup="Submit" ControlToValidate="TB_EndLife" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_EndLife" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="FrenquencyDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_DDL_MaintenanceFrequency" runat="server" AssociatedControlID="DDL_MaintenanceFrequency" Text="Maintenance Frequency" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_MaintenanceFrequency" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_MaintenanceFrequency" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_MaintenanceFrequency" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_MaintenanceFrequency_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="ReorderDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_ReoderLevel" runat="server" AssociatedControlID="TB_ReoderLevel" Text="Reoder Level" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_ReoderLevel" runat="server" ErrorMessage="Input is required " ValidationGroup="Submit" ControlToValidate="TB_ReoderLevel" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_ReoderLevel" runat="server" ControlToValidate="TB_ReoderLevel" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Integer only" ValidationExpression="^[0-9]\d*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_ReoderLevel" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Reoder Level"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="ShelfLifeDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_ShelfLife" runat="server" AssociatedControlID="TB_ShelfLife" Text="Shelf Life Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_ShelfLife" runat="server" ErrorMessage="Date is required " ValidationGroup="Submit" ControlToValidate="TB_ShelfLife" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_ShelfLife" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="WarrantyDateDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_WarrantyDate" runat="server" AssociatedControlID="TB_WarrantyDate" Text="Warranty End Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_WarrantyDate" runat="server" ErrorMessage="Date is required " ValidationGroup="Submit" ControlToValidate="TB_WarrantyDate" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_WarrantyDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="InstallationDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_Installation" runat="server" AssociatedControlID="TB_Installation" Text="Installation Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Installation" runat="server" ErrorMessage="Date is required " ValidationGroup="Submit" ControlToValidate="TB_Installation" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Installation" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="MaintenanceDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="LblTB_LastMaintenance" runat="server" AssociatedControlID="TB_Installation" Text=" Last Maintenance Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_LastMaintenance" runat="server" ErrorMessage="Date is required " ValidationGroup="Submit" ControlToValidate="TB_LastMaintenance" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_LastMaintenance" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="QuantityDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_OpeningStockQuantity" runat="server" AssociatedControlID="TB_OpeningStockQuantity" Text="Opening Stock Quantity" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_OpeningStockQuantity" runat="server" ErrorMessage="Input is required " ValidationGroup="Submit" ControlToValidate="TB_OpeningStockQuantity" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_OpeningStockQuantity" runat="server" ControlToValidate="TB_OpeningStockQuantity" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Decimal only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_OpeningStockQuantity" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Quantity Value"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="UnitMeasureDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_DDL_UnitOfMeasure" runat="server" AssociatedControlID="DDL_UnitOfMeasure" Text="Unit Of Measure " ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_UnitOfMeasure" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_UnitOfMeasure" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_UnitOfMeasure" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_UnitOfMeasure_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="CalibrationDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_CalibrationDate" runat="server" AssociatedControlID="TB_CalibrationDate" Text="Calibration Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_CalibrationDate" runat="server" ErrorMessage="Date is required " ValidationGroup="Submit" ControlToValidate="TB_CalibrationDate" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_CalibrationDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="TenureDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_DDL_Tenure" runat="server" AssociatedControlID="DDL_Tenure" Text="Calibration Tenure " ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_Tenure" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_Tenure" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Tenure" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_Tenure_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="DueDateDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_DueDate" runat="server" AssociatedControlID="TB_DueDate" Text="Due Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_DueDate" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded" Placeholder="Caliberation Due Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="FitnessCertificateDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_FitnessCertificationDate" runat="server" AssociatedControlID="TB_FitnessCertificationDate" Text="Fitness Certification Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_FitnessCertificationDate" runat="server" ErrorMessage="Date is required " ValidationGroup="Submit" ControlToValidate="TB_FitnessCertificationDate" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_FitnessCertificationDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="FitnessDueDateDIV" runat="server">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_FitnessDueDate" runat="server" AssociatedControlID="TB_FitnessDueDate" Text="Fitness Due Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_FitnessDueDate" runat="server" ErrorMessage="Date is required " ValidationGroup="Submit" ControlToValidate="TB_FitnessDueDate" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_FitnessDueDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="FU_FitnessDocImage_Upldr" runat="server" visible="false">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_FU_FitnessDocImage" runat="server" AssociatedControlID="FU_FitnessDocImage" Text="Fitness Document Image" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_FU_FitnessDocImage" runat="server" ErrorMessage="*" ControlToValidate="FU_FitnessDocImage" Display="Dynamic" ValidationGroup="ValidationGroup1" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="CV_FU_FitnessDocImage" runat="server" ControlToValidate="FU_FitnessDocImage" Display="Dynamic" ValidationGroup="ValidationGroup1" ErrorMessage="Please upload file"></asp:CustomValidator>
                                    <asp:Label ID="lblErrorMessage1" runat="server" CssClass="text-danger"></asp:Label>
                                    <div class="input-group input-group-sm">
                                        <asp:FileUpload ID="FU_FitnessDocImage" runat="server" CssClass="form-control rounded" onchange="displayImage(this);" />
                                        <span class="input-group-btn">
                                            <asp:Button ID="BtnUploadFU_FitnessDocImage" runat="server" CssClass="btn btn-primary btn-sm" Text="Upload" OnClientClick="return validateForm1();" OnClick="BtnUploadFU_FitnessDocImage_Click" ValidationGroup="ValidationGroup1" CausesValidation="true" />
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="FU_FitnessDocImage_img" runat="server" visible="false">
                                <asp:Image ID="uploadedImage1" runat="server" CssClass="img-fluid" />
                            </div>

                            <%--Button--%>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_BtnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group input-group-sm">
                                        <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
                                        <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                                        <asp:Button ID="Btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
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
