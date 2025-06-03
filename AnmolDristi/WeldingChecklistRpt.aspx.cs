using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;
using System.Diagnostics;
using static System.Net.Mime.MediaTypeNames;

namespace AnmolDristi
{
    public partial class WeldingChecklistRpt : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int headerId;
                    if (int.TryParse(Request.QueryString["id"], out headerId))
                    {
                        LoadHeaderDetails(headerId);
                        LoadChecklistItems(headerId);
                    }
                }

                BindChecklist();
                BindChecklist_Cables();
                BindChecklist_Terminals();
                BindChecklist_ElectrodeHolder();
                BindChecklist_WorkArea();
            }
        }

        private void LoadHeaderDetails(int headerId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM WeldingChecklistHeader WHERE HeaderID = @HeaderID", con))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", headerId);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        lblDate.Text = Convert.ToDateTime(dr["ChecklistDate"]).ToString("yyyy-MM-dd");
                        lblJobID.Text = dr["JobID"].ToString();
                        lblLocation.Text = dr["Location"].ToString();
                        lblInspectedBy.Text = dr["InspectedBy"].ToString();
                        lblEmployeeName.Text = dr["EmployeeName"].ToString();
                        lblRemarks.Text = dr["Remarks"].ToString();
                    }
                    con.Close();
                }
            }
        }
        private void BindChecklist()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));
            dt.Rows.Add(1, "In good working condition.");
            dt.Rows.Add(2, "Provided with earthing in grounding.");
            dt.Rows.Add(3, "Fire extinguisher is available.");
            dt.Rows.Add(4, "Rubber mat available.");
            dt.Rows.Add(5, "Double earthing.");
            rptChecklist.DataSource = dt;
            rptChecklist.DataBind();
        }
        private void BindChecklist_Cables()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(10, "Is the cables free from heat.");
            dt.Rows.Add(11, "Properly insulated and no exposed cables.");
            dt.Rows.Add(12, "Size of cable suitable for voltage supply.");
            dt.Rows.Add(13, "Hang up to prevent tripping hazard.");
            dt.Rows.Add(14, "Hang on insulated hook or material.");
            dt.Rows.Add(15, "Cables and joints are properly and in good condition.");

            rptCables.DataSource = dt;
            rptCables.DataBind();
        }
        private void BindChecklist_Terminals()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(6, "In good working condition.");
            dt.Rows.Add(7, "Secured and effectively insulated.");
            dt.Rows.Add(8, "Is joint in healthy condition.");
            dt.Rows.Add(9, "Is the lugging was crimped with tool.");

            rptTerminals.DataSource = dt;
            rptTerminals.DataBind();
        }
        private void BindChecklist_ElectrodeHolder()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(16, "Electrode holder is free from defects.");
            dt.Rows.Add(17, "Return cable clamp is free from defects.");
            dt.Rows.Add(18, "Detech electrodes when not in use.");

            rptElectrodeHolder.DataSource = dt;
            rptElectrodeHolder.DataBind();
        }
        private void BindChecklist_WorkArea()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionNumber", typeof(int));
            dt.Columns.Add("Description", typeof(string));

            dt.Rows.Add(19, "No combustible or flammable material.");
            dt.Rows.Add(20, "Fire Blanket is provided.");
            dt.Rows.Add(21, "Maintain good housekeeping.");
            dt.Rows.Add(22, "Flooring is free from water.");

            rptWorkArea.DataSource = dt;
            rptWorkArea.DataBind();
        }

        //protected void rptGeneral_ItemDataBound(object sender, RepeaterItemEventArgs e)
        //{
        //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //    {
        //        DataRowView dr = (DataRowView)e.Item.DataItem;

        //        CheckBox chkOk = (CheckBox)e.Item.FindControl("chkOk");
        //        CheckBox chkNotOk = (CheckBox)e.Item.FindControl("chkNotOk");
        //        TextBox txtRemarks = (TextBox)e.Item.FindControl("txtRemarks");
        //        //Image imgAttachment = (Image)e.Item.FindControl("imgAttachment");
        //        Image imgAttachment = e.Item.FindControl("imgAttachment") as Image;
        //        if (imgAttachment != null && !string.IsNullOrEmpty(dr["ImagePath"].ToString()))
        //        {
        //            imgAttachment.ImageUrl = dr["ImagePath"].ToString();
        //        }


        //        chkOk.Checked = dr["OK"].ToString() == "1";
        //        chkNotOk.Checked = dr["NotOK"].ToString() == "1";
        //        txtRemarks.Text = dr["Remarks"].ToString();

        //        if (!string.IsNullOrEmpty(dr["ImagePath"].ToString()))
        //        {
        //            imgAttachment.ImageUrl = dr["ImagePath"].ToString();
        //        }
        //    }
        //}


        private void LoadChecklistItems(int headerId)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT  IsOk, NA, Remarks, PhotoPath FROM WeldingChecklist WHERE HeaderID = @HeaderID", con))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", headerId);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    rptChecklist.DataSource = dr;
                    rptChecklist.DataBind();
                    con.Close();
                }
            }
        }





    }
}