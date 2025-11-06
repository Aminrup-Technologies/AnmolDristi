<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Award_DetailedView.aspx.cs" Inherits="AnmolDristi.Award_DetailedView" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>

    .header-table th {
        background-color: #007bff;
        color: white;
        text-align: center;
        font-weight: 600;
    }

    .header-table td {
        text-align: center;
        background-color: #f8f9fa;
        font-weight: 500;
    }

    .award-table th {
        background-color: #17a2b8;
        color: white;
        font-weight: 600;
    }

    .award-table td {
        vertical-align: middle;
        text-align: center;
    }

    .award-table tr:hover {
        background-color: #f1f1f1;
    }

    hr.my-4 {
        border: 0;
        height: 2px;
        background: #dee2e6;
        margin: 30px 0;
    }
</style>

    <style>
    /* ===== Header Box Styling ===== */
    .header-box {
        background: linear-gradient(135deg, #f8f9fa, #e9ecef);
        border: 1px solid #dee2e6;
        border-radius: 10px;
        padding: 15px 20px;
        margin-bottom: 25px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    }

    .header-box h5 {
        font-weight: 600;
        color: #007bff;
        margin-bottom: 10px;
    }

    h3,h2{
        color:#007bff;
        font-weight:bold;
    }

    .header-box p {
        margin: 0;
        line-height: 1.6;
        color: #495057;
    }

    .header-box strong {
        color: #343a40;
    }

    /* ===== Table Styling ===== */
    .award-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
        background: #fff;
        box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }

    .award-table th {
        background: #007bff;
        color: white;
        text-align: left;
        padding: 10px;
        font-weight: 500;
        font-size: 14px;
    }

    .award-table td {
        padding: 8px 10px;
        border-bottom: 1px solid #dee2e6;
        font-size: 14px;
        color: #212529;
        vertical-align: middle;
    }

    .award-table tr:hover {
        background-color: #f8f9fa;
        transition: 0.2s ease-in-out;
    }

    /* ===== Image Styling ===== */
    .award-table img {
        border-radius: 6px;
        border: 1px solid #dee2e6;
        object-fit: cover;
    }

    /* ===== Responsive ===== */
    @media (max-width: 768px) {
        .header-box {
            padding: 10px;
        }

        .award-table th, .award-table td {
            font-size: 13px;
            padding: 6px;
        }

        .award-table img {
            width: 50px;
            height: 50px;
        }
    }
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3 class="text-center mb-4">Award Distribution Details</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Detailed Award Record</h2>
                    <div class="clearfix"></div>
                </div>

                <div class="x_content table-container">
                  

            <asp:Repeater ID="rptHeader" runat="server" OnItemDataBound="rptHeader_ItemDataBound">
                <ItemTemplate>
                    <table class="table table-bordered table-sm header-table mb-3">
            <thead class="table-light">
                <tr>
                    <th>Award ID</th>
                    <th>Award Date</th>
                    <th>Event Name</th>
                    <th>Submitted Date</th>
                    <th>Submitted Time</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%# Eval("Award_ID") %></td>
                    <td><%# Eval("DateOfAwardDistribution", "{0:yyyy-MM-dd}") %></td>
                    <td><%# Eval("EventName") %></td>
                    <td><%# Eval("SubmittedDate", "{0:yyyy-MM-dd}") %></td>
                    <td>
    <%# Eval("SubmittedTime") != DBNull.Value 
        ? DateTime.Today.Add(TimeSpan.Parse(Eval("SubmittedTime").ToString())).ToString("hh:mm tt") 
        : "" %>
</td>

                </tr>
            </tbody>
        </table>
                    </div>

                    <asp:Repeater ID="rptDetails" runat="server" DataSource='<%# Eval("Awardees") %>'>
                        <HeaderTemplate>
                            <table class="table table-bordered table-striped award-table">
                                <thead class="table-light">
                                    <tr>
                                        <th>Employee ID</th>
                                        <th>Employee Name</th>
                                        <th>Designation</th>
                                        <th>Award Category</th>
                                        <th>Photo</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("EmpId") %></td>
                                <td><%# Eval("EmpName") %></td>
                                <td><%# Eval("Designation") %></td>
                                <td><%# Eval("AwardCategory") %></td>
                                <td>
                                    <asp:Image ID="imgPhoto" runat="server" ImageUrl='<%# Eval("ImagePath") %>' 
                                        Width="70px" Height="70px" AlternateText="No Image" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </ItemTemplate>
            </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
