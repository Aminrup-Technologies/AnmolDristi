<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Line_Walk_Data.aspx.cs" Inherits="AnmolDristi.Line_Walk_Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left" style="text-align: center;">
                     <asp:Label ID="Label1" runat="server" CssClass="h5 text-center font-weight-bold text-success" Text="LINE WALK ALL RECORDS"></asp:Label>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title" >
                            <asp:Label ID="heading" runat="server" CssClass="h5 text-center font-weight-bold text-success" Text="DOC: DOC/ATS/TSK/QMS/GC/013 REV : 00 ,EFT DATE : 01/02/2024"></asp:Label>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">






                            <div class="card shadow-sm mb-4">
                                <div class="card-body">
                                    <h5 class="card-title mb-3 text-dark">
                                        <i class="fa fa-filter text-primary"></i> Filter Line Walks Data
                                    </h5>
                                    <div class="form-row">
                                        <div class="form-group col-md-3">
                                            <asp:Label for="ddlStatus" runat="server" ForeColor="Blue"><i class="fa fa-tasks mr-1"></i>Status</asp:Label>
                                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control form-control-sm rounded">
                                                <asp:ListItem Text="All" Value=""></asp:ListItem>
                                                <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
                                                <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                                <asp:ListItem Text="In Processing" Value="In Processing"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>

                                        <div class="form-group col-md-3">
                                            <asp:Label for="txtFromDate" runat="server" ForeColor="Blue"><i class="fa fa-calendar-alt mr-1"></i>From</asp:Label>
                                            <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" CssClass="form-control form-control-sm rounded" />
                                        </div>

                                        <div class="form-group col-md-3">
                                            <asp:Label for="txtToDate" runat="server" ForeColor="Blue"><i class="fa fa-calendar-check mr-1"></i>To</asp:Label>
                                            <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" CssClass="form-control form-control-sm rounded" />
                                        </div>

                                        <div class="form-group col-md-3 d-flex align-items-end">
                                            <asp:Button ID="btnFilter" runat="server" Text="Apply Filter"
                                                CssClass="btn btn-primary me-2 w-50" OnClick="btnFilter_Click" />
                                            <asp:Button ID="btnReset" runat="server" Text="Reset"
                                                CssClass="btn btn-secondary w-50" OnClick="btnReset_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>








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
