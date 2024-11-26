using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Dristi : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["USERID"] == null || Session["USERNAME"] == null || Session["WORKMAN"] == null)
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    Label lbl1 = (Label)Page.Master.FindControl("lbl_loginusername2");
                    lbl1.Text = Session["USERNAME"].ToString();

                    Label lbl2 = (Label)Page.Master.FindControl("lbl_loginusername1");
                    lbl2.Text = Session["USERFNAME"].ToString();

                    if (Session["USERID"].ToString() == "AHO445" || Session["USERID"].ToString() == "ADMIN")
                    {
                        DataMastering.Visible = true;
                    }
                    else
                    {
                        DataMastering.Visible = false;
                    }
                }
            }
        }

        protected void btn_Logout_Click(object sender, EventArgs e)
        {
            //dbcl.WriteToFile("User :" + lbl_loginusername1.Text.ToString() + " Singout Successfully");
            //Update loginstatus and Last Login Information i.e. date
            //dbcl.UPDT_EmpMuster_LogoutInfo(Session["WORKMAN"].ToString(), Session["USERID"].ToString());

            Session.Abandon();
            Response.Redirect("login.aspx");
        }
    }
}