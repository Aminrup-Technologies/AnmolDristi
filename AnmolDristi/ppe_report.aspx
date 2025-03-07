<%@ Page Title="PPE Report" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="ppe_report.aspx.cs" Inherits="AnmolDristi.ppe_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /*    .container {
            max-width: 100%;
            padding: 15px;
        }*/

        .table-wrapper {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin-left: 220px;
        }

        .table-responsive {
            overflow-x: auto;
            width: 100%;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

            .table th, .table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }

            .table th {
                background-color: #f4f4f4;
            }

        .btn {
            display: inline-block;
            padding: 8px 12px;
            font-size: 14px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }

            .btn:hover {
                background-color: #0056b3;
            }

        /* Responsive Design */
        @media screen and (max-width: 768px) {
            .table th, .table td {
                padding: 8px;
                font-size: 12px;
            }

            .btn {
                padding: 6px 10px;
                font-size: 12px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5>Workers PPE Checklist Report</h5>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_content">
                            <div class="col-md-12">
                                <div class="mb-3">

                                    <asp:GridView ID="GridView1" runat="server" CssClass="table"
                                        AutoGenerateColumns="False" DataKeyNames="id" OnRowCommand="GridView1_RowCommand">
                                        <Columns>
                                            <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" />
                                            <asp:BoundField DataField="inspection_by" HeaderText="Inspector" />
                                            <asp:BoundField DataField="Submitted_date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                                            <asp:BoundField DataField="worker_id" HeaderText="Worker ID" />
                                            <asp:BoundField DataField="worker_name" HeaderText="Worker Name" />
                                            <asp:BoundField DataField="designation" HeaderText="Designation" />

                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnViewMore" runat="server" CssClass="btn"
                                                        Text="View More" CommandName="ViewMore" CommandArgument='<%# Eval("id") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
