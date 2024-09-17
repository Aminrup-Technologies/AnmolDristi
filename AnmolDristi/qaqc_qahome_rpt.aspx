<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_qahome_rpt.aspx.cs" Inherits="AnmolDristi.qaqc_qahome_rpt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="row">
                <div class="col-md-12" id="Div1" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Quality Assurance Online Reports</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="Process_Report.aspx">
                                <span class="badge bg-green">
                                    <asp:Label ID="Label3" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>Process Checking
                            </a>
                            <a class="btn btn-app" href="FinalCbbWtVM.aspx">
                                <span class="badge bg-green">
                                    <asp:Label ID="Label4" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>Final CBB Weight
                            </a>
                            <a class="btn btn-app" href="qaqc_rotaryline_view.aspx" >
                                <span class="badge bg-green">
                                    <asp:Label ID="Label5" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>Line Weight
                            </a>
                            <a class="btn btn-app" href="vm_ccp_checklist.aspx" >
                                <span class="badge bg-green">
                                    <asp:Label ID="Label1" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>CCP Checklist
                            </a>
                            <a class="btn btn-app" href="qaqc_oven_viewpage.aspx" >
                                <span class="badge bg-green">
                                    <asp:Label ID="Label2" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>Oven Report
                            </a>

                            <a class="btn btn-app" href="vm_leak_test.aspx" >
                                <span class="badge bg-green">
                                    <asp:Label ID="Label6" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>Leak/ Slanted
                            </a>

                            <a class="btn btn-app" href="preDispatchVM.aspx" >
                                <span class="badge bg-green">
                                    <asp:Label ID="Label7" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>Pre-Dispatch
                            </a>
                            <a class="btn btn-app" href="#" >
                                <span class="badge bg-green">
                                    <asp:Label ID="Label8" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>Critical Incident
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
