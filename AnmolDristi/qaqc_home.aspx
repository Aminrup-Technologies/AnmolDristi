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
                <div class="col-md-6" id="QC_Panel" runat="server" visible="false">
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
                                    <asp:Label ID="lbl_csm_mm_form" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Mass Meeting Form

                            </a>

                            <a class="btn btn-app" href="MassMeeting_Report.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="lbl_csm_mm_report" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Mass Meeting Record

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
                                    <asp:Label ID="lbl_csm_hkp_form" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>House Keeping Form
                            </a>

                            <a class="btn btn-app" href="housekeeping_audit_report.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="lbl_csm_hkp_rpt" runat="server" Text="0" Visible="false"></asp:Label></span>
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
                                    <asp:Label ID="lbl_csm_cm_form" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Committee Meeting Form

                            </a>
                            <a class="btn btn-app" href="committee_meeting_report.aspx">
                                <span class="badge bg-green">Ok
                                    <asp:Label ID="lbl_csm_cm_rpt" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Committee Meeting Report
                            </a>
                        </div>
                        
                    </div>
                </div>
                               <div class="col-md-6" id="Div3" runat="server" visible="true">
                   <div class="x_panel">
                       <div class="x_title">
                           <h2>Full Body Harness Inspection</h2>
                           <ul class="nav navbar-right panel_toolbox">
                               <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                               </li>
                           </ul>
                           <div class="clearfix"></div>
                       </div>
                       <div class="x_content">
                           <a class="btn btn-app" href="FullBodyHarnessInspection.aspx">
                               <span class="badge bg-green">Ok
                                   <asp:Label ID="Label2" runat="server" Text="0" Visible="false"></asp:Label></span>
                               <i class="fa fa-edit"></i>FullBodyHarnessInspection Form

                           </a>
                           <a class="btn btn-app" href="FullBodyHarnessInspection_View.aspx">
                                     <span class="badge bg-green">Ok
                                          <asp:Label ID="Label1" runat="server" Text="0" Visible="false"></asp:Label></span>
                                           <i class="fa fa-edit"></i>FullBodyHarnessInspection View Form

                           </a>
                          
                       </div>
                        
                   </div>
               </div>

                                <div class="col-md-6" id="Div4" runat="server" visible="true">
    <div class="x_panel">
        <div class="x_title">
            <h2>Competency Assessment</h2>
            <ul class="nav navbar-right panel_toolbox">
                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                </li>
            </ul>
            <div class="clearfix"></div>
        </div>
        <div class="x_content">
            <a class="btn btn-app" href="WorkerCompetencyAssessment.aspx">
                <span class="badge bg-green">Ok
                    <asp:Label ID="Label3" runat="server" Text="0" Visible="false"></asp:Label></span>
                <i class="fa fa-edit"></i>Competency Assessment

            </a>
            <a class="btn btn-app" href="WorkerCompetencyView.aspx">
                      <span class="badge bg-green">Ok
                           <asp:Label ID="Label4" runat="server" Text="0" Visible="false"></asp:Label></span>
                            <i class="fa fa-edit"></i>Competency Assessment View

            </a>
           
        </div>
         
    </div>
</div>

    <div class="col-md-6" id="Div5" runat="server" visible="true">
    <div class="x_panel">
        <div class="x_title">
            <h2>Welding Machine Checklist</h2>
            <ul class="nav navbar-right panel_toolbox">
                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                </li>
            </ul>
            <div class="clearfix"></div>
        </div>
        <div class="x_content">
            <a class="btn btn-app" href="WeldingMachineChecklist.aspx">
                <span class="badge bg-green">Ok
                    <asp:Label ID="Label5" runat="server" Text="0" Visible="false"></asp:Label></span>
                <i class="fa fa-edit"></i>Welding Machine Checklist

            </a>   
            <a class="btn btn-app" href="WeldingChecklistView.aspx">
    <span class="badge bg-green">Ok
        <asp:Label ID="Label6" runat="server" Text="0" Visible="false"></asp:Label></span>
    <i class="fa fa-edit"></i>Welding Machine Checklist View

</a>   
        </div>
         
    </div>
</div>
                    <div class="col-md-6" id="Div6" runat="server" visible="true">
    <div class="x_panel">
        <div class="x_title">
            <h2>Fire Extinguisher Checklist</h2>
            <ul class="nav navbar-right panel_toolbox">
                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                </li>
            </ul>
            <div class="clearfix"></div>
        </div>
        <div class="x_content">
            <a class="btn btn-app" href="FireExtinguisherChecklist.aspx">
                <span class="badge bg-green">Ok
                    <asp:Label ID="Label7" runat="server" Text="0" Visible="false"></asp:Label></span>
                <i class="fa fa-edit"></i>Fire Extinguisher Checklist

            </a>   
            <a class="btn btn-app" href="FireExtinguisherChecklistView.aspx">
    <span class="badge bg-green">Ok
        <asp:Label ID="Label8" runat="server" Text="0" Visible="false"></asp:Label></span>
    <i class="fa fa-edit"></i>Fire Extinguisher View

</a>   
        </div>
         
    </div>
</div>
            </div>
        </div>
    </div>
</asp:Content>
