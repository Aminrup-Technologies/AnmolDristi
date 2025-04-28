<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Committee_Meeting_Report.aspx.cs" Inherits="AnmolDristi.Committee_Meeting_Report" %>

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

        body {
            margin: 35px 55px;
            box-sizing: border-box;
        }

        #Image1 {
            width: 60px;
            height: auto;
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

        .TABLE_2 {
            margin-top: 20px;
        }

        .heading_2 td {
            margin-bottom: 50px;
        }

        .center_1 td,
        .center_1 th {
            text-align: center;
            vertical-align: top;
            padding: 5px 10px;
            border: 1px solid #000;
            line-height: 1;
        }

        .center td,
        .center th {
            padding: 5px 10px;
            vertical-align: top;
            border: 1px solid #000;
            line-height: 1;
        }

        .center_2 th {
            text-align: center;
            vertical-align: top;
            padding: 10px 10px;
            border: 1px solid #000;
            line-height: 1;
        }

        .TABLE_1 tr:first-child td {
            width: 33.3%;
        }

        .center_2 th {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <table class="TABLE_1">
        <tr>
            <td style="text-align: left;">
                <b>DOC/ATS/OSH/CM-04</b><br />
                19/12/2018
            </td>
            <td style="text-align: center;">
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

        <!-- Meeting Info -->
        <tr class="center">
            <td>
                <asp:Label ID="lbl_D" Text="Date" runat="server" /></td>
            <td colspan="2">
                <asp:Label ID="lbl_Date" Text="17/06/2024 " runat="server" /></td>

        </tr>
        <tr class="center">
            <td>
                <asp:Label ID="lbl_T" Text="Time" runat="server" /></td>
            <td colspan="2">
                <asp:Label ID="lbl_Time" Text="2.00PM" runat="server" /></td>
        </tr>
        <tr class="center">
            <td>
                <asp:Label ID="lbl_V" Text="Venue" runat="server" /></td>
            <td colspan="2">
                <asp:Label ID="lbl_Venus" Text="Microsoft Teams" runat="server" /></td>
        </tr>
        <tr class="center">
            <td>
                <asp:Label ID="lbl_M" Text="Meeting No" runat="server" /></td>
            <td colspan="2">
                <asp:Label ID="lbl_MeetingNo" Text="DOC/ATS/OSH/CM-06" runat="server" /></td>
        </tr>
        <tr class="center">
            <td>
                <asp:Label ID="lbl_C" Text="Chaired By" runat="server" /></td>
            <td colspan="2">
                <asp:Label ID="lblChairedBy" Text="Mr. Mahesh Chourasia" runat="server" /></td>
        </tr>

        <!-- Attendance center -->
        <tr>
            <td colspan="3">
                <table>
                    <tr>
                        <td colspan="9" style="text-align: center; padding-top: 20px; padding-bottom: 20px; font-size: 18px; font-weight: bold; text-decoration: underline;">Attendance Sheet
                        </td>
                    </tr>

                    <!-- Attendance Table Header -->
                    <tr class="center_1">
                        <th>Sr. No</th>
                        <th>AttendiID</th>
                        <th>MeetingID</th>
                        <th>Name</th>
                        <th>Designation</th>
                        <th>AttendiCode</th>
                        <th>Attenditype</th>
                        <th>image</th>
                        <th>Signature</th>

                        <!-- Extra columns to align with colspan=6 -->
                    </tr>


                    <!-- Attendance Row 1 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_1" Text="01" runat="server" />

                        </td>
                        <td>
                            <asp:Label ID="Label1AttendiID" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label2MeetingID" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Mahesh" runat="server" />

                        </td>

                        <td>
                            <asp:Label ID="lbl_Proprietor" Text="Proprietor " runat="server" /></td>

                        <td>
                            <asp:Label ID="Label3AttendiCode" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label4Attenditype" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image5" runat="server" ImageUrl="~/images/sample.jpg" />
                        </td>

                        <td>
                            <asp:Label ID="lbl_Attend" Text="Attend " runat="server" /></td>

                    </tr>

                    <!-- Attendance Row 2 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_2" Text="02" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label6AttendiID" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label7MeetingID" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_K" Text="Kishor Kumar Ray" runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_L" Text="Location Head " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label8AttendiCode" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label9Attenditype" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image6" runat="server" ImageUrl="~/images/default.jpg" AlternateText="Profile Image" />
                        </td>

                        <td>
                            <asp:Label ID="lbl_Attend2" Text="Attend" runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 3 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_3" Text="03" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label11AttendiID" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label12MeetingID" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Kulamani" Text="Kulamani Das " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Hr" Text="HR" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label13AttendiCode" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label14Attenditype" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image7" runat="server" ImageUrl="~/images/default.jpg" AlternateText="Profile Image" />
                            <td>
                                <asp:Label ID="lbl_Attend_3" Text="Attend " runat="server" /></td>
                    </tr>
                    <!-- Attendance Row 4 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_4" Text="04" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label16AttendiID" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label17MeetingID" Text=" " runat="server" /></td>
                        <td>

                            <asp:Label ID="lbl_Santosh" Text="Santosh Singh" runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Site" Text="Site Incharge" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label18AttendiCode" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label19Attenditype" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image8" runat="server" ImageUrl="~/images/default.jpg" AlternateText="Profile Image" />
                        </td>

                        <td>
                            <asp:Label ID="lbl_Attend_4" Text="Attend " runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 5 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_5" Text="05" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label21AttendiID" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label22MeetingID" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Ajay" Text="Ajay Kumar Yadav " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_site1" Text="Site Incharge" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label23AttendiCode" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label24Attenditype" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image9" runat="server" ImageUrl="~/images/default.jpg" AlternateText="Profile Image" />
                        </td>


                        <td>
                            <asp:Label ID="lbl_Attend_5" Text="Attend " runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 6 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_6" Text="06" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label26" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label27" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Biraja" Text="Biraja Kumar Satpathy  " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Site2" Text="Site Incharge" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label28" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label29" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image10" runat="server" ImageUrl="~/path/to/image.jpg" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_Attend_6" Text="Attend " runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 7 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_7" Text="07" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label31" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label32" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Shyam" Text="Shyam Padhy" runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Safety_4" Text="Safety Officer" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label33" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label34" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image11" runat="server" ImageUrl="~/images/clean.png" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_Attend7" Text="Attend" runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 8 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_8" Text="08" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label36" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label37" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Amaresh" Text="Amaresh Sahoo" runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Site3" Text="Site Incharge " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label38" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label39" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image12" runat="server" ImageUrl="~/Images/checkmark.png" />
                        </td>

                        <td>
                            <asp:Label ID="lbl_Attend8" Text="Attend " runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 9 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_9" Text="09" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label41" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label42" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Bipad" Text="Bipad jena " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Site4" Text="Site Incharge " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label43" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label44" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image13" runat="server" ImageUrl="~/Images/default.png" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_Attend9" Text="Attend " runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 10 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_10" Text="10" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label46" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label47" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Subhranshu" Text="Subhranshu Swain  " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Safety1" Text="Safety Supervisor  " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label48" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label49" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image14" runat="server" ImageUrl="~/Images/default.png" /></td>
                        <td>
                            <asp:Label ID="lbl_Attend10" Text="Attend " runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 11 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_11" Text="11" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label51" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label52" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Surya" Text="Surya Adak" runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Safety2" Text="Safety Supervisor  " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label53" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label54" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image15" runat="server" ImageUrl="~/Images/default.png" /></td>
                        <td>
                            <asp:Label ID="lbl_Attend11" Text="Attend " runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 12 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_12" Text="12" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label56" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label57" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Rajesh" Text="Rajesh Jena" runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Safety3" Text="Safety Supervisor" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label58" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label59" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image16" runat="server" ImageUrl="~/Images/default.png" /></td>
                        <td>
                            <asp:Label ID="lbl_Attend12" Text="Attend" runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 13 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_13" Text="13" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label61" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label62" Text=" " runat="server" /></td>

                        <td>
                            <asp:Label ID="lbl_Jyotishree" Text="Jyotishree Ojha " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Safety4" Text="Safety Supervisor" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label63" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label64" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image17" runat="server" ImageUrl="~/Images/default.png" /></td>
                        <td>
                            <asp:Label ID="lbl_Attend13" Text="Attend" runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 14 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_14" Text="14" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label66" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label67" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Shasikant" Text="Shasikant Ojha  " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_site_4" Text="Site Incharge " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label68" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label69" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image18" runat="server" ImageUrl="~/Images/default.png" /></td>
                        <td>
                            <asp:Label ID="lbl_Attend14" Text="Attend" runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 15 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_15" Text="15" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label71" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label72" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Satyajit" Text="Satyajit Mahanta" runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Safety_5" Text="Safety Supervisor " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label73" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label74" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image19" runat="server" ImageUrl="~/Images/default.png" /></td>
                        <td>
                            <asp:Label ID="lbl_Attend15" Text="Attend" runat="server" /></td>

                    </tr>
                    <!-- Attendance Row 16 -->
                    <tr class="center_1">
                        <td>
                            <asp:Label ID="lbl_16" Text="16" runat="server" /></td>
                        <td>
                            <asp:Label ID="Label76" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label77" Text=" " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Mahendra" Text="Mahendra Jena " runat="server" /></td>
                        <td>
                            <asp:Label ID="lbl_Site6" Text="Site Incharge  " runat="server" /></td>
                        <td>
                            <asp:Label ID="Label78" Text=" " runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label79" Text=" " runat="server" /></td>
                        <td>
                            <asp:Image ID="Image20" runat="server" ImageUrl="~/Images/default.png" /></td>
                        <td>
                            <asp:Label ID="lbl_Attend16" Text="Attend" runat="server" /></td>

                    </tr>

                </table>
            </td>
        </tr>

        <tr>
            <td colspan="9">
                <table class="TABLE_2">
                    <tr>
                        <td colspan="3" style="text-align: left;">
                            <b>DOC/ATS/OSH/CM-04</b><br />
                            19/12/2018
                        </td>
                        <td colspan="3" style="text-align: center;">
                            <asp:Image ID="Image2" runat="server" ImageUrl="~/WebData/img/logo.png" CssClass="Logo" AlternateText="logo" />
                        </td>
                        <td colspan="3" style="text-align: right;">
                            <b>EFF. DATE:</b>
                        </td>
                    </tr>
                   <%-- <tr>
                        <td colspan="9" style="height: 30px"></td>
                    </tr>--%>

                    <!-- Title Section -->
                    <tr class="heading_2">
                        <td colspan="9" style="text-align: center; font-size: 18px; font-weight: bold; text-decoration: underline">MINUTES OF MEETING  
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9">
                            <table class="center_2">
                                <tr>
                                    <th>Sr. No</th>
                                    <th>IssueID</th>
                                    <th>MeetingID</th>
                                    <th>IssueDescription</th>
                                    <th>ResponsiblePerson</th>
                                    <th>TargetDate</th>
                                    <th>AgendaTitle</th>
                                    <th>ReviewDate</th>
                                    <th>ReviewBy</th>

                                    <!-- Extra columns to align with colspan=6 -->
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>2</td>
                        <td>3</td>
                        <td>3</td>
                        <td>2</td>
                        <td>3</td>
                        <td>2</td>
                        <td>3</td>
                        <td>3</td>
                    </tr>


                     </table>
                     </td>
                    </tr>
                </table>
     
</body>

</html>
