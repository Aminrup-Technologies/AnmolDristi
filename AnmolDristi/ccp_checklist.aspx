<%@ Page Title="AIL | CCP Checklist" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="ccp_checklist.aspx.cs" Inherits="AnmolDristi.ccp_checklist" %>

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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">

        function GridtoggleCleanedStatusRemarks(radioButtonList) {
            console.log("GridtoggleCleanedStatusRemarks function called");

            // Check the type of radioButtonList
            console.log("radioButtonList:", radioButtonList);

            var rbtnvalue = radioButtonList.querySelector("input:checked").value;
            // Check if the value is being accessed correctly
            console.log("Value of radioButtonList:", rbtnvalue);

            // Get the row containing the radio button list
            var row = radioButtonList.closest('tr');
            console.log("Row element:", row);

            // Ensure the row is found
            if (row) {
                // Find the remarks textbox within the same row using class
                var remarksTextBox = row.querySelector('.TXB_CleanedStatusRemarks');
                console.log("Remarks TextBox element:", remarksTextBox);

                if (remarksTextBox) {
                    // Toggle visibility based on the value
                    if (rbtnvalue == "0") {
                        console.log("Displaying the remarks TextBox");
                        remarksTextBox.style.display = 'block';
                    } else {
                        console.log("Hiding the remarks TextBox");
                        remarksTextBox.style.display = 'none';
                    }
                } else {
                    console.log("Remarks TextBox not found within the row");
                }
            } else {
                console.log("Row element not found");
            }
        }



        function toggleFFRemarks(radioButtonList) {
            console.log("toggleFFRemarks function called");

            // Get the selected value from the RadioButtonList
            var selectedValue = radioButtonList.querySelector("input:checked").value;

            // Get the remarks DIV and validator elements
            var remarksDiv = document.getElementById("FF_RemarksDIV");
            var remarksValidator = document.getElementById('<%= RFV_FF_Remarks.ClientID %>');

            console.log("Selected value: " + selectedValue);

            // Show the remarks textbox and validator if "Not Sensing" is selected, otherwise hide them
            if (selectedValue === "NotSensing") {
                remarksDiv.style.display = "block";
                remarksValidator.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
                remarksValidator.style.display = "none";
            }
        }
        function toggleNFERemarks(radioButtonList) {
            console.log("toggleNFERemarks function called");

            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("NFE_RemarksDIV");
            var remarksValidator = document.getElementById('<%= RFV_NFE_Remarks.ClientID %>');

            console.log("Selected value: " + selectedValue);

            if (selectedValue === "NotSensing") {
                remarksDiv.style.display = "block";
                remarksValidator.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
                remarksValidator.style.display = "none";
            }
        }

        function toggleSSRemarks(radioButtonList) {
            console.log("toggleSSRemarks function called");

            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("SS_RemarksDIV");
            var remarksValidator = document.getElementById('<%= RFV_SS_Remarks.ClientID %>');

            console.log("Selected value: " + selectedValue);

            if (selectedValue === "NotSensing") {
                remarksDiv.style.display = "block";
                remarksValidator.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
                remarksValidator.style.display = "none";
            }
        }

        function toggleCleanedStatusRemarks(radioButtonList) {
            console.log("toggleCleanedStatusRemarks function called");

            // Find the selected value in the RadioButtonList
            var selectedValue = radioButtonList.querySelector("input:checked").value;

            // Locate the closest GridView row (tr)
            var gridViewRow = radioButtonList.closest("tr");

            // Find the Remarks TextBox and Validator within the same row
            var remarksTextBox = gridViewRow.querySelector("input[id$='TXB_CleanedStatusRemarks']");
            var remarksValidator = gridViewRow.querySelector("span[id$='RFV_CleanedStatusRemarks']");

            console.log("Selected value: " + selectedValue);

            if (selectedValue === "0") { // If "Not Ok" is selected
                remarksTextBox.style.display = "block";
                if (remarksValidator) {
                    remarksValidator.style.display = "block";
                }
            } else { // If "Ok" is selected
                remarksTextBox.style.display = "none";
                if (remarksValidator) {
                    remarksValidator.style.display = "none";
                }
            }
        }


    </script>



    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title custom-page-title">
                <div class="title_left">
                    <h3>
                        <asp:Label ID="lbl_docname" runat="server" Text="Label"></asp:Label></h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docnumber" runat="server" Text="Label"></asp:Label></h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-12">
                                                <ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
                                                    <li class="nav-item">
                                                        <a class="nav-link active text-info" id="basicData-tab" data-toggle="tab" href="#basicData" role="tab"
                                                            aria-controls="basicData" aria-selected="true"><%--<i class="fa fa-id-badge mr-2"></i>--%>Plant & Line</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link text-info" id="Metal_Check-tab" data-toggle="tab" href="#Metal_Check" role="tab"
                                                            aria-controls="Metal_Check" aria-selected="false">
                                                            <%-- <i class="fa fa-clock-o mr-2"></i>--%>Magnet Check</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link text-info" id="Standard_Sieve-tab" data-toggle="tab" href="#Standard_Sieve" role="tab"
                                                            aria-controls="Standard_Sieve" aria-selected="false">
                                                            <%-- <i class="fa fa-clock-o mr-2"></i>--%>Sieve Condition</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link text-info" id="Metal_Dctector_Area-tab" data-toggle="tab" href="#Metal_Dctector_Area" role="tab"
                                                            aria-controls="Metal_Dctector_Area" aria-selected="false">
                                                            <%-- <i class="fa fa-clock-o mr-2"></i>--%>Metal Dctector</a>
                                                    </li>
                                                </ul>
                                                <div class="tab-content ml-1" id="myTabContent">
                                                    <%---Basic User Info Starts--%>
                                                    <div class="tab-pane fade show active" id="basicData" role="tabpanel" aria-labelledby="basicData-tab">
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
                                                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="DDL_PlantLine" Text="Select Line" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_PlantLine" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_PlantLine" Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_PlantLine" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_PlantLine_SelectedIndexChanged"></asp:DropDownList>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label3" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductCategory" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" InitialValue="" ControlToValidate="DDL_ProductCategory" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductCategory_SelectedIndexChanged"></asp:DropDownList>

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
                                                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="DDL_BrandSKU" Text="Brand SKU Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_BrandSKU" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_BrandSKU" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_BrandSKU" runat="server" CssClass="form-control form-control-sm rounded"></asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- Basic Data Save and ReSet Button-->
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_basic_btnSave" runat="server" AssociatedControlID="btnBDSave" Text="Click to Save" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group input-group-sm">
                                                                        <asp:Button ID="btnBDSave" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="false" OnClick="btnBDSave_Click" />
                                                                        <asp:Button ID="btnBDReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="btnBDReset_Click" />
                                                                    </div>
                                                                    <div class="mt-3">
                                                                        <!-- Add this label to display messages -->
                                                                        <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                        </div>
                                                    </div>


                                                    <!--Metal_Check -->
                                                    <%-- <div class="tab-pane fade" id="Metal_Check" role="tabpanel" aria-labelledby="Metal_Check-tab">
                                                        <div class="x_content">
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label10" runat="server" AssociatedControlID="DDL_LineNo" Text="Line Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_LineNo" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_LineNo_SelectedIndexChanged"></asp:DropDownList>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_QtyMetalFound" runat="server" AssociatedControlID="TB_QtyMetalFound" Text="Qty of Metal Found (gm):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_QtyMetalFound" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_QtyMetalFound" Display="Dynamic" ForeColor="Red" InitialValue=""></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_QtyMetalFound" runat="server" ValidationGroup="Submit" ControlToValidate="TB_QtyMetalFound" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <asp:CustomValidator ID="CV_TB_QtyMetalFound" runat="server" ErrorMessage="*" Display="Dynamic" ValidationGroup="Submit" ForeColor="Red"></asp:CustomValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_QtyMetalFound" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Qty of Metal Found (gm)"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label11" runat="server" AssociatedControlID="RBL_CleanedStatus" Text="Cleaned Status :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_RBL_CleanedStatus" runat="server" ValidationGroup="Submit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_CleanedStatus" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_CleanedStatus" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleCleanedStatusRemarks(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="FlavTxt_RemarksDIV" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label12" runat="server" AssociatedControlID="TXB_RBL_CleanedStatus_Rmrks" Text="Cleaned Status (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_RBL_CleanedStatus_Rmrks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_RBL_CleanedStatus_Rmrks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_RBL_CleanedStatus_Rmrks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>--%>





                                                    <%--<div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label9" runat="server" Text="Shift" ForeColor="Blue" Font-Bold="true" Font-Size="Small" AssociatedControlID="DDL_Shift"></asp:Label>
                                                                    <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-control form-control-sm rounded">
                                                                        <asp:ListItem Value="" Text="-- Select Shift --" />
                                                                        <asp:ListItem Value="ShiftA" Text="Shift A" />
                                                                        <asp:ListItem Value="ShiftB" Text="Shift B" />
                                                                        <asp:ListItem Value="ShiftC" Text="Shift C" />
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DDL_Shift" InitialValue="" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>--%>
                                                    <div class="tab-pane fade" id="Metal_Check" role="tabpanel" aria-labelledby="Metal_Check-tab">
                                                        <div class="x_content">
                                                            <asp:GridView ID="GridView_MetalCheck" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sl">
                                                                        <ItemTemplate>
                                                                            <%# Container.DataItemIndex + 1 %>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Location">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lbl_Location" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Qty of Metal Found (gm)">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="TB_QtyMetalFound" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Cleaned Status">
                                                                        <ItemTemplate>
                                                                            <asp:RadioButtonList ID="RBL_CleanedStatus" runat="server" RepeatDirection="Horizontal" onchange="GridtoggleCleanedStatusRemarks(this);">
                                                                                <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                                <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                            </asp:RadioButtonList>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Remarks">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="TXB_CleanedStatusRemarks" runat="server" CssClass="form-control form-control-sm rounded TXB_CleanedStatusRemarks" Placeholder="Remarks" Style="display: none;"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Save" CssClass="btn btn-primary" CausesValidation="false" OnClick="btnSubmit_Click" />
                                                        </div>
                                                    </div>



                                                    <!-- STANDARD SIEVE-->
                                                    <div class="tab-pane fade" id="Standard_Sieve" role="tabpanel" aria-labelledby="Standard_Sieve-tab">
                                                        <div class="x_content">
                                                            <div class="row">

                                                                <!-- SIEVE NO. -->
                                                                <div class="col-md-3">
                                                                    <div class="mb-3">
                                                                        <asp:Label ID="Label_SieveNo" runat="server" Text="Sieve No." ForeColor="Blue" Font-Bold="true" Font-Size="Small" AssociatedControlID="DDL_SieveNo"></asp:Label>
                                                                        <asp:DropDownList ID="DDL_SieveNo" runat="server" CssClass="form-control form-control-sm rounded">
                                                                            <asp:ListItem Value="" Text="-- Select Sieve No. --" />

                                                                        </asp:DropDownList>
                                                                        <asp:RequiredFieldValidator ID="RFV_DDL_SieveNo" runat="server" ControlToValidate="DDL_SieveNo" InitialValue="" ErrorMessage="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    </div>
                                                                </div>

                                                                <!-- INITIAL SIEVE SAMPLE Wt./gm -->

                                                                <div class="col-md-3">
                                                                    <div class="mb-3">
                                                                        <asp:Label ID="Label_InitialSieveSampleWt" runat="server" Text="Initial Sieve Sample Wt.(gm)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                        <asp:RequiredFieldValidator ID="RFV_InitialSieveSampleWt" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_InitialSieveSampleWt" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                        <div class="input-group-sm">
                                                                            <asp:TextBox ID="TB_InitialSieveSampleWt" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                        </div>
                                                                        <asp:Label ID="Label_Remarks_InitialSieveSampleWt" runat="server" Text="Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                        <div class="input-group-sm">
                                                                            <asp:TextBox ID="TB_Remarks_InitialSieveSampleWt" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- FINAL SIEVE RETENTION Wt./gm -->
                                                                <div class="col-md-3">
                                                                    <div class="mb-3">
                                                                        <asp:Label ID="Label_FinalSieveRetentionWt" runat="server" Text="Final Sieve Retention Wt.(gm)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                        <asp:RequiredFieldValidator ID="RFV_FinalSieveRetentionWt" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_FinalSieveRetentionWt" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                        <div class="input-group-sm">
                                                                            <asp:TextBox ID="TB_FinalSieveRetentionWt" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                        </div>
                                                                        <asp:Label ID="Label_Remarks_FinalSieveRetentionWt" runat="server" Text="Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                        <div class="input-group-sm">
                                                                            <asp:TextBox ID="TB_Remarks_FinalSieveRetentionWt" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- PERCENTAGE OF SIEVE RETENTION -->
                                                                <div class="col-md-3">
                                                                    <div class="mb-3">
                                                                        <asp:Label ID="Label_PercentageOfSieveRetention" runat="server" Text="Percentage of Sieve Retention" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                        <asp:RequiredFieldValidator ID="RFV_PercentageOfSieveRetention" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_PercentageOfSieveRetention" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                        <div class="input-group-sm">
                                                                            <asp:TextBox ID="TB_PercentageOfSieveRetention" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                        </div>
                                                                        <asp:Label ID="Label_Remarks_PercentageOfSieveRetention" runat="server" Text="Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                        <div class="input-group-sm">
                                                                            <asp:TextBox ID="TB_Remarks_PercentageOfSieveRetention" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-3">
                                                                    <div class="mb-3">
                                                                        <asp:Label ID="Label_SizeOfStandardSieve" runat="server" Text="Size of Standard Sieve (Micron)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                        <asp:RequiredFieldValidator ID="RFV_SizeOfStandardSieve" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_SizeOfStandardSieve" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                        <div class="input-group-sm">
                                                                            <asp:TextBox ID="TB_SizeOfStandardSieve" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- Checked By QA -->
                                                                <div class="col-md-3">
                                                                    <div class="mb-3">
                                                                        <asp:Label ID="Label_CheckedByQA" runat="server" Text="Checked By QA" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                        <asp:RequiredFieldValidator ID="RFV_CheckedByQA" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_CheckedByQA" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                        <div class="input-group-sm">
                                                                            <asp:TextBox ID="TB_CheckedByQA" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- Verify By -->
                                                                <div class="col-md-3">
                                                                    <div class="mb-3">
                                                                        <asp:Label ID="Label_VerifyBy" runat="server" Text="Verify By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                        <asp:RequiredFieldValidator ID="RFV_VerifyBy" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_VerifyBy" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                        <div class="input-group-sm">
                                                                            <asp:TextBox ID="TB_VerifyBy" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <!-- Remarks -->
                                                                <div class="col-md-3">
                                                                    <div class="mb-3">
                                                                        <asp:Label ID="Label_Remarks" runat="server" Text="Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                        <asp:RequiredFieldValidator ID="RFV_Remarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                        <div class="input-group-sm">
                                                                            <asp:TextBox ID="TB_Remarks" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="tab-pane fade" id="Metal_Dctector_Area" role="tabpanel" aria-labelledby="Metal_Dctector_Area-tab">
                                                        <div class="x_content">
                                                            <div class="row">
                                                                <div class="col-md-3 mb-3">
                                                                    <asp:Label ID="Label_MetalDetectorArea" runat="server" AssociatedControlID="DDL_MetalDetectorArea" Text="Metal Detector Area:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:DropDownList ID="DDL_MetalDetectorArea" runat="server" CssClass="form-control form-control-sm rounded ">
                                                                        <%--<asp:ListItem Text="Packing 1" Value="Packing1"></asp:ListItem>
                                                                        <asp:ListItem Text="Packing 2" Value="Packing2"></asp:ListItem>
                                                                        <asp:ListItem Text="Packing 3" Value="Packing3"></asp:ListItem>--%>
                                                                    </asp:DropDownList>
                                                                </div>

                                                                <!-- Status of Metal Detector -->
                                                                <!-- FF Status -->
                                                                <%--<d class="mb-3">
                                                                    <asp:Label ID="Label_FF_Status" runat="server" Text="FF:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_FF_Status" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" AutoPostBack="true" OnSelectedIndexChanged="RBL_FF_Status_SelectedIndexChanged">
                                                                            <asp:ListItem Text="Sensing" Value="Sensing"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Sensing" Value="NotSensing"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                        <asp:TextBox ID="TB_FF_Remarks" runat="server" CssClass="form-control form-control-sm rounded remove-border" Visible="false" />
                                                                    </div>
                                                                </div>--%>
                                                                <!-- FF Status Radio Button List -->
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label_FF_Status" runat="server" Text="FF:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_FF_Status" runat="server"
                                                                            CssClass="form-control form-control-sm rounded remove-border"
                                                                            RepeatLayout="Table"
                                                                            RepeatDirection="Horizontal"
                                                                            CellPadding="5"
                                                                            CellSpacing="5"
                                                                            RepeatColumns="2"
                                                                            Width="100%"
                                                                            onchange="toggleFFRemarks(this);">
                                                                            <asp:ListItem Text="Sensing" Value="Sensing"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Sensing" Value="NotSensing"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>

                                                                <!-- Remarks for Not Sensing -->
                                                                <div class="mb-3" id="FF_RemarksDIV" style="display: none;">
                                                                    <asp:Label ID="Label_FF_Remarks" runat="server"
                                                                        AssociatedControlID="TB_FF_Remarks"
                                                                        Text="FF Status (Not Sensing) Remarks:"
                                                                        ForeColor="Blue"
                                                                        Font-Bold="true"
                                                                        Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_FF_Remarks" runat="server"
                                                                        ErrorMessage="*"
                                                                        ForeColor="Red"
                                                                        ControlToValidate="TB_FF_Remarks"
                                                                        Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_FF_Remarks" runat="server"
                                                                            CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>


                                                                <%--<!-- NFE Status -->
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label_NFE_Status" runat="server" Text="NFE:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_NFE_Status" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" AutoPostBack="true" OnSelectedIndexChanged="RBL_NFE_Status_SelectedIndexChanged">
                                                                            <asp:ListItem Text="Sensing" Value="Sensing"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Sensing" Value="NotSensing"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                        <asp:TextBox ID="TB_NFE_Remarks" runat="server" CssClass="form-control form-control-sm rounded remove-border" Visible="false" />
                                                                    </div>
                                                                </div>

                                                                <!-- SS Status -->
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label_SS_Status" runat="server" Text="SS:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_SS_Status" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" AutoPostBack="true" OnSelectedIndexChanged="RBL_SS_Status_SelectedIndexChanged">
                                                                            <asp:ListItem Text="Sensing" Value="Sensing"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Sensing" Value="NotSensing"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                        <asp:TextBox ID="TB_SS_Remarks" runat="server" CssClass="form-control form-control-sm rounded remove-border" Visible="false" />
                                                                    </div>
                                                                </div>--%>
                                                                <!-- NFE Status -->
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label_NFE_Status" runat="server" Text="NFE:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_NFE_Status" runat="server"
                                                                            CssClass="form-control form-control-sm rounded remove-border"
                                                                            RepeatLayout="Table"
                                                                            RepeatDirection="Horizontal"
                                                                            CellPadding="5"
                                                                            CellSpacing="5"
                                                                            RepeatColumns="2"
                                                                            Width="100%"
                                                                            onchange="toggleNFERemarks(this);">
                                                                            <asp:ListItem Text="Sensing" Value="Sensing"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Sensing" Value="NotSensing"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>

                                                                <!-- Remarks for NFE Status -->
                                                                <div class="mb-3" id="NFE_RemarksDIV" style="display: none;">
                                                                    <asp:Label ID="Label_NFE_Remarks" runat="server"
                                                                        AssociatedControlID="TB_NFE_Remarks"
                                                                        Text="NFE Status (Not Sensing) Remarks:"
                                                                        ForeColor="Blue"
                                                                        Font-Bold="true"
                                                                        Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_NFE_Remarks" runat="server"
                                                                        ErrorMessage="*"
                                                                        ForeColor="Red"
                                                                        ControlToValidate="TB_NFE_Remarks"
                                                                        Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_NFE_Remarks" runat="server"
                                                                            CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>

                                                                <!-- SS Status -->
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label_SS_Status" runat="server" Text="SS:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_SS_Status" runat="server"
                                                                            CssClass="form-control form-control-sm rounded remove-border"
                                                                            RepeatLayout="Table"
                                                                            RepeatDirection="Horizontal"
                                                                            CellPadding="5"
                                                                            CellSpacing="5"
                                                                            RepeatColumns="2"
                                                                            Width="100%"
                                                                            onchange="toggleSSRemarks(this);">
                                                                            <asp:ListItem Text="Sensing" Value="Sensing"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Sensing" Value="NotSensing"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>

                                                                <!-- Remarks for SS Status -->
                                                                <div class="mb-3" id="SS_RemarksDIV" style="display: none;">
                                                                    <asp:Label ID="Label_SS_Remarks" runat="server"
                                                                        AssociatedControlID="TB_SS_Remarks"
                                                                        Text="SS Status (Not Sensing) Remarks:"
                                                                        ForeColor="Blue"
                                                                        Font-Bold="true"
                                                                        Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SS_Remarks" runat="server"
                                                                        ErrorMessage="*"
                                                                        ForeColor="Red"
                                                                        ControlToValidate="TB_SS_Remarks"
                                                                        Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SS_Remarks" runat="server"
                                                                            CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>

                                                                <!-- Remarks -->
                                                                <div class="col-md-3">
                                                                    <div class="mb-3">
                                                                        <asp:Label ID="Label8" runat="server" Text="Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                        <div class="input-group-sm">
                                                                            <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control form-control-sm rounded" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
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
                                <asp:Label ID="Label6" runat="server" Text="Approval Matrix"></asp:Label></h2>
                            <div class="clearfix"></div>

                        </div>
                        <div class="x_content">
                            <!-- Approver Flow Diagram -->
                            <div class="approver-flow">
                                <div class="approver-item">
                                    <p>
                                        <asp:Label ID="Label7" runat="server" Text="Approver 1" />
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
                                        <asp:Label ID="Label9" runat="server" Text="Approver 2" />
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
                                        <asp:Label ID="Label10" runat="server" Text="Approver 3" />
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
