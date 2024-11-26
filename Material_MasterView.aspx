<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Material_MasterView.aspx.cs" Inherits="AnmolDristi.Material_MasterView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="right_col" role="main">
        <div class="container">

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docname" runat="server" Text="Label"></asp:Label></h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <div class="tab-content ml-1" id="myTabContent">
                                    <div class="x-content">

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="Lbl_DDL_MaterialType" runat="server" AssociatedControlID="DDL_MaterialType" Text="Material Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_DDL_MaterialType" runat="server" ErrorMessage="" ForeColor="Red" ControlToValidate="DDL_MaterialType" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:DropDownList ID="DDL_MaterialType" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_MaterialType_SelectedIndexChanged"></asp:DropDownList>
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

            <!-- Search Section -->
            <div class="row mb-3">
                <div class="col-md-4">
                    <asp:TextBox ID="SearchBox" runat="server" CssClass="form-control form-control-sm rounded" placeholder="Search by Model Number"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="btn btn-primary btn-sm" CausesValidation="false" OnClick="SearchButton_Click" />
                    <asp:Button ID="ReportbtnCancel" runat="server" Text="Cancle" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="ReportbtnCancel_Click" />
                    <asp:Button ID="ReportbtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="ReportbtnReset_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_viewname" runat="server" Text="Material List"></asp:Label>
                            </h2>
                            <div class="clearfix"></div>
                        </div>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_PageIndexChanging" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap">

                            <Columns>

                                <asp:TemplateField HeaderText="Sl">
                                    <ItemTemplate>
                                        <%--<asp:Label ID="lblSl" runat="server" ReadOnly="true" ClientIDMode="Static" Text="Sl:"></asp:Label><strong><%# Container.DataItemIndex + 1 %></strong>
                                        <br />--%>
                                        <asp:Label ID="lblId" runat="server" CssClass="bold-text" ReadOnly="true" ClientIDMode="Static" Text='<%# "ID: " + "<strong>" + Eval("Id") + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblMatNo" runat="server" CssClass="bold-text" ReadOnly="true" ClientIDMode="Static" Text='<%# "MAT-No: " + "<strong>" + Eval("MaterialNumber") + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText=" Material Type ">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMaterialType" runat="server" ClientIDMode="Static" Text='<%# "Material Type:" + "<strong>" + Eval("MaterialType") + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText=" Model Number ">
                                    <ItemTemplate>
                                        <asp:Label ID="lblModelNumber" runat="server" ClientIDMode="Static" Text='<%# "Model Number :" + "<strong>" + Eval("ModelNumber") + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText=" Material Brand ">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMaterialBrand" runat="server" ClientIDMode="Static" Text='<%# "Material Brand :" + "<strong>" + Eval("MaterialBrand") + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Friendly Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFriendlyName" runat="server" ClientIDMode="Static" Text='<%# "Friendly Name :" + "<strong>" + Eval("FriendlyName") + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="View">
                                    <ItemTemplate>
                                        <asp:Button ID="ViewBtn" runat="server" Text="View" CssClass="btn btn-warning btn-sm" CausesValidation="false" CommandArgument='<%# Eval("Id") %>' OnClick="ViewBtn_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>

                        </asp:GridView>
                    </div>
                </div>
            </div>


        </div>
    </div>

</asp:Content>
