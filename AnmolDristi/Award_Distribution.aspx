<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Award_Distribution.aspx.cs" Inherits="AnmolDristi.Award_Distribution" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
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
    <asp:ScriptManager runat="server" EnablePageMethods="true" />

    <div class="right_col" role="main">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Award Distribution</h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">

                                <%-- <!-- Award Date -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblAwardDate" runat="server" Text="Award Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDateOfAwardDistribution" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" />
                                            <asp:RequiredFieldValidator ID="rfvAwardDate" runat="server" ControlToValidate="txtAwardDate" ErrorMessage="Award Date is required." ForeColor="Red" Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>--%>


                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblAwardDate" runat="server" Text="Award Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDateOfAwardDistribution" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" />
                                            <asp:RequiredFieldValidator ID="rfvAwardDate" runat="server" ControlToValidate="txtDateOfAwardDistribution" ErrorMessage="Award Date is required." ForeColor="Red" Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>


                                <!-- Event Name -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblEventName" runat="server" Text="Event Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtEventName" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Event Name" />
                                            <asp:RequiredFieldValidator ID="rfvEventName" runat="server" ControlToValidate="txtEventName" ErrorMessage="Event Name is required." ForeColor="Red" Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>

                                <!-- Employee ID -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblEmployeeID" runat="server" Text="Employee ID:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtEmployeeID" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Employee ID" />
                                            <asp:RequiredFieldValidator ID="rfvEmployeeID" runat="server" ControlToValidate="txtEmployeeID" ErrorMessage="Employee ID is required." ForeColor="Red" Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>

                                <!-- Employee Name -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblEmployeeName" runat="server" Text="Employee Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Employee Name" />
                                            <asp:RequiredFieldValidator ID="rfvEmployeeName" runat="server" ControlToValidate="txtEmployeeName" ErrorMessage="Employee Name is required." ForeColor="Red" Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>

                                <!-- Designation -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblDesignation" runat="server" Text="Designation:" ForeColor="Blue" Font-Bold="true" Font-Size="Small" />
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Designation" />
                                            <asp:RequiredFieldValidator ID="rfvDesignation" runat="server" ControlToValidate="txtDesignation" ErrorMessage="Designation is required." ForeColor="Red" Display="Dynamic" />
                                        </div>
                                    </div>
                                </div>


                                <!-- Award Category -->
                                <div class="col-md-6 col-sm-12">
                                    <div class="form-group">
                                        <asp:Label ID="lbl_awardcategory" runat="server" Text="Award Category:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:DropDownList ID="ddlAwardCategory" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true">
    <asp:ListItem Text="--Select Award Category--" Value="-1" />
</asp:DropDownList>

                                            <asp:RequiredFieldValidator ID="rfvAwardCategory" runat="server" ControlToValidate="ddlAwardCategory" InitialValue="-1" ErrorMessage="Select Award Category." ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <%--<!-- Placeholder for dynamic upload controls -->
<div class="col-md-6 col-sm-12">
    <div class="form-group">
        <asp:Label ID="lblUploadImages" runat="server" Text="Upload Images:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:PlaceHolder ID="phImageUploadControls" runat="server"></asp:PlaceHolder>
    </div>

    <!-- Add More / Remove Buttons -->
    <div class="form-group mt-3">
        <asp:Button ID="btnAddEmployee" runat="server" CssClass="btn btn-success btn-sm" Text="Add More" OnClick="btnAddEmployee_Click" />
        &nbsp;
        <asp:Button ID="btnRemoveEmployee" runat="server" CssClass="btn btn-danger btn-sm" Text="Remove" OnClick="btnRemoveEmployee_Click" />
    </div>
</div>--%>

                                <!-- Placeholder for dynamic upload controls -->
                                <div class="col-md-6 col-sm-12">
                                    <div class="form-group">
                                        <asp:Label ID="lblUploadImages" runat="server" Text="Upload Images:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <asp:PlaceHolder ID="phImageUploadControls" runat="server"></asp:PlaceHolder>
                                    </div>

                                    <!-- 🟡 Show uploaded file names -->
                                    <div class="form-group">
                                        <asp:Repeater ID="rptUploadedImages" runat="server">
                                            <ItemTemplate>
                                                <div class="mb-1 text-success">
                                                    <span><%# System.IO.Path.GetFileName(Container.DataItem.ToString()) %></span>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                    <!-- Add More / Remove Buttons -->
                                    <div class="form-group mt-3">
                                        <asp:Button ID="BtnAddEmployee" runat="server" CssClass="btn btn-success btn-sm" Text="Add More" OnClick="BtnAddEmployee_Click" />
                                        &nbsp;
        <asp:Button ID="BtnRemoveEmployee" runat="server" CssClass="btn btn-danger btn-sm" Text="Remove" OnClick="BtnRemoveEmployee_Click" />
                                    </div>
                                </div>


                                <script>
                                    function updateFileNameDisplay(inputElement) {
                                        const fileName = inputElement.files[0]?.name || "No file chosen";
                                        let span = inputElement.nextElementSibling;
                                        if (span && span.tagName.toLowerCase() === 'span') {
                                            span.textContent = fileName;
                                        }
                                    }

                                    function attachChangeEvent(input) {
                                        input.addEventListener('change', function () {
                                            updateFileNameDisplay(this);
                                        });
                                    }

                                    function initializeFileInputs() {
                                        const fileInputs = document.querySelectorAll('.file-upload');
                                        fileInputs.forEach(input => {
                                            if (!input.dataset.initialized) {
                                                attachChangeEvent(input);
                                                input.dataset.initialized = "true";
                                                // Add span if not already there
                                                if (!input.nextElementSibling || input.nextElementSibling.tagName.toLowerCase() !== 'span') {
                                                    const span = document.createElement('span');
                                                    span.className = 'text-info';
                                                    input.parentNode.insertBefore(span, input.nextSibling);
                                                }
                                            }
                                        });
                                    }

                                    document.addEventListener('DOMContentLoaded', initializeFileInputs);

                                    // Re-run initializer when "Add More" is clicked
                                    document.getElementById("btnAddMore")?.addEventListener('click', function () {
                                        setTimeout(initializeFileInputs, 100); // Delay to allow new inputs to appear
                                    });
                                </script>





                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group input-group-sm">
                                            <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
                                            <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                                            <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                        </div>
                                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true" />
                                    </div>
                                </div>



                            </div>
                            <!-- row -->
                        </div>
                        <!-- x_content -->
                    </div>
                    <!-- x_panel -->
                </div>
            </div>
        </div>
    </div>
</asp:Content>
