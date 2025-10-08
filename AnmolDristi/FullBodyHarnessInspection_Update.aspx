<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="FullBodyHarnessInspection_Update.aspx.cs" Inherits="AnmolDristi.FullBodyHarnessInspection_Update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     
<%--<style type="text/css">
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
    </style>--%>
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
    <asp:Label ID="lbl_txtInsBy" runat="server" AssociatedControlID="txtInsBy" Text="Inspection By(Emp Code)" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
    <asp:RequiredFieldValidator ID="RFV_txtInsBy" runat="server" ErrorMessage="*" ControlToValidate="txtInsBy" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
    <div class="input-group-sm">
        <asp:TextBox ID="txtInsBy" runat="server" CssClass="form-control form-control-sm rounded " ReadOnly="true" ></asp:TextBox>
    </div>
          </div>
</div>
        <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtDocNo" runat="server" AssociatedControlID="txtDocNo" Text="Employee Name" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtDocNo" runat="server" ErrorMessage="*" ControlToValidate="txtDocNo" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtDocNo" runat="server" CssClass="form-control form-control-sm rounded " ReadOnly="true" ></asp:TextBox>
        </div>
    </div>
</div>
     <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtjobID" runat="server" AssociatedControlID="txtjobID" Text="Job ID" CssClass="assessment-label" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtjobID" runat="server" ErrorMessage="*" ControlToValidate="txtjobID" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtjobID" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>
     <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="Lbl_txtnote" runat="server" AssociatedControlID="txtnote" Text="Remarks" CssClass="assessment-label"  Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtnote" runat="server" ErrorMessage="*" ControlToValidate="txtnote" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtnote" runat="server" CssClass="form-control form-control-sm rounded "  TextMode="MultiLine"></asp:TextBox>
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

<asp:HiddenField ID="hfHeaderID" runat="server" />

 
                    

<asp:Repeater ID="rptsChecklist" runat="server">   
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
                <asp:RadioButton ID="rdoYes" runat="server" Value="Yes" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                    Text="Yes" CssClass="assessment-label status-option" Checked="true" onclick="toggleFields(this)" />
                <asp:RadioButton ID="rdoNo" runat="server" Value="No" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                    Text="No" CssClass="assessment-label status-option" onclick="toggleFields(this)" />
                <asp:RadioButton ID="rdoNA" runat="server" Value="Na" GroupName='<%# "grp_" + Eval("QuestionNumber") %>'
                    Text="NA" CssClass="assessment-label status-option" onclick="toggleFields(this)" />
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


<%--   <div class="table-responsive">
    <div class="col-md-12">
        <div class="mb-3">
            <asp:GridView ID="gvChecklist" runat="server" AutoGenerateColumns="False" DataKeyNames="IdentificationNo"
                CssClass="table table-bordered table-sm table-hover table-striped nowrap" GridLines="None"  >
                <HeaderStyle BackColor="#2C3E50" ForeColor="#ECF0F1" Font-Bold="true" Font-Size="Small" Font-Names="Segoe UI" HorizontalAlign="Center" />
                <Columns>

                    <asp:TemplateField HeaderText="Identification No">
                        <ItemTemplate>
                            <asp:Label ID="lblIdentificationNo" runat="server" Text='<%# Eval("IdentificationNo") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Location">
                        <ItemTemplate>
                            <asp:TextBox ID="txtLocation" runat="server" Text='<%# Eval("Location") %>' CssClass="form-control gv-input" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- Q1 Fields 
                   <%-- <asp:TemplateField HeaderText="Q1 Status">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ1Status" runat="server" Text='<%# Eval("Q1Status") %>' CssClass="form-control gv-input" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    
                    <asp:TemplateField HeaderText="Q1 Status">
                      <ItemTemplate>
                      <asp:DropDownList ID="ddlQ1Status" runat="server" CssClass="form-control gv-input" SelectedValue='<%# Eval("Q1Status") %>'>
    <asp:ListItem Text="Select" Value="" />
    <asp:ListItem Text="OK" Value="OK" />
    <asp:ListItem Text="Not OK" Value="Not OK" />
</asp:DropDownList>
                     </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Q1 Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ1Remarks" runat="server" Text='<%# Eval("Q1Remarks") %>' CssClass="form-control gv-input" />
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="Q1 Photo">
    <ItemTemplate>
        <asp:Image ID="imgQ1Photo" runat="server" 
                   ImageUrl='<%# Eval("Q1Photo", "{0}") %>' Width="90px" Height="90px" Style="object-fit:cover;"/>
        <!-- Hidden field to retain existing image path -->
<asp:Label ID="lblimgQ1Photo" runat="server" 
    Text='<%# Eval("Q1Photo") %>' Visible="false" />

<!-- Upload control to select a new image -->
<br />
<asp:FileUpload ID="fuimgQ1Photo" runat="server" />

    </ItemTemplate>
</asp:TemplateField>


                    <%-- Q2 Fields 
                   <%-- <asp:TemplateField HeaderText="Q2 Status">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ2Status" runat="server" Text='<%# Eval("Q2Status") %>' CssClass="form-control gv-input" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Q2 Status">
                       <ItemTemplate>
                                                 <asp:DropDownList ID="ddlQ2Status" runat="server" CssClass="form-control gv-input" SelectedValue='<%# Eval("Q2Status") %>'>
    <asp:ListItem Text="Select" Value="" />
    <asp:ListItem Text="OK" Value="OK" />
    <asp:ListItem Text="Not OK" Value="Not OK" />
</asp:DropDownList>
                      
                     </ItemTemplate>
                     </asp:TemplateField>
                    <asp:TemplateField HeaderText="Q2 Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ2Remarks" runat="server" Text='<%# Eval("Q2Remarks") %>' CssClass="form-control gv-input" />
                        </ItemTemplate>
                    </asp:TemplateField>
   <asp:TemplateField HeaderText="Q2 Photo">
    <ItemTemplate>
        <asp:Image ID="imgQ2Photo" runat="server" 
                   ImageUrl='<%# Eval("Q2Photo", "{0}") %>' Width="90px" Height="90px" Style="object-fit:cover;"/>
                <!-- Hidden field to retain existing image path -->
<asp:Label ID="lblimgQ2Photo" runat="server" 
    Text='<%# Eval("Q2Photo") %>' Visible="false" />

<!-- Upload control to select a new image -->
<br />
<asp:FileUpload ID="fuimgQ2Photo" runat="server" />
    </ItemTemplate>
</asp:TemplateField>
                    <%-- Q3 Fields
                   <%-- <asp:TemplateField HeaderText="Q3 Status">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ3Status" runat="server" Text='<%# Eval("Q3Status") %>' CssClass="form-control gv-input" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Q3 Status">
    <ItemTemplate>
                                                         <asp:DropDownList ID="ddlQ3Status" runat="server" CssClass="form-control gv-input" SelectedValue='<%# Eval("Q3Status") %>'>
    <asp:ListItem Text="Select" Value="" />
    <asp:ListItem Text="OK" Value="OK" />
    <asp:ListItem Text="Not OK" Value="Not OK" />
</asp:DropDownList>
                      
    </ItemTemplate>
</asp:TemplateField>

                    <asp:TemplateField HeaderText="Q3 Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ3Remarks" runat="server" Text='<%# Eval("Q3Remarks") %>' CssClass="form-control gv-input" />
                        </ItemTemplate>
                    </asp:TemplateField>
                       <asp:TemplateField HeaderText="Q3 Photo">
    <ItemTemplate>
        <asp:Image ID="imgQ3Photo" runat="server" 
                   ImageUrl='<%# Eval("Q3Photo", "{0}") %>' Width="90px" Height="90px" Style="object-fit:cover;" />
                
<asp:Label ID="lblimgQ3Photo" runat="server" 
    Text='<%# Eval("Q3Photo") %>' Visible="false" />

<!-- Upload control to select a new image -->
<br />
<asp:FileUpload ID="fuimgQ3Photo" runat="server" />
    </ItemTemplate>
</asp:TemplateField>

                    Q4 Fields 
                    <asp:TemplateField HeaderText="Q4 Status">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ4Status" runat="server" Text='<%# Eval("Q4Status") %>' CssClass="form-control gv-input" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Q4 Status">
    <ItemTemplate>
                                                         <asp:DropDownList ID="ddlQ4Status" runat="server" CssClass="form-control gv-input" SelectedValue='<%# Eval("Q4Status") %>'>
    <asp:ListItem Text="Select" Value="" />
    <asp:ListItem Text="OK" Value="OK" />
    <asp:ListItem Text="Not OK" Value="Not OK" />
</asp:DropDownList>
                      
    </ItemTemplate>
</asp:TemplateField>
                    <asp:TemplateField HeaderText="Q4 Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ4Remarks" runat="server" Text='<%# Eval("Q4Remarks") %>' CssClass="form-control gv-input" />
                        </ItemTemplate>
                    </asp:TemplateField>
                   
  <asp:TemplateField HeaderText="Q4 Photo">
        <ItemTemplate>
        <asp:Image ID="imgQ4Photo" runat="server" 
                   ImageUrl='<%# Eval("Q4Photo", "{0}") %>' Width="90px" Height="90px" Style="object-fit:cover;"/>
                    <!-- Hidden field to retain existing image path -->
<asp:Label ID="lblimgQ4Photo" runat="server" 
    Text='<%# Eval("Q4Photo") %>' Visible="false" />

<!-- Upload control to select a new image -->
<br />
<asp:FileUpload ID="fuimgQ4Photo" runat="server" />
    </ItemTemplate>
</asp:TemplateField>


                    <%-- Q5 Fields 
                    <asp:TemplateField HeaderText="Q5 Status">
    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlQ5Status" runat="server" CssClass="form-control gv-input" SelectedValue='<%# Eval("Q5Status") %>'>
    <asp:ListItem Text="Select" Value="" />
    <asp:ListItem Text="OK" Value="OK" />
    <asp:ListItem Text="Not OK" Value="Not OK" />
</asp:DropDownList>
                      
    </ItemTemplate>
</asp:TemplateField>
                    <asp:TemplateField HeaderText="Q5 Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ5Remarks" runat="server" Text='<%# Eval("Q5Remarks") %>' CssClass="form-control gv-input" />
                        </ItemTemplate>
                    </asp:TemplateField>
                  
                      <asp:TemplateField HeaderText="Q5 Photo">
                        <ItemTemplate>
        <asp:Image ID="imgQ5Photo" runat="server" 
                   ImageUrl='<%# Eval("Q5Photo", "{0}") %>' Width="90px" Height="90px" Style="object-fit:cover;"/>
                            
<asp:Label ID="lblimgQ5Photo" runat="server" 
    Text='<%# Eval("Q5Photo") %>' Visible="false" />

<!-- Upload control to select a new image -->
<br />
<asp:FileUpload ID="fuimgQ5Photo" runat="server" />
    </ItemTemplate>
</asp:TemplateField>

                    <%-- Action Buttons 
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnDelInsp" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger" OnClick="BtnDelInsp_Click" OnClientClick="return confirm('Are you sure you want to delete?');" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>
    </div>
</div>--%>


                </div>
            </div>


            <%--Button--%>
<div class="col-md-3">
                <div class="mb-3">
                    <asp:Label ID="Lbl_BtnUpdate" runat="server" AssociatedControlID="BtnUpdate" Text="Click to Update" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group input-group-sm">
                        <asp:Button ID="BtnUpdate" runat="server" Text="Update" CssClass="btn btn-success btn-sm" ValidationGroup="submit" CausesValidation="true" OnClientClick="return validateAllQStatus();"  OnClick="BtnUpdate_Click" />
                        <asp:Button ID="BtnBack" runat="server" Text="Back" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnBack_Click" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        
                    </div>
                </div>
            </div>            

        </div>
    </div>
</div>
<%--<script type="text/javascript">
    function validateAllQStatus() {
        let isValid = true;
        const grid = document.getElementById("<%= gvChecklist.ClientID %>");
        if (!grid) return true;

        const rows = grid.getElementsByTagName("tr");

        for (let i = 0; i < rows.length; i++) {
            for (let q = 1; q <= 5; q++) {
                const ddl = rows[i].querySelector(`select[id*='ddlQ${q}Status']`);
                const remarks = rows[i].querySelector(`input[id*='txtQ${q}Remarks']`);
                const fileUpload = rows[i].querySelector(`input[id*='fuimgQ${q}Photo']`);
                const imgPreview = rows[i].querySelector(`img[id*='imgQ${q}Photo']`);

                if (ddl && ddl.value === "Not OK") {
                    const remarkValue = remarks ? remarks.value.trim() : "";
                    const fileValue = fileUpload ? fileUpload.value.trim() : "";
                    const previewSrc = imgPreview ? imgPreview.src.trim() : "";

                    const hasImage = fileValue !== "" || (previewSrc && !previewSrc.toLowerCase().includes("blank") && !previewSrc.toLowerCase().includes("noimage"));

                    if (!remarkValue || !hasImage) {
                        if (remarks && !remarkValue) remarks.classList.add("is-invalid");
                        if (!hasImage && fileUpload) fileUpload.classList.add("is-invalid");

                        isValid = false;
                    } else {
                        if (remarks) remarks.classList.remove("is-invalid");
                        if (fileUpload) fileUpload.classList.remove("is-invalid");
                    }
                } else {
                    if (remarks) remarks.classList.remove("is-invalid");
                    if (fileUpload) fileUpload.classList.remove("is-invalid");
                }
            }
        }

        if (!isValid) {
            alert("For any 'Not OK' , Remarks and Photo (or existing preview) are required.");
        }

        return isValid;
    }
</script>--%>

  <script type="text/javascript">
      window.onload = function () {
          const radios = document.querySelectorAll('.status-option input[type="radio"], .status-option');

          radios.forEach(radio => {
              radio.addEventListener("click", function () {
                  const row = this.closest('tr');
                  const value = this.value || this.textContent.trim(); // Use value first

                  const txtRemarks = row.querySelector('.form-control.remarks');
                  const fileUpload = row.querySelector('.fileUpload'); // Corrected class name
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
      function toggleFields(radio) {
          const row = radio.closest("tr");
          const remarks = row.querySelector(".remarks");
          const fileUpload = row.querySelector(".file-upload");
          const capaCheckbox = row.querySelector(".capa-checkbox");
          const imgPreview = row.querySelector(".img-thumbnail"); // 👈 target your <asp:Image>

          if (radio.value === "No") {
              //  Enable Remarks & File Upload for "No"
              if (remarks) {
                  remarks.disabled = false;
              }
              if (fileUpload) {
                  fileUpload.style.display = "block";
              }
              //  Show and check CAPA checkbox
              if (capaCheckbox) {
                  capaCheckbox.style.display = "inline-block";
                  capaCheckbox.checked = true;
              }
              //  Show image preview if available (optional)
              if (imgPreview && imgPreview.src) {
                  imgPreview.style.display = "block";
              }

          } else {
              //  Disable & clear for "Yes" or "N/A"
              if (remarks) {
                  remarks.value = "";
                  remarks.disabled = true;
              }
              if (fileUpload) {
                  fileUpload.value = "";
                  fileUpload.style.display = "none";
              }
              //  Hide and uncheck CAPA checkbox
              if (capaCheckbox) {
                  capaCheckbox.checked = false;
                  capaCheckbox.style.display = "none";
              }
              //  Hide image preview
              if (imgPreview) {
                  imgPreview.src = ""; // clear image
                  imgPreview.style.display = "none";
              }
          }
      }
  </script>




</asp:Content>
