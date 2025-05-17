<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Grinding_Report.aspx.cs" Inherits="AnmolDristi.Grinding_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        @media print {
            @page {
                size: A4;
                margin: 20mm;
            }
            .no-print {
                display: none !important;
            }
        }

        body {
            background-color: white;
            font-family: 'Segoe UI', sans-serif;
        }

        .report-container {
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px 40px;
            background-color: white;
            box-sizing: border-box;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 8px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        .tick {
            color: green;
        }

        .cross {
            color: red;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="report-container">
        <h2>Grinding Machine Checklist Report</h2>
        <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="print-btn" OnClientClick="window.print(); return false;" />

        <asp:GridView ID="gvChecklistReport" runat="server" AutoGenerateColumns="False" CssClass="table">
            <Columns>
                <asp:BoundField DataField="Site" HeaderText="Site" />
                <asp:BoundField DataField="DateOfInspection" HeaderText="Inspection Date" DataFormatString="{0:yyyy-MM-dd}" />

                <asp:BoundField DataField="InspectedBy" HeaderText="Inspected By" />
                <asp:BoundField DataField="SerialNo" HeaderText="SI No" />
                <asp:BoundField DataField="IdentificationNumber" HeaderText="Identification Number" />
                <asp:BoundField DataField="Location" HeaderText="Location" />
              
                <%-- Checklist Fields --%>
                <asp:TemplateField HeaderText="Fore Handle">
                    <ItemTemplate>
                        <asp:Label ID="lblForeHandle" runat="server" Text='<%# Eval("ForeHandle") == "Yes" ? "✔" : "✖" %>' CssClass='<%# Eval("ForeHandle") == "Yes" ? "tick" : "cross" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Wheel Guard">
                    <ItemTemplate>
                        <asp:Label ID="lblWheelGuard" runat="server" Text='<%# Eval("WheelGuard") == "Yes" ? "✔" : "✖" %>' CssClass='<%# Eval("WheelGuard") == "Yes" ? "tick" : "cross" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Grinding Wheel Condition">
                    <ItemTemplate>
                        <asp:Label ID="lblGrindingWheelCondition" runat="server" Text='<%# Eval("GrindingWheelCondition") == "Yes" ? "✔" : "✖" %>' CssClass='<%# Eval("GrindingWheelCondition") == "Yes" ? "tick" : "cross" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Rear Handles">
                    <ItemTemplate>
                        <asp:Label ID="lblRearHandles" runat="server" Text='<%# Eval("RearHandles") == "Yes" ? "✔" : "✖" %>' CssClass='<%# Eval("RearHandles") == "Yes" ? "tick" : "cross" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cord Strain Reliever">
                    <ItemTemplate>
                        <asp:Label ID="lblCordStrainReliever" runat="server" Text='<%# Eval("CordStrainReliever") == "Yes" ? "✔" : "✖" %>' CssClass='<%# Eval("CordStrainReliever") == "Yes" ? "tick" : "cross" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Trigger Switch">
                    <ItemTemplate>
                        <asp:Label ID="lblTriggerSwitch" runat="server" Text='<%# Eval("TriggerSwitch") == "Yes" ? "✔" : "✖" %>' CssClass='<%# Eval("TriggerSwitch") == "Yes" ? "tick" : "cross" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Switch Lock">
                    <ItemTemplate>
                        <asp:Label ID="lblSwitchLock" runat="server" Text='<%# Eval("SwitchLock") == "Yes" ? "✔" : "✖" %>' CssClass='<%# Eval("SwitchLock") == "Yes" ? "tick" : "cross" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Power Cable">
                    <ItemTemplate>
                        <asp:Label ID="lblPowerCable" runat="server" Text='<%# Eval("PowerCable") == "Yes" ? "✔" : "✖" %>' CssClass='<%# Eval("PowerCable") == "Yes" ? "tick" : "cross" %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Final_Remarks" HeaderText="Final Remarks" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
