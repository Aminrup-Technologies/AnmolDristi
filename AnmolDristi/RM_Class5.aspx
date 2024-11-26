<%@ Page Title="RAW MATERIAL FORM" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="RM_Class5.aspx.cs" Inherits="AnmolDristi.RM_Class5" %>
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
                        <asp:Label ID="lbl_docname" runat="server" Text="RAW MATERIAL FORM REPORT"></asp:Label></h3>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docnumber" runat="server" Text="ANMOL/DOC/CORP/QC/.."></asp:Label></h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label1" runat="server" <%--AssociatedControlID="DDL_Plant"--%> Text="Plant :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                  <%--  [<asp:Label ID="lbl_DDL_Plant_Value" runat="server" AssociatedControlID="DDL_Plant" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
                                     <asp:RequiredFieldValidator ID="RFV_DDL_Plant" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_Plant" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" <%--ValidationGroup="Submit" OnSelectedIndexChanged="DDL_Plant_SelectedIndexChanged"--%> ></asp:DropDownList>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label2" runat="server" <%--AssociatedControlID="DDL_Material" --%>Text="Material :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                     <%--<asp:RequiredFieldValidator ID="RFV_DDL_Material" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_Material" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Material" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" <%--ValidationGroup="Submit" OnSelectedIndexChanged=""--%> ></asp:DropDownList>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label4" runat="server" <%--AssociatedControlID="DDL_ProductBrand"--%> Text="Product Brand :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                   <%-- [<asp:Label ID="lbl_DDL_ProductBrand_Value" runat="server" AssociatedControlID="DDL_ProductBrand" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductBrand" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_ProductBrand" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" <%--OnSelectedIndexChanged="DDL_ProductBrand_SelectedIndexChanged" --%>></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Supplier" runat="server" <%--AssociatedControlID="TB_Supplier--%>" Text="Supplier :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%-- <asp:RequiredFieldValidator ID="RFV_TB_Supplier" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TB_Supplier" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Supplier" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_ChalanNo" runat="server" <%--AssociatedControlID="TB_ChalanNo"--%> Text="Chalan No. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_ChalanNo" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_ChalanNo" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_ChalanNo" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_ChalanDate" runat="server" <%--AssociatedControlID="TB_ChalanDate"--%> Text="Chalan Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_ChalanDate" runat="server" ErrorMessage="*" ControlToValidate="TB_ChalanDate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_ChalanDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" Placeholder=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                             <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label3" runat="server" <%--AssociatedControlID="TB_Quantity"--%> Text="Quantity :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_Quantity" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Quantity" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_Quantity" runat="server" ValidationGroup="Submit" ControlToValidate="TB_Quantity" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_Quantity" runat="server" ErrorMessage="N1 to N2" ValidationGroup="Submit" ControlToValidate="TB_Quantity" MinimumValue="50" MaximumValue="100" Type="Integer" Display="Static" ForeColor="Red" ></asp:RangeValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Quantity" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Number"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_LotNo" runat="server" <%--AssociatedControlID="TB_LotNo"--%> Text="LOT/ Gate No. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_LotNo" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_LotNo" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_LotNo" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_VehicleNo" runat="server" <%--AssociatedControlID="TB_VehicleNo"--%> Text="Vehicle No. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                   <%-- <asp:RequiredFieldValidator ID="RFV_TB_VehicleNo" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_VehicleNo" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_VehicleNo" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label5" runat="server" <%--AssociatedControlID="TB_MFG_Date"--%> Text="MFG Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%--<asp:RequiredFieldValidator ID="RFV_TB_MFG_Date" runat="server" ErrorMessage="*" ControlToValidate="TB_MFG_Date" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_MFG_Date" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" Placeholder=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_GSM" runat="server" AssociatedControlID="TB_GSM" Text="GSM / Wt per 10pc :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_GSM" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_GSM" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_GSM" runat="server" ValidationGroup="Submit" ControlToValidate="TB_GSM" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_GSM" runat="server" ErrorMessage="N1 to N2" ValidationGroup="Submit" ControlToValidate="TB_GSM" MinimumValue="50" MaximumValue="100" Type="Integer" Display="Static" ForeColor="Red" ></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_GSM" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="[50-100]"  TextMode="Number"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Remarks" runat="server" AssociatedControlID="TB_Remarks" Text="Remarks :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Remarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="btnSubmit" Text="Click to SUBMIT" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group input-group-sm">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary btn-sm" CausesValidation="false" OnClick="btnSubmit_Click" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" OnClick="btnReset_Click" CausesValidation="false" />
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
