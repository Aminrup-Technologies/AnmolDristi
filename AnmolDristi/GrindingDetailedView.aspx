<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="GrindingDetailedView.aspx.cs" Inherits="AnmolDristi.GrindingDetailedView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                    <h3>Grinding Detailed View</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">

                    <div class="section-title">Grinding Machine Basic Details</div>
                    <div class="responsive-wrapper">
                        <asp:GridView ID="gvGrindingHeader" runat="server" CssClass="custom-grid" AutoGenerateColumns="False" GridLines="Both" BorderWidth="1">
                            <Columns>
                                <asp:BoundField DataField="Site" HeaderText="Site" />
                                <asp:BoundField DataField="DateOfInspection" HeaderText="Inspection Date" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:BoundField DataField="InspectedBy" HeaderText="Inspected By" />
                                <asp:BoundField DataField="SerialNo" HeaderText="Serial No" />
                                <asp:BoundField DataField="IdentificationNumber" HeaderText="ID Number" />
                                <asp:BoundField DataField="Location" HeaderText="Location" />
                                <asp:BoundField DataField="Final_Remarks" HeaderText="Final Remarks" />
                                <asp:BoundField DataField="JobID" HeaderText="Job ID" />
                                <asp:BoundField DataField="JobName" HeaderText="Job Name" />
                            </Columns>
                        </asp:GridView>
                    </div>

                    <div class="section-title">Grinding Machine Checklist</div>
                    <div class="responsive-wrapper">
                        <asp:GridView ID="gvGrindingChecklist" runat="server" CssClass="custom-grid" AutoGenerateColumns="False" GridLines="Both" BorderWidth="1" OnRowDataBound="gvGrindingChecklist_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Question" HeaderText="Question" />
                                <asp:TemplateField HeaderText="Is Yes">
                                    <ItemTemplate>
                                        <asp:Literal ID="litIsYes" runat="server"></asp:Literal>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                <asp:TemplateField HeaderText="Photo">
                                    <ItemTemplate>
                                        <asp:Image ID="imgPhoto" runat="server" CssClass="photo-img" ImageUrl='<%# Eval("PhotoPath") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="EntryDate" HeaderText="Entry Date" DataFormatString="{0:yyyy-MM-dd}" />
                            </Columns>
                        </asp:GridView>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
