<%@ Page Title="D & Bow Checklist View" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="DandBowDetailedView.aspx.cs" Inherits="AnmolDristi.DandBowDetailedView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />--%>
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
                    <h3>D and Bow Checklist Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>D and Bow Checklist Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <!--  Wrapped GridView in printableTable div -->
                    <div id="printableTable">
                    <div style="overflow-x: auto;">
    <div class="container mt-4">


         <asp:Label ID="lblTitle3" runat="server" Text="Basic Details Checklist" CssClass="title-label"></asp:Label>
 <asp:GridView ID="gvBasicDetails" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
     HeaderStyle-CssClass="grid-header">
     <Columns>
         <asp:BoundField DataField="Site" HeaderText="Site" />
         <asp:BoundField DataField="TagNo" HeaderText="Tag No" />
         <asp:BoundField DataField="InspectionDate" HeaderText="Inspection Date" DataFormatString="{0:yyyy-MM-dd}" />
         <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
         <asp:BoundField DataField="JobID" HeaderText="Job ID" />
         <asp:BoundField DataField="JobName" HeaderText="Job Name" />
     </Columns>
 </asp:GridView>











<asp:Label ID="lblTitle2" runat="server" Text="D-Bow Checklist" CssClass="title-label"></asp:Label>
<asp:GridView ID="gvDBow" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
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
                    Text='<%# Eval("CAPA_ID") %>' Target="_blank" />
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

        <asp:BoundField DataField="CreatedDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
    </Columns>
</asp:GridView>

<asp:Label ID="lblTitle1" runat="server" Text="Chain Pulley Checklist" CssClass="title-label"></asp:Label>
<asp:GridView ID="gvChainPulley" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
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
                    Text='<%# Eval("CAPA_ID") %>' Target="_blank" />
            </ItemTemplate>
        </asp:TemplateField>


        <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
       <%-- <asp:TemplateField HeaderText="Photo">
            <ItemTemplate>
                <asp:Image ID="imgPhoto" runat="server" Width="60" Height="60"
                    ImageUrl='<%# string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ? "" : Eval("PhotoPath").ToString() %>'
                    Visible='<%# !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) %>' />
                <asp:Label ID="lblNoPhoto" runat="server" Text="No photo uploaded"
                    Visible='<%# string.IsNullOrEmpty(Eval("PhotoPath").ToString()) %>' ForeColor="Gray" />
            </ItemTemplate>
        </asp:TemplateField>--%>



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















        <asp:BoundField DataField="CreatedDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
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
            </div></div>
                        
</asp:Content>
