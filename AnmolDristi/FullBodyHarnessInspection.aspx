<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="FullBodyHarnessInspection.aspx.cs" Inherits="AnmolDristi.FullBodyHarnessInspection" %>
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
                <h3>Full Body Harness Inspection
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        
                        <h2>DOC/ATS/TSK/FBH/013 | Eff.Date: 01.02.2024 | REVISION NO:00</h2>
                         <div class="clearfix"></div>
                      </div>

                    <div class="x_content">

                        
                                <div class="row">             
      <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Date Of Inspection" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
     <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtSite" runat="server" AssociatedControlID="txtSite" Text="Site" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtSite" runat="server" ErrorMessage="*" ControlToValidate="txtSite" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtSite" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
                                            <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtjobID" runat="server" AssociatedControlID="txtjobID" Text="Job ID" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtjobID" runat="server" ErrorMessage="*" ControlToValidate="txtjobID" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
       <%-- <asp:RegularExpressionValidator  ID="REV_txtjobID"  ControlToValidate="txtjobID"  ValidationExpression="^\d+$" ErrorMessage="Only digits are allowed"  ForeColor="Red"  runat="server" />--%>

        <div class="input-group-sm">
            <asp:TextBox ID="txtjobID" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>

       
<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtInsBy" runat="server" AssociatedControlID="txtInsBy" Text="Inspection By(Emp Code)" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtInsBy" runat="server" ErrorMessage="*" ControlToValidate="txtInsBy" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtInsBy" runat="server" CssClass="form-control form-control-sm rounded" OnKeyUp="fetchEmployeeName()"  AutoPostBack="false"></asp:TextBox>
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
        
                              
                                    </div>

  <div class="x_title">
     <h2 class="text-info h4">Inspection CheckList</h2>
     <div class="clearfix"></div>
 </div>

                         <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_txtIdentity" runat="server" AssociatedControlID="txtIdentity" Text="Identification No" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtIdentity"  runat="server" ErrorMessage="*" ControlToValidate="txtIdentity" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtIdentity" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
        </div>
    </div>
</div>
  <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbltxtLoc" runat="server" AssociatedControlID="txtLoc" Text="Location" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtLoc"  runat="server" ErrorMessage="*" ControlToValidate="txtLoc" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtLoc" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
        </div>
    </div>
</div>

                            
<asp:Repeater ID="rptsChecklist" runat="server">   
<HeaderTemplate>
    <div class="table-responsive"> 
        <table class="table table-bordered align-middle" >
           <thead class="bg-info">
    <tr>
        <th style="white-space: nowrap;">SNo</th>
        <th style="min-width: 100px;">Points</th>
        <th>Status</th>
        <th style="min-width: 90px;">Remarks</th>
        <th>Upload Photo</th>
         <th>CAPA Report</th>
    </tr>
</thead> 
            <tbody>
               
</HeaderTemplate>
    <ItemTemplate>
        <tr>
            <td><%# Eval("QuestionNumber") %>
                <asp:HiddenField ID="hfQuestionNumber" runat="server" Value='<%# Eval("QuestionNumber") %>' />
            </td>
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
                <td>
                     <asp:CheckBox ID="chkCapaReport" runat="server" CssClass="capa-checkbox" Text="CAPA Report" Style="display:none;" onclick="return confirmCAPAUncheck(this);" />
               </td>
        </tr>
    </ItemTemplate>

    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</asp:Repeater>

  

                   


    <div class="col-md-4">
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


            <%--Button--%>
            <div class="col-md-3">
                <div class="mb-3">
                    <asp:Label ID="Lbl_BtnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group input-group-sm">
                        <asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm"  OnClick="BtnSubmit_Click" OnClientClick="return validateFormBeforeSubmit();" />
                        <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                        <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/Home.aspx" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

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

                if (value === "No") {
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
        function validateFormBeforeSubmit() {
            let isValid = true;
            let errorMsg = "";

            document.querySelectorAll("tr").forEach(row => {
                const noRadio = row.querySelector("input[type=radio][value='No']");
                const isNoChecked = noRadio && noRadio.checked;

                if (isNoChecked) {
                    const remarks = row.querySelector(".remarks");
                    const fileUpload = row.querySelector(".file-upload");

                    if (remarks && !remarks.value.trim()) {
                        isValid = false;
                        errorMsg = "Please fill in remarks for all 'No' responses.";
                    }
                    if (fileUpload && fileUpload.style.display !== "none" && fileUpload.files.length === 0) {
                        isValid = false;
                        errorMsg = "Please upload photo for all 'No' responses.";
                    }
                }
            });

            if (!isValid) {
                alert(errorMsg);
            }

            return isValid;
        }
</script>



<%--<script type="text/javascript">
    function validatesChecklist() {
       <%-- var identity = document.getElementById('<%= txtIdentity.ClientID %>').value.trim();
        var location = document.getElementById('<%= txtLoc.ClientID %>').value.trim();-
        var date = document.getElementById('<%= txtdate.ClientID %>').value.trim();
        var site = document.getElementById('<%= txtSite.ClientID %>').value.trim(); 
        <%--var docNo = document.getElementById('<%= txtDocNo.ClientID %>').value.trim();
        var jobId = document.getElementById('<%= txtjobID.ClientID %>').value.trim();
        var insp = document.getElementById('<%= txtInsBy.ClientID %>').value.trim(); 
        var remark = document.getElementById('<%= txtnote.ClientID %>').value.trim();
        if (!date) {
            alert("Please select Date of Inspection.");
            return false;
        }

        if (!site) {
            alert("Please enter Site.");
            return false;
        }
        if (!jobId) {
            alert("Please enter JobID.");
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
        for (var i = 0; i < 5; i++) {
            var rdoNotOk = document.getElementById(rdoNotOkIds[i]);
            var remarks = document.getElementById(txtRemarkIds[i]);
            var fileUpload = document.getElementById(fileUploadIds[i]);

            if (rdoNotOk && rdoNotOk.checked) {
                if (remarks && remarks.value.trim() === "") {
                    alert("Please enter remarks for Point " + (i + 1));
                    remarks.focus();
                    return false;
                }

                if (fileUpload && fileUpload.value.trim() === "") {
                    alert("Please upload a photo for Point " + (i + 1));
                    fileUpload.focus();
                    return false;
                }
            }
        }

        return true;
    }

</script>--%>


  <!-- Add the necessary jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script type="text/javascript">
    function fetchEmployeeName() {
        var inspectionId = document.getElementById('<%= txtInsBy.ClientID %>').value;

        if (inspectionId.length > 0) {
            $.ajax({
                type: "POST",
                url: "FullBodyHarnessInspection.aspx/GetEmployeeName",
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
                        hiddenField.value = employeeName;  // ✅ Save value to hidden field
                        lblError.innerText = '';
                    } else {
                        empTextBox.value = '';
                        empTextBox.readOnly = true;
                        hiddenField.value = '';
                        lblError.innerText = 'Invalid Inspection ID!';
                    }
                },
                error: function (xhr, status, error) {
                    console.error("AJAX Error: " + error);
                    document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = 'Error fetching data.';
                    document.getElementById('<%= txtDocNo.ClientID %>').value = '';
                    document.getElementById('<%= txtDocNo.ClientID %>').readOnly = true;
                    document.getElementById('<%= hfEmployeeName.ClientID %>').value = '';
                }
            });
        } else {
            document.getElementById('<%= txtDocNo.ClientID %>').value = '';
            document.getElementById('<%= txtDocNo.ClientID %>').readOnly = true;
            document.getElementById('<%= lblEmployeeName.ClientID %>').innerText = '';
            document.getElementById('<%= hfEmployeeName.ClientID %>').value = '';
        }
    }
</script>

<script type="text/javascript">
    function confirmCAPAUncheck(checkbox) {
        if (!checkbox.checked) {
            return confirm("CAPA is required.Proceeding without it is at your own risk");
        }
        return true;
    }
</script>

  
</asp:Content>
