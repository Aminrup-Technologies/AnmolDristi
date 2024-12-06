<%@ Page Title="AIL | Critical Incident Detailed View" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Critical_Incident_Detailed.aspx.cs" Inherits="AnmolDristi.Critical_Incident_Detailed" Async="true" %>

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

                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded" ></asp:DropDownList>

                                    </div>

                                </div>

                            </div>
                            <div class="col-md-2">
                                <div class="mb-2">
                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="DDL_PlantLine" Text="Select Line" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_PlantLine" runat="server" CssClass="form-control form-control-sm rounded"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="mb-2">
                                    <asp:Label ID="Label3" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="mb-2">
                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="DDL_BrandSKU" Text="Brand SKU Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_BrandSKU" runat="server" CssClass="form-control form-control-sm rounded" ></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_BatchCode" runat="server" AssociatedControlID="TB_BatchCode" Text="Batch Code :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_BatchCode" runat="server" CssClass="form-control form-control-sm rounded" MaxLength="50" Text=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_QCI" runat="server" AssociatedControlID="TB_QCI" Text="QCI :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_QCI" runat="server" CssClass="form-control form-control-sm rounded" MaxLength="50" Text=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_SftInCharge" runat="server" AssociatedControlID="TB_SftInCharge" Text="Shift In-Charge Name :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_SftInCharge" runat="server" CssClass="form-control form-control-sm rounded" MaxLength="50" Text=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_qaqcInCharge" runat="server" AssociatedControlID="TB_qaqcInCharge" Text="QA & QC In-Charge Name :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_qaqcInCharge" runat="server" CssClass="form-control form-control-sm rounded" MaxLength="50" Text=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="mb-6">
                                    <asp:Label ID="Lbl_qiDetails" runat="server" AssociatedControlID="TB_qiDetails" Text="Quality Incident Details :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_qiDetails" runat="server" TextMode="MultiLine" Rows="1" CssClass="form-control form-control-sm rounded" Columns="1" Wrap="True" Text=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_r_hQuantity" runat="server" AssociatedControlID="TB_r_hQuantity" Text="Rejected/Hold Quantity :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_r_hQuantity" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Number" Text=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Observed" runat="server" AssociatedControlID="TB_Observed" Text="When Observed :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Observed" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" Placeholder="HH:MM" Text=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_ImmediateTakenAction" runat="server" AssociatedControlID="TB_ImmediateTakenAction" Text="Immediate Taken Action :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_ImmediateTakenAction" runat="server" CssClass="form-control form-control-sm rounded" Text=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_c_pActions" runat="server" AssociatedControlID="TB_c_pActions" Text="Corrective/Preventive Actions :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_c_pActions" runat="server" CssClass="form-control form-control-sm rounded" Text=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TargetDtCom" runat="server" AssociatedControlID="TB_TargetDtCom" Text="Target Date of Completion :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_TargetDtCom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Date" Text=""></asp:TextBox>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Responsibility" runat="server" AssociatedControlID="TB_Responsibility" Text="Responsibility :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Responsibility" runat="server" CssClass="form-control form-control-sm rounded" Text=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_DispatchApp" runat="server" AssociatedControlID="RBL_DispatchApp" Text="Dispatch Approval:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group-sm">
                                        <asp:RadioButtonList ID="RBL_DispatchApp" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleDispatchAppRemarksDiv(this);">
                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6" id="DispatchAppRemarksDiv" style="display: none;" runat="server">
                                <div class="mb-6">
                                    <asp:Label ID="Lbl_DispatchAppRemarks" runat="server" AssociatedControlID="TB_Remarks" Text="Dispatch Approval Remarks :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Remarks" runat="server" CssClass="form-control form-control-sm rounded" Text=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_BasicbtnApprove" runat="server" AssociatedControlID="" Text="Click on your ACTION" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group input-group-sm">
                                        <asp:Button ID="BtnValidate" runat="server" Text="Re-Validate inputs" CssClass="btn btn-warning btn-sm" ValidationGroup="" CausesValidation="true" />
                                        <asp:Button ID="BtnApprove" runat="server" Text="Approve" CssClass="btn btn-success btn-sm" CausesValidation="false" OnClick="BtnApprove_Click" />
                                        <asp:Button ID="BtnReject" runat="server" Text="Reject" CssClass="btn btn-sm btn-danger" CausesValidation="false" OnClick="BtnReject_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>




</asp:Content>
