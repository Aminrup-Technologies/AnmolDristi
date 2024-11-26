using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace AnmolDristi
{
    public partial class Material_MasterView : System.Web.UI.Page
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
                    lbl_docname.Text = "Search Filter for Material Master ";
                    lbl_viewname.Text = "View and Search for Detailed View || ";

                    PopulateTypeDropdown();
                    BindGridView();

                }

            }
        }

        private void PopulateTypeDropdown()
        {
            DDL_MaterialType.Items.Add(new ListItem("Select", "0")); // Empty value for default selection

            // Add items to the DropDownList
            DDL_MaterialType.Items.Add(new ListItem("Consumables", "Consumables"));
            DDL_MaterialType.Items.Add(new ListItem("Non-Consumables", "Non-Consumables"));
        }

        protected void DDL_MaterialType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DDL_MaterialType.SelectedIndex != 0)
            {
                string selectedMaterialType = DDL_MaterialType.SelectedValue.ToString();
                FilterData();
            }
            else
            {
                string DDL_MaterialType_Error_script = @"<script type='text/javascript'>
                            new PNotify({
                                title: 'Error',
                                text: 'Invalid Selection!',
                                type: 'error',
                                styling: 'bootstrap3'
                            });
                        </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowTypeInvalidErrorNotification", DDL_MaterialType_Error_script, false);

            }
        }


        protected void ReportbtnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }

        protected void ReportbtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("Material_MasterView.aspx");
        }

        protected void ViewBtn_Click(object sender, EventArgs e)
        {
            // Get the ID from the CommandArgument of the button
            System.Web.UI.WebControls.Button btn = (System.Web.UI.WebControls.Button)sender;
            string id = btn.CommandArgument;

            // Redirect to the Process_FinalApproval.aspx page with the PcrNo in the query string
            Response.Redirect("Material_Master_DetailView.aspx?Id=" + id);
        }


        public class ReportInfo
        {
            public string Id { get; set; }
            public string MaterialNumber { get; set; }
            public string MaterialType { get; set; }
            public string ModelNumber { get; set; }
            public string MaterialBrand { get; set; }
            public string FriendlyName { get; set; }
        }

        private void BindGridView()
        {
            var dataSave = new List<ReportInfo>
            {
                 new ReportInfo {},
            };

            // Bind to GridView
            GridView1.DataSource = dataSave;
            GridView1.DataBind();

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string query = "SELECT * FROM MST_Material";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        System.Data.DataTable dt = new System.Data.DataTable();
                        sda.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
        }

        protected void FilterData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            string query = "SELECT * FROM MST_Material WHERE 1=1"; //  WHERE 1=1 (why becoz if one contition true it will show the data) is used for appending conditions dynamically in case want to add more filters in the future

            if (!string.IsNullOrEmpty(DDL_MaterialType.SelectedValue) && DDL_MaterialType.SelectedValue != "0")
            {
                query += " AND MaterialType = @MaterialType";
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    // Add parameter for MaterialType filter (which is a string)
                    if (!string.IsNullOrEmpty(DDL_MaterialType.SelectedValue) && DDL_MaterialType.SelectedValue != "0")
                    {
                        query += " AND MaterialType = @MaterialType";  // Append condition dynamically
                        cmd.Parameters.AddWithValue("@MaterialType", DDL_MaterialType.SelectedValue); // This is now a string
                    }

                    con.Open();

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        System.Data.DataTable dt = new System.Data.DataTable();
                        sda.Fill(dt);

                        // Bind the data to the GridView
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
        }


        protected void SearchButton_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

           // string query = "SELECT * FROM MST_Material WHERE Id = " + SearchBox.Text +" ";
            string query = "SELECT * FROM MST_Material WHERE ModelNumber = @ModelNumber";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ModelNumber", SearchBox.Text.Trim());

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }
                        else
                        {
                            // Handle the case where no data is returned
                            GridView1.DataSource = null;
                            GridView1.DataBind();
                        }
                    }
                }
            }
        }


        // Paging event
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGridView(); 
        }

    }
}