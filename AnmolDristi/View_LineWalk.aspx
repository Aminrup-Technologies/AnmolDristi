<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="View_LineWalk.aspx.cs" Inherits="AnmolDristi.View_LineWalk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        function printDetails() {
            var printContents = document.getElementById("printableDiv").innerHTML;
            var printWindow = window.open('', '', 'height=800,width=1000');

            printWindow.document.write('<html><head><title>Print</title>');
            printWindow.document.write(`
            <style>

                h1{
                    text-align: center;
                    text-decoration: underline;
                }
                  
                body {
                    font-family: Arial, sans-serif;
                    font-size: 12px;
                    margin: 20px;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-bottom: 20px;
                }

                th, td {
                    border: 1px solid #000;
                    padding: 8px;
                    text-align: left;
                }

                /* Force header color override */
                th {
                    background-color: black !important;
                    color: white !important;
                    -webkit-print-color-adjust: exact; /* For Chrome/Safari */
                    print-color-adjust: exact;
                }

                /* Also override .thead-dark or any Bootstrap class */
                .thead-dark th {
                    background-color: black !important;
                    
                }

                img {
                    max-width: 100px;
                    height: auto;
                }

                a {
                    color: black;
                    text-decoration: none;
                }

                @media print {
                    body {
                        margin: 0;
                        padding: 0;
                    }
                }
            </style>
        `);

            printWindow.document.write('</head><body><h1>Line Walk Report</h1>');
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
                <div class="title_left" style="text-align: center;">
                    <asp:Label ID="heading" runat="server" CssClass="h5 text-center font-weight-bold text-success"  Text="Detailed View Page"></asp:Label>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                           <%-- <h2 style="color: green;">Line walk Details View </h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>--%>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content" style="overflow: auto;">
                            <div id="printableDiv">
                                <table class="table table-sm table-bordered" border="1">
                                    <tr class="thead-dark">
                                        <th>Date</th>
                                        <th>Job ID</th>
                                        <th>Job Description</th>
                                        <th>Photo</th>
                                        <th>Audit By</th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="date" /></td>
                                        <td>
                                            <asp:Label runat="server" ID="jobid" /></td>
                                        <td>
                                            <asp:Label runat="server" ID="jobdesc" /></td>
                                        <td>
                                            <asp:Image ID="jobimg" runat="server" Width="200px" Visible="false"/></td>
                                        <td>
                                            <asp:Label ID="Auditby" runat="server" /></td>
                                    </tr>
                                </table>

                                <asp:GridView ID="TeamMemberGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-responsive-md">
                                    <HeaderStyle CssClass="thead-dark" />
                                    <Columns>
                                        <asp:BoundField HeaderText="Employee Type" DataField="TM_Type" />
                                        <asp:BoundField HeaderText="Employee Code" DataField="TM_Code" />
                                        <asp:BoundField HeaderText="Employee Name" DataField="TM_names" />
                                    </Columns>
                                </asp:GridView>

                                <asp:GridView ID="ObservGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered table-hover table-responsive-md" OnRowDataBound="ObservGrid_RowDataBound">
                                    <HeaderStyle CssClass="thead-dark" />
                                    <Columns>
                                        <asp:BoundField HeaderText="Area" DataField="Location" />
                                        <asp:BoundField HeaderText="Observation" DataField="Observation_Points" />
                                        <asp:BoundField HeaderText="Recommendation" DataField="Recommendation_Points" />
                                        <asp:TemplateField HeaderText="Snaps">
                                            <ItemTemplate>
                                                <asp:Image ID="imgSnap" runat="server"
                                                    ImageUrl='<%# ResolveUrl("~/Uploads/" + Eval("Snap_File_Path")) %>'
                                                    Width="100px" Height="100px" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Remarks" DataField="Remarks" />
                                        <asp:TemplateField HeaderText="Immediate Action Attachment">
                                            <ItemTemplate>
                                                <%-- <%# string.IsNullOrEmpty(Eval("ImmediateAction_Attachment") as string) 
                                                                  ? "" 
                                            : $"<a href='{ResolveUrl("~/Uploads/")}{Eval("ImmediateAction_Attachment")}' target='_blank'>View</a>" %>--%>
                                                <asp:Image ID="imgImmediateAttachment" runat="server"
                                                    ImageUrl='<%# ResolveUrl("~/Uploads/" + Eval("ImmediateAction_Attachment")) %>'
                                                    Width="100px" Height="100px" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Responsibility" DataField="Responsibility" />
                                        <asp:BoundField HeaderText="TargetDate" DataField="Target_Date" DataFormatString="{0:yyyy-MM-dd}" />
                                        <%--<asp:BoundField HeaderText="Status" DataField="Status" />--%>
                                        <asp:TemplateField HeaderText="Status">
    <ItemTemplate>
        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
    </ItemTemplate>
</asp:TemplateField>

                                    </Columns>
                                </asp:GridView>

                            </div>
                            <div class="text-center mt-3">
                                <button type="button" class="btn btn-primary" onclick="printDetails()">Print</button>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
