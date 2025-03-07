

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class SN_CRUD_Oprtn : System.Web.UI.Page
    {
        // Correct way to retrieve the connection string
       string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRecord();
               
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand comm = new SqlCommand("INSERT INTO SN_CRUD VALUES ('" +int.Parse(TextBox1.Text)+ "', '" +TextBox2.Text+ "', '" +DropDownList1.SelectedValue+ "', '" +int.Parse(TextBox3.Text)+ "', '" +TextBox4.Text+ "')", con);

                con.Open();
                comm.ExecuteNonQuery();
                con.Close();
            }

            // Corrected JavaScript alert
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Successfully Inserted');", true);

            LoadRecord();

//for reset fields:
            //TextBox1.Text = string.Empty; TextBox2.Text = string.Empty; DropDownList1.SelectedValue = string.Empty; TextBox3.Text = string.Empty; TextBox4.Text = string.Empty;
            //alternate
            Response.Redirect("SN_CRUD_Oprtn.aspx");

        }
        void LoadRecord()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand comm = new SqlCommand("select * from SN_CRUD", con);
                SqlDataAdapter d = new SqlDataAdapter(comm);
                DataTable dt = new DataTable();
                d.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                //SqlCommand comm = new SqlCommand("UPDATE SN_CRUD Set StudentName = '" + TextBox2.Text + "', Address = '" + DropDownList1.SelectedValue + "', Age = '" + int.Parse(TextBox3.Text) + "', Contact = '" + TextBox4.Text + "' where StudentID = '" + int.Parse(TextBox1.Text) + "'", con); 
                SqlCommand comm = new SqlCommand("UPDATE SN_CRUD Set StudentName = '" + TextBox2.Text + "', Address = '" + DropDownList1.SelectedValue + "', Age = " + int.Parse(TextBox3.Text) + ", Contact = '" + TextBox4.Text + "' where StudentID = " + int.Parse(TextBox1.Text), con);

                con.Open();
                comm.ExecuteNonQuery();
                con.Close();
            }

            // Corrected JavaScript alert
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Successfully Updated');", true);
            LoadRecord();
            Response.Redirect("SN_CRUD_Oprtn.aspx");


        }
        protected void Button3_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand comm = new SqlCommand("DELETE FROM SN_CRUD where StudentID = '" + int.Parse(TextBox1.Text) + "'", con);

                con.Open();
                comm.ExecuteNonQuery();
                con.Close();
            }

            // Corrected JavaScript alert
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('Successfully Deleted');", true);
            LoadRecord();
            Response.Redirect("SN_CRUD_Oprtn.aspx");


        }
        protected void Button4_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand comm = new SqlCommand("select * from SN_CRUD where StudentID = '" + int.Parse(TextBox1.Text) + "'", con);
                SqlDataAdapter d = new SqlDataAdapter(comm);
                DataTable dt = new DataTable();
                d.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            Response.Redirect("SN_CRUD_Oprtn.aspx");


        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand comm = new SqlCommand("select * from SN_CRUD where StudentID = '" + int.Parse(TextBox1.Text) + "'", con);
                SqlDataReader r = comm.ExecuteReader();
                while(r.Read())
                {
                    TextBox2.Text = r.GetValue(1).ToString();
                    DropDownList1.SelectedValue = r.GetValue(2).ToString();
                    TextBox3.Text = r.GetValue(3).ToString();
                    TextBox4.Text = r.GetValue(4).ToString();
                }
               
            }
            Response.Redirect("SN_CRUD_Oprtn.aspx");


        }
    }
}
