<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="housekeeping_audit.aspx.cs" Inherits="AnmolDristi.housekeeping_audit" %>
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

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h3>Automation And Technical Services
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>Housekeeping Audit(5S)</h2>
                        <div class="clearfix"></div>
                    </div>

                    <div class="x_content">

                         <asp:Panel ID="pnlAuditForm" runat="server">
                                <div class="row">  
                                    
      <div class="col-md-6">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
     <div class="col-md-6">
     <div class="mb-3">
         <asp:Label ID="lbl_txtLocation" runat="server" AssociatedControlID="txtLocation" Text="Location" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtLocation" runat="server" ErrorMessage="*" ControlToValidate="txtLocation" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
                                  <%--  <asp:HiddenField ID="hdnAuditID" runat="server" />
   --%>
                                    </div>

 <div class="x_title">
     <h2>Observation Table</h2>
     <div class="clearfix"></div>
 </div>
                             

<div class="field" id="Observation">
 <div class="row d-flex justify-content-between">
                                 
      <div class="col-md-2">
    <div class="mb-3">
        <asp:Label ID="lbl_txtObserverID" runat="server" AssociatedControlID="txtObserverID" Text="Observer ID" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtObserverID" runat="server" ErrorMessage="*" ControlToValidate="txtObserverID" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtObserverID" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>                          

    <div class="col-md-2">
         <div class="mb-3">
        <asp:Label ID="lbl_fileBeforePhoto" runat="server" AssociatedControlID="fileBeforePhoto" Text="Photo" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_fileBeforePhoto" runat="server" ErrorMessage="*" ControlToValidate="fileBeforePhoto" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
             <asp:FileUpload ID="fileBeforePhoto" runat="server" CssClass="form-control form-control-sm rounded" />
        </div>
    </div>
</div>
              <div class="col-md-2">
         <div class="mb-3">
        <asp:Label ID="lbl_txtObservation" runat="server" AssociatedControlID="txtObservation" Text="Observation" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtObservation" runat="server" ErrorMessage="*" ControlToValidate="txtObservation" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtObservation" runat="server" CssClass="form-control form-control-sm rounded "></asp:TextBox>
        </div>
    </div>
</div>
                  <div class="col-md-2">
         <div class="mb-3">
        <asp:Label ID="lbl_txtCorrectiveAction" runat="server" AssociatedControlID="txtCorrectiveAction" Text="Corrective Action" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtCorrectiveAction" runat="server" ErrorMessage="*" ControlToValidate="txtCorrectiveAction" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtCorrectiveAction" runat="server" CssClass="form-control form-control-sm rounded "></asp:TextBox>
        </div>
    </div>
</div>
    
    <div class="col-md-2">
         <div class="mb-3">
        <asp:Label ID="lbl_fileAfterPhoto" runat="server" AssociatedControlID="fileAfterPhoto" Text="Photo (After)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_fileAfterPhoto" runat="server" ErrorMessage="*" ControlToValidate="fileAfterPhoto" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
             <asp:FileUpload ID="fileAfterPhoto" runat="server" CssClass="form-control form-control-sm rounded" />
        </div>
    </div>
</div>
         <div class="col-md-2 ">
         <div class="mb-3">
        <asp:Label ID="lbl_ddlStatus" runat="server" AssociatedControlID="ddlStatus" Text="Status" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_ddlStatus" runat="server" ErrorMessage="*" ControlToValidate="ddlStatus" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
             <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control form-control-sm rounded">
                 <asp:ListItem Text="Select" Value="" />
                 <asp:ListItem Text="Pending" Value="Pending" />
                 <asp:ListItem Text="Completed" Value="Completed" />
                 <asp:ListItem Text="In Progress" Value="In Progress" />
                 <asp:ListItem Text="Approved" Value="Approved" />
                 <asp:ListItem Text="Rejected" Value="Rejected" />
                 <asp:ListItem Text="On Hold" Value="On Hold" />
             </asp:DropDownList>
        </div>
    </div>
</div>
     
                         
     </div>


                             <div class="row" >
                                      <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtOpeningDate" runat="server" AssociatedControlID="txtOpeningDate" Text="Opening Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtOpeningDate" runat="server" ErrorMessage="*" ControlToValidate="txtOpeningDate" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtOpeningDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>
                                     <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtOpenBy" runat="server" AssociatedControlID="txtOpenBy" Text="Open By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtOpenBy" runat="server" ErrorMessage="*" ControlToValidate="txtOpenBy" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtOpenBy" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>
                                      <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtClosingDate" runat="server" AssociatedControlID="txtClosingDate" Text="Closing Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtClosingDate" runat="server" ErrorMessage="*" ControlToValidate="txtClosingDate" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtClosingDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>
                                     <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtCloseBy" runat="server" AssociatedControlID="txtCloseBy" Text="Close By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtCloseBy" runat="server" ErrorMessage="*" ControlToValidate="txtCloseBy" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtCloseBy" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>



                             </div>
    </div>
                                <!-- Button -->
                                <div class="mt-3">
                                    <asp:Button ID="btnAddObservation" runat="server" Text="Add Observation" CssClass="btn btn-primary" ValidationGroup="add" CausesValidation="true" OnClick="btnAddObservation_Click"  OnClientClick="clearFields();" />
                                    <asp:Label ID="lblMsg1" runat="server" ></asp:Label>
                                </div>
                            </asp:Panel>

                            <hr>
    <div class="table-responsive">
    <div class="col-md-12">
        <div class="mb-3">
    <asp:GridView ID="gvObservations" runat="server"  DataKeyNames="SNo" AutoGenerateColumns="False" CssClass="table table-bordered table-hover ">
    <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
    <Columns>
        <asp:BoundField DataField="SNo" HeaderText="SNo" />
        <asp:BoundField DataField="ObserverID" HeaderText="Oberver ID" />
        <asp:BoundField DataField="OpeningDate" HeaderText="Opening Date" />
        <asp:BoundField DataField="OpenBy" HeaderText="Open By" />
        <asp:TemplateField HeaderText="Photo (Before)">
            <ItemTemplate>
                <asp:Image ID="imgBeforePhoto" runat="server" ImageUrl='<%# Eval("PhotoBefore") %>' Width="50px" Height="50px" />
            </ItemTemplate>
        </asp:TemplateField>
       
        <asp:BoundField DataField="Observation" HeaderText="Observation" />
        <asp:BoundField DataField="CorrectiveAction" HeaderText="Corrective Action" />
      
        <asp:TemplateField HeaderText="Photo (After)">
            <ItemTemplate>
                <asp:Image ID="imgAfterPhoto" runat="server" ImageUrl='<%# Eval("PhotoAfter") %>' Width="50px" Height="50px" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="ClosingDate" HeaderText="Closing Date" />
        <asp:BoundField DataField="CloseBy" HeaderText="Close By" />
        <asp:BoundField DataField="Status" HeaderText="Status" />
      <asp:TemplateField HeaderText="Action">
        <ItemTemplate>
            <asp:Button ID="BtnDelObservation" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"  OnClick="BtnDelObservation_Click" OnClientClick="return confirm('Are you sure you want to delete?');" />
       </ItemTemplate>
 </asp:TemplateField>
    </Columns>
</asp:GridView>
            </div>
        </div>
        </div>

                         


   


                   
                </div>
            </div>


            <%--Button--%>
            <div class="col-md-3">
                <div class="mb-3">
                    <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group input-group-sm">
                        <asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
                        <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                        <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/Home.aspx" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
    
</div>
   

    <script type="text/javascript">
        function showSuccessMessage() {
            alert("Attendee details have been added successfully!");
        }
    </script>
</asp:Content>
