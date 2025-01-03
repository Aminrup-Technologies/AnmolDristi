<%@ Page Title="QAQC | QC Forms" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_qchome.aspx.cs" Inherits="AnmolDristi.qaqc_qchome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="row">
                <div class="col-md-12" id="QC_Panel" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Quality Control Online Forms</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <a class="btn btn-app" href="PM_LaminateTesting.aspx">
                                <span class="badge bg-green">OK
                                    <asp:Label ID="Label1" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Daily Laminate

                            </a>

                            <a class="btn btn-app" href="qaqc_overwrap.aspx">
                                <span class="badge bg-green">OK
                                    <asp:Label ID="Label2" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>HM / PP Bag
                            </a>

                            <a class="btn btn-app" href="CorrugatedBoardBoxReport.aspx">
                                <span class="badge bg-green">OK
                                    <asp:Label ID="Label3" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>CBB Report
                            </a>

                            <a class="btn btn-app" href="bopp_tape.aspx">
                                <span class="badge bg-green">OK
                                    <asp:Label ID="Label4" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>BOPP Tape
                            </a>

                            <a class="btn btn-app" href="PVC_Tray.aspx">
                                <span class="badge bg-green">OK
                                    <asp:Label ID="Label5" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>PVC Tray
                            </a>

                            <a class="btn btn-app" href="RM_Class_1.aspx">
                                <span class="badge bg-green">OK
                                    <asp:Label ID="Label6" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class 1
                            </a>

                            <a class="btn btn-app" href="RM_Class_3.aspx">
                                <span class="badge bg-green">OK
                                    <asp:Label ID="Label7" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class 3
                            </a>

                            <a class="btn btn-app" href="RM_Class_4.aspx">
                                <span class="badge bg-green">OK
                                    <asp:Label ID="Label8" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class 4
                            </a>

                            <a class="btn btn-app" href="Aata_Maida_Form.aspx">
                                <span class="badge bg-green">OK
                                    <asp:Label ID="Label9" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Aata+Maida
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
