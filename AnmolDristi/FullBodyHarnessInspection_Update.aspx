<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="FullBodyHarnessInspection_Update.aspx.cs" Inherits="AnmolDristi.FullBodyHarnessInspection_Update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style type="text/css">
    
    .question-section {
    padding: 20px;
    background-color: #f7f7f7;
    border-radius: 8px;
}

.question-block {
    margin-bottom: 20px;
    padding: 15px;
    background-color: #ffffff;
    border: 1px solid #ccc;
    border-radius: 6px;
}

    .table-responsive {
    width: 100%;
    max-height: 400px; /* Adjust based on need */
    overflow-x: auto;
    overflow-y: auto;
    
   }

@media (max-width: 768px) {
    .table-responsive {
        max-height: 300px; /* Adjust based on your UI */
    }
}
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h3>Automation And Technical Services
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        
                        <h2>Full Body Harness Inspection</h2>
                         <div class="clearfix"></div>
                      </div>

                    <div class="x_content">

                        
                                <div class="row">  
                                    
      <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Date Of Inspection" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
     <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtSite" runat="server" AssociatedControlID="txtSite" Text="Site" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtSite" runat="server" ErrorMessage="*" ControlToValidate="txtSite" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtSite" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
      <div class="col-md-3">
      <div class="mb-3">
    <asp:Label ID="lbl_txtInsBy" runat="server" AssociatedControlID="txtInsBy" Text="Inspection By(Emp Code)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
    <asp:RequiredFieldValidator ID="RFV_txtInsBy" runat="server" ErrorMessage="*" ControlToValidate="txtInsBy" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
    <div class="input-group-sm">
        <asp:TextBox ID="txtInsBy" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
    </div>
          </div>
</div>
        <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtDocNo" runat="server" AssociatedControlID="txtDocNo" Text="Employee Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtDocNo" runat="server" ErrorMessage="*" ControlToValidate="txtDocNo" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtDocNo" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>
         
</div>
        
                              
                                    </div>

 <div class="x_title">
     <h2>Inspection Checklist</h2>
     <div class="clearfix"></div>
 </div>
                    
    

   <div class="table-responsive">
    <div class="col-md-12">
        <div class="mb-3">
            <asp:GridView ID="gvChecklist" runat="server" AutoGenerateColumns="False" DataKeyNames="IdentificationNo"
                CssClass="table table-bordered table-sm table-hover mt-4">
                <HeaderStyle BackColor="#2C3E50" ForeColor="#ECF0F1" Font-Bold="true" Font-Size="Small" Font-Names="Segoe UI" HorizontalAlign="Center" />
                <Columns>

                    <asp:TemplateField HeaderText="Identification No">
                        <ItemTemplate>
                            <asp:Label ID="lblIdentificationNo" runat="server" Text='<%# Eval("IdentificationNo") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Location">
                        <ItemTemplate>
                            <asp:TextBox ID="txtLocation" runat="server" Text='<%# Eval("Location") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- Q1 Fields --%>
                    <asp:TemplateField HeaderText="Q1 Status">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ1Status" runat="server" Text='<%# Eval("Q1Status") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Q1 Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ1Remarks" runat="server" Text='<%# Eval("Q1Remarks") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="Q1 Photo">
    <ItemTemplate>
        <asp:Image ID="imgQ1Photo" runat="server" 
                   ImageUrl='<%# Eval("Q1Photo", "{0}") %>' 
                   Width="50px" Height="50px" 
                   CssClass="img-thumbnail" 
                   AlternateText="alt" />
        <!-- Hidden field to retain existing image path -->
<asp:Label ID="lblimgQ1Photo" runat="server" 
    Text='<%# Eval("Q1Photo") %>' Visible="false" />

<!-- Upload control to select a new image -->
<br />
<asp:FileUpload ID="fuimgQ1Photo" runat="server" />

    </ItemTemplate>
</asp:TemplateField>


                    <%-- Q2 Fields --%>
                    <asp:TemplateField HeaderText="Q2 Status">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ2Status" runat="server" Text='<%# Eval("Q2Status") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Q2 Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ2Remarks" runat="server" Text='<%# Eval("Q2Remarks") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:TemplateField HeaderText="Q2 Photo">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ2Photo" runat="server" Text='<%# Eval("Q2Photo") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
   <asp:TemplateField HeaderText="Q2 Photo">
    <ItemTemplate>
        <asp:Image ID="imgQ2Photo" runat="server" 
                   ImageUrl='<%# Eval("Q2Photo", "{0}") %>' 
                   Width="50px" Height="50px" 
                   CssClass="img-thumbnail" 
                   AlternateText="alt" />
                <!-- Hidden field to retain existing image path -->
<asp:Label ID="lblimgQ2Photo" runat="server" 
    Text='<%# Eval("Q2Photo") %>' Visible="false" />

<!-- Upload control to select a new image -->
<br />
<asp:FileUpload ID="fuimgQ2Photo" runat="server" />
    </ItemTemplate>
</asp:TemplateField>
                    <%-- Q3 Fields --%>
                    <asp:TemplateField HeaderText="Q3 Status">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ3Status" runat="server" Text='<%# Eval("Q3Status") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Q3 Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ3Remarks" runat="server" Text='<%# Eval("Q3Remarks") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:TemplateField HeaderText="Q3 Photo">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ3Photo" runat="server" Text='<%# Eval("Q3Photo") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                       <asp:TemplateField HeaderText="Q3 Photo">
    <ItemTemplate>
        <asp:Image ID="imgQ3Photo" runat="server" 
                   ImageUrl='<%# Eval("Q3Photo", "{0}") %>' 
                   Width="50px" Height="50px" 
                   CssClass="img-thumbnail" 
                   AlternateText="alt" />
                <!-- Hidden field to retain existing image path -->
<asp:Label ID="lblimgQ3Photo" runat="server" 
    Text='<%# Eval("Q3Photo") %>' Visible="false" />

<!-- Upload control to select a new image -->
<br />
<asp:FileUpload ID="fuimgQ3Photo" runat="server" />
    </ItemTemplate>
</asp:TemplateField>

                    <%-- Q4 Fields --%>
                    <asp:TemplateField HeaderText="Q4 Status">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ4Status" runat="server" Text='<%# Eval("Q4Status") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Q4 Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ4Remarks" runat="server" Text='<%# Eval("Q4Remarks") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>
                   
  <asp:TemplateField HeaderText="Q4 Photo">
        <ItemTemplate>
        <asp:Image ID="imgQ4Photo" runat="server" 
                   ImageUrl='<%# Eval("Q4Photo", "{0}") %>' 
                   Width="50px" Height="50px" 
                   CssClass="img-thumbnail" 
                   AlternateText="alt" />
                    <!-- Hidden field to retain existing image path -->
<asp:Label ID="lblimgQ4Photo" runat="server" 
    Text='<%# Eval("Q4Photo") %>' Visible="false" />

<!-- Upload control to select a new image -->
<br />
<asp:FileUpload ID="fuimgQ4Photo" runat="server" />
    </ItemTemplate>
</asp:TemplateField>


                    <%-- Q5 Fields --%>
                    <asp:TemplateField HeaderText="Q5 Status">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ5Status" runat="server" Text='<%# Eval("Q5Status") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Q5 Remarks">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ5Remarks" runat="server" Text='<%# Eval("Q5Remarks") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>
                   <%-- <asp:TemplateField HeaderText="Q5 Photo">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQ5Photo" runat="server" Text='<%# Eval("Q5Photo") %>' CssClass="form-control" />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                      <asp:TemplateField HeaderText="Q5 Photo">
                        <ItemTemplate>
        <asp:Image ID="imgQ5Photo" runat="server" 
                   ImageUrl='<%# Eval("Q5Photo", "{0}") %>' 
                   Width="50px" Height="50px" 
                   CssClass="img-thumbnail" 
                   AlternateText="alt" />
                            <!-- Hidden field to retain existing image path -->
<asp:Label ID="lblimgQ5Photo" runat="server" 
    Text='<%# Eval("Q5Photo") %>' Visible="false" />

<!-- Upload control to select a new image -->
<br />
<asp:FileUpload ID="fuimgQ5Photo" runat="server" />
    </ItemTemplate>
</asp:TemplateField>

                    <%-- Action Buttons --%>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnDelInsp" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger" OnClick="BtnDelInsp_Click" OnClientClick="return confirm('Are you sure you want to delete?');" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
        </div>
    </div>
</div>


                </div>
            </div>


            <%--Button--%>
<%--<div class="col-md-3">
                <div class="mb-3">
                    <asp:Label ID="Lbl_BtnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group input-group-sm">
                        <asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm"  OnClick="BtnSubmit_Click" />
                        <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                        <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/Home.aspx" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        
                    </div>
                </div>
            </div>            --%>

        </div>
    </div>
</div>
</asp:Content>
