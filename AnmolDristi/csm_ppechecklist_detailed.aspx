<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="csm_ppechecklist_detailed.aspx.cs" Inherits="AnmolDristi.csm_ppechecklist_detailed" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .rmv_border .form-control {
            border: none !important;
        }

        .remarks_border .form-control {
            border: 1px solid #808080;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--js when not okay--%>
    <script type="text/javascript">

        function toggle_SafetyShoe(radioButtonList) {
            console.log("toggle_SafetyShoe function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("Display_SafetyShoe");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        };

        function toggle_SafetyHelmet(radioButtonList) {
            console.log("toggle_SafetyHelmet function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("Display_SafetyHelmet");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        };

        function toggle_SafetyGoggles(radioButtonList) {
            console.log("toggle_SafetyGoggles function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("Display_SafetyGoggles");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        };

        function toggle_SafetySpron(radioButtonList) {
            console.log("toggle_SafetySpron function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("Display_SafetySpron");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        };

        function toggle_HandGloves(radioButtonList) {
            console.log("toggle_HandGloves function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("Display_HandGloves");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        };

        function toggle_HandSleeves(radioButtonList) {
            console.log("toggle_HandSleeves function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("Display_HandSleeves");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        };

        function toggle_EarPlug(radioButtonList) {
            console.log("toggle_EarPlug function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("Display_EarPlug");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        };



        function toggle_NoseMask(radioButtonList) {
            console.log("toggle_NoseMask function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("Display_NoseMask");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        };



        function toggle_LegGuard(radioButtonList) {
            console.log("toggle_LegGuard function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("Display_LegGuard");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        };


        function toggle_HPJacket(radioButtonList) {
            console.log("toggle_HPJacket function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("Display_HPJacket");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        };



    </script>

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5>Workers PPE Checklist Report</h5>
                </div>
            </div>



            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">

                        <div class="x_content">

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_Inspection" runat="server" AssociatedControlID="TB_Inspection" Text="Inspection By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Inspection" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Inspection" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_Inspection" runat="server" ValidationGroup="Submit" ControlToValidate="TB_Inspection" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Inspection" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Name of Inspector"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_Date" runat="server" AssociatedControlID="TB_Date" Text="Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Date" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Date" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>


                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Date" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Date" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_WorkerName" runat="server" AssociatedControlID="TB_WorkerName" Text="Worker Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_WorkerName" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_WorkerName" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_WorkerName" runat="server" ValidationGroup="Submit" ControlToValidate="TB_WorkerName" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_WorkerName" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Name of worker"></asp:TextBox>

                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_WorkerID" runat="server" AssociatedControlID="TB_WorkerID" Text="Worker ID" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_WorkerID" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_WorkerID" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_WorkerID" runat="server" ValidationGroup="Submit" ControlToValidate="TB_WorkerID" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_WorkerID" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Worker ID"></asp:TextBox>

                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_Designation" runat="server" AssociatedControlID="TB_Designation" Text="Designation" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Designation" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Designation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_Designation" runat="server" ValidationGroup="Submit" ControlToValidate="TB_Designation" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Designation" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Designation of worker"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">

                                    <asp:Label ID="lbl_SafetyShoe" runat="server" AssociatedControlID="rbl_SafetyShoe" Text="Safety Shoe" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_rbl_SafetyShoe" runat="server" ErrorMessage="Select any option" ValidationGroup="Submit" ControlToValidate="rbl_SafetyShoe" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <div class="input-group-sm rmv_border">
                                        <asp:RadioButtonList ID="rbl_SafetyShoe" runat="server" ClientIDMode="Static" CssClass="form-control form-control-sm rounded" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggle_SafetyShoe(this);">
                                            <asp:ListItem Text="NEW" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="OK" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="NOT OKAY" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3" id="Display_SafetyShoe" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_NO_SafetyShoe" runat="server" AssociatedControlID="TB_NO_SafetyShoe" Text="Safety Shoe (Not Okay) Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_NO_SafetyShoe" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_NO_SafetyShoe" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_NO_SafetyShoe" runat="server" ControlToValidate="TB_NO_SafetyShoe" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_NO_SafetyShoe" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>




                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_SafetyHelmet" runat="server" AssociatedControlID="rbl_SafetyHelmet" Text="Safety Helmet" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_rbl_SafetyHelmet" runat="server" ErrorMessage="Select any option" ValidationGroup="Submit" ControlToValidate="rbl_SafetyHelmet" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <div class="input-group-sm rmv_border">
                                        <asp:RadioButtonList ID="rbl_SafetyHelmet" runat="server" CssClass="form-control form-control-sm rounded" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggle_SafetyHelmet(this);">
                                            <asp:ListItem Text="NEW" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="OK" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="NOT OKAY" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3" id="Display_SafetyHelmet" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_NO_SafetyHelmet" runat="server" AssociatedControlID="TB_NO_SafetyHelmet" Text="Safety Helmet (Not Okay) Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_NO_SafetyHelmet" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_NO_SafetyHelmet" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_NO_SafetyHelmet" runat="server" ControlToValidate="TB_NO_SafetyHelmet" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_NO_SafetyHelmet" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_SafetyGoggles" runat="server" AssociatedControlID="rbl_SafetyGoggles" Text="Safety Goggles" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_rbl_SafetyGoggles" runat="server" ErrorMessage="Select any option" ValidationGroup="Submit" ControlToValidate="rbl_SafetyGoggles" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <div class="input-group-sm rmv_border">
                                        <asp:RadioButtonList ID="rbl_SafetyGoggles" runat="server" CssClass="form-control form-control-sm rounded" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggle_SafetyGoggles(this);">
                                            <asp:ListItem Text="NEW" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="OK" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="NOT OKAY" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>

                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3" id="Display_SafetyGoggles" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_NO_SafetyGoggles" runat="server" AssociatedControlID="TB_NO_SafetyGoggles" Text="Safety Goggles (Not Okay) Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_NO_SafetyGoggles" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_NO_SafetyGoggles" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_NO_SafetyGoggles" runat="server" ControlToValidate="TB_NO_SafetyGoggles" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_NO_SafetyGoggles" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_SafetySpron" runat="server" AssociatedControlID="rbl_SafetySpron" Text="Safety Spron" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_rbl_SafetySpron" runat="server" ErrorMessage="Select any option" ValidationGroup="Submit" ControlToValidate="rbl_SafetySpron" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <div class="input-group-sm rmv_border">
                                        <asp:RadioButtonList ID="rbl_SafetySpron" runat="server" CssClass="form-control form-control-sm rounded" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggle_SafetySpron(this);">
                                            <asp:ListItem Text="NEW" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="OK" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="NOT OKAY" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>

                                    </div>

                                </div>
                            </div>

                            <div class="col-md-3" id="Display_SafetySpron" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_NO_SafetySpron" runat="server" AssociatedControlID="TB_NO_SafetySpron" Text="Safety Spron (Not Okay) Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_NO_SafetySpron" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_NO_SafetySpron" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_NO_SafetySpron" runat="server" ControlToValidate="TB_NO_SafetySpron" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_NO_SafetySpron" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_HandGloves" runat="server" AssociatedControlID="rbl_HandGloves" Text="Hand Gloves" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_rbl_HandGloves" runat="server" ErrorMessage="Select any option" ValidationGroup="Submit" ControlToValidate="rbl_HandGloves" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <div class="input-group-sm rmv_border">
                                        <asp:RadioButtonList ID="rbl_HandGloves" runat="server" CssClass="form-control form-control-sm rounded" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggle_HandGloves(this);">
                                            <asp:ListItem Text="NEW" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="OK" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="NOT OKAY" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="Display_HandGloves" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_NO_HandGloves" runat="server" AssociatedControlID="TB_NO_HandGloves" Text="Hand Gloves (Not Okay) Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_NO_HandGloves" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_NO_HandGloves" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_NO_HandGloves" runat="server" ControlToValidate="TB_NO_HandGloves" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_NO_HandGloves" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>




                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_HandSleeves" runat="server" AssociatedControlID="rbl_HandSleeves" Text="Hand Sleeves" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_rbl_HandSleeves" runat="server" ErrorMessage="Select any option" ValidationGroup="Submit" ControlToValidate="rbl_HandSleeves" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <div class="input-group-sm rmv_border">
                                        <asp:RadioButtonList ID="rbl_HandSleeves" runat="server" CssClass="form-control form-control-sm rounded" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggle_HandSleeves(this);">
                                            <asp:ListItem Text="NEW" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="OK" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="NOT OKAY" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>

                                    </div>

                                </div>
                            </div>
                            <div class="col-md-3" id="Display_HandSleeves" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_NO_HandSleeves" runat="server" AssociatedControlID="TB_NO_HandSleeves" Text="Hand Sleeves (Not Okay) Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_NO_HandSleeves" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_NO_HandSleeves" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_NO_HandSleeves" runat="server" ControlToValidate="TB_NO_HandSleeves" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_NO_HandSleeves" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_EarPlug" runat="server" AssociatedControlID="rbl_EarPlug" Text="Ear Plug" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_rbl_EarPlug" runat="server" ErrorMessage="Select any option" ValidationGroup="Submit" ControlToValidate="rbl_EarPlug" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <div class="input-group-sm rmv_border">
                                        <asp:RadioButtonList ID="rbl_EarPlug" runat="server" CssClass="form-control form-control-sm rounded" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggle_EarPlug(this);">
                                            <asp:ListItem Text="NEW" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="OK" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="NOT OKAY" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>

                                    </div>

                                </div>
                            </div>

                            <div class="col-md-3" id="Display_EarPlug" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_NO_EarPlug" runat="server" AssociatedControlID="TB_NO_EarPlug" Text="Ear Plug (Not Okay) Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_NO_EarPlug" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_NO_EarPlug" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_NO_EarPlug" runat="server" ControlToValidate="TB_NO_EarPlug" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_NO_EarPlug" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>



                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_NoseMask" runat="server" AssociatedControlID="rbl_NoseMask" Text="Nose Mask" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_rbl_NoseMask" runat="server" ErrorMessage="Select any option" ValidationGroup="Submit" ControlToValidate="rbl_NoseMask" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <div class="input-group-sm rmv_border">
                                        <asp:RadioButtonList ID="rbl_NoseMask" runat="server" CssClass="form-control form-control-sm rounded" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggle_NoseMask(this);">
                                            <asp:ListItem Text="NEW" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="OK" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="NOT OKAY" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>

                                    </div>

                                </div>
                            </div>
                            <div class="col-md-3" id="Display_NoseMask" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_NO_NoseMask" runat="server" AssociatedControlID="TB_NO_NoseMask" Text="Nose Mask (Not Okay) Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_NO_NoseMask" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_NO_NoseMask" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_NO_NoseMask" runat="server" ControlToValidate="TB_NO_NoseMask" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_NO_NoseMask" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>





                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_LegGuard" runat="server" AssociatedControlID="rbl_LegGuard" Text="Leg Guard" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_rbl_LegGuard" runat="server" ErrorMessage="Select any option" ValidationGroup="Submit" ControlToValidate="rbl_LegGuard" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <div class="input-group-sm rmv_border">
                                        <asp:RadioButtonList ID="rbl_LegGuard" runat="server" CssClass="form-control form-control-sm rounded" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggle_LegGuard(this);">
                                            <asp:ListItem Text="NEW" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="OK" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="NOT OKAY" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>

                                    </div>

                                </div>
                            </div>

                            <div class="col-md-3" id="Display_LegGuard" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_NO_LegGuard" runat="server" AssociatedControlID="TB_NO_LegGuard" Text="Leg Guard (Not Okay) Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_NO_LegGuard" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_NO_LegGuard" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_NO_LegGuard" runat="server" ControlToValidate="TB_NO_LegGuard" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_NO_LegGuard" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>



                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_HotProtectJacket" runat="server" AssociatedControlID="rbl_HotProtectJacket" Text="Hot Protect Jacket" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_rbl_HotProtectJacket" runat="server" ErrorMessage="Select any option" ValidationGroup="Submit" ControlToValidate="rbl_HotProtectJacket" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <div class="input-group-sm rmv_border">
                                        <asp:RadioButtonList ID="rbl_HotProtectJacket" runat="server" CssClass="form-control form-control-sm rounded" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggle_HPJacket(this);">
                                            <asp:ListItem Text="NEW" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="OK" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="NOT OKAY" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>

                                    </div>

                                </div>
                            </div>
                            <div class="col-md-3" id="Display_HPJacket" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_NO_HPJacket" runat="server" AssociatedControlID="TB_NO_HPJacket" Text="Hot Protect Jacket (Not Okay) Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_NO_HPJacket" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TB_NO_HPJacket" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_NO_HPJacket" runat="server" ControlToValidate="TB_NO_HPJacket" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_NO_HPJacket" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                            </div>




                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_Remarks" runat="server" AssociatedControlID="TB_Remarks" Text="Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Remarks" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Remarks" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_Remarks" runat="server" ValidationGroup="Submit" ControlToValidate="TB_Remarks" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Remarks" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Remarks for worker"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>



                    </div>



                    <%--button start--%>

                    <div class="col-md-6">
                        <div class="mb-3">
                            <div class="input-group input-group-sm">

                     <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-warning btn-sm" ValidationGroup="Update" CausesValidation="true" OnClick="btnUpdate_Click" />
<asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm" ValidationGroup="Delete" CausesValidation="false" OnClick="btnDelete_Click" />
<asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="btnSave_Click" />
<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary btn-sm" ValidationGroup="Cancel" CausesValidation="false" OnClick="btnCancel_Click" />
         

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>


</asp:Content>




