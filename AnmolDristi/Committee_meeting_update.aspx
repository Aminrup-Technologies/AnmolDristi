<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Committee_meeting_update.aspx.cs" Inherits="AnmolDristi.Committee_meeting_update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h3>Internal Safety Committee meeting 
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>DOC/ATS/OSH/CM-04</h2>
                        <div class="clearfix"></div>
                    </div>

                    <div class="x_content">

                        
      <div class="row">  
                                    
      <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Meeting Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
    <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtTime" runat="server" AssociatedControlID="txtTime" Text="Meeting Time" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtTime" runat="server" ErrorMessage="*" ControlToValidate="txtTime" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtTime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
        </div>
    </div>
</div>
     <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtVenue" runat="server" AssociatedControlID="txtVenue" Text="Venue" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtVenue" runat="server" ErrorMessage="*" ControlToValidate="txtVenue" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtVenue" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
    <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtMeetingNo" runat="server" AssociatedControlID="txtMeetingNo" Text="Meeting Number" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtMeetingNo" runat="server" ErrorMessage="*" ControlToValidate="txtMeetingNo" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtMeetingNo" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
        </div>
    </div>
</div>
    <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtChairedBy" runat="server" AssociatedControlID="txtChairedBy" Text="Chaired By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtChairedBy" runat="server" ErrorMessage="*" ControlToValidate="txtChairedBy" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtChairedBy" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
        </div>
    </div>
</div>
                                  <%--  <asp:HiddenField ID="hdnMeetingID" runat="server" />
   --%>
                                    </div>

 <div class="x_title">
     <h2>Attendance Table</h2>
     <div class="clearfix"></div>
 </div>
                
                 

      
    
    
         <div class="table-responsive">
         <div class="col-md-12">
             <div class="mb-3">
                 <asp:GridView ID="gvAttendees" runat="server"  CssClass="table table-bordered table-hover " AutoGenerateColumns="False">
                     <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
                     <Columns>
                         <asp:BoundField DataField="AttendeeType" HeaderText="Attendee Type" />
                         <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
                         <asp:BoundField DataField="AttendeeCode" HeaderText="Attendee Code" />
                         <asp:BoundField DataField="AttendanceStatus" HeaderText="Attendance Status" />
                         <asp:BoundField DataField="Designation" HeaderText="Designation" />
                         <asp:TemplateField HeaderText="Image Preview">
                           <ItemTemplate>
                             <asp:Image ID="imgPreview" runat="server" ImageUrl='<%# Eval("ImagePath") %>' Width="50px" Height="50px" />
                            </ItemTemplate>                      
                         </asp:TemplateField>
                               <asp:TemplateField HeaderText="Action">
                                 <ItemTemplate>
                                    <%-- <asp:Button ID="BtnDelAttendees" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"  OnClick="BtnDelAttendees_Click" OnClientClick="return confirm('Are you sure you want to delete?');" />--%>
                                </ItemTemplate>
                          </asp:TemplateField>
                     </Columns>
                 </asp:GridView>
             </div>
         </div>
             </div>
    


  <div class="x_title">
     <h2>Meeting Issue Table</h2>
     <div class="clearfix"></div>
 </div>                         

   
            <div class="table-responsive">
    <div class="col-md-12">
        <div class="mb-3">
    <asp:GridView ID="gvIssues" runat="server" AutoGenerateColumns="False" DataKeyNames="SNo" CssClass="table table-bordered table-hover ">
    <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
    <Columns>
        <asp:BoundField DataField="SNo" HeaderText="SNo" />
        <asp:BoundField DataField="AgendaTitle" HeaderText="Agenda Title" />
        <asp:BoundField DataField="IssuesDiscussed" HeaderText="Issues Discussed" />
        <asp:BoundField DataField="ActionBy" HeaderText="Action By" />
        <asp:BoundField DataField="TargetDate" HeaderText="Target Date" />
        <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" />
        <asp:BoundField DataField="ReviewBy" HeaderText="Review By" />
        <asp:BoundField DataField="Status" HeaderText="Status" />
        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>
<%--                 <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"  OnClick="BtnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete ?');" />--%>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
            </div>
        </div>
        </div>

             

                         


   


                   
                </div>
            </div>


           <%-- <%--Button--%>
        <%--   <div class="col-md-3">
                <div class="mb-3">
                    <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group input-group-sm">
                        <asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
                        
                        <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                        <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/Home.aspx" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        
                    </div>
                </div>
            </div>--%>

        </div>
    </div>
</div>
    
</div>
</asp:Content>
