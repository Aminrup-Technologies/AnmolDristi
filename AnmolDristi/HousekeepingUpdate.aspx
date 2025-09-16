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
    .gv-input {
    width: 160px; /* consistent fixed width for all textboxes */
    height: 38px; /* standard Bootstrap input height */
    font-size: 14px;
    padding: 5px 10px;
    box-sizing: border-box;
  }

.classic-green input[type="checkbox"] {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    width: 16px;
    height: 16px;
    border: 1px solid #555;
    background: #fff;
    cursor: default;
    position: relative;
    vertical-align: middle;
}

.classic-green input[type="checkbox"]:checked::after {
    content: "";
    position: absolute;
    left: 3px;
    top: 0px;
    width: 6px;
    height: 12px;
    border: solid green;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
}




    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
               <asp:Label ID="lblTitle" runat="server" 
                            Text="Update Housekeeping Audit(5S) | DOC/ATS/OSH/CM-04" 
                            ForeColor="Green" 
                            CssClass="text-center d-block" 
                            Font-Size="Large" 
                            Font-Bold="true">
                        </asp:Label>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>Basic Details</h2>
                         <div class="clearfix"></div>
                      </div>

                    <div class="x_content">

                         <%--<asp:Panel ID="pnlAuditForm" runat="server">--%>
                                <div class="row">  
                                    
      <div class="col-md-4">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="add"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
     <div class="col-md-4">
     <div class="mb-3">
         <asp:Label ID="lbl_txtLocation" runat="server" AssociatedControlID="txtLocation" Text="Location" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtLocation" runat="server" ErrorMessage="*" ControlToValidate="txtLocation" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
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
     <h2>Observation Table</h2>
     <div class="clearfix"></div>
 </div>
                             
<div class="table-responsive">
    <div class="col-md-12">
        <div class="mb-3">

<asp:GridView ID="gvObservations" runat="server" DataKeyNames="SlNo,Capa_Report" AutoGenerateColumns="False" CssClass="table table-bordered table-sm table-hover table-striped nowrap" GridLines="None" OnRowDataBound="gvObservations_RowDataBound">
    <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
    <Columns>
        <asp:BoundField DataField="ObserverID" HeaderText="Oberver ID"  />
        

        
        <asp:TemplateField HeaderText="Open By">
            <ItemTemplate>
                <asp:TextBox ID="txtOpenBy" runat="server" Text='<%# Eval("OpenBy") %>' CssClass="form-control gv-input" ReadOnly="true" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Open By(Workman SL)">
    <ItemTemplate>
        <asp:TextBox ID="txtOpenByWorkman" runat="server" Text='<%# Eval("OpenByWorkman") %>' CssClass="form-control gv-input" />
    </ItemTemplate>
</asp:TemplateField>

        <asp:TemplateField HeaderText="Opening Date">
    <ItemTemplate>
        <asp:TextBox ID="txtOpeningDate" runat="server" Text='<%# Eval("OpeningDate", "{0:yyyy-MM-dd}") %>' TextMode="Date" CssClass="form-control gv-input" />
    </ItemTemplate>
</asp:TemplateField>


 <asp:TemplateField HeaderText="Target Date">
     <ItemTemplate>
         <asp:TextBox ID="txtTargetDate" runat="server" Text='<%# Eval("TargetDate", "{0:yyyy-MM-dd}") %>' TextMode="Date" CssClass="form-control gv-input" />
     </ItemTemplate>
 </asp:TemplateField>




<asp:TemplateField HeaderText="Photo (Before)">
    <ItemTemplate>
        <!-- Larger Image -->
        <asp:Image ID="imgBeforePhoto" runat="server" 
            ImageUrl='<%# ResolveUrl(Eval("PhotoBefore").ToString()) %>' 
            Width="90px" Height="90px" Style="object-fit:cover;" />

        <%--<!-- Hidden field to retain existing image path -->
        <asp:Label ID="lblPhotoBefore" runat="server" 
            Text='<%# Eval("PhotoBefore") %>' Visible="false" />--%>

        <!-- Hidden field to retain existing image path -->
        <asp:HiddenField ID="hfBeforePhoto" runat="server" 
            Value='<%# Eval("PhotoBefore") %>' />

        <!-- Upload control to select a new image -->
        <br />
        <asp:FileUpload ID="fuBeforePhoto" runat="server" Enabled="true" onchange="previewFile(this, this.parentElement.querySelector('img'))"/>
    </ItemTemplate>
</asp:TemplateField>


       


        <asp:TemplateField HeaderText="Observation">
            <ItemTemplate>
                <asp:TextBox ID="txtObservation" runat="server" Text='<%# Eval("Observation") %>' CssClass="form-control gv-input" TextMode="MultiLine"  />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Corrective Action">
            <ItemTemplate>
                <asp:TextBox ID="txtCorrectiveAction" runat="server" Text='<%# Eval("CorrectiveAction") %>' CssClass="form-control gv-input" TextMode="MultiLine"   />
            </ItemTemplate>
        </asp:TemplateField>
       <asp:TemplateField HeaderText="Photo (After)">
    <ItemTemplate>
        <!-- Larger Image -->
        <asp:Image ID="imgAfterPhoto" runat="server" 
            ImageUrl='<%# ResolveUrl(Eval("PhotoAfter").ToString()) %>' 
            Width="90px" Height="90px" Style="object-fit:cover;" />

         <!-- Hidden field to retain existing image path -->
         <asp:HiddenField ID="hfAfterPhoto" runat="server" 
             Value='<%# Eval("PhotoAfter") %>' />

        <!-- Upload control to select a new image -->
        <br />
        <asp:FileUpload ID="fuAfterPhoto" runat="server" Enabled="true" onchange="previewFile(this, this.parentElement.querySelector('img'))"  />
    </ItemTemplate>
</asp:TemplateField>



        <asp:TemplateField HeaderText="Closing Date">
            <ItemTemplate>
                <asp:TextBox ID="txtClosingDate" runat="server" Text='<%# Eval("ClosingDate", "{0:yyyy-MM-ddTHH:mm}") %>' TextMode="DateTimeLocal" CssClass="form-control gv-input" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Close By">
            <ItemTemplate>
                <asp:TextBox ID="txtCloseBy" runat="server" Text='<%# Eval("CloseBy") %>' CssClass="form-control gv-input" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Assigned To">
    <ItemTemplate>
        <asp:TextBox ID="txtAssignedTo" runat="server" Text='<%# Eval("AssignedTo") %>' CssClass="form-control gv-input" />
    </ItemTemplate>
</asp:TemplateField>

   <asp:TemplateField HeaderText="CAPA Created">
    <ItemTemplate>
       <%--<asp:CheckBox ID="chkCapa" runat="server" Enabled="false" CssClass="gv-checkbox-green"  />--%>
        <asp:CheckBox ID="chkCapa" runat="server" Enabled="false" CssClass="classic-green" />


    </ItemTemplate>
</asp:TemplateField>


        <asp:TemplateField HeaderText="Status">
    <ItemTemplate>
        <asp:DropDownList ID="ddlStatus" runat="server" 
            CssClass="form-control form-control-sm rounded gv-input">
            <asp:ListItem Text="Select" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Completed" Value="Completed" />
            <asp:ListItem Text="In Progress" Value="In Progress" />
            <asp:ListItem Text="Approved" Value="Approved" />
            <asp:ListItem Text="Rejected" Value="Rejected" />
            <asp:ListItem Text="On Hold" Value="On Hold" />
            <asp:ListItem Text="Open" Value="Open" />
            <asp:ListItem Text="Closed" Value="Closed" />
            <asp:ListItem Text="CAPA Created" Value="CAPA Created" />
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
                        <asp:Button ID="BtnUpdate" runat="server" Text="Update" CssClass="btn btn-success btn-sm"  ValidationGroup="add" CausesValidation="true" OnClientClick="return validateObservations();" OnClick="BtnUpdate_Click" />
                        <asp:Button ID="BtnBack" runat="server" Text="Back" CssClass="btn btn-primary btn-sm" CausesValidation="false" OnClick="BtnBack_Click" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
</div>
<script type="text/javascript">
    function validateObservations() {
        let isValid = true;

        const grid = document.getElementById("<%= gvObservations.ClientID %>");
        if (grid) {
            const rows = grid.getElementsByTagName("tr");
            for (let i = 1; i < rows.length; i++) { // skip header
                const row = rows[i];

                const fields = [
                    row.querySelector("input[id*='txtOpeningDate']"),
                    row.querySelector("input[id*='txtOpenBy']"),
                    row.querySelector("input[id*='txtOpenByWorkman']"),
                    row.querySelector("input[id*='txtTargetDate']"),
                    row.querySelector("input[id*='txtObservation']"),
                    row.querySelector("input[id*='txtCorrectiveAction']"),
                    row.querySelector("input[id*='txtClosingDate']"),
                    //row.querySelector("input[id*='txtCloseBy']"),
                    row.querySelector("input[id*='txtAssignedTo']"),
                    row.querySelector("select[id*='ddlStatus']")
                ];

                fields.forEach(function (field) {
                    if (field && !field.value.trim()) {
                        field.classList.add("is-invalid");
                        isValid = false;
                    } else if (field) {
                        field.classList.remove("is-invalid");
                    }
                });
            }
        }

        if (!isValid) {
            alert("Please fill all required fields in Observations grid.");
        }

        return isValid;
    }
</script>


    <script>
        function previewFile(input, imgElement) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    imgElement.src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>


</asp:Content>
