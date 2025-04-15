<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="csm_massmeeting_rpt.aspx.cs" Inherits="AnmolDristi.csm_massmeeting_rpt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CSM | Mass Meeting Report</title>
    <style type="text/css">
        .printable_box {
            width: 844px;
            height: 1144px;
            border: 1px solid black;
        }

        .header_table {
            width: 100%;
            border: 1px solid blue;
        }

        .tbl_hdr_thead {
            width: 100%;
        }

        .tbl_hdr_tr {
            width: 100%;
            border: 1px solid red;
        }
        .tbl_hdr_td{
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="print_box" runat="server" class="printable_box">
            <div id="content" runat="server" class="content_box">
                <table id="header_contents" class="header_table">
                    <thead id="header_tbl_hd" class="tbl_hdr_thead">
                        <tr id="header_tbl_tr" class="tbl_hdr_tr">
                            <td style="width:25%;" id="MM_Id_Display" class="tbl_hdr_td">
                                <asp:Label ID="lbl_mmid" runat="server" Text="Label1"></asp:Label>
                            </td>
                            <td style="width:50%;" class="tbl_hdr_td" rowspan="3">
                                <asp:Label ID="lbl_report_title" runat="server" Text="Label2" Font-Bold="true" Font-Size="Large"></asp:Label>
                            </td>
                            <td style="width:25%;" id="MM_Date_Display" class="tbl_hdr_td">
                                <asp:Label ID="lbl_mmdate" runat="server" Text="Label2"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:25%;">
                                <asp:Image ID="Image1" runat="server" Width="10px" Height="10px"/>
                            </td>
                            <td style="width:25%;">
                                <asp:Image ID="Image2" runat="server" Width="10px" Height="10px"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:25%;">

                            </td>
                            <td style="width:25%;">

                            </td>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </form>
</body>
</html>
