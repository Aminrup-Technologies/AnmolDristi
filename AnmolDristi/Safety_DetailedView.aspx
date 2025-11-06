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
                       <%-- <asp:GridView ID="gvSafetyAuditDetails" runat="server" AutoGenerateColumns="False" ShowHeader="False">
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
                        </asp:GridView>--%>





                   
<h4 class="text-primary mt-3 mb-2">Audit Header Details</h4>
<asp:GridView ID="gvAuditMain" runat="server" AutoGenerateColumns="False"
    CssClass="table table-bordered table-striped mb-4" HeaderStyle-CssClass="table-dark">
    <Columns>
        <asp:BoundField DataField="Department" HeaderText="Department" />
        <asp:BoundField DataField="Section" HeaderText="Section" />
        <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="Time" HeaderText="Time" />
        <asp:BoundField DataField="ContractorVendorCode" HeaderText="Vendor Code" />
        <asp:BoundField DataField="TotalContractorPeople" HeaderText="Total People" />
    </Columns>
</asp:GridView>



<h4 class="text-primary mt-3 mb-2">Participants</h4>
<asp:GridView ID="gvAuditSeverity" runat="server" AutoGenerateColumns="False"
    CssClass="table table-bordered table-striped mb-4" HeaderStyle-CssClass="table-dark">
    <Columns>
        <asp:BoundField DataField="InternalEmployees" HeaderText="Internal Employees" />
        <asp:BoundField DataField="ExternalMembers" HeaderText="External Members" />
    </Columns>
</asp:GridView>


<h4 class="text-primary mt-3 mb-2">Audit Observations</h4>
<asp:GridView ID="gvAuditDescription" runat="server" AutoGenerateColumns="False"
    CssClass="table table-bordered table-striped" HeaderStyle-CssClass="table-dark">
    <Columns>
        <asp:BoundField DataField="Description" HeaderText="Description" />
        <asp:BoundField DataField="GoodCitizens" HeaderText="Good Citizens" />
        <asp:BoundField DataField="NoOfViolations" HeaderText="No. of Violations" />
        <asp:BoundField DataField="Severity" HeaderText="Severity" />
        <asp:BoundField DataField="ViolationXSeverity" HeaderText="Violation × Severity" />
        <asp:BoundField DataField="FourAndFive" HeaderText="Four & Five" />
        <asp:BoundField DataField="UnsafeActConditions" HeaderText="Unsafe Acts/Conditions" />
        <asp:BoundField DataField="SubmittedDate" HeaderText="Submitted Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="SubmittedTime" HeaderText="Submitted Time" />

        <asp:TemplateField HeaderText="CAPA ID">
            <ItemTemplate>
                <asp:HyperLink ID="lnkCAPA" runat="server"
                    Text='<%# Eval("CAPAID") %>'
                    NavigateUrl='<%# Eval("CAPAID", "Universal_Capa.aspx?CAPA_ID={0}") %>'
                    Target="_blank"
                    Visible='<%# Eval("CAPAID") != DBNull.Value && Eval("CAPAID").ToString() != "" %>'>
                </asp:HyperLink>
                <asp:Label ID="lblNoCapa" runat="server" Text="-" 
                    Visible='<%# Eval("CAPAID") == DBNull.Value || Eval("CAPAID").ToString() == "" %>' />
            </ItemTemplate>
        </asp:TemplateField>

        
        <asp:TemplateField HeaderText="CAPA Active">
            <ItemTemplate>
                <span style='<%# Convert.ToBoolean(Eval("GenerateCAPA")) ? "color:green;" : "color:red;" %>'>
                    <%# Convert.ToBoolean(Eval("GenerateCAPA")) ? "✔️" : "❌" %>
                </span>
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
