<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Job_site_Checklist.aspx.cs" Inherits="AnmolDristi.Job_site_Checklist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .form-label {
            font-weight: bold;
            color: blue;
        }

        .table-bordered td, .table-bordered th {
            vertical-align: middle;
            border: 1px solid #dee2e6;
        }

        .form-control {
            margin-top: 5px;
        }

        .section-title {
            color: teal;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Job Site - Hazard Checklist</h3>
                </div>
            </div>
            <div class="x_panel">
                <div class="x_title">
                    <h2>Document No: DOC/ATS/TSK/QMS/GC/014 | Effective Date: 27/12/2024 | Revision No: REV:00</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <h3 style="color: teal; font-weight: bold; margin-top: 20px;"class="section-title">Step 1: Basic Details</h3>
                    <hr />

                    <div class="row">
                        <!-- DATE -->
                        <div class="col-md-3">
                            <div class="mb-3">
                                <asp:Label ID="lblDate" runat="server" Text="Date:" CssClass="form-label" />
                                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" ValidationGroup="Submit" />
                                <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtDate" ErrorMessage="Date required." ForeColor="Red" Display="Dynamic" />
                            </div>
                        </div>

                        <!-- SECTION / AREA -->
                        <div class="col-md-3">
                            <div class="mb-3">
                                <asp:Label ID="lblArea" runat="server" Text="Section / Area:" CssClass="form-label" />
                                <asp:TextBox ID="txtArea" runat="server" CssClass="form-control" Placeholder="Enter area e.g., Mech/CP" ValidationGroup="Submit" />
                                <asp:RequiredFieldValidator ID="rfvArea" runat="server" ControlToValidate="txtArea" ErrorMessage="Area required." ForeColor="Red" Display="Dynamic" />
                            </div>
                        </div>
                    </div>

                   <div class="row">
    <div class="col-md-12">
        <h3 style="color: teal; font-weight: bold; margin-top: 20px;">Step 2: Job Site - Hazard Checklist</h3>
        <hr style="border: 0; border-top: 2px solid #c2c2c2; margin: 10px 0 20px 0;" />
    </div>
</div>
<table class="table table-bordered">
 <!-- Mechanical Hazards -->
    <tr><th colspan="3">MECHANICAL HAZARDS</th></tr>

<!-- 1. Adequate safeguards -->
<tr>
    <td>Are the adequate safeguards at the point of operation / Job Execution?</td>
    <td>
        <asp:RadioButton ID="rbMechGuardOk" GroupName="MechGuard" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleMechGuardPanel()" />
        <asp:RadioButton ID="rbMechGuardNotOk" GroupName="MechGuard" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleMechGuardPanel()" />
        <asp:RadioButton ID="rbMechGuardNA" GroupName="MechGuard" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlMechGuard" runat="server">
            <div id="divMechGuardPanel" style="display: none;">
                <asp:TextBox ID="txtMechGuardRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuMechGuard" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkMechGuardCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 2. Exposed parts -->
<tr>
    <td>Are there any exposed moving parts (Chain, belts, gears, flywheels, etc.)?</td>
    <td>
        <asp:RadioButton ID="rbExposedPartsOk" GroupName="ExposedParts" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleExposedPartsPanel()" />
        <asp:RadioButton ID="rbExposedPartsNotOk" GroupName="ExposedParts" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleExposedPartsPanel()" />
        <asp:RadioButton ID="rbExposedPartsNA" GroupName="ExposedParts" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlExposedParts" runat="server">
            <div id="divExposedPartsPanel" style="display: none;">
                <asp:TextBox ID="txtExposedPartsRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuExposedParts" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkExposedPartsCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 3. Sharp mechanical parts -->
<tr>
    <td>Are there any other exposed mechanical parts that might be sharp or otherwise hazardous (screws, bolts, edges, etc.)?</td>
    <td>
        <asp:RadioButton ID="rbSharpPartsOk" GroupName="SharpParts" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleSharpPartsPanel()" />
        <asp:RadioButton ID="rbSharpPartsNotOk" GroupName="SharpParts" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleSharpPartsPanel()" />
        <asp:RadioButton ID="rbSharpPartsNA" GroupName="SharpParts" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlSharpParts" runat="server">
            <div id="divSharpPartsPanel" style="display: none;">
                <asp:TextBox ID="txtSharpPartsRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuSharpParts" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkSharpPartsCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 4. Machine anchored -->
<tr>
    <td>Is the machine properly anchored/fixed to the base as needed?</td>
    <td>
        <asp:RadioButton ID="rbAnchoredOk" GroupName="Anchored" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleAnchoredPanel()" />
        <asp:RadioButton ID="rbAnchoredNotOk" GroupName="Anchored" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleAnchoredPanel()" />
        <asp:RadioButton ID="rbAnchoredNA" GroupName="Anchored" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlAnchored" runat="server">
            <div id="divAnchoredPanel" style="display: none;">
                <asp:TextBox ID="txtAnchoredRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuAnchored" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkAnchoredCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>



    <!-- Vibration Measurement Hazard -->
    <tr><th colspan="3">VIBRATION MEASUREMENT HAZARDS</th></tr>

<!-- 1. Marking Fix -->
<tr>
    <td>Is marking fix the prob on Machine/GB is available?</td>
    <td>
        <asp:RadioButton ID="rbMarkingFixOk" GroupName="MarkingFix" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleMarkingFixPanel()" />
        <asp:RadioButton ID="rbMarkingFixNotOk" GroupName="MarkingFix" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleMarkingFixPanel()" />
        <asp:RadioButton ID="rbMarkingFixNA" GroupName="MarkingFix" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlMarkingFix" runat="server">
            <div id="divMarkingFixPanel" style="display: none;">
                <asp:TextBox ID="txtMarkingFixRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuMarkingFix" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkMarkingFixCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 2. Marking Visibility -->
<tr>
    <td>Whether the marking visible to employees?</td>
    <td>
        <asp:RadioButton ID="rbMarkingVisibleOk" GroupName="MarkingVisible" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleMarkingVisiblePanel()" />
        <asp:RadioButton ID="rbMarkingVisibleNotOk" GroupName="MarkingVisible" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleMarkingVisiblePanel()" />
        <asp:RadioButton ID="rbMarkingVisibleNA" GroupName="MarkingVisible" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlMarkingVisible" runat="server">
            <div id="divMarkingVisiblePanel" style="display: none;">
                <asp:TextBox ID="txtMarkingVisibleRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuMarkingVisible" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkMarkingVisibleCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 3. Marking Safety -->
<tr>
    <td>Whether those markings safe to take test?</td>
    <td>
        <asp:RadioButton ID="rbMarkingSafeOk" GroupName="MarkingSafe" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleMarkingSafePanel()" />
        <asp:RadioButton ID="rbMarkingSafeNotOk" GroupName="MarkingSafe" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleMarkingSafePanel()" />
        <asp:RadioButton ID="rbMarkingSafeNA" GroupName="MarkingSafe" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlMarkingSafe" runat="server">
            <div id="divMarkingSafePanel" style="display: none;">
                <asp:TextBox ID="txtMarkingSafeRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuMarkingSafe" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkMarkingSafeCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 4. Guarding of rotating equipment -->
<tr>
    <td>Guarding of rotating equipment adequate & safe during taking probe?</td>
    <td>
        <asp:RadioButton ID="rbGuardingRotatingOk" GroupName="GuardingRotating" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleGuardingRotatingPanel()" />
        <asp:RadioButton ID="rbGuardingRotatingNotOk" GroupName="GuardingRotating" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleGuardingRotatingPanel()" />
        <asp:RadioButton ID="rbGuardingRotatingNA" GroupName="GuardingRotating" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlGuardingRotating" runat="server">
            <div id="divGuardingRotatingPanel" style="display: none;">
                <asp:TextBox ID="txtGuardingRotatingRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuGuardingRotating" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkGuardingRotatingCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 5. Workmen Position -->
<tr>
    <td>Position of workmen to take measurement is approachable & Safe?</td>
    <td>
        <asp:RadioButton ID="rbWorkmenPositionOk" GroupName="WorkmenPosition" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleWorkmenPositionPanel()" />
        <asp:RadioButton ID="rbWorkmenPositionNotOk" GroupName="WorkmenPosition" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleWorkmenPositionPanel()" />
        <asp:RadioButton ID="rbWorkmenPositionNA" GroupName="WorkmenPosition" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlWorkmenPosition" runat="server">
            <div id="divWorkmenPositionPanel" style="display: none;">
                <asp:TextBox ID="txtWorkmenPositionRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuWorkmenPosition" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkWorkmenPositionCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 6. Contractor/Employee Safety -->
<tr>
    <td>Is job executed by Contractor or TSK Employee safely?</td>
    <td>
        <asp:RadioButton ID="rbExecutorOk" GroupName="Executor" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleExecutorPanel()" />
        <asp:RadioButton ID="rbExecutorNotOk" GroupName="Executor" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleExecutorPanel()" />
        <asp:RadioButton ID="rbExecutorNA" GroupName="Executor" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlExecutor" runat="server">
            <div id="divExecutorPanel" style="display: none;">
                <asp:TextBox ID="txtExecutorRemarks" runat="server" CssClass="form-control" Placeholder="Remarks (Contractor/TSK, Comments)" />
                <asp:FileUpload ID="fuExecutor" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkExecutorCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 7. Other Hazards -->
<tr>
    <td>Are there other site hazards? (e.g. Hard to access, slippery surface)</td>
    <td>
        <asp:RadioButton ID="rbOtherPointsOk" GroupName="OtherPoints" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleOtherPointsPanel()" />
        <asp:RadioButton ID="rbOtherPointsNotOk" GroupName="OtherPoints" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleOtherPointsPanel()" />
        <asp:RadioButton ID="rbOtherPointsNA" GroupName="OtherPoints" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlOtherPoints" runat="server">
            <div id="divOtherPointsPanel" style="display: none;">
                <asp:TextBox ID="txtOtherPointsRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuOtherPoints" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkOtherPointsCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

  <!-- Electrical Hazards -->
    <tr><th colspan="3">ELECTRICAL HAZARDS</th></tr>

<!-- 1. Grounded -->
<tr>
    <td>Is the machine grounded properly?</td>
    <td>
        <asp:RadioButton ID="rbGroundedOk" GroupName="Grounded" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleGroundedPanel()" />
        <asp:RadioButton ID="rbGroundedNotOk" GroupName="Grounded" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleGroundedPanel()" />
        <asp:RadioButton ID="rbGroundedNA" GroupName="Grounded" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlGrounded" runat="server">
            <div id="divGroundedPanel" style="display: none;">
                <asp:TextBox ID="txtGroundedRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuGrounded" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkGroundedCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 2. Shock Hazards -->
<tr>
    <td>Are there any shock hazards from open connections?</td>
    <td>
        <asp:RadioButton ID="rbShockHazardOk" GroupName="ShockHazard" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleShockHazardPanel()" />
        <asp:RadioButton ID="rbShockHazardNotOk" GroupName="ShockHazard" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleShockHazardPanel()" />
        <asp:RadioButton ID="rbShockHazardNA" GroupName="ShockHazard" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlShockHazard" runat="server">
            <div id="divShockHazardPanel" style="display: none;">
                <asp:TextBox ID="txtShockHazardRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuShockHazard" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkShockHazardCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 3. Labeled Wires -->
<tr>
    <td>Are any hazardous wires or other electrical components suitably labeled/Marked?</td>
    <td>
        <asp:RadioButton ID="rbWiresLabeledOk" GroupName="WiresLabeled" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleWiresLabeledPanel()" />
        <asp:RadioButton ID="rbWiresLabeledNotOk" GroupName="WiresLabeled" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleWiresLabeledPanel()" />
        <asp:RadioButton ID="rbWiresLabeledNA" GroupName="WiresLabeled" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlWiresLabeled" runat="server">
            <div id="divWiresLabeledPanel" style="display: none;">
                <asp:TextBox ID="txtWiresLabeledRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuWiresLabeled" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkWiresLabeledCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 4. Floor Free of Cords -->
<tr>
    <td>Is the floor free of cords where workers need to move?</td>
    <td>
        <asp:RadioButton ID="rbFloorCordFreeOk" GroupName="FloorCordFree" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleFloorCordFreePanel()" />
        <asp:RadioButton ID="rbFloorCordFreeNotOk" GroupName="FloorCordFree" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleFloorCordFreePanel()" />
        <asp:RadioButton ID="rbFloorCordFreeNA" GroupName="FloorCordFree" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlFloorCordFree" runat="server">
            <div id="divFloorCordFreePanel" style="display: none;">
                <asp:TextBox ID="txtFloorCordFreeRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuFloorCordFree" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkFloorCordFreeCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>




    <tr><th colspan="3">OTHER HAZARDS</th></tr>

<!-- 1. Environment Safe -->
<tr>
    <td>Is environment conducive to safe worker (temperature, humidity, radiation etc.)?</td>
    <td>
        <asp:RadioButton ID="rbEnvSafeOk" GroupName="EnvSafe" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleEnvSafePanel()" />
        <asp:RadioButton ID="rbEnvSafeNotOk" GroupName="EnvSafe" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleEnvSafePanel()" />
        <asp:RadioButton ID="rbEnvSafeNA" GroupName="EnvSafe" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlEnvSafe" runat="server">
            <div id="divEnvSafePanel" style="display: none;">
                <asp:TextBox ID="txtEnvSafeRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuEnvSafe" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkEnvSafeCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>


<!-- 2. Lighting -->
<tr>
    <td>Is lighting enough to operate the machine safely?</td>
    <td>
        <asp:RadioButton ID="rbLightingOk" GroupName="Lighting" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleLightingPanel()" />
        <asp:RadioButton ID="rbLightingNotOk" GroupName="Lighting" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleLightingPanel()" />
        <asp:RadioButton ID="rbLightingNA" GroupName="Lighting" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlLighting" runat="server">
            <div id="divLightingPanel" style="display: none;">
                <asp:TextBox ID="txtLightingRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuLighting" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkLightingCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>



<!-- 3. Floor Safe -->
<tr>
    <td>Is the floor dry and safe for working?</td>
    <td>
        <asp:RadioButton ID="rbFloorSafeOk" GroupName="FloorSafe" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleFloorSafePanel()" />
        <asp:RadioButton ID="rbFloorSafeNotOk" GroupName="FloorSafe" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleFloorSafePanel()" />
        <asp:RadioButton ID="rbFloorSafeNA" GroupName="FloorSafe" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlFloorSafe" runat="server">
            <div id="divFloorSafePanel" style="display: none;">
                <asp:TextBox ID="txtFloorSafeRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuFloorSafe" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkFloorSafeCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>


    <!-- Safeguards -->
  <tr><th colspan="3">SAFEGUARDS</th></tr>

<!-- 1. Master Cutoff -->
<tr>
    <td>Is there master cut-offs which stop functioning of the machinery?</td>
    <td>
        <asp:RadioButton ID="rbMasterCutoffOk" GroupName="MasterCutoff" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleMasterCutoffPanel()" />
        <asp:RadioButton ID="rbMasterCutoffNotOk" GroupName="MasterCutoff" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleMasterCutoffPanel()" />
        <asp:RadioButton ID="rbMasterCutoffNA" GroupName="MasterCutoff" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlMasterCutoff" runat="server">
            <div id="divMasterCutoffPanel" style="display: none;">
                <asp:TextBox ID="txtMasterCutoffRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuMasterCutoff" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkMasterCutoffCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 2. Start/Stop Control -->
<tr>
    <td>Is starting and stopping control present and reachable?</td>
    <td>
        <asp:RadioButton ID="rbStartStopOk" GroupName="StartStop" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleStartStopPanel()" />
        <asp:RadioButton ID="rbStartStopNotOk" GroupName="StartStop" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleStartStopPanel()" />
        <asp:RadioButton ID="rbStartStopNA" GroupName="StartStop" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlStartStop" runat="server">
            <div id="divStartStopPanel" style="display: none;">
                <asp:TextBox ID="txtStartStopRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuStartStop" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkStartStopCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 3. Emergency Equipment -->
<tr>
    <td>Is emergency response equipment available? What additional equipment is needed?</td>
    <td>
        <asp:RadioButton ID="rbEmergencyEquipOk" GroupName="EmergencyEquip" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleEmergencyEquipPanel()" />
        <asp:RadioButton ID="rbEmergencyEquipNotOk" GroupName="EmergencyEquip" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleEmergencyEquipPanel()" />
        <asp:RadioButton ID="rbEmergencyEquipNA" GroupName="EmergencyEquip" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlEmergencyEquip" runat="server">
            <div id="divEmergencyEquipPanel" style="display: none;">
                <asp:TextBox ID="txtEmergencyEquipRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuEmergencyEquip" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkEmergencyEquipCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>


    <!-- Training -->
   <tr><th colspan="3">TRAINING</th></tr>

<!-- 1. Training for the job -->
<tr>
    <td>Have all workers been trained for the job?</td>
    <td>
        <asp:RadioButton ID="rbTrainingJobOk" GroupName="TrainingJob" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleTrainingJobPanel()" />
        <asp:RadioButton ID="rbTrainingJobNotOk" GroupName="TrainingJob" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleTrainingJobPanel()" />
        <asp:RadioButton ID="rbTrainingJobNA" GroupName="TrainingJob" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlTrainingJob" runat="server">
            <div id="divTrainingJobPanel" style="display: none;">
                <asp:TextBox ID="txtTrainingJobRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuTrainingJob" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkTrainingJobCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 2. Machine safety features -->
<tr>
    <td>Are workers trained on machine safety features?</td>
    <td>
        <asp:RadioButton ID="rbTrainingFeaturesOk" GroupName="TrainingFeatures" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleTrainingFeaturesPanel()" />
        <asp:RadioButton ID="rbTrainingFeaturesNotOk" GroupName="TrainingFeatures" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleTrainingFeaturesPanel()" />
        <asp:RadioButton ID="rbTrainingFeaturesNA" GroupName="TrainingFeatures" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlTrainingFeatures" runat="server">
            <div id="divTrainingFeaturesPanel" style="display: none;">
                <asp:TextBox ID="txtTrainingFeaturesRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuTrainingFeatures" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkTrainingFeaturesCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 3. Emergency response -->
<tr>
    <td>Are workers trained on emergency response?</td>
    <td>
        <asp:RadioButton ID="rbTrainingResponseOk" GroupName="TrainingResponse" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleTrainingResponsePanel()" />
        <asp:RadioButton ID="rbTrainingResponseNotOk" GroupName="TrainingResponse" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleTrainingResponsePanel()" />
        <asp:RadioButton ID="rbTrainingResponseNA" GroupName="TrainingResponse" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlTrainingResponse" runat="server">
            <div id="divTrainingResponsePanel" style="display: none;">
                <asp:TextBox ID="txtTrainingResponseRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuTrainingResponse" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkTrainingResponseCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

<!-- 4. Manuals in local language -->
<tr>
    <td>Are all operating manuals/documentation/SOP in languages understood by workers?</td>
    <td>
        <asp:RadioButton ID="rbTrainingManualsOk" GroupName="TrainingManuals" Text="Ok" runat="server" AutoPostBack="false" onclick="toggleTrainingManualsPanel()" />
        <asp:RadioButton ID="rbTrainingManualsNotOk" GroupName="TrainingManuals" Text="Not Ok" runat="server" AutoPostBack="false" onclick="toggleTrainingManualsPanel()" />
        <asp:RadioButton ID="rbTrainingManualsNA" GroupName="TrainingManuals" Text="NA" runat="server" Visible="false" />
    </td>
    <td>
        <asp:Panel ID="pnlTrainingManuals" runat="server">
            <div id="divTrainingManualsPanel" style="display: none;">
                <asp:TextBox ID="txtTrainingManualsRemarks" runat="server" CssClass="form-control" Placeholder="Remarks" />
                <asp:FileUpload ID="fuTrainingManuals" runat="server" CssClass="form-control" />
                <asp:CheckBox ID="chkTrainingManualsCAPA" runat="server" Checked="true" onclick="confirmCAPA(this)" />
                <span class="form-label">CAPA Required</span>
            </div>
        </asp:Panel>
    </td>
</tr>

</table>




                    <script type="text/javascript">
                        function validateDandBowChecklist() {
                            var dateBox = document.getElementById('<%= txtDate.ClientID %>');
        var areaBox = document.getElementById('<%= txtArea.ClientID %>');

                            var dateValue = dateBox.value.trim();
                            var areaValue = areaBox.value.trim();

                            // Clear any previous error borders
                            dateBox.style.borderColor = '';
                            areaBox.style.borderColor = '';

                            // === Validation Logic ===
                            if (dateValue === "") {
                                alert("Please select a Date.");
                                dateBox.style.borderColor = "red";
                                dateBox.focus();
                                return false;
                            }

                            if (areaValue === "") {
                                alert("Please enter Section / Area.");
                                areaBox.style.borderColor = "red";
                                areaBox.focus();
                                return false;
                            }

                            // ✅ If both fields are valid, allow postback
                            return true;
                        }
                    </script>






                    <script type="text/javascript">
    // Shared Toggle Logic
    //function togglePanel(yesId, noId, panelDivId) {
    //    var yes = document.getElementById(yesId);
    //    var no = document.getElementById(noId);
    //    var panelDiv = document.getElementById(panelDivId);
    //    if (yes && no && panelDiv) {
    //        panelDiv.style.display = (no.checked) ? 'block' : 'none';
    //    }
                        //}




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










    // Mechanical Hazard Panels
                        function toggleMechGuardPanel() {
                            togglePanel('<%= rbMechGuardOk.ClientID %>', '<%= rbMechGuardNotOk.ClientID %>', 'divMechGuardPanel');
                        }

                        function toggleExposedPartsPanel() {
                            togglePanel('<%= rbExposedPartsOk.ClientID %>', '<%= rbExposedPartsNotOk.ClientID %>', 'divExposedPartsPanel');
                        }

                        function toggleSharpPartsPanel() {
                            togglePanel('<%= rbSharpPartsOk.ClientID %>', '<%= rbSharpPartsNotOk.ClientID %>', 'divSharpPartsPanel');
                        }

                        function toggleAnchoredPanel() {
                            togglePanel('<%= rbAnchoredOk.ClientID %>', '<%= rbAnchoredNotOk.ClientID %>', 'divAnchoredPanel');
                        }
    
                            // Vibration Measurement Hazards
                            function toggleMarkingFixPanel() { togglePanel('<%= rbMarkingFixOk.ClientID %>', '<%= rbMarkingFixNotOk.ClientID %>', 'divMarkingFixPanel'); }
                            function toggleMarkingVisiblePanel() { togglePanel('<%= rbMarkingVisibleOk.ClientID %>', '<%= rbMarkingVisibleNotOk.ClientID %>', 'divMarkingVisiblePanel'); }
                            function toggleMarkingSafePanel() { togglePanel('<%= rbMarkingSafeOk.ClientID %>', '<%= rbMarkingSafeNotOk.ClientID %>', 'divMarkingSafePanel'); }
                            function toggleGuardingRotatingPanel() { togglePanel('<%= rbGuardingRotatingOk.ClientID %>', '<%= rbGuardingRotatingNotOk.ClientID %>', 'divGuardingRotatingPanel'); }
                            function toggleWorkmenPositionPanel() { togglePanel('<%= rbWorkmenPositionOk.ClientID %>', '<%= rbWorkmenPositionNotOk.ClientID %>', 'divWorkmenPositionPanel'); }
                            function toggleExecutorPanel() { togglePanel('<%= rbExecutorOk.ClientID %>', '<%= rbExecutorNotOk.ClientID %>', 'divExecutorPanel'); }
                            function toggleOtherPointsPanel() { togglePanel('<%= rbOtherPointsOk.ClientID %>', '<%= rbOtherPointsNotOk.ClientID %>', 'divOtherPointsPanel'); }

                            // Electrical Hazards
                            function toggleGroundedPanel() { togglePanel('<%= rbGroundedOk.ClientID %>', '<%= rbGroundedNotOk.ClientID %>', 'divGroundedPanel'); }
                            function toggleShockHazardPanel() { togglePanel('<%= rbShockHazardOk.ClientID %>', '<%= rbShockHazardNotOk.ClientID %>', 'divShockHazardPanel'); }
                            function toggleWiresLabeledPanel() { togglePanel('<%= rbWiresLabeledOk.ClientID %>', '<%= rbWiresLabeledNotOk.ClientID %>', 'divWiresLabeledPanel'); }
                            function toggleFloorCordFreePanel() { togglePanel('<%= rbFloorCordFreeOk.ClientID %>', '<%= rbFloorCordFreeNotOk.ClientID %>', 'divFloorCordFreePanel'); }

                            // Other Hazards
                            function toggleEnvSafePanel() { togglePanel('<%= rbEnvSafeOk.ClientID %>', '<%= rbEnvSafeNotOk.ClientID %>', 'divEnvSafePanel'); }
                                                function toggleLightingPanel() {
                                                    togglePanel('<%= rbLightingOk.ClientID %>', '<%= rbLightingNotOk.ClientID %>', 'divLightingPanel');}
                            function toggleFloorSafePanel() { togglePanel('<%= rbFloorSafeOk.ClientID %>', '<%= rbFloorSafeNotOk.ClientID %>', 'divFloorSafePanel'); }

                            // Safeguards
                            function toggleMasterCutoffPanel() { togglePanel('<%= rbMasterCutoffOk.ClientID %>', '<%= rbMasterCutoffNotOk.ClientID %>', 'divMasterCutoffPanel'); }
                            function toggleStartStopPanel() { togglePanel('<%= rbStartStopOk.ClientID %>', '<%= rbStartStopNotOk.ClientID %>', 'divStartStopPanel'); }
                            function toggleEmergencyEquipPanel() { togglePanel('<%= rbEmergencyEquipOk.ClientID %>', '<%= rbEmergencyEquipNotOk.ClientID %>', 'divEmergencyEquipPanel'); }

                            // Training
                            function toggleTrainingJobPanel() { togglePanel('<%= rbTrainingJobOk.ClientID %>', '<%= rbTrainingJobNotOk.ClientID %>', 'divTrainingJobPanel'); }
                            function toggleTrainingFeaturesPanel() { togglePanel('<%= rbTrainingFeaturesOk.ClientID %>', '<%= rbTrainingFeaturesNotOk.ClientID %>', 'divTrainingFeaturesPanel'); }
                            function toggleTrainingResponsePanel() { togglePanel('<%= rbTrainingResponseOk.ClientID %>', '<%= rbTrainingResponseNotOk.ClientID %>', 'divTrainingResponsePanel'); }
                            function toggleTrainingManualsPanel() { togglePanel('<%= rbTrainingManualsOk.ClientID %>', '<%= rbTrainingManualsNotOk.ClientID %>', 'divTrainingManualsPanel'); }

                            // CAPA checkbox confirmation
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


                            toggleMechGuardPanel();
                            toggleExposedPartsPanel();
                            toggleSharpPartsPanel();
                            toggleAnchoredPanel();
                            toggleMarkingFixPanel();
                            toggleMarkingVisiblePanel();
                            toggleMarkingSafePanel();
                            toggleGuardingRotatingPanel();
                            toggleWorkmenPositionPanel();
                            toggleExecutorPanel();
                            toggleOtherPointsPanel();
                            toggleGroundedPanel();
                            toggleShockHazardPanel();
                            toggleWiresLabeledPanel();
                            toggleFloorCordFreePanel();
                            toggleEnvSafePanel();
                            toggleFloorSafePanel();
                            toggleMasterCutoffPanel();
                            toggleStartStopPanel();
                            toggleEmergencyEquipPanel();
                            toggleTrainingJobPanel();
                            toggleTrainingFeaturesPanel();
                            toggleTrainingResponsePanel();
                            toggleTrainingManualsPanel();

                        };


























                    </script>


   
                        <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group input-group-sm">


                                          <asp:Button ID="BtnSubmit" runat="server" Text="Save" 
    CssClass="btn btn-primary btn-sm"
    ValidationGroup="Submit" CausesValidation="true"
    OnClientClick="return validateDandBowChecklist();"
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
    
</asp:Content>
