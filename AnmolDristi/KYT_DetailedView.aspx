<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="KYT_DetailedView.aspx.cs" Inherits="AnmolDristi.KYT_DetailedView" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <script type="text/javascript">
       function printChecklist() {
           var printContents = document.getElementById("printableTable").innerHTML;
           var printWindow = window.open('', '', 'height=800,width=1000');
           printWindow.document.write('<html><head><title>Checklist Report</title>');

           printWindow.document.write(`
          <style>
            body {
              font-family: Arial, sans-serif;
              font-size: 14px;
              margin: 20px;
            }
            h1 {
              text-align: center;
              margin-top: 10px;
              margin-bottom: 20px;
              font-size: 22px;
              text-decoration: underline;
            }
            table {
              border-collapse: collapse;
              width: 100%;
              margin-bottom: 20px;
            }
            th, td {
              border: 1px solid black;
              padding: 6px;
              text-align: left;
              vertical-align: top;
            }
            th {
              background-color: #f0f0f0;
              font-weight: bold;
            }
            img {
              max-width: 120px;
              height: auto;
            }
            @media print {
              body { margin: 0; }
            }
          </style>
        `);

           printWindow.document.write('</head><body>');
           printWindow.document.write('<h1>KYT Report</h1>');
           printWindow.document.write(printContents);
           printWindow.document.write('</body></html>');
           printWindow.document.close();
           printWindow.focus();
           printWindow.print();
           printWindow.close();
       }
   </script>

   <style>
        .table-container {
            display: flex;
            justify-content: center;
            padding: 20px 0;
            overflow-x: auto;
        }
        table.table {
            width: 100%;
            min-width: 1250px;
            max-width: 2000px;
            border-collapse: collapse;
            font-family: Arial, sans-serif;
            font-size: 14px;
            margin-bottom: 25px;
            background-color: #fff;
        }
        table.table th,
        table.table td {
            padding: 10px 12px;
            border: 1px solid #ddd;
            vertical-align: top;
            color: #000;
        }
        table.table th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            text-align: left;
        }
        table.table td:first-child {
            font-weight: bold;
            width: 35%;
            white-space: nowrap;
        }
        table.table tr:nth-child(even) td {
            background-color: #f2f2f2;
        }
        img#imgKYTPhoto {
            border: 1px solid #ccc;
            padding: 4px;
            border-radius: 4px;
            max-width: 150px;
            height: auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>KYT Detailed View</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored KYT Details</h2>
                    <div class="clearfix"></div>
                </div>

                <div class="x_content table-container">
                    <!--  Wrapped GridView in printableTable div -->
                    <div id="printableTable">
                       <%-- <asp:GridView ID="gvKYTDetails" runat="server" AutoGenerateColumns="False" ShowHeader="False">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <!-- KYT Basic Info -->
                                        <table class="table table-bordered">
                                            <tr><th colspan="2">KYT Basic Information</th></tr>
                                            <tr><td>Worksite Name:</td><td><%# Eval("KYT_WorksiteName") %></td></tr>
                                            <tr><td>Department:</td><td><%# Eval("KYT_Department") %></td></tr>
                                            <tr><td>Location:</td><td><%# Eval("KYT_Location") %></td></tr>
                                            <tr><td>Date:</td><td><%# Eval("KYT_Date", "{0:dd-MM-yyyy}") %></td></tr>
                                            <tr><td>Job ID:</td><td><%# Eval("KYT_JobID") %></td></tr>
                                            <tr><td>SOP No:</td><td><%# Eval("KYT_SOPNo") %></td></tr>
                                            <tr><td>Vendor:</td><td><%# Eval("KYT_Vendor") %></td></tr>
                                        </table>

                                        <!-- KYT Additional Info -->
                                        <table class="table table-bordered">
                                            <tr><th colspan="2">KYT Observations</th></tr>
                                            <tr><td>Activity:</td><td><%# Eval("KYT_Activity") %></td></tr>
                                            <tr><td>Hidden Hazards:</td><td><%# Eval("KYT_HiddenHazards") %></td></tr>
                                            <tr><td>Consequence:</td><td><%# Eval("KYT_Consequence") %></td></tr>
                                            <tr><td>Counter Measures:</td><td><%# Eval("KYT_CounterMeasures") %></td></tr>
                                            <tr><td>Priority Value:</td><td><%# Eval("KYT_PriorityValue") %></td></tr>
                                            <tr>
                                                <td>CAPAID:</td>
                                                <td>
                                                    <asp:HyperLink ID="lnkCapa" runat="server" 
                                                        NavigateUrl='<%# "Universal_Capa.aspx?CAPA_ID=" + Eval("CAPAID") %>'
                                                        Text='<%# Eval("CAPAID") %>' 
                                                        Target="_blank" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Photograph:</td>
                                                <td>
                                                    <asp:Image ID="imgKYTPhoto" runat="server" ImageUrl='<%# Eval("KYT_PhotographPath") %>' Width="100px" />
                                                </td>
                                            </tr>
                                            <tr><td>Submission Date:</td><td><%# Eval("SubmissionDate", "{0:dd-MM-yyyy}") %></td></tr>
                                            <tr><td>Submission Time:</td><td><%# Eval("SubmissionTime", "{0:hh\\:mm\\:ss}") %></td></tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>--%>











<asp:Label ID="lblHeader1" runat="server" Text="KYT Header Details" CssClass="title-label text-center bold" ></asp:Label>
<asp:GridView ID="gvKYTHeader" runat="server" AutoGenerateColumns="false"
    CssClass="table table-bordered table-hover" HeaderStyle-CssClass="grid-header">
    <Columns>
        <asp:BoundField DataField="ID" HeaderText="KYT ID" />
        <asp:BoundField DataField="KYT_WorksiteName" HeaderText="Worksite Name" />
        <asp:BoundField DataField="KYT_Department" HeaderText="Department" />
        <asp:BoundField DataField="KYT_Location" HeaderText="Location" />
        <asp:BoundField DataField="KYT_Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="KYT_JobID" HeaderText="Job ID" />
        <asp:BoundField DataField="KYT_SOPNo" HeaderText="SOP No" />
        <asp:BoundField DataField="KYT_Vendor" HeaderText="Vendor" />
    </Columns>
</asp:GridView>



                        <asp:Label ID="lblHeader2" runat="server" Text="KYT Activity Details" CssClass="title-label"></asp:Label>
<asp:GridView ID="gvKYTDetails" runat="server" AutoGenerateColumns="false"
    CssClass="table table-bordered table-hover" HeaderStyle-CssClass="grid-header">
    <Columns>
        <asp:BoundField DataField="KYT_Activity" HeaderText="Activity" />
        <asp:BoundField DataField="KYT_HiddenHazards" HeaderText="Hidden Hazards" />
        <asp:BoundField DataField="KYT_Consequence" HeaderText="Consequence" />
        <asp:BoundField DataField="KYT_CounterMeasures" HeaderText="Counter Measures" />
        <asp:BoundField DataField="KYT_PriorityValue" HeaderText="Priority Value" />

        <asp:TemplateField HeaderText="Photo">
            <ItemTemplate>
                <asp:Image ID="imgPhoto" runat="server" Width="60" Height="60"
                    ImageUrl='<%# string.IsNullOrEmpty(Eval("KYT_PhotographPath").ToString()) ? "" : Eval("KYT_PhotographPath").ToString() %>'
                    Visible='<%# !string.IsNullOrEmpty(Eval("KYT_PhotographPath").ToString()) %>' />
                <asp:Label ID="lblNoPhoto" runat="server" Text="No photo uploaded" ForeColor="Gray"
                    Visible='<%# string.IsNullOrEmpty(Eval("KYT_PhotographPath").ToString()) %>' />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="SubmissionDate" HeaderText="Submission Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="SubmissionTime" HeaderText="Submission Time" />

        <asp:TemplateField HeaderText="CAPA ID">
            <ItemTemplate>
                <asp:HyperLink ID="lnkCapa" runat="server"
                    NavigateUrl='<%# "Universal_Capa.aspx?CAPA_ID=" + Eval("CAPAID") %>'
                    Text='<%# Eval("CAPAID") %>' Target="_blank" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
























                    </div>
                </div>

                <!-- Print Button -->
                <div class="text-center mt-3">
                    <button type="button" class="btn btn-primary" onclick="printChecklist()">Print Checklist</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>