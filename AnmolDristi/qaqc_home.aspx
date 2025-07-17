<%@ Page Title="CSM Home" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_home.aspx.cs" Inherits="AnmolDristi.qaqc.qaqc_home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="">
            <div class="page-title">
                <div class="title_left">
                    <h2>CSM Documentation Forms</h2>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-6" id="QC_Panel" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Five S Report</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">
                            <a class="btn btn-app" href="fiveS_checklist_1.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label1" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Create
                            </a>

                            <a class="btn btn-app" href="fiveS_checklist_2.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="lbl_tbttodaycount" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>View
                            </a>

                        </div>

                    </div>
                </div>



                <div class="col-md-6" id="Div1" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Line Walk</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">
                            <a class="btn btn-app" href="Line_Walk.aspx">
                                <span class="badge bg-green">Ok
                        <asp:Label ID="Label2" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Create
                            </a>

                            <a class="btn btn-app" href="Line_Walk_Data.aspx">
                                <span class="badge bg-green">Ok
         <asp:Label ID="Label3" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>View
                            </a>

                        </div>
                    </div>
                </div>
            </div>
        


        <div class="row">
            <div class="col-md-6" id="Div2" runat="server" visible="true">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>Lifting Belt and Wire Rope Sling Checklist</h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                            </li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>

                    <div class="x_content">
                        <a class="btn btn-app" href="Lifting_Belt.aspx">
                            <span class="badge bg-green">Ok
                        <asp:Label ID="Label4" runat="server" Text="0" Visible="false"></asp:Label></span>
                            <i class="fa fa-edit"></i>Create
                        </a>

                        <a class="btn btn-app" href="Lifting_BeltData.aspx">
                            <span class="badge bg-green">Ok
         <asp:Label ID="Label5" runat="server" Text="0" Visible="false"></asp:Label></span>
                            <i class="fa fa-edit"></i>View
                        </a>

                    </div>
                </div></div>


                <div class="col-md-6" id="Div3" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Maas Meeting</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">
                            <a class="btn btn-app" href="csm_massmeeting_record.aspx">
                                <span class="badge bg-green">Ok
               <asp:Label ID="Label6" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Create
                            </a>

                            <a class="btn btn-app" href="MassMeeting_Data.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="Label7" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>View
                            </a>

                        </div>
                    </div>
               </div>
           
            </div>

            <div class="row">
                   <div class="col-md-6" id="Div4" runat="server" visible="true">
                       <div class="x_panel">
                           <div class="x_title">
                               <h2>Quick JCC Checklist</h2>
                               <ul class="nav navbar-right panel_toolbox">
                                   <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                   </li>
                               </ul>
                               <div class="clearfix"></div>
                           </div>

                           <div class="x_content">
                               <a class="btn btn-app" href="QuickJCC_Checklist.aspx">
                                   <span class="badge bg-green">Ok
                               <asp:Label ID="Label8" runat="server" Text="0" Visible="false"></asp:Label></span>
                                   <i class="fa fa-edit"></i>Create
                               </a>

                               <a class="btn btn-app" href="Quick_JCCData.aspx">
                                   <span class="badge bg-green">Ok
                <asp:Label ID="Label9" runat="server" Text="0" Visible="false"></asp:Label></span>
                                   <i class="fa fa-edit"></i>View
                               </a>

                           </div>
                </div>


        </div></div>
</asp:Content>
