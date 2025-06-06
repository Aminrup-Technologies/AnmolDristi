<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Committee_meeting_update.aspx.cs" Inherits="AnmolDristi.Committee_meeting_update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <style>
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
    .gv-input {
    width: 160px; /* consistent fixed width for all textboxes */
    height: 38px; /* standard Bootstrap input height */
    font-size: 14px;
    padding: 5px 10px;
    box-sizing: border-box;
  }


    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h3>Safety Committee Meeting 
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>DOC/ATS/OSH/CM-04 | Eff.Date: 19/12/2018</h2>
                        <div class="clearfix"></div>
                    </div>

                    <div class="x_content">

                        
      <div class="row">  
                                    
      <div class="col-md-4">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Meeting Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
    <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_txtTime" runat="server" AssociatedControlID="txtTime" Text="Meeting Time" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtTime" runat="server" ErrorMessage="*" ControlToValidate="txtTime" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtTime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
        </div>
    </div>
</div>
     <div class="col-md-4">
     <div class="mb-3">
         <asp:Label ID="lbl_txtVenue" runat="server" AssociatedControlID="txtVenue" Text="Venue" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtVenue" runat="server" ErrorMessage="*" ControlToValidate="txtVenue" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtVenue" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
    <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_txtMeetingNo" runat="server" AssociatedControlID="txtMeetingNo" Text="Meeting Number" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtMeetingNo" runat="server" ErrorMessage="*" ControlToValidate="txtMeetingNo" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtMeetingNo" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
        </div>
    </div>
</div>
    <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_txtChairedBy" runat="server" AssociatedControlID="txtChairedBy" Text="Chaired By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtChairedBy" runat="server" ErrorMessage="*" ControlToValidate="txtChairedBy" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtChairedBy" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
        </div>
    </div>
</div>
        <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_txtjobID" runat="server" AssociatedControlID="txtjobID" Text="Job ID" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtjobID" runat="server" ErrorMessage="*" ControlToValidate="txtjobID" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtjobID" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>
                                 
                                    </div>

 <div class="x_title">
     <h2 class="text-info h4">Attendance Table</h2>
     <div class="clearfix"></div>
 </div>
                
                 
<%--<div class="col-md-2">
       <div class="mb-3">
           <asp:Label ID="lbl_imgupload" runat="server" AssociatedControlID="imgupload" Text="Upload Photo" ForeColor="Blue" Font-Bold="true"></asp:Label>
           <asp:RequiredFieldValidator ID="RFV_imgupload" runat="server" ErrorMessage="*" ControlToValidate="imgupload" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
           <div class="input-group-sm">
               <asp:FileUpload ID="imgupload" runat="server" CssClass="form-control form-control-sm rounded" />
                <asp:Label ID="lblBeforeError" runat="server" CssClass="text-danger" Style="display:none;"></asp:Label>
           </div>
            <asp:Image ID="imgPreview" runat="server" 
               Width="150px" Height="150px" 
               AlternateText="No photo uploaded" 
               Visible="false" CssClass="mt-2 img-thumbnail" />
       </div>
   </div>--%>
                        
    <%--</div>
    --%>
      
    
    

    <div class="table-responsive">
         <div class="col-md-6">
             <div class="mb-3">
    <asp:GridView ID="gvAttendees" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-sm table-hover table-striped nowrap" GridLines="None"   DataKeyNames="AttendanceID"> 
        <HeaderStyle BackColor="#2C3E50" ForeColor="#ECF0F1" Font-Bold="true" Font-Size="Small" Font-Names="Segoe UI" HorizontalAlign="Center" />
    <Columns>
        <asp:BoundField DataField="AttendanceID" HeaderText="SNo" Visible="false" />
         <asp:TemplateField HeaderText="Attendee Type">
  <ItemTemplate>
 <asp:TextBox ID="txtAttendeeType" runat="server" Text='<%# Eval("Attendee_Type") %>' CssClass="form-control gv-input" />
  </ItemTemplate>
  </asp:TemplateField>
         <asp:TemplateField HeaderText="Employee Name ">
  <ItemTemplate>
 <asp:TextBox ID="txtEmployeeName" runat="server" Text='<%# Eval("Name") %>' CssClass="form-control gv-input" />
  </ItemTemplate>
  </asp:TemplateField>
         <asp:TemplateField HeaderText="Attendee Code">
  <ItemTemplate>
 <asp:TextBox ID="txtAttendeeCode" runat="server" Text='<%# Eval("AttendeeCode") %>' CssClass="form-control gv-input" />
  </ItemTemplate>
  </asp:TemplateField>
         <asp:TemplateField HeaderText="Attendance Status">
   <ItemTemplate>
    <asp:DropDownList ID="ddlAttendanceStatus" runat="server" CssClass="form-control form-control-sm rounded gv-input" SelectedValue='<%# Eval("AttendanceStatus") %>' >
   <asp:ListItem Text="Select" Value="" />
   <asp:ListItem Text="Attend" Value="Attend" />
   <asp:ListItem Text="Absent" Value="Absent" />
</asp:DropDownList>
       </ItemTemplate>
      </asp:TemplateField>
         <asp:TemplateField HeaderText="Designation">
  <ItemTemplate>
 <asp:TextBox ID="txtDesignation" runat="server" Text='<%# Eval("Designation") %>' CssClass="form-control gv-input" />
  </ItemTemplate>
  </asp:TemplateField>
       <%--  <asp:TemplateField HeaderText="Image Preview">
          <ItemTemplate>
    <!-- Larger Image -->
    <asp:Image ID="imgPreview" runat="server" 
        ImageUrl='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' 
        Width="90px" Height="90px" Style="object-fit:cover;" />

    <!-- Hidden field to retain existing image path -->
    <asp:Label ID="lblimgPreview" runat="server" 
        Text='<%# Eval("ImagePath") %>' Visible="false" />

    <!-- Upload control to select a new image -->
    <br />
    <asp:FileUpload ID="fuimgPreview" runat="server" />
</ItemTemplate>
  </asp:TemplateField>--%>
      <asp:TemplateField HeaderText="Action">
        <ItemTemplate>
           <asp:Button ID="BtnDelAttendees" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"  OnClick="BtnDelAttendees_Click" OnClientClick="return confirm('Are you sure you want to delete?');" />
           
       </ItemTemplate>
 </asp:TemplateField>
    </Columns>
</asp:GridView>
                 </div>
             </div>
        </div>

    


  <div class="x_title">
     <h2 class="text-info h4">Meeting Issue Table</h2>
     <div class="clearfix"></div>
 </div>                         

             
    <div class="table-responsive">
         <div class="col-md-6">
             <div class="mb-3">
    <asp:GridView ID="gvIssues" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-sm table-hover table-striped nowrap" GridLines="None"   DataKeyNames="IssueID"> 
        <HeaderStyle BackColor="#2C3E50" ForeColor="#ECF0F1" Font-Bold="true" Font-Size="Small" Font-Names="Segoe UI" HorizontalAlign="Center" />
    <Columns>
        <asp:BoundField DataField="IssueID" HeaderText="SNo" Visible="false" />
         <asp:TemplateField HeaderText="Agenda Title">
  <ItemTemplate>
 <asp:TextBox ID="txtAgendaTitle" runat="server" Text='<%# Eval("AgendaTitle") %>' CssClass="form-control gv-input" />
  </ItemTemplate>
  </asp:TemplateField>
         <asp:TemplateField HeaderText="Issues Discussed">
  <ItemTemplate>
 <asp:TextBox ID="txtIssuesDiscussed" runat="server" Text='<%# Eval("IssuesDiscussed") %>' CssClass="form-control gv-input" />
  </ItemTemplate>
  </asp:TemplateField>
         <asp:TemplateField HeaderText="Action By">
  <ItemTemplate>
 <asp:TextBox ID="txtActionBy" runat="server" Text='<%# Eval("ActionBy") %>' CssClass="form-control gv-input" />
  </ItemTemplate>
  </asp:TemplateField>
         
         <asp:TemplateField HeaderText="Target Date">
  <ItemTemplate>
 <asp:TextBox ID="txtTargetDate" runat="server" Text='<%# Eval("TargetDate","{0:yyyy-MM-dd}") %>' TextMode="Date" CssClass="form-control gv-input" />
  </ItemTemplate>
  </asp:TemplateField>
                <asp:TemplateField HeaderText="Review Date">
 <ItemTemplate>
<asp:TextBox ID="txtReviewDate" runat="server" Text='<%# Eval("ReviewDate","{0:yyyy-MM-dd}") %>' TextMode="Date" CssClass="form-control gv-input" />
 </ItemTemplate>
 </asp:TemplateField>
  <asp:TemplateField HeaderText="Review By">
 <ItemTemplate>
<asp:TextBox ID="txtReviewBy" runat="server" Text='<%# Eval("ReviewBy") %>'  CssClass="form-control gv-input" />
 </ItemTemplate>
 </asp:TemplateField>
         <asp:TemplateField HeaderText="Status">
     <ItemTemplate>
         <asp:DropDownList ID="ddlStattus" runat="server" CssClass="form-control form-control-sm rounded gv-input" SelectedValue='<%# Eval("Status") %>'>
             <asp:ListItem Text="Select" Value="" />
             <asp:ListItem Text="Pending" Value="Pending" />
             <asp:ListItem Text="Completed" Value="Completed" />
             <asp:ListItem Text="In Progress" Value="In Progress" />
             <asp:ListItem Text="Approved" Value="Approved" />
             <asp:ListItem Text="Rejected" Value="Rejected" />
             <asp:ListItem Text="On Hold" Value="On Hold" />
         </asp:DropDownList>
     </ItemTemplate>
 </asp:TemplateField>
      <asp:TemplateField HeaderText="Action">
        <ItemTemplate>
           <asp:Button ID="BtnDelIssues" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"  OnClick="BtnDelIssues_Click" OnClientClick="return confirm('Are you sure you want to delete?');" />
          
      </ItemTemplate>
 </asp:TemplateField>
    </Columns>
</asp:GridView>
                 </div>
             </div>
        </div>

                         
                         <div class="x_title">
    <h2 class="text-info h4">Meeting Image</h2>
    <div class="clearfix"></div>
</div>                         
 <div class="col-md-4">
        <div class="mb-3">
            <asp:Label ID="lbl_imgupload" runat="server" AssociatedControlID="imgupload" Text="Upload Photo" ForeColor="Blue" Font-Bold="true"></asp:Label>
            <asp:RequiredFieldValidator ID="RFV_imgupload" runat="server" ErrorMessage="*" ControlToValidate="imgupload" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            <div class="input-group-sm">
                <asp:FileUpload ID="imgupload" runat="server" CssClass="form-control form-control-sm rounded" />
                 <asp:Label ID="lblBeforeError" runat="server" CssClass="text-danger" Style="display:none;"></asp:Label>
            </div>
                 <asp:Image ID="imgPreview" runat="server" 
        Width="150px" Height="150px" 
        AlternateText="No photo uploaded" 
        Visible="false" CssClass="mt-2 img-thumbnail" />
</div>
        </div>

   


                   
                </div>
            </div>


           <%-- <%--Button--%>
           <div class="col-md-3">
                <div class="mb-3">
                    <asp:Label ID="lblbtnUpdate" runat="server" AssociatedControlID="btnUpdate" Text="Click to Update" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group input-group-sm">
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success btn-sm"  CausesValidation="true" OnClick="btnUpdate_Click" />   
                        <asp:Button ID="Btnback" runat="server" Text="Back" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="Btnback_Click" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
    
</div>
</asp:Content>
