<%@ Page Title="CRUD Operation" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="SN_CRUD_Oprtn.aspx.cs" Inherits="AnmolDristi.SN_CRUD_Oprtn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5>Student Info Manage Form</h5>
                </div>
            </div>


            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_content">

                            <div class="col-md-12">
                                <div class="mb-3">
                                    <asp:Label runat="server" Text="Student ID"></asp:Label>
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                    <asp:Button ID="Button5" runat="server" Text="Get" BackColor="Orange" ForeColor="White" OnClick="Button5_Click" />

                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="mb-3">
                                    <asp:Label runat="server" Text="Student Name"></asp:Label>
                                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="mb-3">
                                    <asp:Label runat="server" Text="Address"></asp:Label>

                                    <asp:DropDownList ID="DropDownList1" runat="server">
                                        <asp:ListItem>USA</asp:ListItem>
                                        <asp:ListItem>CANADA</asp:ListItem>
                                        <asp:ListItem>UK</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="mb-3">
                                    <asp:Label runat="server" Text="Age"></asp:Label>
                                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="mb-3">

                                    <asp:Label runat="server" Text="Contact"></asp:Label>
                                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="mb-3">
                                    <asp:Button ID="Button1" runat="server" Text="Insert" BackColor="Purple" ForeColor="White" OnClick="Button1_Click" />
                                    <asp:Button ID="Button2" runat="server" Text="Update" BackColor="Blue" ForeColor="White" OnClick="Button2_Click" />
                                    <asp:Button ID="Button3" runat="server" Text="Delete" BackColor="Red" ForeColor="White" OnClick="Button3_Click" OnClientClick="return confirm('are you sure to delete?');"  />
                                    <asp:Button ID="Button4" runat="server" Text="Search" BackColor="Green" ForeColor="White" OnClick="Button4_Click" />
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>


            <div class="col-md-12">
                <div class="mb-3">

                    <asp:GridView ID="GridView1" runat="server" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False"  >
                        <Columns>
                            <asp:BoundField DataField="StudentID" HeaderText="Student ID" />
                            <asp:BoundField DataField="StudentName" HeaderText="Student Name" />
                            <asp:BoundField DataField="Address" HeaderText="Address" />
                            <asp:BoundField DataField="Age" HeaderText="Age" />
                            <asp:BoundField DataField="Contact" HeaderText="Contact" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

        </div>

    </div>
</asp:Content>
