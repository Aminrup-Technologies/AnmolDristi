<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="D_and_Bow_View.aspx.cs" Inherits="AnmolDristi.D_and_Bow_View" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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



    <script type="text/javascript">
    function toggleRemarksAndPhoto(dropdown, prefix) {
        //var selectedValue = dropdown.value;
        //var panel = dropdown.closest('tr').querySelector('[id*="pnl' + prefix + 'Details"]');
        //if (selectedValue === "False") {
        //    panel.style.display = 'block';
        //} else {
        //    panel.style.display = 'none';
        //}



        var selectedValue = dropdown.value;
        var panel = dropdown.closest('tr').querySelector('[id*="pnl' + prefix + 'Details"]');

        if (!panel) return;

        // Find input fields inside the panel
        var remarkBox = panel.querySelector('input[type="text"], textarea');
        var fileUpload = panel.querySelector('input[type="file"]');
        var existingPhoto = panel.querySelector('label[id*="lblExisting"]');

        if (selectedValue === "False") {
            // Show remark/photo section
            panel.style.display = 'block';
        } else {
            // Hide and clear fields when switching to "True"
            panel.style.display = 'none';
            if (remarkBox) remarkBox.value = "";
            if (fileUpload) fileUpload.value = "";
            if (existingPhoto) existingPhoto.textContent = "";
        }





    }

   
    window.onload = function () {
        const dropdowns = document.querySelectorAll("select[id*='ddlShacklesIsYes'], select[id*='ddlChainPulleyIsYes']");
        dropdowns.forEach(dd => {
            if (dd.value === "False") {
                const prefix = dd.id.includes("Shackles") ? "Shackles" : "ChainPulley";
                toggleRemarksAndPhoto(dd, prefix);
            }
        });
    };
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>D and Bow Checklist Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>D and Bow Checklist Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <div style="overflow-x: auto;">
                         <div class="gridview-scroll">
                   <asp:GridView ID="GvDandBowChecklist" runat="server" CssClass="table table-striped table-bordered"
    AutoGenerateColumns="False" DataKeyNames="BasicID,EquipmentType" OnRowEditing="GvDandBowChecklist_RowEditing"
    OnRowUpdating="GvDandBowChecklist_RowUpdating" OnRowCancelingEdit="GvDandBowChecklist_RowCancelingEdit"
    OnRowDeleting="GvDandBowChecklist_RowDeleting"
    OnRowDataBound="GvDandBowChecklist_RowDataBound">

    <Columns>
            <asp:BoundField DataField="HeaderID" HeaderText="Header ID" /> 
        <asp:BoundField DataField="EquipmentType" HeaderText="Equipment Type" ReadOnly="true" />

        <asp:BoundField DataField="Site" HeaderText="Site" />
        <asp:BoundField DataField="TagNo" HeaderText="Tag No" />
        <asp:BoundField DataField="InspectionDate" HeaderText="Inspection Date" DataFormatString="{0:yyyy-MM-dd}" />
        
    <asp:BoundField DataField="JobID" HeaderText="Job ID" />
   <asp:TemplateField HeaderText="Job Name">
    <ItemTemplate>
        <%# Eval("JobName") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtJobName" runat="server" Text='<%# Bind("JobName") %>' />
    </EditItemTemplate>
</asp:TemplateField>

       <asp:TemplateField HeaderText="Shackles Question">
    <ItemTemplate>
        <%# Eval("ChecklistQuestion") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:Label ID="txtShacklesQuestion" runat="server" 
                     Text='<%# Bind("ChecklistQuestion") %>' />
    </EditItemTemplate>
</asp:TemplateField>

       <asp:TemplateField HeaderText="Shackles Is Yes">
    <ItemTemplate>
        <%# Eval("IsYes") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="ddlShacklesIsYes" runat="server" CssClass="form-control"
    SelectedValue='<%# Bind("IsYes") %>' onchange="toggleRemarksAndPhoto(this, 'Shackles')" style="width:150px;">
    <asp:ListItem Text="True" Value="True" />
    <asp:ListItem Text="False" Value="False" />
</asp:DropDownList>

    </EditItemTemplate>
</asp:TemplateField>

<%--<asp:TemplateField HeaderText="Shackles Remarks & Photo">
    <ItemTemplate>
        <%# Eval("Remarks") %> <br />
        <%# Eval("PhotoPath") %>
    </ItemTemplate>
    <EditItemTemplate>
    <asp:Panel ID="pnlShacklesDetails" runat="server" Style="display:none;">
        <asp:TextBox ID="txtShacklesRemarks" runat="server" CssClass="form-control" 
                     Text='<%# Bind("Remarks") %>' placeholder="Enter Remarks" />
        <asp:FileUpload ID="fileShacklesPhoto" runat="server" CssClass="form-control" />
        <asp:Label ID="lblExistingShacklesPhoto" runat="server" 
                   Text='<%# Eval("PhotoPath") %>' Visible="false" />
    </asp:Panel>
</EditItemTemplate>

</asp:TemplateField>--%>


        <asp:TemplateField HeaderText="Shackles Remarks">
    <ItemTemplate>
        <%# Eval("Remarks") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtShacklesRemarks" runat="server" CssClass="form-control"
                     Text='<%# Bind("Remarks") %>' placeholder="Enter Remarks" />
    </EditItemTemplate>
</asp:TemplateField>



        <asp:TemplateField HeaderText="Shackles Photo">
    <ItemTemplate>
        <asp:Image ID="imgShacklesPhoto" runat="server" Width="60" Height="60"
            ImageUrl='<%# Eval("PhotoPath") %>'
            Visible='<%# Convert.ToInt32(Eval("IsYes")) == 0 && !string.IsNullOrEmpty(Eval("PhotoPath").ToString()) %>' />

        <asp:Label ID="lblNoPhoto" runat="server" Text="No photo uploaded" ForeColor="Gray"
            Visible='<%# Convert.ToInt32(Eval("IsYes")) == 0 && string.IsNullOrEmpty(Eval("PhotoPath").ToString()) %>' />
    </ItemTemplate>

    <EditItemTemplate>
        <asp:FileUpload ID="fileShacklesPhoto" runat="server" CssClass="form-control" />
        <asp:Label ID="lblExistingShacklesPhoto" runat="server" 
                   Text='<%# Eval("PhotoPath") %>' Visible="false" />
    </EditItemTemplate>
</asp:TemplateField>







       <%-- <asp:TemplateField HeaderText="Chain Pulley Question">
    <ItemTemplate>
        <%# Eval("ChainPulleyChecklistQuestion") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtChainPulleyQuestion" runat="server" CssClass="form-control"
                     Text='<%# Bind("ChainPulleyChecklistQuestion") %>' />
    </EditItemTemplate>
</asp:TemplateField>

       <asp:TemplateField HeaderText="Chain Pulley Is Yes">
    <ItemTemplate>
        <%# Eval("ChainPulleyIsYes") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="ddlChainPulleyIsYes" runat="server" CssClass="form-control"
    SelectedValue='<%# Bind("ChainPulleyIsYes") %>' onchange="toggleRemarksAndPhoto(this, 'ChainPulley')">
    <asp:ListItem Text="True" Value="True" />
    <asp:ListItem Text="False" Value="False" />
</asp:DropDownList>

    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Chain Pulley Remarks & Photo">
    <ItemTemplate>
        <%# Eval("ChainPulleyRemarks") %> <br />
        <%# Eval("ChainPulleyPhotoPath") %>
    </ItemTemplate>
   <EditItemTemplate>
    <asp:Panel ID="pnlChainPulleyDetails" runat="server" Style="display:none;">
        <asp:TextBox ID="txtChainPulleyRemarks" runat="server" CssClass="form-control" 
                     Text='<%# Bind("ChainPulleyRemarks") %>' placeholder="Enter Remarks" />
        <asp:FileUpload ID="fileChainPulleyPhoto" runat="server" CssClass="form-control" />
        <asp:Label ID="lblExistingChainPulleyPhoto" runat="server" 
                   Text='<%# Eval("ChainPulleyPhotoPath") %>' Visible="false" />
    </asp:Panel>
</EditItemTemplate>

</asp:TemplateField>--%>



        <asp:TemplateField HeaderText="Actions">
    <ItemTemplate>
        <asp:LinkButton ID="btnView" runat="server" CssClass="btn btn-info btn-actions btn-sm" 
            CommandArgument='<%# Eval("BasicID") %>'

            OnClick="btnView_Click">View</asp:LinkButton>

        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning btn-actions btn-sm" 
            CommandName="Edit">Edit</asp:LinkButton>

        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-actions btn-sm" 
            CommandName="Delete" 
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
