<%@ Page Title="" Language="C#" MasterPageFile="~/Dristi.Master" AutoEventWireup="true" CodeBehind="CAPA_MASTER.aspx.cs" Inherits="AnmolDristi.CAPA_MASTER" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* CAPA Form Unique Styling */
        #capaFormWrapper {
            background: linear-gradient(180deg, #f3f5ff, #ffffff);
            padding: 20px;
            border-radius: 10px;
        }

        .capa-section {
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.08);
        }

        .capa-section h3 {
            background: linear-gradient(to right, #3f51b5, #5c6bc0);
            color: #fff;
            padding: 10px 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 1.2rem;
        }

        .capa-label {
            font-weight: 500;
            margin-bottom: 5px;
            display: block;
        }

        .capa-img-preview {
            width: 200px;              /* fixed width */
            height: 150px;             /* fixed height */
            object-fit: contain;       /* keeps image proportion without cropping */
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f8f8f8; /* light gray background */
            padding: 5px;
        }



        .capa-back-btn {
            margin-bottom: 20px;
        }

        /* Responsive tweaks */
        @media (max-width: 768px) {
            .capa-section h3 {
                font-size: 1rem;
                padding: 8px 12px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="right_col" role="main">
        <div id="capaFormWrapper" class="container-fluid">

            <!-- Back Button -->
            <div class="row capa-back-btn">
                <div class="col-12">
                    <asp:Button ID="btnBack" runat="server" Text="← Back" CssClass="btn btn-secondary" PostBackUrl="~/bussiness/production/TargetPage.aspx" />
                </div>
            </div>

            <!-- General Details -->
            <div class="capa-section">
                <h3>General Details</h3>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Source Record Type</label>
                        <asp:TextBox ID="txtSourceRecordType" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Source Record ID</label>
                        <asp:TextBox ID="txtSourceRecordID" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Raised By</label>
                        <asp:TextBox ID="txtRaisedBy" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Description of the Issue</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- Corrective Actions -->
            <div class="capa-section">
                <h3>Corrective Actions</h3>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Corrective Actions</label>
                        <asp:TextBox ID="txtCorrectiveActions" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Corrective Action Note</label>
                        <asp:TextBox ID="txtCorrectiveNote" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" ReadOnly="true"></asp:TextBox>
                    </div>

                    <!-- Corrective Action Photo -->
                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Corrective Action Photo</label>
                        <asp:TextBox ID="txtCorrectivePhotoName" runat="server" CssClass="form-control mb-2" ReadOnly="true"></asp:TextBox>
                        <asp:Image ID="imgCorrectivePhoto" runat="server" CssClass="capa-img-preview" ImageUrl="https://cdn-icons-png.flaticon.com/512/4218/4218934.png"/>
                    </div>

                    <div class="col-md-3 mb-3">
                        <label class="capa-label">Corrective Action Date</label>
                        <asp:TextBox ID="txtCorrectiveDate" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="capa-label">Corrective Action By</label>
                        <asp:TextBox ID="txtCorrectiveBy" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- Preventive Actions -->
            <div class="capa-section">
                <h3>Preventive Actions</h3>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Preventive Action</label>
                        <asp:TextBox ID="txtPreventiveAction" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Preventive Action Note</label>
                        <asp:TextBox ID="txtPreventiveNote" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" ReadOnly="true"></asp:TextBox>
                    </div>

                    <!-- Preventive Action Photo -->
                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Preventive Action Photo</label>
                        <asp:TextBox ID="txtPreventivePhotoName" runat="server" CssClass="form-control mb-2" ReadOnly="true"></asp:TextBox>
                        <asp:Image ID="imgPreventivePhoto" runat="server" CssClass="capa-img-preview" ImageUrl="https://cdn-icons-png.flaticon.com/512/4218/4218934.png" />
                    </div>

                    <div class="col-md-3 mb-3">
                        <label class="capa-label">Preventive Action Date</label>
                        <asp:TextBox ID="txtPreventiveDate" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="capa-label">Preventive Action By</label>
                        <asp:TextBox ID="txtPreventiveBy" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
            </div>

            <!-- Verification Status -->
            <div class="capa-section">
                <h3>Verification Status</h3>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="capa-label">Target Completion Date</label>
                        <asp:TextBox ID="txtTargetCompletion" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="capa-label">Responsible Person</label>
                        <asp:TextBox ID="txtResponsiblePerson" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="capa-label">Status</label>
                        <asp:TextBox ID="txtStatus" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Remarks</label>
                        <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" ReadOnly="true"></asp:TextBox>
                    </div>

                    <!-- Photo Uploaded -->
                    <div class="col-md-6 mb-3">
                        <label class="capa-label">Photo Uploaded</label>
                        <asp:TextBox ID="txtUploadedPhotoName" runat="server" CssClass="form-control mb-2" ReadOnly="true"></asp:TextBox>
                        <asp:Image ID="imgUploadedPhoto" runat="server" CssClass="capa-img-preview" ImageUrl="https://cdn-icons-png.flaticon.com/512/4218/4218934.png" />
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="capa-label">Reviewed By</label>
                        <asp:TextBox ID="txtReviewedBy" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="capa-label">Verification Status</label>
                        <asp:TextBox ID="txtVerificationStatus" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
