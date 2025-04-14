<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="fiveS_checklist_1.aspx.cs" Inherits="AnmolDristi.fiveS_checklist_1" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .collapse-toggle-icon {
            transition: transform 0.3s ease;
        }

        a.collapsed .collapse-toggle-icon {
            transform: rotate(0deg);
        }

        a:not(.collapsed) .collapse-toggle-icon {
            transform: rotate(180deg);
        }
    </style>


    <script type="text/javascript">
        function validateChecklist() {
            let isValid = true;

            document.querySelectorAll(".requirement-item").forEach(function (item) {
                const selectedResult = item.querySelector("input[type='radio']:checked");
                const remark = item.querySelector(".remark-input");
                const photo = item.querySelector(".photo-input");
                const remarkError = item.querySelector(".rfv.remark-error");
                const photoError = item.querySelector(".rfv.photo-error");


                if (remarkError) remarkError.style.display = "none";
                if (photoError) photoError.style.display = "none";

                if (selectedResult && selectedResult.value === "false") {
                    if (!remark || remark.value.trim() === "") {
                        if (remarkError) remarkError.style.display = "block";
                        isValid = false;
                    }

                    if (!photo || !photo.value) {
                        if (photoError) photoError.style.display = "block";
                        isValid = false;
                    }
                }
            });

            return isValid;
        }


        function toggleInputs(radioBtn) {
            const wrapper = radioBtn.closest(".requirement-item");
            const hiddenFields = wrapper.querySelector(".hidden-fields");

            // NOT OK
            if (radioBtn.value === "false") {
                hiddenFields.style.display = "block";
            }
            // OK
            else {
                hiddenFields.style.display = "none";

                const remarkBox = wrapper.querySelector(".remark-input");
                const photoInput = wrapper.querySelector(".photo-input");

                if (remarkBox) remarkBox.value = "";
                if (photoInput) photoInput.value = "";

                wrapper.querySelectorAll(".rfv").forEach(v => v.style.display = "none");
            }
        }

        window.onload = function () {

            const radios = document.querySelectorAll('input[type="radio"]');
            radios.forEach(function (rb) {
                rb.addEventListener("change", function () {
                    toggleInputs(rb);
                });

                if (rb.checked) {
                    toggleInputs(rb);
                }
            });
        };

        function resetFormUI() {
           
            document.querySelectorAll('input[type="text"], input[type="date"], textarea').forEach(function (input) {
                input.value = "";
            });

            document.querySelectorAll('.requirement-item').forEach(function (item) {
                let okRadio = item.querySelector('input[type="radio"][value="true"]');
                if (okRadio) okRadio.checked = true;
            });

            document.querySelectorAll('.photo-input').forEach(function (fileInput) {
                fileInput.value = "";
            });

            document.querySelectorAll('.hidden-fields').forEach(function (section) {
                section.style.display = "none";
            });

            document.querySelectorAll(".rfv").forEach(function (v) {
                v.style.display = "none";
            });
        }

        function confirmReset() {
            if (confirm('Are you sure you want to clear all fields?')) {
                resetFormUI(); 
            }
        }


    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5 style="text-align: center; font-weight: bold"; class="text-success">CHECKLIST FOR 5S</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row m-0">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <asp:label runat="server" ForeColor="Green" Font-Bold="true" >ATS/OHS/HKS-5SCL-01</asp:label>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <div class="row mb-4">
                                <!-- Date Field -->
                                <div class="col-md-4 col-sm-12 mb-3">
                                    <asp:label for="txtDate" runat="server" class="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Date:</asp:label>
                                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDate" runat="server"
                                        ControlToValidate="txtDate"
                                        ErrorMessage="Date is required"
                                        CssClass="text-danger"
                                        Display="Dynamic"
                                        ValidationGroup="save" />
                                </div>

                                <!-- Department Field -->
                                <div class="col-md-4 col-sm-12 mb-3">
                                    <asp:label for="txtDepartment" runat="server" class="form-label" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Department:</asp:label>
                                    <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDepartment" runat="server"
                                        ControlToValidate="txtDepartment"
                                        ErrorMessage="Department is required"
                                        CssClass="text-danger"
                                        Display="Dynamic"
                                        ValidationGroup="save" />
                                </div>

                                <!-- Job Field -->
                                <div class="col-md-4 col-sm-12 mb-3">
                                    <asp:label for="txtJob" runat="server" class="form-label" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Job:</asp:label>
                                    <asp:TextBox ID="txtJob" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvJob" runat="server"
                                        ControlToValidate="txtJob"
                                        ErrorMessage="Job is required"
                                        CssClass="text-danger"
                                        Display="Dynamic"
                                        ValidationGroup="save" />
                                </div>
                            </div>



                            <asp:Repeater ID="DictionaryRepeater" runat="server">
                                <ItemTemplate>
                                    <div class="card mb-4 shadow-sm">
                                        <div class="card-header d-flex justify-content-between align-items-center bg-primary text-white">
                                            <h6 class="mb-0">
                                                        <asp:Label ID="Grp_detail" runat="server" Text='<%# Bind("Value") %>' />

                                            </h6>

                                            <a class="text-white text-decoration-none collapsed ml-auto" data-toggle="collapse"
                                                   href='<%# "#collapse" + Container.ItemIndex %>' role="button"
                                                   aria-expanded="false" aria-controls='<%# "collapse" + Container.ItemIndex %>'>
                                                    <i class="fa fa-chevron-down collapse-toggle-icon"></i>
                                                </a>
                                   

                                        </div>
                                        <div id='<%# "collapse" + Container.ItemIndex %>' class="collapse card-body">
                                            <%-- <div class="card-body">--%>
                                            <asp:Repeater ID="ChildRepeater" runat="server" DataSource='<%# Eval("Keys") %>'>
                                                
                                                <ItemTemplate>
                                                    <div class="row requirement-item mb-4 p-3 border rounded needs-validation">
                                                        <div class="col-md-3">
                                                            <asp:label for="labelRequirementEmail4" runat="server" CssClass="form-label " ForeColor="Black" Font-Bold="False" Font-Size="Small">Requirement:<%# Eval("Serial") %></asp:label>
                                                            <asp:Label ID="Requirement" CssClass="form-label" runat="server" Text='<%# Bind("key") %>' ForeColor="Blue" Font-Bold="true" Font-Size="Small"/>
                                                        </div>

                                                        <div class="col-md-2">
                                                            <asp:label for="labelresult" class="form-label" runat="server"  ForeColor="Black" Font-Bold="False" Font-Size="Small">Ok/NotOk:</asp:label>

                                                            <asp:RadioButtonList ID="result" runat="server" RepeatDirection="Horizontal"
                                                                CssClass="" OnClientClick="toggleInputs(this)" ForeColor="Black" Font-Bold="False" Font-Size="Small">
                                                                <asp:ListItem Text="OK" Value="true" Selected="True"  />
                                                                <asp:ListItem Text="NOT OK" Value="false" />
                                                            </asp:RadioButtonList>
                                                            <asp:RequiredFieldValidator ID="rfvResult" runat="server"
                                                                ControlToValidate="result"
                                                                ErrorMessage="Please select OK/NOT OK"
                                                                CssClass="text-danger rfv"
                                                                Display="Dynamic"
                                                                ValidationGroup="save" />

                                                        </div>

                                                        <div class="col-md-6 hidden-fields" style="">
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <label for="labelremarks" class="form-label">Remarks:</label>
                                                                    <asp:TextBox ID="Remark_text" runat="server" CssClass="form-control remark-input" TextMode="MultiLine"></asp:TextBox>
                                                                    <span class="text-danger rfv remark-error" style="display: none;">Remark is required</span>
                                                                </div>

                                                                <div class="col-md-6 ">
                                                                    <label for="labelphotograph" class="form-label">Before Photographs:</label>
                                                                    <asp:FileUpload ID="Before_pic" runat="server" CssClass="form-control-file photo-input" />
                                                                    <span class="text-danger rfv photo-error" style="display: none;">Photo is required</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                     </div>
                                   <%-- </div>--%>
                                </ItemTemplate>
                            </asp:Repeater>



                            <!-- Submit Button -->
                            <div class="text-center mt-4">
                                <asp:Button ID="submit" runat="server" OnClick="submit_Click" Text="Submit"
                                    CssClass="btn btn-success px-4 py-2" OnClientClick="validateChecklist();" ValidationGroup="save" />

                                <!-- Reset button-->

                                <asp:Button ID="reset" runat="server" OnClick="reset_Click" Text="Reset"
                                    CssClass="btn btn-secondary px-4 py-2" OnClientClick="confirmReset(); return false;" />

                                <!-- Home button-->
                                <asp:Button runat="server" ID="home"  Text="Home"
                                    CssClass="btn btn-primary px-4 py-2" OnClick="home_Click" />


                            </div>



                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
