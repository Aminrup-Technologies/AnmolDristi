<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="incident_View.aspx.cs" Inherits="AnmolDristi.incident_View" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <%-- <style>
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
    </style>--%>

<%--<style>
    .form-label {
        font-weight: bold;
        color: blue;
        display: block;
        margin-bottom: 5px;
    }

    /* ✅ Table container setup */
    .table-container {
        overflow-x: auto;        /* Only horizontal scrolling */
        overflow-y: hidden;      /* No vertical scroll */
        white-space: nowrap;
        position: sticky;        /* Key: makes it stick in its parent */
        bottom: 0;               /* Sticks to bottom of viewport */
        background: #fff;        /* Prevents content showing through */
        z-index: 100;            /* Keeps it above other content */
        padding-bottom: 5px;     /* Small gap for scrollbar */
        border-top: 1px solid #ccc;
        scrollbar-width: thin;   /* Firefox */
        scrollbar-color: #007bff #f1f1f1;
    }

    /* ✅ Custom scrollbar for Chrome/Edge/Safari */
    .table-container::-webkit-scrollbar {
        height: 10px;
    }

    .table-container::-webkit-scrollbar-thumb {
        background: linear-gradient(90deg, #007bff, #0056b3);
        border-radius: 8px;
    }

    .table-container::-webkit-scrollbar-thumb:hover {
        background: linear-gradient(90deg, #0056b3, #004099);
    }

    .table-container::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 8px;
    }

    table.table {
        min-width: 1400px;
        width: 100%;
        border-collapse: collapse;
        font-family: Arial, sans-serif;
        font-size: 14px;
    }

    table.table th,
    table.table td {
        padding: 10px 12px;
        border: 1px solid #ddd;
        vertical-align: top;
        color: #000;
    }

    table.table th {
        background-color: #007bff;
        color: white;
        font-weight: bold;
        text-align: left;
    }

    table.table td:first-child {
        font-weight: bold;
        width: 35%;
        white-space: nowrap;
    }

    table.table tr:nth-child(even) td {
        background-color: #f2f2f2;
    }

    .btn-actions {
        margin-right: 5px;
    }
</style>--%>


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
    font-size: 20px !important;        /* bigger text */
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
            <div class="page-title">
                <div class="title_left">
                    <h3>Incident Records</h3>
                </div>
            </div>

            <div class="x_panel">
                <div class="x_title">
                    <h2>Stored Incident Records</h2>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content table-container">
                    <div style="overflow-x: auto;">
                        <div class="gridview-scroll">
                        <asp:GridView ID="gvIncidentData" runat="server" CssClass="table table-striped table-bordered"
                            AutoGenerateColumns="False" DataKeyNames="IncidentID"
                            OnRowEditing="gvIncidentData_RowEditing"
                            OnRowUpdating="gvIncidentData_RowUpdating"
                            OnRowCancelingEdit="gvIncidentData_RowCancelingEdit"
                            OnRowDeleting="gvIncidentData_RowDeleting">


                            <Columns>


                                <asp:BoundField DataField="IncidentID" HeaderText="Incident ID" ReadOnly="True" />


                                <asp:TemplateField HeaderText="Classification">
    <ItemTemplate>
        <%# Eval("IncidentClassification") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="ddlIncidentClassification" runat="server"
            CssClass="form-select" SelectedValue='<%# Bind("IncidentClassification") %>'>
    
            <asp:ListItem Text="Near Miss" Value="Near Miss"></asp:ListItem>
            <asp:ListItem Text="First Aid Case" Value="First Aid Case"></asp:ListItem>
            <asp:ListItem Text="Minor Injury" Value="Minor Injury"></asp:ListItem>
            <asp:ListItem Text="Lost Time Injury" Value="Lost Time Injury"></asp:ListItem>
            <asp:ListItem Text="Fatal" Value="Fatal"></asp:ListItem>
            <asp:ListItem Text="Property Damage" Value="Property Damage"></asp:ListItem>
        </asp:DropDownList>
    </EditItemTemplate>
</asp:TemplateField>



                                <asp:TemplateField HeaderText="Incident Date">
                                    <ItemTemplate>
                                        <%# Eval("DateOfIncident", "{0:yyyy-MM-dd}") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDateOfIncident" runat="server" Text='<%# Bind("DateOfIncident", "{0:yyyy-MM-dd}") %>' TextMode="Date" CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <%--<asp:TemplateField HeaderText="Time of Incident">
                                    <ItemTemplate>
                                        <%# Eval("TimeOfIncident") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtTimeOfIncident" runat="server" Text='<%# Bind("TimeOfIncident") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>--%>


                              <asp:TemplateField HeaderText="Time of Incident">
    <ItemTemplate>
        <%# TimeSpan.Parse(Eval("TimeOfIncident").ToString()).ToString(@"hh\:mm") %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtTimeOfIncident"
                     runat="server"
                     Text='<%# TimeSpan.Parse(Eval("TimeOfIncident").ToString()).ToString(@"hh\:mm") %>'
                     TextMode="Time"
                     CssClass="form-control" />
    </EditItemTemplate>
</asp:TemplateField>





                                <asp:TemplateField HeaderText="Location">
                                    <ItemTemplate>
                                        <%# Eval("Location") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtLocation" runat="server" Text='<%# Bind("Location") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8" 
                                             />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Section">
                                    <ItemTemplate>
                                        <%# Eval("Section") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtSection" runat="server" Text='<%# Bind("Section") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8"  />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Department">
                                    <ItemTemplate>
                                        <%# Eval("Department") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDepartment" runat="server" Text='<%# Bind("Department") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8"  />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Vendor Name">
                                    <ItemTemplate>
                                        <%# Eval("VendorName") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtVendorName" runat="server" Text='<%# Bind("VendorName") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8" />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Total Injured">
                                    <ItemTemplate>
                                        <%# Eval("TotalInjuredPersons") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtTotalInjuredPersons" runat="server" Text='<%# Bind("TotalInjuredPersons") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8" />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Investigation Team Members">
                                    <ItemTemplate>
                                        <%# Eval("InvestigationTeamMembers") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtInvestigationTeamMembers" runat="server" Text='<%# Bind("InvestigationTeamMembers") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8" />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Task & Incident Description">
                                    <ItemTemplate>
                                        <%# Eval("TaskAndDescription") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtTaskAndDescription" runat="server" Text='<%# Bind("TaskAndDescription") %>' CssClass="form-control" TextMode="MultiLine" Rows="8" />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                    <asp:TemplateField HeaderText="Why1_Loss">
                                        <ItemTemplate>
                                            <%# Eval("Why1_Loss") %>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtWhy1Loss" runat="server" Text='<%# Bind("Why1_Loss") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>


                                <asp:TemplateField HeaderText="Why2_Incident">
                                    <ItemTemplate>
                                        <%# Eval("Why2_Incident") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtWhy2_Incident" runat="server" Text='<%# Bind("Why2_Incident") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8"  />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Why3_ImmediateCause">
                                    <ItemTemplate>
                                        <%# Eval("Why3_ImmediateCause") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtWhy3_ImmediateCause" runat="server" Text='<%# Bind("Why3_ImmediateCause") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8" />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Why4_UnderlyingCause">
                                    <ItemTemplate>
                                        <%# Eval("Why4_UnderlyingCause") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtWhy4_UnderlyingCause" runat="server" Text='<%# Bind("Why4_UnderlyingCause") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8"  />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Why5_RootCause">
                                    <ItemTemplate>
                                        <%# Eval("Why5_RootCause") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtWhy5_RootCause" runat="server" Text='<%# Bind("Why5_RootCause") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8"  />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Why6_How">
                                    <ItemTemplate>
                                        <%# Eval("Why6_How") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtWhy6_How" runat="server" Text='<%# Bind("Why6_How") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8" />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <%--    
        <asp:TemplateField HeaderText="Review Date">
            <ItemTemplate>
                <%# Eval("ReviewDate") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtReviewDate" runat="server" Text='<%# Bind("ReviewDate") %>' CssClass="form-control" />
            </EditItemTemplate>
        </asp:TemplateField>--%>

                                         <asp:TemplateField HeaderText="Supporting Image">
                                            <ItemTemplate>
                                                <asp:Image ID="imgSupporting"
                                                           runat="server"
                                                           ImageUrl='<%# Eval("FinalRootCauseImagePath") %>'
                                                           Width="100px"
                                                           Height="100px"
                                                           AlternateText="No Image" />
                                                <asp:HiddenField ID="hfFinalRootCauseImage" 
                                                         runat="server" 
                                                         Value='<%# Eval("FinalRootCauseImagePath") %>' />
                                            </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:FileUpload ID="fuRootCauseImage" runat="server" CssClass="form-control form-control-sm mb-1" />
                                        <asp:HiddenField ID="hfFinalRootCauseImage" runat="server"
                                                         Value='<%# Eval("FinalRootCauseImagePath") %>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Final Root Cause">
                                    <ItemTemplate>
                                        <%# Eval("FinalRootCause") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtFinalRootCause" runat="server" Text='<%# Bind("FinalRootCause") %>' CssClass="form-control w-100 large-textbox" Rows="8" TextMode="MultiLine" />
                                    </EditItemTemplate>
                                </asp:TemplateField>



                                <asp:TemplateField HeaderText="Preventive Actions">
                                    <ItemTemplate>
                                        <%# Eval("PreventiveActions") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPreventiveActions" runat="server" Text='<%# Bind("PreventiveActions") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8" />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Person Involved">
                                    <ItemTemplate>
                                        <%# Eval("NameOfPersonInvolved") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNameOfPersonInvolved" runat="server" Text='<%# Bind("NameOfPersonInvolved") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8" />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Any Witness?">
                                    <ItemTemplate>
                                        <%# Eval("AnyWitness") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtAnyWitness" runat="server" Text='<%# Bind("AnyWitness") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Witness Names">
                                    <ItemTemplate>
                                        <%# Eval("WitnessNames") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtWitnessNames" runat="server" Text='<%# Bind("WitnessNames") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8" />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Reported By">
                                    <ItemTemplate>
                                        <%# Eval("ReportedBy") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtReportedBy" runat="server" Text='<%# Bind("ReportedBy") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8" />
                                    </EditItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Immediate  Actions">
                                    <ItemTemplate>
                                        <%# Eval("CorrectiveActions") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCorrectiveActions" runat="server" Text='<%# Bind("CorrectiveActions") %>' CssClass="form-control w-100 large-textbox" TextMode="MultiLine" Rows="8"/>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Submitted Date">
                                    <ItemTemplate>
                                        <%# Eval("SubmittedDate", "{0:yyyy-MM-dd}") %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Submitted Time">
                                    <ItemTemplate>
                                        <%# Eval("SubmittedTime", "{0:hh\\:mm}") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="View">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkView" runat="server" 
                            NavigateUrl='<%# Eval("IncidentID", "~/incident_DetailedView.aspx?IncidentId={0}") %>' 
                            Text="View" 
                            CssClass="btn btn-info btn-actions" 
                            Target="_blank" />
                    </ItemTemplate>
                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-warning btn-actions" CommandName="Edit">Edit</asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-danger btn-actions" CommandName="Delete" OnClientClick="return confirm('Are you want to delete the record?');">Delete</asp:LinkButton>
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
