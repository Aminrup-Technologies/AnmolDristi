<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="View_LineWalk.aspx.cs" Inherits="AnmolDristi.View_LineWalk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5 style="color:green;">Line Walk</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 style="color:green;">Line walk Details View </h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content" style="overflow:auto;">
                            <table class="table table-sm table-bordered" border="1">
                                <tr class="thead-dark">
                                    <th>Date</th>
                                    <th>Job ID</th>
                                    <th>Job Description</th>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label runat="server" ID="date" /></td>
                                    <td>
                                        <asp:Label runat="server" ID="jobid" /></td>
                                    <td>
                                        <asp:Label runat="server" ID="jobdesc" /></td>
                                </tr>
                            </table>

                            <asp:GridView ID="TeamMemberGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-responsive-md">
                                <HeaderStyle CssClass="thead-dark" />
                                <Columns>
                                    <asp:BoundField HeaderText="Employee Type" DataField="TM_Type" />
                                    <asp:BoundField HeaderText="Employee Code" DataField="TM_Code" />
                                    <asp:BoundField HeaderText="Employee Name" DataField="TM_names" />
                                </Columns>
                            </asp:GridView>

                            <asp:GridView ID="ObservGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-responsive-md">
                                <HeaderStyle CssClass="thead-dark" />
                                <Columns>
                                    <asp:BoundField HeaderText="Area" DataField="Location" />
                                    <asp:BoundField HeaderText="Observation" DataField="Observation_Points" />
                                    <asp:BoundField HeaderText="Recommendation" DataField="Recommendation_Points" />
                                    <asp:BoundField HeaderText="Responsibility" DataField="Responsibility" />
                                    <asp:BoundField HeaderText="TargetDate" DataField="Target_Date" />
                                    <asp:BoundField HeaderText="Remarks" DataField="Remarks" />
                                    <asp:TemplateField HeaderText="Snaps">
                                        <ItemTemplate>
                                            <asp:Image ID="imgSnap" runat="server"
                                                ImageUrl='<%# ResolveUrl("~/Uploads/" + Eval("Snap_File_Path")) %>'
                                                Width="100px" Height="100px" />
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
