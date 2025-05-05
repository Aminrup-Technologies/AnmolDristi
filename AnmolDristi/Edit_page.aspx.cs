using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Edit_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("EmpType");
            dt.Columns.Add("EmpCode");
            dt.Columns.Add("EmpName");

            // Add one row (dummy data just for UI)
            dt.Rows.Add("Manager", "E001", "John Doe");

            gvEmployees.DataSource = dt;
            gvEmployees.DataBind();
        }
    }
}