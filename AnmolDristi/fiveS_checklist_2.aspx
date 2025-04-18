<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="fiveS_checklist_2.aspx.cs" Inherits="AnmolDristi.fiveS_checklist_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    html, body {
        overflow-x: hidden;
    }
    .table-rspv {
        overflow-x: auto;
        width: 100%;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5 style="text-align: center; font-weight: bold"; class="text-success">CHECKLIST FOR 5S</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <asp:label runat="server" ForeColor="Green" Font-Bold="true">ATS/OHS/HKS-5SCL-01</asp:label>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="table-rspv">

                                <asp:GridView ID="GridViewChecklists" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="ID" CssClass="table table-bordered table-hover table-responsive-md"
                                     OnRowDataBound="GridViewChecklists_RowDataBound" OnRowCommand="GridViewChecklists_RowCommand" 
 >
                                    <HeaderStyle CssClass="thead-dark" />
                                    <Columns>
                                        <asp:BoundField DataField="ID" HeaderText="Checklist ID" ReadOnly="true" />
                                        <asp:BoundField DataField="Date" HeaderText="Date" />
                                        <asp:BoundField DataField="Department" HeaderText="Department" />
                                        <asp:BoundField DataField="Job" HeaderText="Job" />

                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>
                                                <div class="btn-group btn-group-sm" role="group">
                                                    <asp:HyperLink ID="btnView" runat="server" CssClass="btn btn-info text-white m-2" NavigateUrl='<%# "view_Checklists.aspx?id=" + Eval("ID") %>' >
                        <i class="fa fa-eye"></i> View
                                                    </asp:HyperLink>
                                                    <asp:LinkButton ID="btnEdit" runat="server" 
                                                         CssClass="btn btn-warning text-white m-2" PostBackUrl='<%# "~/fiveS_checklist_1.aspx?id=" + Eval("ID") %>'>
                        <i class="fa fa-edit"></i> Edit
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteChecklist"
                                                        CommandArgument='<%# Eval("ID") %>' CssClass="btn btn-danger text-white m-2"
                                                        OnClientClick="return confirm('Are you sure you want to delete this checklist?');">
                        <i class="fa fa-trash"></i> Delete
                                                    </asp:LinkButton>
                                                </div>
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
    </div>
</asp:Content>
