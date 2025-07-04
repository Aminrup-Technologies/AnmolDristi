<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="JobSite_DetailedView.aspx.cs" Inherits="AnmolDristi.JobSite_DetailedView" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                    <div class="container mt-4">

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
                            </Columns>
                        </asp:GridView>

                        <asp:Label ID="lblTitle2" runat="server" Text="Basic Information" CssClass="title-label"></asp:Label>
<asp:GridView ID="gvHeader" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
    HeaderStyle-CssClass="grid-header">
    <Columns>
        <asp:BoundField DataField="ChecklistDate" HeaderText="Checklist Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="Area" HeaderText="Area" />
        <asp:BoundField DataField="CreatedAt" HeaderText="Created Date" DataFormatString="{0:yyyy-MM-dd}" />
    </Columns>
</asp:GridView>


                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
