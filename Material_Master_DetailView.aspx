<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Material_Master_DetailView.aspx.cs" Inherits="AnmolDristi.Material_Master_DetailView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .remove-border {
            border: none !important; /* This will ensure the border is removed */
            /* Add any other necessary styling */
        }

        .white-background-readonly {
            background-color: white !important;
            color: black !important;
            cursor: default;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hdf_id" runat="server" />
    <script type="text/javascript">

        

        let olddate = "";

        function enableCal(TB_PurchaseDate) {
            if (!olddate) {
                olddate = TB_PurchaseDate.value;
            }
            TB_PurchaseDate.type = 'date';
        }

        function enableCal(TB_EndLife) {
            if (!olddate) {
                olddate = TB_EndLife.value;
            }
            TB_EndLife.type = 'date';
        }

        function enableCal(TB_ShelfLife) {
            if (!olddate) {
                olddate = TB_ShelfLife.value;
            }
            TB_ShelfLife.type = 'date';
        }

        function enableCal(TB_WarrantyDate) {
            if (!olddate) {
                olddate = TB_WarrantyDate.value;
            }
            TB_WarrantyDate.type = 'date';
        }

        function enableCal(TB_Installation) {
            if (!olddate) {
                olddate = TB_Installation.value;
            }
            TB_Installation.type = 'date';
        }

        function enableCal(TB_LastMaintenance) {
            if (!olddate) {
                olddate = TB_LastMaintenance;
            }
            TB_LastMaintenance = 'date';
        }

        function enableCal(TB_CalibrationDate) {
            if (!olddate) {
                olddate = TB_CalibrationDate.value;
            }
            TB_CalibrationDate.type = 'date';
        }

        function enableCal(TB_DueDate) {
            if (!olddate) {
                olddate = TB_DueDate.value;
            }
            TB_DueDate.type = 'date';
        }

        function enableCal(TB_FitnessCertificationDate) {
            if (!olddate) {
                olddate = TB_FitnessCertificationDate.value;
            }
            TB_FitnessCertificationDate.type = 'date';
        }

        function enableCal(TB_FitnessDueDate) {
            if (!olddate) {
                olddate = TB_FitnessDueDate.value;
            }
            TB_FitnessDueDate.type = 'date';
        }



    </script>

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>
                        <asp:Label ID="lbl_docname" runat="server" Text="Material Master View Page"></asp:Label>
                    </h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docnumber" runat="server" Text="Detailed View"></asp:Label>
                            </h2>
                            <div class="clearfix"></div>
                        </div>

                        <%--form start--%>
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="x-content">

                                                    <div class="col-md-3" id="MaterialTypeDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_DDL_MaterialType" runat="server" AssociatedControlID="DDL_MaterialType" Text="Material Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:DropDownList ID="DDL_MaterialType" runat="server" ReadOnly="true" Enabled="false" CssClass="form-control form-control-sm rounded white-background-readonly"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="ModelDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_ModelNo" runat="server" AssociatedControlID="TB_ModelNo" Text="Model Number :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_ModelNo" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("ModelNumber") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="MaterialBrandDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_MaterialBrand" runat="server" AssociatedControlID="TB_MaterialBrand" Text="Material Brand :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_MaterialBrand" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("MaterialBrand") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="FriendlyDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_FriendlyName" runat="server" AssociatedControlID="TB_FriendlyName" Text="Friendly Name:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_FriendlyName" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("FriendlyName") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="SeriallDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_SerialNo" runat="server" AssociatedControlID="TB_SerialNo" Text="Serial Number :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_SerialNo" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("SerialNumber") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="MfgDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_Mfg" runat="server" AssociatedControlID="TB_Mfg" Text="Manufacturing/MakeYear" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_Mfg" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("ManufacturingOrMakeYear") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="PrintedRateDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_PrintedRate" runat="server" AssociatedControlID="TB_PrintedRate" Text="PrintedRate" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_PrintedRate" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("PrintedRate") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="PurchaseRateDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_PurchaseRate" runat="server" AssociatedControlID="TB_PurchaseRate" Text="Purchase Rate" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_PurchaseRate" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("PurchaseRate") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="PurchaseDateDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_PurchaseDate" runat="server" AssociatedControlID="TB_PurchaseDate" Text="Purchase Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_PurchaseDate" runat="server" CssClass="date-picker form-control form-control-sm rounded white-background-readonly" required="required" onclick="enableCal(this);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="ClassificationDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_DDL_Classification" runat="server" AssociatedControlID="DDL_Classification" Text="Material Classification" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:DropDownList ID="DDL_Classification" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="StatusDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_DDL_Status" runat="server" AssociatedControlID="DDL_Status" Text="Operational Status" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:DropDownList ID="DDL_Status" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="DescriptionDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_Description" runat="server" AssociatedControlID="TB_Description" Text="Material Description:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_Description" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("MaterialDescription") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="PurchaseOrderDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_PurchaseOrderNo" runat="server" AssociatedControlID="TB_PurchaseOrderNo" Text="Purchase Order Number :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_PurchaseOrderNo" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("PurchaseOrderNo") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="EndLifeDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_EndLife" runat="server" AssociatedControlID="TB_EndLife" Text="End Of Life Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_EndLife" runat="server" CssClass="date-picker form-control form-control-sm rounded white-background-readonly" required="required" onclick="enableCal(this);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="FrenquencyDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_DDL_MaintenanceFrequency" runat="server" AssociatedControlID="DDL_MaintenanceFrequency" Text="Maintenance Frequency" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:DropDownList ID="DDL_MaintenanceFrequency" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="ReorderDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_ReoderLevel" runat="server" AssociatedControlID="TB_ReoderLevel" Text="Reoder Level" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_ReoderLevel" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("ReorderLevel") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="ShelfLifeDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_ShelfLife" runat="server" AssociatedControlID="TB_ShelfLife" Text="Shelf Life Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_ShelfLife" runat="server" CssClass="date-picker form-control form-control-sm rounded white-background-readonly" required="required" onclick="enableCal(this);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="WarrantyDateDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_WarrantyDate" runat="server" AssociatedControlID="TB_WarrantyDate" Text="Warranty End Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_WarrantyDate" runat="server" CssClass="date-picker form-control form-control-sm rounded white-background-readonly" required="required" onclick="enableCal(this);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="InstallationDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_Installation" runat="server" AssociatedControlID="TB_Installation" Text="Installation Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_Installation" runat="server" CssClass="date-picker form-control form-control-sm rounded white-background-readonly" required="required" onclick="enableCal(this);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="MaintenanceDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="LblTB_LastMaintenance" runat="server" AssociatedControlID="TB_Installation" Text=" Last Maintenance Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_LastMaintenance" runat="server" CssClass="date-picker form-control form-control-sm rounded white-background-readonly" required="required" onclick="enableCal(this);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="QuantityDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_OpeningStockQuantity" runat="server" AssociatedControlID="TB_OpeningStockQuantity" Text="Opening Stock Quantity" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_OpeningStockQuantity" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" Text='<%#  Eval("OpeningStockQuantity") %>'></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="UnitMeasureDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_DDL_UnitOfMeasure" runat="server" AssociatedControlID="DDL_UnitOfMeasure" Text="Unit Of Measure " ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:DropDownList ID="DDL_UnitOfMeasure" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="CalibrationDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_CalibrationDate" runat="server" AssociatedControlID="TB_CalibrationDate" Text="Calibration Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_CalibrationDate" runat="server" CssClass="date-picker form-control form-control-sm rounded white-background-readonly" required="required" onclick="enableCal(this);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="TenureDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_DDL_Tenure" runat="server" AssociatedControlID="DDL_Tenure" Text="Calibration Tenure " ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:DropDownList ID="DDL_Tenure" runat="server" CssClass="form-control form-control-sm rounded white-background-readonly" AutoPostBack="true" OnSelectedIndexChanged="DDL_Tenure_SelectedIndexChanged"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="DueDateDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_DueDate" runat="server" AssociatedControlID="TB_DueDate" Text="Due Date:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_DueDate" runat="server" CssClass="date-picker form-control form-control-sm rounded white-background-readonly" required="required" onclick="enableCal(this);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="FitnessCertificateDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_FitnessCertificationDate" runat="server" AssociatedControlID="TB_FitnessCertificationDate" Text="Fitness Certification Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_FitnessCertificationDate" runat="server" CssClass="date-picker form-control form-control-sm rounded white-background-readonly" required="required" onclick="enableCal(this);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-3" id="FitnessDueDateDIV" runat="server">
                                                        <div class="mb-3">
                                                            <asp:Label ID="Lbl_TB_FitnessDueDate" runat="server" AssociatedControlID="TB_FitnessDueDate" Text="Fitness Due Date :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            <div class="input-group-sm">
                                                                <asp:TextBox ID="TB_FitnessDueDate" runat="server" CssClass="date-picker form-control form-control-sm rounded white-background-readonly" required="required" onclick="enableCal(this);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <%--For view mode --%>
                                                    <div class="col-md-3" id="FU_FitnessDocImage_img" runat="server">
                                                        <asp:Label ID="Lbl_FU_FitnessDocImage" runat="server" Text="Fitness Document Image" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                        <asp:Image ID="imgFitnessDocument" runat="server" ImageUrl='<%# Eval("FitnessDocument") != null ? ResolveUrl(Eval("FitnessDocument").ToString()) : "~/Images/placeholder.jpg" %>' AlternateText="Fitness Document Image" Width="100px" Height="100px" />
                                                    </div>

                                                </div>

                                                <%--Button--%>
                                                <div class="col-md-3">
                                                    <div class="mb-3">
                                                        <asp:Label ID="Lbl_Basicbtn" runat="server" AssociatedControlID="" Text="Click on your ACTION" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                        <div class="input-group input-group-sm">
                                                            <asp:Button ID="Update" runat="server" Text="Update" CssClass="btn btn-warning btn-sm" CausesValidation="true" OnClick="Update_Click" />
                                                            <asp:Button ID="Back" runat="server" Text="Back" CssClass="btn btn-info btn-sm" CausesValidation="false" OnClick="Back_Click" />
                                                            <asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="btn btn-sm btn-danger" CausesValidation="false" OnClick="Cancel_Click" />
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- form end--%>
                    </div>
                </div>
            </div>

        </div>
    </div>


</asp:Content>
