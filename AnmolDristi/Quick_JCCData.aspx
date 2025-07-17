<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Quick_JCCData.aspx.cs" Inherits="AnmolDristi.Quick_JCCData" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="right_col" role="main">
     <div class="container">
         <div class="page-title">
             <div class="title_left" style="text-align: center;">
                 <asp:Label ID="heading" runat="server" CssClass="h5 text-center font-weight-bold text-success" Text="QUICK JCC"></asp:Label>
             </div>
         </div>

         <div class="clearfix"></div>

         <div class="row">
             <div class="col-md-12 col-sm-12  ">
                 <div class="x_panel">
                     <div class="x_title">
                         <h2 style="text-align: left; padding-left: 20px; font-weight: bold;" class="text-success">DOC/ATS/Q-JCC/MM(TSK) REV : 00 ,EFT DATE : 01/01/2025</h2>
                         <ul class="nav navbar-right panel_toolbox">
                             <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                         </ul>
                         <div class="clearfix"></div>
                     </div>
                     <div class="x_content">


                         <asp:GridView ID="GridViewChecklists" runat="server" AutoGenerateColumns="False"
                            DataKeyNames="ID" CssClass="table table-bordered table-hover table-responsive-md" OnRowCommand="GridViewChecklists_RowCommand">
                            <HeaderStyle CssClass="thead-dark" />
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="true" />
                                <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:BoundField DataField="JobID" HeaderText="JobID" />
                                <asp:BoundField DataField="Department" HeaderText="Department" />
                                <asp:BoundField DataField="Location" HeaderText="Location" />

                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <div class="btn-group btn-group-sm" role="group">
                                            <asp:HyperLink ID="btnView" runat="server" CssClass="btn btn-info text-white m-2" NavigateUrl='<%# "View_QJCC.aspx?id=" + Eval("ID") %>' >
                                                <i class="fa fa-eye"></i> View
                                            </asp:HyperLink>
                                            <asp:HyperLink ID="btnEdit" runat="server"
                                                CssClass="btn btn-warning text-white m-2" NavigateUrl='<%# "~/QuickJCC_Checklist.aspx?id=" + Eval("ID") %>'>
                                                   <i class="fa fa-edit"></i> Edit
                                            </asp:HyperLink>
                                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteChecklist"
                                                CommandArgument='<%# Eval("ID") %>' CssClass="btn btn-danger text-white m-2"
                                                OnClientClick="return confirm('Are you sure you want to delete this checklist?');">
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
