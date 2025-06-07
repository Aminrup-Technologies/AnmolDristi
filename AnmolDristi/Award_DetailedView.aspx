<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Award_DetailedView.aspx.cs" Inherits="AnmolDristi.Award_DetailedView" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-container {
            display: flex;
            justify-content: center;
            padding: 20px 0;
            overflow-x: auto;
        }

        table.table {
            width: 100%;
            min-width: 1250px;
            max-width: 1400px;
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
            width: 35%;
            white-space: nowrap;
        }

        table.table td {
            background-color: #f9f9f9;
        }

        table.table tr:nth-child(even) td {
            background-color: #f2f2f2;
        }

        img#imgAward {
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
                    <h3>Award Distribution Details</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Detailed Award Record</h2>
                    <div class="clearfix"></div>
                </div>

                <div class="x_content table-container">
                    <asp:GridView ID="gvAwardDetails" runat="server" AutoGenerateColumns="False" ShowHeader="False">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <table class="table table-bordered mb-4">
                                        <tr><th colspan="2">Award Information</th></tr>
                                        <tr><td>Award Date:</td><td><%# Eval("DateOfAwardDistribution", "{0:dd-MM-yyyy}") %></td></tr>
                                        <tr><td>Event Name:</td><td><%# Eval("EventName") %></td></tr>
                                        <tr><td>Award ID:</td><td><%# Eval("Award_ID") %></td></tr>
                                        <tr><td>Award Description:</td><td><%# Eval("AwardDescription") %></td></tr>
                                    </table>

                                    <table class="table table-bordered mb-4">
                                        <tr><th colspan="2">Recipient Details</th></tr>
                                        <tr><td>Employee ID:</td><td><%# Eval("EmpId") %></td></tr>
                                        <tr><td>Employee Name:</td><td><%# Eval("EmpName") %></td></tr>
                                        <tr><td>Designation:</td><td><%# Eval("Designation") %></td></tr>
                                    </table>

                                    <table class="table table-bordered mb-4">
                                        <tr><th colspan="2">Submission Details</th></tr>
                                        <tr><td>Submitted Date:</td><td><%# Eval("SubmittedDate", "{0:dd-MM-yyyy}") %></td></tr>
                                        <tr><td>Submitted Time:</td><td><%# Eval("SubmittedTime") %></td></tr>
                                        <tr><td>Uploaded Image:</td>
                                            <td>
                                                <asp:Image ID="imgAward" runat="server" ImageUrl='<%# Eval("ImagePath") %>' />
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
</asp:Content>
