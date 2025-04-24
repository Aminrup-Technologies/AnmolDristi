<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="FullBodyHarnessInspection_View.aspx.cs" Inherits="AnmolDristi.FullBodyHarnessInspection_View" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <<div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Automation And Technical services
                    </h3>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Search Filter For HouseKeeping Audit 
                            </h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">


                            <div class="col-md-6">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_txdate" runat="server" AssociatedControlID="txdate" Text="From Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_txdate" runat="server" ErrorMessage="*" ControlToValidate="txdate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="txdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" ></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-6">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_ttodate" runat="server" AssociatedControlID="ttodate" Text="To Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                     <asp:RequiredFieldValidator ID="RFV_ttodate" runat="server" ErrorMessage="*" ControlToValidate="ttodate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>                                   
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="ttodate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" ></asp:TextBox>
                                    </div>
                                </div>
                            </div>



                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Button ID="BtnSearch" runat="server" Text="Search" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSearch_Click" />
                                    <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-sm btn-danger" CausesValidation="false" OnClientClick="BtnReset_Click" />
                                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>

            
<div class="table-responsive">
                <div class="x_content">
                    <div class="col-md-12">
                        <div class="mb-3">
                            <asp:GridView ID="gvInspection" runat="server" AutoGenerateColumns="False"  DataKeyNames="InspectionID" CssClass="table table-striped table-bordered table-hover ">
                                <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
                                <Columns>
                                    <asp:BoundField DataField="InspectionID" HeaderText="Inspection ID" />
                                     <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
                                    <asp:BoundField DataField="Site" HeaderText="Site" />
                                    <asp:BoundField DataField="InspectedBy" HeaderText="Inspected By"/>
                                    <asp:BoundField DataField="DateOfInspection" HeaderText="Date Of Inspection" />  
                                     <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                       <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-warning btn-sm" CommandArgument='<%# Eval("InspectionID") %>' OnClick="BtnEdit_Click" />
                                       <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm" OnClick="BtnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete this meeting?');" />
                                    </ItemTemplate>
                                   </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
        var fromDate = document.getElementById('<%= txdate.ClientID %>');
        var toDate = document.getElementById('<%= ttodate.ClientID %>');

    if (fromDate && toDate) {
        toDate.addEventListener("change", function () {
            validateDates(fromDate, toDate);
        });
    }
});

function validateDates(fromDateElement, toDateElement) {
    var fromDate = fromDateElement.value;
    var toDate = toDateElement.value;

    if (fromDate && toDate) {
        var from = new Date(fromDate);
        var to = new Date(toDate);

        if (from > to) {
            alert("Invalid Date!.");
            toDateElement.value = ""; // Clear To Date field
        }
    }
}


    </script>
</asp:Content>
