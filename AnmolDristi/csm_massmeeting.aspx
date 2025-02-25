<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="csm_massmeeting.aspx.cs" Inherits="AnmolDristi.csm_massmeeting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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
    <%--<asp:HiddenField ID="hdn_meetingID" runat="server" />--%>
    <asp:HiddenField ID="hdnPointsDiscussed" runat="server" />
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
                            <h2>ATS/DOC/MM/0010
                            </h2>
                            <div class="clearfix"></div>
                        </div>

                        <div class="x_content">

                            <div class="col-md-6">
                                <div class="mb-3">
                                    <asp:Label ID="lbl_Date" runat="server" AssociatedControlID="TB_Date" Text="Date" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_TB_Date" runat="server" ErrorMessage="Select Date" ControlToValidate="TB_Date" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="TB_Date" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Date"></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <!-- Second set of dropdown list -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_time" runat="server" AssociatedControlID="tb_time" Text="Time" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_tb_time" runat="server" ErrorMessage="Select Time" ValidationGroup="Submit" ControlToValidate="tb_time" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="tb_time" runat="server" CssClass="form-control form-control-sm rounded" TextMode="Time"></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-6">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_loc" runat="server" AssociatedControlID="tb_loc" Text="Site/Location" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_tb_loc" runat="server" ErrorMessage="Location Required" ValidationGroup="Submit" ControlToValidate="tb_loc" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="tb_loc" runat="server" CssClass="form-control form-control-sm rounded" Placeholder=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-6">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_name" runat="server" AssociatedControlID="tb_name" Text="Employee Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_tb_name" runat="server" ErrorMessage="Employee Name Required" ValidationGroup="Submit" ControlToValidate="tb_name" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="tb_name" runat="server" CssClass="form-control form-control-sm rounded" Placeholder=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-6">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_des" runat="server" AssociatedControlID="tb_des" Text="Designation" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_tb_des" runat="server" ErrorMessage="Designation Required" ControlToValidate="tb_des" ValidationGroup="Submit" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="tb_des" runat="server" CssClass="form-control form-control-sm rounded" Placeholder=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>


                            <div class="col-md-6">
                                <div class="mb-3">
                                    <asp:Label ID="Lbl_rfid" runat="server" AssociatedControlID="tb_rfid" Text="RFID" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_tb_rfid" runat="server" ErrorMessage="Rfid Required" ValidationGroup="Submit" ControlToValidate="tb_rfid" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="REV_tb_rfid" runat="server" ControlToValidate="tb_rfid" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="AlphaNumeric Only" ValidationExpression="^[a-zA-Z0-9.@]{0,25}$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <div class="input-group-sm">
                                        <asp:TextBox ID="tb_rfid" runat="server" CssClass="form-control form-control-sm rounded" Placeholder=""></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">

                                <div class="mb-3">
                                    <asp:Label ID="lblPointsDiscussed" runat="server" AssociatedControlID="tb_points" Text="Points Discussed" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                    <asp:RequiredFieldValidator ID="RFV_tb_points" runat="server" ErrorMessage="Points Required" ValidationGroup="Submit" ControlToValidate="tb_points" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

                                    <div id="PointsContainer" runat="server">
                                        <div class="d-flex align-items-center mb-2">
                                            <asp:TextBox ID="tb_points" runat="server" CssClass="form-control form-control-sm rounded points-input"></asp:TextBox>
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

                                        document.getElementById('<%= hdnPointsDiscussed.ClientID %>').value = pointsArray.join(" | ");
                                    }
                                </script>
                            </div>
                        </div>
                    </div>
                </div>



                <%--Button--%>
                <div class="col-md-3">
                    <div class="mb-3">
                        <asp:Label ID="Lbl_btnSubmit" runat="server" AssociatedControlID="BtnSubmit" Text="Click to SAVE" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                        <div class="input-group input-group-sm">
                            <%-- <asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClick="BtnSubmit_Click" />--%>
                            <asp:Button ID="BtnSubmit" runat="server" Text="Submit" CssClass="btn btn-success btn-sm" ValidationGroup="Submit" CausesValidation="true" OnClientClick="preparePoints();" OnClick="BtnSubmit_Click" />
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                            <asp:Button ID="BtnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="BtnReset_Click" />
                            <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-danger" CausesValidation="false" PostBackUrl="~/Home.aspx" />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>

