<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Award_Distribution_View.aspx.cs" Inherits="AnmolDristi.Award_Distribution_View" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-container {
            margin-top: 20px;
        }
        .btn-actions {
            margin-right: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <h3>Award Distribution Records</h3>
            
            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored Awards</h2>
                    <div class="clearfix"></div>
                </div>


                <div class="x_content table-container">
                    <div style="overflow-x: auto;">
                    <asp:GridView ID="GvAwards" runat="server" CssClass="table table-bordered"
                        AutoGenerateColumns="False" DataKeyNames="ADR_ID"
                        OnRowEditing="GvAwards_RowEditing"
                        OnRowUpdating="GvAwards_RowUpdating"
                        OnRowCancelingEdit="GvAwards_RowCancelingEdit"
                        OnRowDeleting="GvAwards_RowDeleting">

                        <Columns>

                            <asp:TemplateField HeaderText="Award Date">
                                <ItemTemplate><%# Eval("DateOfAwardDistribution", "{0:yyyy-MM-dd}") %></ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Event">
                                <ItemTemplate><%# Eval("EventName") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEventName" runat="server" Text='<%# Bind("EventName") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Employee ID">
                                <ItemTemplate><%# Eval("EmpId") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEmpId" runat="server" Text='<%# Bind("EmpId") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Employee Name">
                                <ItemTemplate><%# Eval("EmpName") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEmpName" runat="server" Text='<%# Bind("EmpName") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Designation">
                                <ItemTemplate><%# Eval("Designation") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDesignation" runat="server" Text='<%# Bind("Designation") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Award ID">
                                <ItemTemplate><%# Eval("Award_ID") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtAward_ID" runat="server" Text='<%# Bind("Award_ID") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Submission Date">
                                <ItemTemplate><%# Eval("SubmittedDate", "{0:yyyy-MM-dd}") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSubmittedDate" runat="server" Text='<%# Bind("SubmittedDate", "{0:yyyy-MM-dd}") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Submission Time">
                                <ItemTemplate><%# Eval("SubmittedTime") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSubmittedTime" runat="server" Text='<%# Bind("SubmittedTime") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Image Path">
                                <ItemTemplate><%# Eval("ImagePath") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtImagePath" runat="server" Text='<%# Bind("ImagePath") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                           <asp:TemplateField HeaderText="Actions">
    <ItemTemplate>
       <asp:HyperLink ID="btnView" runat="server" CssClass="btn btn-info btn-actions"
    NavigateUrl='<%# Eval("ADR_ID", "Award_report.aspx?id={0}") %>'>
    View
</asp:HyperLink>

        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning btn-actions" CommandName="Edit">Edit</asp:LinkButton>
        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-actions" CommandName="Delete"
            OnClientClick="return confirm('Are you sure?');">Delete</asp:LinkButton>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-actions" CommandName="Update">Update</asp:LinkButton>
        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary btn-actions" CommandName="Cancel">Cancel</asp:LinkButton>
    </EditItemTemplate>
</asp:TemplateField>


                        </Columns>
                    </asp:GridView>
                </div>
                    </div>
            </div>
        </div>
    </div>
</asp:Content>



               <%-- <div class="x_content table-container">
                    <asp:GridView ID="GvAwards" runat="server" CssClass="table table-bordered"
                        AutoGenerateColumns="False" DataKeyNames="ADR_ID"
                        OnRowEditing="GvAwards_RowEditing"
                        OnRowUpdating="GvAwards_RowUpdating"
                        OnRowCancelingEdit="GvAwards_RowCancelingEdit"
                        OnRowDeleting="GvAwards_RowDeleting">

                        <Columns>
                            <asp:BoundField DataField="DateOfAwardDistribution" HeaderText="Award Date" SortExpression="DateOfAwardDistribution" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="EventName" HeaderText="Event" SortExpression="EventName" />
                            <asp:BoundField DataField="EmpId" HeaderText="Employee ID" SortExpression="EmpId" />
                            <asp:BoundField DataField="EmpName" HeaderText="Employee Name" SortExpression="EmpName" />
                            <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
                            <asp:BoundField DataField="Award_ID" HeaderText="Award ID" SortExpression="Award_ID" />
                            <asp:BoundField DataField="SubmittedDate" HeaderText="Submission Date" SortExpression="SubmittedDate" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="SubmittedTime" HeaderText="Submission Time" SortExpression="SubmittedTime" />
                            <asp:BoundField DataField="ImagePath" HeaderText="Image Path" SortExpression="ImagePath" />

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning btn-actions" CommandName="Edit">Edit</asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-actions" CommandName="Delete" OnClientClick="return confirm('Are you sure?');">Delete</asp:LinkButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-actions" CommandName="Update">Update</asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary btn-actions" CommandName="Cancel">Cancel</asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>
