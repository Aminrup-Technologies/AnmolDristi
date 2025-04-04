using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace AnmolDristi
{
    public partial class form1 : System.Web.UI.Page
    {
        // Fetch connection string from Web.config
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData(); // Load data when page loads
            }
        }

        // Insert Operation
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Users (FirstName, LastName, City) VALUES (@FirstName, @LastName, @City)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FirstName", firstname.Text.Trim());
                    cmd.Parameters.AddWithValue("@LastName", lastname.Text.Trim());
                    cmd.Parameters.AddWithValue("@City", city.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            LoadData();
        }

        // Delete Operation
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Users WHERE FirstName = @FirstName";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FirstName", firstname.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            LoadData();
        }

        // Update Operation
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE Users SET LastName = @LastName, City = @City WHERE FirstName = @FirstName";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FirstName", firstname.Text.Trim());
                    cmd.Parameters.AddWithValue("@LastName", lastname.Text.Trim());
                    cmd.Parameters.AddWithValue("@City", city.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            LoadData();
        }

        // View Data in GridView
        protected void btnView_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        private void LoadData()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT FirstName, LastName, City FROM Users";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gridview1.DataSource = dt;
                        gridview1.DataBind();
                    }
                }
            }
        }
    }
}

