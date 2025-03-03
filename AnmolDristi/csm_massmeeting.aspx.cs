using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing.Drawing2D;
using AnmolDristi.DAL;
using System.Globalization;
using System.Web.Script.Serialization;

namespace AnmolDristi
{
    public partial class csm_massmeeting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string Employee_Name = tb_name.Text;
            string Designation = tb_des.Text;
            string Location = tb_loc.Text;
            string RFID = tb_rfid.Text;
           // string Points_Discussed= tb_points.Text;
            string Points_Discussed = hdnPointsDiscussed.Value;
            DateTime? Meeting_Date = string.IsNullOrEmpty(TB_Date.Text) ? (DateTime?)null : Convert.ToDateTime(TB_Date.Text);
            TimeSpan? Meeting_Time = string.IsNullOrEmpty(tb_time.Text) ? (TimeSpan?)null : TimeSpan.Parse(tb_time.Text);
            
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();
                try
                {
                    int Meeting_ID;
                    using (SqlCommand cmd = new SqlCommand("InsertMeetingData", conn, transaction))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        SqlParameter outputMeetingID = new SqlParameter("@Meeting_ID", System.Data.SqlDbType.Int)
                        {
                            Direction = System.Data.ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputMeetingID);
                        cmd.Parameters.AddWithValue("@Location", Location);
                        cmd.Parameters.AddWithValue("@Meeting_Date", Meeting_Date);
                        cmd.Parameters.AddWithValue("@Meeting_Time", Meeting_Time);
                        cmd.ExecuteNonQuery();
                        Meeting_ID = Convert.ToInt32(outputMeetingID.Value);
                    }

                    int Attendees_ID;
                    using (SqlCommand cmd = new SqlCommand("InsertAttendeeData", conn, transaction))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        SqlParameter outputAttendeesID = new SqlParameter("@Attendees_ID", System.Data.SqlDbType.Int)
                        {
                            Direction = System.Data.ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputAttendeesID);
                        cmd.Parameters.AddWithValue("@Employee_Name", Employee_Name);
                        cmd.Parameters.AddWithValue("@Designation", Designation);
                        cmd.Parameters.AddWithValue("@RFID", RFID);
                        cmd.Parameters.AddWithValue("@Meeting_ID", Meeting_ID);
                        cmd.ExecuteNonQuery();

                        if (outputAttendeesID.Value == DBNull.Value)
                        {
                            transaction.Rollback();
                            lblMsg.Text = "Error: Attendee ID not generated.";
                            return;
                        }
                        Attendees_ID = Convert.ToInt32(outputAttendeesID.Value);
                    }


                    using (SqlCommand cmd = new SqlCommand("InsertPointsData", conn, transaction))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Points_Discussed",Points_Discussed);
                        cmd.Parameters.AddWithValue("@Attendees_ID", Attendees_ID);
                        cmd.ExecuteNonQuery();
                    }
                    transaction.Commit();
                    lblMsg.Text = "Transaction completed successfully!";
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lblMsg.Text = "Transaction failed: " + ex.Message;
                    throw new Exception("Transaction failed", ex);
                }
            }
            TB_Date.Text = string.Empty;
            tb_time.Text= string.Empty;
            tb_loc.Text = string.Empty;
            tb_name.Text = string.Empty;
            tb_des.Text = string.Empty;
            tb_rfid.Text = string.Empty;
            tb_points.Text = string.Empty;
        }

       
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("csm_massmeeting.aspx");


        }
        protected void addbutton(object sender, EventArgs e)
        {

        }
        protected void removebutton(object sender, EventArgs e)
        {

        }
        





    }
}

