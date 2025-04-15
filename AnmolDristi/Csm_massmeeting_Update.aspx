<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Csm_massmeeting_Update.aspx.cs" Inherits="AnmolDristi.Csm_massmeeting_Update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                         <h2>Update Your Meeting Records</h2>
                         
                         <div class="clearfix"></div>
                     </div>

                     <div class="x_content">
                         <asp:HiddenField ID="HiddenMeetingID" runat="server" />

                         <div class="col-md-6">
                             <div class="mb-3">
                                 <asp:Label ID="lbl_Date" runat="server" AssociatedControlID="TB_Date" Text="Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                 <asp:RequiredFieldValidator ID="RFV_TB_Date" runat="server" ErrorMessage="Select Date" ControlToValidate="TB_Date" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                 <div class="input-group-sm">
                                     <asp:TextBox ID="TB_Date" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                 </div>
                             </div>
                         </div>

                         <!-- Second set of dropdown list -->
                         <div class="col-md-6">
                             <div class="mb-3">
                                 <asp:Label ID="Lbl_time" runat="server" AssociatedControlID="tb_time" Text="Time" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                 <asp:RequiredFieldValidator ID="RFV_tb_time" runat="server" ErrorMessage="Select Time" ValidationGroup="Submit" ControlToValidate="tb_time" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                 <div class="input-group-sm">
                                     <asp:TextBox ID="tb_time" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
                                 </div>
                             </div>
                         </div>


                         <div class="col-md-6">
                             <div class="mb-3">
                                 <asp:Label ID="Lbl_loc" runat="server" AssociatedControlID="tb_loc" Text="Site/Location" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                 <asp:RequiredFieldValidator ID="RFV_tb_loc" runat="server" ErrorMessage="Location Required" ValidationGroup="Submit" ControlToValidate="tb_loc" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                 <div class="input-group-sm">
                                     <asp:TextBox ID="tb_loc" runat="server" CssClass="form-control form-control-sm rounded" Placeholder=""></asp:TextBox>
                                 </div>
                             </div>
                         </div>


                         <div class="col-md-6">
                             <div class="mb-3">
                                 <asp:Label ID="Lbl_name" runat="server" AssociatedControlID="tb_name" Text="Employee Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                 <asp:RequiredFieldValidator ID="RFV_tb_name" runat="server" ErrorMessage="Employee Name Required" ValidationGroup="Submit" ControlToValidate="tb_name" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                 <div class="input-group-sm">
                                     <asp:TextBox ID="tb_name" runat="server" CssClass="form-control form-control-sm rounded" Placeholder=""></asp:TextBox>
                                 </div>
                             </div>
                         </div>


                         <div class="col-md-6">
                             <div class="mb-3">
                                 <asp:Label ID="Lbl_des" runat="server" AssociatedControlID="tb_des" Text="Designation" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                 <asp:RequiredFieldValidator ID="RFV_tb_des" runat="server" ErrorMessage="Designation Required" ControlToValidate="tb_des" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                 <div class="input-group-sm">
                                     <asp:TextBox ID="tb_des" runat="server" CssClass="form-control form-control-sm rounded" Placeholder=""></asp:TextBox>
                                 </div>
                             </div>
                         </div>


                         <div class="col-md-6">
                             <div class="mb-3">
                                 <asp:Label ID="Lbl_rfid" runat="server" AssociatedControlID="tb_rfid" Text="RFID" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                 <asp:RequiredFieldValidator ID="RFV_tb_rfid" runat="server" ErrorMessage="Rfid Required" ValidationGroup="Submit" ControlToValidate="tb_rfid" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                 <asp:RegularExpressionValidator ID="REV_tb_rfid" runat="server" ControlToValidate="tb_rfid" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="AlphaNumeric Only" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" Display="Dynamic"></asp:RegularExpressionValidator>
                                 <div class="input-group-sm">
                                     <asp:TextBox ID="tb_rfid" runat="server" CssClass="form-control form-control-sm rounded" Placeholder=""></asp:TextBox>
                                 </div>
                             </div>
                         </div>

                       
                         <div class="col-md-6">
                        <div class="mb-3">
                            <asp:Label ID="lblPointsDiscussed" runat="server" AssociatedControlID="tb_points" Text="Points Discussed" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                              <asp:RequiredFieldValidator ID="RFV_tb_points" runat="server" ErrorMessage="Points Required" ValidationGroup="Submit" ControlToValidate="tb_points" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            <div class="input-group-sm">
                                <asp:TextBox ID="tb_points" runat="server" CssClass="form-control form-control-sm rounded points-input"></asp:TextBox>
                                    </div>
                                  </div>
                                  </div>


                       

</div>
         </div>
         </div>


             <%--Button--%>
             <div class="col-md-3">
                 <div class="mb-3">
                       <div class="input-group input-group-sm">
                         <asp:Button ID="BtnUpdate" runat="server" Text="Update" CssClass="btn btn-danger btn-sm" ValidationGroup="Update" CausesValidation="true"  OnClick="BtnUpdate_Click" />
                         <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                         <asp:Button ID="BtnBack" runat="server" Text="Back" CssClass="btn btn-info btn-sm" CausesValidation="false" OnClick="BtnBack_Click" />
                        
                     </div>
                 </div>
             </div>
             </div>
         </div>
         </div>

</asp:Content>
