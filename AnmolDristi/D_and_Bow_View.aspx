<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="D_and_Bow_View.aspx.cs" Inherits="AnmolDristi.D_and_Bow_View" %>
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
                    <h3>D and Bow Checklist Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>D and Bow Checklist Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <div style="overflow-x: auto;">
                     <asp:GridView ID="GvDandBowChecklist" runat="server" CssClass="table table-striped table-bordered"
    AutoGenerateColumns="False" DataKeyNames="BasicID" OnRowEditing="GvDandBowChecklist_RowEditing"
    OnRowUpdating="GvDandBowChecklist_RowUpdating" OnRowCancelingEdit="GvDandBowChecklist_RowCancelingEdit"
    OnRowDeleting="GvDandBowChecklist_RowDeleting">
    <Columns>
        <asp:BoundField DataField="Site" HeaderText="Site" />
        <asp:BoundField DataField="TagNo" HeaderText="Tag No" />
        <asp:BoundField DataField="InspectionDate" HeaderText="Inspection Date" DataFormatString="{0:yyyy-MM-dd}" />

        <asp:BoundField DataField="ShacklesChecklistQuestion" HeaderText="Shackles Question" />
        <asp:BoundField DataField="ShacklesIsYes" HeaderText="Shackles Is Yes" />
        <asp:BoundField DataField="ShacklesRemarks" HeaderText="Shackles Remarks" />
        <asp:BoundField DataField="ShacklesPhotoPath" HeaderText="Shackles Photo" />

        <asp:BoundField DataField="ChainPulleyChecklistQuestion" HeaderText="Chain Pulley Question" />
        <asp:BoundField DataField="ChainPulleyIsYes" HeaderText="Chain Pulley Is Yes" />
        <asp:BoundField DataField="ChainPulleyRemarks" HeaderText="Chain Pulley Remarks" />
        <asp:BoundField DataField="ChainPulleyPhotoPath" HeaderText="Chain Pulley Photo" />

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
    </div>
</asp:Content>
