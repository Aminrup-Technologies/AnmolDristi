<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Safety_DetailedView.aspx.cs" Inherits="AnmolDristi.Safety_DetailedView" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-container {
            display: flex;
            justify-content: center;
            padding: 20px 0;
            overflow-x: auto;
        }

        table.table {
            width: 100%;         /* Full width */
            min-width: 1250px;   /* Wider base width */
            max-width: 1400px;   /* Optional max limit for readability */
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
                    <h3>Safety Audit Details</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored Safety Audit Records</h2>
                    <div class="clearfix"></div>
                </div>

                <div class="x_content table-container">
                    <div style="overflow-x: auto;">
                        <asp:GridView ID="gvSafetyAuditDetails" runat="server" AutoGenerateColumns="False" ShowHeader="False">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <!-- Safety Audit Main Details -->
                                        <table class="table table-bordered mb-4">
                                            <tr><th colspan="2">Audit Main Details</th></tr>
                                            <tr><td>Audit ID:</td><td><%# Eval("AuditID") %></td></tr>
                                            <tr><td>Department:</td><td><%# Eval("Department") %></td></tr>
                                            <tr><td>Section:</td><td><%# Eval("Section") %></td></tr>
                                            <tr><td>Date:</td><td><%# Eval("Date", "{0:dd-MM-yyyy}") %></td></tr>
                                            <tr><td>Time:</td><td><%# Eval("Time") %></td></tr>
                                            <tr><td>Contractor Vendor Code:</td><td><%# Eval("ContractorVendorCode") %></td></tr>
                                            <tr><td>Total Contractor People:</td><td><%# Eval("TotalContractorPeople") %></td></tr>
                                        </table>

                                        <!-- Safety Audit Severity Details -->
                                        <table class="table table-bordered mb-4">
                                            <tr><th colspan="2">Severity Details</th></tr>
                                            <tr><td>Internal Employees:</td><td><%# Eval("InternalEmployees") %></td></tr>
                                            <tr><td>External Members:</td><td><%# Eval("ExternalMembers") %></td></tr>
                                        </table>

                                        <!-- Safety Audit Description Details -->
                                        <table class="table table-bordered mb-4">
                                            <tr><th colspan="2">Description & Analysis</th></tr>
                                            <tr><td>Description:</td><td><%# Eval("Description") %></td></tr>
                                            <tr><td>Good Citizens:</td><td><%# Eval("GoodCitizens") %></td></tr>
                                            <tr><td>Number of Violations:</td><td><%# Eval("NoOfViolations") %></td></tr>
                                            <tr><td>Severity:</td><td><%# Eval("Severity") %></td></tr>
                                            <tr><td>Violation x Severity:</td><td><%# Eval("ViolationXSeverity") %></td></tr>
                                            <tr><td>Four and Five:</td><td><%# Eval("FourAndFive") %></td></tr>
                                            <tr><td>Unsafe Act Conditions:</td><td><%# Eval("UnsafeActConditions") %></td></tr>
                                            <tr><td>Submitted Date:</td><td><%# Eval("SubmittedDate", "{0:dd-MM-yyyy}") %></td></tr>
                                            <tr><td>Submitted Time:</td><td><%# Eval("SubmittedTime") %></td></tr>

                                                                                    <tr>
    <td>CAPAID:</td>
    <td>
        <asp:TemplateField HeaderText="CAPA ID">
    <ItemTemplate>
        <asp:HyperLink ID="lnkCapa" runat="server" 
            NavigateUrl='<%# "Universal_Capa.aspx?CAPA_ID=" + Eval("CAPAID") %>'
            Text='<%# Eval("CAPAID") %>' 
            Target="_blank" />
    </ItemTemplate>
</asp:TemplateField>

    </td>
</tr>
                                            
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
