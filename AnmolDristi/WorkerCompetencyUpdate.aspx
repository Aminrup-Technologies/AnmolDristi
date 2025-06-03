<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="WorkerCompetencyUpdate.aspx.cs" Inherits="AnmolDristi.WorkerCompetencyUpdate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style type="text/css">
    .assessment-label {
        color: #004080;
        font-weight: 600;
        font-size: 0.9rem;
    }

    .form-control-sm {
        border-radius: 6px;
        font-size: 0.95rem;
    }

    .readonly-box {
        background-color: #f0f0f0;
        font-weight: bold;
    }

.eval-category {
        display: flex;
        justify-content: center;
        align-items: center;
        font-weight: 700;
        font-size: 1.1rem;
        padding: 14px 20px;
        text-align: center;
        border-radius: 10px;
        margin-top: 10px;
        box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        letter-spacing: 1px;
        text-transform: uppercase;
        min-height: 50px;
}
.Excellent {
        background-color: #28a745; 
        color: #ffffff;
}
    .Good {
        background-color: #007bff; 
        color: #ffffff;
    }
    .Average {
        background-color: #ffc107; 
        color: #ffffff;
    }
    .Poor {
        background-color: #dc3545; 
        color: #ffffff;

    }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="right_col" role="main">
     <div class="container">
         <div class="page-title">
             <div class="title_left">
                 <h3>Competency Assessment | ATS/OHS/CA-01/REV-00
                 </h3>
             </div>
         </div>

         <div class="row">
             <div class="col-md-12 col-sm-12 ">
                 <div class="x_panel">
                        <div class="x_title">
        <h2 class="text-primary h4">Basic Details
        </h2>
        <div class="clearfix"></div>
    </div>

                     <div class="x_content">
    <div class="col-md-4">
    <div class="mb-3">
    <asp:Label ID="lbl_Date" runat="server" AssociatedControlID="tb_Date" CssClass="assessment-label" Text="Date"></asp:Label>
     <asp:RequiredFieldValidator ID="RFV_tb_Date" runat="server" ErrorMessage="*" ControlToValidate="tb_Date" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
    <asp:TextBox ID="tb_Date" runat="server" CssClass="form-control form-control-sm" TextMode="Date" />
    </div>
    </div>
    <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_NameOfWorkman" runat="server" AssociatedControlID="tb_NameOfWorkman" CssClass="assessment-label" Text="Name of Workman"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_tb_NameOfWorkman" runat="server" ErrorMessage="*" ControlToValidate="tb_NameOfWorkman" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
    
        <asp:TextBox ID="tb_NameOfWorkman" runat="server" CssClass="form-control form-control-sm" />
    </div>
    </div>
     <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_Designation" runat="server" AssociatedControlID="tb_Designation" CssClass="assessment-label" Text="Designation"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_tb_Designation" runat="server" ErrorMessage="*" ControlToValidate="tb_Designation" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
    
        <asp:TextBox ID="tb_Designation" runat="server" CssClass="form-control form-control-sm" />
    </div>
    </div>

    <!-- Score Fields -->
   <div class="x_title">
     <h2 class="text-primary h4">Score Fields
     </h2>
     <div class="clearfix"></div>
 </div>
 <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_TechnicalKnowledge" runat="server" CssClass="assessment-label" Text="Technical Knowledge (0–5)"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_tb_TechnicalKnowledge" runat="server" ErrorMessage="*" ControlToValidate="tb_TechnicalKnowledge" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <asp:TextBox ID="tb_TechnicalKnowledge" runat="server" CssClass="form-control form-control-sm score-input" />
    </div>
</div>
 <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_TechnicalSkills" runat="server" CssClass="assessment-label" Text="Technical Skills (0–5)"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_tb_TechnicalSkills" runat="server" ErrorMessage="*" ControlToValidate="tb_TechnicalSkills" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <asp:TextBox ID="tb_TechnicalSkills" runat="server" CssClass="form-control form-control-sm score-input" />
    </div>
</div>
 <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_ConsistencyInJob" runat="server" CssClass="assessment-label" Text="Consistency in Job (0–5)"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_tb_ConsistencyInJob" runat="server" ErrorMessage="*" ControlToValidate="tb_ConsistencyInJob" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
       <asp:TextBox ID="tb_ConsistencyInJob" runat="server" CssClass="form-control form-control-sm score-input" />
    </div>
</div>
<div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_JobQuality" runat="server" CssClass="assessment-label" Text="Job Quality (0–5)"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_tb_JobQuality" runat="server" ErrorMessage="*" ControlToValidate="tb_JobQuality" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
           <asp:TextBox ID="tb_JobQuality" runat="server" CssClass="form-control form-control-sm score-input" />
    </div>
</div>
                         <div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_SafetyAwareness" runat="server" CssClass="assessment-label" Text="Safety Awareness (0–5)"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_tb_SafetyAwareness" runat="server" ErrorMessage="*" ControlToValidate="tb_SafetyAwareness" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <asp:TextBox ID="tb_SafetyAwareness" runat="server" CssClass="form-control form-control-sm score-input" />
    </div>
</div>
    
<div class="col-md-4">
    <div class="mb-3">
        <asp:Label ID="lbl_TotalMark" runat="server" CssClass="assessment-label" Text="Total Mark (Fixed: 25)"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_tb_TotalMark" runat="server" ErrorMessage="*" ControlToValidate="tb_TotalMark" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <asp:TextBox ID="tb_TotalMark" runat="server" CssClass="form-control form-control-sm readonly-box" ReadOnly="true" Text="25" />
    </div>
</div>
                         <!-- Result Fields -->
 <div class="x_title">
    <h2 class="text-primary h4">Result Field
   </h2>
    <div class="clearfix"></div>
</div>



 <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_Score" runat="server" CssClass="assessment-label" Text="Score"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_tb_Score" runat="server" ErrorMessage="*" ControlToValidate="tb_Score" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>       
        <asp:TextBox ID="tb_Score" runat="server" CssClass="form-control form-control-sm readonly-box" onkeydown="return false;"  />
            <asp:HiddenField ID="hf_Score" runat="server" />   
    </div>
</div>
                         
 <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_Percentage" runat="server" CssClass="assessment-label" Text="Percentage (%)"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_tb_Percentage" runat="server" ErrorMessage="*" ControlToValidate="tb_Percentage" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>      
        <asp:TextBox ID="tb_Percentage" runat="server" CssClass="form-control form-control-sm readonly-box" onkeydown="return false;"  />
            <asp:HiddenField ID="hf_Percentage" runat="server" />   
    </div>
     </div>
  <div class="col-md-12">
    <div class="mb-3">
        <asp:Label ID="lbl_EvaluationCategory" runat="server" CssClass="assessment-label" Text="Evaluation Category"></asp:Label>
       <%--  <asp:RequiredFieldValidator ID="RFV_tb_CategoryDisplay" runat="server" ErrorMessage="*" ControlToValidate="tb_CategoryDisplay" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator> 
       --%> <asp:Label ID="lbl_CategoryDisplay" runat="server" CssClass="form-control form-control-sm eval-category"  />
       <asp:HiddenField ID="hf_Category" runat="server" />
    </div>
  </div>
                     </div>
                 </div>
             </div>



             <%--Button--%>
             <div class="col-md-3">
                 <div class="mb-3">
                     <asp:Label ID="lbl_BtnUpdate" runat="server" AssociatedControlID="BtnUpdate" Text="CLICK TO Update" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                     <div class="input-group input-group-sm">
                         <asp:Button ID="BtnUpdate" runat="server" Text="Update" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true"  OnClick="BtnUpdate_Click" />
                         <asp:Button ID="BtnBack" runat="server" Text="Back" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnBack_Click" />
                         <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                     </div>
                 </div>
             </div>
     </div>
 </div>
</div>
   
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        const inputs = Array.from(document.querySelectorAll(".score-input"));
        const scoreBox = document.getElementById("<%= tb_Score.ClientID %>");
    const pctBox = document.getElementById("<%= tb_Percentage.ClientID %>");
    const catLabel = document.getElementById("<%= lbl_CategoryDisplay.ClientID %>");
    const hfScore    = document.getElementById("<%= hf_Score.ClientID %>");
    const hfPct      = document.getElementById("<%= hf_Percentage.ClientID %>");
    const hfCategory = document.getElementById("<%= hf_Category.ClientID %>");

    // 1) Hook your inputs to recalc on the fly
    inputs.forEach(i => {
        i.setAttribute("inputmode", "numeric");
        i.setAttribute("pattern", "[0-5]");
        i.addEventListener("input", calculateAndValidate);
    });

    // 2) Restore any existing values from hidden fields on load
    if (hfScore.value) {
        scoreBox.value = hfScore.value;
        pctBox.value = hfPct.value;
        catLabel.textContent = hfCategory.value;
        catLabel.className = "form-control form-control-sm eval-category " + hfCategory.value;
    }

    // 3) Expose calculateAndValidate globally so we can call it OnClientClick
    window.calculateAndValidate = calculateAndValidate;

    function calculateAndValidate() {
        let total = 0, allFilled = true, allValid = true;

        inputs.forEach(i => {
            const v = i.value.trim();
            i.classList.remove("is-invalid");
            if (!v) { allFilled = false; return; }
            const n = parseInt(v, 10);
            if (isNaN(n) || n < 0 || n > 5) {
                allValid = false;
                i.classList.add("is-invalid");
            } else {
                total += n;
            }
        });

        if (!allFilled || !allValid) {
            scoreBox.value = pctBox.value = "";
            catLabel.textContent = "";
            hfScore.value = hfPct.value = hfCategory.value = "";
            return;
        }

        const pct = ((total / 25) * 100).toFixed(2);
        let cat = "", css = "";
        if (pct >= 80) { cat = "Excellent"; css = "Excellent"; }
        else if (pct >= 60) { cat = "Good"; css = "Good"; }
        else if (pct >= 40) { cat = "Average"; css = "Average"; }
        else { cat = "Poor"; css = "Poor"; }

        // write back to UI
        scoreBox.value = total;
        pctBox.value = pct;
        catLabel.textContent = cat;
        catLabel.className = "form-control form-control-sm eval-category " + css;

        // keep your hidden fields in sync for postback
        hfScore.value = total;
        hfPct.value = pct;
        hfCategory.value = cat;
    }
});
</script>
</asp:Content>
