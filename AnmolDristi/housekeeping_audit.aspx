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
        <asp:RegularExpressionValidator ID="REV_txtObserverID" runat="server" ControlToValidate="txtObserverID" ForeColor="Red" ValidationGroup="add" ErrorMessage="Numeric Only" ValidationExpression="^\d{1,25}$" Display="Dynamic"></asp:RegularExpressionValidator>
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
            <asp:Label ID="lblBeforeError" runat="server" CssClass="text-danger" Style="display:none;"></asp:Label>
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
            <asp:Label ID="lblAfterError" runat="server" CssClass="text-danger" Style="display:none;"></asp:Label>
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
                                      <div class="col-md-2">
    <div class="mb-3">
        <asp:Label ID="lbl_txtOpeningDate" runat="server" AssociatedControlID="txtOpeningDate" Text="Opening Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtOpeningDate" runat="server" ErrorMessage="*" ControlToValidate="txtOpeningDate" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtOpeningDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"  oninput="validateDates()"></asp:TextBox>
        </div>
    </div>
</div>
                                     <div class="col-md-2">
    <div class="mb-3">
        <asp:Label ID="lbl_txtOpenBy" runat="server" AssociatedControlID="txtOpenBy" Text="Open By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtOpenBy" runat="server" ErrorMessage="*" ControlToValidate="txtOpenBy" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtOpenBy" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>
                                  <div class="col-md-2">
    <div class="mb-3">
        <asp:Label ID="lbl_txtOpenByWorkman" runat="server" AssociatedControlID="txtOpenByWorkman" Text="Open By(Workman SL)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtOpenByWorkman" runat="server" ErrorMessage="*" ControlToValidate="txtOpenByWorkman" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtOpenByWorkman" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>

                                      <div class="col-md-2">
    <div class="mb-3">
        <asp:Label ID="lbl_txtClosingDate" runat="server" AssociatedControlID="txtClosingDate" Text="Closing Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtClosingDate" runat="server" ErrorMessage="*" ControlToValidate="txtClosingDate" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtClosingDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"  oninput="validateDates()"></asp:TextBox>
            <asp:Label ID="lblDateValidation" runat="server" CssClass="text-danger" Style="display:none;"></asp:Label>

        </div>
    </div>
      </div>
                                 
    <div class="col-md-2">
    <div class="mb-3">
        <asp:Label ID="lbl_txtCloseBy" runat="server" AssociatedControlID="txtCloseBy" Text="Close By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <div class="input-group-sm">
            <asp:TextBox ID="txtCloseBy" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>
                                  <div class="col-md-2">
    <div class="mb-3">
        <asp:Label ID="lbl_txtTargetDate" runat="server" AssociatedControlID="txtTargetDate" Text="Target Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtTargetDate" runat="server" ErrorMessage="*" ControlToValidate="txtTargetDate" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtTargetDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>
                                  <div class="col-md-2">
    <div class="mb-3">
        <asp:Label ID="lbl_txtAssignedTo" runat="server" AssociatedControlID="txtAssignedTo" Text="Assigned To" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtAssignedTo" runat="server" ErrorMessage="*" ControlToValidate="txtAssignedTo" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtAssignedTo" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
        </div>
    </div>
</div>




                             </div>
   </div>
                                <!-- Button -->
                                <div class="mt-3">
                                    <asp:Button ID="btnAddObservation" runat="server" Text="Add Observation" CssClass="btn btn-primary" ValidationGroup="add" CausesValidation="true" OnClick="btnAddObservation_Click" OnClientClick="return validateObservationFields();"/>
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
         <asp:BoundField DataField="OpenByWorkman" HeaderText="Open By(Workman SL)" />
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
        <asp:BoundField DataField="TargetDate" HeaderText="Target Date" />
         <asp:BoundField DataField="AssignedTo" HeaderText="Assigned To" />
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
            alert("Observations have been added successfully!");
        }
</script>
  
    <script>
        function validateDates() {
            var openingDateInput = document.getElementById('<%= txtOpeningDate.ClientID %>');
        var closingDateInput = document.getElementById('<%= txtClosingDate.ClientID %>');
        var validationLabel = document.getElementById('<%= lblDateValidation.ClientID %>');

            var openingDate = openingDateInput.value;
            var closingDate = closingDateInput.value;

            if (openingDate && closingDate) {
                var open = new Date(openingDate);
                var close = new Date(closingDate);

                if (close <= open) {
                    // Show error and clear the invalid closing date
                    validationLabel.style.display = 'block';
                    validationLabel.innerText = 'Invalid date';
                    closingDateInput.value = ""; // clear invalid date
                    closingDateInput.focus();
                } else {
                    validationLabel.style.display = 'none';
                }
            }
        }

        window.onload = function () {
            validateDates();
        };
    </script>


   <script type="text/javascript">
       window.onload = function () {
           const validExtensions = [".jpg", ".jpeg", ".png"];

           const beforeFile = document.getElementById('<%= fileBeforePhoto.ClientID %>');
        const afterFile = document.getElementById('<%= fileAfterPhoto.ClientID %>');

        const beforeError = document.getElementById('<%= lblBeforeError.ClientID %>');
        const afterError = document.getElementById('<%= lblAfterError.ClientID %>');

           // Set accept attribute for file filtering at browser level
           beforeFile.setAttribute("accept", ".jpg,.jpeg,.png");
           afterFile.setAttribute("accept", ".jpg,.jpeg,.png");

           beforeFile.addEventListener("change", function () {
               validateFile(this, beforeError);
           });

           afterFile.addEventListener("change", function () {
               validateFile(this, afterError);
           });

           function validateFile(fileInput, errorLabel) {
               const filePath = fileInput.value;
               const ext = filePath.substring(filePath.lastIndexOf('.')).toLowerCase();

               if (!validExtensions.includes(ext)) {
                   fileInput.value = "";
                   errorLabel.innerText = "❌ Only .jpg, .jpeg, or .png files are allowed.";
                   errorLabel.style.display = "block";
               } else {
                   errorLabel.innerText = "";
                   errorLabel.style.display = "none";
               }
           }
       };
   </script>
   <script type="text/javascript">
       document.addEventListener("DOMContentLoaded", function () {
           var txtOpenBy = document.getElementById('<%= txtOpenBy.ClientID %>');
        var btnAdd = document.getElementById('<%= btnAddObservation.ClientID %>');

        const validNames = ["eshubharti", "rajusingh", "zz", "Protima K"];

        btnAdd.addEventListener("click", function (e) {
            var inputName = txtOpenBy.value.trim();

            var isValid = validNames.some(function (name) {
                return name.toLowerCase() === inputName.toLowerCase();
            });

            if (!isValid) {
                e.preventDefault(); // Prevent postback
                alert("Enter a valid Employee name In the OpenBy Field.");
                txtOpenBy.focus();
            }
        });
    });
   </script>
<%--<script type="text/javascript">
    function validateObservationFields() {
        var fields = [
            { id: '<%= txtObserverID.ClientID %>', name: 'Observer ID' },
            { id: '<%= fileBeforePhoto.ClientID %>', name: 'Before Photo' },
            { id: '<%= txtObservation.ClientID %>', name: 'Observation' },
            { id: '<%= txtCorrectiveAction.ClientID %>', name: 'Corrective Action' },
            { id: '<%= fileAfterPhoto.ClientID %>', name: 'After Photo' },
            { id: '<%= ddlStatus.ClientID %>', name: 'Status' },
            { id: '<%= txtOpeningDate.ClientID %>', name: 'Opening Date' },
            { id: '<%= txtOpenBy.ClientID %>', name: 'Open By' },
            { id: '<%= txtOpenByWorkman.ClientID %>', name: 'Open By (Workman SL)' },
            { id: '<%= txtClosingDate.ClientID %>', name: 'Closing Date' },
            { id: '<%= txtTargetDate.ClientID %>', name: 'Target Date' },
            { id: '<%= txtAssignedTo.ClientID %>', name: 'Assigned To' }
        ];

        for (var i = 0; i < fields.length; i++) {
            var elem = document.getElementById(fields[i].id);
            if (elem) {
                if ((elem.type === "text" || elem.tagName === "TEXTAREA" || elem.tagName === "SELECT") && elem.value.trim() === "") {
                    alert(fields[i].name + " is required.");
                    elem.focus();
                    return false;
                }

                if (elem.type === "file" && elem.value.trim() === "") {
                    alert(fields[i].name + " is required.");
                    return false;
                }
            }
        }

        return true;
    }
</script>--%>
<script type="text/javascript">
    function validateObservationFields() {
        var fields = [
            { id: '<%= txtObserverID.ClientID %>', name: 'Observer ID' },
            { id: '<%= fileBeforePhoto.ClientID %>', name: 'Before Photo' },
            { id: '<%= txtObservation.ClientID %>', name: 'Observation' },
            { id: '<%= txtCorrectiveAction.ClientID %>', name: 'Corrective Action' },
            { id: '<%= fileAfterPhoto.ClientID %>', name: 'After Photo' },
            { id: '<%= ddlStatus.ClientID %>', name: 'Status' },
            { id: '<%= txtOpeningDate.ClientID %>', name: 'Opening Date' },
            { id: '<%= txtOpenByWorkman.ClientID %>', name: 'Open By (Workman SL)' },
            { id: '<%= txtClosingDate.ClientID %>', name: 'Closing Date' },
            { id: '<%= txtTargetDate.ClientID %>', name: 'Target Date' },
            { id: '<%= txtAssignedTo.ClientID %>', name: 'Assigned To' }
        ];

        for (var i = 0; i < fields.length; i++) {
            var elem = document.getElementById(fields[i].id);
            if (elem) {
                var isEmpty = false;
                if (elem.type === "file" && !elem.value) {
                    isEmpty = true;
                } else if (
                    (elem.type === "text" ||
                        elem.tagName === "TEXTAREA" ||
                        elem.tagName === "SELECT") &&
                    elem.value.trim() === "") {
                    isEmpty = true;
                }

                if (isEmpty) {
                    alert(fields[i].name + " is required.");
                    elem.focus();
                    return false;
                }
            }
        }

        return true; // all fields valid, allow form submission
    }
</script>






</asp:Content>
