<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="PM_Laminate_Approval.aspx.cs" Inherits="AnmolDristi.PM_Laminate_Approval" %>
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
                             <asp:Label ID="lbl_docname" runat="server" Text="Label"></asp:Label></h2>
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
                                     <asp:Label ID="lblSl" runat="server" ReadOnly="true" ClientIDMode="Static" Text="Sl:"></asp:Label><strong><%# Container.DataItemIndex + 1 %></strong>
                                     <br />
                                     <asp:Label ID="lblLtrid" runat="server" CssClass="bold-text" ReadOnly="true" ClientIDMode="Static" Text='<%# "LTRID: " + "<strong>" + Eval("LTRID") + "</strong>" %>'></asp:Label>
                                     <br />
                                 </ItemTemplate>
                             </asp:TemplateField>

                             <asp:TemplateField HeaderText="Plant and Line Details">
                                 <ItemTemplate>
                                     <asp:Label ID="lblPlant" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Plant: " + "<strong>" +  Eval("plant_name") + "</strong>" %>'></asp:Label>
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

                             <asp:TemplateField HeaderText="Supplier Details">
                                 <ItemTemplate>
                                     <asp:Label ID="lblSupplier" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Supplier.:" + "<strong>" + Eval("Supplier_Name") + "</strong>" %>'></asp:Label>
                                     <br />
                                 </ItemTemplate>
                             </asp:TemplateField>

                             <asp:TemplateField HeaderText="Smell Details">
                                 <ItemTemplate>
                                     <asp:Label ID="lblSmell" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Smell: " + " <strong>" + (Eval("Smell") != null ? (Eval("Smell").ToString() == "1" ? "Ok" : "Not Ok") : "N/A") + "</strong>"%>'></asp:Label>
                                     <br />
                                     <asp:Label ID="lblSmellRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Smell Remarks:" + "<strong>" + Eval("Smell_Remarks") + "</strong>"%>'></asp:Label>
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

                             <asp:TemplateField HeaderText="Strength Details">
                                 <ItemTemplate>
                                     <asp:Label ID="lblBond" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%#"Bond Strength: " + " <strong>" + Eval("Bond_Strength") + "</strong>" %>'></asp:Label>
                                     <br />
                                     <asp:Label ID="LblSeal" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%#"Seal Strength:"+ "<strong>" + Eval("Seal_Strength") + "</strong>"%>'></asp:Label>
                                     <br />
                                 </ItemTemplate>
                             </asp:TemplateField>

                             <asp:TemplateField HeaderText="Dimension Details">
                                 <ItemTemplate>
                                     <asp:Label ID="lblStdLength" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Standard Length: " + "<strong>" + Eval("Std_Length")  + "</strong>" %>'></asp:Label>
                                     <br />
                                     <asp:Label ID="lblObsLength" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Observation Length: " + "<strong>" + Eval("Obs_Length")  + "</strong>" %>'></asp:Label>
                                     <br />
                                     <asp:Label ID="lblLengthRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Length Remarks: " + "<strong>" + Eval("Length_Remarks")  + "</strong>" %>'></asp:Label>
                                     <br />
                                     <asp:Label ID="lblStdWidth" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Standard Width: " + "<strong>" + Eval("Std_Width")  + "</strong>" %>'></asp:Label>
                                     <br />
                                     <asp:Label ID="lblObsWidth" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Observation Width: " + "<strong>" + Eval("Obs_Width")  + "</strong>" %>'></asp:Label>
                                     <br />
                                     <asp:Label ID="lblWidthRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Width Remarks: " + "<strong>" + Eval("Width_Remarks")  + "</strong>" %>'></asp:Label>
                                     <br />
                                     <asp:Label ID="lblStdHeight" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Standard Height: " + "<strong>" + Eval("Std_Height")  + "</strong>" %>'></asp:Label>
                                     <br />
                                     <asp:Label ID="lblObsHeight" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Observation Height: " + "<strong>" + Eval("Obs_Height")  + "</strong>" %>'></asp:Label>
                                     <br />
                                     <asp:Label ID="lblHeightRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Height Remarks: " + "<strong>" + Eval("Height_Remarks")  + "</strong>" %>'></asp:Label>
                                     <br />
                                 </ItemTemplate>
                             </asp:TemplateField>

                             <asp:TemplateField HeaderText="GSM Details">
                                 <ItemTemplate>
                                     <asp:Label ID="lblStdGSM" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%#"Standard GSM:" + "<strong>" + Eval("GMS_Std") + "</strong>" %>'></asp:Label>
                                     <br />
                                     <asp:Label ID="lblObsGSM" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "Observation GSM: " + " <strong>" + Eval("GSM_Obs") + "</strong>"%>'></asp:Label>
                                     <br />
                                     <asp:Label ID="lblGSMRemarks" runat="server" ReadOnly="true" ClientIDMode="Static" Text='<%# "GSM Remarks: " + "<strong>" + Eval("GSM_Remarks")  + "</strong>" %>'></asp:Label>
                                     <br />
                                 </ItemTemplate>
                             </asp:TemplateField>

                             <asp:TemplateField HeaderText=" Remarks Details">
                                 <ItemTemplate>
                                     <asp:Label ID="lblRemarks" runat="server" ClientIDMode="Static" Text='<%# "Remarks:" + "<strong>" + Eval("Remarks") + "</strong>" %>'></asp:Label>
                                     <br />
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
                                     <asp:Button ID="ApproveBtn" runat="server" Text="Approve" CssClass="btn btn-warning btn-sm" CausesValidation="false" CommandArgument='<%# Eval("LTRID") %>' OnClick="ApproveBtn_Click" />
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
