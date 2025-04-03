<%@ Page Title="CSMS" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_home.aspx.cs" Inherits="AnmolDristi.qaqc.qaqc_home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h2>CSMS Documentation</h2>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-6" id="QC_Panel" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Mass Meeting</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="csm_massmeeting_record.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label3" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Mass Meeting Form

                            </a>
<<<<<<< HEAD
                            <a class="btn btn-app" href="MassMeeting_Report.aspx">
    <span class="badge bg-green">Ok
        <asp:Label ID="Label6" runat="server" Text="0" Visible="false"></asp:Label></span>
    <i class="fa fa-edit"></i>Mass Meeting Record View

</a>
                            <a class="btn btn-app" href="housekeeping_audit.aspx">
                                <span class="badge bg-green">Ok
                        <asp:Label ID="Label4" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>House Keeping Audit

                            </a>
                                <a class="btn btn-app" href="housekeeping_audit_report.aspx">
        <span class="badge bg-green">Ok
<asp:Label ID="Label2" runat="server" Text="0" Visible="false"></asp:Label></span>
        <i class="fa fa-edit"></i>HouseKeeping Audit View

    </a>
                            <a class="btn btn-app" href="committee_meeting.aspx">
                                <span class="badge bg-green">Ok
                              <asp:Label ID="Label5" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Committee Meeting

                            </a>
                            <a class="btn btn-app" href="committee_meeting_report.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label1" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Committee Meeting View
=======

                            <a class="btn btn-app" href="csm_massmeeting_report.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label1" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Mass Meeting Record
>>>>>>> ba71f0ce6a700e574fc9e1f92dfd8f78f078ba9c

                            </a>
                             <a class="btn btn-app" href="practice.aspx">
     <span class="badge bg-green">Ok
         <asp:Label ID="Label7" runat="server" Text="0" Visible="false"></asp:Label></span>
     <i class="fa fa-edit"></i>practice

 </a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6" id="Div1" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Housekeeping Audit</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="housekeeping_audit.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label6" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>House Keeping Form
                            </a>

                            <a class="btn btn-app" href="housekeeping_audit_report.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label2" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>House Keeping Records
                            </a>

                        </div>
                    </div>
                </div>

                <div class="col-md-6" id="Div2" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Safety Committee Meeting</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="committee_meeting.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label4" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Committee Meeting Form

                            </a>
                            <a class="btn btn-app" href="committee_meeting_report.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label5" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Committee Meeting Records

                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
