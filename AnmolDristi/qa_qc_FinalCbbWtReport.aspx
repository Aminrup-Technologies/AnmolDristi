<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qa_qc_FinalCbbWtReport.aspx.cs" Inherits="AnmolDristi.qa_qc_FinalCbbWtReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .remove-border {
            border: none !important; /* This will ensure the border is removed */
            /* Add any other necessary styling */
        }
    </style>

    <script type="text/javascript">
        function validateGridView() {
            var isValid = true;
            var gridView = document.getElementById('<%= GridView1.ClientID %>');
            for (var i = 1; i < gridView.rows.length; i++) {  // Start from 1 to skip header row
                var row = gridView.rows[i];

                var txtGrossWeight = row.querySelector("input[id*='txtGrossWeight']");
                //var txtDescription = row.querySelector("input[id*='txtDescription']");

                // Check if TextBoxes are filled
                if (txtGrossWeight && txtGrossWeight.value.trim() === "") {
                    isValid = false;
                    txtGrossWeight.style.borderColor = "red";
                } else {
                    txtGrossWeight.style.borderColor = "";
                }

                //if (txtDescription && txtDescription.value.trim() === "") {
                //    isValid = false;
                //    txtDescription.style.borderColor = "red";
                //} else {
                //    txtDescription.style.borderColor = "";
                //}
            }

            // If not valid, prevent form submission
            if (!isValid) {
                alert("Please fill all the required fields.");
            }

            return isValid;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
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
                                                            aria-controls="basicData" aria-selected="true"><%--<i class="fa fa-id-badge mr-2"></i>--%>Basic Data</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link text-info" id="GrossWeightData-tab" data-toggle="tab" href="#GrossWeightData" role="tab"
                                                            aria-controls="GrossWeightData" aria-selected="false"><%--<i class="fa fa-id-badge mr-2"></i>--%>Gross Weight</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link text-info" id="GrossWeightData2-tab" data-toggle="tab" href="#GrossWeightData2" role="tab"
                                                            aria-controls="GrossWeightData2" aria-selected="false"><%--<i class="fa fa-id-badge mr-2"></i>--%>Design 2</a>
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


                                                            <%-- <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="lblLineNo" runat="server" AssociatedControlID="TXT_LineNo" Text="Line Number:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_LineNo" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TXT_LineNo" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_LineNo" runat="server" ValidationGroup="Submit" ControlToValidate="TXT_LineNo" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <asp:RangeValidator ID="RV_LineNo" runat="server" ControlToValidate="TXT_LineNo" ErrorMessage="[0 - 31]" ForeColor="Red" MinimumValue="1" MaximumValue="30" Type="Integer" Display="Static"></asp:RangeValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXT_LineNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Line Number [1 - 30]"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>--%>

                                                            <%--<div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="lblProductName" runat="server" AssociatedControlID="TXT_ProductName"
                                                                        Text="Product Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small">
                                                                    </asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_ProductName" runat="server"
                                                                        ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TXT_ProductName"
                                                                        Display="Dynamic" ForeColor="Red">
                                                                    </asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_ProductName" runat="server"
                                                                        ValidationGroup="Submit" ControlToValidate="TXT_ProductName" ForeColor="Red"
                                                                        ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9]+$" Display="Dynamic">
                                                                    </asp:RegularExpressionValidator>
                                                                    <asp:RangeValidator ID="RV_ProductName" runat="server" ControlToValidate="TXT_ProductName"
                                                                        ErrorMessage="Product Name must be between 1 and 30 characters long" ForeColor="Red"
                                                                        MinimumValue="1" MaximumValue="30" Type="String" Display="Static">
                                                                    </asp:RangeValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXT_ProductName" runat="server"
                                                                            CssClass="form-control form-control-sm rounded"
                                                                            Placeholder="Enter Product Name [1 - 30 Characters]" MaxLength="30">
                                                                        </asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>--%>





                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="lblBatchNo" runat="server" AssociatedControlID="TXT_BatchNo" Text="Batch No:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BatchNo" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TXT_BatchNo" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_BatchNo" runat="server" ValidationGroup="Submit" ControlToValidate="TXT_BatchNo" ForeColor="Red" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9]+$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXT_BatchNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Batch No"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <%--<div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="lblSlNo" runat="server" AssociatedControlID="TXT_SlNo" Text="Serial Number:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SlNo" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TXT_SlNo" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_SlNo" runat="server" ValidationGroup="Submit" ControlToValidate="TXT_SlNo" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <asp:RangeValidator ID="RV_SlNo" runat="server" ControlToValidate="TXT_SlNo" ErrorMessage="[0 - 31]" ForeColor="Red" MinimumValue="1" MaximumValue="30" Type="Integer" Display="Static"></asp:RangeValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXT_SlNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Serial Number [1 - 30]"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>--%>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="lblMRP" runat="server" AssociatedControlID="TXT_MRP" Text="MRP:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MRP" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TXT_MRP" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_MRP" runat="server" ValidationGroup="Submit" ControlToValidate="TXT_MRP" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="^\d+(\.\d{1,2})?$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <asp:RangeValidator ID="RV_MRP" runat="server" ControlToValidate="TXT_MRP" ErrorMessage="[0.00 - 9999.99]" ForeColor="Red" MinimumValue="0.00" MaximumValue="9999.99" Type="Double" Display="Static"></asp:RangeValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXT_MRP" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="MRP [0.00 - 9999.99]"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <%--<div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="lblGrossWt" runat="server" AssociatedControlID="TXT_GrossWt" Text="Gross Weight:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_GrossWt" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TXT_GrossWt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_GrossWt" runat="server" ValidationGroup="Submit" ControlToValidate="TXT_GrossWt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <asp:RangeValidator ID="RV_GrossWt" runat="server" ControlToValidate="TXT_GrossWt" ErrorMessage="[0.01 - 10000]" ForeColor="Red" MinimumValue="0.01" MaximumValue="10000" Type="Double" Display="Static"></asp:RangeValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXT_GrossWt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Gross Weight [0.01 - 10000]"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>--%>


                                                            <%--  --%>


                                                            <%--<asp:Button ID="Btn_Save" runat="server" Text="Save" OnClick="Btn_Save_Click" CssClass="btn btn-primary" />
                                                            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>--%>

                                                            <div class="col-md-12 text-center">
                                                                <asp:Button ID="Btn_Save" runat="server" Text="Save" OnClick="Btn_Save_Click" CssClass="btn btn-primary" />
                                                                <asp:Button ID="Btn_Reset" runat="server" Text="Reset" OnClick="Btn_Reset_Click" CssClass="btn btn-warning" />
                                                                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
                                                            </div>



                                                        </div>
                                                    </div>

                                                    <div class="tab-pane fade" id="GrossWeightData" role="tabpanel" aria-labelledby="GrossWeightData-tab">
                                                        <div class="x_content">
                                                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Sl">
                                                                        <ItemTemplate>
                                                                            <%# Container.DataItemIndex + 1 %>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="Gross Weight">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtGrossWeight" runat="server"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return validateGridView();" OnClick="btnSubmit_Click" />
                                                    </div>

                                                    <div class="tab-pane fade" id="GrossWeightData2" role="tabpanel" aria-labelledby="GrossWeightData2-tab">
                                                        <div class="x_content">
                                                            <asp:GridView ID="yourGridView" runat="server" AutoGenerateColumns="False">
                                                                <Columns>
                                                                    <asp:BoundField DataField="SlNo" HeaderText="Sl. No." />
                                                                    <asp:BoundField DataField="GrossWeight" HeaderText="Gross Weight" />
                                                                </Columns>
                                                            </asp:GridView>
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
</asp:Content>
