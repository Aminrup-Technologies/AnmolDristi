<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_home.aspx.cs" Inherits="AnmolDristi.qaqc.qaqc_home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h2>Quality Report Forms</h2>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-6" id="Div1" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>CSM : Incident Analysis</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <a class="btn btn-app" href="incident_analysis.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label6" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Incident Analysis

                            </a>
                            <a class="btn btn-app" href="incident_View.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label3" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Incident Records

                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6" id="Div2" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>CSM : KYT Report</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="KYT.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label2" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>KYT Report
                            </a>
                            <a class="btn btn-app" href="KYT_View.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label1" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>KYT Records
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6" id="Div3" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>CSM : Safety Audit Report</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="Safety_audit.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label4" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Safety Audit Form
                            </a>
                            <a class="btn btn-app" href="Safety_View.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label5" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Safety Audit Records
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6" id="Div4" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>CSM : Grinding Machine Checklist</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="Grinding_Machine_Checklist.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label7" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Grinding Machine Checklist
                            </a>
                            <a class="btn btn-app" href="Grinding_Machine_View.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label8" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Grinding Machine Records
                            </a>
                        </div>
                    </div>
                </div>

                
                <div class="col-md-6" id="Div5" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>CSM : Award Distribution</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="Award_Distribution.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label9" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Award Distribution Form
                            </a>
                            <a class="btn btn-app" href="Award_Distribution_View.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label10" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Award Distribution Report
                            </a>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
</asp:Content>
