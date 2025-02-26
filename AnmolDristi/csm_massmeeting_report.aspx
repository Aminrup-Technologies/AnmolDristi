<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="csm_massmeeting_report.aspx.cs" Inherits="AnmolDristi.csm_massmeeting_report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            



 <div class="right_col" role="main">
     <div class="container">
         <div class="page-title">
             <div class="title_left">
                 <h3>CSM MASS MEETING REPORT SHEET
                 </h3>
             </div>
         </div>

         <div class="row">
             <div class="col-md-12 col-sm-12 ">
                 <div class="x_panel">
                     <div class="x_title">
                         <h2>ATS/DOC/MM/0010
                         </h2>
                         <div class="clearfix"></div>
                     </div>

                     <div class="x_content">
                          <div class="col-md-12">
                             <div class="mb-3">
      <%--  <asp:GridView ID="gvMeetings" runat="server" AutoGenerateColumns="False" DataKeyNames="Meeting_ID" CssClass="table table-striped table-bordered table-hover ">
        <Columns>
        <asp:BoundField DataField="Meeting_Time" HeaderText="Time" />
        <asp:BoundField DataField="Meeting_Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="Location" HeaderText="Location" />
        <asp:BoundField DataField="Employee_Name" HeaderText="Employee Name" />
        <asp:BoundField DataField="Designation" HeaderText="Designation" />
        <asp:BoundField DataField="RFID" HeaderText="RFID" />
        <asp:BoundField DataField="Points_Discussed" HeaderText="Points Discussed" />
        <asp:TemplateField HeaderText="Actions">
        <ItemTemplate>
        <asp:Button ID="BtnUpdate" runat="server" Text="Update" CssClass="btn btn-success btn-sm" OnClick="BtnUpdate_Click" />
        <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm" OnClick="BtnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete this meeting?');" />
        </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>--%>
<asp:GridView ID="gvMeetings" runat="server" AutoGenerateColumns="False" DataKeyNames="Meeting_ID" CssClass="table table-striped table-bordered table-hover">
    <Columns>
        <asp:TemplateField HeaderText="Time">
            <ItemTemplate>
                <asp:TextBox ID="txtMeetingTime" runat="server" Text='<%# Bind("Meeting_Time") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>
        
        <asp:TemplateField HeaderText="Date">
            <ItemTemplate>
                <asp:TextBox ID="txtMeetingDate" runat="server" Text='<%# Bind("Meeting_Date", "{0:yyyy-MM-dd}") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Location">
            <ItemTemplate>
                <asp:TextBox ID="txtLocation" runat="server" Text='<%# Bind("Location") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Employee Name">
            <ItemTemplate>
                <asp:TextBox ID="txtEmployeeName" runat="server" Text='<%# Bind("Employee_Name") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Designation">
            <ItemTemplate>
                <asp:TextBox ID="txtDesignation" runat="server" Text='<%# Bind("Designation") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="RFID">
            <ItemTemplate>
                <asp:TextBox ID="txtRFID" runat="server" Text='<%# Bind("RFID") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Points Discussed">
            <ItemTemplate>
                <asp:TextBox ID="txtPointsDiscussed" runat="server" Text='<%# Bind("Points_Discussed") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:Button ID="BtnUpdate" runat="server" Text="Update" CssClass="btn btn-success btn-sm" OnClick="BtnUpdate_Click" />
                <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm" OnClick="BtnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete this meeting?');" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>



                          </div>
                        </div>
                    </div>
                 </div>
             </div>

               <div class="col-md-3">
              <div class="mb-3">
          <div class="input-group input-group-sm">
              <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClientClick="BtnReset_Click" />
              <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/Home.aspx" />
          </div>
      </div>
  </div>

            
            
         </div>
     </div>
 </div>
</asp:Content>
