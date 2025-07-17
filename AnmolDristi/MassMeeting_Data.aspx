<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="MassMeeting_Data.aspx.cs" Inherits="AnmolDristi.MassMeeting_Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="right_col" role="main">
     <div class="container">
         <div class="page-title">
             <div class="title_left">
                 <h5 style="text-align: center; font-weight: bold;" class="text-success">MASS MEETING ALL DATA</h5>
             </div>
         </div>

         <div class="clearfix"></div>

         <div class="row">
             <div class="col-md-12 col-sm-12  ">
                 <div class="x_panel">
                     <div class="x_title">
                         <h2 style="text-align: left; padding-left: 20px; font-weight: bold;" class="text-success">ATS/DOC/MM/0010 || REV 00 || EFFT DATE- 19/12/18</h2>
                         <ul class="nav navbar-right panel_toolbox">
                             <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                         </ul>
                         <div class="clearfix"></div>
                     </div>
                     <div class="x_content">


                         <asp:GridView ID="gridData" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover table-responsive-md" OnRowCommand="gridData_RowCommand" >
                             <HeaderStyle CssClass="thead-dark" />
                             <Columns>
                                 <asp:BoundField DataField="ID" HeaderText="Meeting ID" />
                                 <asp:BoundField DataField="Meeting_Date" HeaderText="Meeting Date" DataFormatString="{0:yyyy-MM-dd}" />
                                 <asp:BoundField DataField="RegionCode" HeaderText="Work Region" />
                                 <asp:BoundField DataField="DeptCode" HeaderText="Department" />
                                 <asp:BoundField DataField="LocationCode" HeaderText="Location" />

                                 <asp:TemplateField HeaderText="Actions">
                                     <ItemTemplate>
                                       <div class="btn-group btn-group-sm" role="group">
                                             <asp:HyperLink runat="server" CssClass="btn btn-info text-white m-2" NavigateUrl='<%# "~/View_Maasmeeting.aspx?id=" + Eval("ID") %>'>
                                                 <i class="fa fa-eye"></i> View</asp:HyperLink>
                                             <asp:HyperLink runat="server" CssClass="btn btn-warning text-white m-2" NavigateUrl='<%# "~/csm_massmeeting_record.aspx?id=" + Eval("ID") %>'>
                                                 <i class="fa fa-edit"></i> Edit</asp:HyperLink>
                                            <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-danger text-white m-2" CommandName="DeleteRow" CommandArgument='<%# Eval("ID") %>'
                                                    OnClientClick="return confirm('Are you sure you want to delete this record?');">
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
