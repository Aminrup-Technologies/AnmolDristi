using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class practice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnAddIssues_Click(object sender, EventArgs e)
        {
            DataTable dts;
            if (ViewState["Issues"] == null)
            {
                dts = new DataTable();
                dts.Columns.Add("SNo");
                dts.Columns.Add("IssuesDiscussed");
            }
            else
            {
                dts = (DataTable)ViewState["Issues"];
            }

            // Generating SNo dynamically
            int serialNo = dts.Rows.Count + 1;

            // Retrieve issues from hidden field
            string allIssues = hdnPointsDiscussed.Value.Trim();

            if (!string.IsNullOrEmpty(allIssues))
            {
                DataRow dr = dts.NewRow();
                dr["SNo"] = serialNo;
                dr["IssuesDiscussed"] = allIssues; // Comma-separated values

                dts.Rows.Add(dr);

                ViewState["Issues"] = dts;
                gvIssues.DataSource = dts;
                gvIssues.DataBind();
            }

            // Clear input fields
            txtIssuesDes.Text = "";
            hdnPointsDiscussed.Value = "";
        }

        //protected void btnAddIssues_Click(object sender, EventArgs e)
        //{
        //    DataTable dts;
        //    if (ViewState["Issues"] == null)
        //    {
        //        dts = new DataTable();
        //        dts.Columns.Add("SNo");

        //        dts.Columns.Add("IssuesDiscussed");

        //    }
        //    else
        //    {
        //        dts = (DataTable)ViewState["Issues"];
        //    }
        //    // Generating SNo dynamically
        //    int serialNo = dts.Rows.Count + 1;

        //    DataRow dr = dts.NewRow();
        //    dr["SNo"] = serialNo;

        //    dr["IssuesDiscussed"] = txtIssuesDes.Text.Trim();


        //    dts.Rows.Add(dr);

        //    ViewState["Issues"] = dts;
        //    gvIssues.DataSource = dts;
        //    gvIssues.DataBind();

        //    // Clear input fields for next attendee

        //    txtIssuesDes.Text = "";


        //}
        protected void BtnDelete_Click(object sender, EventArgs e)
        {

        }
    }
}