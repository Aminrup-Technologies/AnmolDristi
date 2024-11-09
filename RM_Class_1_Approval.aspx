<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="RM_Class_1_Approval.aspx.cs" Inherits="AnmolDristi.RM_Class_1_Approval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
        <div class="container">

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docname" runat="server" Text="Label"></asp:Label>
                            </h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <div class="tab-content ml-1" id="myTabContent">
                                    <div class="x-content">

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="Label1" runat="server" AssociatedControlID="DDL_Plant" Text="Plant Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_DDL_Plant" runat="server" ErrorMessage="" ForeColor="Red" ControlToValidate="DDL_Plant" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_Plant_SelectedIndexChanged"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="Label2" runat="server" AssociatedControlID="DDL_Material" Text="Material Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_DDL_Material" runat="server" ErrorMessage="" ForeColor="Red" ControlToValidate="DDL_Material" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:DropDownList ID="DDL_Material" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_Material_SelectedIndexChanged"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="Label3" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_DDL_ProductCategory" runat="server" ErrorMessage="" ForeColor="Red" InitialValue="" ControlToValidate="DDL_ProductCategory" Display="Dynamic"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductCategory_SelectedIndexChanged"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="Label4" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_DDL_ProductBrand" runat="server" ErrorMessage="" ForeColor="Red" ControlToValidate="DDL_ProductBrand" InitialValue="" Display="Dynamic"></asp:RequiredFieldValidator>
                                                <div class="input-group-sm">
                                                    <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductBrand_SelectedIndexChanged"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="Lbl_Date_From" runat="server" AssociatedControlID="TB_Date_From" Text="Date From :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_Date_From" runat="server" ErrorMessage="Date is required " ControlToValidate="TB_Date_From" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="REV_Date_From" runat="server" ControlToValidate="TB_Date_From" ForeColor="Red" ErrorMessage="" Display="Dynamic" ValidationExpression=" "></asp:RegularExpressionValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_Date_From" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Date"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="mb-3">
                                                <asp:Label ID="Lbl_Date_To" runat="server" AssociatedControlID="TB_Date_To" Text="Date To :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                <asp:RequiredFieldValidator ID="RFV_Date_To" runat="server" ErrorMessage="Date is required " ControlToValidate="TB_Date_To" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="REV_Date_To" runat="server" ControlToValidate="TB_Date_To" ForeColor="Red" ErrorMessage="" Display="Dynamic" ValidationExpression=" "></asp:RegularExpressionValidator>
                                                <div class="input-group-sm">
                                                    <asp:TextBox ID="TB_Date_To" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Date"></asp:TextBox>
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

            <%--Button--%>
            <div class="col-md-12 d-flex justify-content-center align-items-center">
                <div class="mb-3 ">
                    <div class="input-group input-group-sm">
                        <asp:Label ID="lblInstruction" runat="server" Text="Click SUBMIT to view data!!!" CssClass="clearfix" Style="padding-right: 5em" />
                        <asp:Button ID="ReportbtnCancel" runat="server" Text="Cancle" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="ReportbtnCancel_Click" />
                        <asp:Button ID="ReportbtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" CausesValidation="false" OnClick="ReportbtnSubmit_Click" />
                        <asp:Button ID="ReportbtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="ReportbtnReset_Click" />
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_viewname" runat="server" Text="Label"></asp:Label>
                                <asp:Button ID="ExportBtn" runat="server" Text="Export" CssClass="btn btn-info btn-sm" CausesValidation="false" OnClick="ExportBtn_Click" />
                            </h2>
                            <div class="clearfix"></div>
                        </div>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap">
                            <Columns>

                                <asp:TemplateField HeaderText="Sl">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSl" runat="server" ReadOnly="true" ClientIDMode="Static" Text="Sl:"></asp:Label>
                                        <strong><%# Container.DataItemIndex + 1 %></strong>
                                        <br />
                                        <asp:Label ID="lblRmfid" runat="server" CssClass="bold-text" ReadOnly="true" ClientIDMode="Static" Text='<%# "RMFID: " + "<strong>" + Eval("RMFID") + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Plant Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPlant" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Plant: " + "<strong>" +  Eval("plant_name") + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblMaterial" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Material: " + "<strong>" +  Eval("material_name") + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblCategory" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Category: " + "<strong>" +  Eval("category_name") + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblBrand" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Brand:" + "<strong>" + Eval("brand_name") + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Submission Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDate" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Date: <span style=\"color: red; font-weight: bold;\">" + Eval("SubmittedDate","{0:dd-MM-yyyy}") + "</span>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblTime" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Time: <span style=\"color: red; font-weight: bold;\">" + DataBinder.Eval(Container.DataItem, "SubmittedTime", "{0:hh\\:mm\\:ss}") + "</span>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblName" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Submitter:" + "<strong>" + Eval("SubmittedById")+ "</strong>"%>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Supplier and Quantity Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSupplier" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Supplier.:" + "<strong>" + Eval("Supplier_Name") + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblQuantity" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Quantity.:" + "<strong>" + Eval("Quantity") + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblQuantityRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Quantity Remarks:" + "<strong>" + Eval("CommentsForQuantity") + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="No.and Date Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblChallanNo" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Challan No.: "+" <strong>" + Eval("Challan_No") + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblChallanDate" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Challan Date:"+ "<strong>" + Eval("Challan_Date","{0:dd-MM-yyyy}") + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblLotNo" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%#"Lot/Gate No.: "+" <strong>" + Eval("Lot_No") + "</strong>"%>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblVehicleNo" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%#"Vehicle No.:" + "<strong>" + Eval("Vehicle_No") + "</strong>"%>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Color Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblColor" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Color: " + " <strong>" +  Eval("Color") + "</strong>"%>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblColorRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Other Color :" + "<strong>" + Eval("CommentsForColor") + "</strong>"%>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Smell Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSmell" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Smell: " + " <strong>" + (Eval("Smell") != null ? (Eval("Smell").ToString() == "1" ? "Ok" : "Not Ok") : "N/A") + "</strong>"%>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblSmellRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Smell Remarks:" + "<strong>" + Eval("CommentsForSmell") + "</strong>"%>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Taste Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTaste" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Taste: " + " <strong>" + (Eval("Taste") != null ? (Eval("Taste").ToString() == "1" ? "Ok" : "Not Ok") : "N/A") + "</strong>"%>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblTasteRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Taste Remarks:" + "<strong>" + Eval("CommentsForTaste") + "</strong>"%>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Appearance Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAppearance" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Appearance: " + " <strong>" + (Eval("Appearance") != null ? (Eval("Appearance").ToString() == "1" ? "Ok" : "Not Ok") : "N/A") + "</strong>"%>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblAppearanceRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Appearance Remarks:" + "<strong>" + Eval("CommentsForAppearance") + "</strong>"%>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Impurities Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblImpurirties" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Impurities value: " + "<strong>" + Eval("Foreign_Matter_Impurities")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Ph Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPh" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "PH value: " + "<strong>" + Eval("PH")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblPHRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "PH Remarks: " + "<strong>" + Eval("CommentsForPH")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Moisture Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMoisture" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Moisture value: " + "<strong>" + Eval("Moisture")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblMoistureRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Moisture Remarks: " + "<strong>" + Eval("CommentsForMoisture")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Ash Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalAsh" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Total Ash value: " + "<strong>" + Eval("Total_Ash")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblTotalAshRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Total Ash Remarks: " + "<strong>" + Eval("CommentsForTotalAsh")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblInsolubleAsh" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Acid Insoluble Ash value: " + "<strong>" + Eval("Acid_Insoluble_Ash")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblInsolubleAshRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Acid Insoluble Ash Remarks: " + "<strong>" + Eval("CommentsForInsolubleAsh")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Density Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDensity" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Density value: " + "<strong>" + Eval("Density")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblDensityRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Density Remarks: " + "<strong>" + Eval("CommentsForDensity")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Fat Content Details ">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFat" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Fat Content value: " + "<strong>" + Eval("Fat_Content")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblFatRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Fat Content Remarks: " + "<strong>" + Eval("CommentsForFatContent")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Total Solid Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSolid" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Total Solids Height: " + "<strong>" + Eval("Total_Solids")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblSolidRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Total Solids Remarks: " + "<strong>" + Eval("CommentsForSolid")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Sugar Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSugar" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Reducing Sugar: " + "<strong>" + Eval("Reducing_Sugar")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblSugarRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Reducing Sugar Remarks: " + "<strong>" + Eval("CommentsForSugar")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Syrup Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSyrup" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Drainable Syrup: " + "<strong>" + Eval("Drainable_Syrup")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblSyrupRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Drainable Syrup Remarks: " + "<strong>" + Eval("CommentsForSyrup")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Seeds Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSeeds" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "No of Matured/Immatured seeds: " + "<strong>" + Eval("Matured_Immatured_seeds")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblSeedsRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Seeds Remarks: " + "<strong>" + Eval("CommentsForSeed")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Brix Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBrix" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Brix: " + "<strong>" + Eval("Brix")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblBrixRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Brix Remarks: " + "<strong>" + Eval("CommentsForBrix")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Shape and Size Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblShapeSize" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Shape/Size: " + "<strong>" + Eval("ShapeOrSize")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblShapeSizeRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Shape/Size Remarks: " + "<strong>" + Eval("CommentsForShapeOrSize")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText=" TS Details">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTS" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "TS: " + "<strong>" + Eval("TS")  + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblTSRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "TS Remarks: " + "<strong>" + Eval("CommentsForTS")  + "</strong>" %>'></asp:Label>
                                        <br />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Material Image">
                                    <ItemTemplate>
                                        <asp:Image ID="imgMaterial" runat="server" ImageUrl='<%# Eval("Material_Image") != null ? ResolveUrl(Eval("Material_Image").ToString()) : "~/Images/placeholder.jpg" %>' AlternateText="Material Image" Width="100px" Height="100px" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Approvals">
                                    <ItemTemplate>
                                        <asp:Label ID="lblApproval1" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "A1:" + "<strong>" + Eval("Approver1EmployeeCode") + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblApproval2" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "A2:" + "<strong>" + Eval("Approver2EmployeeCode") + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="lblApproval3" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "A3:" + "<strong>" + Eval("DottedLineApproverEmployeeCode") + "</strong>" %>'></asp:Label>
                                        <br />
                                        <asp:Button ID="ApproveBtn" runat="server" Text="Approve" CssClass="btn btn-warning btn-sm" CausesValidation="false" CommandArgument='<%# Eval("RMFID") %>' OnClick="ApproveBtn_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>


        </div>
    </div>

</asp:Content>
