<%@ Page Title="AIL | Critical Incident Report" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Critical_Incident_ViewPage.aspx.cs" Inherits="AnmolDristi.Critical_Incident_ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .remove-border {
            border: none !important; /* This will ensure the border is removed */
            /* Add any other necessary styling */
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="row">
                <div class="col-md-12 col-sm-12  ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Search Filters for Critical Incident Report</h2>
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
                                        <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_Plant_SelectedIndexChanged"></asp:DropDownList>

                                    </div>

                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="DDL_PlantLine" Text="Select Line" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                     [<asp:Label ID="lbl_DDL_PlantLine_Value" runat="server" AssociatedControlID="DDL_PlantLine" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]

                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_PlantLine" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_PlantLine_SelectedIndexChanged"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    [<asp:Label ID="lbl_DDL_ProductCategory_Value" runat="server" AssociatedControlID="DDL_ProductCategory" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]

                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductCategory_SelectedIndexChanged"></asp:DropDownList>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    [<asp:Label ID="lbl_DDL_ProductBrand_Value" runat="server" AssociatedControlID="DDL_ProductBrand" Text="N/A" ForeColor="LightBlue" Font-Bold="true" Font-Size="Smaller"></asp:Label>]

                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductBrand_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Label7" runat="server" Text="Brand SKU Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:DropDownList ID="DDL_BrandSKU" runat="server" CssClass="form-control form-control-sm rounded"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Date_From" runat="server" Text="Date From :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>


                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Date_From" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_Date_To" runat="server" Text="Date To :" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>

                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Date_To" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--button start--%>
                    <div class="col-md-6 center-margin">
                        <div class="item form-group row">
                            <div class="col-md-6 col-sm-12">
                                <asp:Label ID="lbl_msg" runat="server" Text="Click SUBMIT to view Data!!"></asp:Label>
                            </div>
                            <div class="col-md-6 col-sm-12">
                                <asp:Button ID="ReportbtnCancel" runat="server" Text="Cancle" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="ReportbtnCancel_Click" />
                                <asp:Button ID="ReportbtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="ReportbtnReset_Click" />
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
                                <asp:Button ID="Button1" runat="server" Text="Export" CssClass="btn btn-primary btn-sm" /></h2>
                            <ul class="nav navbar-right panel_toolbox">
                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                            </ul>
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_content">
                            <div class="row">
                                <div class="card-box col-md-12 col-sm-12" style="width: 100%; height: 450px; overflow: scroll;">
                                    <asp:GridView ID="GridView1" runat="server" Width="100%" class="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No Data Found">
                                        <Columns>

                                            <asp:TemplateField HeaderText="SL" Visible="True" HeaderStyle-Width="2%">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_slno" runat="server" Text="<%# Container.DataItemIndex + 1 %>"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text text-center" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Plant and Line Details" Visible="true" HeaderStyle-Width="5%">
                                                <ItemTemplate>
                                                    Plant Name :
                                                    <asp:Label ID="lbl_Plant" runat="server" Text='<%# Eval("PlantName") %>' />
                                                    <br />
                                                    Line No :
                                                    <asp:Label ID="lbl_Line" runat="server" Text='<%# Eval("Line") %>' />
                                                    <br />
                                                    Category:
                                                    <asp:Label ID="lbl_Category" runat="server" Text='<%# Eval("ProductCategory") %>' />
                                                    <br />
                                                    Brand:
                                                    <asp:Label ID="lbl_Brand" runat="server" Text='<%# Eval("ProductBrand")%>' />
                                                    <br />
                                                    SKU:
                                                    <asp:Label ID="lbl_Sku" runat="server" Text='<%# Eval("SKUId") %>' />
                                                    <br />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />

                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Submission Details" HeaderStyle-Width="5%">
                                                <ItemTemplate>
                                                    Date :
                                                    <asp:Label ID="lbl_SubmittedDate" runat="server" Text='<%# Eval("SubmittedDate","{0:dd-MM-yyyy}") %>' ForeColor="Brown" Font-Bold="true" /><br />
                                                    Time :
                                                    <asp:Label ID="lbl_SubmittedTime" runat="server" Text='<%# Eval("SubmittedTime") %>' ForeColor="Brown" Font-Bold="true" /><br />
                                                    Employee :
                                                    <asp:Label ID="lbl_SubmittedById" runat="server" Text='<%# Eval("SubmittedById") %>' Font-Bold="true" ForeColor="Blue" />
                                                    <br />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Observation Details :" Visible="true" HeaderStyle-Width="5%">
                                                <ItemTemplate>
                                                    Quality Incident Details :
                                                    <asp:Label ID="lbl_qiDetail" runat="server" Text='<%# Eval("QIDetails") %>' Font-Bold="true" /><br />
                                                    Rejected/Hold Quantity :
                                                    <asp:Label ID="lbl_r_hQuantity" runat="server" Text='<%# Eval("RjtdQty") %>' Font-Bold="true" /><br />
                                                    When Observed :
                                                    <asp:Label ID="lbl_Observed" runat="server" Text='<%# Eval("WhenObserved") %>' Font-Bold="true" /><br />
                                                    Target Date of Completion :
                                                    <asp:Label ID="lbl_TargetDtCom" runat="server" Text='<%# Eval("TgtDtOfComp") %>' Font-Bold="true" />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Actions Taken :" Visible="true" HeaderStyle-Width="5%">
                                                <ItemTemplate>
                                                    Immediate Taken Action :
                                                    <asp:Label ID="lbl_ImmediateTakenAction" runat="server" Text='<%# Eval("ImmediateAction") %>' Font-Bold="true" /><br />
                                                    Corrective/Preventive Actions :
                                                    <asp:Label ID="lbl_c_pActions" runat="server" Text='<%# Eval("CorrectiveAction") %>' Font-Bold="true" /><br />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="In-Charge Details" Visible="true" HeaderStyle-Width="5%">
                                                <ItemTemplate>
                                                    QCI :
                                                    <asp:Label ID="lbl_QCI" runat="server" Text='<%# Eval("QCI_EmpCode") %>' Font-Bold="true" /><br />
                                                    Shift In-Charge :
                                                    <asp:Label ID="lbl_SftInCharge" runat="server" Text='<%# Eval("SftInCharge_EmpCode") %>' Font-Bold="true" /><br />
                                                    QA&QC In-Charge :
                                                    <asp:Label ID="lbl_qaqcInCharge" runat="server" Text='<%# Eval("QAQCInCharge") %>' Font-Bold="true" /><br />
                                                    Responsibility :
                                                    <asp:Label ID="lbl_Responsibility" runat="server" Text='<%# Eval("Responsibility_EmpCode") %>' Font-Bold="true" />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Dispatch Details" Visible="true" HeaderStyle-Width="5%">
                                                <ItemTemplate>
                                                    Dispatch Approval:
                                              <asp:Label ID="lbl_dispatch" runat="server" Text='<%# (Eval("DispatchAppRb") != null ? (Eval("DispatchAppRb").ToString() == "1" ? "Ok" : "Not Ok") : "N/A") %>' />
                                                    <br />
                                                    Dispatch Approval Remarks :
                                        <asp:Label ID="Lb_DispatchAppR" runat="server" Text='<%# Eval("DispatchApp")%>'></asp:Label>
                                                    <br />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="text" />
                                            </asp:TemplateField>

                                        </Columns>
                                        <HeaderStyle CssClass="text text-center" />
                                        <EmptyDataTemplate>
                                            <div class="grid">No Data Found</div>
                                        </EmptyDataTemplate>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
