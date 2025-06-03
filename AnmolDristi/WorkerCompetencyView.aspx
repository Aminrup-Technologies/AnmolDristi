<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="WorkerCompetencyView.aspx.cs" Inherits="AnmolDristi.WorkerCompetencyView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="right_col" role="main">
     <div class="container">
         <%--<div class="page-title">
             <div class="title_left">
                 <h3>
                 </h3>
             </div>
         </div>--%>

         <div class="row">
             <div class="col-md-12 col-sm-12 ">
                 <div class="x_panel">
                     <div class="x_title">
                         <h2>Competency Assessment View</h2>
                         
                         <div class="clearfix"></div>
                     </div>

                     <div class="x_content">

                <div class="col-md-6">
     <div class="mb-3">
         <asp:Label ID="lbl_txtfromdate" runat="server" AssociatedControlID="txtfromdate" Text="From Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtfromdate" runat="server" ErrorMessage="*" ControlToValidate="txtfromdate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtfromdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
 <div class="col-md-6">
     <div class="mb-3">
         <asp:Label ID="Lbl_txttodate" runat="server" AssociatedControlID="txttodate" Text="To Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txttodate" runat="server" ErrorMessage="*" ControlToValidate="txttodate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txttodate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>



 <div class="col-md-3">
     <div class="mb-3">
         <asp:Button ID="BtnSearch" runat="server" Text="Search" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSearch_Click" />
         <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-sm btn-danger" CausesValidation="false" OnClick="BtnReset_Click" />
         <asp:Button ID="btn_home" runat="server" Text="Back" CssClass="btn btn-sm btn-primary" CausesValidation="false" PostBackUrl="~/Home.aspx" />
         <asp:Label ID="lblMsg" runat="server"></asp:Label>
     </div>
 </div>

 <div class="table-responsive">
     <div class="col-md-4">
         <div class="mb-3">
             <asp:GridView ID="gvRecords" runat="server" AutoGenerateColumns="False" DataKeyNames="AssessmentID" CssClass="table table-bordered table-sm table-hover table-striped nowrap" GridLines="None">

                 <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
                 <Columns>
                     <asp:BoundField DataField="AssessmentID" HeaderText="SNo" Visible="false" />
                     <asp:BoundField DataField="Date" HeaderText="Date"  />
                     <asp:BoundField DataField="NameOfWorkman" HeaderText="Name" />
                     <asp:BoundField DataField="Designation" HeaderText="Designation" />
                     <asp:BoundField DataField="TechnicalKnowledge" HeaderText="TechnicalKnowledge" Visible="false" />
                     <asp:BoundField DataField="TechnicalSkills" HeaderText="TechnicalSkills" Visible="false" />
                     <asp:BoundField DataField="ConsistencyInJob" HeaderText="Consistency In Job" Visible="false" />
                     <asp:BoundField DataField="JobQuality" HeaderText="Job Quality" Visible="false" />
                     <asp:BoundField DataField="SafetyAwareness" HeaderText="Safety Awareness" Visible="false" />
                     <asp:TemplateField HeaderText="Actions">
                         <ItemTemplate>
                             <asp:Button ID="BtnEdit" runat="server" Text="Edit" CssClass="btn btn-warning btn-sm" CommandArgument='<%# Eval("AssessmentID") %>' OnClick="BtnEdit_Click" />
                             <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm" OnClick="BtnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete this meeting?');" />
                            <asp:Button ID="BtnView" runat="server" Text="View" CssClass="btn btn-primary btn-sm" CommandArgument='<%# Eval("AssessmentID") %>' OnClick="BtnView_Click" />

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
 </div>
 <script type="text/javascript">
     document.addEventListener("DOMContentLoaded", function () {
         var fromDate = document.getElementById('<%= txtfromdate.ClientID %>');
         var toDate = document.getElementById('<%= txttodate.ClientID %>');

         if (fromDate && toDate) {
             toDate.addEventListener("change", function () {
                 validateDates(fromDate, toDate);
             });
         }
     });

     function validateDates(fromDateElement, toDateElement) {
         var fromDate = fromDateElement.value;
         var toDate = toDateElement.value;

         if (fromDate && toDate) {
             var from = new Date(fromDate);
             var to = new Date(toDate);

             if (from > to) {
                 alert("Invalid Date!.");
                 toDateElement.value = ""; // Clear To Date field
             }
         }
     }


 </script>
   
</asp:Content>
