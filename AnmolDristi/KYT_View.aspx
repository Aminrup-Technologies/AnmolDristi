<%@ Page Title="KYT Records" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="KYT_View.aspx.cs" Inherits="AnmolDristi.KYT_View" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-label {
            font-weight: bold;
            color: blue;
            display: block;
            margin-bottom: 5px;
        }

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

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>KYT Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored KYT Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <div style="overflow-x: auto;">
                       <div class="gridview-scroll">
                        <asp:GridView ID="GvKYTRecords" runat="server" CssClass="table table-striped table-bordered"
                            AutoGenerateColumns="False" DataKeyNames="ID,KYT_Table2ID" OnRowEditing="GvKYTRecords_RowEditing"
                            OnRowUpdating="GvKYTRecords_RowUpdating" OnRowCancelingEdit="GvKYTRecords_RowCancelingEdit"
                            OnRowDeleting="GvKYTRecords_RowDeleting">

                            
                               <Columns>

                                   <asp:BoundField DataField="KYT_Table2ID" HeaderText="kytid" Visible="false" />
                                   
        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" />

        <asp:TemplateField HeaderText="Worksite">
            <ItemTemplate>
                <%# Eval("KYT_WorksiteName") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtWorksiteName" runat="server" Text='<%# Bind("KYT_WorksiteName") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Department">
            <ItemTemplate>
                <%# Eval("KYT_Department") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtDepartment" runat="server" Text='<%# Bind("KYT_Department") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Location">
            <ItemTemplate>
                <%# Eval("KYT_Location") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtLocation" runat="server" Text='<%# Bind("KYT_Location") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>

                                
                                   <asp:TemplateField HeaderText="Date">
    <ItemTemplate>
        <%# Eval("KYT_Date", "{0:dd-MM-yyyy}") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtKYTDate" runat="server"
            Text='<%# Bind("KYT_Date", "{0:yyyy-MM-dd}") %>'
            CssClass="form-control"
            TextMode="Date">
        </asp:TextBox>
    </EditItemTemplate>
</asp:TemplateField>





                   <asp:TemplateField HeaderText="Job ID">
            <ItemTemplate>
                <%# Eval("KYT_JobID") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtJobID" runat="server" Text='<%# Bind("KYT_JobID") %>'></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>
                               <%-- <asp:BoundField DataField="KYT_Activity" HeaderText="Activity" />
                                <asp:BoundField DataField="KYT_SOPNo" HeaderText="SOP No" />
                                <asp:BoundField DataField="KYT_Vendor" HeaderText="Vendor" />
                                <asp:BoundField DataField="KYT_HiddenHazards" HeaderText="Hidden Hazards" />
                                <asp:BoundField DataField="KYT_Consequence" HeaderText="Consequence" />
                                <asp:BoundField DataField="KYT_CounterMeasures" HeaderText="Counter Measures" />
                                <asp:BoundField DataField="KYT_PriorityValue" HeaderText="Priority" />
                                <asp:BoundField DataField="SubmissionDate" HeaderText="Submission Date"  />
                                <asp:BoundField DataField="SubmissionTime" HeaderText="Submission Time" />--%>




                                   <%--Activity --%>
<asp:TemplateField HeaderText="Activity">
    <ItemTemplate>
        <%# Eval("KYT_Activity") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtActivity" runat="server" 
            Text='<%# Bind("KYT_Activity") %>' CssClass="form-control"></asp:TextBox>
    </EditItemTemplate>
</asp:TemplateField>


<asp:TemplateField HeaderText="SOP No">
    <ItemTemplate>
        <%# Eval("KYT_SOPNo") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtSOPNo" runat="server" 
            Text='<%# Bind("KYT_SOPNo") %>' CssClass="form-control"></asp:TextBox>
    </EditItemTemplate>
</asp:TemplateField>


<asp:TemplateField HeaderText="Vendor">
    <ItemTemplate>
        <%# Eval("KYT_Vendor") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtVendor" runat="server" 
            Text='<%# Bind("KYT_Vendor") %>' CssClass="form-control"></asp:TextBox>
    </EditItemTemplate>
</asp:TemplateField>


<asp:TemplateField HeaderText="Hidden Hazards">
    <ItemTemplate>
        <%# Eval("KYT_HiddenHazards") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtHazards" runat="server" 
            Text='<%# Bind("KYT_HiddenHazards") %>' TextMode="MultiLine"
            CssClass="form-control"></asp:TextBox>
    </EditItemTemplate>
</asp:TemplateField>


<asp:TemplateField HeaderText="Consequence">
    <ItemTemplate>
        <%# Eval("KYT_Consequence") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtConsequence" runat="server" 
            Text='<%# Bind("KYT_Consequence") %>' TextMode="MultiLine"
            CssClass="form-control"></asp:TextBox>
    </EditItemTemplate>
</asp:TemplateField>


<asp:TemplateField HeaderText="Counter Measures">
    <ItemTemplate>
        <%# Eval("KYT_CounterMeasures") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtCounterMeasures" runat="server" 
            Text='<%# Bind("KYT_CounterMeasures") %>' TextMode="MultiLine"
            CssClass="form-control"></asp:TextBox>
    </EditItemTemplate>
</asp:TemplateField>


<asp:TemplateField HeaderText="Priority">
    <ItemTemplate>
        <%# Eval("KYT_PriorityValue") %>
    </ItemTemplate>
   <EditItemTemplate>
        <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-control"
            SelectedValue='<%# Bind("KYT_PriorityValue") %>'>
             <asp:ListItem Text="Low" Value="Low" />
 <asp:ListItem Text="Medium" Value="Medium" />
 <asp:ListItem Text="High" Value="High" />
        </asp:DropDownList>
    </EditItemTemplate>
</asp:TemplateField>


                                   <asp:TemplateField HeaderText="Photograph">
    <ItemTemplate>
        <asp:Image ID="imgPhoto" runat="server" 
            ImageUrl='<%# Eval("KYT_PhotographPath") %>' 
            Width="100px" Height="100px" 
            Style="border-radius:8px; object-fit:cover;" 
            AlternateText="No Image" />
    </ItemTemplate>

    
    <EditItemTemplate>
        <asp:FileUpload ID="Photograph" runat="server" CssClass="form-control" />
    </EditItemTemplate>
</asp:TemplateField>






   <asp:TemplateField HeaderText="Submission Date">
    <ItemTemplate>
        <%# Eval("SubmissionDate", "{0:dd-MM-yyyy}") %>
    </ItemTemplate>
   
</asp:TemplateField>


<asp:TemplateField HeaderText="Submission Time">
    <ItemTemplate>
        <%# Eval("SubmissionTime") == DBNull.Value 
            ? "" 
            : DateTime.Today.Add((TimeSpan)Eval("SubmissionTime")).ToString("HH:mm") %>
    </ItemTemplate>
    
</asp:TemplateField>















                                            
            <asp:TemplateField HeaderText="CAPA Created">
   <%-- <ItemTemplate>
        <asp:CheckBox ID="chkRequiresCAPAView" runat="server" Enabled="false"
            Checked='<%# Convert.ToBoolean(Eval("RequiresCAPA")) %>' />
    </ItemTemplate>--%>


                <ItemTemplate>
    <asp:CheckBox ID="chkRequiresCAPAView" runat="server" Enabled="false"
        Checked='<%# Eval("IsCAPAChecked") != DBNull.Value && Convert.ToInt32(Eval("IsCapaChecked")) == 1 %>' />
</ItemTemplate>

    <EditItemTemplate>
    <asp:CheckBox ID="chkRequiresCAPAEdit" runat="server" 
        Checked='<%# Eval("IsCAPAChecked") != DBNull.Value && Convert.ToInt32(Eval("IsCapaChecked")) == 1 %>' />
</EditItemTemplate>

</asp:TemplateField>



                             <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:HyperLink ID="lnkView" runat="server"
                                        NavigateUrl='<%# Eval("ID", "~/KYT_DetailedView.aspx?ID={0}") %>'
                                        Text="View"
                                        CssClass="btn btn-info btn-actions btn-sm"
                                        Target="_blank" />

                                           <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning btn-actions btn-sm" CommandName="Edit">Edit</asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-actions btn-sm" CommandName="Delete" OnClientClick="return confirm('Are you sure?');">Delete</asp:LinkButton>
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
