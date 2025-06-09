<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="View_LiftingBelt.aspx.cs" Inherits="AnmolDristi.View_LiftingBelt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        /* Container for each group */
        .group-header {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            padding: 0.5rem 1rem;
            margin-bottom: 1rem;
            border-radius: 4px;
            font-size: 1.1rem;
            print-color-adjust: exact;
            -webkit-print-color-adjust: exact;
        }

        /* Checklist item container */
        .checklist-item {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 1rem;
            margin-bottom: 1rem;
            print-color-adjust: exact;
            -webkit-print-color-adjust: exact;
        }

        /* Requirement text */
        .requirement {
            color: #004080;
            font-weight: 700;
            margin-bottom: 0.5rem;
            font-size: 1rem;
        }

        /* Observation label */
        .observation {
            color: #000;
            margin-bottom: 0.75rem;
            font-size: 0.9rem;
        }

        /* Observation status badges */
        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            font-size: 0.85rem;
            font-weight: 600;
            border-radius: 12px;
            color: #fff;
            margin-left: 0.5rem;
            min-width: 65px;
            text-align: center;
            print-color-adjust: exact;
            -webkit-print-color-adjust: exact;
        }

        /* Colors for status */
        .status-ok {
            background-color: #28a745; /* green */
            print-color-adjust: exact;
            -webkit-print-color-adjust: exact;
        }

        .status-notok {
            background-color: #dc3545; /* red */
        }

        .status-na {
            background-color: #6c757d; /* gray */
        }

        .status-unknown {
            background-color: #f8f9fa; /* light */
            color: #212529;
            border: 1px solid #ced4da;
        }

        /* Note and remarks */
        .note, .remarks {
            color: #000;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .photo-container {
            color: #000;
            min-width: 180px;
            text-align: right;
            font-size: 0.9rem;
        }

            .photo-container #imgPhoto {
                max-width: 100%;
                height: auto;
                display: inline-grid;
            }

        /* Responsive adjustments */
        @media (max-width: 600px) {
            .checklist-item {
                padding: 0.75rem;
            }

            .group-header {
                font-size: 1rem;
                padding: 0.4rem 0.8rem;
            }

            .status-badge {
                font-size: 0.75rem;
                min-width: 50px;
                padding: 0.2rem 0.5rem;
            }
        }

        @media print {
            .col-md-3 label {
                display: block;
                width: 100%;
                text-align: left !important;
                font-weight: bold;
                margin-bottom: 5px;
                print-color-adjust: exact;
                -webkit-print-color-adjust: exact;
            }
        }

        @media (max-width: 688px) {
            .row {
                flex-direction: column;
            }

            .col-md-3,
            .col-md-9 {
                max-width: 100%;
                flex: 0 0 100%;
                padding-left: 0;
                padding-right: 0;
            }

            .photo-container img {
                width: 100% !important;
                height: auto !important;
            }

            .photo-container span{
                display: flex !important;
            }
        }
    </style>




                 <script>

                            function printChecklist() {
                                var printContents = document.getElementById("PrintChecklist").innerHTML;
                                var printWindow = window.open('', '', 'height=800,width=1000');
                                printWindow.document.write('<html><head><title>Print</title>');

                                // Include existing styles from the main document (like Bootstrap)
                                var styles = Array.from(document.querySelectorAll('link[rel="stylesheet"], style'));
                                styles.forEach(style => {
                                    printWindow.document.write(style.outerHTML);
                                });

                                // Add custom print styles
                                printWindow.document.write(`
                            <style>
                                @page {
                                    size: A4 portrait;
                                    margin: 10mm;
                                }
                                body {
                                    font-family: Arial, sans-serif;
                                    font-size: 12pt;
                                    color: #000;
                                    background: #fff;
                                    margin: 0;
                                    padding: 10px;
                                }
                                button {
                                    display: none !important;
                                }
                                .row {
                                    display: flex;
                                    flex-wrap: wrap;
                                    margin-right: -15px;
                                    margin-left: -15px;
                                }
                                .col-md-3 {
                                    flex: 0 0 25%;
                                    max-width: 25%;
                                    padding-right: 15px;
                                    padding-left: 15px;
                                    display: flex;
                                    justify-content: flex-end;
                                    align-items: flex-start;
                                }
                                .col-md-9 {
                                    flex: 0 0 75%;
                                    max-width: 75%;
                                    padding-right: 15px;
                                    padding-left: 15px;
                                }
                                img {
                                    max-width: 100%;
                                    height: auto;
                                    page-break-inside: avoid;
                                }
                                     h1, h3 {
                          text-align: center;
                          margin: 0;
                        }
                        h1 {
                          margin-top: 20px;
                          margin-bottom: 10px;
                          font-size: 24px;
                          border:2px solid black;
                          padding:5px
                        }
                        .photo-container span{
                            margin-right:70px;
                        }
                        }
                            </style>
                        `);


                                printWindow.document.write('</head><body>');
                                printWindow.document.write('<h1>LIFTING BELTS & WIRE ROPE SLING CHECKLIST REPORT</h1>');
                                printWindow.document.write(printContents);
                                printWindow.document.write('</body></html>');
                                printWindow.document.close();
                                printWindow.focus();
                                printWindow.print();
                                printWindow.close();
                            }

                 </script>

</asp:Content >


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5 style="text-align: center; font-weight: bold;" class="text-success">Detailed View Page</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2 style="text-align: left; padding-left: 20px; font-weight: bold;" class="text-success">DOC/ATS/TSK/QMS/GC/013</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="print-container" id="PrintChecklist">

                                <div class="container my-4">
                                    <div class="table-responsive">
                                        <table class="table table-sm table-bordered w-50 mx-auto shadow-sm bg-white rounded">
                                            <tbody>
                                                <tr>
                                                    <th>ID</th>
                                                    <td class="w-75">
                                                        <asp:Label ID="lblID" runat="server" CssClass="form-control-plaintext m-0 p-1" /></td>
                                                </tr>
                                                <tr>
                                                    <th>Date</th>
                                                    <td>
                                                        <asp:Label ID="lblDte" runat="server" CssClass="form-control-plaintext m-0 p-1" /></td>
                                                </tr>
                                                <tr>
                                                    <th>JobSite</th>
                                                    <td>
                                                        <asp:Label ID="lbljbsite" runat="server" CssClass="form-control-plaintext m-0 p-1" /></td>
                                                </tr>
                                                <tr>
                                                    <th>JobID</th>
                                                    <td>
                                                        <asp:Label ID="lbljbID" runat="server" CssClass="form-control-plaintext m-0 p-1" /></td>
                                                </tr>
                                                <tr>
                                                    <th>JobDescription</th>
                                                    <td>
                                                        <asp:Label ID="lbljbdesc" runat="server" CssClass="form-control-plaintext m-0 p-1" /></td>
                                                </tr>
                                                <tr>
                                                    <th>Audit By</th>
                                                    <td>
                                                        <asp:Label ID="lblaudit" runat="server" CssClass="form-control-plaintext m-0 p-1" /></td>
                                               </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>





                                <%--<asp:Repeater ID="ParentRepeter" runat="server" OnItemDataBound="ParentRepeter_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="group-header p-2 mb-2" style="background-color: #007bff; color: white; font-weight: bold;" id="grp">
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
                                </asp:Repeater>--%>


                                <asp:Repeater ID="ParentRepeter" runat="server">
                                    <ItemTemplate>
                                        <div class="group-header" id="grp">
                                            <%# Eval("GroupName") %>
                                        </div>

                                        <asp:Repeater ID="RepeaterChecklist" runat="server" DataSource='<%# Eval("Keys") %>' OnItemDataBound="RepeaterChecklist_ItemDataBound">
                                            <ItemTemplate>
                                                <div class="row checklist-item p-3 mb-3 bg-white shadow-sm rounded border">
                                                    <!-- Left content column -->
                                                    <div class="col-md-9">
                                                        <div class="requirement font-weight-bold mb-2">
                                                            Requirement: <%# Eval("Requirement") %>
                                                        </div>

                                                        <div class="observation mb-2">
                                                            Observation:
                                                        <span class='<%# 
                                                            Eval("IsOk").ToString() == "OK" ? "status-badge status-ok" : 
                                                            Eval("IsOk").ToString() == "NotOK" ? "status-badge status-notok" : 
                                                            Eval("IsOk").ToString() == "NA" ? "status-badge status-na" : 
                                                            "status-badge status-unknown" 
                                                        %>'>
                                                            <%# Eval("IsOk") %>
                                                        </span>
                                                        </div>

                                                        <asp:PlaceHolder runat="server" Visible='<%# Eval("IsOk").ToString() == "OK" %>'>
                                                            <div class="note mb-2">
                                                                Note: <%# Eval("Note") %>
                                                            </div>
                                                        </asp:PlaceHolder>

                                                        <asp:PlaceHolder runat="server" Visible='<%# Eval("IsOk").ToString() == "NotOK" %>'>
                                                            <div class="remarks mb-2">
                                                                Remarks: <%# Eval("Remark_text") %>
                                                            </div>
                                                        </asp:PlaceHolder>
                                                    </div>

                                                    <!-- Right image column -->
                                                    <asp:PlaceHolder ID="phImageColumn" runat="server" Visible='<%# Eval("IsOk").ToString() == "NotOK" %>'>
                                                        <div class="col-md-3 d-flex align-items-start justify-content-end">
                                                            <div class="photo-container text-right">
                                                                <asp:label ID="lblphimg" runat="server">Photo:</asp:label>
                                                                <asp:Image ID="imgPhoto" runat="server"
                                                                    ImageUrl='<%#  Eval("Before_pic") %>'
                                                                    CssClass="img-thumbnail"
                                                                    Width="180"
                                                                    Style="max-width: 100%; height: auto;" />
                                                            </div>
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
