using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection.Emit;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;
using System.Diagnostics;
using static System.Net.Mime.MediaTypeNames;


namespace AnmolDristi
{
    public partial class FireExtinguisherChecklist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindChecklist();
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetEmployeeName(string inspectionId)
        {
            string employeeName = string.Empty;

            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            string query = "SELECT EmployeeName FROM [CSMS].[dbo].[FireExtinguisherHeader] WHERE InspectedBy = @InspectedBy";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@InspectedBy", inspectionId);

                try
                {
                    conn.Open();
                    var result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        employeeName = result.ToString();
                    }
                    else
                    {
                        employeeName = "Invalid Inspection ID";
                    }
                }
                catch
                {
                    employeeName = "Error occurred while fetching data";
                }
            }

            return employeeName;
        }


        private void BindChecklist()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));
            dt.Rows.Add(1, "Nozzle (house) Condition.");
            dt.Rows.Add(2, "Is the pin in place.");
            dt.Rows.Add(3, "Does the gauge show in the green.");
            dt.Rows.Add(4, "Tag attached.");
            dt.Rows.Add(5, "Body Condition.");
            rptChecklist.DataSource = dt;
            rptChecklist.DataBind();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // 1. Insert into 
                string insertHeaderQuery = @"
            INSERT INTO FireExtinguisherHeader (ChecklistDate, JobID, Location, EmployeeName, InspectedBy, Remarks)
            OUTPUT INSERTED.HeaderID
            VALUES (@ChecklistDate, @JobID, @Location, @EmployeeName, @InspectedBy, @Remarks)";

                SqlCommand cmdHeader = new SqlCommand(insertHeaderQuery, con);
                cmdHeader.Parameters.AddWithValue("@ChecklistDate", Convert.ToDateTime(txtdate.Text));
                cmdHeader.Parameters.AddWithValue("@JobID", txtjobId.Text);
                cmdHeader.Parameters.AddWithValue("@Location", txtloc.Text);
                cmdHeader.Parameters.AddWithValue("@EmployeeName", hfEmployeeName.Value.Trim());
                cmdHeader.Parameters.AddWithValue("@InspectedBy", txtInsBy.Text);
                cmdHeader.Parameters.AddWithValue("@Remarks", txtnote.Text);

                int headerID = (int)cmdHeader.ExecuteScalar();

                //  checklist items from  repeater
                SaveChecklistItemsFromRepeater(rptChecklist, con, headerID);


                con.Close();
            }


            lblMsg.Text = "Data saved successfully!";
            
        }
        private void SaveChecklistItemsFromRepeater(Repeater rpt, SqlConnection con, int headerID)
        {
            foreach (RepeaterItem item in rpt.Items)
            {

                HiddenField hfQuestionNumber = (HiddenField)item.FindControl("hfQuestionNumber");
                int questionNumber = Convert.ToInt32(hfQuestionNumber.Value);

                int qn = 0;
                if (hfQuestionNumber != null && int.TryParse(hfQuestionNumber.Value, out qn))
                {
                    questionNumber = qn;
                }


                RadioButton rdoYes = (RadioButton)item.FindControl("rdoYes");
                RadioButton rdoNo = (RadioButton)item.FindControl("rdoNo");
                RadioButton rdoNA = (RadioButton)item.FindControl("rdoNA");

                TextBox txtRemarks = (TextBox)item.FindControl("txtRemarks");
                FileUpload fileUpload = (FileUpload)item.FindControl("fileUpload");

                bool isOk = rdoYes != null && rdoYes.Checked;
                bool na = rdoNA != null && rdoNA.Checked;

                string remarks = txtRemarks?.Text ?? "";
                string photoPath = "";

                if (fileUpload != null && fileUpload.HasFile)
                {
                    string fileName = Path.GetFileName(fileUpload.FileName);
                    string savePath = Server.MapPath("~/Uploads1/" + fileName);
                    fileUpload.SaveAs(savePath);
                    photoPath = "~/Uploads1/" + fileName;
                }
                //Label lblDescription = (Label)item.FindControl("lblDescription");
                System.Web.UI.WebControls.Label lblDescription = (System.Web.UI.WebControls.Label)item.FindControl("lblDescription");
                string description = lblDescription?.Text ?? "";

                string insertDetailQuery = @"
            INSERT INTO FireExtinguisherChecklist (HeaderID,ExtinguisherType,FE_SerialNo,CalibrationDate,DueDate, QuestionNumber, IsOk, Remarks, PhotoPath, NA,description)
            VALUES (@HeaderID,@ExtinguisherType,@FE_SerialNo,@CalibrationDate,@DueDate, @QuestionNumber, @IsOk, @Remarks, @PhotoPath, @NA,@description)";

                SqlCommand cmdDetail = new SqlCommand(insertDetailQuery, con);
                cmdDetail.Parameters.AddWithValue("@HeaderID", headerID);
                cmdDetail.Parameters.AddWithValue("@ExtinguisherType", ddlType.SelectedValue);
                cmdDetail.Parameters.AddWithValue("@FE_SerialNo", txtsno.Text);
                cmdDetail.Parameters.AddWithValue("@CalibrationDate", Convert.ToDateTime(txtCalibrationDate.Text));
                cmdDetail.Parameters.AddWithValue("@DueDate", Convert.ToDateTime(txtDueDate.Text));    
                cmdDetail.Parameters.AddWithValue("@QuestionNumber", questionNumber);
                cmdDetail.Parameters.AddWithValue("@IsOk", isOk);
                cmdDetail.Parameters.AddWithValue("@Remarks", remarks);
                cmdDetail.Parameters.AddWithValue("@PhotoPath", photoPath);
                cmdDetail.Parameters.AddWithValue("@NA", na);
                cmdDetail.Parameters.AddWithValue("@description", description);
                cmdDetail.ExecuteNonQuery();
            }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("FireExtinguisherChecklist.aspx");
        }
    }
}