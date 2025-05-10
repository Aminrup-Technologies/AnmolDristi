<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="committee_meeting_report.aspx.cs" Inherits="AnmolDristi.committee_meeting_report" %>

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

        .input-group-sm input, .form-control-sm {
            width: 100%;
        }

        #gvMeetings th, #gvMeetings td {
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
    <div class="right_col" role="main">
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
                            <h2>Search Filter For Committee Meeting
                            </h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">


                            <div class="col-md-6">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_txtFromDate" runat="server" AssociatedControlID="txtFromDate" Text="From Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_txtFromDate" runat="server" ErrorMessage="*" ControlToValidate="txtFromDate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-6">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_txtToDate" runat="server" AssociatedControlID="txtToDate" Text="To Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Select Date" ControlToValidate="TB_Date" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    --%>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>



                            <div class="col-md-3">
                                <div class="mb-3">
                                    <asp:Button ID="BtnSubmit" runat="server" Text="Search" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
                                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                                    <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-sm btn-danger" CausesValidation="false" OnClick="BtnReset_Click" />
                                    <asp:Button ID="btn_home" runat="server" Text="Back" CssClass="btn btn-sm btn-primary" CausesValidation="false" PostBackUrl="~/Home.aspx" />
                                </div>
                            </div>
                            <div class="table-responsive">
                                <div class="x_content">
                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <asp:GridView ID="gvMeeting" runat="server" AutoGenerateColumns="False" DataKeyNames="MeetingID" 
                                                CssClass="table table-striped table-bordered table-hover " ShowHeaderWhenEmpty="true" EmptyDataText="No records for selected filter">

                                                <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
                                                <Columns>
                                                    <asp:BoundField DataField="MeetingID" HeaderText="Meeting ID" />
                                                    <asp:BoundField DataField="MeetingDate" HeaderText="Date" />
                                                    <asp:BoundField DataField="MeetingTime" HeaderText="Time" />
                                                    <asp:BoundField DataField="MeetingNo" HeaderText="Meeting No" />
                                                    <asp:BoundField DataField="Venue" HeaderText="Venue" />
                                                    <asp:BoundField DataField="Title" HeaderText="Title" />
                                                    <asp:BoundField DataField="ChairedBy" HeaderText="Chaired By" />
                                                    <asp:TemplateField HeaderText="Actions">
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-warning btn-sm" CommandArgument='<%# Eval("MeetingID") %>' OnClick="BtnEdit_Click" />
                                                            <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm" OnClick="BtnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete this meeting?');" />
                                                            <asp:Button ID="BtnView" runat="server" Text="View" CssClass="btn btn-primary btn-sm" CommandArgument='<%# Eval("MeetingID") %>' OnClick="BtnView_Click" />

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

                </div>
            </div>



        </div>

    </div>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
    var fromDate = document.getElementById('<%= txtFromDate.ClientID %>');
    var toDate = document.getElementById('<%= txtToDate.ClientID %>');

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
