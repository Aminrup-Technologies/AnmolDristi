<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="Grinding_Machine_View.aspx.cs" Inherits="AnmolDristi.Grinding_Machine_View" %>


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
    <script type="text/javascript">
    function toggleRemarksAndPhoto(ddl) {
        var row = ddl.closest('tr');
        var remarks = row.querySelector('.remarksField');
        var photo = row.querySelector('.photoField');

        if (ddl.value === "False") {
            if (remarks) remarks.style.display = "inline-block";
            if (photo) photo.style.display = "inline-block";
        } else {
            if (remarks) remarks.style.display = "none";
            if (photo) photo.style.display = "none";
        }
    }

    // Automatically apply when row enters edit mode
    function applyInitialToggle() {
        var allDropdowns = document.querySelectorAll('select[id*="ddlIsYes"]');
        allDropdowns.forEach(toggleRemarksAndPhoto);
    }

    // Hook into page lifecycle
    window.onload = function () {
        setTimeout(applyInitialToggle, 100);
    };
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Grinding Machine Checklist Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored Grinding Machine Checklist Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <div style="overflow-x: auto;">
                    <asp:GridView ID="GvGrindingMachineChecklist" runat="server" CssClass="table table-striped table-bordered"
                        AutoGenerateColumns="False" DataKeyNames="HeaderID" OnRowEditing="GvGrindingMachineChecklist_RowEditing"
                        OnRowUpdating="GvGrindingMachineChecklist_RowUpdating" OnRowCancelingEdit="GvGrindingMachineChecklist_RowCancelingEdit"
                        OnRowDeleting="GvGrindingMachineChecklist_RowDeleting" OnRowDataBound="GvGrindingMachineChecklist_RowDataBound">

                        <Columns>
                            <asp:BoundField DataField="HeaderID" HeaderText="Header ID" ReadOnly="true" />
                            <asp:BoundField DataField="Site" HeaderText="Site" ReadOnly="true"  />
                            <asp:BoundField DataField="DateOfInspection" HeaderText="Date of Inspection" DataFormatString="{0:yyyy-MM-dd}" ReadOnly="true"  />
                            <asp:BoundField DataField="InspectedBy" HeaderText="Inspected By" ReadOnly="true"  />
                            <asp:BoundField DataField="SerialNo" HeaderText="Serial No" ReadOnly="true" />
                            <asp:BoundField DataField="IdentificationNumber" HeaderText="Identification No" ReadOnly="true"  />
                            <asp:BoundField DataField="Location" HeaderText="Location" ReadOnly="true"  />
                            <asp:BoundField DataField="ChecklistQuestion" HeaderText="Checklist Question" ReadOnly="true"  />
                            <asp:TemplateField HeaderText="Is Yes">
    <ItemTemplate>
        <%# Eval("IsYes") %>
    </ItemTemplate>
   <EditItemTemplate>
    <asp:DropDownList 
    ID="ddlIsYes" 
    runat="server" 
    SelectedValue='<%# Convert.ToBoolean(Eval("IsYes")) ? "True" : "False" %>'
    onchange="toggleRemarksAndPhoto(this);" style="width:150px;">
    <asp:ListItem Text="True" Value="True" />
    <asp:ListItem Text="False" Value="False" />
</asp:DropDownList>

</EditItemTemplate>

</asp:TemplateField>

<asp:TemplateField HeaderText="Remarks">
    <ItemTemplate>
        <%# Eval("Remarks") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtRemarks" runat="server" CssClass="remarksField" Style="display: none;" Text='<%# Bind("Remarks") %>'></asp:TextBox>
    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Photo Path">
    <ItemTemplate>
        <asp:Literal ID="litPhoto" runat="server" />
    </ItemTemplate>
    <EditItemTemplate>
        <asp:FileUpload ID="filePhoto" runat="server" CssClass="photoField" Style="display: none;" />
        <asp:Label ID="lblExistingPhoto" runat="server" Text='<%# Eval("PhotoPath") %>' Visible="false" />
    </EditItemTemplate>
</asp:TemplateField>

                            <asp:BoundField DataField="JobID" HeaderText="Job ID" ReadOnly="true" /> 
    <asp:BoundField DataField="JobName" HeaderText="Job Name" ReadOnly="true" />
                            <asp:BoundField DataField="Final_Remarks" HeaderText="Final Remarks" ReadOnly="true" />


          <asp:TemplateField HeaderText="Actions">
    <ItemTemplate>
        <asp:LinkButton 
            ID="btnView" 
            runat="server" 
            CommandArgument='<%# Eval("HeaderID") %>' 
            OnClick="btnView_Click" 
            CssClass="btn btn-info btn-actions">View</asp:LinkButton>

        <asp:LinkButton 
            ID="btnEdit" 
            runat="server" 
            CssClass="btn btn-warning btn-actions" 
            CommandName="Edit">Edit</asp:LinkButton>

        <asp:LinkButton 
            ID="btnDelete" 
            runat="server" 
            CssClass="btn btn-danger btn-actions" 
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
</asp:Content>
