<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="preDispatchVM.aspx.cs" Inherits="AnmolDristi.preDispatchVM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .remove-border {
            border: none !important; /* This will ensure the border is removed */
            /* Add any other necessary styling */
        }

        .table-responsive {
            overflow-x: auto; /* Allow horizontal scroll */
            white-space: nowrap; /* Prevent text wrapping */
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docnumber" runat="server" Text="Label"></asp:Label>
                            </h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">
                            <!-- Plant Name Filter -->
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="DDL_Plant" Text="Plant Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_Plant" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_Plant" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_Plant_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <!-- Line Filter -->
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="DDL_PlantLine" Text="Select Line" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_PlantLine" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_PlantLine" Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_PlantLine" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_PlantLine_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <!-- Product Category Filter -->
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label3" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductCategory" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" InitialValue="" ControlToValidate="DDL_ProductCategory" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductCategory_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <!-- Product Brand Filter -->
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductBrand" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_ProductBrand" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductBrand_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <!-- SKU Type Filter -->
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="DDL_BrandSKU" Text="Brand SKU Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_BrandSKU" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_BrandSKU" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_BrandSKU" runat="server" CssClass="form-control form-control-sm rounded"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <!-- Date From Filter -->
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lblPackageDate" runat="server" AssociatedControlID="TXT_PackageDateFrom" Text="Date From" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_PackageDateFrom" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TXT_PackageDateFrom" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TXT_PackageDateFrom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Select Packaging Date" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <!-- Date To Filter -->
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label6" runat="server" AssociatedControlID="TXT_PackageDateTo" Text="Date To" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_PackageDateTo" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TXT_PackageDateTo" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TXT_PackageDateTo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Select Packaging Date" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons" style="display: flex; justify-content: center; align-items: center; text-align: center;">
            <asp:Label ID="lblInstruction" runat="server" Text="Click SUBMIT to view data!!!" CssClass="clearfix" Style="padding-right: 5em" />
            <asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="Cancel_Click" />
            <asp:Button ID="Submit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" CausesValidation="false" OnClick="Submit_Click" />
            <asp:Button ID="Reset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="Reset_Click" />
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="label_lower" runat="server" Text="Filtered Data" Style="margin-right: 6px;"></asp:Label>
                                <asp:Button ID="ExportBtn" runat="server" Text="Export" CssClass="btn btn-info btn-sm" CausesValidation="false" />
                            </h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <!-- GridView for displaying filtered data -->
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sl">
                                        <ItemTemplate>
                                            <asp:Label ID="lblId" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# Eval("Id") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="FormID & PDCR_PK">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFormID" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# Eval("FormID") %>'></asp:Label><br />
                                            <asp:Label ID="lblPDCR_PK" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# Eval("PDCR_PK") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Plant and Line Details">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPlantName" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Plant: " + Eval("PlantName") %>'></asp:Label><br />
                                            <asp:Label ID="lblLine" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Line: " + Eval("Line") %>'></asp:Label><br />
                                            <asp:Label ID="lblProductCategory" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Praduct Category: " + Eval("ProductCategory") %>'></asp:Label><br />
                                            <asp:Label ID="lblProductBrand" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Product Brand: " + Eval("ProductBrand") %>'></asp:Label><br />
                                            <asp:Label ID="lblSKUId" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "SKU ID: " + Eval("SKUId") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Submission Details">
                                        <ItemTemplate>
                                            <asp:Label ID="lblInspectionLot" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Inspection Lot: " + Eval("InspectionLot") %>'></asp:Label><br />
                                            <asp:Label ID="lblMaterialCode" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Material Code: " + Eval("MaterialCode") %>'></asp:Label><br />
                                            <asp:Label ID="lblCBBProduced" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "CBB Produced: " + Eval("CBB_Produced") %>'></asp:Label><br />
                                            <asp:Label ID="lblCBBChecked" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "CBB Checked: " + Eval("CBB_Checked") %>'></asp:Label><br />
                                            <asp:Label ID="lblCBBBoxCondition" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "CBB Box Condition: " + Eval("CBB_Box_Condition") %>'></asp:Label><br />
                                            <asp:Label ID="lblCBBBoxConditionRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "CBB Tapping Remarks: " + Eval("CBB_Box_ConditionRemarks") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Test Details">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPacketsCBB" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Packets CBB: " + Eval("Packets_CBB") %>'></asp:Label><br />
                                            <asp:Label ID="lblCBBTapping" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "CBB Tapping: " + Eval("CBB_tapping") %>'></asp:Label><br />
                                            <asp:Label ID="lblCBBTappingRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "CBB Tapping Remarks: " + Eval("CBB_tappingRemarks") %>'></asp:Label><br />
                                            <asp:Label ID="lblPacketsCheckedCBB" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Packets Checked CBB: " + Eval("PacketsChecked_CBB") %>'></asp:Label><br />
                                            <asp:Label ID="lblWeightofPackets" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Weight of Packets: " + Eval("WeightofPackets") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Package Details">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPackageDate" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Package Date: " + Eval("PackageDate", "{0:dd-MM-yyyy}") %>'></asp:Label><br />
                                            <asp:Label ID="lblBatchNo" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Batch No: " + Eval("BatchNo") %>'></asp:Label><br />
                                            <asp:Label ID="lblPacketsMRP" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Packets MRP: " + Eval("PacketsMRP") %>'></asp:Label><br />
                                            <asp:Label ID="lblLongSeal" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Long Seal: " + Eval("LongSeal") %>'></asp:Label><br />
                                            <asp:Label ID="lblLongSealRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Long Seal Remarks: " + Eval("LongSealRemarks") %>'></asp:Label><br />
                                            <asp:Label ID="lblEndSeal" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "End Seal: " + Eval("EndSeal") %>'></asp:Label><br />
                                            <asp:Label ID="lblEndSealRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "End Seal Remarks: " + Eval("EndSealRemarks") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Main Panels Details">
                                        <ItemTemplate>
                                            <asp:Label ID="lblMainPanel" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Main Panel: " + Eval("MainPanel") %>'></asp:Label><br />
                                            <asp:Label ID="lblMainPanelRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Main Panel Remarks: " + Eval("MainPanelRemarks") %>'></asp:Label><br />
                                            <asp:Label ID="lblCutsPackets" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Cuts Packets: " + Eval("Cuts_Packets") %>'></asp:Label><br />
                                            <asp:Label ID="lblCutsPacketsRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Cuts Packets Remarks: " + Eval("Cuts_PacketsRemarks") %>'></asp:Label><br />
                                            <asp:Label ID="lblBackingStatus" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Backing Status: " + Eval("BackingStatus") %>'></asp:Label><br />
                                            <asp:Label ID="lblBackingStatusRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Backing Status Remarks: " + Eval("BackingStatusRemarks") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Test Details">
                                        <ItemTemplate>
                                            <asp:Label ID="lblElongOval" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Elong Oval: " + Eval("ElongOval") %>'></asp:Label><br />
                                            <asp:Label ID="lblElongOvalRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Elong Oval Remarks: " + Eval("ElongOvalRemarks") %>'></asp:Label><br />
                                            <asp:Label ID="lblCupping" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Cupping: " + Eval("Cupping") %>'></asp:Label><br />
                                            <asp:Label ID="lblCuppingRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Cupping Remarks: " + Eval("CuppingRemarks") %>'></asp:Label><br />
                                            <asp:Label ID="lblImpression" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Impression: " + Eval("Impression") %>'></asp:Label><br />
                                            <asp:Label ID="lblImpressionRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Impression Remarks: " + Eval("ImpressionRemarks") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Test Details">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSoggyStatus" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Soggy Status: " + Eval("SoggyStatus") %>'></asp:Label><br />
                                            <asp:Label ID="lblSoggyStatusRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Soggy Status Remarks: " + Eval("SoggyStatusRemarks") %>'></asp:Label><br />
                                            <asp:Label ID="lblForeignBody" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Foreign Body: " + Eval("ForeignBody") %>'></asp:Label><br />
                                            <asp:Label ID="lblForeignBodyRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Foreign Body Remarks: " + Eval("ForeignBodyRemarks") %>'></asp:Label><br />
                                            <asp:Label ID="lblOffOdour" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Off Odour: " + Eval("OffOdour") %>'></asp:Label><br />
                                            <asp:Label ID="lblOffOdourRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Off Odour Remarks: " + Eval("OffOdourRemarks") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Remarks & Submission Details">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Remarks: " + Eval("Remarks") %>'></asp:Label><br />
                                            <asp:Label ID="lblShift" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Shift: " + Eval("Shift") %>'></asp:Label><br />
                                            <asp:Label ID="lblSubmittedBy" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Submitted By: " + Eval("SubmittedById") %>'></asp:Label><br />
                                            <asp:Label ID="lblSubmittedDate" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Submitted Date: " + Eval("SubmittedDate", "{0:dd-MM-yyyy}") %>'></asp:Label><br />
                                            <asp:Label ID="lblSubmittedTime" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Submitted Time: " + Eval("SubmittedTime", "{0:hh\\:mm\\:ss}") %>'></asp:Label><br />
                                            <asp:Label ID="lblSubmittedByEmployeeCode" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Submitted By Employee Code: " + Eval("SubmittedByEmployeeCode") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Level1 Approval">
                                        <ItemTemplate>
                                            <asp:Label ID="lblApprover1Status" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Approver 1 Status: " + Eval("Approver1_Status") %>'></asp:Label><br />
                                            <asp:Label ID="lblApprover1TimeStamp" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Approver 1 Timestamp: " + Eval("Approver1_TimeStamp", "{0:dd-MM-yyyy HH:mm:ss}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Level2 Approval">
                                        <ItemTemplate>
                                            <asp:Label ID="lblApprover2Status" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Approver 2 Status: " + Eval("Approver2_Status") %>'></asp:Label><br />
                                            <asp:Label ID="lblApprover2TimeStamp" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Approver 2 Timestamp: " + Eval("Approver2_TimeStamp", "{0:dd-MM-yyyy HH:mm:ss}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Dotted Approval">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDottedApproverStatus" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Dotted Approver Status: " + Eval("DottedApprover_Status") %>'></asp:Label><br />
                                            <asp:Label ID="lblDottedApproverTimeStamp" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Dotted Approver Timestamp: " + Eval("DottedApprover_TimeStamp", "{0:dd-MM-yyyy HH:mm:ss}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div class="x_content"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
