<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="form1.aspx.cs" Inherits="AnmolDristi.form1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>--%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
        <div class="container mt-5">
            <div class="card p-4 shadow mx-auto">
                <h2 class="text-center mb-4">employee</h2>

                <div class="row mb-3">
                    <div class="col-md-4 g-3">
                        <%-- <label class="form-label">First Name</label>--%>
                        <%-- <asp:Label ID="lbl1" runat="server" Text="First Name :" AssociatedControlID="firstname"></asp:Label>--%>
                        <asp:Label ID="lbl1" runat="server" Text="First Name:"></asp:Label>
                        <asp:TextBox ID="firstname" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <%-- <label class="form-label">Last Name</label>--%>
                        <%--  <asp:Label ID="lbl2"runat="server" Text="Last Name:" AssociatedControlID="lastname"></asp:Label>--%>
                        <asp:Label ID="lbl2" runat="server" Text="Last Name:"></asp:Label>
                        <asp:TextBox ID="lastname" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <%-- <label class="form-label">City</label>--%>
                        <%-- <asp:Label ID="lbl3" runat="server" Text="City": AssociatedControlID="city"></asp:Label>--%>
                        <asp:Label ID="lbl3" runat="server" Text="city"></asp:Label>
                        <asp:TextBox ID="city" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="text-center mb-3">
                    <asp:Button ID="btnInsert" runat="server" Text="Insert" CssClass="btn btn-primary me-2" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger me-2" />
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-warning me-2" />
                    <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-success" />
                </div>

                <!-- GridView with Bootstrap styling -->
                <asp:GridView ID="gridview1" runat="server" CssClass="table table-bordered" AutoGenerateColumns="True"></asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
