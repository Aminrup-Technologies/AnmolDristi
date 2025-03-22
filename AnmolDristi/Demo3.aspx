<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Demo3.aspx.cs" Inherits="AnmolDristi.Demo3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        :root {
            --primary: #f45b50;
            --black: #000;
            --white: #fff;
            --gray: #ccc;
            --heading-bg: #c3c3c3;
            --hover-bg: #f0f0f0;
        }

        /*        * {
            margin: 0;
            padding: 0;
        }
*/
        body {
            font-family: "Roboto", serif;
            color: var(--black);
            font-weight: normal;
            line-height: 2;
        }
    </style>
    <%--///--%>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%-- <script type="text/javascript">
        function toggleAccordion() {
            var panel = document.getElementById("<%= PanelContent.ClientID %>");
            panel.style.display = (panel.style.display === "none") ? "block" : "none";

        };
        function toggle_SafetyShoe(radioButtonList) {
            console.log("toggle_SafetyShoe function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("Display_SafetyShoe");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "2") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        };
</script>--%>

    <script>
        function toggleAccordion(panelId) {
            var panel = document.getElementById(panelId);
            if (panel) {
                panel.style.display = (panel.style.display === "none" || panel.style.display === "") ? "block" : "none";
            }
        }
        document.addEventListener("DOMContentLoaded", function () {
            // Attach event listeners to all radio buttons
            document.querySelectorAll("input[type='radio']").forEach(radio => {
                radio.addEventListener("change", function () {
                    toggleRemarks(this);
                });
            });

            // Form validation function
            document.getElementById("btnSubmit").addEventListener("click", function (event) {
                if (!validateForm(event)) {
                    event.preventDefault(); // Prevent form submission if validation fails
                } else {
                    clearForm(); // Clear form after successful submission
                }
            });
        });

        function toggleRemarks(radioButton) {
            let questionContainer = radioButton.closest(".p-2.border"); // Find the parent question container
            let remarksDiv = questionContainer.querySelector(".remarks-section"); // Get remarks section

            if (radioButton.value === "2") {
                remarksDiv.style.display = "block"; // Show remarks if "Not Ok" is selected
            } else {
                remarksDiv.style.display = "none"; // Hide remarks otherwise
                let inputField = remarksDiv.querySelector("input[type='text']");
                let fileInput = remarksDiv.querySelector("input[type='file']");
                if (inputField) inputField.value = ""; // Clear text input
                if (fileInput) fileInput.value = ""; // Clear file input
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            // Attach event listener to all radio buttons
            document.querySelectorAll("input[type='radio']").forEach(radio => {
                radio.addEventListener("change", function () {
                    toggleRemarks(this);
                });
            });

            // Attach event listener to the form submit button
            document.getElementById("inspectionForm").addEventListener("submit", function (event) {
                if (!validateForm()) {
                    event.preventDefault(); // Prevent submission if validation fails
                } else {
                    clearForm(); // Clear form after successful submission
                }
            });
        });

        function toggleRemarks(radioButton) {
            let questionContainer = radioButton.closest(".p-2.border");
            let remarksDiv = questionContainer.querySelector(".remarks-section");

            if (radioButton.value === "2") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
                let inputField = remarksDiv.querySelector("input[type='text']");
                let fileInput = remarksDiv.querySelector("input[type='file']");
                if (inputField) inputField.value = "";
                if (fileInput) fileInput.value = "";
            }
        }

        function validateForm() {
            let isValid = true;
            let allQuestionsAnswered = true;

            document.querySelectorAll(".p-2.border").forEach(function (questionContainer) {
                let selectedRadio = questionContainer.querySelector("input[type='radio']:checked");
                let remarksInput = questionContainer.querySelector(".remarks-section input[type='text']");
                let errorLabel = questionContainer.querySelector(".error-message");

                if (!selectedRadio) {
                    allQuestionsAnswered = false;
                } else {
                    if (selectedRadio.value === "2" && (!remarksInput || !remarksInput.value.trim())) {
                        errorLabel.style.display = "block";
                        isValid = false;
                    } else {
                        errorLabel.style.display = "none";
                    }
                }
            });

            if (!allQuestionsAnswered) {
                alert("⚠ Please answer all questions before submitting.");
                return false;
            }

            if (!isValid) {
                return false;
            }

            return true; // Allow form submission
        }

        function clearForm() {
            setTimeout(() => {
                document.querySelectorAll("input[type='radio']").forEach(radio => {
                    radio.checked = false;
                });

                document.querySelectorAll(".remarks-section input[type='text']").forEach(input => {
                    input.value = "";
                });

                document.querySelectorAll(".remarks-section input[type='file']").forEach(file => {
                    file.value = "";
                });

                document.querySelectorAll(".error-message").forEach(error => {
                    error.style.display = "none";
                });

                document.querySelectorAll(".remarks-section").forEach(section => {
                    section.style.display = "none";
                });
            }, 500); // Delay ensures submission before clearing
        }



    </script>
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5>Main Heading</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-md-6  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Sub Heading</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <!-- First set of dropdown list -->
                                <div class="col-md-4 ">
                                    <div class="form-group">
                                        <asp:Label ID="lbl_Date" runat="server" AssociatedControlID="TB_Date" Text="Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Date" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Date" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="TB_Date" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" Placeholder=""></asp:TextBox>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-md-4 col-">
                                    <div class="form-group">
                                        <asp:Label ID="lbl_Dept" runat="server" AssociatedControlID="TB_Dept" Text="Department:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" placeholder=""></asp:Label>
                                        <asp:RequiredFieldValidator ID="RFV_TB_Dept" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Dept" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="TB_Dept" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <asp:Label ID="lbl_Job" runat="server" AssociatedControlID="TB_Job" Text="Job :" ForeColor="Blue" Font-Bold="true" Font-Size="Small" placeholder=""></asp:Label>
                                      <asp:RequiredFieldValidator ID="RFV_TB_Job" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Job" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                        <asp:TextBox ID="TB_Job" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>


                                    </div>
                                </div>

                                <%-- accordian loop--%>

                                <div class="col-md-12">
                                    <div class="border p-2 bg-primary text-white" style="cursor: pointer;" onclick="toggleAccordion('<%= Panel1.ClientID %>')">
                                        <h5 class="m-0">Sort Out - SEIRI ▼</h5>
                                    </div>
                                    <asp:Panel ID="Panel1" runat="server" CssClass="accordion-panel" Style="display: none;">
                                        <%--         first question--%>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl4" runat="server" Text="Is the floor area free of unwanted items? " Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text_1" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>


                                            </div>
                                        </div>
                                        <%--        second question--%>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl5" runat="server" Text=" Are tops and insides of all cupboards, shelves, tables,  etc. free of unwanted items?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                 <%--   rfv--%>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text5" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                    
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                          <%--          rfv all question --%>
                                                    
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl6" runat="server" Text=" Are Items stored according to frequencyof use? " Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="RadioButtonList6" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="Labe7" runat="server" Text="Are walls free of old posters, calendars, pictures,
    notices etc.? "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text7" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl8" runat="server" Text="Is there a general clutter free appearance?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text9" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                    </asp:Panel>

                                </div>
                                <%--second accordian loop--%>
                                <div class="col-md-12 mt-2">
                                    <div class="border p-2 bg-primary text-white" style="cursor: pointer;" onclick="toggleAccordion('<%= Panel2.ClientID %>')">
                                        <h5 class="m-0">SET IN ORDER-SEITON ▼</h5>
                                    </div>
                                    <asp:Panel ID="Panel2" runat="server" CssClass="accordion-panel" Style="display: none;">
                                        <%--         first question--%>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl10" runat="server" Text="Are direction indications available to all facilities from
                                        the entrance
                                        onwards? "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text10" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>


                                            </div>
                                        </div>
                                        <%--        second question--%>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl11" runat="server" Text="Do all items of equipment have identification labels ?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text11" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl12" runat="server" Text=" Are all rooms, cubicles and similar areas clearly numbered
                                        or named?  "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text12" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl13" runat="server" Text="Are specific areas demarcated for garbage/rejects/waste,
                                        etc.  "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text13" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl14" runat="server" Text="Are switches, fan regulators, controls, etc. labelled?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text14" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl15" runat="server" Text="Are all cables, wires, pipes etc, neat and straight?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text15" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl16" runat="server" Text="is colour coding used effectively for easy identification?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text16" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl17" runat="server" Text="Is there a general appearance of orderliness? "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text17" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl18" runat="server" Text="Is it easy to find any item/document without delay? "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text18" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                    </asp:Panel>

                                </div>

                                <%--three accordian loop--%>
                                <div class="col-md-12 mt-2">
                                    <div class="border p-2 bg-primary text-white" style="cursor: pointer;" onclick="toggleAccordion('<%= Panel3.ClientID %>')">
                                        <h5 class="m-0">SHINE-SEISO ▼</h5>
                                    </div>
                                    <asp:Panel ID="Panel3" runat="server" CssClass="accordion-panel" Style="display: none;">
                                        <%--         first question--%>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl20" runat="server" Text="  Are cleaning schedules available and displayed?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text20" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>


                                            </div>
                                        </div>
                                        <%--        second question--%>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl21" runat="server" Text=" Are floors, walls, windows doors etc. maintained at a high
                                        level of
                                        cleanliness?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text21" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl22" runat="server" Text=" Are Items stored according to frequencyof use?   "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text22" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl23" runat="server" Text="Are machines, equipment, tools, furniture maintained al a
                                        high level of
                                        cleanliness and their maintenance schedules displayed?    "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text23" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl24" runat="server" Text="Is there a general appearance of cleanliness all round?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text24" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>

                                    </asp:Panel>

                                </div>
                                <%--fourth accordian loop--%>
                                <div class="col-md-12 mt-2">
                                    <div class="border p-2 bg-primary text-white" style="cursor: pointer;" onclick="toggleAccordion('<%= Panel4.ClientID %>')">
                                        <h5 class="m-0">STANDARDIZE-SEIKETSU ▼</h5>
                                    </div>
                                    <asp:Panel ID="Panel4" runat="server" CssClass="accordion-panel" Style="display: none;">
                                        <%--         first question--%>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl25" runat="server" Text="  Are all 5S procedures standardized?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="text25" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>


                                            </div>
                                        </div>
                                        <%--        second question--%>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl26" runat="server" Text="Are standard check lists used to regularly inspect 5s?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text26" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl28" runat="server" Text="Are labels, notices etc. standardized? "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text28" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl29" runat="server" Text="Do isles/gangways have a standard size and colour? "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text29" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                                      
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl30" runat="server" Text="Are pipes, cables etc. colourcoded? "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text30" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>

                                    </asp:Panel>

                                </div>
                                <!-- five section question -->
                                <div class="col-md-12 mt-2">
                                    <div class="border p-2 bg-primary text-white" style="cursor: pointer;" onclick="toggleAccordion('<%= Panel5.ClientID %>')">
                                        <h5 class="m-0">SUSTAIN-SHITSUKE ▼</h5>
                                    </div>
                                    <asp:Panel ID="Panel5" runat="server" CssClass="accordion-panel" Style="display: none;">
                                        <%--         first question--%>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl31" runat="server" Text="  is there a system for how and when the 5S activities will
                                        be implemented?"
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text31" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>


                                            </div>
                                        </div>
                                        <%--        second question--%>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl32" runat="server" Text="Does management provide support to 5S programme by
                                        recognition, resources
                                        and leadership? "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text32" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl33" runat="server" Text=" Have first 3S become a part of the Dally work?   "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text33" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="p-2 border">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <asp:Label ID="lbl34" runat="server" Text="Do employees show positive interest in 5S activities?  "
                                                        Font-Bold="false" Font-Size="Small"></asp:Label>
                                                </div>
                                                <div class="col-md-2 d-flex justify-content-betwen">
                                                    <asp:RadioButtonList ID="Text34" runat="server" RepeatDirection="Horizontal" CssClass="w-100" onchange="toggleRemarksSection(this);">
                                                        <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Not Ok" Value="2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <div class="col-md-12 remarks-section" style="display: none;">
                                                    <asp:Label runat="server" Text=" Remarks" CssClass="mb-0" ForeColor="Black" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                    <div class="input-group-sm">
                                                        <asp:TextBox runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                        <asp:FileUpload runat="server" CssClass="mt-2"></asp:FileUpload>
                                                    </div>
                                                    <!-- Error Message -->
                                                    <span class="error-message text-danger" style="display: none;">Remarks are required when selecting "Not Ok".</span>
                                                </div>

                                            </div>
                                        </div>


                                    </asp:Panel>

                                </div>


                                <%--button start--%>
                                <div class="col-md-12 center-margin">
                                    <div class="ln_solid"></div>

                                    <div class=" row">
                                        <div class="col-12 d-flex justify-content-center">
                                            <button type="button" class="btn btn-danger btn-sm collapse-link">Cancel</button>
                                            <button type="reset" class="btn btn-warning btn-sm">Reset</button>
                                               <%--<asp:Button ID="btn_submit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" OnClientClick="return ValidateFormField()" />--%>
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" OnClientClick="return validateForm();"  />
                                            
    


                                        </div>
                                    </div>
                                    <div class="row text-center">
                                        <div class=" col-12 ">
                                            <asp:Label ID="lbl_msg" runat="server" Text="Click SUBMIT to Save Data!!"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <%--button end--%>

                                <!-- Small modal -->
                                <asp:Button ID="ShowPopup" runat="server" Text="Button" class="btn btn-primary" Visible="false" data-toggle="modal" data-target=".bs-example-modal-sm" />
                                <div id="MyPopup" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-sm">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <h4 class="modal-title" id="myModalLabel2"></h4>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">×</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <!-- Small Modal - END---->
                            </div>
                        </div>

                        <%--                        <div class="col-md-12 col-sm-12">
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>View and Manage : Work Order Data</h2>
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                    <div class="row">
                                        <div class="col-md-12 col-sm-12">
                                            <div class="card-box table-responsive">
                                                <span>Hello, How are you?</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>--%>
                    </div>

                </div>

            </div>

        </div>

    </div>
</asp:Content>
