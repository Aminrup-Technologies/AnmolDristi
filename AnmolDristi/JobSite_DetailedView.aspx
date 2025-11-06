<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="JobSite_DetailedView.aspx.cs" Inherits="AnmolDristi.JobSite_DetailedView" %>


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
        .grid-header {
            background-color: black !important;
            color: white !important;
            text-align: center;
        }

        .check-icon {
            font-size: 1.5rem;
        }

        .title-label {
            font-size: 1.5rem;
            font-weight: bold;
            margin-top: 30px;
            margin-bottom: 10px;
            color: #004085;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Job Site Hazard Checklist Details</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Checklist Details</h2>
                    <div class="clearfix"></div>
                </div>

                <div class="x_content table-container">
                    <!--  Wrapped GridView in printableTable div -->
                    <div id="printableTable">
                    <div class="container mt-4">




                                                <asp:Label ID="lblTitle2" runat="server" Text="Basic Information" CssClass="title-label"></asp:Label>
<asp:GridView ID="gvHeader" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
    HeaderStyle-CssClass="grid-header">
    <Columns>
        <asp:BoundField DataField="ChecklistDate" HeaderText="Checklist Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="Area" HeaderText="Area" />
        <asp:BoundField DataField="CreatedAt" HeaderText="Created Date" DataFormatString="{0:yyyy-MM-dd}" />
    </Columns>
</asp:GridView>










                        <asp:Label ID="lblTitle1" runat="server" Text="Checklist Questions" CssClass="title-label"></asp:Label>
                        <asp:GridView ID="gvChecklistDetails" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                            HeaderStyle-CssClass="grid-header">
                            <Columns>
                                <asp:BoundField DataField="Question" HeaderText="Question" />
                                <asp:TemplateField HeaderText="IsYes">
                                    <ItemTemplate>
                                        <span class="check-icon" style='<%# Convert.ToInt32(Eval("IsYes")) == 1 ? "color:green;" : "color:red;" %>'>
                                            <%# Convert.ToInt32(Eval("IsYes")) == 1 ? "✔️" : "❌" %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
             
                      <asp:TemplateField HeaderText="CAPA ID">
    <ItemTemplate>
        <asp:HyperLink ID="lnkCapa" runat="server" 
            NavigateUrl='<%# "Universal_Capa.aspx?CAPA_ID=" + Eval("CAPA_ID") %>'
            Text='<%# Eval("CAPA_ID") %>' 
            Target="_blank" />
    </ItemTemplate>
</asp:TemplateField>

                                <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                <asp:TemplateField HeaderText="Photo">
    <ItemTemplate>
        <asp:Image ID="imgPhoto" runat="server" Width="60" Height="60"
            ImageUrl='<%# Eval("PhotoPath") != DBNull.Value && !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) 
                        ? Eval("PhotoPath").ToString() 
                        : "" %>'
            Visible='<%# Convert.ToInt32(Eval("IsYes")) == 0 && 
                      Eval("PhotoPath") != DBNull.Value && 
                      !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) %>' />

        <asp:Label ID="lblNoPhoto" runat="server" Text="No photo uploaded" ForeColor="Gray"
            Visible='<%# Convert.ToInt32(Eval("IsYes")) == 0 && 
                      (Eval("PhotoPath") == DBNull.Value || 
                       string.IsNullOrEmpty(Eval("PhotoPath").ToString())) %>' />
    </ItemTemplate>
</asp:TemplateField>

                            </Columns>
                        </asp:GridView>

                      
                        </div>
                        <!--  Print Button -->
                <div class="text-center mt-3">
                    <button type="button" class="btn btn-primary" onclick="printChecklist()">Print Checklist</button>
                </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
