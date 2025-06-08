<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkerCompetencyRpt.aspx.cs" Inherits="AnmolDristi.WorkerCompetencyRpt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Worker Compentency Assessment Report</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet" />
    <style>
    @media print{
     @page {
         size: A4;
         margin: 5px;
     }
    }
            @media print {
    #printButton {
        display: none;
    }
}

    body {
        margin: 35px 55px;
        font-family: "Roboto", sans-serif;
        font-size: 14px;
        color: #000;
    }

    h2 {
        text-align: center;
        font-size: 16px;
        margin: 20px 0 10px;
        text-decoration: underline;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    .center td,
    .center th {
        padding: 10px;
        vertical-align: top;
        text-align: center;
        border: 2px solid #2c3e50;
        line-height: 1.4;
    }

    .center tr:nth-child(even) {
        background-color: #f8f9fa;
    }

    .center th {
        background-color: #2c3e50;
        color: #fff;
        font-weight: bold;
    }

    .center {
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

    img, .Logo {
        max-height: 80px;
        max-width: 120px;
    }
</style>

</head>
<body>
   <asp:Repeater ID="RepeaterMeeting" runat="server" >
    <HeaderTemplate>
        <table class="TABLE_1">
            <tr>
                <td style="text-align: left;">
                    <b>Document Number</b></br>
                     ATS/OHS/CA-01/REV-00
                </td>
               <%-- <td style="text-align: center; height: auto;">
                    <asp:Image ID="Image1" runat="server"  ImageUrl="~/WebData/Imagess/AminrupLogo.png" CssClass="Logo" AlternateText="logo" />
                </td>--%>
              <%--  <td style="text-align: left;">
                    <b>EFF.DATE:</b><br />
                    23/02/2023
                </td>--%>
            </tr>
            <tr>
                <td colspan="3" style="height: 30px"></td>
            </tr>

            <!-- Title Section -->
            <tr>
                <td colspan="3" style="text-align: center; font-size: 18px; font-weight: bold; text-decoration: underline;">M/s. Automation & Technical Services,KPO
                </td>
            </tr>
            <tr>
                <td colspan="3" style="text-align: center; padding: 10px 0 30px; font-size: 16px; font-weight: bold; text-decoration: underline;">Competency Assessment
                </td>
            </tr>
    </HeaderTemplate>

    <ItemTemplate>
        <tr>
            <td colspan="3" style="height: 20px;"><h2 style="text-decoration: underline;">Assessment Report</h2></td>
        </tr>
       <tr class="center">
    <td>Date</td>
    <td colspan="2"><%# Eval("Date", "{0:yyyy-MM-dd}") %></td>
     </tr>

        <tr class="center">
            <td>Name Of Workman</td>
            <td colspan="2"><%# Eval("NameOfWorkman") %></td>
        </tr>
        <tr class="center">
            <td>Designation</td>
            <td colspan="2"><%# Eval("Designation") %></td>
        </tr>
         <tr>
     <td colspan="3" style="height: 20px;"><h2 style="text-decoration: underline;">Score field</h2></td>
 </tr>

        <tr class="center">
            <td>Technical Knowledge(0-5)</td>
            <td colspan="2"><%# Eval("TechnicalKnowledge") %></td>
        </tr>
        <tr class="center">
    <td>Technical Skills(0-5)</td>
    <td colspan="2"><%# Eval("TechnicalSkills") %></td>
</tr>
        <tr class="center">
    <td>Consistency In Job(0-5)</td>
    <td colspan="2"><%# Eval("ConsistencyInJob") %></td>
</tr>
        <tr class="center">
    <td>Job Quality(0-5)</td>
    <td colspan="2"><%# Eval("JobQuality") %></td>
</tr>
        <tr class="center">
    <td>Safety Awareness(0-5)</td>
    <td colspan="2"><%# Eval("SafetyAwareness") %></td>
</tr>
                <tr class="center">
    <td>TotalMark</td>
    <td colspan="2"><%# Eval("TotalMark") %></td>
</tr>
                <tr class="center">
    <td>Total Score(Out of 25)</td>
    <td colspan="2"><%# Eval("Score") %></td>
</tr>
                <tr class="center">
    <td>Percentage</td>
    <td colspan="2"><%# Eval("Percentage") %></td>
</tr>
                        <tr class="center">
    <td>Evaluation Category</td>
    <td colspan="2"><%# Eval("EvaluationCategory") %></td>
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
