<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Committee_Report.aspx.cs" Inherits="AnmolDristi.Committee_Report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Committee_Meeting_Report</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet" />
    <style>
        @media print {
            @page {
                size: A4;
                margin: 15px;
            }
        }
        h2{
            text-align:center;
        }

        body {
            margin: 35px 55px;
            box-sizing: border-box;
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

        #Image1 {
            width: 60px;
            height: auto;
        }

        .center td,
        .center th {
            padding: 5px 10px;
            vertical-align: top;
            text-align: center;
            border: 1px solid #000;
            line-height: 1;
        }

        .center_1 td,
        .center_1 th {
            padding: 10px 10px;
            vertical-align: top;
            text-align: center;
            border: 1px solid #000;
            line-height: 1;
        }

        .TABLE_1 tr:first-child td {
            width: 33.3%;
        }
    </style>

</head>
<body>
    <asp:Repeater ID="RepeaterMeeting" runat="server" OnItemDataBound="RepeaterMeeting_ItemDataBound">
        <HeaderTemplate>
            <!-- Your header content -->
            <table>
                <tr>
                    <td style="text-align: left;">
                        <b>DOC/ATS/OSH/CM-04</b><br />
                        19/12/2018
                    </td>
                    <td style="text-align: center; width: 100%; height: auto;">
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/WebData/img/logo.png" CssClass="Logo" AlternateText="logo" />
                    </td>
                    <td style="text-align: right;">
                        <b>EFF. DATE:</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="height: 30px"></td>
                </tr>

                <!-- Title Section -->
                <tr>
                    <td colspan="3" style="text-align: center; font-size: 18px; font-weight: bold; text-decoration: underline;">AUTOMATION & TECHNICAL SERVICE
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align: center; padding: 10px 0 30px; font-size: 16px; font-weight: bold; text-decoration: underline;">Internal Safety Committee Meeting
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <h3 style="padding-top: 15px;">Safety Performance Review Meeting:-</h3>
                    </td>
                </tr>
        </HeaderTemplate>

        <ItemTemplate>
            <!-- Meeting Info -->
            <tr class="center">
                <td>Date</td>
                <td colspan="3"><%# Eval("Date") %></td>
            </tr>
            <tr class="center">
                <td>Time</td>
                <td colspan="2"><%# Eval("Time") %></td>
            </tr>
            <tr class="center">
                <td>Venue</td>
                <td colspan="2"><%# Eval("Venue") %></td>
            </tr>
            <tr class="center">
                <td>Meeting No</td>
                <td colspan="2"><%# Eval("MeetingNo") %></td>
            </tr>
            <tr class="center">
                <td>Chaired By</td>
                <td colspan="2"><%# Eval("ChairedBy") %></td>
            </tr>

            <!-- Attendee Section -->
            <tr>
                <td colspan="7">
                    <h2> Attendees</h2>
                    <table>
                        <thead>
                            <tr class="center_1">
                                <th>Attendance ID</th>
                                <th>Meeting ID</th>
                                <th>Name</th>
                                <th>Designation</th>
                                <th>Attendee Code</th>
                                <th>Attendee Type</th>
                                <th>Image</th>
                                <th>Attendance Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="RepeaterAttendees" runat="server">
                                <ItemTemplate>
                                    <tr class="center_1">
                                        <td><%# Eval("AttendanceID") %></td>
                                        <td><%# Eval("MeetingID") %></td>
                                        <td><%# Eval("Name") %></td>
                                        <td><%# Eval("Designation") %></td>
                                        <td><%# Eval("AttendeeCode") %></td>
                                        <td><%# Eval("Attendee_Type") %></td>
                                        <td>
                                            <asp:Image ID="imgUpload" runat="server" ImageUrl='<%# "~/WebData/uploads/" + Eval("Image_upload") %>' Width="60" Height="60" AlternateText="N/A" />
                                        </td>
                                        <td><%# Eval("AttendanceStatus") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>

</body>
</html>
