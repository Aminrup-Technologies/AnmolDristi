<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Line_Walk_Data.aspx.cs" Inherits="AnmolDristi.Line_Walk_Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5 style="color:green;">Line Walk</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 style="color:green;">Line Walk All Records</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <asp:GridView ID="View" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover table-responsive-md" OnRowCommand="View_RowCommand">

                                <HeaderStyle CssClass="thead-dark" />
                                <Columns>
                                    <asp:BoundField DataField="ID" HeaderText="Line Walk ID" ReadOnly="true" />
                                    <asp:BoundField DataField="WalkDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                                    <asp:BoundField DataField="JobDescription" HeaderText="JobDescription" />
                                    <asp:BoundField DataField="JobID" HeaderText="JobID" />

                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <div class="btn-group btn-group-sm" role="group">
                                                <asp:HyperLink ID="btnView" runat="server" CssClass="btn btn-info text-white m-2" NavigateUrl='<%# "View_LineWalk.aspx?id=" + Eval("ID") %>'>
                                                           <i class="fa fa-eye"></i> View </asp:HyperLink>

                                                <asp:HyperLink ID="btnEdit" runat="server" CssClass="btn btn-warning text-white m-2" NavigateUrl='<%# "~/Line_Walk.aspx?id=" + Eval("ID") %>'>     
                                                           <i class="fa fa-edit"></i> Edit</asp:HyperLink>

                                                <asp:LinkButton ID="btnDelete" runat="server"
                                                    CssClass="btn btn-danger text-white m-2"
                                                    CommandName="DeleteWalk"
                                                    CommandArgument='<%# Eval("ID") %>'
                                                    OnClientClick="return confirm('Are you sure you want to delete this Line Walk?');">
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

</asp:Content>
