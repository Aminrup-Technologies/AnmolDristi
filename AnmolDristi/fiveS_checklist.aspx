<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="fiveS_checklist.aspx.cs" Inherits="AnmolDristi.SurveyForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

        .page-break-after {
            page-break-before:always;
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
            border: 1px solid #ccc;
            margin: 0px;
        }

            .question tr td:nth-child(2) {
                text-align: center;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5>Main Heading</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Checklist for 5s</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

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
                                                    <th>Requirement</th>

                                                    <th>Okay/Not OK</th>

                                                    <th>Remarks</th>

                                                </tr>
                                                <%-- question--%>

                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_1" runat="server" Text="is this floor area free of unwanted items?" Font-Bold="false" Font-Size="Small"></asp:Label>


                                                    </td>
                                                    <td>
                                                        <asp:RadioButtonList>
                                                            <asp:ListItem ID=""
                                                        </asp:RadioButtonList>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p1_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_2" runat="server" Text="Are tops and insides of all cupboards, shelves, tables,
                                        etc. free of
                                        unwanted items? "
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>

                                                    </td>
                                                    <td>
                                                        <span id="p2_tick" runat="server" visible="false">✅</span>
                                                        <span id="p2_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p2_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>


                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_3" runat="server" Text="Are Items stored according to frequencyof use? "
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>

                                                    </td>
                                                    <td>
                                                        <span id="p3_tick" runat="server" visible="false">✅</span>
                                                        <span id="p3_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p3_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_4" runat="server" Text="Are walls free of old posters, calendars, pictures,
                                        notices etc.?  "
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>

                                                    </td>
                                                    <td>
                                                        <span id="p4_tick" runat="server" visible="false">✅</span>
                                                        <span id="p4_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p4_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_5" runat="server" Text=" Is there a general clutter free appearance?                "
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>

                                                    </td>
                                                    <td>
                                                        <span id="p5_tick" runat="server" visible="false">✅</span>
                                                        <span id="p5_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p5_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>



                                                <tr>
                                                    <td colspan="3" class="heading">
                                                        <strong>SET IN ORDER-SEITON</strong>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_6" runat="server"
                                                            Text="Are direction indications available to all facilities from the entrance onwards?"
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p6_tick" runat="server" visible="false">✅</span>
                                                        <span id="p6_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p6_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>


                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_7" runat="server" Text="Do all items of equipment have identification labels?" Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p7_tick" runat="server" visible="false">✅</span>
                                                        <span id="p7_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p7_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_8" runat="server" Text="Are all rooms, cubicles and similar areas clearly numbered or named?" Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p8_tick" runat="server" visible="false">✅</span>
                                                        <span id="p8_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p8_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_9" runat="server" Text="Are specific areas demarcated for garbage/rejects/waste, etc.?" Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p9_tick" runat="server" visible="false">✅</span>
                                                        <span id="p9_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p9_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_10" runat="server" Text="Are switches, fan regulators, controls, etc. labelled?" Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p10_tick" runat="server" visible="false">✅</span>
                                                        <span id="p10_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p10_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_11" runat="server" Text="Are all cables, wires, pipes etc, neat and straight?" Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p11_tick" runat="server" visible="false">✅</span>
                                                        <span id="p11_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p11_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_14" runat="server" Text="Is it easy to find any item/document without delay?                  
"
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>

                                                    </td>
                                                    <td>
                                                        <span id="p14_tick" runat="server" visible="false">✅</span>
                                                        <span id="p14_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p14_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <%-- Third_section--%>
                                                <tr class="page-break-inside">
                                                    <td colspan="3" class="heading">
                                                        <strong>SHINE-SEISO</strong>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_15" runat="server" Text="Are cleaning schedules available and displayed?" Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p15_tick" runat="server" visible="false">✅</span>
                                                        <span id="p15_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p15_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_16" runat="server"
                                                            Text="Are floors, walls, windows, doors etc. maintained at a high level of cleanliness?"
                                                            Font-Bold="false" Font-Size="Small" />
                                                    </td>
                                                    <td>
                                                        <span id="p16_tick" runat="server" visible="false">✅</span>
                                                        <span id="p16_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p16_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_17" runat="server"
                                                            Text="Are Items stored according to frequency of use?"
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p17_tick" runat="server" visible="false">✅</span>
                                                        <span id="p17_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p17_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_18" runat="server"
                                                            Text="Are machines, equipment, tools, furniture maintained at a high level of cleanliness and their maintenance schedules displayed?"
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p18_tick" runat="server" visible="false">✅</span>
                                                        <span id="p18_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p18_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_19" runat="server"
                                                            Text="Is there a general appearance of cleanliness all round?"
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p19_tick" runat="server" visible="false">✅</span>
                                                        <span id="p19_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p19_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <%--fourth_section--%>
                                                <tr>
                                                    <td colspan="3" class="heading">
                                                        <strong>STANDARDIZE-SEIKETSU</strong>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_20" runat="server"
                                                            Text="Are all 5S procedures standardized?"
                                                            Font-Bold="false" Font-Size="Small" />
                                                    </td>
                                                    <td>
                                                        <span id="p20_tick" runat="server" visible="false">✅</span>
                                                        <span id="p20_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p20_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_21" runat="server"
                                                            Text="Are standard checklists used to regularly inspect 5S?"
                                                            Font-Bold="false" Font-Size="Small" />
                                                    </td>
                                                    <td>
                                                        <span id="p21_tick" runat="server" visible="false">✅</span>
                                                        <span id="p21_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p21_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_22" runat="server"
                                                            Text="Are labels, notices etc. standardized?"
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p22_tick" runat="server" visible="false">✅</span>
                                                        <span id="p22_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p22_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_23" runat="server"
                                                            Text="Do aisles/gangways have a standard size and colour?"
                                                            Font-Bold="false" Font-Size="Small" />
                                                    </td>
                                                    <td>
                                                        <span id="p23_tick" runat="server" visible="false">✅</span>
                                                        <span id="p23_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p23_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_24" runat="server"
                                                            Text="Are pipes, cables etc. colour-coded?"
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p24_tick" runat="server" visible="false">✅</span>
                                                        <span id="p24_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p24_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <%--fifth_section--%>
                                                <tr class="page-break-after">
                                                    <td colspan="3" class="heading">
                                                        <strong>SUSTAIN-SHITSUKE</strong>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_25" runat="server"
                                                            Text="Is there a system for how and when the 5S activities will be implemented?"
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p25_tick" runat="server" visible="false">✅</span>
                                                        <span id="p25_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p25_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_26" runat="server"
                                                            Text="Does management provide support to the 5S programme by recognition, resources and leadership?"
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p26_tick" runat="server" visible="false">✅</span>
                                                        <span id="p26_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p26_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_27" runat="server"
                                                            Text="Have first 3S’s become a part of the daily work?"
                                                            Font-Bold="false" Font-Size="Small"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <span id="p27_tick" runat="server" visible="false">✅</span>
                                                        <span id="p27_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p27_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label Class="Question" ID="lbl_28" runat="server"
                                                            Text="Do employees show positive interest in 5S activities?"
                                                            Font-Bold="false" Font-Size="Small" />
                                                    </td>
                                                    <td>
                                                        <span id="p28_tick" runat="server" visible="false">✅</span>
                                                        <span id="p28_cross" runat="server" visible="false">❌</span>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbl_p28_rmrks" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>

                                            </table>

                                        </td>
                                    </tr>

                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
