<%@ Page Title="AIL | Rotary Line & Oven END Report" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="qaqc_rotary_line.aspx.cs" Inherits="AnmolDristi.qaqc_rotary_line" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .remove-border {
            border: none !important; /* This will ensure the border is removed */
            /* Add any other necessary styling */
        }

        .custom-page-title {
            width: 100%;
            background-color: #f0f0f0; /* Example: Change background color */
            margin-top: 20px;
            padding-top: 35px;
            padding-right: 20px;
            padding-left: 20px;
            /*padding-bottom:20px;*/
        }

            .custom-page-title .title_left h3 {
                font-size: 20px;
                color: #333333;
                font-weight: bold;
            }

        .approver-photo {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }

        .approver-flow {
            display: flex;
            align-items: center;
            justify-content: space-around;
            padding: 1rem;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: .25rem;
        }

        .flow-line {
            flex: 1;
            border-top: 2px solid #007bff;
            margin: 0 10px;
        }

        .approver-item {
            text-align: center;
        }
    </style>

    <script type="text/javascript">
        function validateGridView1() {
            var isValid = true;
            var gridView = document.getElementById('<%= LineWeights_Grid.ClientID %>');
            for (var i = 1; i < gridView.rows.length; i++) {  // Start from 1 to skip header row
                var row = gridView.rows[i];

                var txtStlWeight = row.querySelector("input[id*='txtStlWeight']");
                var txtedlWeight = row.querySelector("input[id*='txtedlWeight']");

                // Check if TextBoxes are filled
                if (txtStlWeight && txtStlWeight.value.trim() === "") {
                    isValid = false;
                    txtStlWeight.style.borderColor = "red";
                } else {
                    txtStlWeight.style.borderColor = "";
                }

                if (txtedlWeight && txtedlWeight.value.trim() === "") {
                    isValid = false;
                    txtedlWeight.style.borderColor = "red";
                } else {
                    txtedlWeight.style.borderColor = "";
                }
            }

            // If not valid, prevent form submission
            if (!isValid) {
                alert("Please fill all the required fields.");
            }

            return isValid;
        }
    </script>

    <script type="text/javascript">

        function calculateAverageWeight() {
            var totalWeight = 0;
            var rowCount = 0;

            // Get all the textboxes with the class 'line-weight' inside the GridView
            var textBoxes = document.getElementsByClassName('line-weight');

            // Loop through each textbox to calculate the total weight
            for (var i = 0; i < textBoxes.length; i++) {
                var weight = parseFloat(textBoxes[i].value);

                // Check if the value entered is a valid number
                if (!isNaN(weight) && weight > 0) {
                    totalWeight += weight;
                    rowCount++;
                }
            }

            // Calculate the average weight if there are valid entries
            var averageWeight = (rowCount > 0) ? (totalWeight / rowCount).toFixed(2) : 0;

            // Get the Label by ClientID and update its text with the calculated average
            var lblAvgWeight = document.getElementById('<%= lblAvgWeight.ClientID %>');
            lblAvgWeight.innerHTML = averageWeight;
        }

        function validateGridView1() {
            var isValid = true;
            var gridView = document.getElementById('<%= LineWeights_Grid.ClientID %>');
            for (var i = 1; i < gridView.rows.length; i++) {  // Start from 1 to skip header row
                var row = gridView.rows[i];

                var txtStlWeight = row.querySelector("input[id*='txtStlWeight']");
                // var txtedlWeight = row.querySelector("input[id*='txtedlWeight']");

                // Check if TextBoxes are filled
                if (txtStlWeight && txtStlWeight.value.trim() === "") {
                    isValid = false;
                    txtStlWeight.style.borderColor = "red";
                } else {
                    txtStlWeight.style.borderColor = "";
                }

                //if (txtedlWeight && txtedlWeight.value.trim() === "") {
                //    isValid = false;
                //    txtedlWeight.style.borderColor = "red";
                //} else {
                //    txtedlWeight.style.borderColor = "";
                //}
            }

            // If not valid, prevent form submission
            if (!isValid) {
                alert("Please fill all the required fields.");
            }

            return isValid;
        }


        function validateGridView() {
            var isValid = true;
            var gridView = document.getElementById('<%= OvenEnd_GridView.ClientID %>');
            for (var i = 1; i < gridView.rows.length; i++) {  // Start from 1 to skip header row
                var row = gridView.rows[i];

                var txtGaugeLength = row.querySelector("input[id*='txtGaugeLength']");
                var txtWeight = row.querySelector("input[id*='txtWeight']");

                // Check if TextBoxes are filled
                if (txtGaugeLength && txtGaugeLength.value.trim() === "") {
                    isValid = false;
                    txtGaugeLength.style.borderColor = "red";
                } else {
                    txtGaugeLength.style.borderColor = "";
                }

                if (txtWeight && txtWeight.value.trim() === "") {
                    isValid = false;
                    txtWeight.style.borderColor = "red";
                } else {
                    txtWeight.style.borderColor = "";
                }
            }

            // If not valid, prevent form submission
            if (!isValid) {
                alert("Please fill all the required fields.");
            }

            return isValid;
        }

        function clearGridView1TextBoxes() {
            var textBoxes = document.querySelectorAll('#<%= LineWeights_Grid.ClientID %> .form-control');
             textBoxes.forEach(function (textBox) {
                 textBox.value = '';
             });
         }

         function clearGridView2TextBoxes() {
             var textBoxes = document.querySelectorAll('#<%= OvenEnd_GridView.ClientID %> .form-control');
               textBoxes.forEach(function (textBox) {
                   textBox.value = '';
               });
           }

           function calculateAverageGaugeLength() {
               var totalLength = 0;
               var count = 0;

               // Get all the TextBox elements for gauge length
               var textboxes = document.querySelectorAll('.gauge-length');

               // Iterate over each TextBox to sum up the values
               textboxes.forEach(function (textbox) {
                   var value = parseFloat(textbox.value);
                   if (!isNaN(value)) {
                       totalLength += value;
                       count++;
                   }
               });

               // Calculate the average
               var averageLength = (count > 0) ? (totalLength / count) : 0;

               // Update the label with the average length in millimeters
               document.getElementById('lblAvgGaugeLength').innerText = averageLength.toFixed(2) + ' mm';
           }

           function calculateAverageWeight1() {
               var totalWeight = 0;
               var rowCount = 0;

               // Get all the textboxes with the class 'line-weight' inside the GridView
               var textBoxes = document.getElementsByClassName('weight');

               // Loop through each textbox to calculate the total weight
               for (var i = 0; i < textBoxes.length; i++) {
                   var weight = parseFloat(textBoxes[i].value);

                   // Check if the value entered is a valid number
                   if (!isNaN(weight) && weight > 0) {
                       totalWeight += weight;
                       rowCount++;
                   }
               }

               // Calculate the average weight if there are valid entries
               var averageWeight = (rowCount > 0) ? (totalWeight / rowCount).toFixed(2) : 0;

               // Get the Label by ClientID and update its text with the calculated average
               var lblAvgWeight = document.getElementById('<%= lblAvgWeights.ClientID %>');
              lblAvgWeight.innerHTML = averageWeight;
          }

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hdn_shiftvalue" runat="server" />
    <asp:HiddenField ID="hdn_formid" runat="server" />

    <div class="right_col" role="main">
        <div class="container">
            <div class="page-title custom-page-title">
                <div class="title_left">
                    <h3>
                        <asp:Label ID="lbl_docname" runat="server" Text="Label"></asp:Label>
                    </h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12 ">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="lbl_docnumber" runat="server" Text="Label"></asp:Label>
                            </h2>
                            <div class="clearfix"></div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-12">
                                                <ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
                                                    <li class="nav-item">
                                                        <a class="nav-link active text-info" id="basicData-tab" data-toggle="tab" href="#basicData" role="tab"
                                                            aria-controls="basicData" aria-selected="true"><i class="fa fa-id-badge mr-2"></i>Plant & Line Data</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" id="rawBiscuts-tab" data-toggle="tab" href="#rawBiscuts" role="tab"
                                                            aria-controls="rawBiscuts" aria-selected="false">Line Weights</a>
                                                    </li>

                                                    <li class="nav-item">
                                                        <a class="nav-link" id="ovenReport-tab" data-toggle="tab" href="#ovenReport" role="tab"
                                                            aria-controls="ovenReport" aria-selected="false">Oven End Data</a>
                                                    </li>
                                                </ul>
                                                <div class="tab-content ml-1" id="myTabContent">
                                                    <%---Basic User Info Starts--%>
                                                    <div class="tab-pane fade show active" id="basicData" role="tabpanel" aria-labelledby="basicData-tab">
                                                        <div class="x_content">
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label1" runat="server" AssociatedControlID="DDL_Plant" Text="Plant Name" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_Plant" runat="server" ErrorMessage="Required" ValidationGroup="Submit" ForeColor="Red" ControlToValidate="DDL_Plant" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_Plant" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" ValidationGroup="Submit" OnSelectedIndexChanged="DDL_Plant_SelectedIndexChanged"></asp:DropDownList>

                                                                    </div>

                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label2" runat="server" AssociatedControlID="DDL_PlantLine" Text="Select Line" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_PlantLine" runat="server" ErrorMessage="Required" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_PlantLine" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_PlantLine" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_PlantLine_SelectedIndexChanged"></asp:DropDownList>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label3" runat="server" AssociatedControlID="DDL_ProductCategory" Text="Product Category" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductCategory" runat="server" ErrorMessage="Required" ForeColor="Red" ValidationGroup="Submit" InitialValue="0" ControlToValidate="DDL_ProductCategory" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_ProductCategory" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductCategory_SelectedIndexChanged"></asp:DropDownList>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label4" runat="server" AssociatedControlID="DDL_ProductBrand" Text="Product Brand" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_ProductBrand" runat="server" ErrorMessage="Required" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_ProductBrand" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_ProductBrand" runat="server" CssClass="form-control form-control-sm rounded" AutoPostBack="true" OnSelectedIndexChanged="DDL_ProductBrand_SelectedIndexChanged"></asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="DDL_BrandSKU" Text="Brand SKU Type" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_DDL_BrandSKU" runat="server" ErrorMessage="Required" ForeColor="Red" ValidationGroup="Submit" ControlToValidate="DDL_BrandSKU" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:DropDownList ID="DDL_BrandSKU" runat="server" CssClass="form-control form-control-sm rounded"></asp:DropDownList>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="Lbl_TB_VartyPkt" runat="server" AssociatedControlID="TB_VartyPkt" Text="Variety Packet:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_VartyPkt" runat="server" ErrorMessage="Input Required" ControlToValidate="TB_VartyPkt" ValidationGroup="Submit" InitialValue="" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_VartyPkt" runat="server" ControlToValidate="TB_VartyPkt" ForeColor="Red" ValidationGroup="Submit" ErrorMessage="Alphanumeric Only" ValidationExpression="^[a-zA-Z0-9, /]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_VartyPkt" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Variety Packet (3-20 characters)" MaxLength="20"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-12 text-center">
                                                                <asp:Button ID="Btn_Save" runat="server" Text="Proceed Next" OnClick="Btn_Save_Click" CssClass="btn btn-sm btn-primary" ValidationGroup="Submit" CausesValidation="true" />
                                                                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClick="btnReset_Click" />
                                                                <asp:Button ID="btn_home" runat="server" Text="HOME" CssClass="btn btn-sm btn-info" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                                                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="tab-pane fade" id="rawBiscuts" role="tabpanel" aria-labelledby="rawBiscuts-tab">
                                                        <div class="x_content">
                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="lbl_TB_LineNos" runat="server" AssociatedControlID="TB_LineNos" Text="No Of Rotary Lines:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_LineNos" runat="server" ErrorMessage="MRP Required" InitialValue="" ValidationGroup="Submit" ControlToValidate="TB_LineNos" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_LineNos" runat="server" ValidationGroup="Submit" ControlToValidate="TB_LineNos" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <asp:RangeValidator ID="RV_TB_LineNos" runat="server" ControlToValidate="TB_LineNos" ErrorMessage="[10 - 25]" ForeColor="Red" MinimumValue="10" MaximumValue="25" Type="Double" Display="Static"></asp:RangeValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_LineNos" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Min:10 -- Max:25" Text="28" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <asp:GridView ID="LineWeights_Grid" runat="server" Visible="true" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="SL" HeaderStyle-ForeColor="Blue" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Small">
                                                                        <ItemTemplate>
                                                                            <%# Container.DataItemIndex + 1 %>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="text-center" />
                                                                        <ItemStyle CssClass="text-center" />
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="Starting Line Wt:" HeaderStyle-ForeColor="Blue" HeaderStyle-Font-Bold="true" HeaderStyle-Font-Size="Small">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtStlWeight" runat="server" CssClass="form-control form-control-sm rounded line-weight" oninput="calculateAverageWeight()"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="text-center" />
                                                                        <ItemStyle CssClass="text-center" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>

                                                        <div class="col-md-3" id="AvgWt_TB" runat="server" visible="true">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="lbl_lblAvgWeight" runat="server" AssociatedControlID="lblAvgWeight" Text="Avergae of all the Weights:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <div class="input-group-sm">
                                                                        <asp:Label ID="lblAvgWeight" runat="server" Text="0"></asp:Label> gm
                                                                        <%--<asp:TextBox ID="txtAverageGrossWeight" runat="server" CssClass="form-control form-control-sm rounded"></asp:TextBox>--%>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        <%--<h4>Average Weight:
                                                            <asp:Label ID="lblAvgWeight" runat="server" Text="0"></asp:Label>
                                                            kg</h4>--%>

                                                        <div class="col-md-12 text-center">
                                                            <asp:Button ID="btn_rawSubmit" runat="server" Text="Proceed Next" OnClientClick="return validateGridView1();" OnClick="btn_rawSubmit_Click" CssClass="btn btn-sm btn-primary" />
                                                            <asp:Button ID="btn_rawrest" runat="server" Text="Reset Grid" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClientClick="clearGridView1TextBoxes(); return false;" />
                                                            <asp:Button ID="Button2" runat="server" Text="HOME" CssClass="btn btn-sm btn-info" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                                        </div>
                                                    </div>

                                                    <div class="tab-pane fade" id="ovenReport" role="tabpanel" aria-labelledby="ovenReport-tab">
                                                        <div class="x_content">

                                                            <div class="col-md-3">
                                                                <div class="mb-3">
                                                                    <asp:Label ID="lbl_TB_OvenNos" runat="server" AssociatedControlID="TB_OvenNos" Text="No Of Lines at Oven END:" ForeColor="Blue" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    <asp:RequiredFieldValidator ID="RFV_TB_OvenNos" runat="server" ErrorMessage="MRP Required" InitialValue="" ValidationGroup="Submit" ControlToValidate="TB_OvenNos" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                    <asp:RegularExpressionValidator ID="REV_TB_OvenNos" runat="server" ValidationGroup="Submit" ControlToValidate="TB_OvenNos" ForeColor="Red" ErrorMessage="Numeric Only" ValidationExpression="\d+" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                    <asp:RangeValidator ID="RV_TB_OvenNos" runat="server" ControlToValidate="TB_OvenNos" ErrorMessage="[10 - 25]" ForeColor="Red" MinimumValue="10" MaximumValue="25" Type="Double" Display="Static"></asp:RangeValidator>
                                                                    <div class="input-group-sm">
                                                                        <asp:TextBox ID="TB_OvenNos" runat="server" CssClass="form-control form-control-sm rounded" Placeholder="Min:10 -- Max:25" Text="28" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <asp:GridView ID="OvenEnd_GridView" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap">
                                                                <Columns>

                                                                    <asp:TemplateField HeaderText="SL" HeaderStyle-ForeColor="Blue"
                                                                        HeaderStyle-Font-Bold="true"
                                                                        HeaderStyle-Font-Size="Small">
                                                                        <ItemTemplate>
                                                                            <%# Container.DataItemIndex + 1 %>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="text-center" />
                                                                        <ItemStyle CssClass="text-center" />
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="Gauge Length(mm) :" HeaderStyle-ForeColor="Blue"
                                                                        HeaderStyle-Font-Bold="true"
                                                                        HeaderStyle-Font-Size="Small">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtGaugeLength" runat="server" CssClass="form-control form-control-sm rounded gauge-length" oninput="calculateAverageGaugeLength()"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="text-center" />
                                                                        <ItemStyle CssClass="text-center" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Weight (gm):" HeaderStyle-ForeColor="Blue"
                                                                        HeaderStyle-Font-Bold="true"
                                                                        HeaderStyle-Font-Size="Small">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtWeight" runat="server" CssClass="form-control form-control-sm rounded weight" oninput="calculateAverageWeight1()"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="text-center" />
                                                                        <ItemStyle CssClass="text-center" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>

                                                            <h4>Average Gauge Length: <span id="lblAvgGaugeLength">0.00 mm</span></h4>
                                                            <br />
                                                            <h4>Average Weight:
                                                                <asp:Label ID="lblAvgWeights" runat="server" Text="0"></asp:Label>
                                                                gm</h4>
                                                        </div>

                                                        <div class="col-md-12 text-center">
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Final Submit" OnClientClick="return validateGridView();" OnClick="btnOvenSubmit_Click" CssClass="btn btn-sm btn-primary" />
                                                            <asp:Button ID="Button1" runat="server" Text="Reset Grid" CssClass="btn btn-warning btn-sm" CausesValidation="false" OnClientClick="clearGridView2TextBoxes(); return false;" />
                                                            <asp:Button ID="Button3" runat="server" Text="HOME" CssClass="btn btn-sm btn-info" CausesValidation="false" PostBackUrl="~/home.aspx" />
                                                            <asp:Label ID="Label6" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
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

            <div class="row">
                <div class="col-md-12">
                    <div class="x_panel">
                        <div class="x_title">
                            <h2>
                                <asp:Label ID="Label7" runat="server" Text="Approval Matrix"></asp:Label></h2>
                            <div class="clearfix"></div>

                        </div>
                        <div class="x_content">
                            <!-- Approver Flow Diagram -->
                            <div class="approver-flow">
                                <div class="approver-item">
                                    <p>
                                        <asp:Label ID="Label8" runat="server" Text="Approver 1" />
                                    </p>
                                    <asp:Image ID="Image3" runat="server" ImageUrl="~/WebData/No_Image.jpg" class="approver-photo" />
                                    <p>
                                        <asp:Label ID="Approver1NameLabel" runat="server" Text='<%# Eval("Approver1Name") %>' />
                                    </p>
                                    <p>
                                        <asp:Label ID="Approver1CodeLabel" runat="server" Text='<%# Eval("Approver1EmployeeCode") %>' />
                                    </p>
                                </div>
                                <div class="flow-line"></div>
                                <div class="approver-item">
                                    <p>
                                        <asp:Label ID="Label9" runat="server" Text="Approver 2" />
                                    </p>
                                    <asp:Image ID="Image2" runat="server" ImageUrl="~/WebData/No_Image.jpg" class="approver-photo" />
                                    <p>
                                        <asp:Label ID="Approver2NameLabel" runat="server" Text='<%# Eval("Approver2Name") %>' />
                                    </p>
                                    <p>
                                        <asp:Label ID="Approver2CodeLabel" runat="server" Text='<%# Eval("Approver2EmployeeCode") %>' />
                                    </p>
                                </div>
                                <div class="flow-line"></div>
                                <div class="approver-item">
                                    <p>
                                        <asp:Label ID="Label10" runat="server" Text="Approver 3" />
                                    </p>
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/WebData/No_Image.jpg" class="approver-photo" />
                                    <p>
                                        <asp:Label ID="DottedLineApproverNameLabel" runat="server" Text='<%# Eval("DottedLineApproverName") %>' />
                                    </p>
                                    <p>
                                        <asp:Label ID="DottedLineApproverCodeLabel" runat="server" Text='<%# Eval("DottedLineApproverEmployeeCode") %>' />
                                    </p>
                                </div>
                            </div>

                            <hr />

                            <!-- GridView for Detailed Information -->
                            <asp:GridView ID="GridViewApprovers" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover table-bordered table-responsive table-sm table-condensed text-wrap" Visible="false">
                                <Columns>
                                    <asp:BoundField DataField="Approver1Name" HeaderText="Approver 1 Name" HtmlEncode="false" />
                                    <asp:BoundField DataField="Approver1EmployeeCode" HeaderText="Approver 1" HtmlEncode="false" />
                                    <asp:BoundField DataField="Approver2Name" HeaderText="Approver 2 Name" HtmlEncode="false" />
                                    <asp:BoundField DataField="Approver2EmployeeCode" HeaderText="Approver 2" HtmlEncode="false" />
                                    <asp:BoundField DataField="DottedLineApproverName" HeaderText="Dotted Line Approver Name" HtmlEncode="false" />
                                    <asp:BoundField DataField="DottedLineApproverEmployeeCode" HeaderText="Dotted Line Approver Code" HtmlEncode="false" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
