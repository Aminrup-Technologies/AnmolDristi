<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Gas_Cutting_View.aspx.cs" Inherits="AnmolDristi.Gas_Cutting_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-label {
            font-weight: bold;
            color: blue;
            display: block;
            margin-bottom: 5px;
        }

        .table-container {
            margin-top: 20px;
        }

        .btn-actions {
            margin-right: 5px;
            width: 70px;
            height: 35px;
            padding: 5px 10px;
            text-align: center;
            display: inline-block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Gas Cutting Checklist Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored Gas Cutting Checklist Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div style="overflow-x: auto;">
    
                <asp:GridView ID="GvGasCuttingChecklist" runat="server" CssClass="table table-striped table-bordered"
    AutoGenerateColumns="False" DataKeyNames="HeaderID"
    OnRowEditing="GvGasCuttingChecklist_RowEditing"
    OnRowUpdating="GvGasCuttingChecklist_RowUpdating"
    OnRowCancelingEdit="GvGasCuttingChecklist_RowCancelingEdit"
    OnRowDeleting="GvGasCuttingChecklist_RowDeleting">

    <Columns>

        <asp:TemplateField HeaderText="Site">
            <ItemTemplate>
                <%# Eval("SiteName") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtSiteName" runat="server" Text='<%# Bind("SiteName") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Date of Inspection">
            <ItemTemplate>
                <%# Eval("InspectionDate", "{0:yyyy-MM-dd}") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtInspectionDate" runat="server" Text='<%# Bind("InspectionDate", "{0:yyyy-MM-dd}") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Tag No">
            <ItemTemplate>
                <%# Eval("TagNo") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtTagNo" runat="server" Text='<%# Bind("TagNo") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Checklist Question">
            <ItemTemplate>
                <%# Eval("ChecklistQuestion") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtChecklistQuestion" runat="server" Text='<%# Bind("ChecklistQuestion") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Is Yes">
            <ItemTemplate>
                <%# Eval("IsYes") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtIsYes" runat="server" Text='<%# Bind("IsYes") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Remarks">
            <ItemTemplate>
                <%# Eval("Remarks") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtRemarks" runat="server" Text='<%# Bind("Remarks") %>' />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Photo Path">
            <ItemTemplate>
                <%# Eval("PhotoPath") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtPhotoPath" runat="server" Text='<%# Bind("PhotoPath") %>' />
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Final Remarks">
    <ItemTemplate>
        <%# Eval("FinalRemarks") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtFinalRemarks" runat="server" Text='<%# Bind("FinalRemarks") %>' />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Job ID">
    <ItemTemplate>
        <%# Eval("JobId") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtJobId" runat="server" Text='<%# Bind("JobId") %>' />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Gas Cutter Name">
    <ItemTemplate>
        <%# Eval("GasCutterName") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtGasCutterName" runat="server" Text='<%# Bind("GasCutterName") %>' />
    </EditItemTemplate>
</asp:TemplateField>

       

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

               <%-- <div class="x_content table-container">
                    <div style="overflow-x: auto;">
                        <asp:GridView ID="GvGasCuttingChecklist" runat="server" CssClass="table table-striped table-bordered"
                            AutoGenerateColumns="False" DataKeyNames="HeaderID"
                            OnRowEditing="GvGasCuttingChecklist_RowEditing"
                            OnRowUpdating="GvGasCuttingChecklist_RowUpdating"
                            OnRowCancelingEdit="GvGasCuttingChecklist_RowCancelingEdit"
                            OnRowDeleting="GvGasCuttingChecklist_RowDeleting">

                            <Columns>
                                <asp:BoundField DataField="SiteName" HeaderText="Site" />
                                <asp:BoundField DataField="InspectionDate" HeaderText="Date of Inspection" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:BoundField DataField="TagNo" HeaderText="Tag No" />
                                <asp:BoundField DataField="ChecklistQuestion" HeaderText="Checklist Question" />
                                <asp:BoundField DataField="IsYes" HeaderText="Is Yes" />
                                <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                <asp:BoundField DataField="PhotoPath" HeaderText="Photo Path" />
                                <asp:BoundField DataField="SubmittedDate" HeaderText="Submitted Date" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:BoundField DataField="SubmittedTime" HeaderText="Submitted Time" DataFormatString="{0:hh\\:mm\\:ss}" />

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
                        </asp:GridView>--%>
                    </div>
                </div>
            </div>
    </div>
        
    
</asp:Content>
