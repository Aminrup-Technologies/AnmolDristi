<%@ Page Title="View Records" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="csm_ppe_checklist_report.aspx.cs" Inherits="AnmolDristi.view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Make the whole page occupy full height */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        /* Ensuring the container fills the viewport */
        .page-container {
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Full viewport height */
            padding-left: 250px; /* Sidebar width */
            background-color: #f4f4f4;
        }

        /* Table wrapper with horizontal scroll */
        .table-wrapper {
            flex: 1;
            padding: 20px;
            overflow-x: auto; /* Enable horizontal scrolling */
            background: white;
            border-radius: 5px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Table Styling */
        .table {
            width: 100%;
            border-collapse: collapse;
            white-space: nowrap; /* Prevent text wrapping */
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #2c3e50;
            color: white;
        }

        /* Buttons */
        .btn {
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 3px;
        }

        .btn-edit {
            background-color: #3498db;
            color: white;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }

        .btn-edit:hover {
            background-color: #2980b9;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-container">
        <div class="table-wrapper">
            <h2>Safety Inspection Records</h2>
            
            <div style="overflow-x: auto;">
                <asp:GridView ID="GridView1" runat="server" CssClass="table"
                    AutoGenerateColumns="False" DataKeyNames="id" OnRowEditing="GridView1_RowEditing"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowUpdating="GridView1_RowUpdating"
                    OnRowDeleting="GridView1_RowDeleting">
                    
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="inspection_by" HeaderText="Inspector" />
                        <asp:BoundField DataField="Submitted_date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="worker_id" HeaderText="Worker ID" />
                        <asp:BoundField DataField="worker_name" HeaderText="Worker Name" />
                        <asp:BoundField DataField="designation" HeaderText="Designation" />
                        
                        <asp:BoundField DataField="safety_shoe" HeaderText="Safety Shoe" />
                        <asp:BoundField DataField="safety_helmet" HeaderText="Safety Helmet" />
                        <asp:BoundField DataField="safety_goggles" HeaderText="Safety Goggles" />
                        <asp:BoundField DataField="safety_spron" HeaderText="Safety Apron" />
                        <asp:BoundField DataField="hot_protect_jacket" HeaderText="Protective Jacket" />
                        <asp:BoundField DataField="hand_gloves" HeaderText="Hand Gloves" />
                        <asp:BoundField DataField="hand_sleeves" HeaderText="Hand Sleeves" />
                        <asp:BoundField DataField="ear_plug" HeaderText="Ear Plug" />
                        <asp:BoundField DataField="nose_mask" HeaderText="Nose Mask" />
                        <asp:BoundField DataField="leg_guard" HeaderText="Leg Guard" />
                        <asp:BoundField DataField="remarks" HeaderText="Remarks" />
                        <asp:BoundField DataField="Time_stamp" HeaderText="Timestamp" ReadOnly="True" />
                        
                        <asp:BoundField DataField="safety_shoe_remark" HeaderText="Shoe Remark" />
                        <asp:BoundField DataField="safety_helmet_remark" HeaderText="Helmet Remark" />
                        <asp:BoundField DataField="safety_goggles_remark" HeaderText="Goggles Remark" />
                        <asp:BoundField DataField="safety_spron_remark" HeaderText="Apron Remark" />
                        <asp:BoundField DataField="hot_protect_jacket_remark" HeaderText="Jacket Remark" />
                        <asp:BoundField DataField="hand_gloves_remark" HeaderText="Gloves Remark" />
                        <asp:BoundField DataField="hand_sleeves_remark" HeaderText="Sleeves Remark" />
                        <asp:BoundField DataField="ear_plug_remark" HeaderText="Ear Plug Remark" />
                        <asp:BoundField DataField="nose_mask_remark" HeaderText="Nose Mask Remark" />
                        <asp:BoundField DataField="leg_guard_remark" HeaderText="Leg Guard Remark" />
                        
                       
                        <asp:CommandField ShowEditButton="True" ButtonType="Button" EditText="Edit" UpdateText="Save" CancelText="Cancel" />

                      
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-delete" Text="Delete"
                                    CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this record?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
