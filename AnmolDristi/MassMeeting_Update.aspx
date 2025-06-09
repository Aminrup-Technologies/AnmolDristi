<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="MassMeeting_Update.aspx.cs" Inherits="AnmolDristi.MassMeeting_Update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h3>Mass Meeting Update Page 
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>ATS/DOC/MM/0010</h2>
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
        <asp:Label ID="lbl_txtTime" runat="server" AssociatedControlID="txtTime" Text="Meeting Start Time" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtTime" runat="server" ErrorMessage="*" ControlToValidate="txtTime" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtTime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
        </div>
    </div>
</div>

        <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtEndtime" runat="server" AssociatedControlID="txtTime" Text="Meeting End Time" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtEndtime" runat="server" ErrorMessage="*" ControlToValidate="txtEndtime" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtEndtime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
        </div>
    </div>
</div>
     <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_TB_Duration" runat="server" AssociatedControlID="TB_Duration" Text="Venue" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_TB_Duration" runat="server" ErrorMessage="*" ControlToValidate="TB_Duration" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="TB_Duration" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_WorkRegion" runat="server" AssociatedControlID="DDL_WorkRegion" Text="Work Region" ForeColor="Blue" Font-Bold="true"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_DDL_WorkRegion" runat="server" ErrorMessage="*" ControlToValidate="DDL_WorkRegion" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:DropDownList ID="DDL_WorkRegion" runat="server" CssClass="form-control form-control-sm rounded">
                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                <asp:ListItem Text="Region 1" Value="1"></asp:ListItem>
                <asp:ListItem Text="Region 2" Value="2"></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
</div>


<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_Company" runat="server" AssociatedControlID="DDL_Company" Text="Company" ForeColor="Blue" Font-Bold="true"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_DDL_Company" runat="server" ErrorMessage="*" ControlToValidate="DDL_Company" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:DropDownList ID="DDL_Company" runat="server" CssClass="form-control form-control-sm rounded">
                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                <asp:ListItem Text="Company A" Value="A"></asp:ListItem>
                <asp:ListItem Text="Company B" Value="B"></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
</div>


<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_Department" runat="server" AssociatedControlID="DDL_Department" Text="Department" ForeColor="Blue" Font-Bold="true"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_DDL_Department" runat="server" ErrorMessage="*" ControlToValidate="DDL_Department" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:DropDownList ID="DDL_Department" runat="server" CssClass="form-control form-control-sm rounded">
                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                <asp:ListItem Text="HR" Value="HR"></asp:ListItem>
                <asp:ListItem Text="IT" Value="IT"></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
</div>


<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_Location" runat="server" AssociatedControlID="DDL_Location" Text="Location" ForeColor="Blue" Font-Bold="true"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_DDL_Location" runat="server" ErrorMessage="*" ControlToValidate="DDL_Location" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:DropDownList ID="DDL_Location" runat="server" CssClass="form-control form-control-sm rounded">
                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                <asp:ListItem Text="Site A" Value="A"></asp:ListItem>
                <asp:ListItem Text="Site B" Value="B"></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
</div>
<div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_ExactLocation" runat="server" AssociatedControlID="TB_ExactLocation" Text="Exact Location" ForeColor="Blue" Font-Bold="true"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_TB_ExactLocation" runat="server" ErrorMessage="*" ControlToValidate="TB_ExactLocation" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="TB_ExactLocation" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
        </div>
    </div>
</div>


<div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_TB_CoordinatorName" runat="server" AssociatedControlID="TB_CoordinatorName" Text="Co-Ordinator Name" ForeColor="Blue" Font-Bold="true"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_TB_CoordinatorName" runat="server" ErrorMessage="*" ControlToValidate="TB_CoordinatorName" ValidationGroup="Save1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="TB_CoordinatorName" runat="server" CssClass="form-control form-control-sm rounded" ReadOnly="true"></asp:TextBox>
        </div>
    </div>
</div>
                                 
                                    </div>

 <div class="x_title">
     <h2>Attendance Table</h2>
     <div class="clearfix"></div>
 </div>
    
  <asp:GridView ID="GV_Attendees" runat="server" CssClass="table table-bordered table-striped"
    AutoGenerateColumns="false" EmptyDataText="No Attendees Found.">
    <Columns>
        <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
        <asp:BoundField DataField="Designation" HeaderText="Designation" />
        <asp:BoundField DataField="Gate_passno" HeaderText="Gate Pass No" />
        <asp:BoundField DataField="Attendee_Type" HeaderText="Attendee Type" />
        <asp:ImageField DataImageUrlField="Image_upload" HeaderText="Image" ControlStyle-Height="50" ControlStyle-Width="50" />
    </Columns>
</asp:GridView>

                
 

  <div class="x_title">
     <h2>Meeting Issue Table</h2>
     <div class="clearfix"></div>
 </div>                         

   <asp:GridView ID="GV_MOM" runat="server" CssClass="table table-bordered table-striped"
    AutoGenerateColumns="false" EmptyDataText="No Issues Entries Found.">
    <Columns>
        <asp:BoundField DataField="AgendaTitle" HeaderText="Agenda Title" />
        <asp:BoundField DataField="PointBy" HeaderText="Point By" />
        <asp:BoundField DataField="DiscussionType" HeaderText="Type" />
        <asp:BoundField DataField="DiscussionDescription1" HeaderText="Discussion Description 1" />
        <asp:BoundField DataField="Duration" HeaderText="Duration (mins)" />
        <asp:ImageField DataImageUrlField="Ref_PhotoBefore" HeaderText="Images Uploaded" ControlStyle-Height="50" ControlStyle-Width="50" />
        </Columns>
</asp:GridView>

           

             
       
     


   


                   
                </div>
            </div>


           <%-- <%--Button--%>
         <%--  <div class="col-md-3">
                <div class="mb-3">
                    <asp:Label ID="lblbtnUpdate" runat="server" AssociatedControlID="btnUpdate" Text="Click to Update" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group input-group-sm">
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success btn-sm"  CausesValidation="true" OnClick="btnUpdate_Click" />   
                        <asp:Button ID="Btnback" runat="server" Text="Back" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="Btnback_Click" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        
                    </div>
                </div>
            </div>--%>

        </div>
    </div>
</div>
    
</div>
</asp:Content>
