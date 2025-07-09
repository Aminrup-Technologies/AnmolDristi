<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="FirstAidBox.aspx.cs" Inherits="AnmolDristi.FirstAidBox" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
.assessment-label {
    color: #004080;
    font-weight: 600;
    font-size: 0.9rem;
}
.ab{
    font-weight: bold;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h3>First Aid Box Checklist | ATS/OHS/FACL-01
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2 class="text-info h4">Step 1:Basic Details</h2>
                        <div class="clearfix"></div>
                    </div>

                    <div class="x_content">

                        
      <div class="row">  
                                    
      <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Date" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
     <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtVenue" runat="server" AssociatedControlID="txtVenue" Text="Location"  CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtVenue" runat="server" ErrorMessage="*" ControlToValidate="txtVenue" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtVenue" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtInsBy" runat="server" AssociatedControlID="txtInsBy" Text="Inspection By(Emp Code)" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtInsBy" runat="server" ErrorMessage="*" ControlToValidate="txtInsBy" ValidationGroup="submi" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtInsBy" runat="server" CssClass="form-control form-control-sm rounded" 
              OnKeyUp="fetchEmployeeName()" 
              AutoPostBack="false"></asp:TextBox>
        </div>
        <asp:Label ID="lblEmployeeName" runat="server" Text="" ForeColor="Red" Font-Size="Small"></asp:Label> <!-- For error display -->
    </div>
</div>

 
<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtDocNo" runat="server" AssociatedControlID="txtDocNo" Text="Employee Name" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtDocNo" runat="server" ErrorMessage="*" ControlToValidate="txtDocNo" ValidationGroup="submi" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtDocNo" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
            <asp:HiddenField ID="hfEmployeeName" runat="server" /> <!-- ✅ Hidden field to store actual name -->
        </div>
    </div>
</div>
                                    </div> 

                      
                         <br />
  <div class="x_title">
     <h2 class="text-info h4">Step 2:First Aid Item Details</h2>
     <div class="clearfix"></div>
 </div>                         

   
    <div class="field" id="Issues">
 
                                 
      <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_txtItemName" runat="server" AssociatedControlID="txtItemName" Text="Item Name"  CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtItemName" runat="server" ErrorMessage="*" ControlToValidate="txtItemName" ValidationGroup="add1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtItemName" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>                          
             <div class="col-md-6">
         <div class="mb-3">
        <asp:Label ID="lbl_txtQuantity" runat="server" AssociatedControlID="txtQuantity" Text="Quantity"  CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtQuantity" runat="server" ErrorMessage="*" ControlToValidate="txtQuantity" ValidationGroup="add1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control form-control-sm rounded " TextMode="Number"></asp:TextBox>
        </div>
    </div>
</div>
                 <div class="col-md-4">
         <div class="mb-3">
        <asp:Label ID="lbl_txtExpiryDate" runat="server" AssociatedControlID="txtExpiryDate" Text="Expiry Date"  CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtExpiryDate" runat="server" ErrorMessage="*" ControlToValidate="txtExpiryDate" ValidationGroup="add1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control form-control-sm rounded " TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>

         <div class="col-md-4">
         <div class="mb-3">
        <asp:Label ID="lbl_txtLastRefilledDate" runat="server" AssociatedControlID="txtLastRefilledDate" Text="Refilled Date"  CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtLastRefilledDate" runat="server" ErrorMessage="*" ControlToValidate="txtLastRefilledDate" ValidationGroup="add1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtLastRefilledDate" runat="server" CssClass="form-control form-control-sm rounded " TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>
                 <div class="col-md-4">
         <div class="mb-3">
        <asp:Label ID="lbl_txtNextRefillDueDate" runat="server" AssociatedControlID="txtNextRefillDueDate" Text="Next Refilled Due Date"  CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtNextRefillDueDate" runat="server" ErrorMessage="*" ControlToValidate="txtNextRefillDueDate" ValidationGroup="add1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtNextRefillDueDate" runat="server" CssClass="form-control form-control-sm rounded " TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>
                      
     </div>



 <div class="mt-3">
     <asp:Button ID="btnAddIssues" runat="server" Text="Add Items" CssClass="btn btn-info btn-sm" ValidationGroup="add1" CausesValidation="true" OnClick="btnAddIssues_Click"  />
 <asp:Label ID="lblMsg2" runat="server" ></asp:Label>
 </div>  
                        <br />
            <div class="table-responsive">
    <div class="col-md-6">
        <div class="mb-3">
    <asp:GridView ID="gvIssues" runat="server" AutoGenerateColumns="False" DataKeyNames="SNo"  CssClass="table table-bordered table-sm table-hover table-striped nowrap" GridLines="None" >
    <HeaderStyle BackColor="#004080" ForeColor="#E0E0E0" Font-Bold="true" />
    <Columns>
        <asp:BoundField DataField="SNo" HeaderText="SNo" Visible="false" />
        <asp:BoundField DataField="ItemName" HeaderText="Item Name"  />
        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
        <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date"  />
        <asp:BoundField DataField="LastRefilledDate" HeaderText="Last Refill Date"  Visible="false" />
        <asp:BoundField DataField="NextRefillDueDate" HeaderText="Next Refill Due Date"  Visible="false" />
        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>
                 <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"  OnClick="BtnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete ?');" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
            </div>
        </div>
        </div>

                         <br />
                         
                         

 <div class="x_title">
    <h2 class="text-info h4">Step 3:Checklist Details</h2>
    <div class="clearfix"></div>
</div>  
       
<asp:Repeater ID="rptChecklist" runat="server">   
<HeaderTemplate>
    <div class="table-responsive"> 
        <table class="table table-bordered align-middle" >
           <thead class="bg-info">
    <tr>
        <th style="white-space: nowrap;">SNo</th>
        <th style="min-width: 100px;">Description</th>
        <th>Status</th>
        <th style="min-width: 90px;">Item Names</th>
        <th >Upload Photo</th>
        <th style="min-width: 50px;">CAPA REPORT</th>
    </tr>
</thead> 
            <tbody>
               
</HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td><%# Eval("QuestionNumber") %>
                <asp:HiddenField ID="hfQuestionNumber" runat="server" Value='<%# Eval("QuestionNumber") %>' />
            </td>
           <%-- <td class="ab"><%# Eval("Description") %></td>--%>
             <td class="ab"><asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' /></td>
            <td>
                <asp:RadioButton ID="rdoYes" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                    Text="Yes" CssClass="assessment-label status-option" />
                <asp:RadioButton ID="rdoNo" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                    Text="No" CssClass="assessment-label status-option" checked="true"/>
            </td>
            <td>
                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control remarks" Style="display:none;" />
            </td>
            <td>
                <asp:FileUpload ID="fileUpload" runat="server" CssClass="file-upload"   Style="display:none;" />
            </td>
            <td>
            <asp:CheckBox ID="chkCapaReport" runat="server" CssClass="capa-checkbox" Text="CAPA Report" Style="display:none;" />
        </td>
        </tr>
    </ItemTemplate>

    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>

              <br />

 <div class="x_title">
    <h2 class="text-info h4">Step 4:Upload FirstAidBox Image</h2>
    <div class="clearfix"></div>
</div>                         
 <div class="col-md-6">
        <div class="mb-3">
            <asp:Label ID="lbl_imgupload" runat="server" AssociatedControlID="imgupload" Text="Upload Photo"  CssClass="assessment-label" Font-Bold="true"></asp:Label>
            <asp:RequiredFieldValidator ID="RFV_imgupload" runat="server" ErrorMessage="*" ControlToValidate="imgupload" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            <div class="input-group-sm">
                <asp:FileUpload ID="imgupload" runat="server" CssClass="form-control form-control-sm rounded" />
                 <asp:Label ID="lblBeforeError" runat="server" CssClass="text-danger" Style="display:none;"></asp:Label>
            </div>
        </div>
    </div>
    
    <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="Lbl_txtnote" runat="server" AssociatedControlID="txtnote" Text="Remarks"  CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtnote" runat="server" ErrorMessage="*" ControlToValidate="txtnote" ValidationGroup="submi" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtnote" runat="server" CssClass="form-control form-control-sm rounded "  TextMode="MultiLine"></asp:TextBox>
        </div>
    </div>
</div>                   


   


                   
                </div>
            </div>


           <%-- <%--Button--%>
           <div class="col-md-3">
                <div class="mb-3">
                    <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Green" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group input-group-sm">
                        <asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" OnClientClick="return validatesFields();" />
                        
                        <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                         <asp:Button ID="BtnView" runat="server" Text="View Page" CssClass="btn btn-primary btn-sm" CausesValidation="false" OnClick="BtnView_Click" />
                        <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/Home.aspx" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
    
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- JavaScript to fetch employee name -->
<script type="text/javascript">
    function fetchEmployeeName() {
        var inspectionId = document.getElementById('<%= txtInsBy.ClientID %>').value;

        if (inspectionId.trim().length > 0) {
            $.ajax({
                type: "POST",
                url: "FirstAidBox.aspx/GetEmployeeName",
                data: JSON.stringify({ inspectionId: inspectionId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var employeeName = response.d;
                    var empTextBox = document.getElementById('<%= txtDocNo.ClientID %>');
                    var lblError = document.getElementById('<%= lblEmployeeName.ClientID %>');
                    var hiddenField = document.getElementById('<%= hfEmployeeName.ClientID %>');

                    if (employeeName && employeeName !== "Invalid Inspection ID" && employeeName !== "Error occurred while fetching data") {
                        empTextBox.value = employeeName;
                        empTextBox.readOnly = true;
                        hiddenField.value = employeeName;
                        lblError.innerText = '';
                    } else {
                        empTextBox.value = '';
                        empTextBox.readOnly = true;
                        hiddenField.value = '';
                        lblError.innerText = 'Invalid Inspection ID!';
                    }
                },
                error: function () {
                    document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = 'Error fetching data.';
                    document.getElementById('<%= txtDocNo.ClientID %>').value = '';
                    document.getElementById('<%= txtDocNo.ClientID %>').readOnly = true;
                    document.getElementById('<%= hfEmployeeName.ClientID %>').value = '';
                }
            });
        } else {
            document.getElementById('<%= txtDocNo.ClientID %>').value = '';
            document.getElementById('<%= hfEmployeeName.ClientID %>').value = '';
            document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = '';
        }
    }
</script>



<script type="text/javascript">
    window.onload = function () {
        const radios = document.querySelectorAll('.status-option');

        radios.forEach(radio => {
            radio.addEventListener("click", function () {
                const row = this.closest('tr');
                const value = this.textContent.trim(); // Yes / No / NA

                const txtRemarks = row.querySelector('.form-control.remarks');
                const fileUpload = row.querySelector('.file-upload');
                const chkCapa = row.querySelector('.capa-checkbox input[type="checkbox"]');

                if (value === "Yes") {
                    if (txtRemarks) txtRemarks.style.display = "block";
                    if (fileUpload) fileUpload.style.display = "block";
                    if (chkCapa) {
                        chkCapa.parentElement.style.display = "block";
                        chkCapa.checked = true;
                    }
                } else {
                    if (txtRemarks) txtRemarks.style.display = "none";
                    if (fileUpload) fileUpload.style.display = "none";
                    if (chkCapa) {
                        chkCapa.parentElement.style.display = "none";
                        chkCapa.checked = false;
                    }
                }
            });
        });
    };
</script>

 <script type="text/javascript">
     function showSuccessMessages() {
         alert("Issues have been added successfully!");
     }
 </script>

</asp:Content>
