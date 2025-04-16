<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="view_Checklists.aspx.cs" Inherits="AnmolDristi.viewChecklists" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script type="text/javascript">
        function printChecklist() {
            var printContents = document.getElementById("printableTable").innerHTML;
            var printWindow = window.open('', '', 'height=800,width=1000');
            printWindow.document.write('<html><head><title>Print</title>');
            printWindow.document.write('<style> table { border: 1px solid #000;border-collapse: collapse;width:100 %;} th, td { border: 1px solid #000;border-collapse: collapse;} </style>');
            printWindow.document.write('<style>@media print { body { margin: 0; } }</style>');
            printWindow.document.write('</head><body>');
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
                    <h5 style="text-align:left; padding-left:20px; font-weight: bold;" class="text-success">CHECKLIST FOR 5S</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 style="text-align:left; padding-left:20px; font-weight: bold;" class="text-success">JOB and Site Details</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div id="printableTable">
                                <table class="table table-sm table-bordered" border="1">
                                    <thead>
                                        <tr>
                                            <th>Requirement</th>
                                            <th>Observations</th>
                                            <th>Remarks</th>
                                            <th>Photo</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="ParentRepeter" runat="server">
                                            <HeaderTemplate>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td colspan="4">
                                                        <asp:Label runat="server" ID="groupname" Font-Bold="true" Text='<%# Eval("GroupName") %>' /></td>
                                                </tr>
                                                <asp:Repeater ID="RepeaterChecklist" runat="server" DataSource='<%# Eval("Keys")%>' OnItemDataBound="RepeaterChecklist_ItemDataBound">

                                                    <ItemTemplate>
                                                        <tr>

                                                            <td><%# Eval("Requirements") %></td>
                                                            <td>
                                                                <asp:Label runat="server" ID="oknotok" Text='<%# Convert.ToBoolean(Eval("Result")) ? "OK" : "NOT OK" %>' /></td>
                                                            <td><%# Eval("Remark") %></td>
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
    </div>
</asp:Content>
