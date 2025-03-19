<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3></h3>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2></h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">
                            <div class="right_col" role="main">
                                <div class="container">
                                    <div class="page-title">
                                        <div class="title_left">
                                            <h3>TRAINING SESSION OF SOP</h3>
                                            <small>Revision: 02</small><br />
                                            <small>Effective date: 01.10.2021</small>
                                        </div>
                                    </div>

                                    <div class="clearfix"></div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="x_panel">
                                                <!-- Header Section -->
                                                <div class="x_content">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <asp:label id="lbl_1" runat="Server">SOP Number *</asp:label>
                                                                <asp:TextBox ID="txtSOPNumber" runat="server" CssClass="form-control" placeholder="Enter SOP Number"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label>Training Date *</label>
                                                                <asp:TextBox ID="txtTrainingDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label>Time *</label>
                                                                <asp:TextBox ID="txtTime" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label>SOP Description</label>
                                                                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Enter Description"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label>Faculty</label>
                                                                <asp:TextBox ID="txtFaculty" runat="server" CssClass="form-control" placeholder="Enter Faculty Name"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label>Duration (Minutes)</label>
                                                                <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" placeholder="Duration in minutes"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Participants Section -->
                                                    <div class="x_panel">
                                                        <div class="x_title">
                                                            <h2>Participants Details of Workplace Employees</h2>
                                                            <div class="clearfix"></div>
                                                        </div>
                                                        <div class="x_content">
                                                            <asp:Button ID="btnAddParticipant" runat="server" Text="Add Participant" OnClick="btnAddParticipant_Click" />
                                                            <asp:GridView ID="gvParticipants" runat="server" AutoGenerateColumns="False" OnRowDeleting="gvParticipants_RowDeleting">
                                                                <columns>
                                                                    <asp:BoundField DataField="RowNumber" HeaderText="S.No." />
                                                                    <asp:TemplateField HeaderText="Employee Name">
                                                                        <itemtemplate>
                                                                            <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        </itemtemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Designation">
                                                                        <itemtemplate>
                                                                            <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        </itemtemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Training Feedback Rating">
                                                                        <itemtemplate>
                                                                            <asp:RadioButtonList ID="rblFeedback" runat="server" RepeatDirection="Horizontal">
                                                                                <asp:ListItem Text="Poor" Value="Poor" />
                                                                                <asp:ListItem Text="Good" Value="Good" />
                                                                                <asp:ListItem Text="Excellent" Value="Excellent" />
                                                                            </asp:RadioButtonList>
                                                                        </itemtemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Signature">
                                                                        <itemtemplate>
                                                                            <asp:TextBox ID="txtSignature" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        </itemtemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:CommandField ShowDeleteButton="True" ButtonType="Button" />
                                                                </columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>

                                                    <!-- SOP Feedback Section -->
                                                    <div class="x_panel">
                                                        <div class="x_title">
                                                            <h2>SOP's feedback raised by contract employee and supervisors</h2>
                                                            <div class="clearfix"></div>
                                                        </div>
                                                        <div class="x_content">
                                                            <asp:Button ID="btnAddFeedback" runat="server" Text="Add Feedback" OnClick="btnAddFeedback_Click" />
                                                            <asp:GridView ID="gvSOPFeedback" runat="server" AutoGenerateColumns="False">
                                                                <columns>
                                                                    <asp:BoundField DataField="RowNumber" HeaderText="SOP No." />
                                                                    <asp:TemplateField HeaderText="SOP's Desc & No">
                                                                        <itemtemplate>
                                                                            <asp:TextBox ID="txtSOPDesc" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        </itemtemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Activity (What)">
                                                                        <itemtemplate>
                                                                            <asp:TextBox ID="txtActivity" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        </itemtemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Associated Requirements/Hazards/Impact">
                                                                        <itemtemplate>
                                                                            <asp:TextBox ID="txtHazards" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        </itemtemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Process/Tools/PPEs (How)">
                                                                        <itemtemplate>
                                                                            <asp:TextBox ID="txtProcess" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        </itemtemplate>
                                                                    </asp:TemplateField>
                                                                </columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>

                                                    <!-- Improvements Section -->
                                                    <div class="x_panel">
                                                        <div class="x_title">
                                                            <h2>ANY SUGGESTION FOR IMPROVEMENTS</h2>
                                                            <div class="clearfix"></div>
                                                        </div>
                                                        <div class="x_content">
                                                            <div class="form-group">
                                                                <label>Feedback of Employees Supervisor</label>
                                                                <asp:TextBox ID="txtSupervisorFeedback" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Feedback of Safety officers / Supervisor</label>
                                                                <asp:TextBox ID="txtSafetyOfficerFeedback" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Feedback of Safety Manager/Head/Incharges</label>
                                                                <asp:TextBox ID="txtManagerFeedback" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Signatures Section -->
                                                    <div class="x_panel">
                                                        <div class="x_title">
                                                            <h2>Signatures</h2>
                                                            <div class="clearfix"></div>
                                                        </div>
                                                        <div class="x_content">
                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label>Signature of Training Faculty</label>
                                                                        <asp:TextBox ID="txtFacultySignature" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        <asp:TextBox ID="txtFacultyDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label>Signature of Site Supervisor / Safety officer</label>
                                                                        <asp:TextBox ID="txtSupervisorSignature" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        <asp:TextBox ID="txtSupervisorDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label>Signature of Head / Safety Manager</label>
                                                                        <asp:TextBox ID="txtManagerSignature" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        <asp:TextBox ID="txtManagerDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Action Buttons -->
                                                    <div class="form-group text-right">
                                                        <asp:Button ID="btnPrint" runat="server" Text="Print Form" OnClick="btnPrint_Click" />
                                                        <asp:Button ID="btnExport" runat="server" Text="Export PDF" OnClick="btnExport_Click" />
                                                        <asp:Button ID="btnSave" runat="server" Text="Save Form" OnClick="btnSave_Click" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

