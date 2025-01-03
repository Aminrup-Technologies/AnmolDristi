<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_qcapprovals.aspx.cs" Inherits="AnmolDristi.qaqc_qcapprovals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="row">
                <div class="col-md-12" id="QC_Panel" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Quality Control Approvals</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="app_qc_inspectorreport.aspx">
                                <span class="badge bg-green">Shift-2
                                    <asp:Label ID="lbl_tbttodaycount" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Inspector Report

                            </a>
                            <a class="btn btn-app" href="#">
                                <span class="badge bg-warning">Batch-1
                                    <asp:Label ID="Label1" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Wheat Flour report

                            </a>
                            <a class="btn btn-app" href="PM_Laminate_Approval.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label6" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Daily Laminate

                            </a>
                            <a class="btn btn-app" href="overwrap_approval.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label8" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>HM /PP Bag

                            </a>

                            <a class="btn btn-app" href="bopp_tape_approval.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label7" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Bopp Tape

                            </a>
                            <a class="btn btn-app" href="CorrugatedBoardBox_Approval.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label2" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>CB Box Report

                            </a>

                            <a class="btn btn-app" href="RM_Class_1_Approval.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label3" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class 1

                            </a>
                            <a class="btn btn-app" href="RM_Class_3_Approval.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label4" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class 3

                            </a>
                            <a class="btn btn-app" href="RM_Class_4_Approval.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label5" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class 4

                            </a>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
