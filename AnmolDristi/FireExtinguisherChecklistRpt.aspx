<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FireExtinguisherChecklistRpt.aspx.cs" Inherits="AnmolDristi.FireExtinguisherChecklistRpt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <title>Welding Checklist Report</title>
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

.TABLE_1 {
    margin-bottom: 30px;
}

.TABLE_1 td {
    padding: 6px 8px;
    font-size: 13px;
    vertical-align: top;
}
.TABLE_1 tr:first-child td {
    width: 33.3%;
}

.center_1 th:nth-child(1) { width: 25%; }
.center_1 th:nth-child(2) { width: 20%; }
.center_1 th:nth-child(3) { width: 20%; }
.center_1 th:nth-child(4) { width: 20%; }
.center_1 th:nth-child(5) { width: 15%; }


   
</style>
</head>
<body>
          <asp:Repeater ID="RepeaterMeeting" runat="server" OnItemDataBound="RepeaterMeeting_ItemDataBound">
    <HeaderTemplate>
        <!-- Your header content -->
        <table class="TABLE_1">
            <tr>
               <%-- <td style="text-align: left;">
                    <b>Document Number</b></br>
                   ATS/WMC/22/00
                </td>--%>
               <%-- <td style="text-align: center; height: auto;">
                    <asp:Image ID="Image1" runat="server"  ImageUrl="~/WebData/img/logo.png" CssClass="Logo" AlternateText="logo" />
                </td>--%>
               <%-- <td style="text-align: left;">
                    <b>EFF.DATE:</b><br />
                    23/02/2023
                </td>--%>
            </tr>
            <tr>
                <td colspan="3" style="height: 30px"></td>
            </tr>

            <!-- Title Section -->
            <tr>
                <td colspan="3" style="text-align: center; font-size: 18px; font-weight: bold; text-decoration: underline;">TATA STEEL LIMITED,ANGUL
                </td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: center; padding: 10px 0 30px; font-size: 16px; font-weight: bold; text-decoration: underline;">Fire Extinguisher Checklist
                </td>
            </tr>
    </HeaderTemplate>

    <ItemTemplate>
        <tr>
            <td colspan="3" style="height: 20px;"><h2 style="text-decoration: underline;">Basic Details</h2></td>
        </tr>
        <!-- Meeting Info -->
        <tr class="center">
            <td>Checklist ID</td>
            <td colspan="3"><%# Eval("HeaderID") %></td>
        </tr>
        <tr class="center">
            <td>Date</td>
            <td colspan="3"><%# Eval("ChecklistDate", "{0:yyyy-MM-dd}") %></td>
        </tr>
        <tr class="center">
            <td>Job ID</td>
            <td colspan="2"><%# Eval("JobID") %></td>
        </tr>
        <tr class="center">
            <td>EmployeeName</td>
            <td colspan="2"><%# Eval("EmployeeName") %></td>
        </tr>
         <tr class="center">
     <td>Inspected By</td>
     <td colspan="2"><%# Eval("InspectedBy") %></td>
 </tr>
         <tr class="center">
     <td>Remarks</td>
     <td colspan="2"><%# Eval("Remarks") %></td>
 </tr>
       


        <!-- Attendee Section -->
        <tr>
            <td colspan="10">
                <h2 style="text-decoration: underline;">Checklist Details</h2>
                <table class="center_1">
                    <thead>
                        <tr class="center_1">
                            <th>SNo</th>
                             <th>CheckList Points</th>
                            <th>IsOk</th>
                            <th>Remarks</th>
                            <th>Image</th>
                            <th>NA</th>
                            <th>Extinguisher Type</th>
                            <th>FE SerialNo</th>
                            <th>Calibration Date</th>
                            <th>Due Date</th>
                            <th>Capa Report</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="RepeaterChecklist" runat="server">
                            <ItemTemplate>
                                <tr class="center_1">
                                    <td><%# Eval("QuestionNumber") %></td>
                                     <td><%# Eval("description") %></td>
                                    <td><%# Convert.ToBoolean(Eval("IsOk")) ? "✔️" : "❌" %></td>
                                    <td><%# Eval("Remarks") %></td>
                                    <td><asp:Image ID="imgUpload"  runat="server"  ImageUrl='<%# Eval("PhotoPath") %>'  Width="100"  Height="100"  Visible='<%# !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) %>'  /></td>           
                                    <td><%# Convert.ToBoolean(Eval("NA")) ? "✔️" : "" %></td>
                                    <td><%# Eval("ExtinguisherType") %></td>
                                    <td><%# Eval("FE_SerialNo") %></td>
                                    <td><%# Eval("CalibrationDate", "{0:yyyy-MM-dd}") %></td>
                                    <td><%# Eval("DueDate", "{0:yyyy-MM-dd}") %></td>
                                     <td> <a href='CAPA_MASTER.aspx?report=<%# Eval("CAPA_Report") %>'> <%# Eval("CAPA_Report") %> </a> </td>
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
