<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="WeldingMachineChecklist.aspx.cs" Inherits="AnmolDristi.WeldingMachineChecklist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style type="text/css">
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
                <h3> Welding Machine Checklist |
                    DocNo:ATS/WMC/22/00
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        
                        <h2 class="text-info h4">
                            Basic Details
                        </h2>
                         <div class="clearfix"></div>
                      </div>

                    <div class="x_content">
                        
                                <div class="row">             
      <div class="col-md-6">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Date" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate"  runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
     <div class="col-md-6">
     <div class="mb-3">
         <asp:Label ID="lbl_txtloc" runat="server" AssociatedControlID="txtloc" Text="Location" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtloc" runat="server" ErrorMessage="*" ControlToValidate="txtloc" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtloc" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
     <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_txtjobId" runat="server" AssociatedControlID="txtjobId" Text="Job ID" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtjobId" runat="server" ErrorMessage="*" ControlToValidate="txtjobId" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator  ID="REV_txtjobID"  ControlToValidate="txtjobID"  ValidationExpression="^\d+$" ErrorMessage="Only digits are allowed"  ForeColor="Red"  runat="server" />
        <div class="input-group-sm">
            <asp:TextBox ID="txtjobId" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>
  
<div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_txtInsBy" runat="server" AssociatedControlID="txtInsBy" Text="Inspection By(Emp Code)" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtInsBy" runat="server" ErrorMessage="*" ControlToValidate="txtInsBy" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
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
        <asp:RequiredFieldValidator ID="RFV_txtDocNo" runat="server" ErrorMessage="*" ControlToValidate="txtDocNo" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtDocNo" runat="server" CssClass="form-control form-control-sm rounded" ReadOnly="true"></asp:TextBox>
            <asp:HiddenField ID="hfEmployeeName" runat="server" /> <!-- ✅ Hidden field to store actual name -->
        </div>
    </div>
</div>




</div>
        
                              
                                 

 <div class="x_title">
     <h2 class="text-info h4">Step 1: GENERAL</h2>
     <div class="clearfix"></div>
 </div>
         
<asp:Repeater ID="rptChecklist" runat="server">   
<HeaderTemplate>
    <div class="table-responsive"> 
        <table class="table table-bordered align-middle" >
           <thead class="bg-info">
    <tr>
        <th style="white-space: nowrap;">SNo</th>
        <th style="min-width: 200px;">Points</th>
        <th>Status</th>
        <th style="min-width: 150px;">Remarks</th>
        <th style="min-width: 150px;">Upload Photo</th>
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
                    Text="Yes" CssClass="assessment-label status-option" Checked="true" />
                <asp:RadioButton ID="rdoNo" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                    Text="No" CssClass="assessment-label status-option" />
                <asp:RadioButton ID="rdoNA" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                    Text="NA" CssClass="assessment-label status-option" />
            </td>
            <td>
                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control remarks" Style="display:none;" />
            </td>
            <td>
                <asp:FileUpload ID="fileUpload" runat="server" CssClass="file-upload"   Style="display:none;" />
            </td>
        </tr>
    </ItemTemplate>

    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>


                   

 <div class="x_title">
     <h2 class="text-info h4">Step 2: TERMINLS/JOINTS </h2>
     <div class="clearfix"></div>
 </div>
<asp:Repeater ID="rptTerminals" runat="server">
  <HeaderTemplate>
    <div class="table-responsive">
        <table class="table table-bordered align-middle">
            <thead class="bg-info">
                <tr>
                    <th style="white-space: nowrap;">SNo</th>
                    <th style="min-width: 200px;">Points</th>
                    <th>Status</th>
                    <th style="min-width: 150px;">Remarks</th>
                    <th style="min-width: 150px;">Upload Photo</th>
                </tr>
            </thead>
            <tbody>
</HeaderTemplate>
    <ItemTemplate>
      <tr>
          <td><%# Eval("QuestionNumber") %>
              <asp:HiddenField ID="hfQuestionNumber" runat="server" Value='<%# Eval("QuestionNumber") %>' />
          </td>
         <%-- <td  class="ab"><%# Eval("Description") %></td>--%>
           <td class="ab"><asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' /></td>
          <td>
              <asp:RadioButton ID="rdoYes" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="Yes" CssClass="assessment-label status-option" Checked="true" />
              <asp:RadioButton ID="rdoNo" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="No" CssClass="assessment-label status-option" />
              <asp:RadioButton ID="rdoNA" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="NA" CssClass="assessment-label status-option" />
          </td>
          <td>
              <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control remarks" Style="display:none;" />
          </td>
          <td>
              <asp:FileUpload ID="fileUpload" runat="server" CssClass="file-upload"  Style="display:none;" />
          </td>
      </tr>
  </ItemTemplate>

    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>



 <div class="x_title">
     <h2 class="text-info h4">Step 3: CABLES</h2>
     <div class="clearfix"></div>
 </div>
<asp:Repeater ID="rptCables" runat="server">
  <HeaderTemplate>
    <div class="table-responsive">
        <table class="table table-bordered align-middle">
            <thead class="bg-info">
                <tr>
                    <th style="white-space: nowrap;">SNo</th>
                    <th style="min-width: 200px;">Points</th>
                    <th>Status</th>
                    <th style="min-width: 150px;">Remarks</th>
                    <th style="min-width: 150px;">Upload Photo</th>
                </tr>
            </thead>
            <tbody>
</HeaderTemplate>
     <ItemTemplate>
      <tr>
          <td><%# Eval("QuestionNumber") %>
              <asp:HiddenField ID="hfQuestionNumber" runat="server" Value='<%# Eval("QuestionNumber") %>' />
          </td>
         <%-- <td  class="ab"><%# Eval("Description") %></td>--%>
           <td class="ab"><asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' /></td>
          <td>
              <asp:RadioButton ID="rdoYes" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="Yes" CssClass="assessment-label status-option" Checked="true" />
              <asp:RadioButton ID="rdoNo" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="No" CssClass="assessment-label status-option" />
              <asp:RadioButton ID="rdoNA" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="NA" CssClass="assessment-label status-option" />
          </td>
          <td>
              <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control remarks" Style="display:none;" />
          </td>
          <td>
              <asp:FileUpload ID="fileUpload" runat="server" CssClass="file-upload"   Style="display:none;" />
          </td>
      </tr>
  </ItemTemplate>

    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>

 <div class="x_title">
     <h2 class="text-info h4">Step 4: ELECTRODE HOLDER/CLAMP</h2>
     <div class="clearfix"></div>
 </div>
<asp:Repeater ID="rptElectrodeHolder" runat="server">
  <HeaderTemplate>
    <div class="table-responsive">
        <table class="table table-bordered align-middle">
            <thead class="bg-info">
                <tr>
                    <th style="white-space: nowrap;">SNo</th>
                    <th style="min-width: 200px;">Points</th>
                    <th>Status</th>
                    <th style="min-width: 150px;">Remarks</th>
                    <th style="min-width: 150px;">Upload Photo</th>
                </tr>
            </thead>
            <tbody>
</HeaderTemplate>
    <ItemTemplate>
      <tr>
          <td><%# Eval("QuestionNumber") %>
              <asp:HiddenField ID="hfQuestionNumber" runat="server" Value='<%# Eval("QuestionNumber") %>' />
          </td>
          <%--<td  class="ab"><%# Eval("Description") %></td>--%>
           <td class="ab"><asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' /></td>
          <td>
              <asp:RadioButton ID="rdoYes" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="Yes" CssClass="assessment-label status-option" Checked="true" />
              <asp:RadioButton ID="rdoNo" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="No" CssClass="assessment-label status-option" />
              <asp:RadioButton ID="rdoNA" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="NA" CssClass="assessment-label status-option" />
          </td>
          <td>
              <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control remarks" Style="display:none;" />
          </td>
          <td>
              <asp:FileUpload ID="fileUpload" runat="server" CssClass="file-upload"   Style="display:none;" />
          </td>
      </tr>
  </ItemTemplate>

    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>

 <div class="x_title">
     <h2 class="text-info h4">Step 5: WORK AREA</h2>
     <div class="clearfix"></div>
 </div>
<asp:Repeater ID="rptWorkArea" runat="server">
    <HeaderTemplate>
    <div class="table-responsive">
        <table class="table table-bordered align-middle">
            <thead class="bg-info">
                <tr>
                    <th style="white-space: nowrap;">SNo</th>
                    <th style="min-width: 200px;">Points</th>
                    <th>Status</th>
                    <th style="min-width: 150px;">Remarks</th>
                    <th style="min-width: 150px;">Upload Photo</th>
                </tr>
            </thead>
            <tbody>
</HeaderTemplate>
    <ItemTemplate>
      <tr>
          <td><%# Eval("QuestionNumber") %>
               <asp:HiddenField ID="hfQuestionNumber" runat="server" Value='<%# Eval("QuestionNumber") %>' />

          </td>
         <%-- <td  class="ab"><%# Eval("Description") %></td>--%>
           <td class="ab"><asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>' /></td>
          <td>
              <asp:RadioButton ID="rdoYes" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="Yes" CssClass="assessment-label status-option" Checked="true" />
              <asp:RadioButton ID="rdoNo" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="No" CssClass="assessment-label status-option" />
              <asp:RadioButton ID="rdoNA" runat="server" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                  Text="NA" CssClass="assessment-label status-option" />
          </td>
          <td>
              <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control remarks" Style="display:none;" />
          </td>
          <td>
              <asp:FileUpload ID="fileUpload" runat="server" CssClass="file-upload"   Style="display:none;" />
          </td>
      </tr>
  </ItemTemplate>

    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>

    <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="Lbl_txtnote" runat="server" AssociatedControlID="txtnote" Text="Remarks"  CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtnote" runat="server" ErrorMessage="*" ControlToValidate="txtnote" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtnote" runat="server" CssClass="form-control form-control-sm rounded "  TextMode="MultiLine"></asp:TextBox>
        </div>
    </div>
</div>

                </div>
            
                    </div>

</div>
            
          
     <div class="mb-3">
         <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="btnSubmit" Text="CLICK TO SAVE" ForeColor="Green" Font-Bold="true" Font-Size="Small"></asp:Label>
         <div class="input-group input-group-sm">
             <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success mt-3" ValidationGroup="submit" CausesValidation="true" OnClientClick="return validatesChecklist();"  OnClick="btnSubmit_Click" />
             <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning  mt-3" CausesValidation="false" OnClick="BtnReset_Click" />
             <asp:Button ID="btn_home" runat="server" Text="Home" CssClass="btn btn-danger  mt-3" CausesValidation="false" PostBackUrl="~/Home.aspx" />
             <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
         </div>
     </div>
 
                
                

        </div>
    </div>
</div>

<script type="text/javascript">
    window.onload = function () {
        const radios = document.querySelectorAll('.status-option input[type="radio"]');

        radios.forEach(radio => {
            radio.addEventListener("click", function () {
                const row = this.closest('tr');
                const value = this.nextSibling.textContent.trim(); // Yes / No / NA

                const txtRemarks = row.querySelector('input[type="text"], textarea, .form-control.remarks');
                const fileUpload = row.querySelector('input[type="file"], .fileUpload');

                if (value === "No") {
                    if (txtRemarks) txtRemarks.style.display = "block";
                    if (fileUpload) fileUpload.style.display = "block";
                } else {
                    if (txtRemarks) txtRemarks.style.display = "none";
                    if (fileUpload) fileUpload.style.display = "none";
                }
            });
        });
    };
</script>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- JavaScript to fetch employee name -->
<script type="text/javascript">
    function fetchEmployeeName() {
        var inspectionId = document.getElementById('<%= txtInsBy.ClientID %>').value;

        if (inspectionId.trim().length > 0) {
            $.ajax({
                type: "POST",
                url: "WeldingMachineChecklist.aspx/GetEmployeeName",
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
    function validateRemarksAndPhotos() {
        const rows = document.querySelectorAll("table tr"); // Adjust selector if needed

        for (let row of rows) {
            const selectedRadio = row.querySelector('.status-option input[type="radio"]:checked');

            if (selectedRadio) {
                const labelText = selectedRadio.nextSibling.textContent.trim();

                if (labelText === "No") {
                    const txtRemarks = row.querySelector('input[type="text"], textarea, .form-control.remarks');
                    const fileUpload = row.querySelector('input[type="file"], .fileUpload');

                    if (!txtRemarks || txtRemarks.style.display !== "none" && txtRemarks.value.trim() === "") {
                        alert("Please enter remarks for an item marked as 'No'.");
                        return false;
                    }

                    if (!fileUpload || fileUpload.style.display !== "none" && fileUpload.value === "") {
                        alert("Please upload a photo for an item marked as 'No'.");
                        return false;
                    }
                }
            }
        }

        return true;
    }
</script>


<script type="text/javascript">
    function validatesChecklist() {
        var date = document.getElementById('<%= txtdate.ClientID %>').value.trim();
    var site = document.getElementById('<%= txtloc.ClientID %>').value.trim();
    var jobId = document.getElementById('<%= txtjobId.ClientID %>').value.trim();
    var insp = document.getElementById('<%= txtInsBy.ClientID %>').value.trim(); 
        var re = document.getElementById('<%= txtnote.ClientID %>').value.trim();

        const digitsOnly = /^\d+$/;

        if (!date) {
            alert("Please select Date of Inspection.");
            return false;
        }
        if (!site) {
            alert("Please enter Location.");
            return false;
        }
        if (!jobId) {
            alert("Please enter JobID.");
            return false;
        }
        if (!digitsOnly.test(jobId)) {
            alert("Job ID must contain digits only.");
            return false;
        }
        if (!insp) {
            alert("Please enter Inspected by.");
            return false;
        }
        if (!re) {
            alert("Please give Remarks.");
            return false;
        }
        if (!validateRemarksAndPhotos()) {
            return false;
        }

        return true;
    }
</script>




<%--<script type="text/javascript">
function validatesChecklist() {
    var date = document.getElementById('<%= txtdate.ClientID %>').value.trim();
    var site = document.getElementById('<%= txtloc.ClientID %>').value.trim();
    var jobId = document.getElementById('<%= txtjobId.ClientID %>').value.trim();
    var insp = document.getElementById('<%= txtInsBy.ClientID %>').value.trim(); 
    var remark = document.getElementById('<%= txtnote.ClientID %>').value.trim();

    const digitsOnly = /^\d+$/;

    if (!date) {
        alert("Please select Date of Inspection.");
        return false;
    }
    if (!site) {
        alert("Please enter Location.");
        return false;
    }
    if (!jobId) {
        alert("Please enter JobID.");
        return false;
    }
    if (!digitsOnly.test(jobId)) {
        alert("Job ID must contain digits only.");
        return false;
    }
    if (!insp) {
        alert("Please enter Inspected by.");
        return false;
    }
    if (!remark) {
        alert("Please give Remarks.");
        return false;
    }

    

    return true;
}
</script>--%>





</asp:Content>
