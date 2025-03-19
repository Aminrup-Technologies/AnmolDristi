<%@ Page Title="SOP Training" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="csm_soptrainings.aspx.cs" Inherits="AnmolDristi.csm_soptrainings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="right_col" role="main">
        <div class="container">
            <!-- Page Title -->
            <div class="page-title">
                <div class="title_left">
                    <h3>Training Session for SOP</h3>
                </div>
            </div>


            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>Participant Details</h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">

                            <%--Participant Details Section 1st row--%>
                            <div class="x_content">
                                <div class="x_panel">
                                    <!-- Header Section -->
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <asp:Label ID="lbl_txtSOPNumber" runat="server" AssociatedControlID="txtSOPNumber" Text="SOP Number "></asp:Label>
                                            <asp:TextBox ID="txtSOPNumber" runat="server" CssClass="form-control" placeholder="Enter SOP Number"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <asp:Label ID="lbl_txtTrainingDate" runat="server" AssociatedControlID="txtTrainingDate" Text="Training Date"></asp:Label>
                                            <asp:TextBox ID="txtTrainingDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <asp:Label ID="lbl_txtTime" runat="server" AssociatedControlID="txtTime" Text="Time"></asp:Label>
                                            <asp:TextBox ID="txtTime" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <%--Participant Details Section 2nd row--%>
                            <div class="x_content">
                                <div class="x_panel">

                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <asp:Label ID="lbl_txtDescription" runat="server" AssociatedControlID="txtDescription" Text="SOP Description"></asp:Label>
                                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Enter Description"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <asp:Label ID="lbl_txtFaculty" runat="server" AssociatedControlID="txtFaculty" Text="Faculty"></asp:Label>
                                            <asp:TextBox ID="txtFaculty" runat="server" CssClass="form-control" placeholder="Enter Faculty Name"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <asp:Label ID="lbl_txtDuration" runat="server" AssociatedControlID="txtDuration" Text="Duration (Minutes)"></asp:Label>
                                            <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" placeholder="Duration in minutes"></asp:TextBox>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <!-- Participants Details of Workplace Employees Section-->
                            <div class="x_panel">
                                <div class="x_title">
                                    <h2>Participants Details of Workplace Employees</h2>
                                    <div class="clearfix"></div>
                                </div>

                                <div class="x_content">
                                    <asp:Button ID="btnAddParticipant" runat="server" CssClass="btn btn-sm btn-primary" Text="Add Participant" OnClick="btnAddParticipant_Click" />
                                    <asp:GridView ID="gvParticipants" runat="server" AutoGenerateColumns="False" ShowHeader="true" Visible="false" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed">
                                        <Columns>
                                            <asp:BoundField DataField="RowNumber" HeaderText="S.No." />
                                            <asp:TemplateField HeaderText="Employee Name">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="form-control"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Designation">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-control"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Training Feedback Rating">
                                                <ItemTemplate>
                                                    <asp:RadioButtonList ID="rblFeedback" runat="server" RepeatDirection="Horizontal">
                                                        <asp:ListItem Text="Poor" Value="Poor" />
                                                        <asp:ListItem Text="Good" Value="Good" />
                                                        <asp:ListItem Text="Excellent" Value="Excellent" />
                                                    </asp:RadioButtonList>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Signature">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtSignature" runat="server" CssClass="form-control"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:CommandField ShowDeleteButton="True" ButtonType="Button" />
                                        </Columns>
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
                                    <asp:Button ID="btnAddFeedback" runat="server" CssClass="btn btn-sm btn-primary" Text="Add Feedback" OnClick="btnAddFeedback_Click" />
                                    <asp:GridView ID="gvSOPFeedback" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed">
                                        <Columns>
                                            <asp:BoundField DataField="RowNumber" HeaderText="SOP No." />
                                            <asp:TemplateField HeaderText="SOP's Desc & No">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtSOPDesc" runat="server" CssClass="form-control"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Activity (What)">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtActivity" runat="server" CssClass="form-control"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Associated Requirements/Hazards/Impact">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtHazards" runat="server" CssClass="form-control"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Process/Tools/PPEs (How)">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtProcess" runat="server" CssClass="form-control"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
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
                                    <%--<div class="row">--%>

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

                                    <%--</div>--%>
                                </div>
                            </div>

                            <%--<!-- Action Buttons -->
                            <div class="form-group text-right">
                                <asp:Button ID="btnPrint" CssClass="btn btn-sm btn-primary" runat="server" Text="Print Form" />
                                <asp:Button ID="btnExport" runat="server" CssClass="btn btn-sm btn-primary" Text="Export PDF" />
                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-sm btn-primary" Text="Save Form" />
                            </div>--%>

                        </div>

                        <%--Button--%>
                      <%--  <div class="col-md-6">
                            <div class="mb-3">
                                <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                <div class="input-group input-group-sm">
                                    <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
                                    <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                                    <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                </div>
                            </div>
                        </div>--%>

   <div class="col-md-6">
      <div class="mb-3">
          <asp:Label ID="lbl_msg" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
          <div class="input-group input-group-sm">
              <asp:Button ID="BtnSubmit" runat="server" Text="Save" CssClass="btn btn-primary btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
              <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
              <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/home.aspx" />
          </div>
      </div>
  </div>

                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>