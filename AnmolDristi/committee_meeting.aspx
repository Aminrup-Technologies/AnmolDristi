<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="committee_meeting.aspx.cs" Inherits="AnmolDristi.committee_meeting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .btnStyle {
    width: 120px;
    height: 35px;
    color: black;
    background-color: coral;
    font-size: 16px;
    text-align: center;
    border: none;
    border-radius: 5px;
}
   .table-responsive {
    width: 100%;
    max-height: 400px; /* Adjust based on need */
    overflow-x: auto;
    overflow-y: auto;
    
   }

@media (max-width: 768px) {
    .table-responsive {
        max-height: 300px; /* Adjust based on your UI */
    }
}
.btn-fixed-size {
    width: 100px;
    text-align: center;
    font-size: 14px;
    padding: 5px 0;
}

.points-input {
    margin-right: 10px;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <asp:HiddenField ID="hdnPointsDiscussed" runat="server" />
        <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h3>Internal Safety Committee meeting 
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>DOC/ATS/OSH/CM-04</h2>
                        <div class="clearfix"></div>
                    </div>

                    <div class="x_content">

                        
      <div class="row">  
                                    
      <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Meeting Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
    <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtTime" runat="server" AssociatedControlID="txtTime" Text="Meeting Time" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtTime" runat="server" ErrorMessage="*" ControlToValidate="txtTime" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtTime" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
        </div>
    </div>
</div>
     <div class="col-md-3">
     <div class="mb-3">
         <asp:Label ID="lbl_txtVenue" runat="server" AssociatedControlID="txtVenue" Text="Venue" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtVenue" runat="server" ErrorMessage="*" ControlToValidate="txtVenue" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtVenue" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
    <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtMeetingNo" runat="server" AssociatedControlID="txtMeetingNo" Text="Meeting Number" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtMeetingNo" runat="server" ErrorMessage="*" ControlToValidate="txtMeetingNo" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtMeetingNo" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
        </div>
    </div>
</div>
    <div class="col-md-3">
    <div class="mb-3">
        <asp:Label ID="lbl_txtChairedBy" runat="server" AssociatedControlID="txtChairedBy" Text="Chaired By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtChairedBy" runat="server" ErrorMessage="*" ControlToValidate="txtChairedBy" ValidationGroup="add" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtChairedBy" runat="server" CssClass="form-control form-control-sm rounded" ></asp:TextBox>
        </div>
    </div>
</div>
                                  <%--  <asp:HiddenField ID="hdnMeetingID" runat="server" />
   --%>
                                    </div>

 <div class="x_title">
     <h2>Attendance Table</h2>
     <div class="clearfix"></div>
 </div>
                
                  <div class="field" id="Attendees">

                   
     <asp:Panel ID="pnlAttendeeType" runat="server" Visible="true">

         <div class="col-md-6">
             <div class="mb-3">
                 <asp:Label ID="lbl_rbAttendeeType" runat="server" AssociatedControlID="rbAttendeeType" Text="Attendees Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_rbAttendeeType" runat="server" ErrorMessage="Select any option" ValidationGroup="add2" ControlToValidate="rbAttendeeType" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <div class="input-group-sm">
                     <asp:RadioButtonList ID="rbAttendeeType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbAttendeeType_SelectedIndexChanged">
                         <asp:ListItem Text="Internal" Value="Internal"></asp:ListItem>
                         <asp:ListItem Text="External" Value="External"></asp:ListItem>
                     </asp:RadioButtonList>
                 </div>
             </div>
         </div>
     </asp:Panel>

     <asp:Panel ID="pnlDetails" runat="server" Visible="false"> 

         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_txtAttendeeCode" runat="server" AssociatedControlID="txtAttendeeCode" Text="Ateendees Code" ForeColor="Blue" Font-Bold="true"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_txtAttendeeCode" runat="server" ErrorMessage="*" ControlToValidate="txtAttendeeCode"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="REV_txtAttendeeCode" runat="server" ControlToValidate="txtAttendeeCode" ForeColor="Red"  ErrorMessage="AlphaNumeric Only" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" Display="Dynamic"></asp:RegularExpressionValidator>

                 <div class="input-group-sm">
                     <asp:TextBox ID="txtAttendeeCode" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                 </div>
             </div>
         </div>


         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_txtEmployeeName" runat="server" AssociatedControlID="txtEmployeeName" Text="Employee Name" ForeColor="Blue" Font-Bold="true"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_txtEmployeeName" runat="server" ErrorMessage="*" ControlToValidate="txtEmployeeName" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <div class="input-group-sm">
                     <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                 </div>
             </div>
         </div>

         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_txtdes" runat="server" AssociatedControlID="txtdes" Text="Designation" ForeColor="Blue" Font-Bold="true"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_txtdes" runat="server" ErrorMessage="*" ControlToValidate="txtdes" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <div class="input-group-sm">
                     <asp:TextBox ID="txtdes" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>
                 </div>
             </div>
         </div>

         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_ddlAttendanceStatus" runat="server" AssociatedControlID="ddlAttendanceStatus" Text="Attendance Status" ForeColor="Blue" Font-Bold="true"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_ddlAttendanceStatus" runat="server" ErrorMessage="*" ControlToValidate="ddlAttendanceStatus" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <div class="input-group-sm"> 
                     <asp:DropDownList ID="ddlAttendanceStatus" runat="server" CssClass="form-control form-control-sm rounded">
                        <asp:ListItem Text="Select" Value="" />
                        <asp:ListItem Text="Attend" Value="Attend" />
                        <asp:ListItem Text="Absent" Value="Absent" />
                     </asp:DropDownList>
                 </div>
             </div>
         </div>

         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_imgupload" runat="server" AssociatedControlID="imgupload" Text="Upload Your Image" ForeColor="Blue" Font-Bold="true"></asp:Label>
                 <asp:RequiredFieldValidator ID="RFV_imgupload" runat="server" ErrorMessage="*" ControlToValidate="imgupload" ValidationGroup="add2" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                 <div class="input-group-sm">
                     <asp:FileUpload ID="imgupload" runat="server" CssClass="form-control form-control-sm rounded" />
                      <asp:Label ID="lblBeforeError" runat="server" CssClass="text-danger" Style="display:none;"></asp:Label>
                 </div>
             </div>
         </div>
        

           </asp:Panel>
      </div>
         <asp:Panel ID="pnlDetails1" runat="server" Visible="false"> 
         <div class="col-md-2">
             <div class="mb-3">
                 <asp:Label ID="lbl_btnAddAttendees" runat="server" AssociatedControlID="btnAddAttendees" Text="Add Attendees" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                 <div class="input-group">
                     <asp:Button ID="btnAddAttendees" Text="Add Attendees" runat="server" CssClass="btn btnStyle " ValidationGroup="add2" CausesValidation="true" OnClick="btnAddAttendees_Click" />
                      <asp:Label ID="lblMsg1" runat="server" ></asp:Label>
                 </div>
             </div>
         </div>
       
  </asp:Panel>

      
    
     <asp:Panel ID="pnlAttendeeTable" runat="server">
         <div class="table-responsive">
         <div class="col-md-12">
             <div class="mb-3">
                 <asp:GridView ID="gvAttendees" runat="server" DataKeyNames="SNo" CssClass="table table-bordered table-hover "  AutoGenerateColumns="False">
                     <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
                     <Columns>
                         <asp:BoundField DataField="SNo" HeaderText="SNo" />
                         <asp:BoundField DataField="AttendeeType" HeaderText="Attendee Type" />
                         <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
                         <asp:BoundField DataField="AttendeeCode" HeaderText="Attendee Code" />
                         <asp:BoundField DataField="AttendanceStatus" HeaderText="Attendance Status" />
                         <asp:BoundField DataField="Designation" HeaderText="Designation" />
                         <asp:TemplateField HeaderText="Image Preview">
                           <ItemTemplate>
                             <asp:Image ID="imgPreview" runat="server" ImageUrl='<%# Eval("ImagePath") %>' Width="50px" Height="50px" />
                            </ItemTemplate>                      
                         </asp:TemplateField>
                               <asp:TemplateField HeaderText="Action">
                                 <ItemTemplate>
                                     <asp:Button ID="BtnDelAttendees" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"  OnClick="BtnDelAttendees_Click" OnClientClick="return confirm('Are you sure you want to delete?');" />
                                </ItemTemplate>
                          </asp:TemplateField>
                     </Columns>
                 </asp:GridView>
             </div>
         </div>
             </div>
     </asp:Panel>
                      


  <div class="x_title">
     <h2>Meeting Issue Table</h2>
     <div class="clearfix"></div>
 </div>                         

   
    <div class="field" id="Issues">
 
                                 
      <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_txtAgendaTitle" runat="server" AssociatedControlID="txtAgendaTitle" Text="Agenda Title" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtAgendaTitle" runat="server" ErrorMessage="*" ControlToValidate="txtAgendaTitle" ValidationGroup="add1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtAgendaTitle" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
        </div>
    </div>
</div>                          
     <div class="col-md-6">
    <div class="mb-3">
        <asp:Label ID="lbl_txtIssuesDes" runat="server" AssociatedControlID="txtIssuesDes" Text="Issues Discussed" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_" runat="server" ErrorMessage="*" ValidationGroup="add1" ControlToValidate="txtIssuesDes" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div id="PointsContainer" runat="server">
            <div class="d-flex align-items-center mb-2">
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
             <div class="col-md-6">
         <div class="mb-3">
        <asp:Label ID="lbl_txtReviewBy" runat="server" AssociatedControlID="txtReviewBy" Text="Review By" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtReviewBy" runat="server" ErrorMessage="*" ControlToValidate="txtReviewBy" ValidationGroup="add1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtReviewBy" runat="server" CssClass="form-control form-control-sm rounded "></asp:TextBox>
        </div>
    </div>
</div>
                 <div class="col-md-6">
         <div class="mb-3">
        <asp:Label ID="lbl_txtActionBy" runat="server" AssociatedControlID="txtActionBy" Text="Action By(Responsibility)" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtActionBy" runat="server" ErrorMessage="*" ControlToValidate="txtActionBy" ValidationGroup="add1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtActionBy" runat="server" CssClass="form-control form-control-sm rounded "></asp:TextBox>
        </div>
    </div>
</div>
                 <div class="col-md-4">
         <div class="mb-3">
        <asp:Label ID="lbl_txtTargetDate" runat="server" AssociatedControlID="txtTargetDate" Text="Target Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtTargetDate" runat="server" ErrorMessage="*" ControlToValidate="txtTargetDate" ValidationGroup="add1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtTargetDate" runat="server" CssClass="form-control form-control-sm rounded " TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>

         <div class="col-md-4">
         <div class="mb-3">
        <asp:Label ID="lbl_txtReviewDate" runat="server" AssociatedControlID="txtReviewDate" Text="Review Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtReviewDate" runat="server" ErrorMessage="*" ControlToValidate="txtReviewDate" ValidationGroup="add1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtReviewDate" runat="server" CssClass="form-control form-control-sm rounded " TextMode="Date"></asp:TextBox>
        </div>
    </div>
</div>

    
         <div class="col-md-4">
         <div class="mb-3">
        <asp:Label ID="lbl_ddlStatus" runat="server" AssociatedControlID="ddlStatus" Text="Status" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_ddlStatus" runat="server" ErrorMessage="*" ControlToValidate="ddlStatus" ValidationGroup="add1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
             <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control form-control-sm rounded">
                 <asp:ListItem Text="Select" Value="" />
                 <asp:ListItem Text="Pending" Value="Pending" />
                 <asp:ListItem Text="Completed" Value="Completed" />
                 <asp:ListItem Text="In Progress" Value="In Progress" />
                 <asp:ListItem Text="Approved" Value="Approved" />
                 <asp:ListItem Text="Rejected" Value="Rejected" />
                 <asp:ListItem Text="On Hold" Value="On Hold" />
             </asp:DropDownList>
        </div>
    </div>
</div>
     
                         


     </div>


<div class="col-md-2">
 <div class="mt-3">
     <asp:Button ID="btnAddIssues" runat="server" Text="Add Issues" CssClass="btn btn-success" ValidationGroup="add1" CausesValidation="true"  OnClientClick="preparePoints();" OnClick="btnAddIssues_Click"  />
 </div>
  </div>                         
            <div class="table-responsive">
    <div class="col-md-12">
        <div class="mb-3">
    <asp:GridView ID="gvIssues" runat="server" AutoGenerateColumns="False" DataKeyNames="SNo" CssClass="table table-bordered table-hover ">
    <HeaderStyle BackColor="#000080" ForeColor="#E0E0E0" Font-Bold="true" />
    <Columns>
        <asp:BoundField DataField="SNo" HeaderText="SNo" />
        <asp:BoundField DataField="AgendaTitle" HeaderText="Agenda Title" />
        <asp:BoundField DataField="IssuesDiscussed" HeaderText="Issues Discussed" />
        <asp:BoundField DataField="ActionBy" HeaderText="Action By" />
        <asp:BoundField DataField="TargetDate" HeaderText="Target Date" />
        <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" />
        <asp:BoundField DataField="ReviewBy" HeaderText="Review By" />
        <asp:BoundField DataField="Status" HeaderText="Status" />
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


           <%-- <%--Button--%>
           <div class="col-md-3">
                <div class="mb-3">
                    <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    <div class="input-group input-group-sm">
                        <asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
                        
                        <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                        <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/Home.aspx" />
                        <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
    
</div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        var txtEmployeeName = $("#<%= txtEmployeeName.ClientID %>");
        var txtDesignation = $("#<%= txtdes.ClientID %>");
        var txtAttendeeCode = $("#<%= txtAttendeeCode.ClientID %>");
        var attendeeType = $("input[name='<%= rbAttendeeType.UniqueID %>']");

        function toggleFields() {
            var isInternal = attendeeType.filter(":checked").val() === "Internal";
            txtEmployeeName.prop("readonly", isInternal);
            txtDesignation.prop("readonly", isInternal);
            if (!isInternal) {
                txtEmployeeName.val("").prop("readonly", false);
                txtDesignation.val("").prop("readonly", false);
            }
        }

        // On page load, apply logic
        toggleFields();

        // When Attendee Type changes
        attendeeType.change(function () {
            toggleFields();
        });

        // When Attendee Code is entered
        txtAttendeeCode.on("blur", function () {
            var attendeeCode = $(this).val().trim();
            var isInternal = attendeeType.filter(":checked").val() === "Internal";

            if (isInternal && attendeeCode !== "") {
                $.ajax({
                    type: "POST",
                    url: "committee_meeting.aspx/GetAttendeeDetails",
                    data: JSON.stringify({ attendeeCode: attendeeCode }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.success) {
                            txtEmployeeName.val(response.d.name).prop("readonly", true);
                            txtDesignation.val(response.d.designation).prop("readonly", true);
                            $("#errorMsg").text("").hide();
                        } else {
                            txtEmployeeName.val("").prop("readonly", true);
                            txtDesignation.val("").prop("readonly", true);
                            $("#errorMsg").text(response.d.message).css("color", "red").show();
                        }
                    },
                    error: function () {
                        $("#errorMsg").text("Error fetching data").css("color", "red").show();
                        txtEmployeeName.val("").prop("readonly", true);
                        txtDesignation.val("").prop("readonly", true);
                    }
                });
            }
        });
    });
</script>
    <script type="text/javascript">
        function showSuccessMessage() {
            alert("Attendee details have been added successfully!");
        }
    </script>
    <script type="text/javascript">
        function showSuccessMessages() {
            alert("Issues have been added successfully!");
        }
    </script>
     <script type="text/javascript">
     function showSuccess() {
         alert("Data saved successfully!");
     }
     </script>
  <%-- <script type="text/javascript">
       window.onload = function () {
           const validExtensions = [".jpg", ".jpeg", ".png"];
           const maxSizeMB = 20;
           const minAcceptableWidth = 200;
           const minAcceptableHeight = 200;
           const recommendedWidth = 800;
           const recommendedHeight = 600;

           const beforeFile = document.getElementById('<%= imgupload.ClientID %>');
        const beforeError = document.getElementById('<%= lblBeforeError.ClientID %>');

           beforeFile.setAttribute("accept", ".jpg,.jpeg,.png");

           beforeFile.addEventListener("change", function () {
               validateFile(this, beforeError);
           });

           function validateFile(fileInput, errorLabel) {
               const file = fileInput.files[0];
               const ext = file.name.substring(file.name.lastIndexOf('.')).toLowerCase();

               if (!validExtensions.includes(ext)) {
                   fileInput.value = "";
                   errorLabel.innerText = "❌ Only .jpg, .jpeg, or .png files are allowed.";
                   errorLabel.style.display = "block";
                   return;
               }

               if (file.size > maxSizeMB * 1024 * 1024) {
                   fileInput.value = "";
                   errorLabel.innerText = `❌ File too large. Max ${maxSizeMB}MB allowed.`;
                   errorLabel.style.display = "block";
                   return;
               }

               const img = new Image();
               const objectUrl = URL.createObjectURL(file);

               img.onload = function () {
                   if (this.width < minAcceptableWidth || this.height < minAcceptableHeight) {
                       fileInput.value = "";
                       errorLabel.innerText = `❌ Image too small. Minimum size is ${minAcceptableWidth}x${minAcceptableHeight}px.`;
                       errorLabel.style.display = "block";
                   } else if (this.width < recommendedWidth || this.height < recommendedHeight) {
                       errorLabel.innerText = `⚠️ Image uploaded, but it's below recommended resolution (${recommendedWidth}x${recommendedHeight}px).`;
                       errorLabel.style.display = "block";
                   } else {
                       errorLabel.innerText = "";
                       errorLabel.style.display = "none";
                   }

                   URL.revokeObjectURL(objectUrl);
               };

               img.src = objectUrl;
           }
       };
   </script>--%>

 <script type="text/javascript">
         window.onload = function () {
             const validExtensions = [".jpg", ".jpeg", ".png"];

             const beforeFile = document.getElementById('<%= imgupload.ClientID %>');
         

             const beforeError = document.getElementById('<%= lblBeforeError.ClientID %>');
      
             // Set accept attribute for file filtering at browser level
             beforeFile.setAttribute("accept", ".jpg,.jpeg,.png");
             

             beforeFile.addEventListener("change", function () {
                 validateFile(this, beforeError);
             });

             
             function validateFile(fileInput, errorLabel) {
                 const filePath = fileInput.value;
                 const ext = filePath.substring(filePath.lastIndexOf('.')).toLowerCase();

                 if (!validExtensions.includes(ext)) {
                     fileInput.value = "";
                     errorLabel.innerText = "❌ Only .jpg, .jpeg, or .png files are allowed.";
                     errorLabel.style.display = "block";
                 } else {
                     errorLabel.innerText = "";
                     errorLabel.style.display = "none";
                 }
             }
         };
     </script>

   
</asp:Content>
