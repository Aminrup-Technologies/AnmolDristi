<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="housekeeping_audit.aspx.cs" Inherits="AnmolDristi.housekeeping_audit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h3>Housekeeping Audit(5S) | DOC/ATS/OSH/CM-04 
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2 class="text-info h4">Basic Details</h2>
                         <div class="clearfix"></div>
                      </div>

                    <div class="x_content">

                         <%--<asp:Panel ID="pnlAuditForm" runat="server">--%>
                                <div class="row">  
                                    
      <div class="col-md-4">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
     <div class="col-md-4">
     <div class="mb-3">
         <asp:Label ID="lbl_txtLocation" runat="server" AssociatedControlID="txtLocation" Text="Location" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtLocation" runat="server" ErrorMessage="*" ControlToValidate="txtLocation" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
        <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_txtjobID" runat="server" AssociatedControlID="txtjobID" Text="Job ID" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtjobID" runat="server" ErrorMessage="*" ControlToValidate="txtjobID" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <%--<asp:RegularExpressionValidator  ID="REV_txtjobID"  ControlToValidate="txtjobID"  ValidationExpression="^\d+$" ErrorMessage="Only digits are allowed"  ForeColor="Red"  runat="server" />--%>

        <div class="input-group-sm">
            <asp:TextBox ID="txtjobID" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>
                                  <%--  <asp:HiddenField ID="hdnAuditID" runat="server" />
   --%>
                                    </div>

 <div class="x_title">
     <h2 class="text-info h4">Observation Table</h2>
     <div class="clearfix"></div>
 </div>
                             

<div class="field" id="Observation">
<div class="row bg-light border rounded p-3 mb-3">
    <div class="col-12 border-bottom pb-2 mb-3">
        <h6 class="text-dark fw-bold mb-0">
            <i class="bi bi-person-circle me-2"></i>Step 1: Observer Details
        </h6>
    </div>
     
<%--<!-- Observer ID input -->
<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtObserverID" runat="server" AssociatedControlID="txtObserverID" 
            Text="Observer ID (Emp Code)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

        <asp:RequiredFieldValidator ID="RFV_txtObserverID" runat="server" 
            ErrorMessage="*" ControlToValidate="txtObserverID" 
            ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

        <asp:RegularExpressionValidator ID="REV_txtObserverID" runat="server" 
            ControlToValidate="txtObserverID" ForeColor="Red" ValidationGroup="add" 
            ErrorMessage="Numeric Only" ValidationExpression="^\d{1,25}$" Display="Dynamic"></asp:RegularExpressionValidator> 

        <div class="input-group-sm">
            <asp:TextBox ID="txtObserverID" runat="server" 
                CssClass="form-control form-control-sm rounded" 
                onkeyup="fetchEmployeeName()" AutoPostBack="false"></asp:TextBox>
        </div>

        <asp:Label ID="lblEmployeeName" runat="server" Text="" ForeColor="Red" Font-Size="Small"></asp:Label>
    </div>
</div>

<!-- Open By (Employee Name Output) -->
<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtOpenBy" runat="server" AssociatedControlID="txtOpenBy" 
            Text="Open By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

        <asp:RequiredFieldValidator ID="RFV_txtOpenBy" runat="server" 
            ErrorMessage="*" ControlToValidate="txtOpenBy" 
            ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

        <div class="input-group-sm">
            <asp:TextBox ID="txtOpenBy" runat="server" 
                CssClass="form-control form-control-sm rounded" ReadOnly="true"></asp:TextBox>

            <asp:HiddenField ID="hfEmployeeName" runat="server" />
        </div>
    </div>
</div>--%>

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />

<div class="col-md-3">
    <div class="mb-3">
      <asp:Label ID="lbl_txtObserverID" runat="server" AssociatedControlID="txtObserverID" Text="Observer ID (Emp Code)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
       <asp:RequiredFieldValidator ID="RFV_txtObserverID" runat="server"  ErrorMessage="*" ControlToValidate="txtObserverID" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

        <div class="input-group-sm">
            <asp:TextBox ID="txtObserverID" runat="server" CssClass="form-control form-control-sm rounded" onblur="fetchEmployeeName()" AutoPostBack="false"></asp:TextBox>
        </div>
        <asp:Label ID="lblEmployeeName" runat="server" Text="" ForeColor="Red" Font-Size="Small"></asp:Label>
    </div>
</div>

<div class="col-md-3">
    <div class="mb-3">
       <asp:Label ID="lbl_txtOpenBy" runat="server" AssociatedControlID="txtOpenBy" Text="Open By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
 <asp:RequiredFieldValidator ID="RFV_txtOpenBy" runat="server"  ErrorMessage="*" ControlToValidate="txtOpenBy" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

        <div class="input-group-sm">
            <asp:TextBox ID="txtOpenBy" runat="server" CssClass="form-control form-control-sm rounded" ReadOnly="true"></asp:TextBox>
            <asp:HiddenField ID="hfEmployeeName" runat="server" />
        </div>
    </div>
</div>

<script type="text/javascript">
    function fetchEmployeeName() {
        var empCode = document.getElementById('<%= txtObserverID.ClientID %>').value.trim();

        // Clear previous values if code is empty
        if (empCode === "") {
            document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = "";
            document.getElementById('<%= txtOpenBy.ClientID %>').value = "";
            document.getElementById('<%= hfEmployeeName.ClientID %>').value = "";
            return;
        }

        // Call the server-side PageMethod
        PageMethods.GetEmployeeName(empCode,
            function (result) {
                if (result && result.trim() !== "") {
                    // ✅ Set full name to Label, TextBox, and HiddenField
                    //document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = result;
                   // document.getElementById('<%= lblEmployeeName.ClientID %>').style.color = "green";

                    document.getElementById('<%= txtOpenBy.ClientID %>').value = result;
                    document.getElementById('<%= hfEmployeeName.ClientID %>').value = result;

                    console.log("Full Name Fetched: " + result); // for debugging
                } else {
                    // ❌ Not found
                    document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = "Invalid Employee Code!";
                    document.getElementById('<%= lblEmployeeName.ClientID %>').style.color = "red";

                    document.getElementById('<%= txtOpenBy.ClientID %>').value = "";
                    document.getElementById('<%= hfEmployeeName.ClientID %>').value = "";
                }
            },
            function (error) {
                alert("Server error: " + error.get_message());
                console.error("Error fetching employee name:", error);
            }
        );
    }
</script>

<%--<script type="text/javascript">
    function fetchEmployeeName() {
        var empCode = document.getElementById('<%= txtObserverID.ClientID %>').value.trim();
        if (empCode === "") {
            document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = "";
            document.getElementById('<%= txtOpenBy.ClientID %>').value = "";
            document.getElementById('<%= hfEmployeeName.ClientID %>').value = "";
            return;
        }

        PageMethods.GetEmployeeName(empCode, function (result) {
            if (result !== "") {
               // document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = result;
               // document.getElementById('<%= lblEmployeeName.ClientID %>').style.color = "green";
                document.getElementById('<%= txtOpenBy.ClientID %>').value = result;
                document.getElementById('<%= hfEmployeeName.ClientID %>').value = result;
            } else {
                document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = "Invalid Employee Code!";
                document.getElementById('<%= lblEmployeeName.ClientID %>').style.color = "red";
                document.getElementById('<%= txtOpenBy.ClientID %>').value = "";
                document.getElementById('<%= hfEmployeeName.ClientID %>').value = "";
            }
        }, function (error) {
            alert("Error calling server: " + error.get_message());
        });
    }
</script>--%>




      


                                  <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtOpenByWorkman" runat="server" AssociatedControlID="txtOpenByWorkman" Text="Open By(Workman SL)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtOpenByWorkman" runat="server" ErrorMessage="*" ControlToValidate="txtOpenByWorkman" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtOpenByWorkman" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>
    <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtCloseBy" runat="server" AssociatedControlID="txtCloseBy" Text="Close By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <div class="input-group-sm">
            <asp:TextBox ID="txtCloseBy" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>


</div>


<div class="row bg-light border rounded p-3 mb-3">
    <div class="col-12 border-bottom pb-2 mb-3">
        <h6 class="text-dark fw-bold mb-0">
            <i class="bi bi-person-circle me-2"></i>Step 2: Action Details
        </h6>
    </div>
            
    <div class="col-md-3">
         <div class="mb-3">
        <asp:Label ID="lbl_fileBeforePhoto" runat="server" AssociatedControlID="fileBeforePhoto" Text="Photo(Before)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_fileBeforePhoto" runat="server" ErrorMessage="*" ControlToValidate="fileBeforePhoto" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
             <asp:FileUpload ID="fileBeforePhoto" runat="server" CssClass="form-control form-control-sm rounded" />
            <asp:Label ID="lblBeforeError" runat="server" CssClass="text-danger" Style="display:none;"></asp:Label>
        </div>
    </div>
</div>
              <div class="col-md-3">
         <div class="mb-3">
        <asp:Label ID="lbl_txtObservation" runat="server" AssociatedControlID="txtObservation" Text="Observation" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtObservation" runat="server" ErrorMessage="*" ControlToValidate="txtObservation" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtObservation" runat="server" CssClass="form-control form-control-sm rounded " TextMode="MultiLine"></asp:TextBox>
        </div>
    </div>
</div>
                  <div class="col-md-3">
         <div class="mb-3">
        <asp:Label ID="lbl_txtCorrectiveAction" runat="server" AssociatedControlID="txtCorrectiveAction" Text="Action Taken" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtCorrectiveAction" runat="server" ErrorMessage="*" ControlToValidate="txtCorrectiveAction" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtCorrectiveAction" runat="server" CssClass="form-control form-control-sm rounded " TextMode="MultiLine"></asp:TextBox>
        </div>
    </div>
</div>
    
    <div class="col-md-3">
         <div class="mb-3">
        <asp:Label ID="lbl_fileAfterPhoto" runat="server" AssociatedControlID="fileAfterPhoto" Text="Photo (After)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_fileAfterPhoto" runat="server" ErrorMessage="*" ControlToValidate="fileAfterPhoto" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
             <asp:FileUpload ID="fileAfterPhoto" runat="server" CssClass="form-control form-control-sm rounded" />
            <asp:Label ID="lblAfterError" runat="server" CssClass="text-danger" Style="display:none;"></asp:Label>
        </div>
    </div>
</div>
        
                         
     </div>


<div class="row bg-light border rounded p-3 mb-3">
    <div class="col-12 border-bottom pb-2 mb-3">
        <h6 class="text-dark fw-bold mb-0">
            <i class="bi bi-person-circle me-2"></i>Step 3: Status
        </h6>
    </div>
            
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

         <div class="col-md-2">
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

                            <%-- <div class="col-md-2">--%>
     <%--<div class="mb-3">
         <asp:Label ID="lbl_chkQ3CAPA" runat="server" AssociatedControlID="chkQ3CAPA"
                    Text="CAPA Report" ForeColor="Blue" Font-Bold="true" Font-Size="Small" CssClass="form-label d-block" />
         <div class="form-check">
             <asp:CheckBox ID="chkQ3CAPA" runat="server" Text="CAPA" CssClass="form-check-input me-2" Checked="true" />
         </div>
     </div>--%>
<%-- </div>--%>
    <div class="mb-3">
    <asp:Label ID="lbl_chkQ3CAPA" runat="server" AssociatedControlID="chkQ3CAPA"
               Text="CAPA Report" ForeColor="Blue" Font-Bold="true" Font-Size="Small" CssClass="form-label d-block" />
    <div class="form-check">
        <asp:CheckBox ID="chkQ3CAPA" runat="server" Text="CAPA" CssClass="form-check-input me-2"
                      Checked="true" onclick="return confirmCAPAUncheck(this);" />
    </div>
</div>

<script type="text/javascript">
    function confirmCAPAUncheck(checkbox) {
        if (!checkbox.checked) {
            return confirm("CAPA is required.Proceeding without it is at your own risk");
        }
        return true;
    }
</script>


       

     


                             </div>
   </div>
                                <!-- Button -->
                                <div class="mt-3">
                                    <asp:Button ID="btnAddObservation" runat="server" Text="Add Observation" CssClass="btn btn-primary" ValidationGroup="add" CausesValidation="true" OnClick="btnAddObservation_Click" OnClientClick="return validateObservationFields();"/>
                                    <asp:Label ID="lblMsg1" runat="server" ></asp:Label>
                                </div>
                        
</div>

                            <%--</asp:Panel>--%>

                            <hr>
    <div class="table-responsive">
    <div class="col-md-4">
        <div class="mb-3">
    <asp:GridView ID="gvObservations" runat="server"  DataKeyNames="SNo" AutoGenerateColumns="False" CssClass="table table-bordered table-sm table-hover table-striped nowrap" GridLines="None">
    <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
    <Columns>
        <asp:BoundField DataField="SNo" HeaderText="SNo" Visible="false" />
        <asp:BoundField DataField="ObserverID" HeaderText="Oberver ID" />
        <asp:BoundField DataField="OpeningDate" HeaderText="Opening Date" />
        <asp:BoundField DataField="OpenBy" HeaderText="Open By" Visible="false" />
         <asp:BoundField DataField="OpenByWorkman" HeaderText="Open By(Workman SL)" />
        <asp:TemplateField HeaderText="Photo (Before)">
            <ItemTemplate>
                <asp:Image ID="imgBeforePhoto" runat="server" ImageUrl='<%# Eval("PhotoBefore") %>' Width="50px" Height="50px" />
            </ItemTemplate>
        </asp:TemplateField>
       
        <asp:BoundField DataField="Observation" HeaderText="Observation" />
        <asp:BoundField DataField="CorrectiveAction" HeaderText="Corrective Action"  />
         <asp:BoundField DataField="Capa_Report" HeaderText="CAPA Status" />
      
        <asp:TemplateField HeaderText="Photo (After)">
            <ItemTemplate>
                <asp:Image ID="imgAfterPhoto" runat="server" ImageUrl='<%# Eval("PhotoAfter") %>' Width="50px" Height="50px" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="ClosingDate" HeaderText="Closing Date" Visible="false" />
        <asp:BoundField DataField="CloseBy" HeaderText="Close By" Visible="false" />
        <asp:BoundField DataField="TargetDate" HeaderText="Target Date" Visible="false" />
         <asp:BoundField DataField="AssignedTo" HeaderText="Assigned To" Visible="false" />
        <asp:BoundField DataField="Status" HeaderText="Status" Visible="false" />
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
                        <asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" OnClientClick="return validatesFields();" />
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
 


<%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- JavaScript to fetch employee name 
<script type="text/javascript">
    function fetchEmployeeName() {
        var observerId = document.getElementById('<%= txtObserverID.ClientID %>').value.trim();

        if (observerId.length > 0) {
            // Check if only digits are entered
            if (!/^\d+$/.test(observerId)) {
                alert("Observer ID must be numeric.");
                return;
            }

            $.ajax({
                type: "POST",
                url: "housekeeping_audit.aspx/GetEmployeeName",
                data: JSON.stringify({ inspectionId: observerId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var employeeName = response.d;
                    var openByTextBox = document.getElementById('<%= txtOpenBy.ClientID %>');
                    var errorLabel = document.getElementById('<%= lblEmployeeName.ClientID %>');
                    var hiddenField = document.getElementById('<%= hfEmployeeName.ClientID %>');

                    if (employeeName && employeeName !== "Invalid Observer ID" && employeeName !== "Error occurred while fetching data") {
                        openByTextBox.value = employeeName;
                        hiddenField.value = employeeName;
                        errorLabel.innerText = '';
                    } else {
                        openByTextBox.value = '';
                        hiddenField.value = '';
                        errorLabel.innerText = 'Observer ID not found!';
                    }
                },
                error: function () {
                    document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = 'Error fetching data.';
                    document.getElementById('<%= txtOpenBy.ClientID %>').value = '';
                    document.getElementById('<%= hfEmployeeName.ClientID %>').value = '';
                }
            });
        } else {
            document.getElementById('<%= txtOpenBy.ClientID %>').value = '';
            document.getElementById('<%= hfEmployeeName.ClientID %>').value = '';
            document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = '';
        }
    }
</script>--%>





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


   <%--<script type="text/javascript">
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
   </script>--%>

 <%-- <script type="text/javascript">
      document.addEventListener("DOMContentLoaded", function () {
          var tbObserverID = document.getElementById('<%= txtObserverID.ClientID %>');
       var btnAdd = document.getElementById('<%= btnAddObservation.ClientID %>');

          const validNames = ["6767", "8789", "6786", "678","678"];

          btnAdd.addEventListener("click", function (e) {
              var inputName = tbObserverID.value.trim();

              var isValid = validNames.some(function (name) {
                  return name.toLowerCase() === inputName.toLowerCase();
              });

              if (!isValid) {
                  e.preventDefault(); // Prevent postback
                  alert("Enter a valid OberverID In the Observer ID Field.");
                  tbObserverID.focus();
              }
          });
      });
  </script>--%>


<script type="text/javascript">
    function validateObservationFields() {
        var obsID = document.getElementById('<%= txtObserverID.ClientID %>').value.trim();
        var openby = document.getElementById('<%= txtOpenBy.ClientID %>').value.trim();
        var openwork = document.getElementById('<%= txtOpenByWorkman.ClientID %>').value.trim();
        <%--var closeby = document.getElementById('<%= txtCloseBy.ClientID %>').value.trim();--%>
        var phbef = document.getElementById('<%= fileBeforePhoto.ClientID %>').value.trim();
        var obs = document.getElementById('<%= txtObservation.ClientID %>').value.trim();
        var insp = document.getElementById('<%= txtCorrectiveAction.ClientID %>').value.trim(); 
        var phaft = document.getElementById('<%= fileAfterPhoto.ClientID %>').value.trim();
        var opdate = document.getElementById('<%= txtOpeningDate.ClientID %>').value.trim();
        var cldate = document.getElementById('<%= txtClosingDate.ClientID %>').value.trim();
        var tgdate = document.getElementById('<%= txtTargetDate.ClientID %>').value.trim();
        var assign = document.getElementById('<%= txtAssignedTo.ClientID %>').value.trim();
        var status = document.getElementById('<%= ddlStatus.ClientID %>').value.trim();

        //var digitsOnly = /^\d+$/;

        if (!obsID) {
            alert("Please enter Observer ID");
            return false;
        }
        //if (!digitsOnly.test(obsID)) {
        //    alert("Observer ID must contain digits only.");
        //    return false;
        //}


        if (!openby) {
            alert("Please enter Open By.");
            return false;
        }

        if (!openwork) {
            alert("Please enter Open by Workman SL.");
            return false;
        }
        if (!phbef) {
            alert("Please upload photo Before");
            return false;
        }
        if (!phaft) {
            alert("Please upload photo After");
            return false;
        }
        if (!obs) {
            alert("Please enter Observation");
            return false;
        }
        if (!insp) {
            alert("Please enter Action Taken");
            return false;
        }
        if (!opdate) {
            alert("Please enter Opening Date");
            return false;
        }
        if (!cldate) {
            alert("Please enter Closing Date");
            return false;
        }
        if (!tgdate) {
            alert("Please enter Target Date");
            return false;
        }
        if (!assign) {
            alert("Please enter Assigned To");
            return false;
        }
        if (!status) {
            alert("Please select status");
            return false;
        }
        return true;
    }

</script>

<script type="text/javascript">
    function validatesFields() {
        var obsID = document.getElementById('<%= txtdate.ClientID %>').value.trim();
        var openby = document.getElementById('<%= txtLocation.ClientID %>').value.trim();
        var openwork = document.getElementById('<%= txtjobID.ClientID %>').value.trim();

        
        //var digitsOnly = /^\d+$/;

        if (!obsID) {
            alert("Please select Date");
            return false;
        }

        if (!openby) {
            alert("Please enter Location.");
            return false;
        }

        if (!openwork) {
            alert("Please enter Job ID.");
            return false;
        }
        //if (!digitsOnly.test(openwork)) {
        //    alert("Job ID must contain digits only.");
        //    return false;
        //}

        return true;
    }
</script>




</asp:Content>
