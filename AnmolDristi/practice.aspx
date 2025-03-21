<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="practice.aspx.cs" Inherits="AnmolDristi.practice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <div class="right_col" role="main">
        <div class="container">
            <div class="page-title">
                <div class="title_left">
                    <h3>Mass Meeting Attendance Sheet</h3>
                   
                </div>
            </div>
            <div id="panelMeeting" class="row" >
                <div class="col-md-12 col-sm-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>ATS/DOC/MM/0010</h2>
                            
                            <div class="clearfix"></div>
                        </div>
                        <div class="x_title">
                              <h2>Meeting Details</h2>
                             <div class="clearfix"></div>
                          </div>
                        <div class="x_content">

                          <div class="col-md-3">
      <div class="mb-3">
          <asp:Label ID="lbl_HandSleeves" runat="server" AssociatedControlID="rbl_HandSleeves" Text="Hand Sleeves" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
          <asp:RequiredFieldValidator ID="RFV_rbl_HandSleeves" runat="server" ErrorMessage="Select any option" ValidationGroup="Submit" ControlToValidate="rbl_HandSleeves" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

          <div class="input-group-sm rmv_border">
              <asp:RadioButtonList ID="rbl_HandSleeves" runat="server" CssClass="form-control form-control-sm rounded" RepeatLayout="Table" RepeatDirection="Horizontal" CellPadding="5" CellSpacing="5" RepeatColumns="3" Width="100%" onchange="toggle_HandSleeves(this);">
                  <asp:ListItem Text="NEW" Value="1"></asp:ListItem>
                  <asp:ListItem Text="OK" Value="2"></asp:ListItem>
                  <asp:ListItem Text="NOT OKAY" Value="0"></asp:ListItem>
              </asp:RadioButtonList>

          </div>

      </div>
  </div>
                           
                        </div>
                    </div>
                </div>


                
                <%--Button--%>
                <%--<div class="col-md-3">
                    <div class="mb-3">
                        <asp:Label ID="Lbl_btnSaveFirstPanel" runat="server" AssociatedControlID="BtnSaveFirstPanel" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                        <div class="input-group input-group-sm">
                            <asp:Button ID="BtnSaveFirstPanel" runat="server" Text="Save First Panel" CssClass="btn btn-success" ValidationGroup="Save" CausesValidation="true" OnClientClick="showSecondPanel(); return false;" OnClick="BtnSaveFirstPanel_Click" />

                          
                        </div>
                    </div>
             


            </div>--%>
        </div>





</div>
              
    </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  
</asp:Content>
