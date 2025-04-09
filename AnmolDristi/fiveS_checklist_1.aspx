<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="fiveS_checklist_1.aspx.cs" Inherits="AnmolDristi.fiveS_checklist_1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        // When user toggles the checkbox for each requirement
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll(".toggle-result-checkbox").forEach(function (checkbox) {
                checkbox.addEventListener("change", function () {
                    var wrapper = checkbox.closest(".requirement-item");
                    var resultSection = wrapper.querySelector(".result-section");
                    resultSection.style.display = checkbox.checked ? "block" : "none";

                    if (!checkbox.checked) {
                        // Clear selections if unchecked
                        wrapper.querySelectorAll('input[type="radio"]').forEach(rb => rb.checked = false);
                        wrapper.querySelector(".hidden-fields").style.display = "none";
                        wrapper.querySelectorAll(".rfv").forEach(v => v.style.display = "none");
                    }
                });
            });
        });

        // When user selects OK/NOT OK
        function toggleInputs(rbl) {
            const wrapper = rbl.closest(".requirement-item");
            const selected = wrapper.querySelector('input[type="radio"]:checked');
            const hiddenFields = wrapper.querySelector(".hidden-fields");

            if (!selected) return;

            if (selected.value === "0") {
                hiddenFields.style.display = "block";
            } else {
                hiddenFields.style.display = "none";

                const remarkBox = wrapper.querySelector(".remark-input");
                const photoInput = wrapper.querySelector(".photo-input");

                if (remarkBox) remarkBox.value = "";
                if (photoInput) photoInput.value = "";

                wrapper.querySelectorAll(".rfv").forEach(v => v.style.display = "none");
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5>Main Heading</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Checklist for 5s</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <asp:Repeater ID="DictionaryRepeater" runat="server">
                                <ItemTemplate>
                                    <div class="card mb-4 shadow-sm">
                                        <div class="card-header bg-primary text-white">
                                            <h6 class="mb-0">Group <span><%# Eval("GroupSerial") %></span>: <%# Eval("Value") %></h6>
                                        </div>
                                        <div class="card-body">
                                            <asp:Repeater ID="ChildRepeater" runat="server" DataSource='<%# Eval("Keys") %>'>
                                                <ItemTemplate>
                                                    <div class="row requirement-item mb-4 p-3 border rounded needs-validation">
                                                        <div class="col-md-3">
                                                            <label for="labelRequirementEmail4" class="form-label font-weight-bold">Requirement:<%# Eval("Serial") %></label>
                                                            <label class="form-label"><%# Eval("Key") %></label>
                                                        </div>

                                                        <div class="col-md-2">
                                                            <label for="labelresult" class="form-label">Ok/NotOk:</label>
                                                            <asp:RadioButtonList ID="result" runat="server" RepeatDirection="Horizontal"
                                                                CssClass="" onchange="toggleInputs(this)">
                                                                <asp:ListItem Text="OK" Value="1" />
                                                                <asp:ListItem Text="NOT OK" Value="0" />
                                                            </asp:RadioButtonList>
                                                            <asp:RequiredFieldValidator ID="rfvResult" runat="server"
                                                                ControlToValidate="result"
                                                                ErrorMessage="Please select OK/NOT OK"
                                                                CssClass="text-danger rfv"
                                                                Display="Dynamic"
                                                                ValidationGroup="save" />
                                                        </div>

                                                        <div class="col-md-6 hidden-fields" style="display: none;">
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <label for="labelremarks" class="form-label">Remarks:</label>
                                                                    <asp:TextBox ID="Remark_text" runat="server" CssClass="form-control remark-input" TextMode="MultiLine"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvRemark" runat="server"
                                                                        ControlToValidate="Remark_text"
                                                                        ErrorMessage="Remark required"
                                                                        CssClass="text-danger rfv"
                                                                        Display="Dynamic"
                                                                        EnableClientScript="true" />
                                                                </div>

                                                                <div class="col-md-6 ">
                                                                    <label for="labelphotograph" class="form-label">Before Photographs:</label>
                                                                    <asp:FileUpload ID="Before_pic" runat="server" CssClass="form-control-file photo-input" />
                                                                    <asp:RequiredFieldValidator ID="rfvPhoto" runat="server"
                                                                        ControlToValidate="Before_pic"
                                                                        ErrorMessage="Photo required"
                                                                        CssClass="text-danger rfv"
                                                                        Display="Dynamic"
                                                                        EnableClientScript="true" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                            <!-- Submit Button -->
                            <div class="text-center mt-4">
                                <asp:Button ID="Button1" runat="server" OnClick="smt_btn_Click" Text="Submit"
                                    CssClass="btn btn-success px-4 py-2"
                                    ValidationGroup="save" />
                            </div>



                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
