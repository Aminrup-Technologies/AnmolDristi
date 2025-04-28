<%@ Page Title="First Task" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true"
    CodeBehind="WebForm1.aspx.cs" Inherits="AnmolDristi.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Google Font Roboto -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="css/StyleSheet1.css">

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Toggle Remarks visibility dynamically
            document.querySelectorAll(".toggle-remarks").forEach(function (radio) {
                radio.addEventListener("change", function () {
                    let targetId = this.getAttribute("data-target");
                    let remarksDiv = document.getElementById(targetId);
                    if (this.value === "Not OK") {
                        remarksDiv.classList.remove("d-none");
                    } else {
                        remarksDiv.classList.add("d-none");
                    }
                });
            });

            // Submit button validation
            document.getElementById("<%= btnSubmit.ClientID %>").addEventListener("click", function (event) {
                event.preventDefault(); // Prevent default form submission
                let form = document.querySelector("form"); // Ensure you select the correct form

                let isValid = true;
                let errorMessage = "This field is required.";
                let accordionsWithErrors = new Set();

                // Validate Date
                let dateInput = document.getElementById("<%= date.ClientID %>");
                let dateError = document.getElementById("date_error");
                if (!dateInput.value.trim()) {
                    dateError.innerText = errorMessage;
                    isValid = false;
                } else {
                    dateError.innerText = "";
                }

                // Validate Department
                let departmentInput = document.getElementById("<%= department1.ClientID %>");
                let departmentError = document.getElementById("department_error");
                if (!departmentInput.value.trim()) {
                    departmentError.innerText = errorMessage;
                    isValid = false;
                } else {
                    departmentError.innerText = "";
                }

                // Validate Job Title
                let jobTitleInput = document.getElementById("<%= department2.ClientID %>");
                let jobTitleError = document.getElementById("jobtitle_error");
                if (!jobTitleInput.value.trim()) {
                    jobTitleError.innerText = errorMessage;
                    isValid = false;
                } else {
                    jobTitleError.innerText = "";
                }

                // Validate all questions
                document.querySelectorAll(".question-group").forEach(function (questionDiv) {
                    let questionError = questionDiv.querySelector(".question-error");
                    let selectedRadio = questionDiv.querySelector("input[type='radio']:checked");
                    let remarksInput = questionDiv.querySelector(".remarks-textarea");
                    let remarksError = questionDiv.querySelector(".remarks-error");

                    let accordionBody = questionDiv.closest(".accordion-collapse");

                    if (!selectedRadio) {
                        questionError.innerText = "Please select an option.";
                        isValid = false;
                        accordionsWithErrors.add(accordionBody.id);
                    } else {
                        questionError.innerText = "";
                        if (selectedRadio.value === "Not OK" && remarksInput.value.trim() === "") {
                            remarksError.innerText = "Remarks are required.";
                            isValid = false;
                            accordionsWithErrors.add(accordionBody.id);
                        } else {
                            remarksError.innerText = "";
                        }
                    }
                });

                // Open accordions with errors
                accordionsWithErrors.forEach(function (accordionId) {
                    let accordionElement = document.getElementById(accordionId);
                    let accordionButton = accordionElement.previousElementSibling.querySelector(".accordion-button");

                    accordionElement.classList.add("show");
                    accordionButton.classList.remove("collapsed");
                    accordionButton.setAttribute("aria-expanded", "true");
                });

                // Submit if valid
                if (isValid) {
                    alert("Form submitted successfully!");

                    // Clear the form fields
                    form.reset();

                    // Clear error messages
                    document.querySelectorAll(".text-danger").forEach(error => error.innerText = "");

                    // Hide remarks sections
                    document.querySelectorAll(".remarks-section").forEach(section => section.classList.add("d-none"));
                }
            });
        });
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container py-4">
            <div class="row mb-2">
                <div class="col-md-3">
                    <asp:Label runat="server" AssociatedControlID="date" CssClass="form-label">Date <sup
                                class="text-danger">*</sup></asp:Label>
                    <asp:TextBox ID="date" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    <div class="text-danger mt-1 question-error" id="date_error"></div>
                </div>
                <div class="col-md-3">
                    <asp:Label runat="server" AssociatedControlID="department1" CssClass="form-label">Department
                            <sup class="text-danger">*</sup>
                    </asp:Label>
                    <asp:TextBox ID="department1" runat="server" CssClass="form-control"></asp:TextBox>
                    <div class="text-danger mt-1 question-error" id="department_error"></div>
                </div>
                <div class="col-md-6">
                    <asp:Label runat="server" AssociatedControlID="department2" CssClass="form-label">Job Title <sup
                                class="text-danger">*</sup></asp:Label>
                    <asp:TextBox ID="department2" runat="server" CssClass="form-control"></asp:TextBox>
                    <div class="text-danger mt-1 question-error" id="jobtitle_error"></div>
                </div>
            </div>

            <div class="accordion" id="question_accordion">
                <!-- First Accordian -->
                <div class="accordion-item">
                    <div class="accordion-header" id="heading_1">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse"
                            data-bs-target="#collapse_1" aria-expanded="true" aria-controls="collapse_1">
                            <h1 class="form-heading">Sort Out - SEIRI</h1>
                        </button>
                    </div>
                    <div id="collapse_1" class="accordion-collapse collapse show"
                        data-bs-parent="#question_accordion">
                        <div class="accordion-body">
                            <!-- First Question -->
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Is the floor area free of unwanted items? <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_1" id="question_ok_1" value="Ok"
                                                    data-target="question_remarks_1">
                                                <label class="form-check-label" for="question_ok_1">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_1" id="question_not_ok_1" value="Not OK"
                                                    data-target="question_remarks_1">
                                                <label class="form-check-label" for="question_not_ok_1">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>

                                <div id="question_remarks_1" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_1">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_1"
                                        id="question_textarea_1"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>

                            <!-- Second Question -->
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are tops and insides of all cupboards, shelves, tables,
                                        etc. free of
                                        unwanted items? <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_2" id="question_ok_2" value="Ok"
                                                    data-target="question_remarks_2">
                                                <label class="form-check-label" for="question_ok_2">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_2" id="question_not_ok_2" value="Not OK"
                                                    data-target="question_remarks_2">
                                                <label class="form-check-label" for="question_not_ok_2">
                                                    Not
                                                        OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_2" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_2">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_2"
                                        id="question_textarea_2"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are Items stored according to frequencyof use? <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_3" id="question_ok_3" value="Ok"
                                                    data-target="question_remarks_3">
                                                <label class="form-check-label" for="question_ok_3">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_3" id="question_not_ok_3" value="Not OK"
                                                    data-target="question_remarks_3">
                                                <label class="form-check-label" for="question_not_ok_3">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_3" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_3">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_3"
                                        id="question_textarea_3"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are walls free of old posters, calendars, pictures,notices etc.? <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_4" id="question_ok_4" value="Ok"
                                                    data-target="question_remarks_4">
                                                <label class="form-check-label" for="question_ok_4">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_4" id="question_not_ok_4" value="Not OK"
                                                    data-target="question_remarks_4">
                                                <label class="form-check-label" for="question_not_ok_4">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_4" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_4">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_4"
                                        id="question_textarea_4"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Is there a general clutter free appearance?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_5" id="question_ok_5" value="Ok"
                                                    data-target="question_remarks_5">
                                                <label class="form-check-label" for="question_ok_5">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_5" id="question_not_ok_5" value="Not OK"
                                                    data-target="question_remarks_5">
                                                <label class="form-check-label" for="question_not_ok_5">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_5" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_5">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_5"
                                        id="question_textarea_5"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                       </div>
                    </div>
                </div>

                <!-- Second Accordian -->
                <div class="accordion-item">
                    <div class="accordion-header" id="heading_2">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#collapse_2" aria-expanded="false" aria-controls="collapse_2">
                            <h1 class="form-heading">SET IN ORDER-SEITON</h1>
                        </button>
                    </div>
                    <div id="collapse_2" class="accordion-collapse collapse" data-bs-parent="#question_accordion">
                        <div class="accordion-body">
                            <!-- First Question -->
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are direction indications available to all facilities from the entrance onwards?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_6" id="question_ok_6" value="Ok"
                                                    data-target="question_remarks_6">
                                                <label class="form-check-label" for="question_ok_6">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_6" id="question_not_ok_6" value="Not OK"
                                                    data-target="question_remarks_6">
                                                <label class="form-check-label" for="question_not_ok_6">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_6" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_6">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_6"
                                        id="question_textarea_6"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Do all items of equipment have identification labels ?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_7" id="question_ok_7" value="Ok"
                                                    data-target="question_remarks_7">
                                                <label class="form-check-label" for="question_ok_7">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_7" id="question_not_ok_7" value="Not OK"
                                                    data-target="question_remarks_7">
                                                <label class="form-check-label" for="question_not_ok_7">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_7" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_7">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_7"
                                        id="question_textarea_7"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are all rooms, cubicles and similar areas clearly numbered or named? <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_8" id="question_ok_8" value="Ok"
                                                    data-target="question_remarks_8">
                                                <label class="form-check-label" for="question_ok_8">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_8" id="question_not_ok_8" value="Not OK"
                                                    data-target="question_remarks_8">
                                                <label class="form-check-label" for="question_not_ok_8">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_8" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_7">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_8"
                                        id="question_textarea_8"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are specific areas demarcated for garbage/rejects/waste, etc.  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_9" id="question_ok_9" value="Ok"
                                                    data-target="question_remarks_9">
                                                <label class="form-check-label" for="question_ok_9">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_9" id="question_not_ok_9" value="Not OK"
                                                    data-target="question_remarks_9">
                                                <label class="form-check-label" for="question_not_ok_9">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_9" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_9"
                                        id="question_textarea_9"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are switches, fan regulators, controls, etc. labelled?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_10" id="question_ok_10" value="Ok"
                                                    data-target="question_remarks_10">
                                                <label class="form-check-label" for="question_ok_10">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_10" id="question_not_ok_10" value="Not OK"
                                                    data-target="question_remarks_10">
                                                <label class="form-check-label" for="question_not_ok_10">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_10" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_10"
                                        id="question_textarea_10"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are all cables, wires, pipes etc, neat and straight?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_11" id="question_ok_11" value="Ok"
                                                    data-target="question_remarks_11">
                                                <label class="form-check-label" for="question_ok_11">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_11" id="question_not_ok_11" value="Not OK"
                                                    data-target="question_remarks_11">
                                                <label class="form-check-label" for="question_not_ok_11">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_11" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_11"
                                        id="question_textarea_11"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        is colour coding used effectively for easy identification?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_12" id="question_ok_12" value="Ok"
                                                    data-target="question_remarks_12">
                                                <label class="form-check-label" for="question_ok_12">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_12" id="question_not_ok_12" value="Not OK"
                                                    data-target="question_remarks_12">
                                                <label class="form-check-label" for="question_not_ok_12">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_12" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_12"
                                        id="question_textarea_12"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Is there a general appearance of orderliness?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_13" id="question_ok_13" value="Ok"
                                                    data-target="question_remarks_13">
                                                <label class="form-check-label" for="question_ok_13">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_13" id="question_not_ok_13" value="Not OK"
                                                    data-target="question_remarks_13">
                                                <label class="form-check-label" for="question_not_ok_13">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_13" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_13"
                                        id="question_textarea_13"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Is it easy to find any item/document without delay <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_14" id="question_ok_14" value="Ok"
                                                    data-target="question_remarks_14">
                                                <label class="form-check-label" for="question_ok_14">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_14" id="question_not_ok_14" value="Not OK"
                                                    data-target="question_remarks_14">
                                                <label class="form-check-label" for="question_not_ok_14">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_14" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_14"
                                        id="question_textarea_14"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                       </div>
                    </div>
                </div>
                <!-- Third Accordian -->
                <div class="accordion-item">
                    <div class="accordion-header" id="heading_3">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#collapse_3" aria-expanded="false" aria-controls="collapse_3">
                            <h1 class="form-heading">SHINE-SEISO</h1>
                        </button>
                    </div>
                    <div id="collapse_3" class="accordion-collapse collapse" data-bs-parent="#question_accordion">
                        <div class="accordion-body">
                            <!-- First Question -->
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are cleaning schedules available and displayed?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_15" id="question_ok_15" value="Ok"
                                                    data-target="question_remarks_15">
                                                <label class="form-check-label" for="question_ok_15">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_15" id="question_not_ok_15" value="Not OK"
                                                    data-target="question_remarks_15">
                                                <label class="form-check-label" for="question_not_ok_15">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_15" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_15"
                                        id="question_textarea_15"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are floors, walls, windows doors etc. maintained at a high level of cleanliness?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_16" id="question_ok_16" value="Ok"
                                                    data-target="question_remarks_16">
                                                <label class="form-check-label" for="question_ok_16">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_16" id="question_not_ok_16" value="Not OK"
                                                    data-target="question_remarks_16">
                                                <label class="form-check-label" for="question_not_ok_16">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_16" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_16"
                                        id="question_textarea_16"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are Items stored according to frequencyof use?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_17" id="question_ok_17" value="Ok"
                                                    data-target="question_remarks_17">
                                                <label class="form-check-label" for="question_ok_16">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_17" id="question_not_ok_17" value="Not OK"
                                                    data-target="question_remarks_17">
                                                <label class="form-check-label" for="question_not_ok_17">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_17" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_17"
                                        id="question_textarea_17"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are machines, equipment, tools, furniture maintained al a high level of cleanliness and their maintenance schedules displayed?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_18" id="question_ok_18" value="Ok"
                                                    data-target="question_remarks_18">
                                                <label class="form-check-label" for="question_ok_18">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_18" id="question_not_ok_18" value="Not OK"
                                                    data-target="question_remarks_18">
                                                <label class="form-check-label" for="question_not_ok_18">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_18" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_18"
                                        id="question_textarea_18"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Is there a general appearance of cleanliness all round?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_19" id="question_ok_19" value="Ok"
                                                    data-target="question_remarks_19">
                                                <label class="form-check-label" for="question_ok_19">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_19" id="question_not_ok_19" value="Not OK"
                                                    data-target="question_remarks_19">
                                                <label class="form-check-label" for="question_not_ok_19">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_19" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_19"
                                        id="question_textarea_19"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                         </div>
                    </div>
                </div>
                <!-- Four Accordian -->
                <div class="accordion-item">
                    <div class="accordion-header" id="heading_4">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#collapse_4" aria-expanded="false" aria-controls="collapse_4">
                            <h1 class="form-heading">STANDARDIZE-SEIKETSU</h1>
                        </button>
                    </div>
                    <div id="collapse_4" class="accordion-collapse collapse" data-bs-parent="#question_accordion">
                        <div class="accordion-body">
                            <!-- First Question -->
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are all 55 procedures standardized?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_20" id="question_ok_20" value="Ok"
                                                    data-target="question_remarks_20">
                                                <label class="form-check-label" for="question_ok_20">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_20" id="question_not_ok_20" value="Not OK"
                                                    data-target="question_remarks_20">
                                                <label class="form-check-label" for="question_not_ok_20">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_20" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_20"
                                        id="question_textarea_20"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are standard check lists used to regularly inspect 5s?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_21" id="question_ok_21" value="Ok"
                                                    data-target="question_remarks_21">
                                                <label class="form-check-label" for="question_ok_21">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_21" id="question_not_ok_21" value="Not OK"
                                                    data-target="question_remarks_21">
                                                <label class="form-check-label" for="question_not_ok_21">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_21" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_21"
                                        id="question_textarea_21"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are labels, notices etc. standardized?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_22" id="question_ok_22" value="Ok"
                                                    data-target="question_remarks_22">
                                                <label class="form-check-label" for="question_ok_22">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_22" id="question_not_ok_22" value="Not OK"
                                                    data-target="question_remarks_22">
                                                <label class="form-check-label" for="question_not_ok_22">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_22" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_22"
                                        id="question_textarea_22"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Do isles/gangways have a standard size and colour?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_23" id="question_ok_23" value="Ok"
                                                    data-target="question_remarks_23">
                                                <label class="form-check-label" for="question_ok_23">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_23" id="question_not_ok_23" value="Not OK"
                                                    data-target="question_remarks_23">
                                                <label class="form-check-label" for="question_not_ok_23">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_23" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_23"
                                        id="question_textarea_23"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Are pipes, cables etc. colourcoded?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_24" id="question_ok_24" value="Ok"
                                                    data-target="question_remarks_24">
                                                <label class="form-check-label" for="question_ok_24">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_24" id="question_not_ok_24" value="Not OK"
                                                    data-target="question_remarks_24">
                                                <label class="form-check-label" for="question_not_ok_24">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_24" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_24"
                                        id="question_textarea_24"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Five Accordian -->
                <div class="accordion-item">
                    <div class="accordion-header" id="heading_5">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#collapse_5" aria-expanded="false" aria-controls="collapse_5">
                            <h1 class="form-heading">SUSTAIN-SHITSUKE</h1>
                        </button>
                    </div>
                    <div id="collapse_5" class="accordion-collapse collapse" data-bs-parent="#question_accordion">
                        <div class="accordion-body">
                            <!-- First Question -->
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        is there a system for how and when the 55 activities will be implemented?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_25" id="question_ok_25" value="Ok"
                                                    data-target="question_remarks_25">
                                                <label class="form-check-label" for="question_ok_25">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_25" id="question_not_ok_25" value="Not OK"
                                                    data-target="question_remarks_25">
                                                <label class="form-check-label" for="question_not_ok_25">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_25" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_25"
                                        id="question_textarea_25"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Does management provide support to 55 programme by
                                        recognition, resources
                                        and leadership?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_26" id="question_ok_26" value="Ok"
                                                    data-target="question_remarks_26">
                                                <label class="form-check-label" for="question_ok_26">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_25" id="question_not_ok_26" value="Not OK"
                                                    data-target="question_remarks_26">
                                                <label class="form-check-label" for="question_not_ok_26">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_26" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_26"
                                        id="question_textarea_26"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Have first 3S become a part of the Dally work?   <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_27" id="question_ok_27" value="Ok"
                                                    data-target="question_remarks_27">
                                                <label class="form-check-label" for="question_ok_27">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_27" id="question_not_ok_27" value="Not OK"
                                                    data-target="question_remarks_27">
                                                <label class="form-check-label" for="question_not_ok_27">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_27" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_27"
                                        id="question_textarea_27"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                            <div class="form-border question-group">
                                <div class="d-block d-sm-flex align-items-sm-center justify-content-sm-between">
                                    <p class="fs-6 mb-0">
                                        Do employees show positive interest in 5S activities?  <sup
                                            class="text-danger">*</sup>
                                    </p>
                                    <div class="min-width-option">
                                        <div class="d-flex justify-content-sm-between pt-2 pt-sm-0">
                                            <div class="form-check">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_28" id="question_ok_28" value="Ok"
                                                    data-target="question_remarks_28">
                                                <label class="form-check-label" for="question_ok_28">OK</label>
                                            </div>
                                            <div class="form-check ms-3 ms-sm-0">
                                                <input class="form-check-input toggle-remarks" type="radio"
                                                    name="question_28" id="question_not_ok_28" value="Not OK"
                                                    data-target="question_remarks_28">
                                                <label class="form-check-label" for="question_not_ok_28">
                                                    Not OK</label>
                                            </div>
                                        </div>
                                        <div class="text-danger mt-1 question-error"></div>
                                    </div>
                                </div>
                                <div id="question_remarks_28" class="mt-1 d-none remarks-section">
                                    <label for="question_textarea_9">
                                        Remarks <sup
                                            class="text-danger">*</sup></label>
                                    <textarea class="w-100 form-control remarks-textarea" name="question_textarea_28"
                                        id="question_textarea_28"></textarea>
                                    <div class="text-danger mt-1 remarks-error"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12 text-center">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-outline-primary mt-3" Text="Submit"
                        OnClick="btnSubmit_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
