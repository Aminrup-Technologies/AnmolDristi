<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="HousekeepingUpdate.aspx.cs" Inherits="AnmolDristi.HousekeepingUpdate" %>
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

                         <%--<asp:Panel ID="pnlAuditForm" runat="server">--%>
                                <div class="row">  
                                    
      <div class="col-md-6">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
     <div class="col-md-6">
     <div class="mb-3">
         <asp:Label ID="lbl_txtLocation" runat="server" AssociatedControlID="txtLocation" Text="Location" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtLocation" runat="server" ErrorMessage="*" ControlToValidate="txtLocation"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
                                  
                                    </div>

 <div class="x_title">
     <h2>Observation Table</h2>
     <div class="clearfix"></div>
 </div>
                             

   








<div class="table-responsive">
    <div class="col-md-12">
        <div class="mb-3">

<asp:GridView ID="gvObservations" runat="server" DataKeyNames="ObserverID" AutoGenerateColumns="False" CssClass="table table-bordered table-hover">
    <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
    <Columns>
        <asp:TemplateField HeaderText="Observer ID">
            <ItemTemplate>
                <asp:TextBox ID="txtObserverID" runat="server" Text='<%# Eval("ObserverID") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Opening Date">
            <ItemTemplate>
                <asp:TextBox ID="txtOpeningDate" runat="server" Text='<%# Eval("OpeningDate", "{0:yyyy-MM-ddTHH:mm}") %>' TextMode="DateTimeLocal" CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Open By">
            <ItemTemplate>
                <asp:TextBox ID="txtOpenBy" runat="server" Text='<%# Eval("OpenBy") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <%--<asp:TemplateField HeaderText="Photo (Before)">
            <ItemTemplate>
                <asp:Image ID="imgBeforePhoto" runat="server" ImageUrl='<%# ResolveUrl(Eval("PhotoBefore").ToString()) %>' Width="50px" Height="50px" />
                <asp:Label ID="lblPhotoBefore" runat="server" Text='<%# Eval("PhotoBefore") %>' Visible="false" />
                 <asp:FileUpload ID="fileBeforePhoto" runat="server" CssClass="form-control form-control-sm rounded" />
                 <asp:Label ID="lblBeforeError" runat="server" CssClass="text-danger" Style="display:none;"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>--%>


<asp:TemplateField HeaderText="Photo (Before)">
    <ItemTemplate>
        <!-- Larger Image -->
        <asp:Image ID="imgBeforePhoto" runat="server" 
            ImageUrl='<%# ResolveUrl(Eval("PhotoBefore").ToString()) %>' 
            Width="90px" Height="90px" Style="object-fit:cover;" />

        <!-- Hidden field to retain existing image path -->
        <asp:Label ID="lblPhotoBefore" runat="server" 
            Text='<%# Eval("PhotoBefore") %>' Visible="false" />

        <!-- Upload control to select a new image -->
        <br />
        <asp:FileUpload ID="fuBeforePhoto" runat="server" />
    </ItemTemplate>
</asp:TemplateField>



        <asp:TemplateField HeaderText="Observation">
            <ItemTemplate>
                <asp:TextBox ID="txtObservation" runat="server" Text='<%# Eval("Observation") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Corrective Action">
            <ItemTemplate>
                <asp:TextBox ID="txtCorrectiveAction" runat="server" Text='<%# Eval("CorrectiveAction") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <%--<asp:TemplateField HeaderText="Photo (After)">
            <ItemTemplate>
                <asp:Image ID="imgAfterPhoto" runat="server" ImageUrl='<%# ResolveUrl(Eval("PhotoAfter").ToString()) %>' Width="50px" Height="50px" />
                <asp:Label ID="lblPhotoAfter" runat="server" Text='<%# Eval("PhotoAfter") %>' Visible="false" />
            </ItemTemplate>
        </asp:TemplateField>--%>

       <asp:TemplateField HeaderText="Photo (After)">
    <ItemTemplate>
        <!-- Larger Image -->
        <asp:Image ID="imgAfterPhoto" runat="server" 
            ImageUrl='<%# ResolveUrl(Eval("PhotoAfter").ToString()) %>' 
            Width="90px" Height="90px" Style="object-fit:cover;" />

        <!-- Hidden field to retain existing image path -->
        <asp:Label ID="lblPhotoAfter" runat="server" 
            Text='<%# Eval("PhotoAfter") %>' Visible="false" />

        <!-- Upload control to select a new image -->
        <br />
        <asp:FileUpload ID="fuAfterPhoto" runat="server" />
    </ItemTemplate>
</asp:TemplateField>



        <asp:TemplateField HeaderText="Closing Date">
            <ItemTemplate>
                <asp:TextBox ID="txtClosingDate" runat="server" Text='<%# Eval("ClosingDate", "{0:yyyy-MM-ddTHH:mm}") %>' TextMode="DateTimeLocal" CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Close By">
            <ItemTemplate>
                <asp:TextBox ID="txtCloseBy" runat="server" Text='<%# Eval("CloseBy") %>' CssClass="form-control" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control form-control-sm rounded" SelectedValue='<%# Eval("Status") %>'>
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
                    <asp:Label ID="Lbl_BtnUpdate" runat="server" AssociatedControlID="BtnUpdate" Text="CLICK TO UPDATE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group input-group-sm">
                        <asp:Button ID="BtnUpdate" runat="server" Text="Update" CssClass="btn btn-success btn-sm"  CausesValidation="true" OnClick="BtnUpdate_Click" />
                        <asp:Button ID="BtnBack" runat="server" Text="Back" CssClass="btn btn-primary btn-sm" CausesValidation="false" OnClick="BtnBack_Click" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
    
</div>
</asp:Content>
