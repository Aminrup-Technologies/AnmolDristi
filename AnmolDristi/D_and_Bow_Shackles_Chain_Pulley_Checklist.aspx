<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="D_and_Bow_Shackles_Chain_Pulley_Checklist.aspx.cs" Inherits="AnmolDristi.D_and_Bow_Shackles_Chain_Pulley_Checklist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .form-label {
            font-weight: bold;
            color: blue;
        }

        .table-bordered td {
            vertical-align: middle;
        }

        .d-inline {
            display: inline-block;
            margin-right: 10px;
        }

        .form-control {
            margin-top: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>D & bow Shackles, CHAIN PULLEY BLOCK Checklist</h3>
                </div>
            </div>
            <div class="x_panel">
                <div class="x_title">
                    <h2>Document No: DOC/ATS/TSK/QMS/GC/013 | Effective Date: 01/02/2024 | Revision No: REV:00</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <h3 style="color: teal; font-weight: bold; margin-top: 20px;">Step 1: Basic Details</h3>
                    <hr style="border: 0; border-top: 2px solid #c2c2c2; margin: 10px 0 20px 0;" />

                    <div class="row">

                        <!-- NAME OF SITE -->
                        <div class="col-md-3">
                            <div class="mb-3">
                                <asp:Label ID="lblSite" runat="server" Text="Site:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
                                <div class="input-group-sm">
                                    <asp:TextBox ID="txtSite" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Site" />
                                    <asp:RequiredFieldValidator ID="rfvSite" runat="server"
                                        ControlToValidate="txtSite"
                                        ErrorMessage="Please enter the site."
                                        ForeColor="Red" Display="Dynamic" />
                                </div>
                            </div>
                        </div>

                        <!-- TAG NO -->
                        <div class="col-md-3">
                            <div class="mb-3">
                                <asp:Label ID="lblTagNo" runat="server" Text="Tag No:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
                                <div class="input-group-sm">
                                    <asp:TextBox ID="txtTagNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Tag Number" />
                                    <asp:RequiredFieldValidator ID="rfvTagNo" runat="server"
                                        ControlToValidate="txtTagNo"
                                        ErrorMessage="Please enter the Tag No."
                                        ForeColor="Red" Display="Dynamic" />
                                </div>
                            </div>
                        </div>

                        <!-- DATE -->
                        <div class="col-md-3">
                            <div class="mb-3">
                                <asp:Label ID="lblDate" runat="server" Text="Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
                                <div class="input-group-sm">
                                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" />
                                    <asp:RequiredFieldValidator ID="rfvDate" runat="server"
                                        ControlToValidate="txtDate"
                                        ErrorMessage="Please select the date."
                                        ForeColor="Red" Display="Dynamic" />
                                </div>
                            </div>
                        </div>
                        <!-- JOB ID -->
<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lblJobID" runat="server" Text="Job ID:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
        <div class="input-group-sm">
            <asp:TextBox ID="txtJobID" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Job ID" />
            <asp:RequiredFieldValidator ID="rfvJobID" runat="server"
                ControlToValidate="txtJobID"
                ErrorMessage="Please enter the Job ID."
                ForeColor="Red" Display="Dynamic" />
        </div>
    </div>
</div>

<!-- JOB NAME -->
<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lblJobName" runat="server" Text="Job Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
        <div class="input-group-sm">
            <asp:TextBox ID="txtJobName" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Job Name" />
            <asp:RequiredFieldValidator ID="rfvJobName" runat="server"
                ControlToValidate="txtJobName"
                ErrorMessage="Please enter the Job Name."
                ForeColor="Red" Display="Dynamic" />
        </div>
    </div>
</div>
</div>


                        <!-- Row for Step 2 heading -->
                        <div class="row">
                            <div class="col-md-12">
                                <h3 style="color: teal; font-weight: bold; margin-top: 20px;">Step 2: Description: "D" & "bow" Shackles Checklist</h3>
                                <hr style="border: 0; border-top: 2px solid #c2c2c2; margin: 10px 0 20px 0;" />
                            </div>
                        </div>

                        <table class="table table-bordered">
                          <tr>
    <td>1. D & Bow shackle tested or not, tag fixed or not</td>
    <td>
        <asp:RadioButton ID="rbTestedOk" GroupName="Tested" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleTestedPanel()" />
        <asp:RadioButton ID="rbTestedNotOk" GroupName="Tested" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleTestedPanel()" />
        <asp:RadioButton ID="rbTestedNA" GroupName="Tested" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlTested" runat="server">
            <div id="divTestedPanel" style="display:none;">
                <asp:Label runat="server" Text="Remarks:" CssClass="form-label" /><br />
                <asp:TextBox ID="txtTestedRemarks" runat="server" CssClass="form-control" /><br />
                <asp:Label runat="server" Text="Upload Photo:" CssClass="form-label" /><br />
                <asp:FileUpload ID="fuTested" runat="server" /><br />
                <asp:CheckBox ID="chkTestedCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<tr>
    <td>2. Thread of the pin should not be damaged</td>
    <td>
        <asp:RadioButton ID="rbThreadOk" GroupName="Thread" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleThreadPanel()" />
        <asp:RadioButton ID="rbThreadNotOk" GroupName="Thread" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleThreadPanel()" />
        <asp:RadioButton ID="rbThreadNA" GroupName="Thread" Text="NA" runat="server" Visible="false"  />
    </td>
    <td>
        <asp:Panel ID="pnlThread" runat="server">
            <div id="divThreadPanel" style="display:none;">
                <asp:Label runat="server" Text="Remarks:" CssClass="form-label" /><br />
                <asp:TextBox ID="txtThreadRemarks" runat="server" CssClass="form-control" /><br />
                <asp:Label runat="server" Text="Upload Photo:" CssClass="form-label" /><br />
                <asp:FileUpload ID="fuThread" runat="server" /><br />
                <asp:CheckBox ID="chkThreadCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<tr>
    <td>3. No part should be worn more than 10% of original dimension</td>
    <td>
        <asp:RadioButton ID="rbWornOk" GroupName="Worn" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleWornPanel()" />
        <asp:RadioButton ID="rbWornNotOk" GroupName="Worn" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleWornPanel()" />
        <asp:RadioButton ID="rbWornNA" GroupName="Worn" Text="NA" runat="server" Visible="false"  />
    </td>
    <td>
        <asp:Panel ID="pnlWorn" runat="server">
            <div id="divWornPanel" style="display:none;">
                <asp:Label runat="server" Text="Remarks:" CssClass="form-label" /><br />
                <asp:TextBox ID="txtWornRemarks" runat="server" CssClass="form-control" /><br />
                <asp:Label runat="server" Text="Upload Photo:" CssClass="form-label" /><br />
                <asp:FileUpload ID="fuWorn" runat="server" /><br />
                <asp:CheckBox ID="chkWornCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<tr>
    <td>4. Strength of pin should be checked</td>
    <td>
        <asp:RadioButton ID="rbStrengthOk" GroupName="Strength" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleStrengthPanel()" />
        <asp:RadioButton ID="rbStrengthNotOk" GroupName="Strength" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleStrengthPanel()" />
        <asp:RadioButton ID="rbStrengthNA" GroupName="Strength" Text="NA" runat="server" Visible="false"  />
    </td>
    <td>
        <asp:Panel ID="pnlStrength" runat="server">
            <div id="divStrengthPanel" style="display:none;">
                <asp:Label runat="server" Text="Remarks:" CssClass="form-label" /><br />
                <asp:TextBox ID="txtStrengthRemarks" runat="server" CssClass="form-control" /><br />
                <asp:Label runat="server" Text="Upload Photo:" CssClass="form-label" /><br />
                <asp:FileUpload ID="fuStrength" runat="server" /><br />
                <asp:CheckBox ID="chkStrengthCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<tr>
    <td>5. No rusting on body or pin</td>
    <td>
        <asp:RadioButton ID="rbRustOk" GroupName="Rust" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleRustPanel()" />
        <asp:RadioButton ID="rbRustNotOk" GroupName="Rust" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleRustPanel()" />
        <asp:RadioButton ID="rbRustNA" GroupName="Rust" Text="NA" runat="server" Visible="false"  />
    </td>
    <td>
        <asp:Panel ID="pnlRust" runat="server">
            <div id="divRustPanel" style="display:none;">
                <asp:Label runat="server" Text="Remarks:" CssClass="form-label" /><br />
                <asp:TextBox ID="txtRustRemarks" runat="server" CssClass="form-control" /><br />
                <asp:Label runat="server" Text="Upload Photo:" CssClass="form-label" /><br />
                <asp:FileUpload ID="fuRust" runat="server" /><br />
                <asp:CheckBox ID="chkRustCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>
</table>



 



                          <!-- Row for Step 3 heading -->
  <div class="row">
      <div class="col-md-12">
          <h3 style="color: teal; font-weight: bold; margin-top: 20px;">Step 3: Description: CHAIN PULLEY BLOCK Checklist</h3>
          <hr style="border: 0; border-top: 2px solid #c2c2c2; margin: 10px 0 20px 0;" />
      </div>
  </div>
                        
                        
         
     <table class="table table-bordered">
    <tr>
        <td>1. Chain block is tested or not, Testing & due date of testing is ok or not</td>
        <td>
            <asp:RadioButton ID="rbChainTestedOk" GroupName="ChainTested" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleChainTestedPanel()" />
            <asp:RadioButton ID="rbChainTestedNotOk" GroupName="ChainTested" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleChainTestedPanel()" />
            <asp:RadioButton ID="rbChainTestedNA" GroupName="ChainTested" Text="NA" runat="server" Visible="false"  />
        </td>
        <td>
            <asp:Panel ID="pnlChainTested" runat="server">
                <div id="divChainTestedPanel" style="display:none;">
                    <asp:Label runat="server" Text="Remarks:" CssClass="form-label" /><br />
                    <asp:TextBox ID="txtChainTestedRemarks" runat="server" CssClass="form-control" /><br />
                    <asp:Label runat="server" Text="Upload Photo:" CssClass="form-label" /><br />
                    <asp:FileUpload ID="fuChainTested" runat="server" /><br />
                    <asp:CheckBox ID="chkChainTestedCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                    <span class="form-label">CAPA Required</span>
                </div>
            </asp:Panel>
        </td>
    </tr>

    <tr>
        <td>2. Any damaged chain links</td>
        <td>
            <asp:RadioButton ID="rbChainDamageOk" GroupName="ChainDamage" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleChainDamagePanel()" />
            <asp:RadioButton ID="rbChainDamageNotOk" GroupName="ChainDamage" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleChainDamagePanel()" />
            <asp:RadioButton ID="rbChainDamageNA" GroupName="ChainDamage" Text="NA" runat="server" Visible="false"  />
        </td>
        <td>
            <asp:Panel ID="pnlChainDamage" runat="server">
                <div id="divChainDamagePanel" style="display:none;">
                    <asp:Label runat="server" Text="Remarks:" CssClass="form-label" /><br />
                    <asp:TextBox ID="txtChainDamageRemarks" runat="server" CssClass="form-control" /><br />
                    <asp:Label runat="server" Text="Upload Photo:" CssClass="form-label" /><br />
                    <asp:FileUpload ID="fuChainDamage" runat="server" /><br />
                    <asp:CheckBox ID="chkChainDamageCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                    <span class="form-label">CAPA Required</span>
                </div>
            </asp:Panel>
        </td>
    </tr>

    <tr>
        <td>3. Chain & hook condition for any twist, wear, bend, corrosion & cracks</td>
        <td>
            <asp:RadioButton ID="rbConditionOk" GroupName="Condition" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleConditionPanel()" />
            <asp:RadioButton ID="rbConditionNotOk" GroupName="Condition" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleConditionPanel()" />
            <asp:RadioButton ID="rbConditionNA" GroupName="Condition" Text="NA" runat="server" Visible="false"  />
        </td>
        <td>
            <asp:Panel ID="pnlCondition" runat="server">
                <div id="divConditionPanel" style="display:none;">
                    <asp:Label runat="server" Text="Remarks:" CssClass="form-label" /><br />
                    <asp:TextBox ID="txtConditionRemarks" runat="server" CssClass="form-control" /><br />
                    <asp:Label runat="server" Text="Upload Photo:" CssClass="form-label" /><br />
                    <asp:FileUpload ID="fuCondition" runat="server" /><br />
                    <asp:CheckBox ID="chkConditionCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                    <span class="form-label">CAPA Required</span>
                </div>
            </asp:Panel>
        </td>
    </tr>

    <tr>
        <td>4. Safety latch & latch spring available in hook and functioning properly</td>
        <td>
            <asp:RadioButton ID="rbLatchOk" GroupName="Latch" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleLatchPanel()" />
            <asp:RadioButton ID="rbLatchNotOk" GroupName="Latch" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleLatchPanel()" />
            <asp:RadioButton ID="rbLatchNA" GroupName="Latch" Text="NA" runat="server" Visible="false"  />
        </td>
        <td>
            <asp:Panel ID="pnlLatch" runat="server">
                <div id="divLatchPanel" style="display:none;">
                    <asp:Label runat="server" Text="Remarks:" CssClass="form-label" /><br />
                    <asp:TextBox ID="txtLatchRemarks" runat="server" CssClass="form-control" /><br />
                    <asp:Label runat="server" Text="Upload Photo:" CssClass="form-label" /><br />
                    <asp:FileUpload ID="fuLatch" runat="server" /><br />
                    <asp:CheckBox ID="chkLatchCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                    <span class="form-label">CAPA Required</span>
                </div>
            </asp:Panel>
        </td>
    </tr>

    <tr>
        <td>5. Check padeye/hook is standard & welded properly when chain block to be ganged</td>
        <td>
            <asp:RadioButton ID="rbPadeyeOk" GroupName="Padeye" Text="Ok" runat="server" AutoPostBack="false" onclick="togglePadeyePanel()" />
            <asp:RadioButton ID="rbPadeyeNotOk" GroupName="Padeye" Text="Not Ok" runat="server" AutoPostBack="false" onclick="togglePadeyePanel()" />
            <asp:RadioButton ID="rbPadeyeNA" GroupName="Padeye" Text="NA" runat="server" Visible="false"  />
        </td>
        <td>
            <asp:Panel ID="pnlPadeye" runat="server">
                <div id="divPadeyePanel" style="display:none;">
                    <asp:Label runat="server" Text="Remarks:" CssClass="form-label" /><br />
                    <asp:TextBox ID="txtPadeyeRemarks" runat="server" CssClass="form-control" /><br />
                    <asp:Label runat="server" Text="Upload Photo:" CssClass="form-label" /><br />
                    <asp:FileUpload ID="fuPadeye" runat="server" /><br />
                    <asp:CheckBox ID="chkPadeyeCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                    <span class="form-label">CAPA Required</span>
                </div>
            </asp:Panel>
        </td>
    </tr>

    <tr>
        <td>6. Any part of hook should not be worn 10% of original dimension</td>
        <td>
            <asp:RadioButton ID="rbHookWearOk" GroupName="HookWear" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleHookWearPanel()" />
            <asp:RadioButton ID="rbHookWearNotOk" GroupName="HookWear" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleHookWearPanel()" />
            <asp:RadioButton ID="rbHookWearNA" GroupName="HookWear" Text="NA" runat="server" Visible="false"  />
        </td>
        <td>
            <asp:Panel ID="pnlHookWear" runat="server">
                <div id="divHookWearPanel" style="display:none;">
                    <asp:Label runat="server" Text="Remarks:" CssClass="form-label" /><br />
                    <asp:TextBox ID="txtHookWearRemarks" runat="server" CssClass="form-control" /><br />
                    <asp:Label runat="server" Text="Upload Photo:" CssClass="form-label" /><br />
                    <asp:FileUpload ID="fuHookWear" runat="server" /><br />
                    <asp:CheckBox ID="chkHookWearCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                    <span class="form-label">CAPA Required</span>
                </div>
            </asp:Panel>
        </td>
    </tr>
</table>
                        <script type="text/javascript">
                            function togglePanel(yesId, noId, panelDivId) {
                                var yes = document.getElementById(yesId);
                                var no = document.getElementById(noId);
                                var panelDiv = document.getElementById(panelDivId);

                                if (!yes || !no || !panelDiv) return;

                                if (no.checked) {
                                    panelDiv.style.display = 'block';
                                } else {
                                    panelDiv.style.display = 'none';
                                    
                                    var inputs = panelDiv.querySelectorAll('input[type="text"], textarea, input[type="file"]');
                                    inputs.forEach(function (input) {
                                        input.value = '';
                                    });
                                    var imgs = panelDiv.querySelectorAll('img');
                                    imgs.forEach(function (img) {
                                        img.src = '';
                                        img.style.display = 'none';
                                    });
                                }
                            }


                            // D & Bow Shackles Checklist
                            function toggleTestedPanel() {
                                togglePanel('<%= rbTestedOk.ClientID %>', '<%= rbTestedNotOk.ClientID %>', 'divTestedPanel');
                            }

                            function toggleThreadPanel() {
                                togglePanel('<%= rbThreadOk.ClientID %>', '<%= rbThreadNotOk.ClientID %>', 'divThreadPanel');
                            }

                            function toggleWornPanel() {
                                togglePanel('<%= rbWornOk.ClientID %>', '<%= rbWornNotOk.ClientID %>', 'divWornPanel');
                            }

                            function toggleStrengthPanel() {
                                togglePanel('<%= rbStrengthOk.ClientID %>', '<%= rbStrengthNotOk.ClientID %>', 'divStrengthPanel');
                            }

                            function toggleRustPanel() {
                                togglePanel('<%= rbRustOk.ClientID %>', '<%= rbRustNotOk.ClientID %>', 'divRustPanel');
                            }

                            // Chain Pulley Block Checklist
                            function toggleChainTestedPanel() {
                                togglePanel('<%= rbChainTestedOk.ClientID %>', '<%= rbChainTestedNotOk.ClientID %>', 'divChainTestedPanel');
                            }

                            function toggleChainDamagePanel() {
                                togglePanel('<%= rbChainDamageOk.ClientID %>', '<%= rbChainDamageNotOk.ClientID %>', 'divChainDamagePanel');
                            }

                            function toggleConditionPanel() {
                                togglePanel('<%= rbConditionOk.ClientID %>', '<%= rbConditionNotOk.ClientID %>', 'divConditionPanel');
                            }

                            function toggleLatchPanel() {
                                togglePanel('<%= rbLatchOk.ClientID %>', '<%= rbLatchNotOk.ClientID %>', 'divLatchPanel');
                            }

                            function togglePadeyePanel() {
                                togglePanel('<%= rbPadeyeOk.ClientID %>', '<%= rbPadeyeNotOk.ClientID %>', 'divPadeyePanel');
                            }

                            function toggleHookWearPanel() {
                                togglePanel('<%= rbHookWearOk.ClientID %>', '<%= rbHookWearNotOk.ClientID %>', 'divHookWearPanel');
                                                    }

                            // CAPA Warning
                            function confirmCAPA(checkbox) {
                                if (!checkbox.checked) {
                                    alert("CAPA is required. Proceeding without it is at your own risk.");
                                }
                            }


                            window.onload = function () {
                                var yesButtons = Array.from(document.querySelectorAll('input[type="radio"]'))
                                    .filter(rb => rb.id.endsWith("Ok") && !rb.id.endsWith("NotOk"));

                                yesButtons.forEach(function (rb) {
                                    rb.checked = true;
                                });

                                document.querySelectorAll('div[id^="div"]').forEach(function (panel) {
                                    panel.style.display = 'none';
                                });

                                // Call toggle functions
                                toggleTestedPanel();
                                toggleThreadPanel();
                                toggleWornPanel();
                                toggleStrengthPanel();
                                toggleRustPanel();
                                toggleChainTestedPanel();
                                toggleChainDamagePanel();
                                toggleLatchPanel();
                                togglePadeyePanel();
                                toggleHookWearPanel();
                            };








                        </script>


                  
                           <!-- Remarks -->
   <div class="col-md-6">
       <div class="mb-3">
           <asp:Label ID="lblRemarks" runat="server" Text="Remarks:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
           <div class="input-group-sm">
               <asp:TextBox ID="txtRemarks" runat="server"
                   CssClass="form-control form-control-sm rounded"
                   TextMode="MultiLine"
                   Rows="3"
                   Placeholder="Enter any remarks">
               </asp:TextBox>
           </div>
       </div>
   </div>
                        <script>

          function validateDandBowChecklist() {
    var isValid = true;
    var errorMessage = "";

    // Validate basic textboxes
    var fieldsToCheck = [
        { id: '<%= txtSite.ClientID %>', name: 'Site' },
        { id: '<%= txtTagNo.ClientID %>', name: 'Tag No' },
        { id: '<%= txtDate.ClientID %>', name: 'Date' },
        { id: '<%= txtJobID.ClientID %>', name: 'Job ID' },       
        { id: '<%= txtJobName.ClientID %>', name: 'Job Name' }
    ];

    fieldsToCheck.forEach(function (field) {
        var el = document.getElementById(field.id);
        if (el && el.value.trim() === "") {
            errorMessage += "- Please enter " + field.name + "\n";
            isValid = false;
        }
    });

    // Validate radio button groups by prefixing with control ID
    var radioGroups = [
        { groupName: "Tested", label: "D & Bow shackle tested" },
        { groupName: "Thread", label: "Thread of the pin" },
        { groupName: "Worn", label: "Wear on part" },
        { groupName: "Strength", label: "Strength of pin" },
        { groupName: "Rust", label: "Rusting on body or pin" },
        { groupName: "ChainTested", label: "Chain block testing status" },
        { groupName: "ChainDamage", label: "Damaged chain links" },
        { groupName: "Condition", label: "Chain & hook condition" },
        { groupName: "Latch", label: "Latch & spring condition" },
        { groupName: "Padeye", label: "Padeye/hook weld condition" },
        { groupName: "HookWear", label: "Hook wear status" }
    ];

    radioGroups.forEach(function (group) {
        var radios = document.querySelectorAll("input[type='radio'][name*='" + group.groupName + "']");
        var oneChecked = false;
        radios.forEach(function (radio) {
            if (radio.checked) {
                oneChecked = true;
            }
        });

        if (!oneChecked) {
            errorMessage += "- Please select an option for " + group.label + "\n";
            isValid = false;
        }
    });

    if (!isValid) {
        alert(errorMessage);
    }

    return isValid;
}
                        </script>

                        
                        </div>
                        <div class="row">
                        <div class="col-md-12 text-center">
                                    <div class="mb-3">
                                        <%--<asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>--%>
                                        <div class="btn-group" role="group">
<%--                                            <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />--%>

                                          <asp:Button ID="BtnSubmit" runat="server" Text="Save" 
                                                        CssClass="btn btn-primary btn-sm"
                                                        ValidationGroup="Submit" CausesValidation="true"
                                                        OnClientClick="return validateDandBowChecklist();"
                                                        OnClick="BtnSubmit_Click" />


                                            <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm ml-2" CausesValidation="false" OnClick="BtnReset_Click" />
                                            <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger ml-2" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                        </div>
                                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true" />
                                    </div>
                                </div>
                            </div>
                    
                
            </div>
        </div>
    </div>
</asp:Content>
