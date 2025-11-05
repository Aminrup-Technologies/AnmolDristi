<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="JobSite_View.aspx.cs" Inherits="AnmolDristi.JobSite_View" %>

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

        function applyInitialToggle() {
            var allDropdowns = document.querySelectorAll('select[id*="ddlIsYes"]');
            allDropdowns.forEach(toggleRemarksAndPhoto);
        }

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
                    <h3>Job Site Hazard Checklist Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Job Site Hazard Checklist Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <div style="overflow-x: auto;">
        <asp:GridView ID="GridViewJobSiteChecklist" runat="server" CssClass="table table-bordered"
            AutoGenerateColumns="False" DataKeyNames="HeaderID,Question"
            OnRowEditing="GridViewJobSiteChecklist_RowEditing"
            OnRowUpdating="GridViewJobSiteChecklist_RowUpdating"
            OnRowCancelingEdit="GridViewJobSiteChecklist_RowCancelingEdit"
            OnRowDeleting="GridViewJobSiteChecklist_RowDeleting" OnRowDataBound="GridViewJobSiteChecklist_RowDataBound">
           <Columns>
    <asp:TemplateField HeaderText="Header ID">
        <ItemTemplate>
            <%# Eval("HeaderID") %>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:Label ID="lblHeaderID" runat="server" Text='<%# Eval("HeaderID") %>'></asp:Label>
        </EditItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Checklist Date">
        <ItemTemplate>
            <%# Eval("ChecklistDate", "{0:yyyy-MM-dd}") %>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtChecklistDate" runat="server" Text='<%# Bind("ChecklistDate", "{0:yyyy-MM-dd}") %>' CssClass="form-control" TextMode="Date" />
        </EditItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Area">
        <ItemTemplate>
            <%# Eval("Area") %>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtArea" runat="server" Text='<%# Bind("Area") %>' CssClass="form-control" />
        </EditItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Question">
        <ItemTemplate>
            <%# Eval("Question") %>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:TextBox ID="txtQuestion" runat="server" Text='<%# Bind("Question") %>' CssClass="form-control" />
        </EditItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Is Yes">
    <ItemTemplate>
        <%# Eval("IsYes") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList 
            ID="ddlIsYes" 
            runat="server" 
            CssClass="form-control" 
            onchange="toggleRemarksAndPhoto(this);" SelectedValue='<%# Bind("IsYes") %>' style="width:150px;" >
            <asp:ListItem Text="True" Value="True"></asp:ListItem>
            <asp:ListItem Text="False" Value="False"></asp:ListItem>
        </asp:DropDownList>
    </EditItemTemplate>
</asp:TemplateField>


   <asp:TemplateField HeaderText="Remarks">
    <ItemTemplate>
        <%# Eval("Remarks") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control remarksField" Style="display: none;" Text='<%# Bind("Remarks") %>'></asp:TextBox>
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



    <asp:TemplateField HeaderText="Actions">
        <ItemTemplate>
            <asp:LinkButton ID="btnView" runat="server" CssClass="btn btn-info btn-actions"
                CommandArgument='<%# Eval("HeaderID") %>' OnClick="btnView_Click">View</asp:LinkButton>
            <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning btn-actions"
                CommandName="Edit">Edit</asp:LinkButton>
            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-actions"
                CommandName="Delete" OnClientClick="return confirm('Are you sure?');">Delete</asp:LinkButton>
        </ItemTemplate>
        <EditItemTemplate>
            <asp:LinkButton ID="btnUpdate" runat="server" CssClass="btn btn-success btn-actions"
                CommandName="Update">Update</asp:LinkButton>
            <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-secondary btn-actions"
                CommandName="Cancel">Cancel</asp:LinkButton>
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
