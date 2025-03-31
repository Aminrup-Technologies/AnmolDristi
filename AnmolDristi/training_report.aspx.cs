// TrainingSession.aspx.cs
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class TrainingSession : System.Web.UI.Page
{
    // Connection string from web.config
    private string connectionString = ConfigurationManager.ConnectionStrings["TrainingDBConnection"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDepartments();
            LoadInitialFormFields();
        }
    }

    private void LoadDepartments()
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT DISTINCT Department FROM Training_Session_Master";
            SqlCommand cmd = new SqlCommand(query, conn);
            conn.Open();
            ddlDepartment.DataSource = cmd.ExecuteReader();
            ddlDepartment.DataTextField = "Department";
            ddlDepartment.DataBind();
        }
    }

    private void LoadInitialFormFields()
    {
        // Add initial rows for participants and discussion points
        AddParticipantRow();
        AddDiscussionPointRow();
    }

    protected void AddParticipantRow_Click(object sender, EventArgs e)
    {
        AddParticipantRow();
    }

    private void AddParticipantRow()
    {
        // Create a new row for participant entry
        TableRow row = new TableRow();

        // Participant Code
        TableCell cellCode = new TableCell();
        TextBox txtParticipantCode = new TextBox();
        txtParticipantCode.ID = "txtParticipantCode_" + participantsTable.Rows.Count;
        txtParticipantCode.CssClass = "form-control";
        cellCode.Controls.Add(txtParticipantCode);
        row.Cells.Add(cellCode);

        // Participant Name
        TableCell cellName = new TableCell();
        TextBox txtParticipantName = new TextBox();
        txtParticipantName.ID = "txtParticipantName_" + participantsTable.Rows.Count;
        txtParticipantName.CssClass = "form-control";
        cellName.Controls.Add(txtParticipantName);
        row.Cells.Add(cellName);

        // Designation
        TableCell cellDesignation = new TableCell();
        TextBox txtDesignation = new TextBox();
        txtDesignation.ID = "txtDesignation_" + participantsTable.Rows.Count;
        txtDesignation.CssClass = "form-control";
        cellDesignation.Controls.Add(txtDesignation);
        row.Cells.Add(cellDesignation);

        // Signature (Y/N)
        TableCell cellSignature = new TableCell();
        DropDownList ddlSignature = new DropDownList();
        ddlSignature.ID = "ddlSignature_" + participantsTable.Rows.Count;
        ddlSignature.CssClass = "form-control";
        ddlSignature.Items.Add("Y");
        ddlSignature.Items.Add("N");
        cellSignature.Controls.Add(ddlSignature);
        row.Cells.Add(cellSignature);

        // Feedback
        TableCell cellFeedback = new TableCell();
        TextBox txtFeedback = new TextBox();
        txtFeedback.ID = "txtFeedback_" + participantsTable.Rows.Count;
        txtFeedback.CssClass = "form-control";
        cellFeedback.Controls.Add(txtFeedback);
        row.Cells.Add(cellFeedback);

        // Add row to table
        participantsTable.Rows.Add(row);
    }

    protected void AddDiscussionPoint_Click(object sender, EventArgs e)
    {
        AddDiscussionPointRow();
    }

    private void AddDiscussionPointRow()
    {
        // Create a new row for discussion point
        TableRow row = new TableRow();

        // Discussion Point
        TableCell cellPoint = new TableCell();
        TextBox txtDiscussionPoint = new TextBox();
        txtDiscussionPoint.ID = "txtDiscussionPoint_" + discussionPointsTable.Rows.Count;
        txtDiscussionPoint.CssClass = "form-control";
        cellPoint.Controls.Add(txtDiscussionPoint);
        row.Cells.Add(cellPoint);

        // Add row to table
        discussionPointsTable.Rows.Add(row);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        // Validate form
        if (!ValidateForm())
        {
            return;
        }

        // Begin transaction
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            SqlTransaction transaction = conn.BeginTransaction();

            try
            {
                // Insert Training Session Master
                int trainingId = InsertTrainingSessionMaster(conn, transaction);

                // Insert Participants
                InsertParticipants(conn, transaction, trainingId);

                // Insert Discussion Points
                InsertDiscussionPoints(conn, transaction, trainingId);

                // Commit transaction
                transaction.Commit();

                // Show success message
                lblMessage.Text = "Training Session saved successfully!";
                lblMessage.CssClass = "alert alert-success";
            }
            catch (Exception ex)
            {
                // Rollback transaction
                transaction.Rollback();

                // Show error message
                lblMessage.Text = "Error saving training session: " + ex.Message;
                lblMessage.CssClass = "alert alert-danger";
            }
        }
    }

    private bool ValidateForm()
    {
        // Basic form validation
        if (string.IsNullOrEmpty(txtTopic.Text))
        {
            lblMessage.Text = "Topic is required.";
            lblMessage.CssClass = "alert alert-danger";
            return false;
        }

        // Add more validation as needed
        return true;
    }

    private int InsertTrainingSessionMaster(SqlConnection conn, SqlTransaction transaction)
    {
        string query = @"
            INSERT INTO Training_Session_Master 
            (Topic, Trainer_Name, Date, Time, Duration_Minutes, Department, Section, Photograph_File_Name)
            VALUES 
            (@Topic, @TrainerName, @Date, @Time, @Duration, @Department, @Section, @PhotoFileName);
            SELECT SCOPE_IDENTITY();";

        using (SqlCommand cmd = new SqlCommand(query, conn, transaction))
        {
            // Add parameters
            cmd.Parameters.AddWithValue("@Topic", txtTopic.Text);
            cmd.Parameters.AddWithValue("@TrainerName", txtTrainerName.Text);
            cmd.Parameters.AddWithValue("@Date", DateTime.Parse(txtDate.Text));
            cmd.Parameters.AddWithValue("@Time", TimeSpan.Parse(txtTime.Text));
            cmd.Parameters.AddWithValue("@Duration", int.Parse(txtDuration.Text));
            cmd.Parameters.AddWithValue("@Department", ddlDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@Section", txtSection.Text);

            // Handle file upload
            string photoFileName = UploadPhoto();
            cmd.Parameters.AddWithValue("@PhotoFileName", photoFileName);

            // Execute and return new Training ID
            return Convert.ToInt32(cmd.ExecuteScalar());
        }
    }

    private string UploadPhoto()
    {
        if (filePhotograph.HasFile)
        {
            string fileName = Path.GetFileName(filePhotograph.FileName);
            string fileExt = Path.GetExtension(fileName);
            string newFileName = "training_" + DateTime.Now.ToString("yyyyMMddHHmmss") + fileExt;
            string path = Server.MapPath("~/Uploads/TrainingPhotos/" + newFileName);

            // Ensure directory exists
            Directory.CreateDirectory(Path.GetDirectoryName(path));

            // Save file
            filePhotograph.SaveAs(path);

            return newFileName;
        }
        return string.Empty;
    }

    private void InsertParticipants(SqlConnection conn, SqlTransaction transaction, int trainingId)
    {
        string query = @"
            INSERT INTO Participants_Sheet 
            (Training_ID, Participant_Code, Participant_Name, Designation, Signature, Feedback)
            VALUES 
            (@TrainingId, @ParticipantCode, @ParticipantName, @Designation, @Signature, @Feedback)";

        foreach (TableRow row in participantsTable.Rows)
        {
            // Skip header row
            if (row.Cells.Count == 0) continue;

            // Extract participant details
            TextBox txtCode = row.Cells[0].Controls[0] as TextBox;
            TextBox txtName = row.Cells[1].Controls[0] as TextBox;
            TextBox txtDesignation = row.Cells[2].Controls[0] as TextBox;
            DropDownList ddlSignature = row.Cells[3].Controls[0] as DropDownList;
            TextBox txtFeedback = row.Cells[4].Controls[0] as TextBox;

            // Skip empty rows
            if (string.IsNullOrEmpty(txtName.Text)) continue;

            using (SqlCommand cmd = new SqlCommand(query, conn, transaction))
            {
                cmd.Parameters.AddWithValue("@TrainingId", trainingId);
                cmd.Parameters.AddWithValue("@ParticipantCode", txtCode.Text);
                cmd.Parameters.AddWithValue("@ParticipantName", txtName.Text);
                cmd.Parameters.AddWithValue("@Designation", txtDesignation.Text);
                cmd.Parameters.AddWithValue("@Signature", ddlSignature.SelectedValue);
                cmd.Parameters.AddWithValue("@Feedback", txtFeedback.Text);

                cmd.ExecuteNonQuery();
            }
        }
    }

    private void InsertDiscussionPoints(SqlConnection conn, SqlTransaction transaction, int trainingId)
    {
        string query = @"
            INSERT INTO Discussion_Points_Sheet 
            (Training_ID, Discussion_Point)
            VALUES 
            (@TrainingId, @DiscussionPoint)";

        foreach (TableRow row in discussionPointsTable.Rows)
        {
            // Skip header row
            if (row.Cells.Count == 0) continue;

            // Extract discussion point
            TextBox txtPoint = row.Cells[0].Controls[0] as TextBox;

            // Skip empty rows
            if (string.IsNullOrEmpty(txtPoint.Text)) continue;

            using (SqlCommand cmd = new SqlCommand(query, conn, transaction))
            {
                cmd.Parameters.AddWithValue("@TrainingId", trainingId);
                cmd.Parameters.AddWithValue("@DiscussionPoint", txtPoint.Text);

                cmd.ExecuteNonQuery();
            }
        }
    }
}