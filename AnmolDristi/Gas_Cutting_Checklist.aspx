<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Gas_Cutting_Checklist.aspx.cs" Inherits="AnmolDristi.Gas_Cutting_Checklist" %>
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
                    <h3>GAS CUTTING CHECKLIST</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                               <h2>Document No: DOC/ATS/TSK/QMC/GC/013 | Effective Date: 01.02.2024 | Revision No: REV:00</h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <h3 style="color: teal; font-weight: bold; margin-top: 20px;">Step 1: Basic Details</h3>
                            <hr style="border: 0; border-top: 2px solid #c2c2c2; margin: 10px 0 20px 0;" />
                            <div class="row">
                                 <!-- Name of Site -->
    <div class="col-md-3">
        <div class="mb-3">
            <asp:Label ID="lblNameOfSite" runat="server" Text="Name of Site:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
            <div class="input-group-sm">
                <asp:TextBox ID="txtNameOfSite" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Site Name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNameOfSite" runat="server"
                    ControlToValidate="txtNameOfSite"
                    ErrorMessage="Please enter the site name."
                    ForeColor="Red" Display="Dynamic" />
            </div>
        </div>
    </div>

    <!-- Date -->
    <div class="col-md-3">
        <div class="mb-3">
            <asp:Label ID="lblDate" runat="server" Text="Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
            <div class="input-group-sm">
                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" Placeholder="Select Date"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDate" runat="server"
                    ControlToValidate="txtDate"
                    ErrorMessage="Please select a date."
                    ForeColor="Red" Display="Dynamic" />
                <asp:CustomValidator ID="cvDate" runat="server"
                    ControlToValidate="txtDate"
                    OnServerValidate="ValidateDate"
                    ErrorMessage="Date cannot be in the future."
                    ForeColor="Red" Display="Dynamic" />
            </div>
        </div>
    </div>

    <!-- Tag No -->
    <div class="col-md-3">
        <div class="mb-3">
            <asp:Label ID="lblTagNo" runat="server" Text="Tag No:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
            <div class="input-group-sm">
                <asp:TextBox ID="txtTagNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Tag Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTagNo" runat="server"
                    ControlToValidate="txtTagNo"
                    ErrorMessage="Please enter tag number."
                    ForeColor="Red" Display="Dynamic" />
            </div>
        </div>
    </div>
<!-- Gas Cutter Name -->
<div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lblGasCutterName" runat="server" Text="Gas Cutter Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <div class="input-group-sm">
            <asp:TextBox ID="txtGasCutterName" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Gas Cutter Name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvGasCutterName" runat="server"
                ControlToValidate="txtGasCutterName"
                ErrorMessage="Please enter gas cutter name."
                ForeColor="Red" Display="Dynamic" />
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
                ErrorMessage="Please enter job ID."
                ForeColor="Red" Display="Dynamic" />
        </div>
    </div>
</div>




    <!-- Row for Step 2 heading -->
  <div class="row">
      <div class="col-md-12">
          <h3 style="color: teal; font-weight: bold; margin-top: 20px;">Step 3: Gas Cylinder Checklist</h3>
          <hr style="border: 0; border-top: 2px solid #c2c2c2; margin: 10px 0 20px 0;" />
      </div>
  </div>

  <table class="table table-bordered">

      <!-- 1. Gas Cylinders colour -->
      <tr>
          <td>1. Gas Cylinders colour as per Colour Code</td>
          <td>
              <asp:RadioButton ID="RbGasColorYes" GroupName="GasColor" runat="server" AutoPostBack="true" OnCheckedChanged="RbGasColor_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbGasColorNo" GroupName="GasColor" runat="server" AutoPostBack="true" OnCheckedChanged="RbGasColor_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlGasColor" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtGasColorRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuGasColor" runat="server" />
              </asp:Panel>
          </td>
      </tr>

      <!-- 2. NRV/Flash back arrestor -->
      <tr>
          <td>2. NRV/Flash back arrestor provided at regulator and torch side</td>
          <td>
              <asp:RadioButton ID="RbNRVYes" GroupName="NRV" runat="server" AutoPostBack="true" OnCheckedChanged="RbNRV_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbNRVNo" GroupName="NRV" runat="server" AutoPostBack="true" OnCheckedChanged="RbNRV_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlNRV" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtNRVRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuNRV" runat="server" />
              </asp:Panel>
          </td>
      </tr>

      <!-- 3. ISI marked Cylinder -->
      <tr>
          <td>3. ISI marked Cylinder, Valves & Expired value of Cylinder</td>
          <td>
              <asp:RadioButton ID="RbISICylinderYes" GroupName="ISICylinder" runat="server" AutoPostBack="true" OnCheckedChanged="RbISICylinder_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbISICylinderNo" GroupName="ISICylinder" runat="server" AutoPostBack="true" OnCheckedChanged="RbISICylinder_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlISICylinder" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtISICylinderRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuISICylinder" runat="server" />
              </asp:Panel>
          </td>
      </tr>
            <!-- 4. Cylinder stored upright -->
      <tr>
          <td>4. Cylinder stored upright with cap</td>
          <td>
              <asp:RadioButton ID="RbUprightYes" GroupName="Upright" runat="server" AutoPostBack="true" OnCheckedChanged="RbUpright_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbUprightNo" GroupName="Upright" runat="server" AutoPostBack="true" OnCheckedChanged="RbUpright_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlUpright" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtUprightRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuUpright" runat="server" />
              </asp:Panel>
          </td>
      </tr>

      <!-- 5. Cylinder and Torch free from damage -->
      <tr>
          <td>5. Cylinder and Torch free from damage</td>
          <td>
              <asp:RadioButton ID="RbTorchDamageYes" GroupName="TorchDamage" runat="server" AutoPostBack="true" OnCheckedChanged="RbTorchDamage_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbTorchDamageNo" GroupName="TorchDamage" runat="server" AutoPostBack="true" OnCheckedChanged="RbTorchDamage_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlTorchDamage" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtTorchDamageRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuTorchDamage" runat="server" />
              </asp:Panel>
          </td>
      </tr>

      <!-- 6. Flashback arrester checked -->
      <tr>
          <td>6. Flashback arrester checked and within validity</td>
          <td>
              <asp:RadioButton ID="RbFlashbackYes" GroupName="Flashback" runat="server" AutoPostBack="true" OnCheckedChanged="RbFlashback_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbFlashbackNo" GroupName="Flashback" runat="server" AutoPostBack="true" OnCheckedChanged="RbFlashback_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlFlashback" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtFlashbackRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuFlashback" runat="server" />
              </asp:Panel>
          </td>
      </tr>

      <!-- 7. No Gas leak from hose -->
      <tr>
          <td>7. No Gas leak from hose, connection or torch</td>
          <td>
              <asp:RadioButton ID="RbLeakYes" GroupName="Leak" runat="server" AutoPostBack="true" OnCheckedChanged="RbLeak_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbLeakNo" GroupName="Leak" runat="server" AutoPostBack="true" OnCheckedChanged="RbLeak_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlLeak" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtLeakRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuLeak" runat="server" />
              </asp:Panel>
          </td>
      </tr>

      <!-- 8. Proper segregation of filled and empty cylinders -->
      <tr>
          <td>8. Proper segregation of filled and empty cylinders</td>
          <td>
              <asp:RadioButton ID="RbSegregationYes" GroupName="Segregation" runat="server" AutoPostBack="true" OnCheckedChanged="RbSegregation_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbSegregationNo" GroupName="Segregation" runat="server" AutoPostBack="true" OnCheckedChanged="RbSegregation_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlSegregation" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtSegregationRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuSegregation" runat="server" />
              </asp:Panel>
          </td>
      </tr>

      <!-- 9. Welding area barricaded -->
      <tr>
          <td>9. Welding area barricaded with fire resistant curtain</td>
          <td>
              <asp:RadioButton ID="RbBarricadeYes" GroupName="Barricade" runat="server" AutoPostBack="true" OnCheckedChanged="RbBarricade_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbBarricadeNo" GroupName="Barricade" runat="server" AutoPostBack="true" OnCheckedChanged="RbBarricade_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlBarricade" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtBarricadeRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuBarricade" runat="server" />
              </asp:Panel>
          </td>
      </tr>

      <!-- 10. Gas cutting cylinder moved after closing valve -->
      <tr>
          <td>10. Gas cutting cylinder moved only after closing valve and fixing valve cap</td>
          <td>
              <asp:RadioButton ID="RbMovedYes" GroupName="Moved" runat="server" AutoPostBack="true" OnCheckedChanged="RbMoved_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbMovedNo" GroupName="Moved" runat="server" AutoPostBack="true" OnCheckedChanged="RbMoved_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlMoved" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtMovedRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuMoved" runat="server" />
              </asp:Panel>
          </td>
      </tr>

      <!-- 11. Fire extinguisher and sand bucket -->
      <tr>
          <td>11. Fire extinguisher and sand bucket provided at site</td>
          <td>
              <asp:RadioButton ID="RbFireExtYes" GroupName="FireExt" runat="server" AutoPostBack="true" OnCheckedChanged="RbFireExt_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbFireExtNo" GroupName="FireExt" runat="server" AutoPostBack="true" OnCheckedChanged="RbFireExt_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlFireExt" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtFireExtRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuFireExt" runat="server" />
              </asp:Panel>
          </td>
      </tr>

      <!-- 12. Cylinder kept away from heat/sparks -->
      <tr>
          <td>12. Cylinder kept away from heat, fire or electrical spark</td>
          <td>
              <asp:RadioButton ID="RbSparkYes" GroupName="Spark" runat="server" AutoPostBack="true" OnCheckedChanged="RbSpark_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbSparkNo" GroupName="Spark" runat="server" AutoPostBack="true" OnCheckedChanged="RbSpark_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlSpark" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtSparkRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuSpark" runat="server" />
              </asp:Panel>
          </td>
      </tr>

      <!-- 13. Hoses in good condition -->
      <tr>
          <td>13. Hoses are in good condition without cracks or damage</td>
          <td>
              <asp:RadioButton ID="RbHoseYes" GroupName="Hose" runat="server" AutoPostBack="true" OnCheckedChanged="RbHose_CheckedChanged" />
              <span class="form-label d-inline">Yes</span>
              <asp:RadioButton ID="RbHoseNo" GroupName="Hose" runat="server" AutoPostBack="true" OnCheckedChanged="RbHose_CheckedChanged" />
              <span class="form-label d-inline">No</span>
          </td>
          <td>
              <asp:Panel ID="pnlHose" runat="server" Visible="false">
                  <span class="form-label">Remarks</span>
                  <asp:TextBox ID="txtHoseRemarks" runat="server" Width="200px" />
                  <br />
                  <span class="form-label">Upload Photo</span>
                  <asp:FileUpload ID="fuHose" runat="server" />
              </asp:Panel>
          </td>
      </tr>
  </table>

                                <!-- Final Remarks -->
<div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lblFinalRemarks" runat="server" Text="Final Remarks:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <div class="input-group-sm">
            <asp:TextBox ID="txtFinalRemarks" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control form-control-sm rounded" Placeholder="Enter final remarks..."></asp:TextBox>
        </div>
    </div>
</div>

      <script type="text/javascript">
    function validateGasCuttingChecklist() {
        var isValid = true;
        var errorMessage = "";

        var fieldsToCheck = [
            { id: '<%= txtNameOfSite.ClientID %>', type: 'textbox', name: 'Name of Site' },
            { id: '<%= txtDate.ClientID %>', type: 'textbox', name: 'Date' },
            { id: '<%= txtTagNo.ClientID %>', type: 'textbox', name: 'Tag No' },
            { id: '<%= txtGasCutterName.ClientID %>', type: 'textbox', name: 'Gas Cutter Name' },
            { id: '<%= txtJobID.ClientID %>', type: 'textbox', name: 'Job ID' },
            { id: '<%= txtFinalRemarks.ClientID %>', type: 'textbox', name: 'Final Remarks' }
          
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

        // Check RadioButton groups for Gas Cutting specific items
        var radioGroups = [
            { yesId: '<%= RbGasColorYes.ClientID %>', noId: '<%= RbGasColorNo.ClientID %>', name: 'GasColor' },
           { yesId: '<%= RbNRVYes.ClientID %>', noId: '<%= RbNRVNo.ClientID %>', name: 'NRV' },
            { yesId: '<%= RbISICylinderYes.ClientID %>', noId: '<%= RbISICylinderNo.ClientID %>', name: 'ISICylinder' },
            { yesId: '<%= RbUprightYes.ClientID %>', noId: '<%= RbUprightNo.ClientID %>', name: 'Upright' },
            { yesId: '<%= RbTorchDamageYes.ClientID %>', noId: '<%= RbTorchDamageNo.ClientID %>', name: 'TorchDamage' },
            { yesId: '<%= RbFlashbackYes.ClientID %>', noId: '<%= RbFlashbackNo.ClientID %>', name: 'Flashback' },
            { yesId: '<%= RbLeakYes.ClientID %>', noId: '<%= RbLeakNo.ClientID %>', name: 'Leak' },
            { yesId: '<%= RbSegregationYes.ClientID %>', noId: '<%= RbSegregationNo.ClientID %>', name: 'Segregation' },
            { yesId: '<%= RbBarricadeYes.ClientID %>', noId: '<%= RbBarricadeNo.ClientID %>', name: 'Barricade' },
            { yesId: '<%= RbMovedYes.ClientID %>', noId: '<%= RbMovedNo.ClientID %>', name: 'Moved' },
            { yesId: '<%= RbFireExtYes.ClientID %>', noId: '<%= RbFireExtNo.ClientID %>', name: 'FireExt' },
            { yesId: '<%= RbSparkYes.ClientID %>', noId: '<%= RbSparkNo.ClientID %>', name: 'Spark' },
            { yesId: '<%= RbHoseYes.ClientID %>', noId: '<%= RbHoseNo.ClientID %>', name: 'Hose' },

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

                                            <asp:Button ID="BtnSubmit" runat="server" Text="Save" 
    CssClass="btn btn-primary btn-sm"
    ValidationGroup="Submit" CausesValidation="true"
    OnClientClick="return validateGasCuttingChecklist();"
    OnClick="SubmitGasCuttingIncidentData_Click" />

                                           <%-- <asp:Button ID="BtnSubmit" runat="server" Text="Save" 
    CssClass="btn btn-primary btn-sm"
    ValidationGroup="Submit" CausesValidation="true"
    OnClientClick="return validateGasCuttingChecklist() ;"
    OnClick="BtnSubmit_Click" />--%>

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


