<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Edit_page.aspx.cs" Inherits="AnmolDristi.Edit_page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h5>Main Heading</h5>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="row">
            <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>Sub Heading</h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">

                         <div class="row">
     <div class="col-md-3">
         <div class="mb-3">
             <asp:Label ID="Lbl_Date" runat="server" AssociatedControlID="TB_Date" Text="Date" ForeColor="Blue" Font-Bold="true"></asp:Label>
             <asp:RequiredFieldValidator ID="RFV_TB_Date" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_Date" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
             <asp:TextBox ID="TB_Date" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>

     <div class="col-md-3">
         <div class="mb-3">
             <asp:Label ID="Lbl_ID" runat="server" AssociatedControlID="TB_ID" Text="Job ID" ForeColor="Blue" Font-Bold="true"></asp:Label>
             <asp:RequiredFieldValidator ID="RFV_TB_ID" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_ID" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ID="REV_TB_ID" runat="server" ValidationGroup="Submit" ControlToValidate="TB_ID" ForeColor="Red" ErrorMessage="Only letters, numbers, and spaces allowed" ValidationExpression="^[a-zA-Z0-9]+$" Display="Dynamic"></asp:RegularExpressionValidator>

             <asp:TextBox ID="TB_ID" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
         </div>
     </div>

     <div class="col-md-6">
         <div class="mb-6">
             <asp:Label ID="Lbl_JD" runat="server" AssociatedControlID="TB_JD" Text="Job Description" ForeColor="Blue" Font-Bold="true"></asp:Label>
             <asp:RequiredFieldValidator ID="RFV_TB_JD" runat="server" ErrorMessage="*" ValidationGroup="Submit" ControlToValidate="TB_JD" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ID="REV_TB_JD" runat="server" ValidationGroup="Submit" ControlToValidate="TB_JD" ForeColor="Red" ErrorMessage="Only alphabets allowed" ValidationExpression="^[a-zA-Z, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>

             <asp:TextBox ID="TB_JD" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
         </div>
     </div>


 </div>

        <asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="False" ShowFooter="True">
            <Columns>

                <asp:TemplateField HeaderText="Emp Type">
                    <ItemTemplate>
                        <asp:Label ID="lblEmpType" runat="server" Text="Manager"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEmpType" runat="server" Text="Manager"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewEmpType" runat="server" Placeholder="Emp Type"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Emp Code">
                    <ItemTemplate>
                        <asp:Label ID="lblEmpCode" runat="server" Text="E001"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEmpCode" runat="server" Text="E001"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewEmpCode" runat="server" Placeholder="Emp Code"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Emp Name">
                    <ItemTemplate>
                        <asp:Label ID="lblEmpName" runat="server" Text="John Doe"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEmpName" runat="server" Text="John Doe"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="txtNewEmpName" runat="server" Placeholder="Emp Name"></asp:TextBox>
                    </FooterTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Button ID="btnAdd" runat="server" Text="Add" />
                    </FooterTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>



                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>

</asp:Content>
