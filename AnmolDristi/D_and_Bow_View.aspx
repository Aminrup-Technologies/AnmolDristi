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

    <script type="text/javascript">
    function toggleRemarksAndPhoto(dropdown, prefix) {
        var selectedValue = dropdown.value;
        var panel = dropdown.closest('tr').querySelector('[id*="pnl' + prefix + 'Details"]');
        if (selectedValue === "False") {
            panel.style.display = 'block';
        } else {
            panel.style.display = 'none';
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
                   <asp:GridView ID="GvDandBowChecklist" runat="server" CssClass="table table-striped table-bordered"
    AutoGenerateColumns="False" DataKeyNames="BasicID" OnRowEditing="GvDandBowChecklist_RowEditing"
    OnRowUpdating="GvDandBowChecklist_RowUpdating" OnRowCancelingEdit="GvDandBowChecklist_RowCancelingEdit"
    OnRowDeleting="GvDandBowChecklist_RowDeleting"
    OnRowDataBound="GvDandBowChecklist_RowDataBound">

    <Columns>
            <asp:BoundField DataField="HeaderID" HeaderText="Header ID" /> 
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
        <%# Eval("ShacklesChecklistQuestion") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtShacklesQuestion" runat="server" CssClass="form-control"
                     Text='<%# Bind("ShacklesChecklistQuestion") %>' />
    </EditItemTemplate>
</asp:TemplateField>

       <asp:TemplateField HeaderText="Shackles Is Yes">
    <ItemTemplate>
        <%# Eval("ShacklesIsYes") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="ddlShacklesIsYes" runat="server" CssClass="form-control"
    SelectedValue='<%# Bind("ShacklesIsYes") %>' onchange="toggleRemarksAndPhoto(this, 'Shackles')">
    <asp:ListItem Text="True" Value="True" />
    <asp:ListItem Text="False" Value="False" />
</asp:DropDownList>

    </EditItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Shackles Remarks & Photo">
    <ItemTemplate>
        <%# Eval("ShacklesRemarks") %> <br />
        <%# Eval("ShacklesPhotoPath") %>
    </ItemTemplate>
    <EditItemTemplate>
    <asp:Panel ID="pnlShacklesDetails" runat="server" Style="display:none;">
        <asp:TextBox ID="txtShacklesRemarks" runat="server" CssClass="form-control" 
                     Text='<%# Bind("ShacklesRemarks") %>' placeholder="Enter Remarks" />
        <asp:FileUpload ID="fileShacklesPhoto" runat="server" CssClass="form-control" />
        <asp:Label ID="lblExistingShacklesPhoto" runat="server" 
                   Text='<%# Eval("ShacklesPhotoPath") %>' Visible="false" />
    </asp:Panel>
</EditItemTemplate>

</asp:TemplateField>




        <asp:TemplateField HeaderText="Chain Pulley Question">
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

</asp:TemplateField>



        <asp:TemplateField HeaderText="Actions">
    <ItemTemplate>
        <asp:LinkButton ID="btnView" runat="server" CssClass="btn btn-info btn-actions" 
            CommandArgument='<%# Eval("BasicID") %>'

            OnClick="btnView_Click">View</asp:LinkButton>

        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning btn-actions" 
            CommandName="Edit">Edit</asp:LinkButton>

        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-actions" 
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
