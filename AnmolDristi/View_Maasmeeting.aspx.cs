using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class View_Maasmeeting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"];
            if (!string.IsNullOrEmpty(id))
            {
                GetData(Convert.ToInt32(id));
            }
        }

        private void GetData(int id)
        {
            string mmId = null;
            string cs = ConfigurationManager.ConnectionStrings["Dbconn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM csm_massmeting_records WHERE Id = @ID", con);

                cmd.Parameters.AddWithValue("@ID", id);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtMMDocNo.Text = dr["MM_DocNo"].ToString();
                    txtMeetingDate.Text = Convert.ToDateTime(dr["Meeting_Date"]).ToString("yyyy-MM-dd");
                    txtStartTime.Text = dr["Meeting_StartTime"].ToString();
                    txtEndTime.Text = dr["Meeting_EndTime"].ToString();
                    txtDuration.Text = dr["Duration"].ToString();
                    txtRegionCode.Text = dr["RegionCode"].ToString();
                    txtCompanyCode.Text = dr["CompanyCode"].ToString();
                    txtDeptCode.Text = dr["DeptCode"].ToString();
                    txtLocationCode.Text = dr["LocationCode"].ToString();
                    txtExactLocation.Text = dr["ExactLocation"].ToString();
                    txtCoordinator.Text = dr["Coordinator_Name"].ToString();

                    string photoFileName = dr["Photo"] != DBNull.Value ? dr["Photo"].ToString() : null;
                    if (!string.IsNullOrEmpty(photoFileName))
                    {
                        imgPhoto.ImageUrl = "~/Uploads/MassMeetingPhotos/" + photoFileName;
                        imgPhoto.Visible = true;
                    }
                    else
                    {
                        imgPhoto.Visible = false;
                    }

                    mmId = dr["MM_Id"].ToString();
                }
                dr.Close();

                if (!string.IsNullOrEmpty(mmId))
                {
                    SqlCommand attendeeCmd = new SqlCommand(@"
                SELECT EmployeeName, Attendee_Type,AttendeeCode, Designation, Gate_passno
                FROM csm_massmeting_attendee
                WHERE MM_Id = @MM_Id", con);

                    attendeeCmd.Parameters.AddWithValue("@MM_Id", mmId);

                    SqlDataAdapter attendeeDa = new SqlDataAdapter(attendeeCmd);
                    DataTable attendeeDt = new DataTable();
                    attendeeDa.Fill(attendeeDt);

                    gvAttendees.DataSource = attendeeDt;
                    gvAttendees.DataBind();


                    SqlCommand momCmd = new SqlCommand(@"
                SELECT AgendaTitle, EmployeeType, EmployeeName, Description, PointRaisedBy, DiscussionTime
                FROM csm_massmeting_mom
                WHERE MM_Id = @MM_Id", con);
                    momCmd.Parameters.AddWithValue("@MM_Id", mmId);

                    SqlDataAdapter momDa = new SqlDataAdapter(momCmd);
                    DataTable momDt = new DataTable();
                    momDa.Fill(momDt);
                    gvMOM.DataSource = momDt;
                    gvMOM.DataBind();
                }

                con.Close();
            }
        }
        }
        
    }
