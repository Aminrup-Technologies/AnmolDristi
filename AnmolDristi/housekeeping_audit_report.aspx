<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="housekeeping_audit_report.aspx.cs" Inherits="AnmolDristi.housekeeping_audit_report" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .btn-fixed-size {
            width: 100px;
            text-align: center;
            font-size: 14px;
            padding: 5px 0;
        }

        .points-input {
            margin-right: 10px;
        }

        .container {
            padding: 20px;
        }

        

        #gvAudit th, #gvAudit td {
            white-space: nowrap;
        }


        .table-responsive {
            width: 100%;
            max-height: 400px; /* Adjust based on need */
            overflow-x: auto;
            overflow-y: auto;
            -webkit-overflow-scrolling: touch;
        }

        @media (max-width: 768px) {
            .table-responsive {
                max-height: 300px; /* Adjust based on your UI */
            }
        }
    </style>

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
                                    <asp:Label ID="lbl_txtfromdate" runat="server" AssociatedControlID="txtfromdate" Text="From Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_txtfromdate" runat="server" ErrorMessage="*" ControlToValidate="txtfromdate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="txtfromdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" ></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-6">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_txttodate" runat="server" AssociatedControlID="txttodate" Text="To Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                     <asp:RequiredFieldValidator ID="RFV_txttodate" runat="server" ErrorMessage="*" ControlToValidate="txttodate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="txttodate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date" ></asp:TextBox>
                                    </div>
                                </div>
                            </div>



                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Button ID="BtnSubmit" runat="server" Text="Search" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
                                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                                    <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-sm btn-danger" CausesValidation="false" OnClientClick="BtnReset_Click" />
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
                            <asp:GridView ID="gvAudit" runat="server" AutoGenerateColumns="False"  DataKeyNames="AuditID" CssClass="table table-striped table-bordered table-hover ">

                                <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
                                <Columns>
                                    <asp:BoundField DataField="AuditID" HeaderText="Audit ID" />
                                     <asp:BoundField DataField="Title" HeaderText="Title" />
                                    <asp:BoundField DataField="AuditDate" HeaderText="Date" />
                                    <asp:BoundField DataField="Location" HeaderText="Location"/>
                                    <asp:BoundField DataField="ObserverID" HeaderText="Observer ID" />                                
                                    <asp:BoundField DataField="OpenBy" HeaderText="Open By" />
                                     <asp:BoundField DataField="CloseBy" HeaderText="Close By" />
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-warning btn-sm" CommandArgument='<%# Eval("AuditID") %>' OnClick="BtnEdit_Click" />
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
    var fromDate = document.getElementById('<%= txtfromdate.ClientID %>');
    var toDate = document.getElementById('<%= txttodate.ClientID %>');

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
            alert("Invalid Date! 'To Date' must be greater than 'From Date'.");
            toDateElement.value = ""; // Clear To Date field
        }
    }
}


    </script>
</asp:Content>
