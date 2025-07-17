<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="View_QJCC.aspx.cs" Inherits="AnmolDristi.View_QJCC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .group-header {
    background-color: darkblue;
    color: white;
    padding: 5px;
}
    </style>

    <script>
        function printChecklist() {
            var printContents = document.getElementById("printableTable").innerHTML;
            var printWindow = window.open('', '', 'height=800,width=1000');
            printWindow.document.write('<html><head><title>Print</title>');

            printWindow.document.write(`
  <style>
    table {
      border-collapse: collapse;
      width: 100%;
      margin-bottom: 20px;
    }
     h1, h3 {
  text-align: center;
  margin: 0;
}
h1 {
  margin-top: 20px;
  margin-bottom: 10px;
  font-size: 24px;
  text-decoration: underline;
}
h4 {
      background-color: #28a745; /* green */
      color: white;
      padding: 10px;
      font-size: 20px;
      font-weight: bold;
      text-align: center;
      border-radius: 5px;
      -webkit-print-color-adjust: exact; /* for Chrome */
  print-color-adjust: exact;         /* modern standard */
    }
    thead{
        background-color: black;
  color: white;
  -webkit-print-color-adjust: exact; /* for Chrome */
  print-color-adjust: exact; 
    }
    .my-custom-grid th {
        background-color: slategrey !important;
        color: white !important;
        font-weight: bold !important;
        -webkit-print-color-adjust: exact; /* for Chrome */
print-color-adjust: exact;
    }
    th, td {
      border: 1px solid black;
      padding: 6px;
      text-align: left;
      vertical-align: top;
    }
    td span {
      display: inline-block;
      min-width: 100px;
    }
    @media print {
      body { margin: 0; }
    }
  </style>
`);

            printWindow.document.write('</head><body>');
            printWindow.document.write('<h1>QUICK JCC Checklist Report</h1>');
            printWindow.document.write(printContents);
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h5 style="text-align: center; font-weight: bold;" class="text-success">Detailed View Page</h5>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="row" style="margin:0">
            <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2 style="text-align: left; padding-left: 20px; font-weight: bold;" class="text-success">DOC/ATS/Q-JCC/MM(TSK) REV : 00 ,EFT DATE : 01/01/2025</h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                        <div id="printableTable" style="overflow:auto">

                            <!-- Section 1: Basic Details -->
<h4 class="text-white bg-success p-2 rounded fw-bold fs-4 text-center " style="font-size: 20px; font-weight: bold; font-family:'Times New Roman', Times, serif">Basic Details</h4>
                            <table class="table table-sm table-bordered" border="1">
                                <thead style="background-color: slategrey; color: white;">
                                    <tr>
                                        <th>Date</th>
                                        <th>JOBID</th>
                                        <th>Department</th>
                                        <th>Location</th>
                                        <th>StartTime</th>
                                        <th>EndTime</th>
                                        <th>Audit By</th>
                                        <th>Photo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><asp:Label ID="Datelbl" runat="server" ></asp:Label></td>
                                        <td> <asp:Label ID="JobIDlbl" runat="server"></asp:Label></td>
                                        <td><asp:Label ID="Deptlbl" runat="server"></asp:Label></td>
                                        <td><asp:Label ID="Loclbl" runat="server"></asp:Label></td>
                                        <td> <asp:Label ID="strttimelbl" runat="server"></asp:Label></td>
                                        <td> <asp:Label ID="Endtimelbl" runat="server"></asp:Label></td>
                                        <td><asp:Label ID="Audlbl" runat="server"></asp:Label></td>
                                        <td><asp:Image ID="photolbl" runat="server" Width="100" /></td>
                                    </tr>
                                </tbody>
                            </table>

                            <!-- Section 2: Employee Details -->
<h4 class="text-white fw-bold fs-4 mt-5 bg-success p-2 rounded  text-center" style="font-size: 20px; font-weight: bold;  font-family:'Times New Roman', Times, serif">Employee Details</h4>
                             <asp:GridView ID="gvChecklist" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-sm my-custom-grid" HeaderStyle-BackColor="#708090" HeaderStyle-ForeColor="White">
                                 <Columns>
                                     <asp:BoundField DataField="Employee_Type" HeaderText="Employee Type" />
                                     <asp:BoundField DataField="Employee_Code" HeaderText="Employee Code" />
                                     <asp:BoundField DataField="Employee_Name" HeaderText="Employee Name" />
                                     <asp:BoundField DataField="Designation" HeaderText="Designation" />
                                 </Columns>
                             </asp:GridView>


                            <!-- Section 3: Checklist Details -->
<h4 class="text-white bg-success p-2 rounded fw-bold fs-4 mt-5 text-center" style="font-size: 20px; font-weight: bold;  font-family:'Times New Roman', Times, serif">Checklist Details</h4>

                                <table class="table table-sm table-bordered" border="1">
                                            <thead style="background-color: slategrey; color: white;">
                                                <tr>
                                                    <th>Requirement</th>
                                                    <th>Observations</th>
                                                    <th>Remarks</th>
                                                    <th>Severity</th>
                                                    <th>Photo</th>
                                                </tr>
                                            </thead>
                                            <tbody>


                                               
                                                <asp:Repeater ID="ParentRepeter" runat="server" >
                                                    <HeaderTemplate>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td colspan="5" class="group-header">
                                                                <asp:Label runat="server" ID="groupname" Font-Bold="true" Text='<%# Eval("GroupName") %>' /></td>
                                                        </tr>
                                                        <asp:Repeater ID="RepeaterChecklist" runat="server" DataSource='<%# Eval("Keys")%>' OnItemDataBound="RepeaterChecklist_ItemDataBound" >

                                                            <ItemTemplate>
                                                                <tr>

                                                                    <td><%# Eval("Requirements") %></td>
                                                                    <td style="text-align:center">
                                                                        <asp:Label runat="server" ID="oknotok" Text='<%# Eval("Result") %>' /></td>
                                                                    <td><%# Eval("Remark") %></td>
                                                                     <td style="text-align:center">
                                                                         <asp:Label runat="server" ID="Label1" Text='<%# Eval("Severity") %>' /></td>
                                                                    <td>
                                                                        <asp:Image ID="imgPhoto" runat="server" ImageUrl='<%# Eval("Before_photo") %>' Width="100" />
                                                                    </td>
                                                                </tr>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="text-center mt-3">
                                        <button type="button" class="btn btn-primary" onclick="printChecklist()">Print Checklist</button>
                                    </div>







                            </div>
                        </div>
                    </div>
                </div>
            </div>





</asp:Content>
