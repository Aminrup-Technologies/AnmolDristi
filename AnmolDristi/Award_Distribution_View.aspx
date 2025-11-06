<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Award_Distribution_View.aspx.cs" Inherits="AnmolDristi.Award_Distribution_View" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-container {
            margin-top: 20px;
        }
        .btn-actions {
            margin-right: 5px;
        }
    </style>

                <style>
/* Scrollable container */

.gridview-scroll table th{
    position:sticky;
}
.gridview-scroll {
    max-height: 600px !important;       /* taller container */
    max-width: 100%;         
    overflow-y: auto;
    overflow-x: auto;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    background: #fff;
}

/* Table styling - bigger text and padding */
.gridview-scroll table {
    width: 100% !important;
    border-collapse: collapse !important;
    font-size: 15px !important;        /* bigger text */
}

.gridview-scroll table th,
.gridview-scroll table td {
    padding: 18px 22px !important;     /* bigger cells */
}

/* Fixed header */
.gridview-scroll table thead th {
    position: sticky !important;
    top: 0;
    background-color: #e0e0ff !important; /* header color */
    font-weight: bold;
    font-size: 20px !important;
    z-index: 2;
    box-shadow: 0 2px 3px rgba(0,0,0,0.05);
}

/* Chrome, Edge, Safari scrollbar - bigger & visible */
.gridview-scroll::-webkit-scrollbar {
    width: 22px;   /* vertical scrollbar */
    height: 22px;  /* horizontal scrollbar */
}

.gridview-scroll::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 12px;
}

.gridview-scroll::-webkit-scrollbar-thumb {
    background: linear-gradient(180deg, #6c63ff, #4b47b8);
    border-radius: 12px;
    border: 4px solid #f1f1f1;
}

.gridview-scroll::-webkit-scrollbar-thumb:hover {
    background: linear-gradient(180deg, #4b47b8, #3b3b9c);
}

.gridview-scroll {
    overflow-y: scroll !important;  /* always show vertical scrollbar */
}


/* Firefox scrollbar */
.gridview-scroll {
    scrollbar-width: auto;   
    scrollbar-color: #6c63ff #f1f1f1;
}

.large-textbox {
    width: 100%;      /* full width of the parent container */
    max-width: 100%;  /* ensures it doesn’t overflow */
    height: 200px;    /* optional: increase height */
    resize: vertical; /* user can resize vertically if needed */
}
</style>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <h3>Award Distribution Records</h3>
            
            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored Awards</h2>
                    <div class="clearfix"></div>
                </div>


                <div class="x_content table-container">
                    <div style="overflow-x: auto;">
                        <div class="gridview-scroll">
                    <asp:GridView ID="GvAwards" runat="server" CssClass="table table-bordered"
                        AutoGenerateColumns="False" DataKeyNames="ADR_ID,Award_ID"
                        OnRowEditing="GvAwards_RowEditing"
                        OnRowUpdating="GvAwards_RowUpdating"
                        OnRowCancelingEdit="GvAwards_RowCancelingEdit"
                        OnRowDeleting="GvAwards_RowDeleting">

                        <Columns>


                              <asp:TemplateField HeaderText="Award ID">
                                      <ItemTemplate><%# Eval("Award_ID") %></ItemTemplate>
                                      <EditItemTemplate>
                                          <asp:TextBox ID="txtAward_ID" runat="server" Text='<%# Bind("Award_ID") %>' CssClass="form-control" />
                                      </EditItemTemplate>
                                  </asp:TemplateField>




                            <asp:TemplateField HeaderText="Award Date">
                                <ItemTemplate><%# Eval("DateOfAwardDistribution", "{0:yyyy-MM-dd}") %></ItemTemplate>
                                 <EditItemTemplate>
        <asp:TextBox ID="txtDateOfAwardDistribution" runat="server" 
                     Text='<%# Bind("DateOfAwardDistribution", "{0:yyyy-MM-dd}") %>' 
                     CssClass="form-control" 
                     TextMode="Date" />
    </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Event">
                                <ItemTemplate><%# Eval("EventName") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEventName" runat="server" Text='<%# Bind("EventName") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Employee ID">
                                <ItemTemplate><%# Eval("EmpId") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEmpId" runat="server" Text='<%# Bind("EmpId") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Employee Name">
                                <ItemTemplate><%# Eval("EmpName") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEmpName" runat="server" Text='<%# Bind("EmpName") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Designation">
                                <ItemTemplate><%# Eval("Designation") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDesignation" runat="server" Text='<%# Bind("Designation") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>



                                <asp:TemplateField HeaderText="Award Category">
                                            <ItemTemplate>
                                                <%# Eval("AwardCategory") %>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlEditAwardCategory" runat="server" 
                                                    CssClass="form-control" 
                                                    SelectedValue='<%# Bind("AwardCategory") %>'>
                                                     <asp:ListItem Text="Top Performer Award" Value="Top Performer Award"></asp:ListItem>
                                                     <asp:ListItem Text="Perfect Attendance Awards" Value="Perfect Attendance Awards"></asp:ListItem>
                                                     <asp:ListItem Text="Safety Awards" Value="Safety Awards"></asp:ListItem>
                                                     <asp:ListItem Text="Volunteer Awards" Value="Volunteer Awards"></asp:ListItem>
                                                    <asp:ListItem Text="Team Recognition" Value="Team Recognition"></asp:ListItem>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>


                          

                          <%--  <asp:TemplateField HeaderText="Submission Date">
                                <ItemTemplate><%# Eval("SubmittedDate", "{0:yyyy-MM-dd}") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSubmittedDate" runat="server" Text='<%# Bind("SubmittedDate", "{0:yyyy-MM-dd}") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Submission Time">
                                <ItemTemplate><%# Eval("SubmittedTime") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSubmittedTime" runat="server" Text='<%# Bind("SubmittedTime") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>--%>

                            <asp:TemplateField HeaderText="Image Path">
                                <ItemTemplate><%# Eval("ImagePath") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtImagePath" runat="server" Text='<%# Bind("ImagePath") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

        <asp:TemplateField HeaderText="Actions">
    <ItemTemplate>
        <asp:HyperLink ID="lnkViewAward" runat="server"
            NavigateUrl='<%# Eval("Award_ID", "~/Award_DetailedView.aspx?id={0}") %>'
            Text="View"
            CssClass="btn btn-info btn-actions btn-sm"
            Target="_blank" />
    
        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning btn-actions btn-sm" CommandName="Edit">Edit</asp:LinkButton>
        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-actions btn-sm" CommandName="Delete"
            OnClientClick="return confirm('Are you sure?');">Delete</asp:LinkButton>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-actions" CommandName="Update">Update</asp:LinkButton>
        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary btn-actions" CommandName="Cancel">Cancel</asp:LinkButton>
    </EditItemTemplate>
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



               <%-- <div class="x_content table-container">
                    <asp:GridView ID="GvAwards" runat="server" CssClass="table table-bordered"
                        AutoGenerateColumns="False" DataKeyNames="ADR_ID"
                        OnRowEditing="GvAwards_RowEditing"
                        OnRowUpdating="GvAwards_RowUpdating"
                        OnRowCancelingEdit="GvAwards_RowCancelingEdit"
                        OnRowDeleting="GvAwards_RowDeleting">

                        <Columns>
                            <asp:BoundField DataField="DateOfAwardDistribution" HeaderText="Award Date" SortExpression="DateOfAwardDistribution" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="EventName" HeaderText="Event" SortExpression="EventName" />
                            <asp:BoundField DataField="EmpId" HeaderText="Employee ID" SortExpression="EmpId" />
                            <asp:BoundField DataField="EmpName" HeaderText="Employee Name" SortExpression="EmpName" />
                            <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation" />
                            <asp:BoundField DataField="Award_ID" HeaderText="Award ID" SortExpression="Award_ID" />
                            <asp:BoundField DataField="SubmittedDate" HeaderText="Submission Date" SortExpression="SubmittedDate" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="SubmittedTime" HeaderText="Submission Time" SortExpression="SubmittedTime" />
                            <asp:BoundField DataField="ImagePath" HeaderText="Image Path" SortExpression="ImagePath" />

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning btn-actions" CommandName="Edit">Edit</asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-actions" CommandName="Delete" OnClientClick="return confirm('Are you sure?');">Delete</asp:LinkButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-actions" CommandName="Update">Update</asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary btn-actions" CommandName="Cancel">Cancel</asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>--%>
