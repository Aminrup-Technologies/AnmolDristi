<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_inspector_rpt.aspx.cs" Inherits="AnmolDristi.qaqc.qaqc_inspector_rpt" %>

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
        function toggleRemarksDiv(radioButtonList) {
            console.log("showTextbox function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("FlavTxt_RemarksDIV");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
        }

        function toggleSpSzRemarksDiv(radioButtonList) {
            console.log("toggleSpSzRemarksDiv function called");
            var selectedValue = radioButtonList.querySelector("input:checked").value;
            var remarksDiv = document.getElementById("SpSz_RemarksDIV");
            console.log("Selected value: " + selectedValue);
            if (selectedValue === "0") {
                remarksDiv.style.display = "block";
            } else {
                remarksDiv.style.display = "none";
            }
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

                        <div class="x_content">

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="DDL_Plant" Text="Plant Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded">
                                            <asp:ListItem Text="Dankuni">Dankuni</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="DDL_Plant" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>

                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="DDL_PlantLine" Text="Select Line" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_PlantLine" runat="server" CssClass="form-control form-control-sm rounded">
                                            <asp:ListItem Text="Line-4">Line-4</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="DDL_PlantLine" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label3" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Select Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded">
                                            <asp:ListItem Text="Line-4">Line-4</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="DDL_ProductCategory" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Select Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded">
                                            <asp:ListItem Text="Line-4">Line-4</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="DDL_ProductBrand" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_NoOfPcs" runat="server" AssociatedControlID="TB_NoOfPcs" Text="No of Pcs :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_NoOfPcs" runat="server" ErrorMessage="*" ControlToValidate="TB_NoOfPcs" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_NoOfPcs" runat="server" ControlToValidate="TB_NoOfPcs" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_NoOfPcs" runat="server" ControlToValidate="TB_NoOfPcs" ErrorMessage="[30 - 40]" ForeColor="Red" MinimumValue="30" MaximumValue="40" Type="Integer" Display="Static"></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_NoOfPcs" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Number of Pieces [30 - 40]"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_GaugeVal" runat="server" AssociatedControlID="TB_GaugeVal" Text="Gauge Value :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_GaugeVal" runat="server" ErrorMessage="*" ControlToValidate="TB_GaugeVal" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_GaugeVal" runat="server" ControlToValidate="TB_GaugeVal" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_GaugeVal" runat="server" ControlToValidate="TB_GaugeVal" ErrorMessage="[0.00 - 100.00]" ForeColor="Red" MinimumValue="0.00" MaximumValue="100.00" Type="Double" Display="Dynamic"></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_GaugeVal" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Gauge Value [0.00 - 100.00]"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_DryWeight" runat="server" AssociatedControlID="TB_DryWeight" Text="Dry Weight :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_DryWeight" runat="server" ErrorMessage="*" ControlToValidate="TB_DryWeight" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_DryWeight" runat="server" ControlToValidate="TB_DryWeight" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_DryWeight" runat="server" ControlToValidate="TB_DryWeight" ErrorMessage="[0.00 - 1000.00]" ForeColor="Red" MinimumValue="0.00" MaximumValue="1000.00" Type="Double" Display="Dynamic"></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_DryWeight" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Dry Weight [0.00 - 1000.00]"></asp:TextBox>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_DippedWeight" runat="server" AssociatedControlID="TB_DippedWeight" Text="Dipped Weight :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_DippedWeight" runat="server" ErrorMessage="*" InitialValue="" ControlToValidate="TB_DippedWeight" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_DippedWeight" runat="server" ControlToValidate="TB_DippedWeight" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_DippedWeight" runat="server" ControlToValidate="TB_DippedWeight" ErrorMessage="[0.00 - 1000.00]" ForeColor="Red" MinimumValue="0.00" MaximumValue="1000.00" Type="Double" Display="Dynamic"></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_DippedWeight" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Dipped Weight [0.00 - 1000.00]"></asp:TextBox>
                                    </div>
                                </div>
                            </div>



                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_VartyPkt" runat="server" AssociatedControlID="TB_VartyPkt" Text="Variety Packet / LOT No :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_VartyPkt" runat="server" ErrorMessage="*" ControlToValidate="TB_VartyPkt" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_VartyPkt" runat="server" ControlToValidate="TB_VartyPkt" ForeColor="Red" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_VartyPkt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Variety Packet (3-20 characters)" MaxLength="20"></asp:TextBox>
                                    </div>
                                </div>
                            </div>




                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_BakingTime" runat="server" AssociatedControlID="TB_BakingTime" Text="Baking Time (minutes) :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_BakingTime" runat="server" ErrorMessage="*" ControlToValidate="TB_BakingTime" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_BakingTime" runat="server" ControlToValidate="TB_BakingTime" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="^\d+$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_BakingTime" runat="server" ControlToValidate="TB_BakingTime" ErrorMessage="Baking time [5 to 120]" ForeColor="Red" MinimumValue="5" MaximumValue="120" Type="Integer" Display="Dynamic"></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_BakingTime" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Baking Time (5-120 minutes)"></asp:TextBox>
                                    </div>
                                </div>
                            </div>




                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label11" runat="server" AssociatedControlID="RBL_FlavTst" Text="Flavour & Taste :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_FlavTst" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:RadioButtonList ID="RBL_FlavTst" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleRemarksDiv(this);">
                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>

                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3" id="FlavTxt_RemarksDIV" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="Label12" runat="server" AssociatedControlID="TXB_RBL_FlavTst_Rmrks" Text="Flavour & Taste (Not Ok)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TXB_RBL_FlavTst_Rmrks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="DDL_PlantLine" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label13" runat="server" AssociatedControlID="RBL_SpSz" Text="Shape & Size" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="RBL_SpSz" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:RadioButtonList ID="RBL_SpSz" runat="server" CssClass="form-control form-control-sm rounded remove-border" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="2" Width="100%" onchange="toggleSpSzRemarksDiv(this);">
                                            <asp:ListItem Text="Ok" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Not Ok" Value="0"></asp:ListItem>
                                        </asp:RadioButtonList>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="SpSz_RemarksDIV" style="display: none;">
                                <div class="mb-3">
                                    <asp:Label ID="Label14" runat="server" AssociatedControlID="TB_RBL_SpSz_Rmrks" Text="Shape & Size (Not OK)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_RBL_SpSz_Rmrks" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RFV_TB_RBL_SpSz_Rmrks" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="TextBox8" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_TextureBite" runat="server" AssociatedControlID="TB_TextureBite" Text="Texture Bite :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_TextureBite" runat="server" ErrorMessage="*" ControlToValidate="TB_TextureBite" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_TextureBite" runat="server" ControlToValidate="TB_TextureBite" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_TextureBite" runat="server" ControlToValidate="TB_TextureBite" ErrorMessage="Texture bite should be between 0.00 and 10.00" ForeColor="Red" MinimumValue="0.00" MaximumValue="10.00" Type="Double" Display="Dynamic"></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_TextureBite" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Texture Bite (0.00-10.00)"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_Moisture" runat="server" AssociatedControlID="TB_Moisture" Text="Moisture (%):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Moisture" runat="server" ErrorMessage="*" ControlToValidate="TB_Moisture" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_Moisture" runat="server" ControlToValidate="TB_Moisture" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_Moisture" runat="server" ControlToValidate="TB_Moisture" ErrorMessage="Moisture should be between 0.00% and 100.00%" ForeColor="Red" MinimumValue="0.00" MaximumValue="100.00" Type="Double" Display="Dynamic"></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Moisture" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Moisture (0.00% - 100.00%)"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_wgtwtoil" runat="server" AssociatedControlID="TB_wgtwtoil" Text="Weight with oil (g):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_wgtwtoil" runat="server" ErrorMessage="*" ControlToValidate="TB_wgtwtoil" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_wgtwtoil" runat="server" ControlToValidate="TB_wgtwtoil" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_wgtwtoil" runat="server" ControlToValidate="TB_wgtwtoil" ErrorMessage="Weight with oil should be between 0.00 and 100.00 kg" ForeColor="Red" MinimumValue="0.00" MaximumValue="1000.00" Type="Double" Display="Dynamic"></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_wgtwtoil" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Weight with oil (0.00 - 100.00 g)"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_wgtwoil" runat="server" AssociatedControlID="TB_wgtwoil" Text="Weight without oil (g):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_wgtwoil" runat="server" ErrorMessage="*" ControlToValidate="TB_wgtwoil" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_wgtwoil" runat="server" ControlToValidate="TB_wgtwoil" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_wgtwoil" runat="server" ControlToValidate="TB_wgtwoil" ErrorMessage="Weight without oil should be between 0.00 and 1000.00 g" ForeColor="Red" MinimumValue="0.00" MaximumValue="1000.00" Type="Double" Display="Dynamic"></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_wgtwoil" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Weight without oil (0.00 - 1000.00 g)"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_oilpercent" runat="server" AssociatedControlID="TB_oilpercent" Text="Oil Percentage (%):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_oilpercent" runat="server" ErrorMessage="*" ControlToValidate="TB_oilpercent" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_oilpercent" runat="server" ControlToValidate="TB_oilpercent" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_oilpercent" runat="server" ControlToValidate="TB_oilpercent" ErrorMessage="Oil percentage should be between 0.00% and 100.00%" ForeColor="Red" MinimumValue="0.00" MaximumValue="100.00" Type="Double" Display="Dynamic"></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_oilpercent" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Oil Percentage (0.00% - 100.00%)"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_TB_PktWgt" runat="server" AssociatedControlID="TB_PktWgt" Text="Packet Weight (g):" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_PktWgt" runat="server" ErrorMessage="*" ControlToValidate="TB_PktWgt" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_TB_PktWgt" runat="server" ControlToValidate="TB_PktWgt" ForeColor="Red" ErrorMessage="Decimal Only" ValidationExpression="\d+(\.\d{1,2})?" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:RangeValidator ID="RV_TB_PktWgt" runat="server" ControlToValidate="TB_PktWgt" ErrorMessage="Packet weight should be between 0.00 and 1000.00 g" ForeColor="Red" MinimumValue="0.00" MaximumValue="1000.00" Type="Double" Display="Dynamic"></asp:RangeValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_PktWgt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Packet Weight (0.00 - 1000.00 g)"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_FU_DesgImp" runat="server" AssociatedControlID="FU_DesgImp" Text="Design & Imp." ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_FU_DesgImp" runat="server" ErrorMessage="*" ControlToValidate="FU_DesgImp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group input-group-sm">
                                        <asp:FileUpload ID="FU_DesgImp" runat="server" CssClass="form-control rounded" onchange="displayImage(this);" />
                                        <span class="input-group-btn">
                                            <asp:Button ID="BtnUpload" runat="server" CssClass="btn btn-primary btn-sm" Text="Upload" CausesValidation="true" />
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3" id="FU_DesgImp_Img" runat="server" visible="false">
                                <asp:Image ID="uploadedImage" runat="server" CssClass="img-fluid" />
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_FU_ClrApp" runat="server" AssociatedControlID="FU_ClrApp" Text="Color Application" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_FU_ClrApp" runat="server" ErrorMessage="*" ControlToValidate="FU_ClrApp" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group input-group-sm">
                                        <asp:FileUpload ID="FU_ClrApp" runat="server" CssClass="form-control rounded" />

                                        <span class="input-group-btn">
                                            <asp:Button ID="BtnUploadClrApp" runat="server" CssClass="btn btn-primary btn-sm" Text="Upload" />
                                        </span>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="btnSubmit" Text="Click to SUBMIT" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <div class="input-group input-group-sm">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary btn-sm" />
                                        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" PostBackUrl="~/qaqc_inspector_rpt.aspx" />
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
