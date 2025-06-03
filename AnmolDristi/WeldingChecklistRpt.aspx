<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WeldingChecklistRpt.aspx.cs" Inherits="AnmolDristi.WeldingChecklistRpt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welding Checklist Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        .header {
            font-size: 24px;
            font-weight: bold;
            color: green;
            margin-bottom: 20px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 30px;
        }
        th, td {
            border: 1px solid #aaa;
            padding: 10px;
            text-align: left;
            vertical-align: top;
        }
        th {
            background-color: #f2f2f2;
        }
        .check-icon {
            font-size: 18px;
            color: green;
        }
        .cross-icon {
            font-size: 18px;
            color: red;
        }
        .photo-thumb {
            height: 60px;
        }
    </style>
</head>
<body>
   <form id="form1" runat="server">
        <div>
            <div class="header">Welding Checklist Report</div>

            <table>
                <tr>
                    <th>Date</th>
                    <td><asp:Label ID="lblDate" runat="server" /></td>
                    <th>Job ID</th>
                    <td><asp:Label ID="lblJobID" runat="server" /></td>
                </tr>
                <tr>
                    <th>Location</th>
                    <td><asp:Label ID="lblLocation" runat="server" /></td>
                    <th>Inspected By</th>
                    <td><asp:Label ID="lblInspectedBy" runat="server" /></td>
                </tr>
                <tr>
                    <th>Employee Name</th>
                    <td><asp:Label ID="lblEmployeeName" runat="server" /></td>
                    <th>Remarks</th>
                    <td><asp:Label ID="lblRemarks" runat="server" /></td>
                </tr>
            </table>

            <asp:Repeater ID="rptChecklist" runat="server">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <th>SNo</th>
                            <th>Points</th>
                            <th>Remarks</th>
                            <th>Photo</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                        <tr>
                            <td><%# Eval("Description") %></td>
                            <td>
                                <%# Convert.ToBoolean(Eval("IsOk")) ? "✔️" :
                                    Convert.ToBoolean(Eval("NA")) ? "N/A" : "❌" %>
                            </td>
                            <td><%# Eval("Remarks") %></td>
                            <td>
                                <%# !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ?
                                    $"<img src='{Eval("PhotoPath")}' class='photo-thumb' />" : "" %>
                            </td>
                        </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

              <asp:Repeater ID="rptTerminals" runat="server">
      <HeaderTemplate>
          <table>
              <tr>
                  <th>SNo</th>
                  <th>Points</th>
                  <th>Remarks</th>
                  <th>Photo</th>
              </tr>
      </HeaderTemplate>
      <ItemTemplate>
              <tr>
                  <td><%# Eval("Description") %></td>
                  <td>
                      <%# Convert.ToBoolean(Eval("IsOk")) ? "✔️" :
                          Convert.ToBoolean(Eval("NA")) ? "N/A" : "❌" %>
                  </td>
                  <td><%# Eval("Remarks") %></td>
                  <td>
                      <%# !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ?
                          $"<img src='{Eval("PhotoPath")}' class='photo-thumb' />" : "" %>
                  </td>
              </tr>
      </ItemTemplate>
      <FooterTemplate>
          </table>
      </FooterTemplate>
  </asp:Repeater>

              <asp:Repeater ID="rptCables" runat="server">
      <HeaderTemplate>
          <table>
              <tr>
                  <th>SNo</th>
                  <th>Points</th>
                  <th>Remarks</th>
                  <th>Photo</th>
              </tr>
      </HeaderTemplate>
      <ItemTemplate>
              <tr>
                  <td><%# Eval("Description") %></td>
                  <td>
                      <%# Convert.ToBoolean(Eval("IsOk")) ? "✔️" :
                          Convert.ToBoolean(Eval("NA")) ? "N/A" : "❌" %>
                  </td>
                  <td><%# Eval("Remarks") %></td>
                  <td>
                      <%# !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ?
                          $"<img src='{Eval("PhotoPath")}' class='photo-thumb' />" : "" %>
                  </td>
              </tr>
      </ItemTemplate>
      <FooterTemplate>
          </table>
      </FooterTemplate>
  </asp:Repeater>

              <asp:Repeater ID="rptElectrodeHolder" runat="server">
      <HeaderTemplate>
          <table>
              <tr>
                  <th>SNo</th>
                  <th>Points</th>
                  <th>Remarks</th>
                  <th>Photo</th>
              </tr>
      </HeaderTemplate>
      <ItemTemplate>
              <tr>
                  <td><%# Eval("Description") %></td>
                  <td>
                      <%# Convert.ToBoolean(Eval("IsOk")) ? "✔️" :
                          Convert.ToBoolean(Eval("NA")) ? "N/A" : "❌" %>
                  </td>
                  <td><%# Eval("Remarks") %></td>
                  <td>
                      <%# !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ?
                          $"<img src='{Eval("PhotoPath")}' class='photo-thumb' />" : "" %>
                  </td>
              </tr>
      </ItemTemplate>
      <FooterTemplate>
          </table>
      </FooterTemplate>
  </asp:Repeater>

              <asp:Repeater ID="rptWorkArea" runat="server">
      <HeaderTemplate>
          <table>
              <tr>
                  <th>SNo</th>
                  <th>Points</th>
                  <th>Remarks</th>
                  <th>Photo</th>
              </tr>
      </HeaderTemplate>
      <ItemTemplate>
              <tr>
                  <td><%# Eval("Description") %></td>
                  <td>
                      <%# Convert.ToBoolean(Eval("IsOk")) ? "✔️" :
                          Convert.ToBoolean(Eval("NA")) ? "N/A" : "❌" %>
                  </td>
                  <td><%# Eval("Remarks") %></td>
                  <td>
                      <%# !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ?
                          $"<img src='{Eval("PhotoPath")}' class='photo-thumb' />" : "" %>
                  </td>
              </tr>
      </ItemTemplate>
      <FooterTemplate>
          </table>
      </FooterTemplate>
  </asp:Repeater>

        </div>
    </form>
</body>
</html>
