<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="View_Maasmeeting.aspx.cs" Inherits="AnmolDristi.View_Maasmeeting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script>
        function printMeetingSection() {
            var printContent = document.getElementById('printSection').innerHTML;
            var win = window.open('', '', 'width=900,height=700');
            win.document.write(`
            <html>
                <head>
                    <title>Mass Meeting Print</title>
                    <style>
                        body { font-family: 'Segoe UI', sans-serif; padding: 10px; }
                          h5 {
                            text-align: center;
                            margin-top: 5px;
                            padding: 10px 15px;
                            color: #006400 !important;
                            border: 2px solid #555;
                            border-radius: 8px;
                            display: inline-block;
                            -webkit-print-color-adjust: exact !important;
                            print-color-adjust: exact !important;
                          }
                        table { width: 100%; margin-bottom: 20px; }
                        th {
                            background: #4a5568 !important;
                        color: white;
                        -webkit-print-color-adjust: exact !important;
                        print-color-adjust: exact !important;
                        }
                        th, td { padding: 8px; border: 1px solid #ccc;}
                        .img-fluid { max-width: 100%; height: auto; }
                    </style>
                </head>
                <body onload="window.print(); window.close();">
                    ${printContent}
                </body>
            </html>
        `);
            win.document.close();
        }
    </script>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h5 style="text-align: center; font-weight: bold;" class="text-success">Detailed View Page</h5>
            </div>
        </div>

        <div class="clearfix"></div>

        <div class="row">
            <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2 style="text-align: left; padding-left: 20px; font-weight: bold;" class="text-success">ATS/DOC/MM/0010 || REV 00 || EFFT DATE- 19/12/18</h2>
                        <ul class="nav navbar-right panel_toolbox">
                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                           
                        <div id="printSection">
                        <div class="container mt-4">
                             <div style="text-align: center; margin-top: 10px; margin-bottom: 10px;">
                                    <h5 style="border: 2px solid black; padding: 5px; display: inline-block;color:black;">
                                      Mass Meeting Details
                                    </h5>
                                     

                                <div class="table-responsive">
                                    <table class="table table-sm table-bordered">
                                        <tbody>
                                            <tr>
                                                <th>Mass Meeting Document No</th>
                                                <td><asp:Label ID="txtMMDocNo" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <th>Meeting Date</th>
                                                <td><asp:Label ID="txtMeetingDate" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <th>Meeting Start Time</th>
                                                <td><asp:Label ID="txtStartTime" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <th>Meeting End Time</th>
                                                <td><asp:Label ID="txtEndTime" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <th>Meeting Duration(In Mins)</th>
                                                <td><asp:Label ID="txtDuration" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <th>Work Region</th>
                                                <td><asp:Label ID="txtRegionCode" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <th>Company</th>
                                                <td><asp:Label ID="txtCompanyCode" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <th>Department</th>
                                                <td><asp:Label ID="txtDeptCode" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <th>Location</th>
                                                <td><asp:Label ID="txtLocationCode" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <th>Exact Location</th>
                                                <td><asp:Label ID="txtExactLocation" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <th>Co-Ordinator Name</th>
                                                <td><asp:Label ID="txtCoordinator" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <th>Photo</th>
                                                <td><asp:Image ID="imgPhoto" runat="server" Width="200px" CssClass="img-fluid rounded" Visible="false" /></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div style="text-align: center; margin-top: 10px; margin-bottom: 10px;">
                                   <h5 style="border: 2px solid black; padding: 5px; display: inline-block;color:black;">
                                     Attendee Details
                                   </h5>
                                 </div>
                                <div class="table-responsive">
                                    <asp:GridView ID="gvAttendees" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped table-sm">
                                        <HeaderStyle CssClass="thead-dark" />
                                        <Columns>
                                            <asp:BoundField DataField="Attendee_Type" HeaderText="Attendee Type" />
                                            <asp:BoundField DataField="AttendeeCode" HeaderText="Attendee Code" />
                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
                                            <asp:BoundField DataField="Designation" HeaderText="Designation" />
                                            <asp:BoundField DataField="Gate_passno" HeaderText="Gate Pass No" />
                                        </Columns>
                                    </asp:GridView>
                                </div>

                               <div style="text-align: center; margin-top: 10px; margin-bottom: 10px;">
                                      <h5 style="border: 2px solid black ; padding: 5px; display: inline-block;color:black;">
                                        Points Discussed
                                      </h5>
                                    </div>

                                <div class="table-responsive">
                                    <asp:GridView ID="gvMOM" runat="server" AutoGenerateColumns="False"
                                        CssClass="table table-bordered table-striped table-sm"
                                        ShowHeaderWhenEmpty="True" EmptyDataText="No MOM entries found." OnRowDataBound="gvMOM_RowDataBound">
                                        <HeaderStyle CssClass="thead-dark" />
                                        <Columns>
                                            <asp:BoundField DataField="AgendaTitle" HeaderText="Agenda Title" />
                                            <asp:BoundField DataField="EmployeeType" HeaderText="Employee Type" />
                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
                                            <asp:BoundField DataField="Description" HeaderText="Description" />
                                            <asp:BoundField DataField="PointRaisedBy" HeaderText="Point Raised By" />
                                            <asp:TemplateField HeaderText="CAPA ID">
                                                <ItemTemplate>
                                                    <asp:HyperLink 
                                                            runat="server" 
                                                            ID="lnkCapa" 
                                                            ForeColor="Black" 
                                                            ToolTip="View CAPA Details"
                                                           />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="DiscussionTime" HeaderText="Discussion Time(In Mins)" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                           </div>
                         </div>
                           <div class="text-center mt-4">
                                <button class="btn btn-primary" onclick="printMeetingSection()">Print</button>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>

</asp:Content>
