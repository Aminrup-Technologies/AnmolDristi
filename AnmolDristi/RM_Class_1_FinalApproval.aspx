<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="RM_Class_1_FinalApproval.aspx.cs" Inherits="AnmolDristi.RM_Class_1_FinalApproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .remove-border {
            border: none !important; /* This will ensure the border is removed */
            /* Add any other necessary styling */
        }

        .white-background-readonly {
            background-color: white !important;
            color: black !important;
            cursor: default;
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
            /*width: 50px;*/
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


        window.onload = function () {
            // Disable  RadioButtonLists
            disableRadioButtonLists();

            // Toggle remarks divs based on the selected value for each RadioButtonList
            toggleAllRadioDivs();

            //Toggle remarks div based on selected as other for color ddl
            toggleColorDdlDiv();

            // Check and toggle textboxes based on the value range
            toggleAllRemarksTextboxVisibility()
        };

        function disableRadioButtonLists() {
            // Get all RadioButtonLists by their class
            var radioButtonLists = document.querySelectorAll('.form-control');

            radioButtonLists.forEach(function (rbl) {
                var radioItems = rbl.getElementsByTagName('input');
                for (var i = 0; i < radioItems.length; i++) {
                    radioItems[i].disabled = true; // Disable interaction
                }
            });
        }

        function toggleAllRadioDivs() {
            // Define a mapping of RadioButtonLists and their respective remarks divs
            var mapping = {
            '<%= RBL_Smell.ClientID %>': 'SmellRemarksDiv',
            '<%= RBL_TasteFlavor.ClientID %>': 'TasteFlavorRemarksDiv',
            '<%= RBL_Appearance.ClientID %>': 'AppearanceRemarksDiv',
            };

            // Loop through each mapping and toggle the div visibility based on the selected value
            for (var rblId in mapping) {
                var remarksDivId = mapping[rblId];
                toggleRadioRemarksDiv(rblId, remarksDivId);
            }
        }

        function toggleRadioRemarksDiv(rblId, remarksDivId) {
            var rbl = document.getElementById(rblId);

            if (rbl) {
                // Get the selected value from the RadioButtonList
                var selectedValue = rbl.querySelector('input[type="radio"]:checked').value;

                var remarksDiv = document.getElementById(remarksDivId);

                // If "Not Ok" (Value = "0") is selected, show the remarks div, otherwise hide it
                if (selectedValue === "0") {
                    remarksDiv.style.display = "block";
                } else {
                    remarksDiv.style.display = "none";
                }


            }
        }

        function toggleColorDdlDiv() {
            var ddlColorClientId = '<%= DDL_Color.ClientID %>';
            var remarksDivClientId = '<%= ColorRemarksDiv.ClientID %>'; // Use ClientID for remarks div
            console.log("Dropdown ClientID:", ddlColorClientId);  // Debugging: Print the ClientID
            console.log("Remarks Div ClientID:", remarksDivClientId);  // Debugging: Print remarks div ID

            var mapping = {};
            mapping[ddlColorClientId] = remarksDivClientId;

            for (var ddlId in mapping) {
                var remarksDivId = mapping[ddlId];
                toggleDDLRemarksDiv(ddlId, remarksDivId);
            }
        }

        function toggleDDLRemarksDiv(ddlId, remarksDivId) {
            var ddl = document.getElementById(ddlId);
            if (ddl) {
                var selectedValue = ddl.value;
                console.log("Selected Value:", selectedValue);  // Debugging: Print the selected value
                var remarksDiv = document.getElementById(remarksDivId);

                if (remarksDiv) {
                    remarksDiv.style.display = selectedValue.trim().toLowerCase() === "other" ? "block" : "none";
                    console.log("RemarksDiv Display:", remarksDiv.style.display);  // Debugging: Check if display is set
                } else {
                    console.log("RemarksDiv not found:", remarksDivId);  // Debugging: If RemarksDiv not found
                }
            } else {
                console.log("Dropdown not found:", ddlId);  // Debugging: If dropdown not found
            }
        }



        function toggleAllRemarksTextboxVisibility() {
            // Array of textboxes, remarks divs, and hidden fields for min/max values
            var textboxMappings = [
                { textboxId: '<%= TB_Quantity.ClientID %>', remarksDivId: 'QuantityRemarksDIV', errorMsgId: '<%= CV_TB_Quantity %>', minFieldId: '<%= hdnMinQtyValue.ClientID %>', maxFieldId: '<%= hdnMaxQtyValue.ClientID %>' },

                { textboxId: '<%= TB_PH.ClientID %>', remarksDivId: 'PHRemarksDIV', errorMsgId: '<%= CV_TB_PH %>', minFieldId: '<%= hdnMinPhValue.ClientID %>', maxFieldId: '<%= hdnMaxPhValue.ClientID %>' },

                { textboxId: '<%= TB_Moisture.ClientID %>', remarksDivId: 'MoistureRemarksDIV', errorMsgId: '<%= CV_TB_Moisture %>', minFieldId: '<%= hdnMinMoistureValue.ClientID %>', maxFieldId: '<%= hdnMaxMoistureValue.ClientID %>' },

                { textboxId: '<%= TB_TotalAsh.ClientID %>', remarksDivId: 'AshRemarksDIV', errorMsgId: '<%= CV_TB_TotalAsh %>', minFieldId: '<%= hdnMinTotalAshValue.ClientID %>', maxFieldId: '<%= hdnMaxTotalAshValue.ClientID %>' },

                { textboxId: '<%= TB_InsolubleAsh.ClientID %>', remarksDivId: 'InsolubleAshRemarksDIV', errorMsgId: '<%= CV_TB_InsolubleAsh %>', minFieldId: '<%= hdnMinInsolubleAshValue.ClientID %>', maxFieldId: '<%= hdnMaxInsolubleAshValue.ClientID %>' },

                { textboxId: '<%= TB_Density.ClientID %>', remarksDivId: 'DensityRemarksDIV', errorMsgId: '<%= CV_TB_Density %>', minFieldId: '<%= hdnMinDensityValue.ClientID %>', maxFieldId: '<%= hdnMaxDensityValue.ClientID %>' },

                { textboxId: '<%= TB_FatContent.ClientID %>', remarksDivId: 'FatContentRemarksDIV', errorMsgId: '<%= CV_TB_FatContent %>', minFieldId: '<%= hdnMinFatValue.ClientID %>', maxFieldId: '<%= hdnMaxFatValue.ClientID %>' },

                { textboxId: '<%= TB_TotalSolid.ClientID %>', remarksDivId: 'SolidRemarksDIV', errorMsgId: '<%= CV_TB_TotalSolid %>', minFieldId: '<%= hdnMinTotalSolidValue.ClientID %>', maxFieldId: '<%= hdnMaxTotalSolidValue.ClientID %>' },

                { textboxId: '<%= TB_ReducingSugar.ClientID %>', remarksDivId: 'SugarRemarksDIV', errorMsgId: '<%= CV_TB_ReducingSugar %>', minFieldId: '<%= hdnMinSugarValue.ClientID %>', maxFieldId: '<%= hdnMaxSugarValue.ClientID %>' },

                { textboxId: '<%= TB_DrainableSyrup.ClientID %>', remarksDivId: 'SyrupRemarksDIV', errorMsgId: '<%= CV_TB_DrainableSyrup %>', minFieldId: '<%= hdnMinSyrupValue.ClientID %>', maxFieldId: '<%= hdnMaxSyrupValue.ClientID %>' },

                { textboxId: '<%= TB_Matured_Immatured_Seeds.ClientID %>', remarksDivId: 'SeedsRemarksDIV', errorMsgId: '<%= CV_TB_Matured_Immatured_Seeds %>', minFieldId: '<%= hdnMinSeedValue.ClientID %>', maxFieldId: '<%= hdnMaxSeedValue.ClientID %>' },

                { textboxId: '<%= TB_Brix.ClientID %>', remarksDivId: 'BrixRemarksDIV', errorMsgId: '<%= CV_TB_Brix %>', minFieldId: '<%= hdnMinBrixValue.ClientID %>', maxFieldId: '<%= hdnMaxBrixValue.ClientID %>' },

                { textboxId: '<%= TB_ShapeOrSize.ClientID %>', remarksDivId: 'ShapeOrSizeRemarksDIV', errorMsgId: '<%= CV_TB_ShapeOrSize %>', minFieldId: '<%= hdnMinShapeSizeValue.ClientID %>', maxFieldId: '<%= hdnMaxShapeSizeValue.ClientID %>' },

                { textboxId: '<%= TB_TS.ClientID %>', remarksDivId: 'TSRemarksDIV', errorMsgId: '<%= CV_TB_TS %>', minFieldId: '<%= hdnMinTSValue.ClientID %>', maxFieldId: '<%= hdnMaxTSValue.ClientID %>' },

            ];
            // Loop through each mapping and check the value range
            textboxMappings.forEach(function (mapping) {
                var textbox = document.getElementById(mapping.textboxId);
                var remarksDiv = document.getElementById(mapping.remarksDivId);
                var errorMsg = document.getElementById(mapping.errorMsgId);

                // Get the hidden field values (min/max)
                var minValue = parseFloat(document.getElementById(mapping.minFieldId).value);
                var maxValue = parseFloat(document.getElementById(mapping.maxFieldId).value);

                var value = parseFloat(textbox.value); // Get the value of the textbox

                // Toggle visibility based on the value range (comparing to hidden min/max values)
                if (value < minValue || value > maxValue) {
                    remarksDiv.style.display = "block"; // Show remarks div

                    // You can also fetch the error message from the backend if needed
                    errorMsg.innerHTML = `Value must be between ${minValue} and ${maxValue}.`; // Set the error message
                    errorMsg.style.display = "inline"; // Show error message
                } else {
                    remarksDiv.style.display = "none"; // Hide remarks div
                    errorMsg.style.display = "none";   // Hide error message
                }

            });
        }


    </script>

    <asp:HiddenField ID="hdnMinQtyValue" runat="server" />
    <asp:HiddenField ID="hdnMaxQtyValue" runat="server" />

    <asp:HiddenField ID="hdnMinPhValue" runat="server" />
    <asp:HiddenField ID="hdnMaxPhValue" runat="server" />

    <asp:HiddenField ID="hdnMinMoistureValue" runat="server" />
    <asp:HiddenField ID="hdnMaxMoistureValue" runat="server" />

    <asp:HiddenField ID="hdnMinTotalAshValue" runat="server" />
    <asp:HiddenField ID="hdnMaxTotalAshValue" runat="server" />

    <asp:HiddenField ID="hdnMinInsolubleAshValue" runat="server" />
    <asp:HiddenField ID="hdnMaxInsolubleAshValue" runat="server" />

    <asp:HiddenField ID="hdnMinDensityValue" runat="server" />
    <asp:HiddenField ID="hdnMaxDensityValue" runat="server" />

    <asp:HiddenField ID="hdnMinFatValue" runat="server" />
    <asp:HiddenField ID="hdnMaxFatValue" runat="server" />

    <asp:HiddenField ID="hdnMinTotalSolidValue" runat="server" />
    <asp:HiddenField ID="hdnMaxTotalSolidValue" runat="server" />

    <asp:HiddenField ID="hdnMinSyrupValue" runat="server" />
    <asp:HiddenField ID="hdnMaxSyrupValue" runat="server" />

    <asp:HiddenField ID="hdnMinSugarValue" runat="server" />
    <asp:HiddenField ID="hdnMaxSugarValue" runat="server" />

    <asp:HiddenField ID="hdnMinSeedValue" runat="server" />
    <asp:HiddenField ID="hdnMaxSeedValue" runat="server" />

    <asp:HiddenField ID="hdnMinBrixValue" runat="server" />
    <asp:HiddenField ID="hdnMaxBrixValue" runat="server" />

    <asp:HiddenField ID="hdnMinShapeSizeValue" runat="server" />
    <asp:HiddenField ID="hdnMaxShapeSizeValue" runat="server" />

    <asp:HiddenField ID="hdnMinTSValue" runat="server" />
    <asp:HiddenField ID="hdnMaxTSValue" runat="server" />


    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>
                        <asp:Label ID="lbl_docname" runat="server" Text="Detailed View"></asp:Label>
                    </h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docnumber" runat="server" Text="Detailed View"></asp:Label>
                            </h2>
                            <div class="clearfix"></div>
                        </div>

                        <%--form start--%>
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="x-content">

                                                    <div class="col-md-3" id="PlantDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_DDL_Plant" runat="server" AssociatedControlID="DDL_Plant" Text="Plant Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:DropDownList ID="DDL_Plant" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="MaterialDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_DDL_Material" runat="server" AssociatedControlID="DDL_Material" Text="Material Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:DropDownList ID="DDL_Material" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="CategoryDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_DDL_ProductCategory" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:DropDownList ID="DDL_ProductCategory" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="BrandDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_DDL_ProductBrand" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:DropDownList ID="DDL_ProductBrand" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SupplierDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_Supplier" runat="server" AssociatedControlID="TB_Supplier" Text="Supplier :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_Supplier" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Supplier_Name") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="ChallanNoDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_ChallanNo" runat="server" AssociatedControlID="TB_ChallanNo" Text="Challan No. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_ChallanNo" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Challan_No") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="ChallanDateDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_ChallanDate" runat="server" AssociatedControlID="TB_ChallanDate" Text="Challan Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_ChallanDate" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Challan_Date","{0:d d-MM-yyyy}") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="QuantityDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_Quantity" runat="server" AssociatedControlID="TB_Quantity" Text="Quantity :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_Quantity" runat="server" ErrorMessage="Input Range [1000.00-2000.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_Quantity" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly " Text='<%#  Eval("Quantity") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="QuantityRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_TXB_Quantity_Remarks" runat="server" AssociatedControlID="TXB_Quantity_Remarks" Text="Quantity Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Quantity_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForQuantity") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="LotNoDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_LotNo" runat="server" AssociatedControlID="TB_LotNo" Text="Lot/Gate No. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_LotNo" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Lot_No") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="VehicleNoDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_VehicleNo" runat="server" AssociatedControlID="TB_VehicleNo" Text="Vehicle No. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_VehicleNo" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Vehicle_No") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="ColorDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="LabelColor" runat="server" AssociatedControlID="DDL_Color" Text=" Color  :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:DropDownList ID="DDL_Color" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="ColorRemarksDiv" runat="server" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="LabelColorRemarksDiv" runat="server" AssociatedControlID="TXB_Color_Remarks" Text="Color (Others)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Color_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForColor") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SmellDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="LabelSmell" runat="server" AssociatedControlID="RBL_Smell" Text="Smell :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:RadioButtonList ID="RBL_Smell" runat="server" CssClass="form-control form-control-sm rounded remove-border white-background-readonly" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%">
                                                                    <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SmellRemarksDiv" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="LabelSmellRemarks" runat="server" AssociatedControlID="TXB_Smell_Remarks" Text="Smell (Not Ok)" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Smell_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded remove-border white-background-readonly" Text='<%#  Eval("CommentsForSmell") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="AppearanceDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="LabelAppearance" runat="server" AssociatedControlID="RBL_Appearance" Text="Appearance :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:RadioButtonList ID="RBL_Appearance" runat="server" CssClass="form-control form-control-sm rounded remove-border white-background-readonly" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%">
                                                                    <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="AppearanceRemarksDiv" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="LabelAppearancepRemarks" runat="server" AssociatedControlID="TXB_Appearance_Remarks" Text=" Appearance (Not Ok)" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Appearance_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded remove-border white-background-readonly" Text='<%#  Eval("CommentsForAppearance") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="TasteFlavorDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="LabelTasteFlavor" runat="server" AssociatedControlID="RBL_TasteFlavor" Text="Taste/Flavor :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:RadioButtonList ID="RBL_TasteFlavor" runat="server" CssClass="form-control form-control-sm rounded remove-border white-background-readonly" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%">
                                                                    <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="TasteFlavorRemarksDiv" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="LabelTasteFlavorRemarks" runat="server" AssociatedControlID="TXB_TasteFlavor_Remarks" Text=" Taste/Flavor  (Not Ok)" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_TasteFlavor_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm  rounded white-background-readonly" Text='<%#  Eval("CommentsForTaste") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="ImpuritiesDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_Foreign_Impurities" runat="server" AssociatedControlID="TB_Foreign_Impurities" Text="ForeignMatter/Impurities :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_Foreign_Impurities" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Foreign_Matter_Impurities") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="PHDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_PH" runat="server" AssociatedControlID="TB_PH" Text=" PH Value :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_PH" runat="server" ErrorMessage="Input Range [20.00-30.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_PH" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("PH") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="PHRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TXB_PH_Remarks" runat="server" AssociatedControlID="TXB_PH_Remarks" Text="PH Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_PH_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForPH") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="MoistureDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_Moisture" runat="server" AssociatedControlID="TB_Moisture" Text="Moisture (%)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_Moisture" runat="server" ErrorMessage="Input Range [20.00-30.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_Moisture" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Moisture") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="MoistureRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TXB_Moisture_Remarks" runat="server" AssociatedControlID="TXB_Moisture_Remarks" Text="Moisture Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Moisture_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForMoisture") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="AshDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_TotalAsh" runat="server" AssociatedControlID="TB_TotalAsh" Text="Total Ash" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_TotalAsh" runat="server" ErrorMessage="Input Range [20.00-30.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_TotalAsh" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Total_Ash") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="AshRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TXB_Ash_Remarks" runat="server" AssociatedControlID="TXB_Ash_Remarks" Text="Total Ash Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Ash_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForTotalAsh") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="InsolubleAshDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_InsolubleAsh" runat="server" AssociatedControlID="TB_InsolubleAsh" Text="Insoluble Ash" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_InsolubleAsh" runat="server" ErrorMessage="Input Range [20.00-30.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_InsolubleAsh" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Acid_Insoluble_Ash") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="InsolubleAshRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_TXB_InsolubleAsh_Remarks" runat="server" AssociatedControlID="TXB_InsolubleAsh_Remarks" Text="Insoluble Ash Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_InsolubleAsh_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForInsolubleAsh") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="DensityDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_Density" runat="server" AssociatedControlID="TB_Density" Text=" Density Value :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_Density" runat="server" ErrorMessage="Input Range [20.00-30.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_Density" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Density") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="DensityRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_TXB_Density_Remarks" runat="server" AssociatedControlID="TXB_Density_Remarks" Text="Density Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Density_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForDensity") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="FatContentDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_FatContent" runat="server" AssociatedControlID="TB_FatContent" Text="Fat Content" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_FatContent" runat="server" ErrorMessage="Input Range [20.00-30.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_FatContent" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Fat_Content") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="FatContentRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_TXB_Fat_Remarks" runat="server" AssociatedControlID="TXB_Fat_Remarks" Text="Fat Content Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Fat_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForFatContent") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SolidDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_TotalSolid" runat="server" AssociatedControlID="TB_TotalSolid" Text="Total Solids" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_TotalSolid" runat="server" ErrorMessage="Input Range [20.00-30.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_TotalSolid" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Total_Solids") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SolidRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_TXB_Solid_Remarks" runat="server" AssociatedControlID="TXB_Solid_Remarks" Text="Total Solids Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Solid_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForSolid") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SugarDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_ReducingSugar" runat="server" AssociatedControlID="TB_ReducingSugar" Text="Reducing Sugar As Maltose" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_ReducingSugar" runat="server" ErrorMessage="Input Range [20.00-30.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_ReducingSugar" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Reducing_Sugar") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SugarRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_TXB_Sugar_Remarks" runat="server" AssociatedControlID="TXB_Sugar_Remarks" Text="Reducing Sugar Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Sugar_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForSugar") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SyrupDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_DrainableSyrup" runat="server" AssociatedControlID="TB_DrainableSyrup" Text=" Drainable Syrup " ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_DrainableSyrup" runat="server" ErrorMessage="Input Range [20.00-30.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_DrainableSyrup" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Drainable_Syrup") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SyrupRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_TXB_Syrup_Remarks" runat="server" AssociatedControlID="TXB_Syrup_Remarks" Text="Drainable Syrup Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Syrup_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForSyrup") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SeedsDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_Matured_Immatured_Seeds" runat="server" AssociatedControlID="TB_Matured_Immatured_Seeds" Text="No. Of Matured Immatured Seeds" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_Matured_Immatured_Seeds" runat="server" ErrorMessage="Input Range [2 -4]kg" Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_Matured_Immatured_Seeds" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Matured_Immatured_seeds") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SeedsRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="LabelTXB_Seeds_Remarks" runat="server" AssociatedControlID="TXB_Seeds_Remarks" Text="No. Of Matured Immatured Seeds Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Seeds_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForSeed") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="BrixDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_Brix" runat="server" AssociatedControlID="TB_Brix" Text="Brix" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_Brix" runat="server" ErrorMessage="Input Range [20.00-30.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_Brix" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("Brix") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="BrixRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_TXB_Brix_Remarks" runat="server" AssociatedControlID="TXB_Brix_Remarks" Text="Brix Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_Brix_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForBrix") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="ShapeOrSizeDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_ShapeOrSize" runat="server" AssociatedControlID="TB_ShapeOrSize" Text="ShapeOrSize  :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_ShapeOrSize" runat="server" ErrorMessage="Input Range [2.00-3.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_ShapeOrSize" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("ShapeOrSize") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="ShapeOrSizeRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_TXB_ShapeOrSize_Remarks" runat="server" AssociatedControlID="TXB_ShapeOrSize_Remarks" Text="ShapeOrSize Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_ShapeOrSize_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForShapeOrSize") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="TSDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_TS" runat="server" AssociatedControlID="TB_TS" Text="TS" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <asp:CustomValidator ID="CV_TB_TS" runat="server" ErrorMessage="Input Range [20.00-30.00]." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_TS" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("TS") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="TSRemarksDIV" style="display: none;">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Label_TXB_TS_Remarks" runat="server" AssociatedControlID="TXB_TS_Remarks" Text="TS Remarks" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TXB_TS_Remarks" runat="server" ReadOnly="true" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("CommentsForTS") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <%--Image part--%>

                                                    <div class="col-md-3" id="FU_MaterialImage_img" runat="server">
                                                        <asp:Label ID="LblMaterialImg" runat="server" Text="Material Image" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                        <asp:Image ID="imgMaterial" runat="server" ImageUrl='<%# Eval("Material_Image") != null ? ResolveUrl(Eval("Material_Image").ToString()) : "~/Images/placeholder.jpg" %>' AlternateText="Material Image" Width="100px" Height="100px" />
                                                    </div>


                                                </div>

                                                <%--Button--%>
                                                <div class="col-md-3">
                                                    <div class="mb-3">
                                                        <asp:Label ID="LblBtn" runat="server" AssociatedControlID="" Text="Click on your ACTION" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                        <div class="input-group input-group-sm">
                                                            <asp:Button ID="BtnValidate" runat="server" Text="Re-Validate inputs" CssClass="btn btn-warning btn-sm" ValidationGroup="" CausesValidation="true" />
                                                            <asp:Button ID="BtnApprove" runat="server" Text="Approve" CssClass="btn btn-success btn-sm" CausesValidation="false" OnClick="BtnApprove_Click" />
                                                            <asp:Button ID="BtnReject" runat="server" Text="Reject" CssClass="btn btn-sm btn-danger" CausesValidation="false" OnClick="BtnReject_Click" />
                                                            <asp:Button ID="BtnBack" runat="server" Text="Back" CssClass="btn btn-sm btn-info" CausesValidation="false" PostBackUrl="~/RM_Class_1_Approval.aspx" />
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- form end--%>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="Label8" runat="server" Text="Approval Matrix"></asp:Label>
                            </h2>
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
                                        <asp:Label ID="Label7" runat="server" Text="Approver 2" />
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
