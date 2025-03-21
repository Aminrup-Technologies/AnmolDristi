<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="housekeeping_audit.aspx.cs" Inherits="AnmolDristi.housekeeping_audit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
    <div class="container">
        <div class="page-title">
            <div class="title_left">
                <h3>Mass Meeting Attendance Sheet
                </h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12 ">
                <div class="x_panel">
                    <div class="x_title">
                        <h2>Automation And Technical Services</h2>
                        <div class="clearfix"></div>
                    </div>

                    <div class="x_content">

                         <asp:Panel ID="pnlAuditForm" runat="server">
                                <div class="row">  
                                    
      <div class="col-md-6">
     <div class="mb-3">
         <asp:Label ID="lbl_txtdate" runat="server" AssociatedControlID="txtdate" Text="Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtdate" runat="server" ErrorMessage="*" ControlToValidate="txtdate" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtdate" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
         </div>
     </div>
 </div>
     <div class="col-md-6">
     <div class="mb-3">
         <asp:Label ID="lbl_txtLocation" runat="server" AssociatedControlID="txtLocation" Text="Location" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
         <asp:RequiredFieldValidator ID="RFV_txtLocation" runat="server" ErrorMessage="*" ControlToValidate="txtLocation" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
         <div class="input-group-sm">
             <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control form-control-sm rounded " ></asp:TextBox>
         </div>
     </div>
 </div>
                                    </div>

 <div class="row">
                                 
                                    

    <div class="col-md-3">
         <div class="mb-3">
        <asp:Label ID="lbl_fileBeforePhoto" runat="server" AssociatedControlID="fileBeforePhoto" Text="Photo" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_fileBeforePhoto" runat="server" ErrorMessage="*" ControlToValidate="fileBeforePhoto" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
             <asp:FileUpload ID="fileBeforePhoto" runat="server" CssClass="form-control form-control-sm rounded" />
        </div>
    </div>
</div>
              <div class="col-md-3">
         <div class="mb-3">
        <asp:Label ID="lbl_txtObservation" runat="server" AssociatedControlID="txtObservation" Text="Observation" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtObservation" runat="server" ErrorMessage="*" ControlToValidate="txtObservation" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtObservation" runat="server" CssClass="form-control form-control-sm rounded "></asp:TextBox>
        </div>
    </div>
</div>
                  <div class="col-md-3">
         <div class="mb-3">
        <asp:Label ID="lbl_txtCorrectiveAction" runat="server" AssociatedControlID="txtCorrectiveAction" Text="Corrective Action" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_txtCorrectiveAction" runat="server" ErrorMessage="*" ControlToValidate="txtCorrectiveAction" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
            <asp:TextBox ID="txtCorrectiveAction" runat="server" CssClass="form-control form-control-sm rounded "></asp:TextBox>
        </div>
    </div>
</div>
    
    <div class="col-md-3">
         <div class="mb-3">
        <asp:Label ID="lbl_fileuploadStatus" runat="server" AssociatedControlID="fileuploadStatus" Text="Status" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
        <asp:RequiredFieldValidator ID="RFV_fileuploadStatus" runat="server" ErrorMessage="*" ControlToValidate="fileuploadStatus" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
        <div class="input-group-sm">
             <asp:FileUpload ID="fileuploadStatus" runat="server" CssClass="form-control form-control-sm rounded" />
        </div>
    </div>
</div>
     
                         
     </div>
                                <!-- Button -->
                                <div class="mt-3">
                                    <asp:Button ID="btnAddObservation" runat="server" Text="Add Observation" CssClass="btn btn-primary" OnClick="btnAddObservation_Click" OnClientClick="clearFields();" />
                                </div>
                            </asp:Panel>

                            <hr>

                            <!-- ASP.NET Table for Observations -->
                            <asp:Table ID="tblObservations" runat="server" CssClass="table table-bordered">
                                <asp:TableHeaderRow>
                                    <asp:TableHeaderCell>Sl. No</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>Before Photo</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>Observation</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>Corrective Action</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>Status Photo</asp:TableHeaderCell>
                                </asp:TableHeaderRow>
                            </asp:Table>


   


                   
                </div>
            </div>


            <%--Button--%>
            <div class="col-md-3">
                <div class="mb-3">
                   <%-- <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                    --%><div class="input-group input-group-sm">
                        <%--<asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />
                        --%><asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                        <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                        <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/Home.aspx" />
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
    
</div>
    <script type="text/javascript">
        function clearFields() {
            document.getElementById('<%= txtObservation.ClientID %>').value = "";
        document.getElementById('<%= txtCorrectiveAction.ClientID %>').value = "";
        }
    </script>
   <%-- <script>
        function saveAudit() {
            const location = document.getElementById("location").value;
            const auditDate = document.getElementById("auditDate").value;

            if (!location || !auditDate) {
                alert("Please fill in all fields.");
                return;
            }

            const auditData = {
                location: location,
                auditDate: auditDate
            };

            fetch('http://localhost:5000/save-audit', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(auditData)
            })
                .then(response => response.json())
                .then(data => {
                    alert("Audit saved successfully!");
                })
                .catch(error => {
                    console.error("Error:", error);
                });
        }
        function btnaddObservation() {
            const observationText = document.getElementById("observationText").value;
            const correctiveAction = document.getElementById("correctiveAction").value;
            const beforePhotoInput = document.getElementById("beforePhoto");
            const afterPhotoInput = document.getElementById("afterPhoto");

            const beforePhoto = beforePhotoInput.files[0];
            const afterPhoto = afterPhotoInput.files[0];

            if (!observationText || !correctiveAction || !beforePhoto || !afterPhoto) {
                alert("Please fill in all fields and select images.");
                return;
            }

            const readerBefore = new FileReader();
            const readerAfter = new FileReader();

            readerBefore.readAsDataURL(beforePhoto);
            readerAfter.readAsDataURL(afterPhoto);

            readerBefore.onload = function () {
                readerAfter.onload = function () {
                    const newRow = `
                <tr>
                    <td>${document.getElementById("observationTable").rows.length + 1}</td>
                    <td><img src="${readerBefore.result}" width="100"></td>
                    <td>${observationText}</td>
                    <td>${correctiveAction}</td>
                    <td><img src="${readerAfter.result}" width="100"></td>
                </tr>
            `;

                    document.getElementById("observationTable").innerHTML += newRow;

                    // ✅ Clear all input fields after adding observation
                    document.getElementById("observationText").value = "";
                    document.getElementById("correctiveAction").value = "";
                    beforePhotoInput.value = "";
                    afterPhotoInput.value = "";

                    alert("Observation added successfully!");
                };
            };
        }





    </script>--%>
</asp:Content>
