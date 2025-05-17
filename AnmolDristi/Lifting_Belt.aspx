<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Lifting_Belt.aspx.cs" Inherits="AnmolDristi.Lifting_Belt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        
        .custom-radio input[type="radio"] {
            display: none;
        }

        
        .custom-radio label {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 5px;
            margin: 4px 4px 0 0;
            border: 1px solid #ccc;
            cursor: pointer;
            font-size: 0.9rem;
            flex: 1 1 auto;
            text-align: center;
            transition: all 0.2s;
            background-color: #f8f9fa;
            color: #333;
        }

        
        .custom-radio input[type="radio"]:checked + label {
            color: #fff;
        }

        
        .custom-radio input[type="radio"]:checked[value="OK"] + label {
            background-color: #28a745; /* Green */
            border-color: #28a745;
        }

        .custom-radio input[type="radio"]:checked[value="NotOK"] + label {
            background-color: #dc3545; /* Red */
            border-color: #dc3545;
        }

        .custom-radio input[type="radio"]:checked[value="NA"] + label {
            background-color: #6c757d; /* Grey */
            border-color: #6c757d;
        }

        .custom-file-label {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .file-name-wrap {
            white-space: normal !important;
            word-break: break-word !important;
            overflow-wrap: break-word !important;
            display: block !important;
            width: 100% !important;
        }

        .is-invalid {
            border-color: red;
            background-color: #fff0f0;
        }
    </style>


    <script>
        document.addEventListener('DOMContentLoaded', function () {
            document.querySelectorAll('.custom-file-input').forEach(function (input) {
                input.addEventListener('change', function (e) {
                    var fileName = e.target.files[0]?.name || 'Choose file';
                    var label = e.target.nextElementSibling;
                    if (label) {
                        label.innerText = fileName;
                    }
                });
            });
        });




        document.addEventListener("DOMContentLoaded", function () {
            function updateVisibility(radio) {
                const container = radio.closest('.requirement-item');
                if (!container) return;

                const remarksPhoto = container.querySelectorAll('.remarks-photo-group');
                const note = container.querySelector('.note-group');

                switch (radio.value) {
                    case 'OK':
                        remarksPhoto.forEach(e => e.style.display = 'none');
                        if (note) note.style.display = '';
                        break;
                    case 'NotOK':
                        remarksPhoto.forEach(e => e.style.display = '');
                        if (note) note.style.display = 'none';
                        break;
                    case 'NA':
                        remarksPhoto.forEach(e => e.style.display = 'none');
                        if (note) note.style.display = 'none';
                        break;
                }
            }

            
            document.querySelectorAll('.result-selector input[type="radio"]').forEach(radio => {
                radio.addEventListener('change', function () {
                    updateVisibility(this);
                });

                
                if (radio.checked) {
                    updateVisibility(radio);
                }
            });
        });



        function ResetChecklistForm() {
            
            document.querySelectorAll('input[type="text"], input[type="date"], textarea').forEach(input => {
                input.value = '';
            });

            
            document.querySelectorAll('input[type="radio"]').forEach(radio => {
                if (radio.value === "OK") {
                    radio.checked = true;
                } else {
                    radio.checked = false;
                }
            });

            // Clear file inputs
            document.querySelectorAll('input[type="file"]').forEach(fileInput => {
                fileInput.value = '';
            });

            document.querySelectorAll('.custom-file-label').forEach(label => {
                label.textContent = 'Choose file';
            });

            document.querySelectorAll('label[id*="Img"]').forEach(lbl => {
                lbl.style.display = 'none';
            });

            document.querySelectorAll('.text-danger').forEach(msg => {
                msg.style.display = 'none';
            });

            
            document.querySelectorAll('textarea[id*="Note_text"]').forEach(note => {
                note.value = '';
            });

           
            document.querySelectorAll('input[type="checkbox"]').forEach(cb => {
                cb.checked = false;
            });
        }


        function validateChecklist(sender, args) {
            let isValid = true;

            document.querySelectorAll(".requirement-item").forEach(function (item) {
                const selectedResult = item.querySelector("input[type='radio']:checked");
                const remark = item.querySelector(".remark-input");

                if (selectedResult && selectedResult.value === "NotOK") {
                    const remarkText = remark ? remark.value.trim() : "";

                    if (remarkText === "") {
                        remark?.classList.add("is-invalid");
                        isValid = false;
                    } else {
                        remark?.classList.remove("is-invalid");
                    }
                } else {
                    remark?.classList.remove("is-invalid");
                }
            });

            args.IsValid = isValid;
        }





    </script>







</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5>LIFTING BELTS & WIRE ROPE SLING CHECKLIST</h5>
                </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>DOC/ATS/TSK/QMS/GC/013</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <div class="row mb-4">
                                <div class="col-md-4 col-sm-12 mb-3">
                                    <asp:Label for="txtDate" runat="server" class="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Date:</asp:Label>
                                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDate" runat="server"
                                        ControlToValidate="txtDate" ErrorMessage="Date is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                </div>

                                <div class="col-md-4 col-sm-12 mb-3">
                                    <asp:Label for="txtJobsite" runat="server" class="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">JobSite:</asp:Label>
                                    <asp:TextBox ID="txtJobsite" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvJobsite" runat="server" ControlToValidate="txtJobsite" ErrorMessage="JobSite is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                    <asp:HiddenField runat="server" ID="ChecklistId" />
                                </div>

                                <div class="col-md-4 col-sm-12 mb-3">
                                    <asp:Label for="txtJobID" runat="server" class="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">JobID:</asp:Label>
                                    <asp:TextBox ID="txtJobID" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvJobid" runat="server" ControlToValidate="txtJobID" ErrorMessage="JobID is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                </div>

                                <div class="col-md-4 col-sm-12 mb-3">
                                    <asp:Label for="txtJobDescription" runat="server" class="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">JobDescription:</asp:Label>
                                    <asp:TextBox ID="txtJobDescription" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvJobdesc" runat="server" ControlToValidate="txtJobDescription" ErrorMessage="JobDescription is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                </div>
                            </div>





                            <asp:Repeater ID="DictionaryRepeater" runat="server">
                                <ItemTemplate>
                                    <div class="card mb-4 shadow-sm">
                                        <div class="card-header d-flex justify-content-between align-items-center bg-primary text-white">
                                            <h6 class="mb-0">
                                                <asp:Label ID="Grp_detail" runat="server" Text='<%# Eval("GroupName") %>' />
                                            </h6>
                                            <a class="text-white text-decoration-none collapsed ml-auto" data-toggle="collapse"
                                                href='<%# "#collapse" + Container.ItemIndex %>' role="button"
                                                aria-expanded="false" aria-controls='<%# "collapse" + Container.ItemIndex %>'>
                                                <i class="fa fa-chevron-down collapse-toggle-icon"></i>
                                            </a>
                                        </div>

                                        <div id='<%# "collapse" + Container.ItemIndex %>' class="collapse card-body">
                                            <asp:Repeater ID="ChildRepeater" runat="server" DataSource='<%# Bind("Keys") %>' OnItemDataBound="ChildRepeater_ItemDataBound1">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="ChecklistInfoId" Value='<%# Eval("ChecklistInfoId") %>' />
                                                   

                                                    <div class="row requirement-item mb-4 p-3 border rounded bg-light">
                                                        <!-- First Row: Serial + Requirement -->
                                                        <div class="col-12 mb-2">
                                                            <asp:Label CssClass="form-label me-2" runat="server" Text='<%# Eval("Serial")+"." %>' ForeColor="Black" Font-Size="Medium" />
                                                            <asp:Label ID="Requirement" CssClass="form-label" runat="server" Text='<%# Bind("Requirement") %>' ForeColor="Blue" Font-Bold="true" Font-Size="Medium" />
                                                        </div>

                                                        <!-- Second Row: 3 Columns (Observation, Remarks, Photo) -->
                                                        <div class="col-12">
                                                            <div class="row g-3">
                                                                <!-- Add spacing between cols -->
                                                                <!-- Column 1: Observation -->
                                                                <div class="col-md-4">
                                                                    <asp:Label runat="server" CssClass="form-label d-block" Text="Observation" ForeColor="Black" Font-Size="Small" />
                                                                    <asp:RadioButtonList ID="result" runat="server"
                                                                        RepeatDirection="Horizontal"
                                                                        RepeatLayout="Flow"
                                                                        CssClass="btn-group d-flex flex-wrap custom-radio result-selector"
                                                                        AutoPostBack="false">
                                                                        <asp:ListItem Text="OK" Value="OK" Selected="True" />
                                                                        <asp:ListItem Text="Not OK" Value="NotOK" />
                                                                        <asp:ListItem Text="NA" Value="NA" />
                                                                    </asp:RadioButtonList>
                                                                </div>

                                                                <!-- Column 2: Remarks -->
                                                                <div class="col-md-4 remarks-photo-group">
                                                                    <label class="form-label text-dark">Remarks:</label>
                                                                    <asp:TextBox ID="Remark_text" runat="server" CssClass="form-control remark-input" TextMode="MultiLine" Rows="2" />
                                                                    <asp:CustomValidator ID="cvChecklist" runat="server" ControlToValidate="Remark_text" 
                                                                        ClientValidationFunction="validateChecklist"
                                                                        ErrorMessage="Remark is required."
                                                                        CssClass="text-danger"
                                                                        Display="Dynamic"
                                                                        ValidateEmptyText="true"
                                                                        ValidationGroup="save" />
                                                                </div>

                                                                <div class="col-md-4 remarks-photo-group">
                                                                    <label class="form-label d-block text-dark">Before Photo:</label>

                                                                    <div class="custom-file w-100">
                                                                        <asp:FileUpload ID="Before_pic" runat="server" CssClass="custom-file-input" />
                                                                        <label class="custom-file-label" for="Before_pic">Choose file</label>
                                                                    </div>

                                                                    <asp:Label ID="Img" CssClass="d-block mt-2 text-muted" runat="server" Visible="false" />
                                                                </div>




                                                            </div>
                                                        </div>

                                                        <div class="col-12 mt-3 note-group">
                                                            <label class="form-label fw-semibold text-dark">Note:</label>
                                                            <asp:TextBox ID="Note_text" runat="server" CssClass="form-control rounded-end" TextMode="MultiLine" Rows="3" placeholder="Enter any additional notes..." />
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>


                            <div class="row mb-4">

                                <div class="col-md-4 col-sm-12 mb-3">
                                    <asp:Label for="txtCheckedBy" runat="server" class="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Checked By:</asp:Label>
                                    <asp:TextBox ID="txtCheckedBy" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCheckedBy" runat="server" ControlToValidate="txtCheckedBy" ErrorMessage="Checked By is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                </div>

                                <div class="col-md-4 col-sm-12 mb-3">
                                    <asp:Label for="txtApprovedBy" runat="server" class="form-label text-black" ForeColor="Blue" Font-Bold="true" Font-Size="Small">Approved By:</asp:Label>
                                    <asp:TextBox ID="txtApprovedBy" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvApprovedBy" runat="server" ControlToValidate="txtApprovedBy" ErrorMessage="Approved By is required" CssClass="text-danger" Display="Dynamic" ValidationGroup="save" />
                                </div>
                            </div>


                            <div class="text-center mt-4">
                                <asp:Button ID="submit" runat="server" Text="Submit" OnClick="submit_Click" CssClass="btn btn-success px-4 py-2" ValidationGroup="save" />
                                <asp:Button ID="reset" runat="server" Text="Reset" CssClass="btn btn-secondary px-4 py-2" OnClientClick="ResetChecklistForm(); return false;" />
                                <asp:Button runat="server" ID="home" Text="Home" CssClass="btn btn-primary px-4 py-2" OnClick="home_Click" />
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
