<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Grinding_Machine_View.aspx.cs" Inherits="AnmolDristi.Grinding_Machine_View" %>


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
                    <h3>Grinding Machine Checklist Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored Grinding Machine Checklist Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <asp:GridView ID="GvGrindingMachineChecklist" runat="server" CssClass="table table-striped table-bordered"
                        AutoGenerateColumns="False" DataKeyNames="HeaderID" OnRowEditing="GvGrindingMachineChecklist_RowEditing"
                        OnRowUpdating="GvGrindingMachineChecklist_RowUpdating" OnRowCancelingEdit="GvGrindingMachineChecklist_RowCancelingEdit"
                        OnRowDeleting="GvGrindingMachineChecklist_RowDeleting">

                        <Columns>
                            <asp:BoundField DataField="Site" HeaderText="Site" />
                            <asp:BoundField DataField="DateOfInspection" HeaderText="Date of Inspection" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="InspectedBy" HeaderText="Inspected By" />
                            <asp:BoundField DataField="SerialNo" HeaderText="Serial No" />
                            <asp:BoundField DataField="IdentificationNumber" HeaderText="Identification No" />
                            <asp:BoundField DataField="Location" HeaderText="Location" />
                            <asp:BoundField DataField="ChecklistQuestion" HeaderText="Checklist Question" />
                            <asp:BoundField DataField="IsYes" HeaderText="Is Yes" />
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                            <asp:BoundField DataField="PhotoPath" HeaderText="Photo Path" />

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
</asp:Content>
