<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_rotaryline_view.aspx.cs" Inherits="AnmolDristi.qaqc_rotaryline_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-12" id="View_Panel" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_upper" runat="server" Text="Label"></asp:Label>
                            </h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
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
                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="DDL_PlantLine" Text="Select Line" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_PlantLine" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_PlantLine" Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_PlantLine" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_PlantLine_SelectedIndexChanged"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductCategory" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" InitialValue="" ControlToValidate="DDL_ProductCategory" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductCategory_SelectedIndexChanged"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label6" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductBrand" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_ProductBrand" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductBrand_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label7" runat="server" AssociatedControlID="DDL_BrandSKU" Text="Brand SKU Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_BrandSKU" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_BrandSKU" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_BrandSKU" runat="server" CssClass="form-control form-control-sm rounded"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label8" runat="server" AssociatedControlID="TxtDateFrom" Text="Date From" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TxtDateFrom" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TxtDateFrom" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TxtDateFrom" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label9" runat="server" AssociatedControlID="TxtDateTo" Text="Date To" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TxtDateTo" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="TxtDateTo" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TxtDateTo" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-md-12 text-center">
                    <asp:Label ID="lbl_oven" runat="server" Text="Click SUBMIT to view Data!!" ForeColor="SlateGray" Font-Bold="true"></asp:Label>


                    <asp:Button ID="btn_view_cancel" runat="server" Text="Cancel" CssClass="btn btn-danger btn-sm" OnClick="btn_view_cancel_Click" CausesValidation="true" />
                    <asp:Button ID="btn_view_reset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" OnClick="btn_view_reset_Click" CausesValidation="false" />
                    <asp:Button ID="btn_view_submit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" OnClick="btn_view_submit_Click" CausesValidation="false" />

                </div>


                <div class="col-md-12" id="Div1" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_lower" runat="server" Text="Label"></asp:Label>
                            </h2>
                            <asp:Button ID="btn_view_export" runat="server" Text="Export" class="btn btn-primary btn-sm" OnClick="btn_view_export_Click" />


                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>


                        <div class="table-responsive">

                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sl">
                                        <ItemTemplate>
                                            <asp:Label ID="lblId" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="RLWt">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRLWt" runat="server" ClientIDMode="Static" Text='<%# Eval("RLWt") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Plant and Line Details">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPlantName" runat="server" Text='<%# "Plant: " + Eval("PlantName") %>'></asp:Label><br />
                                            <asp:Label ID="lblLine" runat="server" Text='<%# "Line: " + Eval("Line") %>'></asp:Label><br />
                                            <asp:Label ID="lblProductCategory" runat="server" Text='<%# "Category: " + Eval("ProductCategory") %>'></asp:Label><br />
                                            <asp:Label ID="lblProductBrand" runat="server" Text='<%# "Brand: " + Eval("ProductBrand") %>'></asp:Label><br />
                                            <asp:Label ID="lblSKUId" runat="server" Text='<%# "SKU: " + Eval("SKUId") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>


                                    <asp:TemplateField HeaderText="Submission Details">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" Text='<%# "Date: " + Eval("SubmittedDate", "{0:dd/MM/yyyy}") %>'></asp:Label><br />
                                            <asp:Label ID="lblTime" runat="server" Text='<%# "Time: " + Eval("SubmittedTime", "{0:hh\\:mm\\:ss}") %>'></asp:Label><br />
                                            <asp:Label ID="lblShift" runat="server" Text='<%# "Shift: " + Eval("Shift") %>'></asp:Label><br />
                                            <asp:Label ID="lblVariety" runat="server" Text='<%# "Variety: "+Eval("Variety") %>'></asp:Label><br />
                                        </ItemTemplate>
                                    </asp:TemplateField>


                                    <asp:TemplateField HeaderText="Level1 Approval Details">
                                        <ItemTemplate>

                                            <asp:Label ID="lblLevel1ApproverId" runat="server" Text='<%# "Level 1 Approver ID: " + Eval("Approver1EmployeeCode") %>'></asp:Label><br />
                                            <asp:Label ID="lblLevel2ApproverId" runat="server" Text='<%# "Level 2 Approver ID: " + Eval("Approver2EmployeeCode") %>'></asp:Label><br />
                                            <asp:Label ID="lblLevel3ApproverId" runat="server" Text='<%# "Level 3 Approver ID: " + Eval("DottedLineApproverEmployeeCode") %>'></asp:Label><br />
                                        </ItemTemplate>
                                    </asp:TemplateField>


                                    <asp:TemplateField HeaderText="Test Details">
                                        <ItemTemplate>
                                            <asp:Label ID="lblLineWt" runat="server" Visible="false" Text='<%# "Line Weight: " + Eval("linewt") %>'></asp:Label><br />
                                            <asp:Label ID="lblGaugeAndWeight" runat="server" Visible="false" Text='<%# "Gauge and Weight: " + Eval("gaugeandweight") %>'></asp:Label><br />
                                            <asp:Label ID="lblAvgLineWt" runat="server" Text='<%# "Average Line Weight: " + Eval("avglinewt") %>'></asp:Label><br />
                                            <asp:Label ID="lblAvgGaugeValue" runat="server" Text='<%# "Average Gauge Value: " + Eval("avggaugevalue") %>'></asp:Label><br />
                                            <asp:Label ID="lblAvgWeightValue" runat="server" Text='<%# "Average Weight Value: " + Eval("avgweightvalue") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
