<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_process_rpt.aspx.cs" Inherits="AnmolDristi.qaqc_ProcessChecking_rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .remove-border {
            border: none !important; /* This will ensure the border is removed */
            /* Add any other necessary styling */
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript">


        //maida image
        function validateForm1() {
            var fileUpload = document.getElementById('<%= FU_MaidaImage.ClientID %>');
            var lblErrorMessage1 = document.getElementById('<%= lblErrorMessage1.ClientID %>');
            if (fileUpload.files.length === 0) {
                lblErrorMessage1.innerHTML = "Please upload file.";
                return false;
            } else {
                lblErrorMessage1.innerHTML = "";
                return true;
            }
        }
        //bb image
        function validateForm2() {
            var fileUpload = document.getElementById('<%= FU_BBImage.ClientID %>');
            var lblErrorMessage1 = document.getElementById('<%= lblErrorMessage2.ClientID %>');
            if (fileUpload.files.length === 0) {
                lblErrorMessage1.innerHTML = "Please upload file.";
                return false;
            } else {
                lblErrorMessage1.innerHTML = "";
                return true;
            }
        }

        function validateSubmit() {
            var fileUpload = document.getElementById('<%= FU_BBImage.ClientID %>'); // Get the FileUpload control
            var errorMessageLabel = document.getElementById('<%= lblErrorMessage1.ClientID %>'); // Get the error message label

            if (fileUpload.value === "") {
                errorMessageLabel.innerHTML = "Please select a file before submitting."; // Display error message
                errorMessageLabel.style.color = "red"; // Change color to red
                return false; // Prevent form submission
            }

            // File is selected, return true to allow form submission
            return true;
        }


        function toggleMaidaColorAppRemarksDiv(radioButtonList) {
            console.log("toggleMaidaColorAppRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("MaidaColorAppRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleMaidaFlavorTasteRemarksDiv(radioButtonList) {
            console.log("toggleMaidaFlavorTasteRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("MaidaFlavorTasteRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleMaidaGrittinessRemarksDiv(radioButtonList) {
            console.log("toggleMaidaGrittinessRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("MaidaGrittinessRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleBBColorAppRemarksDiv(radioButtonList) {
            console.log("toggleBBColorAppRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("BBColorAppRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleBBFlavorTasteRemarksDiv(radioButtonList) {
            console.log("toggleBBFlavorTasteRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("BBFlavorTasteRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleBBMouthFeelRemarksDiv(radioButtonList) {
            console.log("toggleBBMouthFeelRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("BBMouthFeelRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleHvoSmellRemarksDiv(radioButtonList) {
            console.log("toggleHvoSmellRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("HvoSmellRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleHvoTasteRemarksDiv(radioButtonList) {
            console.log("toggleHvoTasteRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("HvoTasteRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleSMPSmellRemarksDiv(radioButtonList) {
            console.log("toggleSMPSmellRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("SMPSmellRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleSMPTasteRemarksDiv(radioButtonList) {
            console.log("toggleSMPTasteRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("SMPTasteRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleSMPColorRemarksDiv(radioButtonList) {
            console.log("toggleSMPColorRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("SMPColorRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleSyrupColorRemarksDiv(radioButtonList) {
            console.log("toggleSyrupColorRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("SyrupColorRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleInvertSyrupBucketRemarksDiv(radioButtonList) {
            console.log("toggleInvertSyrupBucketRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("InvertSyrupBucketRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleSugarSolBucketRemarksDiv(radioButtonList) {
            console.log("toggleSugarSolBucketRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("SugarSolBucketRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleCreamerBucketRemarksDiv(radioButtonList) {
            console.log("toggleCreamerBucketRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("CreamerBucketRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleSugarGrinderRemarksDiv(radioButtonList) {
            console.log("toggleSugarGrinderRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("SugarGrinderRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleOilSystemRemarksDiv(radioButtonList) {
            console.log("toggleOilSystemRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("OilSystemRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleOilSprayRemarksDiv(radioButtonList) {
            console.log("toggleOilSprayRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("OilSprayRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleMilkSprayRemarksDiv(radioButtonList) {
            console.log("toggleMilkSprayRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("MilkSprayRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleDrumCoveredRemarksDiv(radioButtonList) {
            console.log("toggleDrumCoveredRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("DrumCoveredRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleQualityRemarksDiv(radioButtonList) {
            console.log("toggleQualityRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("QualityRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleMetalDetectorRemarksDiv(radioButtonList) {
            console.log("toggleMetalDetectorRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("MetalDetectorRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleProcessSequenceRemarksDiv(radioButtonList) {
            console.log("toggleProcessSequenceRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("ProcessSequenceRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleDoughConditionRemarksDiv(radioButtonList) {
            console.log("toggleDoughConditionRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("DoughConditionRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleBalanceConditionRemarksDiv(radioButtonList) {
            console.log("toggleBalanceConditionRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("BalanceConditionRemarksDiv");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        // active tab 
        function activateTab(tabId) {
            $('#' + tabId).tab('show');
        }

        // reset tab fields
        //function clearFields(tabId) {
        //    var tab = document.getElementById(tabId);
        //    if (tab) {
        //        var inputs = tab.querySelectorAll('input, select, textarea');
        //        inputs.forEach(function (input) {
        //            if (input.type === 'checkbox' || input.type === 'radio') {
        //                input.checked = false;
        //            } else if (input.tagName === 'SELECT') {
        //                input.selectedIndex = 0;
        //            } else {
        //                input.value = '';
        //            }
        //        });
        //    }
        //}

        //function resetSectionFields(sectionId) {
        //    var section = document.getElementById(sectionId);
        //    if (section) {
        //        var inputs = section.querySelectorAll('input, select, textarea');

        //        inputs.forEach(function (input) {
        //            switch (input.type) {
        //                case 'text':
        //                case 'textarea':
        //                case 'hidden':
        //                    input.value = '';
        //                    break;
        //                case 'checkbox':
        //                case 'radio':
        //                    input.checked = false;
        //                    break;
        //                case 'select-one':
        //                case 'select-multiple':
        //                    input.selectedIndex = -1;
        //                    break;
        //                default:
        //                    break;
        //            }
        //        });
        //    }
        //}


        function validateGridView() {
            var isValid = true;
            var gridView = document.getElementById('<%= GridView1.ClientID %>');
            for (var i = 1; i < gridView.rows.length; i++) {  // Start from 1 to skip header row
                var row = gridView.rows[i];

                var txtActualWeight = row.querySelector("input[id*='txtActualWeight']");
                //var txtDescription = row.querySelector("input[id*='txtDescription']");

                // Check if TextBoxes are filled
                if (txtActualWeight && txtActualWeight.value.trim() === "") {
                    isValid = false;
                    txtActualWeight.style.borderColor = "red";
                } else {
                    txtActualWeight.style.borderColor = "";
                }

                //if (txtDescription && txtDescription.value.trim() === "") {
                //    isValid = false;
                //    txtDescription.style.borderColor = "red";
                //} else {
                //    txtDescription.style.borderColor = "";
                //}
            }

            // If not valid, prevent form submission
            if (!isValid) {
                alert("Please fill all the required fields.");
            }

            return isValid;
        }

        var gridViewData = [];

        // Function to calculate deviation and update the grid data
        function calculateDeviation(inputElement) {
            // Find the row that contains the input element
            var row = inputElement.closest('tr');
            //console.log('rows:', row);

            var slValue = row.querySelector('td').textContent.trim();
            //console.log('slValue:', slValue);
            // Retrieve the Standard Weight, Actual Weight, and Deviation Weight elements from the same row
            var standardWeightElement = row.querySelector('.standard-weight');
            var standardWeight = parseFloat(standardWeightElement.value) || 0;
            //console.log('Standard Weight:', standardWeight);

            var actualWeightElement = row.querySelector('#txtActualWeight');
            var actualWeight = parseFloat(actualWeightElement.value) || 0;
            //console.log('Actual Weight:', actualWeight);

            // Calculate the deviation
            var deviationWeight = actualWeight - standardWeight;
            //console.log('Deviation Weight:', deviationWeight);

            // Get the Deviation Weight element from the same row
            var deviationWeightElement = row.querySelector('#txtDeviation');

            // Format the deviation weight to two decimal places
            var formattedDeviationWeight = deviationWeight.toFixed(2);
            //console.log('Formatted Deviation Weight:', formattedDeviationWeight);

            // Update the Deviation Weight TextBox
            deviationWeightElement.value = formattedDeviationWeight;

            // Build JSON data for the current row
            var rowData = {
                Sl: slValue,
                Variety: row.querySelector('.variety').textContent.trim(),
                StandardWeight: standardWeight,
                ActualWeight: actualWeight,
                DeviationWeight: formattedDeviationWeight
            };
            //console.log('rowData:', rowData);

            // Update global array with current row data
            updateGridViewData(slValue, rowData);
        }

        // Function to update the global array with the current row's data
        function updateGridViewData(slValue, rowData) {
            // Find the existing row in gridViewData with the matching Sl value
            var existingRowIndex = gridViewData.findIndex(row => row.Sl === slValue);

            // If the row exists, update it; otherwise, add it
            if (existingRowIndex >= 0) {
                gridViewData[existingRowIndex] = rowData;
            } else {
                gridViewData.push(rowData);
            }

            // Log the updated data for debugging
            //console.log('GridView Data Updated:', gridViewData);
        }

        function collectAndSendData() {
            // Ensure all rows are processed
            document.querySelectorAll('#GridView1 tbody tr').forEach(row => {
                var actualWeightElement = row.querySelector('#txtActualWeight');
                if (actualWeightElement) {
                    calculateDeviation(actualWeightElement); // Process each row
                }
            });

            // Convert data to JSON
            var jsonData = JSON.stringify(gridViewData);
            //console.log('Data to be sent:', jsonData);

            // Send data to the server
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'qaqc_process_rpt.aspx/SaveData', true); // URL to your Web Method
            xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
            xhr.setRequestHeader('Accept', 'application/json');
            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        console.log('Data successfully sent to server');
                    } else {
                        console.log('Error sending data:', xhr.statusText);
                    }
                }
            };
            xhr.send(JSON.stringify({ jsonData: jsonData }));
        }

    </script>

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>
                        <asp:Label ID="lbl_docname" runat="server" Text="Label"></asp:Label></h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docnumber" runat="server" Text="Label"></asp:Label></h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-12">
                                                <ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
                                                    <li class="nav-item">
                                                        <a class="nav-link active" id="basicData-tab" data-toggle="tab" href="#basicData" role="tab"
                                                            aria-controls="basicData" aria-selected="true">Basic Data</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link " id="rawMaterial-tab" data-toggle="tab" href="#rawMaterial" role="tab"
                                                            aria-controls="rawMaterial" aria-selected="false">Raw Material Weight</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link " id="weight-tab" data-toggle="tab" href="#weight" role="tab"
                                                            aria-controls="weight" aria-selected="false">Raw Weight</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link " id="spongeData-tab" data-toggle="tab" href="#spongeData" role="tab"
                                                            aria-controls="spongeData" aria-selected="false">Sponge </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link " id="doughData-tab" data-toggle="tab" href="#doughData" role="tab"
                                                            aria-controls="doughData" aria-selected="false">Dough </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link " id="ovenData-tab" data-toggle="tab" href="#ovenData" role="tab"
                                                            aria-controls="ovenData" aria-selected="false">Oven </a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link " id="verificationData-tab" data-toggle="tab" href="#verificationData" role="tab"
                                                            aria-controls="verificationData" aria-selected="false">Verification</a>
                                                    </li>
                                                </ul>

                                                <div class="tab-content ml-1" id="myTabContent">
                                                    <%---Basic Data Starts--%>
                                                    <div class="tab-pane fade show active" id="basicData" role="tabpanel" aria-labelledby="basicData-tab">
                                                        <div class="x-content">

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="DDL_Plant" Text="Plant Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_Plant" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="DDL_Plant" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="BasicSubmit" OnSelectedIndexChanged="DDL_Plant_SelectedIndexChanged"></asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="DDL_PlantLine" Text="Select Line" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_PlantLine" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="DDL_PlantLine" Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_PlantLine" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_PlantLine_SelectedIndexChanged"></asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label3" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductCategory" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" InitialValue="" ControlToValidate="DDL_ProductCategory" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductCategory_SelectedIndexChanged"></asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductBrand" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="DDL_ProductBrand" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductBrand_SelectedIndexChanged"></asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="DDL_BrandSKU" Text="Brand SKU Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_BrandSKU" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="DDL_BrandSKU" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_BrandSKU" runat="server" CssClass="form-control form-control-sm rounded"></asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_ProcessWaterTemp" runat="server" AssociatedControlID="TB_ProcessWaterTemp" Text="Process Water Temp :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_ProcessWaterTemp" runat="server" ErrorMessage="*" ValidationGroup="BasicSubmit" ControlToValidate="TB_ProcessWaterTemp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_ProcessWaterTemp" runat="server" ValidationGroup="BasicSubmit" ControlToValidate="TB_ProcessWaterTemp" ForeColor="Red" ErrorMessage="Decimal only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_ProcessWaterTemp" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Process Water Temp. "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-3" id="ProcessWaterTempRemarksDIV" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelProcessWaterTempRemarks" runat="server" AssociatedControlID="TXB_ProcessWaterTemp_Remarks" Text="Process Water Temp. Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_ProcessWaterTemp_Remarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_ProcessWaterTemp_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_ProcessWaterTemp_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_WaterPH" runat="server" AssociatedControlID="TB_WaterPH" Text="Water PH Value :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_WaterPH" runat="server" ErrorMessage="*" ValidationGroup="BasicSubmit" ControlToValidate="TB_WaterPH" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_WaterPH" runat="server" ValidationGroup="BasicSubmit" ControlToValidate="TB_WaterPH" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_WaterPH" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Water PH Value "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="WaterPHRemarksDIV" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelWaterPHRemarks" runat="server" AssociatedControlID="TXB_WaterPH_Remarks" Text="Water PH Value Remarks:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_WaterPH_Remarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_WaterPH_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_WaterPH_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_WaterHardness" runat="server" AssociatedControlID="TB_WaterHardness" Text="Water Hardness" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_WaterHardness" runat="server" ErrorMessage="*" ValidationGroup="BasicSubmit" ControlToValidate="TB_WaterHardness" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_WaterHardness" runat="server" ValidationGroup="BasicSubmit" ControlToValidate="TB_WaterHardness" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_WaterHardness" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Water Hardness Value "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="WaterHardnessRemarksDIV" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelWaterHardnessRemarks" runat="server" AssociatedControlID="TXB_WaterHardness_Remarks" Text="Water Hardness Remarks:" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_WaterHardness_Remarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_WaterHardness_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_WaterHardness_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_WaterTest" runat="server" AssociatedControlID="TB_WaterTest" Text="Water Test :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_WaterTest" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_WaterTest" ValidationGroup="BasicSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_WaterTest" runat="server" ControlToValidate="TB_WaterTest" ForeColor="Red" ValidationGroup="BasicSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_WaterTest" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Water Test (3-20 characters)" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_TDS" runat="server" AssociatedControlID="TB_TDS" Text="TDS" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_TDS" runat="server" ErrorMessage="*" ValidationGroup="BasicSubmit" ControlToValidate="TB_TDS" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_TDS" runat="server" ValidationGroup="BasicSubmit" ControlToValidate="TB_TDS" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_TDS" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="TDS Value "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-3" id="TDSRemarks" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelTDSRemarks" runat="server" AssociatedControlID="TXB_TDS_Remarks" Text="Tds Remarks:" ForeColor="Red" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TDS_Remarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_TDS_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_TDS_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_MaidaBrand" runat="server" AssociatedControlID="TB_MaidaBrand" Text="Maida Brand :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_MaidaBrand" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_MaidaBrand" ValidationGroup="BasicSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_MaidaBrand" runat="server" ControlToValidate="TB_MaidaBrand" ForeColor="Red" ValidationGroup="BasicSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_MaidaBrand" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Maida Brand (3-20 characters)" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_MaidaBatchNo" runat="server" AssociatedControlID="TB_MaidaBatchNo" Text="Maida Batch No. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_MaidaBatchNo" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_MaidaBatchNo" ValidationGroup="BasicSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_MaidaBatchNo" runat="server" ControlToValidate="TB_MaidaBatchNo" ForeColor="Red" ValidationGroup="BasicSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_MaidaBatchNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Maida Batch No"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_MaidaMfg" runat="server" AssociatedControlID="TB_MaidaMfg" Text="Maida Mfg :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MaidaMfg" runat="server" ErrorMessage="Date is required " ControlToValidate="TB_MaidaMfg" ValidationGroup="BasicSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_MaidaMfg" runat="server" ControlToValidate="TB_MaidaMfg" ForeColor="Red" ValidationGroup="BasicSubmit" ErrorMessage="" Display="Dynamic" ValidationExpression=" "></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_MaidaMfg" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Date"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelMaidaColorApp" runat="server" AssociatedControlID="RBL_MaidaColorApp" Text="Maida Color Appearance :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_RBL_MaidaColorApp" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_MaidaColorApp" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_MaidaColorApp" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleMaidaColorAppRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="MaidaColorAppRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelMaidaColorAppRemarks" runat="server" AssociatedControlID="TXB_MaidaColorApp_Remarks" Text="Maida Color Appearance (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MaidaColorAppRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_MaidaColorApp_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_MaidaColorApp_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelMaidaFlavorTaste" runat="server" AssociatedControlID="RBL_MaidaFlavorTaste" Text="Maida Flavor Taste :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MaidaFlavorTaste" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_MaidaFlavorTaste" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_MaidaFlavorTaste" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleMaidaFlavorTasteRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="MaidaFlavorTasteRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelMaidaFlavorTasteRemarks" runat="server" AssociatedControlID="TXB_MaidaFlavorTaste_Remarks" Text="Maida Flavor Taste (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MaidaFlavorTasteRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_MaidaFlavorTaste_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_MaidaFlavorTaste_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelMaidaGrittiness" runat="server" AssociatedControlID="RBL_MaidaGrittiness" Text="Maida Grittiness :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MaidaGrittiness" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_MaidaGrittiness" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_MaidaGrittiness" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleMaidaGrittinessRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="MaidaGrittinessRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelMaidaGrittinessRemarks" runat="server" AssociatedControlID="TXB_MaidaGrittiness_Remarks" Text="Maida Grittiness (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MaidaGrittinessRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_MaidaGrittiness_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_MaidaGrittiness_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelBBColorApp" runat="server" AssociatedControlID="RBL_BBColorApp" Text="Broken Biscuit Color Appearance :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BBColorApp" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_BBColorApp" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_BBColorApp" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleBBColorAppRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="BBColorAppRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelBBColorAppRemarks" runat="server" AssociatedControlID="TXB_BBColorApp_Remarks" Text="BB Color Appearance (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BBColorAppRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_BBColorApp_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_BBColorApp_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelBBFlavorTaste" runat="server" AssociatedControlID="RBL_BBFlavorTaste" Text="Broken Biscuit Flavor Taste :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BBFlavorTaste" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_BBFlavorTaste" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_BBFlavorTaste" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleBBFlavorTasteRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="BBFlavorTasteRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelBBFlavorTasteRemarks" runat="server" AssociatedControlID="TXB_BBFlavorTaste_Remarks" Text="BB Flavor Taste (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BBFlavorTasteRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_BBFlavorTaste_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_BBFlavorTaste_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelBBMouthFeel" runat="server" AssociatedControlID="RBL_BBMouthFeel" Text="Broken Biscuit Mouth Feel :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BBMouthFeel" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_BBMouthFeel" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_BBMouthFeel" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleBBMouthFeelRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="BBMouthFeelRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelBBMouthFeelRemarks" runat="server" AssociatedControlID="TXB_BBMouthFeel_Remarks" Text="BB Mouth Feel (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BBMouthFeelRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_BBMouthFeel_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_BBMouthFeel_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelHvoSmell" runat="server" AssociatedControlID="RBL_HvoSmell" Text="HVO Smell :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_HvoSmell" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_HvoSmell" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_HvoSmell" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleHvoSmellRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="HvoSmellRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelHvoSmellRemarks" runat="server" AssociatedControlID="TXB_HvoSmell_Remarks" Text="HVO Smell (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_HvoSmellRemakrs" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_HvoSmell_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_HvoSmell_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelHvoTaste" runat="server" AssociatedControlID="RBL_HvoTaste" Text="HVO Taste :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_HvoTaste" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_HvoTaste" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_HvoTaste" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleHvoTasteRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="HvoTasteRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelHvoTasteRemarks" runat="server" AssociatedControlID="TXB_HvoTaste_Remarks" Text="HVO Taste (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_HvoTasteRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_HvoTaste_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_HvoTaste_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelHvoTemp" runat="server" AssociatedControlID="TB_HvoTemp" Text="HVO Temp :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_HvoTemp" runat="server" ErrorMessage="*" ValidationGroup="BasicSubmit" ControlToValidate="TB_HvoTemp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_HvoTemp" runat="server" ValidationGroup="BasicSubmit" ControlToValidate="TB_HvoTemp" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_HvoTemp" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="HVO Temp. "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-3" id="HvoTempRemarksDIV" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelHvoTempRemarks" runat="server" AssociatedControlID="TXB_HvoTemp_Remarks" Text="HVO Temp. Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_HvoTempRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_HvoTemp_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_HvoTemp_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSMPSmell" runat="server" AssociatedControlID="RBL_SMPSmell" Text="SMP Smell :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SMPSmell" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_SMPSmell" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_SMPSmell" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleSMPSmellRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="SMPSmellRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSMPSmellRemarks" runat="server" AssociatedControlID="TXB_SMPSmell_Remarks" Text="SMP Smell (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SMPSmell_Remarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_SMPSmell_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_SMPSmell_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSMPTaste" runat="server" AssociatedControlID="RBL_SMPTaste" Text="SMP Taste :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SMPTaste" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_SMPTaste" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_SMPTaste" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleSMPTasteRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="SMPTasteRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSMPTasteRemarks" runat="server" AssociatedControlID="TXB_SMPTaste_Remarks" Text="SMP Taste (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SMPTasteRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_SMPTaste_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_SMPTaste_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSMPColor" runat="server" AssociatedControlID="RBL_SMPColor" Text="SMP Color :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SMPColor" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_SMPColor" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_SMPColor" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleSMPColorRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="SMPColorRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSMPColor_Remarks" runat="server" AssociatedControlID="TXB_SMPColor_Remarks" Text="SMP Color Appearance (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TXB_SMPColorRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_SMPColor_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_SMPColor_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSyrupTemp" runat="server" AssociatedControlID="TB_HvoTemp" Text="Syrup Temp :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SyrupTemp" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_SyrupTemp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_SyrupTemp" runat="server" ValidationGroup="BasicSubmit" ControlToValidate="TB_SyrupTemp" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SyrupTemp" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="HVO Temp. "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-3" id="SyrupTempRemarksDIV" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSyrupTempRemarks" runat="server" AssociatedControlID="TXB_SyrupTemp_Remarks" Text="Syrup Temp. Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SyrupTempRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_SyrupTemp_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_SyrupTemp_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSyrupColor" runat="server" AssociatedControlID="RBL_SyrupColor" Text="Syrup Color :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SyrupColor" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_SyrupColor" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_SyrupColor" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleSyrupColorRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="SyrupColorRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSyrupColorRemarksDiv" runat="server" AssociatedControlID="TXB_SyrupColor_Remarks" Text="Syrup Color Appearance (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SyrupColorRemarksDiv" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_SyrupColor_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_SyrupColor_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_SyrupPH" runat="server" AssociatedControlID="TB_SyrupPH" Text="Syrup PH Value :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_SyrupPH" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_SyrupPH" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_SyrupPH" runat="server" ValidationGroup="BasicSubmit" ControlToValidate="TB_SyrupPH" ForeColor="Red" ErrorMessage="Decimal" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SyrupPH" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Syrup PH Value "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-3" id="SyrupPHRemarksDIV" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSyrupPHRemarks" runat="server" AssociatedControlID="TXB_SyrupPH_Remarks" Text=" Syrup PH Value Remarks:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SyrupPHRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_SyrupPH_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_SyrupPH_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelInvertSyrupBucket" runat="server" AssociatedControlID="RBL_InvertSyrupBucket" Text="Invert Syrup Bucket Filter Sieve :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_InvertSyrupBucket" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_InvertSyrupBucket" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_InvertSyrupBucket" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggleInvertSyrupBucketRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="N/A" Value="5"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="InvertSyrupBucketRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelInvertSyrupBucketRemarks" runat="server" AssociatedControlID="TXB_InvertSyrupBucket_Remarks" Text="Invert Syrup Bucket Filter Sieve Remarks (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_InvertSyrupBucketRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_InvertSyrupBucket_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_InvertSyrupBucket_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSugarSolBucket" runat="server" AssociatedControlID="RBL_SugarSolBucket" Text="Sugar Sol Bucket Filter Sieve :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SugarSolBucket" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_SugarSolBucket" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_SugarSolBucket" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggleSugarSolBucketRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="N/A" Value="5"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="SugarSolBucketRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSugarSolBucketRemarks" runat="server" AssociatedControlID="TXB_SugarSolBucket_Remarks" Text="Sugar Sol Bucket Filter Sieve Remarks (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SugarSolBucketRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_SugarSolBucket_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_SugarSolBucket_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelCreamerBucketFilter" runat="server" AssociatedControlID="RBL_CreamerBucketFilter" Text="Creamer Bucket Filter Sheet :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_CreamerBucketFilter" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_CreamerBucketFilter" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_CreamerBucketFilter" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggleCreamerBucketRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="N/A" Value="5"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="CreamerBucketRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label12" runat="server" AssociatedControlID="TXB_CreamerBucket_Remarks" Text="Creamer Bucket Filter Sheet Remarks (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_CreamerBucketRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_CreamerBucket_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_CreamerBucket_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSugarGrinder" runat="server" AssociatedControlID="RBL_SugarGrinder" Text="Sugar Grinder Sheet :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SugarGrinder" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_SugarGrinder" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_SugarGrinder" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggleSugarGrinderRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="N/A" Value="5"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="SugarGrinderRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelSugarGrinderRemarks" runat="server" AssociatedControlID="TXB_SugarGrinder_Remarks" Text="Sugar Grinder Sheet Remarks (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SugarGrinderRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_SugarGrinder_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_SugarGrinder_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelOilSystem" runat="server" AssociatedControlID="RBL_OilSystem" Text="Oil System Bucket Filter :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_OilSystem" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_OilSystem" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_OilSystem" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggleOilSystemRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="N/A" Value="5"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="OilSystemRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelOilSystemRemarks" runat="server" AssociatedControlID="TXB_OilSystem_Remarks" Text="Oil System Bucket Filter Remarks (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_OilSystemRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_OilSystem_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_OilSystem_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelOilSpray" runat="server" AssociatedControlID="RBL_OilSpray" Text="Oil Spray Seive :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_OilSpray" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_OilSpray" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_OilSpray" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggleOilSprayRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="N/A" Value="5"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="OilSprayRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelOilSprayRemarks" runat="server" AssociatedControlID="TXB_OilSpray_Remarks" Text="Oil Spray Seive Remarks (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_OilSprayRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_OilSpray_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_OilSpray_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelMilkSpray" runat="server" AssociatedControlID="RBL_MilkSpray" Text="Milk Spray Seive :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MilkSpray" runat="server" ValidationGroup="BasicSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_MilkSpray" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_MilkSpray" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggleMilkSprayRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                            <asp:ListItem Text="N/A" Value="5"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="MilkSprayRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label13" runat="server" AssociatedControlID="TXB_MilkSpray_Remarks" Text="Milk Spray Seive Remarks (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MilkSprayRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TXB_MilkSpray_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_MilkSpray_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelColdRoomTemp" runat="server" AssociatedControlID="TB_ColdRoomTemp" Text="Temp. Of Cold Rooom:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_ColdRoomTemp" runat="server" ErrorMessage="*" ValidationGroup="BasicSubmit" ControlToValidate="TB_ColdRoomTemp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_ColdRoomTemp" runat="server" ValidationGroup="BasicSubmit" ControlToValidate="TB_ColdRoomTemp" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_ColdRoomTemp" runat="server" CssClass="form-control form-control-sm rounded" Placeholder=" Temp. Of Cold Room "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-3" id="ColdRoomTempRemarksDIV" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelColdRoomTempRemarks" runat="server" AssociatedControlID="TXB_ColdRoomTemp_Remarks" Text="Cold Room Temp. Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_ColdRoomTempRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_ColdRoomTemp_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_ColdRoomTemp_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelDeepFreezeTemp" runat="server" AssociatedControlID="TB_ColdRoomTemp" Text="Temp. Of Deep Freeze:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DeepFreezeTemp" runat="server" ErrorMessage="*" ValidationGroup="BasicSubmit" ControlToValidate="TB_DeepFreezeTemp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DeepFreezeTemp" runat="server" ValidationGroup="BasicSubmit" ControlToValidate="TB_DeepFreezeTemp" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DeepFreezeTemp" runat="server" CssClass="form-control form-control-sm rounded" Placeholder=" Temp. Of Deep Freeze"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-3" id="DeepFreezeTempRemarksDIV" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label14" runat="server" AssociatedControlID="TXB_DeepFreezeTemp_Remarks" Text="Deep Freeze Temp. Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DeepFreezeTempRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="BasicSubmit" ControlToValidate="TXB_DeepFreezeTemp_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_DeepFreezeTemp_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <%--Image part--%>
                                                            <div class="col-md-3" id="FU_MaidaImage_Upldr" runat="server" visible="true">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_FU_MaidaImage" runat="server" AssociatedControlID="FU_MaidaImage" Text="Maida Appearance" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_FU_MaidaImage" runat="server" ErrorMessage="*" ControlToValidate="FU_MaidaImage" Display="Dynamic" ValidationGroup="ValidationGroup1" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:CustomValidator ID="CV_FU_MaidaImage" runat="server" ControlToValidate="FU_BBImage" Display="Dynamic" ValidationGroup="ValidationGroup1" ErrorMessage="Please upload file"></asp:CustomValidator>
                                                                    <asp:Label ID="lblErrorMessage2" runat="server" CssClass="text-danger"></asp:Label>
                                                                    <div class="input-group input-group-sm">
                                                                        <asp:FileUpload ID="FU_MaidaImage" runat="server" CssClass="form-control rounded" onchange="displayImage(this);" />
                                                                        <span class="input-group-btn">
                                                                            <asp:Button ID="BtnUploadFU_MaidaImage" runat="server" CssClass="btn btn-primary btn-sm" Text="Upload" OnClientClick="return validateForm1();" OnClick="BtnUploadFU_MaidaImage_Click" ValidationGroup="ValidationGroup1" CausesValidation="true" />
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="FU_MaidaImage_img" runat="server" visible="false">
                                                                <asp:Image ID="uploadedImage1" runat="server" CssClass="img-fluid" />
                                                            </div>

                                                            <div class="col-md-3" id="FU_BBImage_Upldr" runat="server" visible="true">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_FU_BBImage" runat="server" AssociatedControlID="FU_BBImage" Text="Broken Biscuit Appearance" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_FU_BBImage" runat="server" ErrorMessage="*" ControlToValidate="FU_BBImage" Display="Dynamic" ValidationGroup="ValidationGroup2" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:CustomValidator ID="CV_FU_BBImage" runat="server" ControlToValidate="FU_BBImage" Display="Dynamic" ValidationGroup="ValidationGroup2" ErrorMessage="Please upload file"></asp:CustomValidator>
                                                                    <asp:Label ID="lblErrorMessage1" runat="server" CssClass="text-danger"></asp:Label>
                                                                    <div class="input-group input-group-sm">
                                                                        <asp:FileUpload ID="FU_BBImage" runat="server" CssClass="form-control rounded" />
                                                                        <span class="input-group-btn">
                                                                            <asp:Button ID="BtnUploadFU_BBImage" runat="server" CssClass="btn btn-primary btn-sm" Text="Upload" OnClientClick="return validateForm2();" OnClick="BtnUploadFU_BBImage_Click" ValidationGroup="ValidationGroup2" CausesValidation="true" />
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="FU_BBImage_Img" runat="server" visible="false">
                                                                <asp:Image ID="uploadedImage2" runat="server" CssClass="img-fluid" />
                                                            </div>

                                                            <%--Button--%>
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_BasicbtnSubmit" runat="server" AssociatedControlID="BasicBtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group input-group-sm">
                                                                        <asp:Button ID="BasicBtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="BasicSubmit" CausesValidation="false" OnClick="BasicBtnSubmit_Click" />
                                                                        <asp:Button ID="BasicBtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BasicBtnReset_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>


                                                        </div>
                                                    </div>
                                                    <%-- Basic Data ends here--%>

                                                    <%--Raw Material Weight Data Starts Here--%>
                                                    <div class="tab-pane fade" id="rawMaterial" role="tabpanel" aria-labelledby="rawMaterial-tab">
                                                        <div class="x-content">


                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelMaidaBrandName" runat="server" AssociatedControlID="TB_MaidaBrandName" Text="Maida Brand Name :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MaidaBrandName" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_MaidaBrandName" ValidationGroup="RawSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_MaidaBrandName" runat="server" ControlToValidate="TB_MaidaBrandName" ForeColor="Red" ValidationGroup="RawSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_MaidaBrandName" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Maida Brand Name (3-20 characters)" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label48" runat="server" AssociatedControlID="TB_MaidaActWgt" Text="Maida :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MaidaActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_MaidaActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_MaidaActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_MaidaActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_MaidaActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Maida actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label49" runat="server" AssociatedControlID="TB_SugarActWgt" Text="Sugar :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SugarActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_SugarActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_SugarActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_SugarActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SugarActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Sugar actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label50" runat="server" AssociatedControlID="TB_ButterActWgt" Text="Butter :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_ButterActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_ButterActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_ButterActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_ButterActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_ButterActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Butter actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label51" runat="server" AssociatedControlID="TB_SMPActWgt" Text="S.M.P. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SMPActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_SMPActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_SMPActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_SMPActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SMPActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder=".M.P. actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label52" runat="server" AssociatedControlID="TB_PWActWgt" Text="Process Water :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_PWActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_PWActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_PWActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_PWActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_PWActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Process Water actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label53" runat="server" AssociatedControlID="TB_LecithinActWgt" Text="Lecithin :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_LecithinActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_LecithinActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_LecithinActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_LecithinActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_LecithinActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Lecithin actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label54" runat="server" AssociatedControlID="TB_GMSActWgt" Text="GMS Paste :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_GMSActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_GMSActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_GMSActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_GMSActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_GMSActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="GMS Paste actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label55" runat="server" AssociatedControlID="TB_SSLActWgt" Text="SSL Paste/ LS. Powder :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SSLActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_SSLActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_SSLActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_SSLActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SSLActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="SSL Paste/ LS. Powder actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label56" runat="server" AssociatedControlID="TB_GlucoseActWgt" Text="Glucose :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_GlucoseActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_GlucoseActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_GlucoseActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_GlucoseActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_GlucoseActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Glucose actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label57" runat="server" AssociatedControlID="TB_HVOActWgt" Text="HVO :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_HVOActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_HVOActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_HVOActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_HVOActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_HVOActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="HVO actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label58" runat="server" AssociatedControlID="TB_SyrupActWgt" Text="Syrup :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SyrupActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_SyrupActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_SyrupActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_SyrupActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SyrupActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Syrup actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label59" runat="server" AssociatedControlID="TB_MaltActWgt" Text="Malt :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MaltActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_MaltActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_MaltActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_MaltActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_MaltActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Malt actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label60" runat="server" AssociatedControlID="TB_BBActWgt" Text="Broken Biscuit :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BBActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_BBActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_BBActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_BBActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_BBActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Broken Biscuit actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label61" runat="server" AssociatedControlID="TB_ABCActWgt" Text="A.B.C. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_ABCActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_ABCActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_ABCActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_ABCActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_ABCActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="A.B.C. actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label62" runat="server" AssociatedControlID="TB_SBCActWgt" Text="S.B.C. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SBCActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_SBCActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_SBCActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_SBCActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SBCActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="S.B.C. actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label63" runat="server" AssociatedControlID="TB_SMBSActWgt" Text="S.M.B.S. :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SMBSActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_SMBSActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_SMBSActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_SMBSActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SMBSActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="S.M.B.S. actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label64" runat="server" AssociatedControlID="TB_WheyPowderActWgt" Text="Whey Powder :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_WheyPowderActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_WheyPowderActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_WheyPowderActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_WheyPowderActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_WheyPowderActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Whey Powder actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label65" runat="server" AssociatedControlID="TB_MilkActWgt" Text="Condence Milk :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MilkActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_MilkActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_MilkActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_MilkActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_MilkActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Condence Milk actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label66" runat="server" AssociatedControlID="TB_SaltActWgt" Text="Condence Milk :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_SaltActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_SaltActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_SaltActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_SaltActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_SaltActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Salt actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label67" runat="server" AssociatedControlID="TB_YeastActWgt" Text="Yeast (Smell & Wt) :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_YeastActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_YeastActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_YeastActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_YeastActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_YeastActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Yeast (Smell & Wt) actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label68" runat="server" AssociatedControlID="TB_E1ActWgt" Text="E1 :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_E1ActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_E1ActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_E1ActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_E1ActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_E1ActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="E1 actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label69" runat="server" AssociatedControlID="TB_CaramelActWgt" Text="Caramel :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_CaramelActWgt" runat="server" ErrorMessage="*" ValidationGroup="RawSubmit" ControlToValidate="TB_CaramelActWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_CaramelActWgt" runat="server" ValidationGroup="RawSubmit" ControlToValidate="TB_CaramelActWgt" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_CaramelActWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Caramel actual wgt "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <%--button--%>
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_RawBtnSubmit" runat="server" AssociatedControlID="RawBtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group input-group-sm">
                                                                        <asp:Button ID="RawBtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="RawSubmit" CausesValidation="true" OnClick="RawBtnSubmit_Click" />
                                                                        <asp:Button ID="RawBtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="RawBtnReset_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                    <%--Raw Material Weight Data Ends Here--%>

                                                    <%-- Weight Data Starts Here--%>
                                                    <div class="tab-pane fade" id="weight" role="tabpanel" aria-labelledby="weight-tab">
                                                        <div class="x-content">


                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label76" runat="server" AssociatedControlID="TB_MaidaBrandNames" Text="Maida Brand Name :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MaidaBrandNames" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_MaidaBrandNames" ValidationGroup="WeightSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_MaidaBrandNames" runat="server" ControlToValidate="TB_MaidaBrandNames" ForeColor="Red" ValidationGroup="WeightSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_MaidaBrandNames" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Maida Brand Name (3-20 characters)" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap">
                                                                <Columns>

                                                                    <asp:TemplateField HeaderText="Sl">
                                                                        <ItemTemplate>
                                                                            <%# Container.DataItemIndex + 1 %>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="Variety">
                                                                        <ItemTemplate>
                                                                            <span class="variety"><%# Eval("Variety") %></span>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>


                                                                    <asp:TemplateField HeaderText="Standard Weight">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtStandardWeight" runat="server" CssClass="standard-weight" ReadOnly="true" ClientIDMode="Static" Text='<%# Eval("StandardWeight") %>'></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="Actual Weight">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtActualWeight" runat="server" ClientIDMode="Static" onkeyup="calculateDeviation(this)"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="Deviation Weight">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtDeviation" runat="server" ClientIDMode="Static" CssClass="deviation-weight" ReadOnly="true"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                </Columns>
                                                            </asp:GridView>

                                                        </div>
                                                        <asp:Button ID="WgtbtnSubmit" runat="server" CssClass="btn btn-primary btn-sm" Text="Submit" OnClientClick="return validateGridView() && collectAndSendData();" OnClick="WgtbtnSubmit_Click" />
                                                        <asp:Button ID="WgtbtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="WgtbtnReset_Click" />

                                                    </div>

                                                    <%-- Weight ends Starts Here--%>

                                                    <%--Sponge Data Start Here--%>
                                                    <div class="tab-pane fade" id="spongeData" role="tabpanel" aria-labelledby="spongeData-tab">
                                                        <div class="x-content">


                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelRoomTemp" runat="server" AssociatedControlID="TB_RoomTemp" Text="Room Temp :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_RoomTemp" runat="server" ErrorMessage="*" ValidationGroup="SpongeSubmit" ControlToValidate="TB_RoomTemp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_RoomTemp" runat="server" ValidationGroup="SpongeSubmit" ControlToValidate="TB_RoomTemp" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_RoomTemp" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Room Temp. "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="RoomTempRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label15" runat="server" AssociatedControlID="TXB_RoomTemp_Remarks" Text="Room Temp. Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_RoomTempRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="SpongeSubmit" ControlToValidate="TXB_RoomTemp_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_RoomTemp_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelDrumCovered" runat="server" AssociatedControlID="RBL_DrumCovered" Text="Sponge Drum Covered :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DrumCovered" runat="server" ValidationGroup="SpongeSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_DrumCovered" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_DrumCovered" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleDrumCoveredRemarksDiv(this);">
                                                                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="DrumCoveredRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label16" runat="server" AssociatedControlID="TXB_DrumCovered_Remarks" Text="Sponge Drum Covered (No)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DrumCoveredRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="SpongeSubmit" ControlToValidate="TXB_DrumCovered_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_DrumCovered_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelQuality" runat="server" AssociatedControlID="RBL_Quality" Text="Quality :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Quality" runat="server" ValidationGroup="SpongeSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_Quality" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_Quality" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleQualityRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="QualityRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label17" runat="server" AssociatedControlID="TXB_Quality_Remarks" Text="Quality (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_QualityRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="SpongeSubmit" ControlToValidate="TXB_Quality_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_Quality_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelStandingTime" runat="server" AssociatedControlID="TB_StandingTime" Text="Time :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Time" runat="server" ErrorMessage="Standing Time is required " ControlToValidate="TB_StandingTime" ValidationGroup="SpongeSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_StandingTime" runat="server" ControlToValidate="TB_StandingTime" ForeColor="Red" ValidationGroup="SpongeSubmit" ErrorMessage="" Display="Dynamic" ValidationExpression=" "></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_StandingTime" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Time"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="StandingTimeRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label77" runat="server" AssociatedControlID="TXB_StandingTime_Remarks" Text="Standing Time Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_StandingTimeRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="SpongeSubmit" ControlToValidate="TXB_StandingTime_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_StandingTime_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelTemp" runat="server" AssociatedControlID="TB_Temp" Text="Temp :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Temp" runat="server" ErrorMessage="*" ValidationGroup="SpongeSubmit" ControlToValidate="TB_Temp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Temp" runat="server" ValidationGroup="SpongeSubmit" ControlToValidate="TB_Temp" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Temp" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Temp. "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="TempRemarksDIV" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label18" runat="server" AssociatedControlID="TXB_Temp_Remarks" Text="Temp. Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TempRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="SpongeSubmit" ControlToValidate="TXB_Temp_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_Temp_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_SpongeBtnSubmit" runat="server" AssociatedControlID="SpongeBtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group input-group-sm">
                                                                        <asp:Button ID="SpongeBtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="SpongeSubmit" CausesValidation="false" OnClick="SpongeBtnSubmit_Click" />
                                                                        <asp:Button ID="Spongebtn_Reset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="Spongebtn_Reset_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <%-- Sponge Data Ends Here--%>

                                                    <%--Dough Data Start Here--%>
                                                    <div class="tab-pane fade" id="doughData" role="tabpanel" aria-labelledby="doughData-tab">
                                                        <div class="x-content">


                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelDoughTemp" runat="server" AssociatedControlID="TB_DoughTemp" Text="Dough Temp :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DoughTemp" runat="server" ErrorMessage="*" ValidationGroup="DoughSubmit" ControlToValidate="TB_DoughTemp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DoughTemp" runat="server" ValidationGroup="DoughSubmit" ControlToValidate="TB_Temp" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DoughTemp" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Temp. "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="DoughTempRemarksDIV" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label19" runat="server" AssociatedControlID="TXB_DoughTemp_Remarks" Text="Dough Temp. Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DoughTempRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="DoughSubmit" ControlToValidate="TXB_DoughTemp_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_DoughTemp_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelDoughRestTime" runat="server" AssociatedControlID="TB_DoughRestTime" Text="Dough Rest Time :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DoughRestTime" runat="server" ErrorMessage="Dough Rest Time is required " ControlToValidate="TB_DoughRestTime" ValidationGroup="DoughSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DoughRestTime" runat="server" ControlToValidate="TB_DoughRestTime" ForeColor="Red" ValidationGroup="DoughSubmit" ErrorMessage="" Display="Dynamic" ValidationExpression=" "></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DoughRestTime" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Time"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="DoughRestTimeRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label70" runat="server" AssociatedControlID="TXB_DoughRestTime_Remarks" Text="Dough Remarks Temp . Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DoughRestTimeRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="DoughSubmit" ControlToValidate="TXB_DoughRestTime_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_DoughRestTime_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelMetalDectector" runat="server" AssociatedControlID="RBL_MetalDectector" Text="Metal Detector Condition :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MetalDectector" runat="server" ValidationGroup="DoughSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_MetalDectector" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_MetalDectector" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleMetalDetectorRemarksDiv(this);">
                                                                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="MetalDetectorRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label20" runat="server" AssociatedControlID="TXB_MetalDetector_Remarks" Text="Condition (No)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MetalDetectorRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="DoughSubmit" ControlToValidate="TXB_MetalDetector_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_MetalDetector_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelProcessSequence" runat="server" AssociatedControlID="RBL_ProcessSequence" Text="Process Sequence :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_ProcessSequence" runat="server" ValidationGroup="DoughSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_MetalDectector" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_ProcessSequence" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleProcessSequenceRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="ProcessSequenceRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label21" runat="server" AssociatedControlID="TXB_ProcessSequence_Remarks" Text="Process Sequence (NoT Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_ProcessSequenceRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="DoughSubmit" ControlToValidate="TXB_ProcessSequence_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_ProcessSequence_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelCreamingTime" runat="server" AssociatedControlID="TB_CreamingTime" Text="Creaming Time :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_CreamingTime" runat="server" ErrorMessage="Creaming Time is required " ControlToValidate="TB_CreamingTime" ValidationGroup="DoughSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_CreamingTime" runat="server" ControlToValidate="TB_CreamingTime" ForeColor="Red" ValidationGroup="DoughSubmit" ErrorMessage="" Display="Dynamic" ValidationExpression=" "></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_CreamingTime" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Time"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="CreamingTimeRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label71" runat="server" AssociatedControlID="TXB_CreamingTime_Remarks" Text="CreamingTime Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_CreamingTimeRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="DoughSubmit" ControlToValidate="TXB_CreamingTime_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_CreamingTime_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelMixingTime" runat="server" AssociatedControlID="TB_MixingTime" Text="Mixing Time :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MixingTime" runat="server" ErrorMessage="Mixing Time is required " ControlToValidate="TB_MixingTime" ValidationGroup="DoughSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_MixingTime" runat="server" ControlToValidate="TB_MixingTime" ForeColor="Red" ValidationGroup="DoughSubmit" ErrorMessage="" Display="Dynamic" ValidationExpression=" "></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_MixingTime" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Time"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="MixingTimeRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label72" runat="server" AssociatedControlID="TXB_MixingTime_Remarks" Text="Mixing Time Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_MixingTimeRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="DoughSubmit" ControlToValidate="TXB_MixingTime_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_MixingTime_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelBakingTime" runat="server" AssociatedControlID="TB_BakingTime" Text="Baking Time :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BakingTime" runat="server" ErrorMessage="Baking Time is required " ControlToValidate="TB_DoughRestTime" ValidationGroup="DoughSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_BakingTime" runat="server" ControlToValidate="TB_BakingTime" ForeColor="Red" ValidationGroup="DoughSubmit" ErrorMessage="" Display="Dynamic" ValidationExpression=" "></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_BakingTime" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Time"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="BakingTimeRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label73" runat="server" AssociatedControlID="TXB_BakingTime_Remarks" Text="Baking time Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BakingTimeRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="DoughSubmit" ControlToValidate="TXB_BakingTime_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_BakingTime_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelDiceRpm" runat="server" AssociatedControlID="TB_DoughTemp" Text="Dice RPM :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DiceRpm" runat="server" ErrorMessage="*" ValidationGroup="DoughSubmit" ControlToValidate="TB_DiceRpm" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DiceRpm" runat="server" ValidationGroup="DoughSubmit" ControlToValidate="TB_DiceRpm" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DiceRpm" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Dice Rmp "></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="DiceRpmRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label74" runat="server" AssociatedControlID="TXB_DiceRpm_Remarks" Text="Dice Rpm Remarks" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DiceRpmRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="DoughSubmit" ControlToValidate="TXB_DiceRpm_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_DiceRpm_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelDoughCondition" runat="server" AssociatedControlID="RBL_DoughCondition" Text="Condition Of Dough :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DoughCondition" runat="server" ValidationGroup="DoughSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_DoughCondition" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_DoughCondition" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleDoughConditionRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="DoughConditionRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label22" runat="server" AssociatedControlID="TXB_DoughCondition_Remarks" Text="Dough Condition (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DoughConditionRemarks" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="DoughSubmit" ControlToValidate="TXB_DoughCondition_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_DoughCondition_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="lbl_DoughBtnSubmit" runat="server" AssociatedControlID="DoughBtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group input-group-sm">
                                                                        <asp:Button ID="DoughBtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="DoughSubmit" CausesValidation="false" OnClick="DoughBtnSubmit_Click" />
                                                                        <asp:Button ID="DoughBtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="DoughBtnReset_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <%--Dough Data Ends Here--%>

                                                    <%--Oven Data Start Here--%>
                                                    <div class="tab-pane fade" id="ovenData" role="tabpanel" aria-labelledby="ovenData-tab">
                                                        <div class="x-content">


                                                            <div class="col-md-12">
                                                                <div class="md-3">
                                                                    <h2>---Oven Profile---</h2>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label23" runat="server" AssociatedControlID="TB_Zone1Top" Text="Zone 1 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone1Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone1Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Zone1Top" runat="server" ControlToValidate="TB_Zone1Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone1Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 1 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label11" runat="server" AssociatedControlID="TB_Zone1Bottom" Text="Zone 1 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone1Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone1Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Zone1Bottom" runat="server" ControlToValidate="TB_Zone1Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone1Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 1 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label24" runat="server" AssociatedControlID="TB_Zone2Top" Text="Zone 2 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone2Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone2Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Zone2Top" runat="server" ControlToValidate="TB_Zone2Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone2Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 2 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label25" runat="server" AssociatedControlID="TB_Zone2Bottom" Text="Zone 2 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone2Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone2Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Zone2Bottom" runat="server" ControlToValidate="TB_Zone2Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone2Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 2 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label26" runat="server" AssociatedControlID="TB_Zone3Top" Text="Zone 3 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone3Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone3Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Zone3Top" runat="server" ControlToValidate="TB_Zone3Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone3Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 3 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label27" runat="server" AssociatedControlID="TB_Zone3Bottom" Text="Zone 3 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone3Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone3Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Zone3Bottom" runat="server" ControlToValidate="TB_Zone3Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone3Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 3 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label28" runat="server" AssociatedControlID="TB_Zone4Top" Text="Zone 4 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone4Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone4Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Zone4Top" runat="server" ControlToValidate="TB_Zone4Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone4Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 4 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label29" runat="server" AssociatedControlID="TB_Zone4Bottom" Text="Zone 4 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone4Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone4Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Zone4Bottom" runat="server" ControlToValidate="TB_Zone4Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone4Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 4 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label30" runat="server" AssociatedControlID="TB_Zone5Top" Text="Zone 5 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone5Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone5Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Zone5Top" runat="server" ControlToValidate="TB_Zone5Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone5Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 5 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label31" runat="server" AssociatedControlID="TB_Zone5Bottom" Text="Zone 5 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone5Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone5Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="rev_Zone5Bottom" runat="server" ControlToValidate="TB_Zone5Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone5Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 5 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label32" runat="server" AssociatedControlID="TB_Zone6Top" Text="Zone 6 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone6Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone6Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Zone6Top" runat="server" ControlToValidate="TB_Zone6Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone6Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 6 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label33" runat="server" AssociatedControlID="TB_Zone6Bottom" Text="Zone 6 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_Zone6Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_Zone6Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_Zone6Bottom" runat="server" ControlToValidate="TB_Zone6Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_Zone6Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 6 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-12">
                                                                <div class="md-3">
                                                                    <h2>---Damper Position---</h2>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label34" runat="server" AssociatedControlID="TB_DPZone1Top" Text="Zone 1 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone1Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone1Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DPZone1Top" runat="server" ControlToValidate="TB_DPZone1Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone1Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 1 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label35" runat="server" AssociatedControlID="TB_DPZone1Bottom" Text="Zone 1 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone1Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone1Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DPZone1Bottom" runat="server" ControlToValidate="TB_DPZone1Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone1Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 1 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label36" runat="server" AssociatedControlID="TB_DPZone2Top" Text="Zone 2 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone2Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone2Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DPZone2Top" runat="server" ControlToValidate="TB_DPZone2Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone2Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 2 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label37" runat="server" AssociatedControlID="TB_DPZone2Bottom" Text="Zone 2 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone2Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone2Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DPZone2Bottom" runat="server" ControlToValidate="TB_DPZone2Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone2Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 2 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label38" runat="server" AssociatedControlID="TB_DPZone3Top" Text="Zone 3 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone3Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone3Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DPZone3Top" runat="server" ControlToValidate="TB_DPZone3Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone3Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 3 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label39" runat="server" AssociatedControlID="TB_DPZone3Bottom" Text="Zone 3 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone3Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone3Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DPZone3Bottom" runat="server" ControlToValidate="TB_DPZone3Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone3Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 3 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label40" runat="server" AssociatedControlID="TB_DPZone4Top" Text="Zone 4 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone4Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone4Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DPZone4Top" runat="server" ControlToValidate="TB_DPZone4Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone4Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 4 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label41" runat="server" AssociatedControlID="TB_DPZone4Bottom" Text="Zone 4 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone4Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone4Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DPZone4Bottom" runat="server" ControlToValidate="TB_DPZone4Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone4Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 4 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label42" runat="server" AssociatedControlID="TB_DPZone5Top" Text="Zone 5 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone5Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone5Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REVTDPZone5Top" runat="server" ControlToValidate="TB_DPZone5Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone5Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 5 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label43" runat="server" AssociatedControlID="TB_DPZone5Bottom" Text="Zone 5 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone5Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone5Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DPZone5Bottom" runat="server" ControlToValidate="TB_DPZone5Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone5Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 5 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label44" runat="server" AssociatedControlID="TB_DPZone6Top" Text="Zone 6 Top :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone6Top" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone6Top" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DPZone6Top" runat="server" ControlToValidate="TB_DPZone6Top" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone6Top" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 6 Top" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label45" runat="server" AssociatedControlID="TB_DPZone6Bottom" Text="Zone 6 Bottom :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DPZone6Bottom" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_DPZone6Bottom" ValidationGroup="OvenSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_DPZone6Bottom" runat="server" ControlToValidate="TB_DPZone6Bottom" ForeColor="Red" ValidationGroup="OvenSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_DPZone6Bottom" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Zone 6 Bottom" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_OvenBtnSubmit" runat="server" AssociatedControlID="OvenBtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group input-group-sm">
                                                                        <asp:Button ID="OvenBtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="OvenSubmit" CausesValidation="false" OnClick="OvenBtnSubmit_Click" />
                                                                        <asp:Button ID="OvenBtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="OvenBtnReset_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>


                                                        </div>
                                                    </div>
                                                    <%--Oven Data Ends Here--%>

                                                    <%--Verification Data Start Here--%>
                                                    <div class="tab-pane fade" id="verificationData" role="tabpanel" aria-labelledby="verificationData-tab">
                                                        <div class="x-content">

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label10" runat="server" AssociatedControlID="RBL_BalanceCondition" Text="Weighing Balance Condition :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BalanceCondition" runat="server" ValidationGroup="VerifiedSubmit" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_BalanceCondition" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:RadioButtonList ID="RBL_BalanceCondition" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleBalanceConditionRemarksDiv(this);">
                                                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3" id="BalanceConditionRemarksDiv" style="display: none;">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label46" runat="server" AssociatedControlID="TXB_BalanceCondition_Remarks" Text="Weighing Balance Condition (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_BalanceCondition_Remarks" runat="server" ErrorMessage="*" ValidationGroup="VerifiedSubmit" ForeColor="Red" ControlToValidate="TXB_BalanceCondition_Remarks" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TXB_BalanceCondition_Remarks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="LabelRawBiscuitWgt" runat="server" AssociatedControlID="TB_RawBiscuitWgt" Text="Raw Biscuit Weight:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_RawBiscuitWgt" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_RawBiscuitWgt" ValidationGroup="VerifiedSubmit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_RawBiscuitWgt" runat="server" ControlToValidate="TB_RawBiscuitWgt" ForeColor="Red" ValidationGroup="VerifiedSubmit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_RawBiscuitWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Raw Biscuit Wgt" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_FinalBtnSubmit" runat="server" AssociatedControlID="FinalBtnSubmit" Text="Click to Submit" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group input-group-sm">
                                                                        <asp:Button ID="FinalBtnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary btn-sm" ValidationGroup="VerifiedSubmit" CausesValidation="false" OnClick="FinalBtnSubmit_Click" />
                                                                        <asp:Button ID="FinalBtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="FinalBtnReset_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <%--Verification Data ends Here--%>
                                                </div>
                                            </div>
                                        </div>
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
