<%@ Page Title="KYT Records" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="KYT_View.aspx.cs" Inherits="AnmolDristi.KYT_View" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
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
        }
    </style>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>KYT Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored KYT Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <div style="overflow-x: auto;">
                        <asp:GridView ID="GvKYTRecords" runat="server" CssClass="table table-striped table-bordered"
                            AutoGenerateColumns="False" DataKeyNames="ID" OnRowEditing="GvKYTRecords_RowEditing"
                            OnRowUpdating="GvKYTRecords_RowUpdating" OnRowCancelingEdit="GvKYTRecords_RowCancelingEdit"
                            OnRowDeleting="GvKYTRecords_RowDeleting">

                            <Columns>
                                <asp:BoundField DataField="KYT_WorksiteName" HeaderText="Worksite" />
                                <asp:BoundField DataField="KYT_Department" HeaderText="Department" />
                                <asp:BoundField DataField="KYT_Location" HeaderText="Location" />
                                <asp:BoundField DataField="KYT_Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:BoundField DataField="KYT_JobID" HeaderText="Job ID" />
                                <asp:BoundField DataField="KYT_Activity" HeaderText="Activity" />
                                <asp:BoundField DataField="KYT_SOPNo" HeaderText="SOP No" />
                                <asp:BoundField DataField="KYT_Vendor" HeaderText="Vendor" />
                                <asp:BoundField DataField="KYT_HiddenHazards" HeaderText="Hidden Hazards" />
                                <asp:BoundField DataField="KYT_Consequence" HeaderText="Consequence" />
                                <asp:BoundField DataField="KYT_CounterMeasures" HeaderText="Counter Measures" />
                                <asp:BoundField DataField="KYT_PriorityValue" HeaderText="Priority" />
                                <asp:BoundField DataField="SubmissionDate" HeaderText="Submission Date" />
                                <asp:BoundField DataField="SubmissionTime" HeaderText="Submission Time" />


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
