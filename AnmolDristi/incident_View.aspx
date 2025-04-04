<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="incident_View.aspx.cs" Inherits="AnmolDristi.incident_View" %>


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
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Incident Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored Incident Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <asp:GridView ID="gvIncidentData" runat="server" CssClass="table table-striped table-bordered"
                        AutoGenerateColumns="False" DataKeyNames="IncidentID" 
                        OnRowEditing="gvIncidentData_RowEditing"
                        OnRowUpdating="gvIncidentData_RowUpdating" 
                        OnRowCancelingEdit="gvIncidentData_RowCancelingEdit"
                        OnRowDeleting="gvIncidentData_RowDeleting">

                        <Columns>
                            <asp:BoundField DataField="IncidentID" HeaderText="Incident ID" ReadOnly="True" />
                            <asp:BoundField DataField="IncidentClassification" HeaderText="Classification" />
                            <asp:BoundField DataField="DateOfIncident" HeaderText="Incident Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="TimeOfIncident" HeaderText="Time of Incident" DataFormatString="{0:hh:mm tt}" />
                            <asp:BoundField DataField="Location" HeaderText="Location" />
                            <asp:BoundField DataField="Section" HeaderText="Section" />
                            <asp:BoundField DataField="Department" HeaderText="Department" />
                            <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" />
                            <asp:BoundField DataField="TotalInjuredPersons" HeaderText="Total Injured" />
                            <asp:BoundField DataField="InvestigationTeamMembers" HeaderText="Investigation Team Members" />
                            <asp:BoundField DataField="TaskAndDescription" HeaderText="Task & Incident Description" />
                            <asp:BoundField DataField="RootCauseAnalysis" HeaderText="Root Cause Analysis" />
                            <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" DataFormatString="{0:yyyy-MM-dd}" />

                            <asp:BoundField DataField="PreventiveActions" HeaderText="Preventive Actions" />
                            <asp:BoundField DataField="NameOfPersonInvolved" HeaderText="Person Involved" />
                            <asp:BoundField DataField="AnyWitness" HeaderText="Any Witness?" />
                            <asp:BoundField DataField="WitnessNames" HeaderText="Witness Names" />
                            <asp:BoundField DataField="ReportedBy" HeaderText="Reported By" />
                            <asp:BoundField DataField="CorrectiveActions" HeaderText="Corrective Actions" />

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
