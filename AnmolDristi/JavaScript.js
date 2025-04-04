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