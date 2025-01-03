<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="bopp_tape.aspx.cs" Inherits="AnmolDristi.bopp_tape" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .remove-border {
            border: none !important; /* This will ensure the border is removed */
            /* Add any other necessary styling */
        }
        /* Custom CSS to ensure proper alignment and spacing */
        .d-flex {
            display: flex;
            align-items: center;
        }

        .remarks-container {
            display: flex;
            flex-direction: column;
            margin-left: 10px;
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
    <script type="text/javascript">
        // JavaScript function to toggle remarks textbox
        function toggleRemarks() {
            var inputVal = parseFloat(document.getElementById('<%= TB_StandardDimension.ClientID %>').value);
            var remarksSection = document.getElementById('RemarksSection');

            // Check if the input is outside the range 99.5 to 101
            if (inputVal < 99.5 || inputVal > 101) {
                remarksSection.style.display = 'block'; // Show remarks section
            } else {
                remarksSection.style.display = 'none';  // Hide remarks section
            }
        }

        // Ensure the DOM is loaded before adding the event listener
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById('<%= TB_StandardDimension.ClientID %>').addEventListener('keyup', toggleRemarks);
            });
            window.onload = function () {

                // Function to validate the Standard Dimension against the range 99.5 to 101
                function checkStandardDimension() {
                    var dimensionValue = parseFloat(document.getElementById('<%= TB_StandardDimension.ClientID %>').value);
                var minValue = 99.5;
                var maxValue = 101;

                // Show remarks if the dimension value is outside the valid range
                if (dimensionValue < minValue || dimensionValue > maxValue) {
                    document.getElementById('RemarksSection').style.display = 'block';
                } else {
                    document.getElementById('RemarksSection').style.display = 'none';
                }
            }

            // Function to validate the Standard GSM against the range 99.5 to 101
            function checkStandardGSM() {
                var gsmValue = parseFloat(document.getElementById('<%= TB_StandardGSM.ClientID %>').value);
                    var minValue = 99.5;
                    var maxValue = 101;

                    // Show remarks if GSM value is outside the valid range
                    if (gsmValue < minValue || gsmValue > maxValue) {
                        document.getElementById('div_GSM_Remarks').style.display = 'block';
                    } else {
                        document.getElementById('div_GSM_Remarks').style.display = 'none';
                    }
                }

            // Attach event listener for Standard Dimension TextBox to validate input on keyup
            var standardDimensionTextBox = document.getElementById('<%= TB_StandardDimension.ClientID %>');
            if (standardDimensionTextBox) {
                standardDimensionTextBox.addEventListener('keyup', checkStandardDimension);
            }

            // Attach event listener for Standard GSM TextBox to validate input on change
            var standardGSMTextBox = document.getElementById('<%= TB_StandardGSM.ClientID %>');
                if (standardGSMTextBox) {
                    standardGSMTextBox.addEventListener('change', checkStandardGSM);
                }
        };

    </script>
    <asp:HiddenField ID="hdn_formid" runat="server" />
    <asp:HiddenField ID="hdn_shiftvalue" runat="server" />
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>
                        <asp:Label ID="lbl_docname" runat="server" Text=" Adhesive Tape Report"></asp:Label>
                    </h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docnumber" runat="server" Text="ANMOL/DOC/CORP/QC/PKNG/02"></asp:Label>
                            </h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">

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
                                        <asp:Label ID="Lbl_TB_LotNo" runat="server" AssociatedControlID="TB_LotNo" Text="Lot and Gate No.:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_LotNo" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_LotNo" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_LotNo" runat="server" ControlToValidate="TB_LotNo" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="TB_LotNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Lot and Gate No." MaxLength="20"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_TB_VehicleNo" runat="server" AssociatedControlID="TB_VehicleNo" Text="Vehicle No.:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_VehicleNo" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_VehicleNo" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_VehicleNo" runat="server" ControlToValidate="TB_VehicleNo" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="TB_VehicleNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Vehicle No." MaxLength="15"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_TB_PrintingColour" runat="server" AssociatedControlID="TB_PrintingColour" Text="Printing Colour:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_PrintingColour" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_PrintingColour" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_PrintingColour" runat="server" ControlToValidate="TB_PrintingColour" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="TB_PrintingColour" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Printing Colour" MaxLength="20"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_TB_AdhesiveProperty" runat="server" AssociatedControlID="TB_AdhesiveProperty" Text="Adhesive Property:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_AdhesiveProperty" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_AdhesiveProperty" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="REV_TB_AdhesiveProperty" runat="server" ControlToValidate="TB_AdhesiveProperty" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="TB_AdhesiveProperty" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Adhesive Property" MaxLength="25"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <!-- Label for Standard Dimension -->
                                        <asp:Label ID="Lbl_TB_StandardDimension" runat="server" AssociatedControlID="TB_StandardDimension" Text="Standard Dimension (in mm):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <!-- Required Field Validator -->
                                        <asp:RequiredFieldValidator ID="RFV_TB_StandardDimension" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_StandardDimension" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <!-- Range Validator for 99.5 to 101 mm -->
                                        <asp:RangeValidator ID="RV_TB_StandardDimension" runat="server" ControlToValidate="TB_StandardDimension" MinimumValue="99.5" MaximumValue="101" Type="Double" ErrorMessage="Value must be between 99.5 and 101 mm"  Display="Dynamic" ForeColor="Red"></asp:RangeValidator>
                                        <div class="input-group-sm">
                                            <!-- Textbox for Standard Dimension -->
                                            <asp:TextBox ID="TB_StandardDimension" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Standard Dimension" MaxLength="25"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <!-- Remarks Textbox for invalid input (initially hidden) -->
                                <div class="col-md-3" id="RemarksSection" style="display: none;">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_Remarks" runat="server" Text="Remarks:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="TB_StandardDimensionRemarks" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Remarks" MaxLength="250"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <!-- Dimension Observation Field (No Validation) -->
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_DimensionObservation" runat="server" AssociatedControlID="TB_DimensionObservation" Text="Dimension Observation (in mm):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <!-- No validation required for this input field -->
                                            <asp:TextBox ID="TB_DimensionObservation" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Dimension Observation"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>


                                <div class="col-md-3">
                                    <!-- Standard GSM Field with Validation (Range: 99.5 to 101) -->
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_StandardGSM" runat="server" AssociatedControlID="TB_StandardGSM" Text="Standard GSM:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_StandardGSM" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_StandardGSM" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RangeValidator ID="RV_StandardGSM" runat="server" ControlToValidate="TB_StandardGSM" ErrorMessage="Value must be between 99.5 and 101" MinimumValue="99.5" MaximumValue="101" Type="Double"  Display="Dynamic" ForeColor="Red"></asp:RangeValidator>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="TB_StandardGSM" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Standard GSM"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <!-- Hidden Remarks Field for Standard GSM Validation Deviation (Initially Hidden) -->
                                <div class="col-md-3" id="div_GSM_Remarks" style="display: none;">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_GSMRemarks" runat="server" AssociatedControlID="TB_GSMRemarks" Text="Remarks (GSM Deviation):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="TB_GSMRemarks" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter reason for deviation"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <!-- GSM Observation Field (No Validation Required) -->
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_GSMObservation" runat="server" AssociatedControlID="TB_GSMObservation" Text="GSM Observation:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="TB_GSMObservation" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter GSM Observation"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>



                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_TB_Remarks" runat="server" AssociatedControlID="TB_Remarks" Text="Remarks:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="TB_Remarks" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Placeholder="Enter any additional remarks" Rows="4" MaxLength="500"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <%--Button--%>
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group input-group-sm">
                                            <asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
                                            <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                                            <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
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
