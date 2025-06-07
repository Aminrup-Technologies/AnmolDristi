<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="KYT_DetailedView.aspx.cs" Inherits="AnmolDristi.KYT_DetailedView" %>


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
            max-width: 2000px;
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

        table.table tr:nth-child(even) td {
            background-color: #f2f2f2;
        }

        img#imgKYTPhoto {
            border: 1px solid #ccc;
            padding: 4px;
            border-radius: 4px;
            max-width: 150px;
            height: auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>KYT Detailed View</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored KYT Details</h2>
                    <div class="clearfix"></div>
                </div>

                <div class="x_content table-container">
                    <asp:GridView ID="gvKYTDetails" runat="server" AutoGenerateColumns="False" ShowHeader="False">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <!-- KYT Basic Info -->
                                    <table class="table table-bordered">
                                        <tr><th colspan="2">KYT Basic Information</th></tr>
                                        <tr><td>Worksite Name:</td><td><%# Eval("KYT_WorksiteName") %></td></tr>
                                        <tr><td>Department:</td><td><%# Eval("KYT_Department") %></td></tr>
                                        <tr><td>Location:</td><td><%# Eval("KYT_Location") %></td></tr>
                                        <tr><td>Date:</td><td><%# Eval("KYT_Date", "{0:dd-MM-yyyy}") %></td></tr>
                                        <tr><td>Job ID:</td><td><%# Eval("KYT_JobID") %></td></tr>
                                        <tr><td>SOP No:</td><td><%# Eval("KYT_SOPNo") %></td></tr>
                                        <tr><td>Vendor:</td><td><%# Eval("KYT_Vendor") %></td></tr>
                                    </table>

                                    <!-- KYT Additional Info -->
                                    <table class="table table-bordered">
                                        <tr><th colspan="2">KYT Observations</th></tr>
                                        <tr><td>Activity:</td><td><%# Eval("KYT_Activity") %></td></tr>
                                        <tr><td>Hidden Hazards:</td><td><%# Eval("KYT_HiddenHazards") %></td></tr>
                                        <tr><td>Consequence:</td><td><%# Eval("KYT_Consequence") %></td></tr>
                                        <tr><td>Counter Measures:</td><td><%# Eval("KYT_CounterMeasures") %></td></tr>
                                        <tr><td>Priority Value:</td><td><%# Eval("KYT_PriorityValue") %></td></tr>
                                        <tr><td>Photograph:</td>
                                            <td>
                                                <asp:Image ID="imgKYTPhoto" runat="server" ImageUrl='<%# Eval("KYT_PhotographPath") %>' />
                                            </td>
                                        </tr>
                                        <tr><td>Submission Date:</td><td><%# Eval("SubmissionDate", "{0:dd-MM-yyyy}") %></td></tr>
                                        <tr><td>Submission Time:</td><td><%# Eval("SubmissionTime", "{0:hh\\:mm\\:ss}") %></td></tr>
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
