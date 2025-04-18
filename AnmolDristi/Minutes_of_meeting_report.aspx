<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Minutes_of_meeting_report.aspx.cs" Inherits="AnmolDristi.Minutes_of_meeting_report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Minutes_meeting_report</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet" />

    <style>
        @media print {
            @page {
                size: A4;
                margin: 20px;
            }
        }

        body {
            margin: 35px 55px;
            box-sizing: border-box;
            padding: 0px;
        }

        table {
            width: 100%;
            margin: 0px;
            padding: 0px;
            border-collapse: collapse;
            font-family: "Roboto", sans-serif;
            font-size: 14px;
            font-weight: normal;
            color: #000;
            border: none;
        }

        .table_1 tr th strong {
            font-size: 16px;
            margin-top: 0;
            margin-left: 50px;
            margin-bottom: 80px;
            width: 20%;
        }

        .Table_2 th {
            text-align: center;
            padding: 10px;
            margin: 40px 0;
            border: 1px solid #000;
            line-height: 1;
            vertical-align: top;
            padding-bottom: 7px;
        }

        .Table_2 {
            margin-top: 20px;
        }

            .Table_2 td {
                border: 1px solid #000;
                text-align: center;
                padding: 10px;
                vertical-align: top;
                line-height: 1;
            }

        .table_1 tr first-child td {
            width: 50%;
        }

        .table_1 tr:first-child td {
            width: 33.3%;
        }

        tr tdh:nth-child(4) {
            width: 20%;
        }

        .Table_2 tr th:nth-child(2) {
            width: 10%;
        }
    </style>
</head>
<body>
    <table class="table_1">

        <tr>
            <td colspan="3">
                <b>DOC/ATS/OSH/CM-04</b>
                <br />
                19/12/2018   
            </td>
            <td colspan="1" style="text-align: center;">
                <asp:Image ID="imgLogo" runat="server" ImageUrl="~/WebData/img/logo.png" CssClass="Logo" AlternateText="logo" />
            </td>

            <td colspan="1" style="text-align: right">
                <b>EFF. DATE:</b>
            </td>

        </tr>

        <tr>
            <th colspan="5" style="text-align: center; padding: 5px 10px 10px; padding-left; font-weight:400;"><strong>MINUTES OF MEETING  </strong></th>
        </tr>

        <tr>
            <td colspan="5">
                <table class="Table_2">
                    <tr>
                        <th>Sr. No </th>
                        <th>Issue Discussed</th>
                        <th>Action By(Responsibility)</th>
                        <th>Target Date</th>
                        <th>Status</th>



                    </tr>
                </table>

            </td>
        </tr>
    </table>




</body>
</html>
