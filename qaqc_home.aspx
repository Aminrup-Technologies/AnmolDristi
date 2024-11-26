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
                <div class="col-md-12" id="QC_Panel" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>QC Forms</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="qaqc_inspector_rpt.aspx">
                                <span class="badge bg-red">Shift : 2
                                    <asp:Label ID="lbl_tbttodaycount" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Inspector Report

                            </a>
                            <%-- Laminate testing form--%>
                            <a class="btn btn-app" href="PM_LaminateTesting.aspx">
                                <span class="badge bg-red">Batch : 1
                                    <asp:Label ID="Label1" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Laminate Testing  
                            </a>
                            <a class="btn btn-app" href="PM_Laminate_Report.aspx">
                                <span class="badge bg-orange">Consignment : 1
                                    <asp:Label ID="Label2" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Laminate Testing report
                            </a>

                            <a class="btn btn-app" href="PM_Laminate_Approval.aspx">
                                <span class="badge bg-orange">Consignment : 1
                                    <asp:Label ID="Label6" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Laminate Testing Approval
                            </a>

                            <%--RM Class 1 Form--%>
                            <a class="btn btn-app" href="RM_Class_1.aspx">
                                <span class="badge bg-orange">Consignment : 1
                                    <asp:Label ID="Label8" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM CLASS-1
                            </a>
                            <a class="btn btn-app" href="RM_Class_1_Report.aspx">
                                <span class="badge bg-orange">Consignment : 1
                                    <asp:Label ID="Label9" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class-1 report
                            </a>
                            <a class="btn btn-app" href="RM_Class_1_Approval.aspx">
                                <span class="badge bg-orange">Consignment : 1
                                    <asp:Label ID="Label10" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class-1 Approval
                            </a>
                            <%--RM Class 3 Form--%>
                            <a class="btn btn-app" href="RM_Class_3.aspx">
                                <span class="badge bg-orange">Consignment : 1
                                    <asp:Label ID="Label11" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM CLASS-3
                            </a>
                            <a class="btn btn-app" href="RM_Class_3_Report.aspx">
                                <span class="badge bg-orange">Consignment : 1
                                    <asp:Label ID="Label12" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class-3 report
                            </a>
                            <a class="btn btn-app" href="RM_Class_3_Approval.aspx">
                                <span class="badge bg-orange">Consignment : 1
                                    <asp:Label ID="Label13" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class-3 Approval
                            </a>
                            <%--RM Class 4 Form--%>
                            <a class="btn btn-app" href="RM_Class_4.aspx">
                                <span class="badge bg-orange">Consignment : 1
                                    <asp:Label ID="Label14" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM CLASS-4
                            </a>
                            <a class="btn btn-app" href="RM_Class_4_Report.aspx">
                                <span class="badge bg-orange">Consignment : 1
                                         <asp:Label ID="Label15" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class-4 report
                            </a>
                            <a class="btn btn-app" href="RM_Class_4_Approval.aspx">
                                <span class="badge bg-orange">Consignment : 1
                                    <asp:Label ID="Label16" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>RM Class-4 Approval
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-md-12" id="Div1" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>QA Forms</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <%--Process Checking Form--%>
                            <a class="btn btn-app" href="qaqc_process_rpt.aspx">
                                <span class="badge bg-red">Shift : 1
                                    <asp:Label ID="Label3" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Process Checking

                            </a>
                            <a class="btn btn-app" href="Process_Report.aspx">
                                <span class="badge bg-red">Shift : 1
                                    <asp:Label ID="Label4" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Process Checking Report

                            </a>
                            <a class="btn btn-app" href="Process_Approval.aspx">
                                <span class="badge bg-red">Shift : 1
                                    <asp:Label ID="Label5" runat="server" Text="0" Visible="false"></asp:Label></span>
                                <i class="fa fa-edit"></i>Process Checking Approval

                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-md-12" id="Div2" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Other Forms</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <a class="btn btn-app" href="New_User.aspx">
                                <asp:Label ID="Label7" runat="server" Text="0" Visible="false"></asp:Label>
                                <i class="fa fa-edit"></i>New User 
                            </a>

                            <a class="btn btn-app" href="Form_Master.aspx">
                                <asp:Label ID="Label17" runat="server" Text="0" Visible="false"></asp:Label>
                                <i class="fa fa-edit"></i>Form Master
                            </a>

                            <a class="btn btn-app" href="Form_Approval_Matrix.aspx">
                                <asp:Label ID="Label18" runat="server" Text="0" Visible="false"></asp:Label>
                                <i class="fa fa-edit"></i>Form Approval Matrix
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-md-12" id="Div3" runat="server" visible="true">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Store Module</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                </li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            
                            <a class="btn btn-app" href="Material_Master.aspx">
                                <asp:Label ID="Label27" runat="server" Text="0" Visible="false"></asp:Label>
                                <i class="fa fa-edit"></i>Material Master 
                            </a>

                            <a class="btn btn-app" href="Material_MasterView.aspx">
                                <asp:Label ID="Label28" runat="server" Text="0" Visible="false"></asp:Label>
                                <i class="fa fa-edit"></i>Material Master View 
                            </a>

                            <a class="btn btn-app" href="str_masters.aspx">
                                <asp:Label ID="Label29" runat="server" Text="0" Visible="false"></asp:Label>
                                <i class="fa fa-edit"></i>Store Master 
                            </a>
                            <a class="btn btn-app" href="str_add_cstores.aspx">
                                <asp:Label ID="Label30" runat="server" Text="0" Visible="false"></asp:Label>
                                <i class="fa fa-edit"></i>Add Central Store
                            </a>
                            <a class="btn btn-app" href="str_add_warehouse.aspx">
                                <asp:Label ID="Label31" runat="server" Text="0" Visible="false"></asp:Label>
                                <i class="fa fa-edit"></i>Add Warehouse 
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
