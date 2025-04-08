<%@ Page Title="Safety Audit Records" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Safety_View.aspx.cs" Inherits="AnmolDristi.Safety_View" %>



<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-label {
            font-weight: bold;
            color: #007bff;
            display: block;
            margin-bottom: 5px;
        }

        .table-container {
            margin-top: 20px;
        }
        .btn-actions {
    width: 70px;       /* Same width for all buttons */
    height: 35px;      /* Optional: fix height for visual alignment */
    padding: 5px 10px; /* Optional: control internal spacing */
    text-align: center;
    display: inline-block;
}


       /* .btn-actions {
            margin-right: 5px;
        }*/
    </style>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Safety Audit Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored Safety Audit Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <asp:GridView ID="GvSafetyAudit" runat="server" CssClass="table table-striped table-bordered"
                        AutoGenerateColumns="False" DataKeyNames="AuditID" OnRowEditing="GvSafetyAudit_RowEditing"
                        OnRowUpdating="GvSafetyAudit_RowUpdating" OnRowCancelingEdit="GvSafetyAudit_RowCancelingEdit"
                        OnRowDeleting="GvSafetyAudit_RowDeleting">

                        <Columns>
                            <asp:BoundField DataField="Department" HeaderText="Department" />
                            <asp:BoundField DataField="Section" HeaderText="Section" />
                            <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="Time" HeaderText="Time" />
                            <asp:BoundField DataField="ContractorVendorCode" HeaderText="Vendor Code" />
                            <asp:BoundField DataField="TotalContractorPeople" HeaderText="Contractor Count" />
                            <asp:BoundField DataField="InternalEmployees" HeaderText="Internal Members" />
                            <asp:BoundField DataField="ExternalMembers" HeaderText="External Members" />
                            <asp:BoundField DataField="Description" HeaderText="Description" />
                            <asp:BoundField DataField="GoodCitizens" HeaderText="Good Citizens" />
                            <asp:BoundField DataField="NoOfViolations" HeaderText="Violations" />
                            <asp:BoundField DataField="Severity" HeaderText="Severity" />
                            <asp:BoundField DataField="ViolationXSeverity" HeaderText="Violation Severity" />
                            <asp:BoundField DataField="FourAndFive" HeaderText="4 & 5" />
                            <asp:BoundField DataField="UnsafeActConditions" HeaderText="Unsafe Act" />

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
