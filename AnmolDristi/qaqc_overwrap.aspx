<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_overwrap.aspx.cs" Inherits="AnmolDristi.qaqc_overwrap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
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
            /*padding-bottom:20px;*/
        }

            .custom-page-title .title_left h3 {
                font-size: 20px;
                color: #333333;
                font-weight: bold;
            }

        /*.nav-tabs .nav-link.active {
         background-color: #17a2b8;
         color: white;
         border: 2px solid #17a2b8;
         border-radius: 5px;
     }

     .nav-tabs .nav-link:hover {
         background-color: #e9ecef;
         color: #17a2b8;
     }*/

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
    <script type="text/javascript">
        function validateGSM() {
            // Get the value of the GSM input field
            var gsmValue = parseFloat(document.getElementById('<%=TB_GMS_Std.ClientID %>').value);

            // Get the remark section element
            var remarkSection = document.getElementById("remarkSection");

            // Valid range for GSM (Standard value = 100g, Lower Tolerance = 99.5g, Upper Tolerance = 101g)
            var lowerLimit =0.00;
            var upperLimit = 1000.0;

            // Check if the GSM value is outside the valid range
            if (gsmValue < lowerLimit || gsmValue > upperLimit) {
                // Show the remark section if the value is outside the range
                remarkSection.style.display = "block";
            } else {
                // Hide the remark section if the value is within the valid range
                remarkSection.style.display = "none";
            }
        }
    </script>
    <script type="text/javascript">
        function validateDimension() {
            // Get the value of the Dimension input field
            var dimensionValue = parseFloat(document.getElementById('<%= TB_DimensionStd.ClientID %>').value);

            // Get the remark section element
            var remarkSection = document.getElementById("remarkSection1");

            // Valid range for dimension: 99.5mm to 101mm
            var lowerLimit = 0.00;
            var upperLimit = 1000.00;

            // Check if the Dimension value is outside the valid range
            if (isNaN(dimensionValue) || dimensionValue < lowerLimit || dimensionValue > upperLimit) {
                // Show the remark section if the value is outside the range (below 99.5 or above 101)
                remarkSection.style.display = "block";
            } else {
                // Hide the remark section if the value is within the valid range
                remarkSection.style.display = "none";
            }
        }
    </script>
    <asp:HiddenField ID="hdn_formid" runat="server" />
    <asp:HiddenField ID="hdn_shiftvalue" runat="server" />
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>
                        <asp:Label ID="lbl_docname" runat="server" Text="Label"></asp:Label>
                    </h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docnumber" runat="server" Text="Label"></asp:Label>
                            </h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-12">
                                                <%--<div class="tab-content ml-1" id="myTabContent">
                                                    <div class="tab-pane fade show active" id="basicData" role="tabpanel" aria-labelledby="basicData-tab">--%>
                                                        <div class="x_content">
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="DDL_Plant" Text="Plant Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_Plant" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_Plant" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_Plant_SelectedIndexChanged"></asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductBrand" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_ProductBrand" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductBrand_SelectedIndexChanged"></asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_SupplierName" runat="server" AssociatedControlID="TB_SupplierName" Text="Supplier Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_SupplierName" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_SupplierName" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_SupplierName" runat="server" ControlToValidate="TB_SupplierName" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SupplierName" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Supplier Name" MaxLength="50"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_ChallanNo" runat="server" AssociatedControlID="TB_ChallanNo" Text="Challan No.:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_ChallanNo" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_ChallanNo" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_ChallanNo" runat="server" ControlToValidate="TB_ChallanNo" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_ChallanNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Challan No." MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_ChallanDate" runat="server" AssociatedControlID="TB_ChallanDate" Text="Challan Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_ChallanDate" runat="server" ErrorMessage="Date Required" ControlToValidate="TB_ChallanDate" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_ChallanDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" Placeholder="Select Challan Date"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_LotGateNo" runat="server" AssociatedControlID="TB_LotGateNo" Text="Lot/Gate No.:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_LotGateNo" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_LotGateNo" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_LotGateNo" runat="server" ControlToValidate="TB_LotGateNo" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_LotGateNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Lot/Gate No." MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_VehicleNo" runat="server" AssociatedControlID="TB_VehicleNo" Text="Vehicle No.:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_VehicleNo" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_VehicleNo" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_VehicleNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Vehicle No." MaxLength="12"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_SealingValue" runat="server" AssociatedControlID="TB_SealingValue" Text="Sealing Value:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_SealingValue" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_SealingValue" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RangeValidator ID="RV_TB_SealingValue" runat="server" ControlToValidate="TB_SealingValue" ValidationGroup="Submit" ErrorMessage="Sealing Value must be between 0 and 1000" MinimumValue="0" MaximumValue="1000" Type="Double" Display="Dynamic" ForeColor="Red"></asp:RangeValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SealingValue" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Sealing Value" MaxLength="10"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <!-- Label for Standard Dimension (in mm) -->
                                                                    <asp:Label ID="LBL_DimensionStd" runat="server" AssociatedControlID="TB_DimensionStd" Text="Standard Dimension (in mm):"
                                                                        ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:Literal ID="span_Dimension" runat="server" Text='<%# Eval("Dimension_Std") %>'></asp:Literal>

                                                                    <!-- Required Field Validator -->
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_DimensionStd" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DimensionStd"
                                                                        ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                                                    <!-- Range Validator to ensure the input is within the valid range -->
                                                                    <asp:RangeValidator ID="RV_TB_DimensionStd" runat="server" ControlToValidate="TB_DimensionStd" ValidationGroup="Submit"
                                                                        ErrorMessage="Value must be between 0.00mm and 1000.0mm" MinimumValue="0.00" MaximumValue="1000.00" Type="Double"
                                                                        Display="Dynamic" ForeColor="Red"></asp:RangeValidator>

                                                                    <!-- Input TextBox for Standard Dimension (in mm) -->
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DimensionStd" runat="server" CssClass="form-control form-control-sm rounded"
                                                                            Placeholder="Enter 0.00mm and 1000.0mm Dimension" MaxLength="10" OnKeyUp="validateDimension()"
                                                                            ClientIDMode="Static"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- Hidden Remark Section -->
                                                            <div class="col-md-3" id="remarkSection1" style="display: none;">
                                                                <div class="mb-3">
                                                                    <!-- Label for Remark -->
                                                                    <asp:Label ID="Lbl_Remark_Dimension" runat="server" AssociatedControlID="TB_Remarks" Text="Please provide a remark for deviation:"
                                                                        ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>

                                                                    <!-- Input TextBox for Remark -->
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Remark_Dimension" runat="server" CssClass="form-control form-control-sm rounded"
                                                                            Placeholder="Enter remark for deviation"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_DimensionObs" runat="server" AssociatedControlID="TB_DimensionObs" Text="Observed Dimension (in mm):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_DimensionObs" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DimensionObs" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RangeValidator ID="RV_TB_DimensionObs" runat="server" ControlToValidate="TB_DimensionObs" ValidationGroup="Submit" ErrorMessage="Invalid Obs Dimension" MinimumValue="0" MaximumValue="1000" Type="Double" Display="Dynamic" ForeColor="Red"></asp:RangeValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DimensionObs" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Observed Dimension (in mm)" MaxLength="50"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <!-- Label for GSM/WT per 10 PS (STD) -->
                                                                    <asp:Label ID="Lbl_TB_GMS_Std" runat="server" AssociatedControlID="TB_GMS_Std"
                                                                        Text="GSM/WT per 10 PS (STD):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:Literal ID="span_GMS" runat="server" Text='<%# Eval("GMS_Std") %>'></asp:Literal>

                                                                    <!-- Required Field Validator -->
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_GMS_Std" runat="server" ErrorMessage="Input Required"
                                                                        ControlToValidate="TB_GMS_Std" ValidationGroup="Submit" InitialValue="" Display="Dynamic"
                                                                        ForeColor="Red"></asp:RequiredFieldValidator>

                                                                    <!-- Range Validator to ensure the input is within the valid range -->
                                                                    <asp:RangeValidator ID="RV_TB_GMS_Std" runat="server" ControlToValidate="TB_GMS_Std"
                                                                        ValidationGroup="Submit" ErrorMessage="Value must be between 0.00g to 1000.00g"
                                                                        MinimumValue="0.00" MaximumValue="1000.00" Type="Double" Display="Dynamic"
                                                                        ForeColor="Red"></asp:RangeValidator>
                                                                    <!-- Input TextBox for GSM/WT per 10 PS (STD) -->
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_GMS_Std" runat="server" CssClass="form-control form-control-sm rounded"
                                                                            Placeholder="Enter 0.00g to 1000.00g GSM/Weight per 10 PS" MaxLength="10"
                                                                            OnKeyUp="validateGSM()" ClientIDMode="Static"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- Hidden Remark Section -->
                                                            <div class="col-md-3" id="remarkSection" style="display: none;">
                                                                <div class="mb-3">
                                                                    <!-- Label for Remark -->
                                                                    <asp:Label ID="Lbl_Remark_GSM" runat="server" AssociatedControlID="TB_Remark_GSM"
                                                                        Text="Please provide a remark for deviation:" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>

                                                                    <!-- Input TextBox for Remark -->
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Remark_GSM" runat="server" CssClass="form-control form-control-sm rounded"
                                                                            Placeholder="Enter remark for deviation"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_GSM_Obs" runat="server" AssociatedControlID="TB_GSM_Obs" Text="GSM/WT per 10 PS (OBS):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_GSM_Obs" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_GSM_Obs" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RangeValidator ID="RV_TB_GSM_Obs" runat="server" ControlToValidate="TB_GSM_Obs" ValidationGroup="Submit" ErrorMessage="Invalid GSM/Weight" MinimumValue="0" MaximumValue="1000" Type="Double" Display="Dynamic" ForeColor="Red"></asp:RangeValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_GSM_Obs" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Observed GSM/Weight per 10 PS" MaxLength="10"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_Remarks" runat="server" AssociatedControlID="TB_Remarks" Text="Remarks:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Remarks" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Placeholder="Enter any additional remarks" Rows="4" MaxLength="200"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="btn_overwrap_submit" Text="Click to SUBMIT" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group input-group-sm">
                                                                        <asp:Button ID="btn_overwrap_submit" runat="server" Text="Submit" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="btn_overwrap_submit_Click" />
                                                                        <asp:Button ID="btn_overwrap_reset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="btn_overwrap_reset_Click" />
                                                                        <%--<asp:Button ID="Button1" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />--%>
                                                                        <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    <%--</div>
                                                </div>--%>
                                            </div>
                                        </div>
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
                                <asp:Label ID="Label8" runat="server" Text="Approval Matrix"></asp:Label></h2>
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
