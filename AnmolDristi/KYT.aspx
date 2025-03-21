<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="KYT.aspx.cs" Inherits="AnmolDristi.KYT" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <style type="text/css">
        .remove-border {
            border: none !important;
        }

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
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>KYT REPORT</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Document No: KYT/01 | Date: 16/12/24 | Revision No: 01</h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">

                                <%--<!-- Worksite (DDL) -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblWorksite" runat="server" Text="Worksite:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:DropDownList ID="ddlWorksite" runat="server" CssClass="form-control form-control-sm rounded">
                                                <asp:ListItem Text="Select Worksite" Value="" Selected="True"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvWorksite" runat="server"
                                                ControlToValidate="ddlWorksite"
                                                InitialValue=""
                                                ErrorMessage="Please select a Worksite."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>--%>



                                <!-- Worksite -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblWorksite" runat="server" Text="Worksite:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtWorksite" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Worksite"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvWorksite" runat="server"
                                                ControlToValidate="txtWorksite"
                                                ErrorMessage="Worksite is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Department -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblDepartment" runat="server" Text="Department:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Department"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDepartment" runat="server"
                                                ControlToValidate="txtDepartment"
                                                ErrorMessage="Department is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <!-- Location -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblLocation" runat="server" Text="Location:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Location"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvLocation" runat="server"
                                                ControlToValidate="txtLocation"
                                                ErrorMessage="Please enter Location."
                                                ForeColor="Red"
                                                Display="Dynamic">
                </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <!-- Date -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblDate" runat="server" Text="Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Select Date" TextMode="Date"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDate" runat="server"
                                                ControlToValidate="txtDate"
                                                ErrorMessage="Please enter Date."
                                                ForeColor="Red"
                                                Display="Dynamic">
                </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <!-- JOB ID -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblJobID" runat="server" Text="Job ID:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtJobID" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Job ID"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvJobID" runat="server"
                                                ControlToValidate="txtJobID"
                                                ErrorMessage="Job ID is required."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>



                                <!-- Activity -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblActivity" runat="server" Text="Activity:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtActivity" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Activity"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvActivity" runat="server"
                                                ControlToValidate="txtActivity"
                                                ErrorMessage="Please enter Activity."
                                                ForeColor="Red"
                                                Display="Dynamic">
                </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>



                                <!-- SOP NO -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblSOPNo" runat="server" Text="SOP NO:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtSOPNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter SOP NO"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvSOPNo" runat="server"
                                                ControlToValidate="txtSOPNo"
                                                ErrorMessage="Please enter SOP NO."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revSOPNo" runat="server"
                                                ControlToValidate="txtSOPNo"
                                                ValidationExpression="^[a-zA-Z0-9]+$"
                                                ErrorMessage="SOP NO must be alphanumeric."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>



                                <!-- Vender -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblVender" runat="server" Text="Vender:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtVender" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Vender"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvVender" runat="server"
                                                ControlToValidate="txtVender"
                                                ErrorMessage="Please enter Vender."
                                                ForeColor="Red"
                                                Display="Dynamic">
                </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <!-- Sl. No. -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblSlNo" runat="server" Text="Sl. No.:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtSlNo" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Number" TextMode="Number"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvSlNo" runat="server"
                                                ControlToValidate="txtSlNo"
                                                ErrorMessage="Please enter Sl. No.."
                                                ForeColor="Red"
                                                Display="Dynamic">
                </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <!-- Hidden Hazards -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblHiddenHazards" runat="server" Text="Hidden Hazards:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtHiddenHazards" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Hidden Hazards"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvHiddenHazards" runat="server"
                                                ControlToValidate="txtHiddenHazards"
                                                ErrorMessage="Please enter Hidden Hazards."
                                                ForeColor="Red"
                                                Display="Dynamic">
                </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <!-- Consequence -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblConsequence" runat="server" Text="Consequence:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtConsequence" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Consequence"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvConsequence" runat="server"
                                                ControlToValidate="txtConsequence"
                                                ErrorMessage="Please enter Consequence."
                                                ForeColor="Red"
                                                Display="Dynamic">
                </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <!-- Counter Measures -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblCounterMeasures" runat="server" Text="Counter Measures:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:TextBox ID="txtCounterMeasures" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Enter Counter Measures"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvCounterMeasures" runat="server"
                                                ControlToValidate="txtCounterMeasures"
                                                ErrorMessage="Please enter Counter Measures."
                                                ForeColor="Red"
                                                Display="Dynamic">
                </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <!-- Priority (Dropdown instead of TextBox) -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblPriority" runat="server" Text="Priority:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-control form-control-sm rounded">
                                                <asp:ListItem Text="Select Priority" Value="" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="P1" Value="P1"></asp:ListItem>
                                                <asp:ListItem Text="P2" Value="P2"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvPriority" runat="server"
                                                ControlToValidate="ddlPriority"
                                                InitialValue=""
                                                ErrorMessage="Please select a Priority."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>


                                <!-- Photograph Upload -->
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <asp:Label ID="lblPhotograph" runat="server" Text="Upload Photograph:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        <div class="input-group-sm">
                                            <asp:FileUpload ID="fuPhotograph" runat="server" CssClass="form-control form-control-sm rounded" />
                                            <asp:RequiredFieldValidator ID="rfvPhotograph" runat="server"
                                                ControlToValidate="fuPhotograph"
                                                ErrorMessage="Please upload a photograph."
                                                ForeColor="Red"
                                                Display="Dynamic">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <!-- Submit Button -->
                                <%-- <div class="col-md-12 text-center">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit Report" CssClass="btn btn-primary" OnClick="SubmitKYTIncidentData_Click" />

                                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                                </div>--%>

                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <%--<asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>--%>
                                        <div class="input-group input-group-sm">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="SubmitKYTIncidentData_Click" />
                                            <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                                            <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                        </div>
                                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true" />

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


































