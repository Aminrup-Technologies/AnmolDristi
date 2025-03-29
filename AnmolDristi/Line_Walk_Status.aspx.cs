using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace AnmolDristi
{
    public partial class Line_Walk_Status : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["USERID"] == null || Session["USERNAME"] == null || Session["WORKMAN"] == null)
                {

                }
                else
                {

                }
            }
        }

        [WebMethod]
        public static string GetEmployeeName(string empCode)
        {
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string query = "SELECT EmployeeName FROM MST_UserMaster WHERE EmployeeCode = @EmpCode";
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@EmpCode", empCode);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    return result != null ? result.ToString() : "";
                }
            }
        }

        [WebMethod]
        public static string SaveMembers(string internalEmployeesCSV, string externalMembersCSV)
        {
            string connString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();
                string query = "INSERT INTO tbl_Members (InternalEmployees, ExternalMembers) VALUES (@Internal, @External)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Internal", string.IsNullOrEmpty(internalEmployeesCSV) ? (object)DBNull.Value : internalEmployeesCSV);
                    cmd.Parameters.AddWithValue("@External", string.IsNullOrEmpty(externalMembersCSV) ? (object)DBNull.Value : externalMembersCSV);
                    //cmd.ExecuteNonQuery();
                }
            }
            return "Members saved successfully!";
        }


        //        protected void BtnSubmit_Click(object sender, EventArgs e)
        //        {

        //            try
        //            {
        //                using (SqlConnection connection = new SqlConnection(connectionString))
        //                {
        //                    connection.Open();
        //                    using (SqlCommand command = new SqlCommand("SP_Workers_PPE_Checklist", connection))
        //                    {
        //                        command.CommandType = CommandType.StoredProcedure;
        //        //Execute the query
        //        command.ExecuteNonQuery();



        //                    }
        //    connection.Close();
        //                }
        ////Show SweetAlert2 after successful submission
        //string script = "Swal.fire({ title: 'Success!', text: 'Data submitted successfully.', icon: 'success' });";
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitSuccess", script, true);

        //        }

        //          catch (Exception ex)
        //            {
        //                lbl_msg.Text = "Error: " + ex.Message;
        //                lbl_msg.ForeColor = System.Drawing.Color.Red;

        //                // ❌ Show SweetAlert2 on error
        //                string errorScript = $"Swal.fire({{ title: 'Error!', text: '{ex.Message}', icon: 'error' }});";
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitError", errorScript, true);
        //        }
        //        }


        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("Line_Walk_Status.aspx");
        }
    }
}



