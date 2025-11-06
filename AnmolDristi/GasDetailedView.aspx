<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="GasDetailedView.aspx.cs" Inherits="AnmolDristi.GasDetailedView" %>

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
            padding: 10px;
        }

        .responsive-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        .custom-grid {
            width: 100%;
            min-width: 800px;
            border-collapse: collapse;
            font-family: 'Segoe UI', Tahoma, sans-serif;
            font-size: 14px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }

        .custom-grid th {
            background-color: #000;
            color: #fff;
            padding: 10px;
            text-align: left;
            border-bottom: 2px solid #444;
            white-space: nowrap;
        }

        .custom-grid td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            white-space: nowrap;
            color: #333;
        }

        .custom-grid tr:nth-child(even) {
            background-color: #f5f5f5;
        }

        .custom-grid tr:hover {
            background-color: #f0f0f0;
        }

        .section-title {
            font-size: 18px;
            margin: 20px 0 10px;
            font-weight: bold;
            color: #2b2b2b;
            border-left: 4px solid #000;
            padding-left: 10px;
        }

        .tick {
            color: green;
            font-weight: bold;
        }

        .cross {
            color: red;
            font-weight: bold;
        }

        .photo-img {
            max-width: 80px;
            height: auto;
            border-radius: 4px;
        }

        @media screen and (max-width: 768px) {
            .custom-grid {
                font-size: 13px;
            }
        }

        @media screen and (max-width: 480px) {
            .custom-grid {
                font-size: 12px;
            }

            .section-title {
                font-size: 16px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Gas Detailed View</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title"><div class="clearfix"></div></div>
                <div class="x_content table-container">
                    <!-- Wrapped GridView in printableTable div -->
                    <div id="printableTable">
                    <div class="section-title">Gas Cutting Basic Details</div>
                    <div class="responsive-wrapper">
                        <asp:GridView ID="gvGasHeader" runat="server" CssClass="custom-grid" AutoGenerateColumns="False" GridLines="Both" BorderWidth="1">
                            <Columns>
                                <asp:BoundField DataField="SiteName" HeaderText="Site" />
                                <asp:BoundField DataField="InspectionDate" HeaderText="Inspection Date" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:BoundField DataField="TagNo" HeaderText="Tag No" />
                                <asp:BoundField DataField="SubmittedDate" HeaderText="Submitted Date" />
                                <asp:BoundField DataField="SubmittedTime" HeaderText="Submitted Time" />
                                <asp:BoundField DataField="GasCutterName" HeaderText="Gas Cutter Name" />
                                <asp:BoundField DataField="JobID" HeaderText="Job ID" />
                            </Columns>
                        </asp:GridView>
                    </div>

                    <div class="section-title">Gas Cutting Checklist</div>
                    <div class="responsive-wrapper">
                        <asp:GridView ID="gvGasChecklist" runat="server" CssClass="custom-grid" AutoGenerateColumns="False" GridLines="Both" BorderWidth="1" OnRowDataBound="gvGasChecklist_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Question" HeaderText="Question" />
                                <asp:TemplateField HeaderText="Is Yes">
                                    <ItemTemplate>
                                        <asp:Literal ID="litIsYes" runat="server"></asp:Literal>
                                    </ItemTemplate>
                                </asp:TemplateField>


        <asp:TemplateField HeaderText="CAPA ID">
            <ItemTemplate>
                <asp:HyperLink ID="lnkCapa" runat="server" 
                    NavigateUrl='<%# "Universal_Capa.aspx?CAPA_ID=" + Eval("CAPA_ID") %>'
                    Text='<%# Eval("CAPA_ID") %>' Target="_blank" />
            </ItemTemplate>
        </asp:TemplateField>


                                <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                                                <asp:TemplateField HeaderText="Photo">
    <ItemTemplate>
        <!-- Show photo only when IsYes == 0 AND PhotoPath is not null/empty -->
        <asp:Image ID="imgPhoto" runat="server" Width="60" Height="60"
            ImageUrl='<%# Eval("PhotoPath") != DBNull.Value && !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) 
                        ? Eval("PhotoPath").ToString() 
                        : "" %>'
            Visible='<%# Convert.ToInt32(Eval("IsYes")) == 0 &&
                      Eval("PhotoPath") != DBNull.Value &&
                      !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) %>' />

        <!-- Show label only when IsYes == 0 AND PhotoPath is null/empty -->
        <asp:Label ID="lblNoPhoto" runat="server" Text="No photo uploaded" ForeColor="Gray"
            Visible='<%# Convert.ToInt32(Eval("IsYes")) == 0 &&
                      (Eval("PhotoPath") == DBNull.Value ||
                       string.IsNullOrEmpty(Eval("PhotoPath").ToString())) %>' />
    </ItemTemplate>
</asp:TemplateField>
                                <asp:BoundField DataField="FinalRemarks" HeaderText="Final Remarks" />
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
    </div>
</asp:Content>
