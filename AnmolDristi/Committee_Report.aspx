<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Committee_Report.aspx.cs" Inherits="AnmolDristi.Committee_Report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Committee Meeting Report</title>
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
       
    @media print {
        #printButton {
            display: none;
        }
    }


        h2 {
            text-align: center;
        }

        body {
            margin: 35px 55px;
            box-sizing: border-box;
            font-family: "Roboto", sans-serif;
            font-size: 14px;
            color: #000;
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
        .center td,
    .center th,
    .center_1 td,
    .center_1 th {
        padding: 10px;
        vertical-align: top;
        text-align: center;
        border: 2px solid #2c3e50;
        line-height: 1.4;
    } 

        
        
         /* Styling headers with a cool tone */
    .center_1 th {
        background-color: #34495e;
        color: white;
        font-weight: bold;
    }

    /* Alternating row colors */
    .center_1 tr:nth-child(even) {
        background-color: #ecf0f1;
    }

    .center_1 tr:nth-child(odd) {
        background-color: #ffffff;
    }

    .center tr:nth-child(even) {
        background-color: #f8f9fa;
    }

    .center th {
        background-color: #2c3e50;
        color: #fff;
        font-weight: bold;
    }

    /* Bold outline for entire table */
    .center,
    .center_1 {
        border: 2px solid #2c3e50;
    }

    /* Column widths */
    .TABLE_1 tr:first-child td {
        width: 33.3%;
    }

    .center_1 th:nth-child(1) { width: 25%; }
    .center_1 th:nth-child(2) { width: 20%; }
    .center_1 th:nth-child(3) { width: 20%; }
    .center_1 th:nth-child(4) { width: 20%; }
    .center_1 th:nth-child(5) { width: 15%; }
    

        /* Attendance Status */
    </style>
 

</head>
<body>
    <asp:Repeater ID="RepeaterMeeting" runat="server" OnItemDataBound="RepeaterMeeting_ItemDataBound">
        <HeaderTemplate>
            <!-- Your header content -->
            <table class="TABLE_1">
                <tr>
                    <td style="text-align: left;">
                        <b>Document Number</b></br>
                        DOC/ATS/OSH/CM-04
                    </td>
                   <%-- <td style="text-align: center; height: auto;">
                        <asp:Image ID="Image1" runat="server"  ImageUrl="~/WebData/img/logo.png" CssClass="Logo" AlternateText="logo" />
                    </td>--%>
                    <td style="text-align: right;">
                        <b>EFF.DATE:</b><br />
                        19/12/2018
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
                        <h3 style="padding-top: 2px; margin-bottom: 0px; text-align: center; ">Safety Performance Review Meeting:-</h3>
                    </td>
                </tr>
        </HeaderTemplate>

        <ItemTemplate>
            <tr>
                <td colspan="3" style="height: 20px;"><h2 style="text-decoration: underline;">Meeting Sheet </h2></td>
            </tr>
            <!-- Meeting Info -->
            <tr class="center">
                <td>Meeting ID</td>
                <td colspan="3"><%# Eval("MeetingID") %></td>
            </tr>
            <tr class="center">
                <td>Date</td>
                <td colspan="3"><%# Eval("MeetingDate", "{0:yyyy-MM-dd}") %></td>
            </tr>
            <tr class="center">
                <td>Time</td>
                <td colspan="2"><%# Eval("MeetingTime") %></td>
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
             <tr class="center">
                    <td>Meeting Image</td>
                 <td colspan="2">
  <asp:Image ID="imgUpload" runat="server"
    ImageUrl='<%# Eval("Image_upload") %>'
    Width="100" Height="100" AlternateText="Image not found" />
                  
            </tr>


            <!-- Attendee Section -->
            <tr>
                <td colspan="7">
                    <h2 style="text-decoration: underline;">Attendance Sheet </h2>
                    <table class="center_1">
                        <thead>
                            <tr class="center_1">
                               <%-- <th>Attendance ID</th>
                                <th>Meeting ID</th>--%>
                                <th>Name</th>
                                <th>Designation</th>
                              <%--  <th>Attendee Code</th>--%>
                                <th>Attendee Type</th>
                                <%--<th>Image</th>--%>
                                <th>Attendance Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="RepeaterAttendees" runat="server">
                                <ItemTemplate>
                                    <tr class="center_1">
                                        <td><%# Eval("Name") %></td>
                                        <td><%# Eval("Designation") %></td>
                                       <%-- <td><%# Eval("AttendeeCode") %></td>--%>
                                        <td><%# Eval("Attendee_Type") %></td>
                                        <td><%# Eval("AttendanceStatus") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </td>
            </tr>

             <!-- Issues Section -->
 <tr>
     <td colspan="8">
         <h2 style="text-decoration: underline;">Issues Sheet </h2>
         <table class="center_1">
             <thead>
                 <tr class="center_1">
                     <th>Agenda Title</th>
                     <th>Issue Description</th>
                      <th>Point Raised By</th>
                     <th>Close By</th>
                     <th>Target Date</th>
                      <th>Review Date</th>
                     <th>Status</th>
                     
                    
                    
                 </tr>
             </thead>
             <tbody>
                 <asp:Repeater ID="RepeaterIssues" runat="server">
                     <ItemTemplate>
                         <tr class="center_1">
                             <td><%# Eval("AgendaTitle") %></td>
                             <td><%# Eval("IssueDescription") %></td>
                              <td><%# Eval("ReviewBy") %></td>
                             <td><%# Eval("ResponsiblePerson") %></td>
                             <td><%# Eval("TargetDate", "{0:yyyy-MM-dd}") %></td>
                             <td><%# Eval("ReviewDate", "{0:yyyy-MM-dd}") %></td>
                             <td><%# Eval("Status") %></td>
                            
                             
                            
                         </tr>
                     </ItemTemplate>
                 </asp:Repeater>
             </tbody>
         </table>
     </td>
 </tr>
          
            
        </ItemTemplate>
       
    </asp:Repeater>
   <div>
    <button id="printButton" onclick="printMeetingSheet()" 
            style="margin: 5px; padding: 15px 16px; font-size: 14px; background-color: lightgreen;">
        Print Sheet
    </button>
</div>



<script type="text/javascript">
    function printMeetingSheet() {
        window.print();
    }
</script>

               
</body>
<script type="text/javascript">
    function printMeetingSheet() {
        var originalContents = document.body.innerHTML;
        var printContents = originalContents;
        document.body.innerHTML = printContents;
        window.print();
        document.body.innerHTML = originalContents;
        location.reload(); 
    }
</script>
</html>
