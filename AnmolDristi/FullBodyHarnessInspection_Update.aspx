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
        <asp:Label ID="lbl_txtDocNo" runat="server" AssociatedControlID="txtDocNo" Text="Document Number" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtDocNo" runat="server" ErrorMessage="*" ControlToValidate="txtDocNo" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtDocNo" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>
          <div class="col-md-3">
          <div class="mb-3">
        <asp:Label ID="lbl_txtInsBy" runat="server" AssociatedControlID="txtInsBy" Text="Inspection By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtInsBy" runat="server" ErrorMessage="*" ControlToValidate="txtInsBy" ValidationGroup="submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtInsBy" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
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
   <asp:GridView ID="gvChecklist" runat="server" AutoGenerateColumns="False" DataKeyNames="IdentificationNo" CssClass="table table-bordered table-sm table-hover mt-4" >
      <HeaderStyle BackColor="#2C3E50" ForeColor="#ECF0F1" Font-Bold="true" Font-Size="Small" Font-Names="Segoe UI" HorizontalAlign="Center" />
    <Columns>
        <asp:BoundField HeaderText="Identification No" DataField="IdentificationNo" />
        <asp:BoundField HeaderText="Location" DataField="Location" />
        
        <asp:BoundField HeaderText="Q1 Status" DataField="Q1Status" />
        <asp:BoundField HeaderText="Q1 Remarks" DataField="Q1Remarks" />
        <asp:BoundField HeaderText="Q1 Photo" DataField="Q1Photo" />

        <asp:BoundField HeaderText="Q2 Status" DataField="Q2Status" />
        <asp:BoundField HeaderText="Q2 Remarks" DataField="Q2Remarks" />
        <asp:BoundField HeaderText="Q2 Photo" DataField="Q2Photo" />

        <asp:BoundField HeaderText="Q3 Status" DataField="Q3Status" />
        <asp:BoundField HeaderText="Q3 Remarks" DataField="Q3Remarks" />
        <asp:BoundField HeaderText="Q3 Photo" DataField="Q3Photo" />

        <asp:BoundField HeaderText="Q4 Status" DataField="Q4Status" />
        <asp:BoundField HeaderText="Q4 Remarks" DataField="Q4Remarks" />
        <asp:BoundField HeaderText="Q4 Photo" DataField="Q4Photo" />

        <asp:BoundField HeaderText="Q5 Status" DataField="Q5Status" />
        <asp:BoundField HeaderText="Q5 Remarks" DataField="Q5Remarks" />
        <asp:BoundField HeaderText="Q5 Photo" DataField="Q5Photo" />
       <asp:TemplateField HeaderText="Action">
       <%--<ItemTemplate>
           <asp:Button ID="BtnDelIns" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"  OnClick="BtnDelIns_Click" OnClientClick="return confirm('Are you sure you want to delete?');" />
      </ItemTemplate>--%>
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
