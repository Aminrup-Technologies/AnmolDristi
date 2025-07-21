<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="FireExtinguisherChecklistUpdate.aspx.cs" Inherits="AnmolDristi.FireExtinguisherChecklistUpdate" %>
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
                <h3> FireExtinguisher Update Page | DOC/ATS/QOS/004 |  Eff. Date:19/05/2025 | REVISION NO:00
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
       <%-- <asp:RegularExpressionValidator  ID="REV_txtjobID"  ControlToValidate="txtjobID"  ValidationExpression="^\d+$" ErrorMessage="Only digits are allowed"  ForeColor="Red"  runat="server" />
       --%> <div class="input-group-sm">
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
            <asp:TextBox ID="txtDocNo" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
            <asp:HiddenField ID="hfEmployeeName" runat="server" /> <!-- ✅ Hidden field to store actual name -->
        </div>
    </div>
</div>




</div>
        
                              
                                 

 <div class="x_title">
     <h2 class="text-info h4">CheckList Details</h2>
     <div class="clearfix"></div>
 </div>

    <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_ddlType" runat="server" AssociatedControlID="ddlType" Text="Fire Extinguisher Type" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_ddlType" runat="server" ErrorMessage="*" ControlToValidate="ddlType" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control form-control-sm rounded">
                 <asp:ListItem Text="Select" Value="" />
                 <asp:ListItem Text="Water" Value="Water" />
                 <asp:ListItem Text="Foam (AFFF)" Value="Foam" />
                <asp:ListItem Text="Dry Powder (ABC)" Value="Dry Powder" />
                <asp:ListItem Text="CO₂" Value="CO₂" />
                <asp:ListItem Text="Wet Chemical" Value="Wet Chemical" />
           </asp:DropDownList></div>
    </div>
</div>
<div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_txtsno" runat="server" AssociatedControlID="txtsno" Text="FE SerialNo" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtsno" runat="server" ErrorMessage="*" ControlToValidate="txtsno" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtsno" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>

     <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_txtCalibrationDate" runat="server" AssociatedControlID="txtCalibrationDate" Text="Calibration Date" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtCalibrationDate"  runat="server" ErrorMessage="*" ControlToValidate="txtCalibrationDate" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtCalibrationDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>
  <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_txtDueDate" runat="server" AssociatedControlID="txtDueDate" Text="Due Date" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtDueDate"  runat="server" ErrorMessage="*" ControlToValidate="txtDueDate" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtDueDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>
        
<asp:Repeater ID="rptChecklist" runat="server">   
<HeaderTemplate>
    <div class="table-responsive"> 
        <table class="table table-bordered align-middle" >
           <thead class="bg-info">
    <tr>
        <th style="white-space: nowrap;">SNo</th>
        <th style="min-width: 200px;">CheckList Points</th>
        <th>Status</th>
        <th style="min-width: 150px;">Remarks</th>
        <th style="min-width: 150px;">Upload Photo</th>
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
                 <asp:FileUpload ID="fileUpload" runat="server" CssClass="fileUpload"   Style="display:none;" />
                 <asp:Image ID="imgPreview" runat="server" Width="100" Height="100" Visible="false" CssClass="mt-2 img-thumbnail" />
                 <asp:HiddenField ID="hfImagePath" runat="server" />
            </td>
             <td>
                <asp:CheckBox ID="chkCapaReport" runat="server" CssClass="capa-checkbox" Text="CAPA Report" Style="display:none;" />
                 <asp:HiddenField ID="hfCapaReportID" runat="server" />
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
         <asp:Label ID="Lbl_btnUpdate" runat="server" AssociatedControlID="btnUpdate" Text="CLICK TO UPDATE" ForeColor="Green" Font-Bold="true" Font-Size="Small"></asp:Label>
         <div class="input-group input-group-sm">
             <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success mt-3" ValidationGroup="submit" CausesValidation="true" OnClientClick="return validatessChecklist();"  OnClick="btnUpdate_Click" />
             <asp:Button ID="BtnBack" runat="server" Text="Back" CssClass="btn btn-warning  mt-3" CausesValidation="false" OnClick="BtnBack_Click" />
             <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
         </div>
     </div>
        </div>
    </div>
</div>




    <script type="text/javascript">
        window.onload = function () {
            const radios = document.querySelectorAll('.status-option input[type="radio"], .status-option');

            radios.forEach(radio => {
                radio.addEventListener("click", function () {
                    const row = this.closest('tr');
                    const value = this.value || this.textContent.trim(); // Use value first

                    const txtRemarks = row.querySelector('.form-control.remarks');
                    const fileUpload = row.querySelector('.fileUpload'); // Corrected class name
                    const chkCapa = row.querySelector('.capa-checkbox input[type="checkbox"], .capa-checkbox');

                    if (value === "No") {
                        if (txtRemarks) txtRemarks.style.display = "block";
                        if (fileUpload) fileUpload.style.display = "block";
                        if (chkCapa) {
                            chkCapa.style.display = "block";
                            chkCapa.checked = true;
                        }
                    } else {
                        if (txtRemarks) txtRemarks.style.display = "none";
                        if (fileUpload) fileUpload.style.display = "none";
                        if (chkCapa) {
                            chkCapa.style.display = "none";
                            chkCapa.checked = false;
                        }
                    }
                });
            });
        };
    </script>


</asp:Content>
