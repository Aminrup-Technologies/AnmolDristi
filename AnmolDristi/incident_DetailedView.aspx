<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="incident_DetailedView.aspx.cs" Inherits="AnmolDristi.incident_DetailedView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    .table-container {
    display: flex;
    justify-content: center;
    padding: 20px 0;
    overflow-x: auto;
    width: 100%;
}

table.table {
    width: 98%;              /* Almost full screen width */
    min-width: 1400px;       /* Increased base width */
    max-width: 2400px;       /* Increased max limit */
    border-collapse: collapse;
    font-family: Arial, sans-serif;
    font-size: 14px;
    margin-bottom: 25px;
    background-color: #fff;
}



        table.table th,
        table.table td {
            padding: 10px 12px;
            border: 1px solid #ddd;
            vertical-align: top;
            color: #000;
        }

        table.table th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            text-align: left;
        }

        table.table td:first-child {
            font-weight: bold;
            width: 35%; /* Optional: slightly reduced to give more space to value column */
            white-space: nowrap;
        }

        table.table td {
            background-color: #f9f9f9;
        }

        table.table tr:nth-child(even) td {
            background-color: #f2f2f2;
        }

        img#imgEvidence {
            border: 1px solid #ccc;
            padding: 4px;
            border-radius: 4px;
            max-width: 150px;
            height: auto;
        }

        .table + .table {
            margin-top: 20px;
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
                    <div style="overflow-x: auto;">
                        <asp:GridView ID="gvIncidentView" runat="server" AutoGenerateColumns="False" ShowHeader="False">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <!-- Incident Basic Details -->
                                        <table class="table table-bordered mb-4">
                                            <tr><th colspan="2">Incident Basic Details</th></tr>
                                            <tr><td>Incident ID:</td><td><%# Eval("IncidentID") %></td></tr>
                                            <tr><td>Incident Classification:</td><td><%# Eval("IncidentClassification") %></td></tr>
                                            <tr><td>Date of Incident:</td><td><%# Eval("DateOfIncident", "{0:dd-MM-yyyy}") %></td></tr>
                                            <tr><td>Time of Incident:</td><td><%# Eval("TimeOfIncident") %></td></tr>
                                            <tr><td>Location:</td><td><%# Eval("Location") %></td></tr>
                                            <tr><td>Department:</td><td><%# Eval("Department") %></td></tr>
                                            <tr><td>Section:</td><td><%# Eval("Section") %></td></tr>
                                        </table>

                                        <!-- Injured Person Details -->
                                        <table class="table table-bordered mb-4">
                                            <tr><th colspan="2">Injured Person Details</th></tr>
                                            <tr><td>Name of Person Involved:</td><td><%# Eval("NameOfPersonInvolved") %></td></tr>
                                            <tr><td>Total No. of Injured Persons:</td><td><%# Eval("TotalInjuredPersons") %></td></tr>
                                            <tr><td>Vendor Name:</td><td><%# Eval("VendorName") %></td></tr>
                                        </table>

                                        <!-- Investigation and Root Cause -->
                                        <table class="table table-bordered mb-4">
                                            <tr><th colspan="2">Investigation Details</th></tr>
                                            <tr><td>Investigation Team Members:</td><td><%# Eval("InvestigationTeamMembers") %></td></tr>
                                            <tr><td>Incident Description:</td><td><%# Eval("TaskAndDescription") %></td></tr>

                                            <tr><th colspan="2">Root Cause Analysis</th></tr>
                                            <tr><td>Why 1 (Loss):</td><td><%# Eval("Why1") %></td></tr>
                                            <tr><td>Why 2 (Incident):</td><td><%# Eval("Why2") %></td></tr>
                                            <tr><td>Why 3 (Immediate Cause):</td><td><%# Eval("Why3") %></td></tr>
                                            <tr><td>Why 4 (Underlying Cause):</td><td><%# Eval("Why4") %></td></tr>
                                            <tr><td>Why 5 (Root Cause):</td><td><%# Eval("Why5") %></td></tr>
                                            <tr><td>Why 6 (How):</td><td><%# Eval("Why6") %></td></tr>
                                            <tr><td>Upload Supporting Image:</td>
                                                <td>
                                                    <asp:Image ID="imgEvidence" runat="server" ImageUrl='<%# Eval("SupportingImagePath") %>' Width="150px" />
                                                </td>
                                            </tr>
                                            <tr><td>Final Root Cause:</td><td><%# Eval("FinalRootCause") %></td></tr>

                                            <tr><th colspan="2">Actionables</th></tr>
                                            <tr><td>Immediate Actions:</td><td><%# Eval("CorrectiveActions") %></td></tr>
                                            <tr><td>Preventive Actions:</td><td><%# Eval("PreventiveActions") %></td></tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

