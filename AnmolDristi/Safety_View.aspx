<%@ Page Title="Safety Audit Records" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Safety_View.aspx.cs" Inherits="AnmolDristi.Safety_View" %>



<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-label {
            font-weight: bold;
            color: #007bff;
            display: block;
            margin-bottom: 5px;
        }

        .table-container {
            margin-top: 20px;
        }

        .btn-actions {
            width: 70px;
            height: 35px;
            padding: 5px 10px;
            text-align: center;
            display: inline-block;
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

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Safety Audit Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored Safety Audit Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <div style="overflow-x: auto;">
                         <div class="gridview-scroll">
                        <asp:GridView ID="GvSafetyAudit" runat="server" CssClass="table table-striped table-bordered"
                            AutoGenerateColumns="False" DataKeyNames="DescriptionID,AuditID" OnRowEditing="GvSafetyAudit_RowEditing"
                            OnRowUpdating="GvSafetyAudit_RowUpdating" OnRowCancelingEdit="GvSafetyAudit_RowCancelingEdit"
                            OnRowDeleting="GvSafetyAudit_RowDeleting">

                            <Columns>
                                
        <asp:BoundField DataField="AuditID" HeaderText="Audit ID" ReadOnly="True" />
                                <asp:TemplateField HeaderText="Department">
    <ItemTemplate><%# Eval("Department") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtDepartment" runat="server" Text='<%# Bind("Department") %>' CssClass="form-control form-control-sm" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Section">
    <ItemTemplate><%# Eval("Section") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtSection" runat="server" Text='<%# Bind("Section") %>' CssClass="form-control form-control-sm" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Date">
    <ItemTemplate><%# Eval("Date", "{0:yyyy-MM-dd}") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtDate" runat="server" Text='<%# Bind("Date", "{0:yyyy-MM-dd}") %>' TextMode="Date" CssClass="form-control form-control-sm" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Time">
    <ItemTemplate><%# Eval("Time") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtTime" runat="server" Text='<%# Bind("Time") %>' TextMode="Time" CssClass="form-control form-control-sm" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Vendor Code">
    <ItemTemplate><%# Eval("ContractorVendorCode") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtVendorCode" runat="server" Text='<%# Bind("ContractorVendorCode") %>' CssClass="form-control form-control-sm" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Contractor Count">
    <ItemTemplate><%# Eval("TotalContractorPeople") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtTotalContractorPeople" runat="server" Text='<%# Bind("TotalContractorPeople") %>' CssClass="form-control form-control-sm" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Internal Members">
    <ItemTemplate><%# Eval("InternalEmployees") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtInternalEmployees" runat="server" Text='<%# Bind("InternalEmployees") %>' CssClass="form-control form-control-sm" Style="min-width: 150px;" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="External Members">
    <ItemTemplate><%# Eval("ExternalMembers") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtExternalMembers" runat="server" Text='<%# Bind("ExternalMembers") %>' CssClass="form-control form-control-sm" Style="min-width: 150px;" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Description">
    <ItemTemplate><%# Eval("Description") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control form-control-sm" TextMode="MultiLine"  Style="min-height:190px; width:100%;" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Good Citizens">
    <ItemTemplate><%# Eval("GoodCitizens") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtGoodCitizens" runat="server" Text='<%# Bind("GoodCitizens") %>' CssClass="form-control form-control-sm" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Violations">
    <ItemTemplate><%# Eval("NoOfViolations") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtNoOfViolations" runat="server" Text='<%# Bind("NoOfViolations") %>' CssClass="form-control form-control-sm" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Severity">
    <ItemTemplate><%# Eval("Severity") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtSeverity" runat="server" Text='<%# Bind("Severity") %>' CssClass="form-control form-control-sm" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Violation Severity">
    <ItemTemplate><%# Eval("ViolationXSeverity") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtViolationXSeverity" runat="server" Text='<%# Bind("ViolationXSeverity") %>' CssClass="form-control form-control-sm" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="4 & 5">
    <ItemTemplate><%# Eval("FourAndFive") %></ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtFourAndFive" runat="server" Text='<%# Bind("FourAndFive") %>' CssClass="form-control form-control-sm" Style="min-width: 50px;" />
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Unsafe Act/Condition">
    <ItemTemplate>
        <%# Eval("UnsafeActConditions") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="ddlUnsafeActConditions" runat="server"
            CssClass="form-select form-select-sm"
            SelectedValue='<%# Bind("UnsafeActConditions") %>'>
            <asp:ListItem Text="Unsafe Act" Value="Unsafe Act"></asp:ListItem>
            <asp:ListItem Text="Unsafe Condition" Value="Unsafe Condition"></asp:ListItem>
        </asp:DropDownList>
    </EditItemTemplate>
</asp:TemplateField>



  <asp:TemplateField HeaderText="Submission Date">
    <ItemTemplate>
        <%# Eval("SubmittedDate", "{0:yyyy-MM-dd}") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtSubmittedDate" runat="server" Style="min-width: 120px;" 
            Text='<%# Bind("SubmittedDate", "{0:yyyy-MM-dd}") %>' 
            CssClass="form-control form-control-sm" 
            Enabled="false" />
    </EditItemTemplate>
</asp:TemplateField>

      <asp:TemplateField HeaderText="Submission Time">
    <ItemTemplate>
        <%# Eval("SubmittedTime") != DBNull.Value 
            ? TimeSpan.Parse(Eval("SubmittedTime").ToString()).ToString(@"hh\:mm") 
            : "" %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtSubmittedTime" runat="server"
            Text='<%# Eval("SubmittedTime") != DBNull.Value 
                ? TimeSpan.Parse(Eval("SubmittedTime").ToString()).ToString(@"hh\:mm") 
                : "" %>'
            CssClass="form-control form-control-sm"
            
            Enabled="false" />
    </EditItemTemplate>
</asp:TemplateField>






<asp:TemplateField HeaderText="CAPA Required">
    <ItemTemplate>
        <asp:CheckBox ID="chkRequiresCAPA" runat="server" Enabled="false"
            Checked='<%# (Eval("GenerateCAPA") != DBNull.Value) && Convert.ToBoolean(Eval("GenerateCAPA")) %>' />
    </ItemTemplate>
    <EditItemTemplate>
        <asp:CheckBox ID="chkRequiresCAPAEdit" runat="server"
            Checked='<%# (Eval("GenerateCAPA") != DBNull.Value) && Convert.ToBoolean(Eval("GenerateCAPA")) %>'  />
    </EditItemTemplate>
</asp:TemplateField>

 <asp:TemplateField HeaderText="View">
    <ItemTemplate>
        <asp:HyperLink ID="lnkView" runat="server"
            NavigateUrl='<%# Eval("AuditID", "~/Safety_DetailedView.aspx?AuditID={0}") %>'
            Text="View"
            CssClass="btn btn-info btn-actions"
            Target="_blank" />
    </ItemTemplate>
</asp:TemplateField>



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
        </div>
    </div>
</asp:Content>
