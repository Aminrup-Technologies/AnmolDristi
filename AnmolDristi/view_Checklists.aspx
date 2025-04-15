<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="view_Checklists.aspx.cs" Inherits="AnmolDristi.viewChecklists" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%--    <style >
         table {
     width: 100%;
     margin: 0px;
     padding: 0px;
     border-collapse: collapse;
     font-family: "Roboto", sans-serif;
     font-size: 14px;
     font-weight: normal;
     color: #000;
     border: none;
 }

     table tr td {
         padding: 0;
         vertical-align: top;
     }
    </style>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5>Main Heading</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Sub Heading</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <table class="table table-sm table-bordered">
                                <thead >
                                    <tr>
                                        <th>Requirement</th>
                                        <th>OK/Not OK</th>
                                        <th>Remarks</th>
                                        <th>Photo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="ParentRepeter" runat="server">
                                        <HeaderTemplate>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td colspan="4">
                                                    <asp:Label runat="server" ID="groupname" Font-Bold="true" Text='<%# Eval("GroupName") %>' /></td>
                                            </tr>
                                            <asp:Repeater ID="RepeaterChecklist" runat="server" DataSource='<%# Eval("Keys")%>' OnItemDataBound="RepeaterChecklist_ItemDataBound">

                                                <ItemTemplate>
                                                    <tr>

                                                        <td><%# Eval("Requirements") %></td>
                                                        <td>
                                                            <asp:Label runat="server" ID="oknotok" Text='<%# Convert.ToBoolean(Eval("Result")) ? "OK" : "NOT OK" %>' /></td>
                                                        <td><%# Eval("Remark") %></td>
                                                        <td>
                                                            <asp:Image ID="imgPhoto" runat="server" ImageUrl='<%# Eval("Before_photo") %>' Width="100" />
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
