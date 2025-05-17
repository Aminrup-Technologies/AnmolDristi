<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Award_report.aspx.cs" Inherits="AnmolDristi.Award_report" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        @media print {
            @page {
                size: A4;
                margin: 20mm;
            }
            .no-print {
                display: none !important;
            }
        }

        body {
            background-color: white;
            font-family: 'Segoe UI', sans-serif;
        }

        .report-container {
            width: 100%;
            max-width: 1000px; /* or 210mm */
            margin: 0 auto;
            padding: 20px 40px;
            background-color: white;
            box-sizing: border-box;
        }

        .report-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .report-title {
            font-size: 35px;
            font-weight: bolder;
            color: dodgerblue;
            text-decoration: underline;
            font-family: 'Times New Roman', Times, serif;
        }

        .sub-title {
            font-size: 18px;
            font-style: italic;
            font-family: Arial;
            font-weight: bold;
        }

        .date-row {
            justify-content: space-between;
            margin: 20px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            border: 1px solid;
            padding: 10px;
            text-align: center;
            vertical-align: middle;
        }

        table thead {
            background-color: lightsteelblue;
        }

        .image {
            width: 150px;
            height: 150px;
            object-fit: unset;
        }

        .footer-note {
            margin-top: 40px;
            text-align: center;
            font-style: italic;
            font-size: 16px;
            font-weight: bold;
            color: red;
        }

        .btn {
            display: inline-block;
            font-weight: 600;
            color: white;
            background-color: darkgreen;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: forestgreen;
        }

        .text-end {
            text-align: right;
        }

        .mb-3 {
            margin-bottom: 1rem;
        }

        /* Ensure sidebar doesn't overlap */
        .content-wrapper {
            margin-left: 260px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <div class="report-container">

            <div class="no-print text-end mb-3">
                <button type="button" class="btn btn-success" onclick="window.print()">Print Report</button>
            </div>

            <div class="report-header">
                <asp:Image ID="LogoImage" runat="server" ImageUrl="image/aminrup-logo.jpg" Width="100px" />
                <div class="report-title">Employee Award Distribution Report</div>
                <div class="sub-title">Congratulations on the success of your performance</div>
                <div class="sub-title">Automation & Technical Services congratulates you on receiving the award</div>
            </div>

            <div class="date-row">
                <div><strong>Date:</strong> <asp:Label ID="lblDate" runat="server" CssClass="text-dark"></asp:Label></div>
            </div>

            <table class="table table-bordered award-table">
                <thead class="table-light">
                    <tr>
                        <th>SL.NO</th>
                        <th>Name</th>
                        <th>Designation</th>
                        <th>Award</th>
                        <th>Event</th>
                        <th>Image</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptAwardDetails" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("SerialNo") %></td>
                                <td><%# Eval("EmpName") %></td>
                                <td><%# Eval("Designation") %></td>
                                <td><%# Eval("AwardCategory") %></td>
                                <td><%# Eval("EventName") %></td>
                                <td>
                                    <img src='<%# Eval("ImagePath") %>' alt="Image" class="image" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>

            <div class="footer-note">
                पुरस्कार प्राप्त करने पर आपको बधाई. AUG (2024)
            </div>

        </div>
    </div>
</asp:Content>

