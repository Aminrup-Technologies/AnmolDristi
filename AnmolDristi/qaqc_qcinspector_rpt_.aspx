<%@ Page Title="AIL | QC Inspector Report" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_qcinspector_rpt_.aspx.cs" Inherits="AnmolDristi.qaqc_qcinspector_rpt_" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .thumbnail {
            position: relative;
            overflow: hidden;
            width: 100px; /* Set the initial width of the thumbnail */
            height: 100px; /* Set the initial height of the thumbnail */
            transition: width 0.3s, height 0.3s; /* Add smooth transition effect */
        }

            .thumbnail:hover {
                width: 150px; /* Set the enlarged width on hover */
                height: 150px; /* Set the enlarged height on hover */
            }

        .thumbnail-image {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Ensure the image covers the entire container */
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <%--<div class="page-title">
                <div class="title_left">
                    <h5>Create Memo Summary</h5>
                </div>
            </div>

            <div class="clearfix"></div>--%>

            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Search Filters for QC Inspector Report</h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="DDL_Plant" Text="Plant Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    [<asp:Label ID="lbl_DDL_Plant_Value" runat="server" AssociatedControlID="DDL_Plant" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
                                    <asp:RequiredFieldValidator ID="RFV_DDL_Plant" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="DDL_Plant" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_Plant_SelectedIndexChanged"></asp:DropDownList>

                                    </div>

                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="DDL_PlantLine" Text="Select Line" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    [<asp:Label ID="lbl_DDL_PlantLine_Value" runat="server" AssociatedControlID="DDL_PlantLine" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
                                    <asp:RequiredFieldValidator ID="RFV_DDL_PlantLine" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_PlantLine" Display="Dynamic" InitialValue=""></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_PlantLine" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_PlantLine_SelectedIndexChanged"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    [<asp:Label ID="lbl_DDL_ProductCategory_Value" runat="server" AssociatedControlID="DDL_ProductCategory" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductCategory" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" InitialValue="" ControlToValidate="DDL_ProductCategory" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductCategory_SelectedIndexChanged"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    [<asp:Label ID="lbl_DDL_ProductBrand_Value" runat="server" AssociatedControlID="DDL_ProductBrand" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]
                                    
                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductBrand" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_ProductBrand" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductBrand_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label7" runat="server" AssociatedControlID="DDL_BrandSKU" Text="Brand SKU Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_DDL_BrandSKU" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_BrandSKU" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_BrandSKU" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_BrandSKU_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label3" runat="server" AssociatedControlID="txt_date1" Text="Date From" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_txt_date1" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txt_date1" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="txt_date1" runat="server" CssClass="form-control form-control-sm rounded" class='date' type="date" name="date" BorderColor="Blue" BorderWidth="2px"></asp:TextBox>
                                    </div>

                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label6" runat="server" AssociatedControlID="txt_date2" Text="Date To" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_txt_date2" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txt_date2" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="txt_date2" runat="server" CssClass="form-control form-control-sm rounded" class='date' type="date" name="date" BorderColor="Blue" BorderWidth="2px"></asp:TextBox>
                                    </div>

                                </div>
                            </div>

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

                    <%--button start--%>
                    <div class="col-md-6 center-margin">
                        <%--<div class="ln_solid"></div>--%>
                        <div class="item form-group row">
                            <div class="col-md-6 col-sm-12">
                                <asp:Label ID="lbl_msg" runat="server" Text="Click SUBMIT to view Data!!"></asp:Label>
                            </div>
                            <div class="col-md-6 col-sm-12">
                                <button type="button" class="btn btn-danger btn-sm collapse-link">Cancel</button>
                                <button type="reset" class="btn btn-warning btn-sm">Reset</button>
                                <asp:Button ID="btn_submit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" CausesValidation="true" ValidationGroup="Submit" OnClick="btn_submit_Click" />
                            </div>
                        </div>
                    </div>
                    <%--button end--%>
                </div>


                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>View and Select for Detailed View ||
                                <asp:Button ID="Button1" runat="server" Text="Export" OnClick="ExportExcel" CssClass="btn btn-primary btn-sm" CausesValidation="false" /></h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="card-box col-md-12 col-sm-12" style="width: 100%; height: 450px; overflow: scroll;">
                                    <asp:GridView ID="GridView1" runat="server" Width="100%" class="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap"
                                        AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Data Found">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SL" HeaderStyle-Width="2%">
                                                <ItemTemplate>
                                                    SL:<asp:Label ID="lbl_slno" runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                    <br />
                                                    Id:<asp:Label ID="lbl_rowid" runat="server" Text='<%# Eval("rowid") %>' />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text text-center" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Plant and Line Details" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    Plant:
                                                    <asp:Label ID="lbl_PlantName" runat="server" Text='<%# Eval("PlantName") %>' Font-Bold="true"/><br />
                                                    Line:
                                                    <asp:Label ID="lbl_Line" runat="server" Text='<%# Eval("LineName") %>' Font-Bold="true"/><br />
                                                    Category:
                                                    <asp:Label ID="lbl_ProductCategory" runat="server" Text='<%# Eval("ProductCategory") %>' Font-Bold="true"/><br />
                                                    Brand:
                                                    <asp:Label ID="lbl_ProductBrand" runat="server" Text='<%# Eval("ProductBrand") %>' Font-Bold="true"/><br />
                                                    SKU:
                                                    <asp:Label ID="lbl_SKUId" runat="server" Text='<%# Eval("SKU_name") %>' Font-Bold="true"/>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Submission Details" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    Date:
                                                    <asp:Label ID="lbl_SubmittedDate" runat="server" Text='<%# Eval("SubmittedDate", "{0:dd-MM-yyyy}") %>' ForeColor="Brown" Font-Bold="true" /><br />
                                                    Time:
                                                    <asp:Label ID="lbl_SubmittedTime" runat="server" Text='<%# BindSubmittedTime(Eval("SubmittedTime")) %>' ForeColor="Brown" Font-Bold="true" /><br />
                                                    Submitter:
                                                    <asp:Label ID="lbl_EmployeeName" runat="server" Text='<%# Eval("EmployeeName") %>' />[<asp:Label ID="lbl_SubmittedByPNo" runat="server" Text='<%# Eval("SubmittedByPNo") %>' />]
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Sample Details" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    Number of Pieces:
                                                    <asp:Label ID="lbl_NumberOfPieces" runat="server" Text='<%# Eval("NumberOfPieces") %>' /><br />
                                                    Variety/Lot No:
                                                    <asp:Label ID="lbl_VarietyOrLotNo" runat="server" Text='<%# Eval("VarietyOrLotNo") %>' /><br />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Baking Time" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    Baking Time:
                                                    <asp:Label ID="lbl_BakingTime" runat="server" Text='<%# Eval("BakingTime") %>' /><br />
                                                    Comments:
                                                    <asp:Label ID="lbl_BakingTime_comments" runat="server" Text='<%# Eval("BakingTime_comments") %>' /><br />
                                                    Baking Time 2:
                                                    <asp:Label ID="lbl_BakingTime2" runat="server" Text='<%# Eval("BakingTime2") %>' /><br />
                                                    Comments:
                                                    <asp:Label ID="lbl_BakingTime2_comments" runat="server" Text='<%# Eval("BakingTime2_comments") %>' />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <%--<asp:TemplateField HeaderText="Appearance and Taste" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    Color Appearance:
                                                    <asp:Label ID="lbl_ColorAppearance" runat="server" Text='<%# Eval("ColorAppearance") %>' /><br />
                                                    Comments:
                                                    <asp:Label ID="lbl_CommentsForColorAppearance" runat="server" Text='<%# Eval("CommentsForColorAppearance") %>' /><br />
                                                    Flavour and Taste:
                                                    <asp:Label ID="lbl_FlavourAndTaste" runat="server" Text='<%# Eval("FlavourAndTaste") %>' /><br />
                                                    Comments:
                                                    <asp:Label ID="lbl_CommentsForFlavourAndTaste" runat="server" Text='<%# Eval("CommentsForFlavourAndTaste") %>' />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>--%>

                                            <asp:TemplateField HeaderText="Appearance and Taste" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    Color Appearance:
                                                    <asp:Label ID="lbl_ColorAppearance" runat="server"
                                                        Text='<%# Convert.ToBoolean(Eval("ColorAppearance")) ? "OK" : "Not OK" %>' Font-Bold="true" />
                                                    ; Comments:
                                                    <asp:Label ID="lbl_CommentsForColorAppearance" runat="server"
                                                        Text='<%# Eval("CommentsForColorAppearance") %>' />
                                                                                                <br />
                                                    Flavour and Taste:
                                                    <asp:Label ID="lbl_FlavourAndTaste" runat="server"
                                                        Text='<%# Convert.ToBoolean(Eval("FlavourAndTaste")) ? "OK" : "Not OK" %>' Font-Bold="true"/>
                                                    Comments:
                                                    <asp:Label ID="lbl_CommentsForFlavourAndTaste" runat="server"
                                                        Text='<%# Eval("CommentsForFlavourAndTaste") %>' />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Appearance and Texture" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    Color Appearance:
                                                    <asp:Label ID="lbl_ColorAppearance" runat="server"
                                                        Text='<%# Convert.ToBoolean(Eval("DesignImplementation")) ? "OK" : "Not OK" %>' Font-Bold="true" />
                                                    ; Comments:
                                                    <asp:Label ID="lbl_CommentsForColorAppearance" runat="server"
                                                        Text='<%# Eval("CommentsForDesignImplementation") %>' />
                                                                                                <br />
                                                    Texture/Bite:
                                                    <asp:Label ID="Label8" runat="server"
                                                        Text='<%# Convert.ToBoolean(Eval("TextureBite")) ? "OK" : "Not OK" %>' Font-Bold="true" />
                                                    ; Comments:
                                                    <asp:Label ID="Label9" runat="server"
                                                        Text='<%# Eval("CommentsForTextureBite") %>' />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Weights" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    Weight Without Oil:
                                                    <asp:Label ID="lbl_WeightWithoutOil" runat="server" Text='<%# Eval("WeightWithoutOil") %>' /><br />
                                                    Weight With Oil:
                                                    <asp:Label ID="lbl_WeightWithOil" runat="server" Text='<%# Eval("WeightWithOil") %>' /><br />
                                                    Oil Percentage:
                                                    <asp:Label ID="lbl_OilPercentage" runat="server" Text='<%# Eval("OilPercentage") %>' />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Shape & Size" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    Length:
                                                    <asp:Label ID="lbl_Length" runat="server" Text='<%# Eval("Length") %>' /><br />
                                                    Breadth:
                                                    <asp:Label ID="lbl_Breadth" runat="server" Text='<%# Eval("Breadth") %>' /><br />
                                                    Height:
                                                    <asp:Label ID="lbl_Height" runat="server" Text='<%# Eval("Height") %>' /><br />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Moisture and Packet Weight" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    Moisture:
                                                    <asp:Label ID="lbl_Moisture" runat="server" Text='<%# Eval("Moisture") %>' /><br />
                                                    Comments:
                                                    <asp:Label ID="lbl_Moisture_comments" runat="server" Text='<%# Eval("Moisture_comments") %>' /><br />
                                                    Packet Weight:
                                                    <asp:Label ID="lbl_PacketWeight" runat="server" Text='<%# Eval("PacketWeight") %>' />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Product Apperance" HeaderStyle-Width="2%">
                                                <ItemTemplate>
                                                    <div class="thumbnail">
                                                        <asp:Image ID="Img_DesignAndImplementation" runat="server" ImageUrl='<%# Eval("DesignAndImplementation") %>' CssClass="thumbnail-image" />
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Final Packet (Coding Zone)" HeaderStyle-Width="2%">
                                                <ItemTemplate>
                                                    <div class="thumbnail">
                                                        <asp:Image ID="Img_ColourAndAppearance" runat="server" ImageUrl='<%# Eval("ColourAndAppearance") %>' CssClass="thumbnail-image" />
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Approvals" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    A1:
                                                    <asp:Label ID="lbl_Approver1" runat="server" Text='<%# Eval("Approver1EmployeeCode") %>' /><br />
                                                    A2:
                                                    <asp:Label ID="lbl_Approver2" runat="server" Text='<%# Eval("Approver2EmployeeCode") %>' /><br />
                                                    A3:
                                                    <asp:Label ID="lbl_DottedLineApproverEmployeeCode" runat="server" Text='<%# Eval("DottedLineApproverEmployeeCode") %>' />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <%--<asp:TemplateField HeaderText="Audit Information" HeaderStyle-Width="10%">
                                                <ItemTemplate>
                                                    Created By:
                                                    <asp:Label ID="lbl_CreatedBy" runat="server" Text='<%# Eval("CreatedBy") %>' /><br />
                                                    Created On:
                                                    <asp:Label ID="lbl_CreatedOn" runat="server" Text='<%# Eval("CreatedOn", "{0:dd-MM-yyyy}") %>' /><br />
                                                    Modified By:
                                                    <asp:Label ID="lbl_ModifiedBy" runat="server" Text='<%# Eval("ModifiedBy") %>' /><br />
                                                    Modified On:
                                                    <asp:Label ID="lbl_ModifiedOn" runat="server" Text='<%# Eval("ModifiedOn", "{0:dd-MM-yyyy}") %>' />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>--%>

                                            <%--<asp:TemplateField HeaderText="Record Status" HeaderStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_RecordStatus" runat="server" Text='<%# Eval("RecordStatus") %>' CssClass="status-label" />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text text-center" />
                                            </asp:TemplateField>--%>

                                            <%--<asp:TemplateField HeaderText="Actions" HeaderStyle-Width="5%">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="lnkEdit" runat="server" Text="Edit" NavigateUrl='<%# Eval("ID", "~/EditForm.aspx?ID={0}") %>' CssClass="btn btn-primary btn-sm" />
                                                    <asp:HyperLink ID="lnkDelete" runat="server" Text="Delete" NavigateUrl='<%# Eval("ID", "~/DeleteForm.aspx?ID={0}") %>' CssClass="btn btn-danger btn-sm" />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text-center" />
                                            </asp:TemplateField>--%>
                                        </Columns>
                                    </asp:GridView>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function ShowPopup(title, body) {
            $("#MyPopup .modal-title").html(title);
            $("#MyPopup .modal-body").html(body);
            $("#MyPopup").modal("show");
        }
    </script>
</asp:Content>
