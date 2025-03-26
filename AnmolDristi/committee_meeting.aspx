<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="committee_meeting.aspx.cs" Inherits="AnmolDristi.committee_meeting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .btnStyle {
    width: 120px;
    height: 35px;
    color: black;
    background-color: coral;
    font-size: 16px;
    text-align: center;
    border: none;
    border-radius: 5px;
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
                        
                  <div class="field" id="Attendees">
  <div class="col-md-6">
         <div class="mb-3">
             <asp:Label ID="lbl_rbEmployee" runat="server" AssociatedControlID="rbEmployee" Text="Employee of this company?" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
             <asp:RequiredFieldValidator ID="RFV_rbEmployee" runat="server" ErrorMessage="Select any option" ValidationGroup="add2" ControlToValidate="rbEmployee" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
             <div class="input-group-sm">
                 <asp:RadioButtonList ID="rbEmployee" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbEmployee_SelectedIndexChanged">
                     <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                     <asp:ListItem Text="No" Value="No"></asp:ListItem>
                 </asp:RadioButtonList>
             </div>
         </div>
     </div>

     <asp:Panel ID="pnlAttendeeType" runat="server" Visible="false">

         <div class="col-md-6">
             <div class="mb-3">
                 <asp:Label ID="lbl_rbAttendeeType" runat="server" AssociatedControlID="rbAttendeeType" Text="Attendees Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_rbAttendeeType" runat="server" ErrorMessage="Select any option" ValidationGroup="add2" ControlToValidate="rbAttendeeType" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <div class="input-group-sm">
                     <asp:RadioButtonList ID="rbAttendeeType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbAttendeeType_SelectedIndexChanged">
                         <asp:ListItem Text="Internal" Value="Internal"></asp:ListItem>
                         <asp:ListItem Text="External" Value="External"></asp:ListItem>
                     </asp:RadioButtonList>
                 </div>
             </div>
         </div>
     </asp:Panel>

     <asp:Panel ID="pnlDetails" runat="server" Visible="false">

         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_txtAttendeeCode" runat="server" AssociatedControlID="txtAttendeeCode" Text="Ateendees Code" ForeColor="Blue" Font-Bold="true"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_txtAttendeeCode" runat="server" ErrorMessage="*" ControlToValidate="txtAttendeeCode"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="REV_txtAttendeeCode" runat="server" ControlToValidate="txtAttendeeCode" ForeColor="Red"  ErrorMessage="AlphaNumeric Only" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" Display="Dynamic"></asp:RegularExpressionValidator>

                 <div class="input-group-sm">
                     <asp:TextBox ID="txtAttendeeCode" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                 </div>
             </div>
         </div>


         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_txtEmployeeName" runat="server" AssociatedControlID="txtEmployeeName" Text="Employee Name" ForeColor="Blue" Font-Bold="true"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_txtEmployeeName" runat="server" ErrorMessage="*" ControlToValidate="txtEmployeeName" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <div class="input-group-sm">
                     <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                 </div>
             </div>
         </div>

         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_txtdes" runat="server" AssociatedControlID="txtdes" Text="Designation" ForeColor="Blue" Font-Bold="true"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_txtdes" runat="server" ErrorMessage="*" ControlToValidate="txtdes" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <div class="input-group-sm">
                     <asp:TextBox ID="txtdes" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                 </div>
             </div>
         </div>

         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_ddlAttendanceStatus" runat="server" AssociatedControlID="ddlAttendanceStatus" Text="Attendance Status" ForeColor="Blue" Font-Bold="true"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_ddlAttendanceStatus" runat="server" ErrorMessage="*" ControlToValidate="ddlAttendanceStatus" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <div class="input-group-sm"> 
                     <asp:DropDownList ID="ddlAttendanceStatus" runat="server" CssClass="form-control form-control-sm rounded">
                        <asp:ListItem Text="Select" Value="" />
                        <asp:ListItem Text="Attend" Value="Pending" />
                        <asp:ListItem Text="Absent" Value="Completed" />
                     </asp:DropDownList>
                 </div>
             </div>
         </div>

         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_imgupload" runat="server" AssociatedControlID="imgupload" Text="Upload Your Image" ForeColor="Blue" Font-Bold="true"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_imgupload" runat="server" ErrorMessage="*" ControlToValidate="imgupload" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <div class="input-group-sm">
                     <asp:FileUpload ID="imgupload" runat="server" CssClass="form-control form-control-sm rounded" />
                 </div>
             </div>
         </div>

        
         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_btnAddAttendees" runat="server" AssociatedControlID="btnAddAttendees" Text="Add Attendees" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                 <div class="input-group">
                     <asp:Button ID="btnAddAttendees" Text="Add Attendees" runat="server" CssClass="btn btnStyle " ValidationGroup="add2" CausesValidation="true" OnClick="btnAddAttendees_Click" />
                      <asp:Label ID="lblMsg1" runat="server" ></asp:Label>
                 </div>
             </div>
         </div>
     </asp:Panel>
    
     <asp:Panel ID="pnlAttendeeTable" runat="server">
         <div class="table-responsive">
         <div class="col-md-12">
             <div class="mb-3">
                 <asp:GridView ID="gvAttendees" runat="server" CssClass="table table-bordered table-hover " AutoGenerateColumns="False">
                     <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
                     <Columns>
                         <asp:BoundField DataField="SNo" HeaderText="SNo" />
                         <asp:BoundField DataField="EmployeeOrNot" HeaderText="Employee?" />
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
                     </Columns>
                 </asp:GridView>
             </div>
         </div>
             </div>
     </asp:Panel>
                      </div>


                            

                            

                         


   


                   
                </div>
            </div>


            <%--Button--%>
           <%-- <div class="col-md-3">
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
