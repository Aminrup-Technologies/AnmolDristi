<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="MassMeeting_Report.aspx.cs" Inherits="AnmolDristi.MassMeeting_Report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style type="text/css">
     .btn-fixed-size {
         width: 100px;
         text-align: center;
         font-size: 14px;
         padding: 5px 0;
     }

     .points-input {
         margin-right: 10px;
     }

     .container {
         padding: 20px;
     }

     

     #gvAudit th, #gvAudit td {
         white-space: nowrap;
     }


     .table-responsive {
         width: 100%;
         max-height: 400px; /* Adjust based on need */
         overflow-x: auto;
         overflow-y: auto;
         -webkit-overflow-scrolling: touch;
     }

     @media (max-width: 768px) {
         .table-responsive {
             max-height: 300px; /* Adjust based on your UI */
         }
     }
 </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <div class="right_col" role="main">
     <div class="container">
         <div class="page-title">
             <div class="title_left">
                 <h3>Mass Meeting Edit Sheet
                 </h3>
             </div>
         </div>

         <div class="row">
             <div class="col-md-12 col-sm-12 ">
                 <div class="x_panel">
                     <div class="x_title">
                         <h2>Mass Meeting Report
                         </h2>
                         <div class="clearfix"></div>
                     </div>

                     <div class="x_content">
                        

                          <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_FromDate" runat="server" AssociatedControlID="TB_FromDate" Text="From Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_TB_FromDate" runat="server" ErrorMessage="*" ControlToValidate="TB_FromDate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="TB_FromDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>


<div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="Lbl_ToDate" runat="server" AssociatedControlID="TB_ToDate" Text="To Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_TB_ToDate" runat="server" ErrorMessage="*" ControlToValidate="TB_ToDate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="TB_ToDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>



     <div class="col-md-3">
     <div class="mb-3">
             <asp:Button ID="BtnSubmit" runat="server" Text="Search" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
             <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-sm btn-danger" CausesValidation="false" OnClientClick="BtnReset_Click" />
     </div>
 </div>
                         

                       <div class="table-responsive">
                       <div class="x_content">
                       <div class="col-md-12">
                             <div class="mb-3">
      <asp:GridView ID="GVMeetings" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" CssClass="table table-striped table-bordered table-hover ">
       
        <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
        <Columns>
        <asp:BoundField DataField="Id" HeaderText="ID" />
        <asp:BoundField DataField="MM_DocNo" HeaderText="Document Number "  />
        <asp:BoundField DataField="Meeting_Date" HeaderText="Date" />
        <asp:BoundField DataField="SubmitterCode" HeaderText="Submitter Code" />
        <asp:BoundField DataField="CompanyCode" HeaderText="Company Code" />
        <asp:BoundField DataField="DeptCode" HeaderText="Department Code" />
        <asp:BoundField DataField="ExactLocation" HeaderText="Exact Location" />
        <asp:BoundField DataField="Coordinator_Name" HeaderText="Coordinator Name" />
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
           <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-warning btn-sm" CommandArgument='<%# Eval("Id") %>' OnClick="BtnEdit_Click" />
           <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm" OnClick="BtnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete this meeting?');" />
            <asp:Button ID="BtnView" runat="server" Text="View" CssClass="btn btn-primary btn-sm" CommandArgument='<%# Eval("Id") %>'  OnClick="BtnView_Click" />
        
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


             <%--Button--%>
             
             </div>
         </div>
         </div>
</asp:Content>
