<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Grinding_Machine_Checklist.aspx.cs" Inherits="AnmolDristi.Grinding_Machine_Checklist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .remove-border {
            border: none !important;
        }

        .form-label {
            font-weight: bold;
            color: blue;
            display: block;
            margin-bottom: 10px;
        }

        .col-md-4 {
            margin-bottom: 20px;
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
                    <h3>GRINDING MACHINE CHECKLIST</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Document No: UN/GM/00 | Effective Date: 01.11.2022 | Revision No: REV:00</h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <h3 style="color: teal; font-weight: bold; margin-top: 5px;">Step 1: Basic Details</h3>
                            <hr style="border: 0; border-top: 2px solid #c2c2c2; margin: 10px 0 20px 0;" />
                            <div class="row">
                                <!-- Site -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblSite" runat="server" Text="Site:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtSite" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Site"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvSite" runat="server"
                                                ControlToValidate="txtSite"
                                                ErrorMessage="Please enter the site."
                                                ForeColor="Red" Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>

                                <!-- Date of Inspection -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblDateOfInspection" runat="server" Text="Date of Inspection:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDateOfInspection" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" Placeholder="Select Date"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDateOfInspection" runat="server"
                                                ControlToValidate="txtDateOfInspection"
                                                ErrorMessage="Please select a date."
                                                ForeColor="Red" Display="Dynamic" />
                                            <asp:CustomValidator ID="cvDateOfInspection" runat="server"
                                                ControlToValidate="txtDateOfInspection"
                                                OnServerValidate="ValidateDateOfInspection"
                                                ErrorMessage="Date cannot be in the future."
                                                ForeColor="Red" Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>

                                <!-- Inspected By (Emp Code) -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblInspectedBy" runat="server" Text="Inspected By :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtInspectedBy" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Employee Code"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvInspectedBy" runat="server"
                                                ControlToValidate="txtInspectedBy"
                                                ErrorMessage="Please enter employee code."
                                                ForeColor="Red" Display="Dynamic" />
                                            <asp:RegularExpressionValidator ID="revInspectedBy" runat="server"
                                                ControlToValidate="txtInspectedBy"
                                                ValidationExpression="^[a-zA-Z0-9]+$"
                                                ErrorMessage="Employee code must be alphanumeric."
                                                ForeColor="Red" Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>

                                <!-- SI No -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblSerialNo" runat="server" Text="SI No:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtSerialNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Serial No"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvSerialNo" runat="server"
                                                ControlToValidate="txtSerialNo"
                                                ErrorMessage="Please enter serial number."
                                                ForeColor="Red" Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>

                                <!-- Identification Number -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblIdentificationNumber" runat="server" Text="Identification Number:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtIdentificationNumber" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Identification Number"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvIdentificationNumber" runat="server"
                                                ControlToValidate="txtIdentificationNumber"
                                                ErrorMessage="Please enter identification number."
                                                ForeColor="Red" Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>

                                <!-- Location -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblLocation" runat="server" Text="Location:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtLocation" runat="server"
                                                CssClass="form-control form-control-sm rounded"
                                                Placeholder="Enter Location">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvLocation" runat="server"
                                                ControlToValidate="txtLocation"
                                                ErrorMessage="Please enter the location."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Job ID -->
<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lblJobID" runat="server" Text="Job ID:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <div class="input-group-sm">
            <asp:TextBox ID="txtJobID" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Job ID"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvJobID" runat="server"
                ControlToValidate="txtJobID"
                ErrorMessage="Please enter Job ID."
                ForeColor="Red" Display="Dynamic" />
        </div>
    </div>
</div>

<!-- Job Name -->
<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lblJobName" runat="server" Text="Job Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <div class="input-group-sm">
            <asp:TextBox ID="txtJobName" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Job Name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvJobName" runat="server"
                ControlToValidate="txtJobName"
                ErrorMessage="Please enter Job Name."
                ForeColor="Red" Display="Dynamic" />
        </div>
    </div>
</div>


                            </div>
                            <div>
                                <!-- Row for Step 2 heading -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <h3 style="color: teal; font-weight: bold; margin-top: 20px;">Step 2: Checklist Points</h3>
                                        <hr style="border: 0; border-top: 2px solid #c2c2c2; margin: 10px 0 20px 0;" />
                                    </div>
                                </div>


                                <table class="table table-bordered">
<!-- 1. Fore handle -->
<tr>
    <td>1. Fore handle without damage</td>
    <td>
        <asp:RadioButton ID="RbForeHandleYes" GroupName="ForeHandle" runat="server" AutoPostBack="false" onclick="toggleForeHandlePanel()" />
        <span class="form-label d-inline">Yes</span>
        <asp:RadioButton ID="RbForeHandleNo" GroupName="ForeHandle" runat="server" AutoPostBack="false" onclick="toggleForeHandlePanel()" />
        <span class="form-label d-inline">No</span>
    </td>
    <td>
        <asp:Panel ID="pnlForeHandle" runat="server">
            <div id="divForeHandlePanel" style="display:none;">
                <span class="form-label">Remarks</span>
                <asp:TextBox ID="txtForeHandleRemarks" runat="server" Width="200px" /><br />
                <span class="form-label">Upload Photo</span>
                <asp:FileUpload ID="fuForeHandle" runat="server" /><br />
                <asp:CheckBox ID="chkForeHandleCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 2. Wheel guard -->
<tr>
    <td>2. Wheel guard (covered 3/4th area)</td>
    <td>
        <asp:RadioButton ID="RbWheelGuardYes" GroupName="WheelGuard" runat="server" AutoPostBack="false" onclick="toggleWheelGuardPanel()" />
        <span class="form-label d-inline">Yes</span>
        <asp:RadioButton ID="RbWheelGuardNo" GroupName="WheelGuard" runat="server" AutoPostBack="false" onclick="toggleWheelGuardPanel()" />
        <span class="form-label d-inline">No</span>
    </td>
    <td>
        <asp:Panel ID="pnlWheelGuard" runat="server">
            <div id="divWheelGuardPanel" style="display:none;">
                <span class="form-label">Remarks</span>
                <asp:TextBox ID="txtWheelGuardRemarks" runat="server" Width="200px" /><br />
                <span class="form-label">Upload Photo</span>
                <asp:FileUpload ID="fuWheelGuard" runat="server" /><br />
                <asp:CheckBox ID="chkWheelGuardCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 3. Grinding wheel -->
<tr>
    <td>3. Grinding wheel without any crack and with valid expiry date</td>
    <td>
        <asp:RadioButton ID="RbGrindWheelYes" GroupName="GrindWheel" runat="server" AutoPostBack="false" onclick="toggleGrindWheelPanel()" />
        <span class="form-label d-inline">Yes</span>
        <asp:RadioButton ID="RbGrindWheelNo" GroupName="GrindWheel" runat="server" AutoPostBack="false" onclick="toggleGrindWheelPanel()" />
        <span class="form-label d-inline">No</span>
    </td>
    <td>
        <asp:Panel ID="pnlGrindWheel" runat="server">
            <div id="divGrindWheelPanel" style="display:none;">
                <span class="form-label">Remarks</span>
                <asp:TextBox ID="txtGrindWheelRemarks" runat="server" Width="200px" /><br />
                <span class="form-label">Upload Photo</span>
                <asp:FileUpload ID="fuGrindWheel" runat="server" /><br />
                <asp:CheckBox ID="chkGrindWheelCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 4. Rear handles -->
<tr>
    <td>4. Rear handles without damage</td>
    <td>
        <asp:RadioButton ID="RbRearHandleYes" GroupName="RearHandle" runat="server" AutoPostBack="false" onclick="toggleRearHandlePanel()" />
        <span class="form-label d-inline">Yes</span>
        <asp:RadioButton ID="RbRearHandleNo" GroupName="RearHandle" runat="server" AutoPostBack="false" onclick="toggleRearHandlePanel()" />
        <span class="form-label d-inline">No</span>
    </td>
    <td>
        <asp:Panel ID="pnlRearHandle" runat="server">
            <div id="divRearHandlePanel" style="display:none;">
                <span class="form-label">Remarks</span>
                <asp:TextBox ID="txtRearHandleRemarks" runat="server" Width="200px" /><br />
                <span class="form-label">Upload Photo</span>
                <asp:FileUpload ID="fuRearHandle" runat="server" /><br />
                <asp:CheckBox ID="chkRearHandleCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 5. Cord strain reliever -->
<tr>
    <td>5. Presence of cord strain reliever (glands)</td>
    <td>
        <asp:RadioButton ID="RbCordYes" GroupName="Cord" runat="server" AutoPostBack="false" onclick="toggleCordPanel()" />
        <span class="form-label d-inline">Yes</span>
        <asp:RadioButton ID="RbCordNo" GroupName="Cord" runat="server" AutoPostBack="false" onclick="toggleCordPanel()" />
        <span class="form-label d-inline">No</span>
    </td>
    <td>
        <asp:Panel ID="pnlCord" runat="server">
            <div id="divCordPanel" style="display:none;">
                <span class="form-label">Remarks</span>
                <asp:TextBox ID="txtCordRemarks" runat="server" Width="200px" /><br />
                <span class="form-label">Upload Photo</span>
                <asp:FileUpload ID="fuCord" runat="server" /><br />
                <asp:CheckBox ID="chkCordCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 6. Trigger switch -->
<tr>
    <td>6. Trigger switch without damage & working condition</td>
    <td>
        <asp:RadioButton ID="RbTriggerYes" GroupName="Trigger" runat="server" AutoPostBack="false" onclick="toggleTriggerPanel()" />
        <span class="form-label d-inline">Yes</span>
        <asp:RadioButton ID="RbTriggerNo" GroupName="Trigger" runat="server" AutoPostBack="false" onclick="toggleTriggerPanel()" />
        <span class="form-label d-inline">No</span>
    </td>
    <td>
        <asp:Panel ID="pnlTrigger" runat="server">
            <div id="divTriggerPanel" style="display:none;">
                <span class="form-label">Remarks</span>
                <asp:TextBox ID="txtTriggerRemarks" runat="server" Width="200px" /><br />
                <span class="form-label">Upload Photo</span>
                <asp:FileUpload ID="fuTrigger" runat="server" /><br />
                <asp:CheckBox ID="chkTriggerCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 7. Switch lock -->
<tr>
    <td>7. Presence of switch lock</td>
    <td>
        <asp:RadioButton ID="RbSwitchLockYes" GroupName="SwitchLock" runat="server" AutoPostBack="false" onclick="toggleSwitchLockPanel()" />
        <span class="form-label d-inline">Yes</span>
        <asp:RadioButton ID="RbSwitchLockNo" GroupName="SwitchLock" runat="server" AutoPostBack="false" onclick="toggleSwitchLockPanel()" />
        <span class="form-label d-inline">No</span>
    </td>
    <td>
        <asp:Panel ID="pnlSwitchLock" runat="server">
            <div id="divSwitchLockPanel" style="display:none;">
                <span class="form-label">Remarks</span>
                <asp:TextBox ID="txtSwitchLockRemarks" runat="server" Width="200px" /><br />
                <span class="form-label">Upload Photo</span>
                <asp:FileUpload ID="fuSwitchLock" runat="server" /><br />
                <asp:CheckBox ID="chkSwitchLockCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 8. Power cable -->
<tr>
    <td>8. Power cable without cut & joined</td>
    <td>
        <asp:RadioButton ID="RbPowerCableYes" GroupName="PowerCable" runat="server" AutoPostBack="false" onclick="togglePowerCablePanel()" />
        <span class="form-label d-inline">Yes</span>
        <asp:RadioButton ID="RbPowerCableNo" GroupName="PowerCable" runat="server" AutoPostBack="false" onclick="togglePowerCablePanel()" />
        <span class="form-label d-inline">No</span>
    </td>
    <td>
        <asp:Panel ID="pnlPowerCable" runat="server">
            <div id="divPowerCablePanel" style="display:none;">
                <span class="form-label">Remarks</span>
                <asp:TextBox ID="txtPowerCableRemarks" runat="server" Width="200px" /><br />
                <span class="form-label">Upload Photo</span>
                <asp:FileUpload ID="fuPowerCable" runat="server" /><br />
                <asp:CheckBox ID="chkPowerCableCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
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
                                if (yes && no && panelDiv) {
                                    panelDiv.style.display = (no.checked) ? 'block' : 'none';
                                }
                            }

                            function toggleForeHandlePanel() { togglePanel('<%= RbForeHandleYes.ClientID %>', '<%= RbForeHandleNo.ClientID %>', 'divForeHandlePanel'); }
                            function toggleWheelGuardPanel() { togglePanel('<%= RbWheelGuardYes.ClientID %>', '<%= RbWheelGuardNo.ClientID %>', 'divWheelGuardPanel'); }
                            function toggleGrindWheelPanel() { togglePanel('<%= RbGrindWheelYes.ClientID %>', '<%= RbGrindWheelNo.ClientID %>', 'divGrindWheelPanel'); }
                            function toggleRearHandlePanel() { togglePanel('<%= RbRearHandleYes.ClientID %>', '<%= RbRearHandleNo.ClientID %>', 'divRearHandlePanel'); }
    function toggleCordPanel() { togglePanel('<%= RbCordYes.ClientID %>', '<%= RbCordNo.ClientID %>', 'divCordPanel'); }
    function toggleTriggerPanel() { togglePanel('<%= RbTriggerYes.ClientID %>', '<%= RbTriggerNo.ClientID %>', 'divTriggerPanel'); }
    function toggleSwitchLockPanel() { togglePanel('<%= RbSwitchLockYes.ClientID %>', '<%= RbSwitchLockNo.ClientID %>', 'divSwitchLockPanel'); }
    function togglePowerCablePanel() { togglePanel('<%= RbPowerCableYes.ClientID %>', '<%= RbPowerCableNo.ClientID %>', 'divPowerCablePanel'); }

                            function confirmCAPA(checkbox) {
                                if (!checkbox.checked) {
                                    alert("CAPA is required. Proceeding without it is at your own risk.");
                                }
                            }
                        </script>



                               


                                <!-- Final Remarks -->
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <asp:Label ID="lblFinalRemarks" runat="server" Text="Final Remarks:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtFinalRemarks" runat="server"
                                                CssClass="form-control form-control-sm rounded"
                                                TextMode="MultiLine"
                                                Rows="3"
                                                Placeholder="Enter any final remarks">
                                            </asp:TextBox>
                                        </div>
                                    </div>
                                </div>

<script type="text/javascript">
    function validateGrindingChecklist() {
        var isValid = true;
        var errorMessage = "";

        var fieldsToCheck = [
            { id: '<%= txtSite.ClientID %>', type: 'textbox', name: 'Site' },
            { id: '<%= txtDateOfInspection.ClientID %>', type: 'textbox', name: 'Date of Inspection' },
            { id: '<%= txtInspectedBy.ClientID %>', type: 'textbox', name: 'Inspected By' },
            { id: '<%= txtSerialNo.ClientID %>', type: 'textbox', name: 'SI No' },
            { id: '<%= txtIdentificationNumber.ClientID %>', type: 'textbox', name: 'Identification Number' },
            { id: '<%= txtLocation.ClientID %>', type: 'textbox', name: 'Location' },
            { id: '<%= txtJobID.ClientID %>', type: 'textbox', name: 'Job ID' },
            { id: '<%= txtJobName.ClientID %>', type: 'textbox', name: 'Job Name' }
        ];

        // Check TextBoxes
        for (var i = 0; i < fieldsToCheck.length; i++) {
            var fieldInfo = fieldsToCheck[i];
            var field = document.getElementById(fieldInfo.id);
            if (field) {
                if (field.value.trim() === "") {
                    isValid = false;
                    errorMessage += "- Please fill " + fieldInfo.name + "\n";
                }
            }
        }

        // Check RadioButton groups
        var radioGroups = [
            { yesId: '<%= RbForeHandleYes.ClientID %>', noId: '<%= RbForeHandleNo.ClientID %>', name: 'Fore Handle' },
            { yesId: '<%= RbWheelGuardYes.ClientID %>', noId: '<%= RbWheelGuardNo.ClientID %>', name: 'Wheel Guard' },
            { yesId: '<%= RbGrindWheelYes.ClientID %>', noId: '<%= RbGrindWheelNo.ClientID %>', name: 'Grinding Wheel' },
            { yesId: '<%= RbRearHandleYes.ClientID %>', noId: '<%= RbRearHandleNo.ClientID %>', name: 'Rear Handle' },
            { yesId: '<%= RbCordYes.ClientID %>', noId: '<%= RbCordNo.ClientID %>', name: 'Cord Strain Reliever' },
            { yesId: '<%= RbTriggerYes.ClientID %>', noId: '<%= RbTriggerNo.ClientID %>', name: 'Trigger Switch' },
            { yesId: '<%= RbSwitchLockYes.ClientID %>', noId: '<%= RbSwitchLockNo.ClientID %>', name: 'Switch Lock' },
            { yesId: '<%= RbPowerCableYes.ClientID %>', noId: '<%= RbPowerCableNo.ClientID %>', name: 'Power Cable' }
        ];

        for (var i = 0; i < radioGroups.length; i++) {
            var group = radioGroups[i];
            var yesOption = document.getElementById(group.yesId);
            var noOption = document.getElementById(group.noId);

            if (yesOption && noOption) {
                if (!yesOption.checked && !noOption.checked) {
                    isValid = false;
                    errorMessage += "- Please select Yes/No for " + group.name + "\n";
                }
            }
        }

        if (!isValid) {
            alert(errorMessage);
        }

        return isValid;
    }
</script>




                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group input-group-sm">
                                            <%--                                            <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />--%>

                                            <asp:Button ID="BtnSubmit" runat="server" Text="Save"
                                                CssClass="btn btn-primary btn-sm"
                                                ValidationGroup="Submit" CausesValidation="true"
                                                OnClientClick="return validateGrindingChecklist();"
                                                OnClick="BtnSubmit_Click" />

                                            <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                                            <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                        </div>
                                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true" />
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>

