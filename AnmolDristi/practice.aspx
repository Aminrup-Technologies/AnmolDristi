<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="practice.aspx.cs" Inherits="AnmolDristi.practice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:HiddenField ID="hdnPointsDiscussed" runat="server" />
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
                                 <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_txtIssuesDes" runat="server" AssociatedControlID="txtIssuesDes" Text="Issues Discussed" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtIssuesDes" runat="server" ErrorMessage="*" ValidationGroup="add1" ControlToValidate="txtIssuesDes" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div id="PointsContainer" runat="server">
            <div class= "d-flex align-items-center mb-2">
                <asp:TextBox ID="txtIssuesDes" runat="server" CssClass="form-control form-control-sm rounded points-input"></asp:TextBox>
                <asp:Button ID="BtnAdd" runat="server" Text="Add" CssClass="btn btn-primary btn-sm btn-fixed-size" OnClientClick="addbutton(); return false;" />
                <asp:Button ID="BtnRemove" runat="server" Text="Remove" CssClass="btn btn-danger btn-sm btn-fixed-size" OnClientClick="removebutton(this); return false;" />

            </div>
        </div>
    </div>

    <script type="text/javascript">
        function addbutton() {

            var container = document.getElementById('<%= PointsContainer.ClientID %>');

            if (!container) {
                console.error("Error: PointsContainer not found!");
                return;
            }

            var div = document.createElement("div");
            div.className = "d-flex align-items-center mb-2";

            var input = document.createElement("input");
            input.type = "text";
            input.className = "form-control form-control-sm points-input";
            input.placeholder = "Enter Points";

            var addBtn = document.createElement("button");
            addBtn.type = "button";
            addBtn.className = "btn btn-primary btn-sm btn-fixed-size";
            addBtn.textContent = "Add";
            addBtn.onclick = addbutton;

            var removeBtn = document.createElement("button");
            removeBtn.type = "button";
            removeBtn.className = "btn btn-danger btn-sm btn-fixed-size";
            removeBtn.textContent = "Remove";
            removeBtn.onclick = function () {
                removebutton(this);
            };

            div.appendChild(input);
            div.appendChild(addBtn);
            div.appendChild(removeBtn);
            container.appendChild(div);
        }

        function removebutton(button) {
            var container = document.getElementById('<%= PointsContainer.ClientID %>');
            if (container.children.length > 1) {
                button.parentNode.remove();
            }
            else {
                alert("At least one point is required.");
            }
        }
        function preparePoints() {
            var container = document.getElementById('<%= PointsContainer.ClientID %>');
            var inputs = container.getElementsByTagName('input');
            var pointsArray = [];

            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].type === "text" && inputs[i].value.trim() !== "") {
                    pointsArray.push(inputs[i].value.trim());
                }
            }

          document.getElementById('<%= hdnPointsDiscussed.ClientID %>').value = pointsArray.join(" , ");
        }
    </script>


</div>
                        <div class="col-md-2">
 <div class="mt-3">
     <asp:Button ID="btnAddIssues" runat="server" Text="Add Issues" CssClass="btn btn-success" ValidationGroup="add1" CausesValidation="true"  OnClientClick="preparePoints();" OnClick="btnAddIssues_Click"  />
    <%-- <asp:Label ID="lblMsg1" runat="server" ></asp:Label>--%>
 </div>
  </div>                         
            <div class="table-responsive">
    <div class="col-md-12">
        <div class="mb-3">
    <asp:GridView ID="gvIssues" runat="server" AutoGenerateColumns="False" DataKeyNames="SNo" CssClass="table table-bordered table-hover ">
    <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
    <Columns>
       <asp:BoundField DataField="SNo" HeaderText="SNo" />
        <asp:BoundField DataField="IssuesDiscussed" HeaderText="Issues Discussed" />     
        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>
                 <asp:Button ID="BtnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"  OnClick="BtnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete ?');" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
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
