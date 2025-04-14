<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Line_walk_report.aspx.cs" Inherits="AnmolDristi.Line_walk_report" %>

<%@ Register TagPrefix="asp" Namespace="System.Web.UI.WebControls" Assembly="System.Web" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .summary-panel {
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            margin-top: 20px;
            background-color: #f9f9f9;
        }

        .summary-heading {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }

        .summary-row {
            display: flex;
            flex-direction: row;
            /*    flex-wrap: wrap;*/
            gap: 10px;
            justify-content: space-between;
        }

        .summary-column {
            /*    flex: 1 1 48%;*/
            min-width: 300px;
        }

            .summary-column h5 {
                font-weight: 500;
                border-bottom: 1px solid #ddd;
                padding-bottom: 5px;
                margin-bottom: 10px;
                text-align: center;
            }


        /*    .container {
          max-width: 100%;
          padding: 15px;
      }*/
        .title_left h5 {
            padding-left: 25px;
        }

        .table-wrapper {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin-left: 220px;
        }

        .table-responsive {
            overflow-x: auto;
            width: 100%;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

            .table th, .table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }

            .table th {
                background-color: #f4f4f4;
            }

        .btn {
            display: inline-block;
            padding: 8px 12px;
            font-size: 14px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }

            .btn:hover {
                background-color: #0056b3;
            }

        /* Responsive Design */
        @media screen and (max-width: 768px) {
            .table th, .table td {
                padding: 8px;
                font-size: 12px;
            }

            .btn {
                padding: 6px 10px;
                font-size: 12px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h5>Line Walk Status Report</h5>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_content">
                            <div class="col-md-12">
                                <div class="mb-3">

                                    <asp:GridView ID="GridViewLineWalk" runat="server" CssClass="table"
                                        AutoGenerateColumns="False" DataKeyNames="ID"
                                        OnRowCommand="GridViewLineWalk_RowCommand">
                                        <Columns>
                                            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" />
                                            <asp:BoundField DataField="WalkDate" HeaderText="Walk Date" DataFormatString="{0:yyyy-MM-dd}" />
                                            <asp:BoundField DataField="JobDescription" HeaderText="Job Description" />
                                            <asp:BoundField DataField="JobID" HeaderText="Job ID" />

                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnViewDetails" runat="server" CssClass="btn"
                                                        Text="View Details" CommandName="ViewDetails" CommandArgument='<%# Eval("ID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>

                                    <asp:Panel ID="pnlDetails" runat="server" Visible="false" CssClass="summary-panel">
                                        <%--    <h3 class="summary-heading">Line Walk Summary</h3>--%>

                                        <div class="summary-row">
                                            <!-- Team Members -->
                                            <div class="summary-column summary-column-team">
                                                <h5>Team Members</h5>
                                                <asp:GridView ID="GridViewTeamMembers" runat="server" CssClass="table" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:BoundField DataField="TM_names" HeaderText="Name" />
                                                        <asp:BoundField DataField="TM_Image" HeaderText="Image Path" />
                                                    </Columns>
                                                </asp:GridView>
                                            </div>

                                            <!-- Walk Details -->
                                            <div class="summary-column summary-column-walk">
                                                <h5>Walk Details</h5>
                                                <asp:GridView ID="GridViewWalkDetails" runat="server" CssClass="table" AutoGenerateColumns="False">
                                                    <Columns>
                                                        <asp:BoundField DataField="Location" HeaderText="Location" />
                                                        <asp:BoundField DataField="Observation_Points" HeaderText="Observations" />
                                                        <asp:BoundField DataField="Recommendation_Points" HeaderText="Recommendations" />
                                                        <asp:BoundField DataField="Responsibility" HeaderText="Responsibility" />
                                                        <asp:BoundField DataField="Target_Date" HeaderText="Target Date" DataFormatString="{0:yyyy-MM-dd}" />
                                                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                                        <asp:BoundField DataField="Snap_File_Path" HeaderText="Snap Path" />
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </asp:Panel>



                                </div>
                            </div>
                        </div>
                    </div>
                    <%--button start--%>

                <%--    <div class="col-md-6">
                        <div class="mb-3">
                            <div class="input-group input-group-sm">

                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-warning btn-sm" ValidationGroup="Update" CausesValidation="true" OnClick="btnUpdate_Click" />
                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm" ValidationGroup="Delete" CausesValidation="false" OnClick="btnDelete_Click" />
                                <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary btn-sm" ValidationGroup="Cancel" CausesValidation="false" OnClick="btnCancel_Click" />


                            </div>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
