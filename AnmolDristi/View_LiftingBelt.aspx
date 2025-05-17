<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="View_LiftingBelt.aspx.cs" Inherits="AnmolDristi.View_LiftingBelt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



    <script>
        function printChecklist() {
            var printContents = document.getElementById("PrintChecklist").innerHTML;
            var printWindow = window.open('', '', 'height=800,width=1000');
            printWindow.document.write('<html><head><title>Print</title>');

            var styles = Array.from(document.querySelectorAll('link[rel="stylesheet"], style'));
            styles.forEach(style => {
                printWindow.document.write(style.outerHTML);
            });

            printWindow.document.write(`
            <style>
                @page {
                    size: A4 portrait;
                    margin: 20mm;
                }
                button {
                    display: none !important;
                }
                body {
                    font-family: Arial, sans-serif;
                    font-size: 12pt;
                    color: #000;
                    background: #fff;
                    margin: 0;
                    padding: 10px;
                }
                .print-container {
                    width: 100%;
                    max-width: 210mm;
                    margin: 0 auto;
                }
                img {
                    max-width: 100%;
                    height: auto;
                    page-break-inside: avoid;
                }
                .group-header {
                  colour:Black;

}
            </style>
        `);

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
                    <h5>LIFTING BELTS & WIRE ROPE SLING CHECKLIST</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>DOC/ATS/TSK/QMS/GC/013</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">




                            <div class="print-container" id="PrintChecklist">
                                <asp:Repeater ID="ParentRepeter" runat="server" OnItemDataBound="ParentRepeter_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="group-header p-2 mb-2" style="background-color: #007bff; color: white; font-weight: bold;">
                                            <%# Eval("GroupName") %>
                                        </div>

                                        <asp:Repeater ID="RepeaterChecklist" runat="server" DataSource='<%# Eval("Keys") %>'>
                                            <ItemTemplate>
                                                <div class="border rounded p-3 mb-3 bg-white shadow-sm">
                                                    <div class="mb-2" style="color: #004080; font-weight: bold;">
                                                        Requirement: <%# Eval("Requirement") %>
                                                    </div>

                                                    <div class="mb-2" style="color: black;">
                                                            Observation:
                                                        <span class='<%# 
                                                            Eval("IsOk").ToString() == "OK" ? "btn btn-success btn-sm px-3" : 
                                                            Eval("IsOk").ToString() == "NotOK" ? "btn btn-danger btn-sm px-3" : 
                                                            Eval("IsOk").ToString() == "NA" ? "btn btn-secondary btn-sm px-3" : 
                                                            "btn btn-light btn-sm px-3" 
                                                        %>'
                                                            style="color: black;">
                                                            <%# Eval("IsOk") %>
                                                        </span>
                                                    </div>

                                                    <asp:PlaceHolder runat="server" Visible='<%# Eval("IsOk").ToString() == "OK" %>'>
                                                        <div class="mb-2" style="color: black;">
                                                            Note: <%# Eval("Note") %>
                                                        </div>
                                                    </asp:PlaceHolder>

                                                    <asp:PlaceHolder runat="server" Visible='<%# Eval("IsOk").ToString() == "NotOK" %>'>
                                                        <div class="mb-2" style="color: black;">
                                                            Remarks: <%# Eval("Remark_text") %>
                                                        </div>
                                                        <div style="color: black;">
                                                            Photo:
                            <asp:Image ID="imgPhoto" runat="server"
                                ImageUrl='<%# "~/uploads/" + Eval("Before_pic") %>'
                                CssClass="img-thumbnail mt-1"
                                Width="120"
                                Style="max-width: 100%; height: auto;" />
                                                        </div>
                                                    </asp:PlaceHolder>

                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                            <div class="text-center my-4">
                                <button type="button" class="btn btn-primary" onclick="printChecklist();">Print Checklist</button>
                            </div>









                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
