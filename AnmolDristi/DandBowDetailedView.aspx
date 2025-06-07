<%@ Page Title="D & Bow Checklist View" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="DandBowDetailedView.aspx.cs" Inherits="AnmolDristi.DandBowDetailedView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />--%>
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
                    <div style="overflow-x: auto;">
    <div class="container mt-4">
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
        <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
        
       
        <asp:TemplateField HeaderText="Photo">
            <ItemTemplate>
                <asp:Image ID="imgPhoto" runat="server" Width="60" Height="60"
                    ImageUrl='<%# string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ? "" : Eval("PhotoPath").ToString() %>'
                    Visible='<%# !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) %>' />
                <asp:Label ID="lblNoPhoto" runat="server" Text="No photo uploaded"
                    Visible='<%# string.IsNullOrEmpty(Eval("PhotoPath").ToString()) %>' ForeColor="Gray" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="CreatedDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
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
        <asp:BoundField DataField="Remarks" HeaderText="Remarks" />

       
        <asp:TemplateField HeaderText="Photo">
            <ItemTemplate>
                <asp:Image ID="imgPhoto" runat="server" Width="60" Height="60"
                    ImageUrl='<%# string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ? "" : Eval("PhotoPath").ToString() %>'
                    Visible='<%# !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) %>' />
                <asp:Label ID="lblNoPhoto" runat="server" Text="No photo uploaded"
                    Visible='<%# string.IsNullOrEmpty(Eval("PhotoPath").ToString()) %>' ForeColor="Gray" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="CreatedDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
    </Columns>
</asp:GridView>




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
    </div>
                        </div>
                    </div>
                </div>
            </div></div>
                        </div>
</asp:Content>
