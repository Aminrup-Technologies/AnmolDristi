<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="FullBodyHarnessInspection.aspx.cs" Inherits="AnmolDristi.FullBodyHarnessInspection" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
    
    .question-section {
    padding: 20px;
    background-color: #f7f7f7;
    border-radius: 8px;
}

.question-block {
    margin-bottom: 20px;
    padding: 15px;
    background-color: #ffffff;
    border: 1px solid #ccc;
    border-radius: 6px;
}

    .table-responsive {
    width: 100%;
    max-height: 400px; /* Adjust based on need */
    overflow-x: auto;
    overflow-y: auto;
    
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
                        
                        <h2>Full Body Harness Inspection</h2>
                         <div class="clearfix"></div>
                      </div>

                    <div class="x_content">

                        
                                <div class="row">  
                                    
      <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Date Of Inspection" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
     <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtSite" runat="server" AssociatedControlID="txtSite" Text="Site" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtSite" runat="server" ErrorMessage="*" ControlToValidate="txtSite" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtSite" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
        <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtDocNo" runat="server" AssociatedControlID="txtDocNo" Text="Document Number" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtDocNo" runat="server" ErrorMessage="*" ControlToValidate="txtDocNo" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtDocNo" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>
          <div class="col-md-3">
          <div class="mb-3">
        <asp:Label ID="lbl_txtInsBy" runat="server" AssociatedControlID="txtInsBy" Text="Inspection By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtInsBy" runat="server" ErrorMessage="*" ControlToValidate="txtInsBy" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtInsBy" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
              </div>
    </div>
</div>
        
                              
                                    </div>

 <div class="x_title">
     <h2>Inspection Checklist</h2>
     <div class="clearfix"></div>
 </div>
                    
                          <div class="col-md-6">
      <div class="mb-3">
    <asp:Label ID="lbl_txtIdentity" runat="server" AssociatedControlID="txtIdentity" Text="Identification No" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
    <asp:RequiredFieldValidator ID="RFV_txtIdentity" runat="server" ErrorMessage="*" ControlToValidate="txtIdentity" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
    <div class="input-group-sm">
        <asp:TextBox ID="txtIdentity" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
    </div>
          </div>
</div>
                          <div class="col-md-6">
      <div class="mb-3">
    <asp:Label ID="lbl_txtLoc" runat="server" AssociatedControlID="txtLoc" Text="Location" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
    <asp:RequiredFieldValidator ID="RFV_txtLoc" runat="server" ErrorMessage="*" ControlToValidate="txtLoc" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
    <div class="input-group-sm">
        <asp:TextBox ID="txtLoc" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
    </div>
          </div>
</div>


   <!-- Toggle Button -->
<div onclick="toggleDropdown('pnlQuestionBody')" style="cursor:pointer; background-color:#F5FFFA; color:#000000; padding:10px; border-radius:5px 5px 0 0; font-size: 1.5rem; font-weight: bold;" >
    Full Body Harness Checklist ▾
</div>

<!-- Collapsible Panel -->
<asp:Panel ID="pnlQuestionBody" runat="server" CssClass="question-section" Style="display:none;" ClientIDMode="Static">

    <!-- Point 1 -->
    <div class="question-block">
    <div class="row">
        <div class="col-md-12">
            <div class="mb-3">
                <asp:Label ID="lblPoint1" runat="server" Text="Point 1:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                <asp:Label ID="lblQ1" runat="server"  AssociatedControlID="" Text="Is the Harness conforming to IS: 3521 & also full body double lanyard type and length is not more than 1.8mtr?" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                <div class="input-group-sm">
                    <asp:RadioButton ID="rdoQ1Ok" runat="server" GroupName="Q1" Text="OK" onclick="toggleVisibility('divQ1', false)" Checked="true" />
                    <asp:RadioButton ID="rdoQ1NotOk" runat="server" GroupName="Q1" Text="Not OK" onclick="toggleVisibility('divQ1', true)" />
                </div>
            </div>
        </div>
    </div>

    <div id="divQ1" style="display:none;">
        <div class="row">
            <div class="col-md-4">
                <div class="mb-3">
                    <asp:Label ID="lbl_txtQ1Remarks" runat="server"  AssociatedControlID="txtQ1Remarks" Text="Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                  
                    <div class="input-group-sm">
                        <asp:TextBox ID="txtQ1Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="mb-3">
                    <asp:Label ID="lbl_fuQ1" runat="server" Text="Photo Upload"  AssociatedControlID="fuQ1" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                 
                    <div class="input-group-sm">
                        <asp:FileUpload ID="fuQ1" runat="server" CssClass="form-control form-control-sm rounded"  />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

 

    
    <!-- Point 2 -->
<div class="question-block">
    <div class="row">
        <div class="col-md-12">
            <div class="mb-3">
                <asp:Label ID="lblPoint2" runat="server" Text="Point 2:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                <asp:Label ID="lblQ2" runat="server"  AssociatedControlID="" Text="Condition of Lanyard: A) No visible damage B) Burn C) Cut D) Worn/Torn out" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label><br />
                <div class="input-group-sm">
                    <asp:RadioButton ID="rdoQ2Ok" runat="server" GroupName="Q2" Text="OK" onclick="toggleVisibility('divQ2', false)" Checked="true" />
                    <asp:RadioButton ID="rdoQ2NotOk" runat="server" GroupName="Q2" Text="Not OK" onclick="toggleVisibility('divQ2', true)" />
                </div>
            </div>
        </div>
    </div>
    <div id="divQ2" style="display:none;">
        <div class="row">
            <div class="col-md-4">
                <div class="mb-3">
                    <asp:Label ID="lbl_txtQ2Remarks" runat="server"  AssociatedControlID="txtQ2Remarks" Text="Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group-sm">
                    <asp:TextBox ID="txtQ2Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                         </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="mb-3">
                    <asp:Label ID="lbl_fuQ2" runat="server"  AssociatedControlID="fuQ2" Text="Photo Upload" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                 
                    <div class="input-group-sm">
                    <asp:FileUpload ID="fuQ2" runat="server" CssClass="form-control form-control-sm rounded"  />
                         </div>
                </div>
            </div>
        </div>
    </div>
</div>

  
    <!-- Point 3 -->
<div class="question-block">
    <div class="row">
        <div class="col-md-12">
            <div class="mb-3">
                <asp:Label ID="lblPoint3" runat="server" Text="Point 3:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                <asp:Label ID="lblQ3" runat="server"  AssociatedControlID="" Text="Condition of thimble and snap hook: A) No visible damage B) Smooth working of hook" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label><br />
                <div class="input-group-sm">
                    <asp:RadioButton ID="rdoQ3Ok" runat="server" GroupName="Q3" Text="OK" onclick="toggleVisibility('divQ3', false)" Checked="true" />
                    <asp:RadioButton ID="rdoQ3NotOk" runat="server" GroupName="Q3" Text="Not OK" onclick="toggleVisibility('divQ3', true)" />
                </div>
            </div>
        </div>
    </div>
    <div id="divQ3" style="display:none;">
        <div class="row">
            <div class="col-md-4">
                <div class="mb-3">
                    <asp:Label ID="lbl_txtQ3Remarks" runat="server"  AssociatedControlID="txtQ3Remarks" Text="Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                  
                    <div class="input-group-sm">
                    <asp:TextBox ID="txtQ3Remarks" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
                         </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="mb-3">
                    <asp:Label ID="lbl_fuQ3" runat="server"  AssociatedControlID="fuQ3" Text="Photo Upload" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                  
                    <div class="input-group-sm">
                    <asp:FileUpload ID="fuQ3" runat="server" CssClass="form-control form-control-sm rounded"  />
                         </div>
                </div>
            </div>
        </div>
    </div>
</div>


    <!-- Point 4 -->
<div class="question-block">
    <div class="row">
        <div class="col-md-12">
            <div class="mb-3">
                <asp:Label ID="lblPoint4" runat="server" Text="Point 4:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                <asp:Label ID="lblQ4" runat="server"  AssociatedControlID="" Text="Condition of stitching and buckles: A) Stitching is ok B) Rust free buckles" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label><br />
                <div class="input-group-sm">
                    <asp:RadioButton ID="rdoQ4Ok" runat="server" GroupName="Q4" Text="OK" onclick="toggleVisibility('divQ4', false)" Checked="true" />
                    <asp:RadioButton ID="rdoQ4NotOk" runat="server" GroupName="Q4" Text="Not OK" onclick="toggleVisibility('divQ4', true)" />
                </div>
            </div>
        </div>
    </div>
    <div id="divQ4" style="display:none;">
        <div class="row">
            <div class="col-md-4">
                <div class="mb-3">
                    <asp:Label ID="lbl_txtQ4Remarks" runat="server"  AssociatedControlID="txtQ4Remarks" Text="Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                 
                    <div class="input-group-sm">
                    <asp:TextBox ID="txtQ4Remarks" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
                         </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="mb-3">
                    <asp:Label ID="lbl_fuQ4" runat="server"  AssociatedControlID="fuQ4" Text="Photo Upload" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                   
                    <div class="input-group-sm">
                    <asp:FileUpload ID="fuQ4" runat="server" CssClass="form-control form-control-sm rounded"  />
                         </div>
                </div>
            </div>
        </div>
    </div>
</div>


 
    <!-- Point 5 -->
<div class="question-block">
    <div class="row">
        <div class="col-md-12">
            <div class="mb-3">
                <asp:Label ID="lblPoint5" runat="server" Text="Point 5:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                <asp:Label ID="lblQ5" runat="server"  AssociatedControlID="" Text="Condition of D-RINGS: A) Distortion B) Cracks C) Sharp edges D) Break" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label><br />
                <div class="input-group-sm">
                    <asp:RadioButton ID="rdoQ5Ok" runat="server" GroupName="Q5" Text="OK" onclick="toggleVisibility('divQ5', false)" Checked="true" />
                    <asp:RadioButton ID="rdoQ5NotOk" runat="server" GroupName="Q5" Text="Not OK" onclick="toggleVisibility('divQ5', true)" />
                </div>
            </div>
        </div>
    </div>
    <div id="divQ5" style="display:none;">
        <div class="row">
            <div class="col-md-4">
                <div class="mb-3">
                    <asp:Label ID="lbl_txtQ5Remarks"  runat="server" AssociatedControlID="txtQ5Remarks" Text="Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                 
                    <div class="input-group-sm">
                    <asp:TextBox ID="txtQ5Remarks" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
                </div>
                    </div>
            </div>
            <div class="col-md-4">
                <div class="mb-3">
                    <asp:Label ID="lbl_fuQ5" runat="server" AssociatedControlID="fuQ5" Text="Photo Upload" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
               
                    <div class="input-group-sm">
                    <asp:FileUpload ID="fuQ5" runat="server" CssClass="form-control form-control-sm rounded" />
                       </div>
                </div>
            </div>
        </div>
    </div>
</div>


 
</asp:Panel>
<script type="text/javascript">
    function toggleDropdown(panelId) {
        var panel = document.getElementById(panelId);
        panel.style.display = (panel.style.display === "none") ? "block" : "none";
    }

    function toggleVisibility(divId, show) {
        var div = document.getElementById(divId);
        div.style.display = show ? "block" : "none";
    }
</script>

          <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_btnAddChecklist" runat="server" AssociatedControlID="btnAddChecklist"  ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <div class="input-group">
            <asp:Button ID="btnAddChecklist" Text="Add Inspection" runat="server"  CssClass="btn btn-success btn-sm"   OnClientClick="return validateChecklist();"   OnClick="btnAddChecklist_Click" />
             <asp:Label ID="lblMsg1" runat="server" ></asp:Label>
        </div>
    </div>
</div>

        <div class="table-responsive">
<div class="col-md-12">
    <div class="mb-3">
   <asp:GridView ID="gvChecklist" runat="server" AutoGenerateColumns="False" DataKeyNames="IdentificationNo" CssClass="table table-bordered table-sm table-hover mt-4" >
      <HeaderStyle BackColor="#2C3E50" ForeColor="#ECF0F1" Font-Bold="true" Font-Size="Small" Font-Names="Segoe UI" HorizontalAlign="Center" />
    <Columns>
        <asp:BoundField HeaderText="Identification No" DataField="IdentificationNo" />
        <asp:BoundField HeaderText="Location" DataField="Location" />
        
        <asp:BoundField HeaderText="Q1 Status" DataField="Q1Status" />
        <asp:BoundField HeaderText="Q1 Remarks" DataField="Q1Remarks" />
        <asp:BoundField HeaderText="Q1 Photo" DataField="Q1Photo" />

        <asp:BoundField HeaderText="Q2 Status" DataField="Q2Status" />
        <asp:BoundField HeaderText="Q2 Remarks" DataField="Q2Remarks" />
        <asp:BoundField HeaderText="Q2 Photo" DataField="Q2Photo" />

        <asp:BoundField HeaderText="Q3 Status" DataField="Q3Status" />
        <asp:BoundField HeaderText="Q3 Remarks" DataField="Q3Remarks" />
        <asp:BoundField HeaderText="Q3 Photo" DataField="Q3Photo" />

        <asp:BoundField HeaderText="Q4 Status" DataField="Q4Status" />
        <asp:BoundField HeaderText="Q4 Remarks" DataField="Q4Remarks" />
        <asp:BoundField HeaderText="Q4 Photo" DataField="Q4Photo" />

        <asp:BoundField HeaderText="Q5 Status" DataField="Q5Status" />
        <asp:BoundField HeaderText="Q5 Remarks" DataField="Q5Remarks" />
        <asp:BoundField HeaderText="Q5 Photo" DataField="Q5Photo" />
       <asp:TemplateField HeaderText="Action">
       <ItemTemplate>
           <asp:Button ID="BtnDelIns" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"  OnClick="BtnDelIns_Click" OnClientClick="return confirm('Are you sure you want to delete?');" />
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
                    <asp:Label ID="Lbl_BtnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group input-group-sm">
                        <asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm"  OnClick="BtnSubmit_Click" />
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
    var rdoNotOkIds = [
        '<%= rdoQ1NotOk.ClientID %>',
        '<%= rdoQ2NotOk.ClientID %>',
        '<%= rdoQ3NotOk.ClientID %>',
        '<%= rdoQ4NotOk.ClientID %>',
        '<%= rdoQ5NotOk.ClientID %>'
    ];

    var txtRemarkIds = [
        '<%= txtQ1Remarks.ClientID %>',
        '<%= txtQ2Remarks.ClientID %>',
        '<%= txtQ3Remarks.ClientID %>',
        '<%= txtQ4Remarks.ClientID %>',
        '<%= txtQ5Remarks.ClientID %>'
    ];

    var fileUploadIds = [
        '<%= fuQ1.ClientID %>',
        '<%= fuQ2.ClientID %>',
        '<%= fuQ3.ClientID %>',
        '<%= fuQ4.ClientID %>',
        '<%= fuQ5.ClientID %>'
    ];
</script>
<script type="text/javascript">
    function validateChecklist() {
        var identity = document.getElementById('<%= txtIdentity.ClientID %>').value.trim();
        var location = document.getElementById('<%= txtLoc.ClientID %>').value.trim();

        if (!identity) {
            alert("Please enter Identification No.");
            return false;
        }

        if (!location) {
            alert("Please enter Location.");
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


</script>
<script type="text/javascript">
    function validateChecklist() {
        var identity = document.getElementById('<%= txtIdentity.ClientID %>').value.trim();
        var location = document.getElementById('<%= txtLoc.ClientID %>').value.trim();
        var date = document.getElementById('<%= txtdate.ClientID %>').value.trim();
    var site = document.getElementById('<%= txtSite.ClientID %>').value.trim();
    var docNo = document.getElementById('<%= txtDocNo.ClientID %>').value.trim();
        var inspectedBy = document.getElementById('<%= txtInsBy.ClientID %>').value.trim();

        if (!identity) {
            alert("Please enter Identification No.");
            return false;
        }

        if (!location) {
            alert("Please enter Location.");
            return false;
        }

        if (!date) {
            alert("Please select Date of Inspection.");
            return false;
        }

        if (!site) {
            alert("Please enter Site.");
            return false;
        }

        if (!docNo) {
            alert("Please enter Document Number.");
            return false;
        }

        if (!inspectedBy) {
            alert("Please enter Inspector's Name.");
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

</script>

  
</asp:Content>
