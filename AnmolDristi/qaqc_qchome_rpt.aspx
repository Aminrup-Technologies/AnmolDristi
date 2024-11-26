<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_qchome_rpt.aspx.cs" Inherits="AnmolDristi.qaqc_qchome_rpt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <%--<div class="page-title">
                <div class="title_left">
                    <h2>Quality AssuranceReport Forms</h2>
                </div>
            </div>

            <div class="clearfix"></div>--%>

            <div class="row">

                <div class="col-md-12" id="QC_Panel" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Quality Control Online Reports</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="qaqc_qcinspector_rpt_.aspx">
                                <span class="badge bg-green">
                                    <asp:Label ID="lbl_qcinspector_rpt_count" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>Inspector Report

                            </a>
                            <a class="btn btn-app" href="#">
                                <span class="badge bg-red">
                                    <asp:Label ID="Label1" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>Wheat Flour report

                            </a>
                            <a class="btn btn-app" href="#">
                                <span class="badge bg-red">
                                    <asp:Label ID="Label2" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>CB Box Report

                            </a>
                             <a class="btn btn-app" href="Critical_Incident_ViewPage.aspx">
                                <span class="badge bg-green">
                                    <asp:Label ID="Label3" runat="server" Text="0" Visible="true"></asp:Label></span>
                                <i class="fa fa-edit"></i>Critical Incident Report

                            </a>
                        </div>
                    </div>
                </div>

                

            </div>
        </div>
    </div>
</asp:Content>
