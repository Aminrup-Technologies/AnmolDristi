<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="csm_fives_rpt.aspx.cs" Inherits="AnmolDristi.csm_fives_rpt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CSM | Five S Report</title>
    <style>
        @media print {
            @page {
                size: A4;
                margin: 20px;
            }
        }

        body {
            margin: 0px;
            padding: 20px;
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

            table tr td {
                padding: 0;
                vertical-align: top;
            }

                table tr td label {
                    margin: 0px;
                }

        .heading {
            padding: 5px 10px;
            font-size: 16px;
            border: 1px solid #ccc;
        }

        .question {
            margin-left: -0.5px;
        }

            .question tr th {
                text-transform: uppercase;
                padding: 5px 10px;
                border: 1px solid #ccc;
            }

                .question tr th:nth-child(1) {
                    width: 50%;
                    border-top: 0px;
                }

                .question tr th:nth-child(2) {
                    width: 18%;
                    border-top: 0px;
                }

                .question tr th:nth-child(3) {
                    width: 32%;
                    border-top: 0px;
                }

            .question tr td {
                padding: 5px 10px;
                border: 1px solid #ccc;
                margin: 0px;
            }

                .question tr td:nth-child(2) {
                    text-align: center;
                }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td class="heading">
                        <strong>Sort Out - SEIRI</strong>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="question">
                            <tr>
                                <th>Requirement
                         </th>
                                <th>Okay/Not OK
                         </th>
                                <th>Remarks
                         </th>
                            </tr>
                            <%-- question--%>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_p1r1_txt" runat="server" Text="is this floor area free of unwanted items?" Font-Bold="false" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <span id="p1r1_tick" runat="server" visible="false">✅</span><span id="p1r1_cross" runat="server" visible="false">❌</span>
                                </td>
                                <td>
                                    <asp:Label ID="lbl_p1r1_rmrks" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label Class="Question" ID="lbl_2" runat="server" Text="Are tops and insides of all cupboards, shelves, tables,
                                         etc. free of
                                         unwanted items? "
                                        Font-Bold="false" Font-Size="Small"></asp:Label>

                                </td>
                                <td><span id="p1r2_tick" runat="server" visible="false">✅</span><span id="p1r2_cross" runat="server" visible="false">❌</span>
                                </td>
                                <td>Remarks write here</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label Class="Question" ID="lbl_3" runat="server" Text="Are Items stored according to frequencyof use? "
                                        Font-Bold="false" Font-Size="Small"></asp:Label>

                                </td>
                                <td><span id="p1r3_tick" runat="server" visible="false">✅</span><span id="p1r3_cross" runat="server" visible="false">❌</span>
                                </td>
                                <td>Remarks write here</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label Class="Question" ID="lbl_4" runat="server" Text="Are walls free of old posters, calendars, pictures,
                                         notices etc.?  "
                                        Font-Bold="false" Font-Size="Small"></asp:Label>

                                </td>
                                <td><span id="p1r4_tick" runat="server" visible="false">✅</span><span id="p1r4_cross" runat="server" visible="false">❌</span>
                                </td>
                                <td>Remarks write here</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label Class="Question" ID="lbl_5" runat="server" Text=" Is there a general clutter free appearance?                "
                                        Font-Bold="false" Font-Size="Small"></asp:Label>

                                </td>
                                <td><span id="p1r5_tick" runat="server" visible="false">✅</span><span id="p1r5_cross" runat="server" visible="false">❌</span>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td colspan="3" class="heading">
                                    <strong>Sort Out - SEIRI</strong>
                                </td>
                            </tr>



                        </table>

                    </td>
                </tr>
            </table>

        </div>
    </form>
</body>
</html>
