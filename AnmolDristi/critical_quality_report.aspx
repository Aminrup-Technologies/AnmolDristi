<%@ Page Title="AIL | Critical Incident Form" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="critical_quality_report.aspx.cs" Inherits="AnmolDristi.critical_quality_report" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .remove-border {
            border: none !important; /* This will ensure the border is removed */
            /* Add any other necessary styling */
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        function toggleDispatchAppRemarksDiv(radioButtonList) {
            console.log("toggleDispatchAppRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("DispatchAppRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }
        function showNotification(title, text, type) {
            new PNotify({
                title: title,
                text: text,
                type: type,
                styling: 'bootstrap3'
            });
        }
    </script>

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>
                        <asp:Label ID="lbl_docname" runat="server" Text="Critical Incident Report"></asp:Label></h3>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docnumber" runat="server" Text="ANMOL/DOC/CORP/QA/07"></asp:Label></h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="DDL_Plant" Text="Plant Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    [<asp:Label ID="lbl_DDL_Plant_Value" runat="server" AssociatedControlID="DDL_Plant" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
                                     <asp:RequiredFieldValidator ID="RFV_DDL_Plant" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_Plant" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_Plant_SelectedIndexChanged"></asp:DropDownList>

                                    </div>

                                </div>

                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="DDL_PlantLine" Text="Select Line" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    [<asp:Label ID="lbl_DDL_PlantLine_Value" runat="server" AssociatedControlID="DDL_PlantLine" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
                                     <asp:RequiredFieldValidator ID="RFV_DDL_PlantLine" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_PlantLine" Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_PlantLine" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_PlantLine_SelectedIndexChanged"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label3" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    [<asp:Label ID="lbl_DDL_ProductCategory_Value" runat="server" AssociatedControlID="DDL_ProductCategory" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductCategory" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" InitialValue="" ControlToValidate="DDL_ProductCategory" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductCategory_SelectedIndexChanged"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    [<asp:Label ID="lbl_DDL_ProductBrand_Value" runat="server" AssociatedControlID="DDL_ProductBrand" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
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
                                        <asp:DropDownList ID="DDL_BrandSKU" runat="server" CssClass="form-control form-control-sm rounded" ></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_BatchCode" runat="server" AssociatedControlID="TB_BatchCode" Text="Batch Code :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_BatchCode" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_BatchCode" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_BatchCode" runat="server" CssClass="form-control form-control-sm rounded" MaxLength="50"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_QCI" runat="server" AssociatedControlID="TB_QCI" Text="QCI :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_QCI" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_QCI" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_QCI" runat="server" CssClass="form-control form-control-sm rounded" MaxLength="50"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_SftInCharge" runat="server" AssociatedControlID="TB_SftInCharge" Text="Shift In-Charge Name :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_SftInCharge" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_SftInCharge" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_SftInCharge" runat="server" CssClass="form-control form-control-sm rounded" MaxLength="50"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_qaqcInCharge" runat="server" AssociatedControlID="TB_qaqcInCharge" Text="QA & QC In-Charge Name :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_qaqcInCharge" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_qaqcInCharge" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_qaqcInCharge" runat="server" CssClass="form-control form-control-sm rounded" MaxLength="50"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="mb-6">
                                    <asp:Label ID="Lbl_qiDetails" runat="server" AssociatedControlID="TB_qiDetails" Text="Quality Incident Details :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_qiDetails" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_qiDetails" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_qiDetails" runat="server" TextMode="MultiLine" Rows="1" CssClass="form-control form-control-sm rounded" Columns="1" Wrap="True"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_r_hQuantity" runat="server" AssociatedControlID="TB_r_hQuantity" Text="Rejected/Hold Quantity :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_r_hQuantity" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_r_hQuantity" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_r_hQuantity" runat="server" ValidationGroup="Submit" ControlToValidate="TB_r_hQuantity" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_r_hQuantity" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Number"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Observed" runat="server" AssociatedControlID="TB_Observed" Text="When Observed :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Observed" runat="server" ErrorMessage="*" ControlToValidate="TB_Observed" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Observed" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" Placeholder="HH:MM"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_ImmediateTakenAction" runat="server" AssociatedControlID="TB_ImmediateTakenAction" Text="Immediate Taken Action :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_ImmediateTakenAction" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_ImmediateTakenAction" ValidationGroup="Submit" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_ImmediateTakenAction" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_c_pActions" runat="server" AssociatedControlID="TB_c_pActions" Text="Corrective/Preventive Actions :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_c_pActions" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_c_pActions" ValidationGroup="Submit" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_c_pActions" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TargetDtCom" runat="server" AssociatedControlID="TB_TargetDtCom" Text="Target Date of Completion :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="TB_TargetDtCom" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_TargetDtCom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Date"></asp:TextBox>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Responsibility" runat="server" AssociatedControlID="TB_Responsibility" Text="Responsibility :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Responsibility" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_Responsibility" ValidationGroup="Submit" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Responsibility" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                 <div class="mb-3">
                                    <asp:Label ID="Lbl_DispatchApp" runat="server" AssociatedControlID="RBL_DispatchApp" Text="Dispatch Approval:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_RBL_DispatchApp" runat="server" ValidationGroup="Submit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_DispatchApp" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:RadioButtonList ID="RBL_DispatchApp" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleDispatchAppRemarksDiv(this);">
                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="DispatchAppRemarksDiv" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_DispatchAppRemarks" runat="server" AssociatedControlID="TB_Remarks" Text="Dispatch Approval Remarks :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Remarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <%--<div class="col-md-3">
                            <div class="mb-3">
                                <asp:Label ID="Lbl_IssueTime" runat="server" AssociatedControlID="TB_IssueTime" Text="Time of Issueing this Slip to :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                <asp:RequiredFieldValidator ID="RFV_TB_IssueTime" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_IssueTime" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                <div class="input-group-sm">
                                    <asp:TextBox ID="TB_IssueTime" runat="server" TextMode="Time"></asp:TextBox>
                                </div>
                            </div>
                        </div>--%>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="btnSubmit" Text="Click to SUBMIT" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group input-group-sm">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="btnSubmit_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="btnReset_Click" />
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
