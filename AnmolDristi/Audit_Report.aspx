<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Audit_Report.aspx.cs" Inherits="AnmolDristi.Audit_Report" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Audit_Report</title>
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

        body {
            margin:20px 30px 0px;
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

        .section_1 {
            text-align: center;
        }

            .section_1 tr td,
            .section_1 tr th {
                border: 1px solid #ccc;
                padding: 5px;
                text-align: start;
                vertical-align: top;
            }

                .section_1 tr:nth-child(1) {
                    width: 4%;
                }

                .section_1 tr th:nth-child(2) {
                    width: 20%;
                }

                .section_1 tr td:nth-child(2),
                .section_1 tr td:nth-child(5) {
                    vertical-align: top;
                    text-align: center;
                }

                .section_1 tr th:nth-child(3) {
                    width: 28%;
                }

                .section_1 tr th:nth-child(4) {
                    width: 28%;
                }

                .section_1 tr th:nth-child(5) {
                    width: 20%;
                }

        .Heading {
            text-align: center;
        }

            .Heading p {
                font-weight: bold;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table>
            <tr>
                <td colspan="2" style="text-align: end">
                    <img style="position: absolute; top: 0px; right: 0px; width: 100px; height: auto"
                        src="WebData/img/logo.png"
                        alt="Logo" />

                </td>
            </tr>
            <tr>
                <td colspan="2" class="Heading">
                    <strong>AUTOMATION & TECHNICAL SERVICES</strong>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="Heading">
                    <p>HouseKeeping Audit (5S)</p>
                </td>
            </tr>
            <tr>
                <td style="width: 60%; font-weight: bold">Location:</td>
                <td style="width: 40%; font-weight: bold">Date:</td>
            </tr>
           <%-- <tr>
                <td colspan="2" style="height: 15px"></td>
            </tr>--%>
            <tr>
                <td colspan="2">
                    <table class="section_1">
                        <thead>
                            <tr>
                                <th>Sl.No</th>
                                <th>Photo</th>
                                <th>Observation</th>
                                <th>Corrective Action</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- First-Section--%>
                            <tr>
                                <td>1</td>
                                <td>
                                    <asp:Image Style="background-size:cover; bottom:0; position:center; left:0;"  ID="imgBefore_1" runat="server" Width="200px" />
                                </td>
                                <td>
                                    <asp:Label ID="lblObservation_1" Text="found unused Materials stored in the work place. " runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAction_1" Text="it should be kept in designated place.  " runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Image ID="imgAfter_1" runat="server" Width="200px" />
                                </td>
                            </tr>
                            <%-- Second-Section--%>
                            <tr>
                                <td>2</td>


                                <td>
                                    <asp:Image ID="imgBefore_2" runat="server" Width="200px" />
                                </td>
                                <td>
                                    <asp:Label ID="lblObservation_2" Text="few steel scraps laid under the conveyor." runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAction_2" Text="it to be removed. " runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Image ID="imgAfter_2" runat="server" Width="200px" />
                                </td>
                            </tr>

                            <%-- Third-Section--%>
                            <tr>
                                <td>3</td>
                                <td>
                                    <asp:Image ID="imgBefore_3" runat="server" Width="200px" />
                                </td>
                                <td>
                                    <asp:Label ID="lblObservation_3" Text="materials are stoed haphazardly on th e store yard. " runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAction_3" Text="it to be kept oderly. " runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Image ID="imgAfter_3" runat="server" Width="200px" />
                                </td>
                            </tr>
                            <%-- Fourth-Section--%>
                            <tr>
                                <td>4</td>
                                <td>
                                    <asp:Image ID="imgBefore_4" runat="server" Width="200px" />
                                </td>
                                <td>
                                    <asp:Label ID="lblObservation_4" Text="few unused materials had been found on the fabrication yard.  " runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAction_4" Text="it to be removed from workplace.  " runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Image ID="imgAfter_4" runat="server" Width="200px" />
                                </td>
                            </tr>
                            <%-- Firth-Section--%>
                            <tr>
                                <td>5</td>
                                <td>
                                    <asp:Image ID="imgBefore_5" runat="server" Width="200px" />
                                </td>
                                <td>
                                    <asp:Label ID="lblObservation_5" Text="few steel scarp had been found on the fabrication yard. " runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAction_5" Text="it to be cleaned.  " runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Image ID="imgAfter_5" runat="server" Width="200px" />
                                </td>
                            </tr>
                            <%-- Sixth-Section--%>
                            <tr>
                                <td>6</td>
                                <td>
                                    <asp:Image ID="imgBefore_6" runat="server" Width="200px" />
                                </td>
                                <td>
                                    <asp:Label ID="lblObservation_6" Text="steel wire rope laid on the workplace at fabrication yard.  " runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAction_6" Text="it to be kept in designated place.   " runat="server" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:Image ID="imgAfter_6" runat="server" Width="200px" />
                                </td>
                            </tr>


                        </tbody>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
