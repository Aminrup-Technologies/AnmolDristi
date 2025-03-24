using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Data;

namespace AnmolDristi
{
    public partial class Demo3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnSubmit(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            DateTime time_stamp = DateTime.Now; // time_stamp stores the current date and time (if needed).

            string dept = TB_Dept.Text;
            string job = TB_Job.Text;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("sp_dept", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        //Adding Parameters
                        command.Parameters.AddWithValue("@Time_stamp", time_stamp);

                        command.Parameters.AddWithValue("@job", job);
                        command.Parameters.AddWithValue("@dep", dept);
                        //Execute the query
                        command.ExecuteNonQuery();



                    }
                    connection.Close();


                }

            }
            catch (Exception ex)
            {
                lbl_msg.Text = "Error: " + ex.Message;
                lbl_msg.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}
