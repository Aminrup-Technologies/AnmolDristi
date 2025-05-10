//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Data;
//using System.Data.SqlClient;
//using System.Configuration;
//namespace AnmolDristi
//{
//    public partial class Grinding_Machine_View : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                LoadGrindingMachineIncidentDetails();
//            }
//        }


//        private void LoadGrindingMachineIncidentDetails()
//        {
//            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

//            using (SqlConnection conn = new SqlConnection(connectionString))
//            {
//                conn.Open();
//                string query = @"
//        SELECT 
//            gh.HeaderID, gh.Site, gh.DateOfInspection, gh.InspectedBy, gh.SerialNo, 
//            gh.IdentificationNumber, gh.Location,gh.Final_Remarks,
//            gc.Question AS ChecklistQuestion, gc.IsYes, gc.Remarks, gc.PhotoPath
//        FROM GrindingMachine_Header gh
//        LEFT JOIN GrindingMachine_Checklist gc ON gh.HeaderID = gc.HeaderID
//        ORDER BY gh.HeaderID DESC";

//                using (SqlCommand cmd = new SqlCommand(query, conn))
//                {
//                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
//                    {
//                        DataTable dt = new DataTable();
//                        da.Fill(dt);

//                        // Bind data to GridView
//                        GvGrindingMachineChecklist.DataSource = dt;
//                        GvGrindingMachineChecklist.DataBind();
//                    }
//                }
//            }
//        }


//        protected void GvGrindingMachineChecklist_RowEditing(object sender, GridViewEditEventArgs e)
//        {
//            GvGrindingMachineChecklist.EditIndex = e.NewEditIndex;
//            LoadGrindingMachineIncidentDetails();
//        }

//        protected void GvGrindingMachineChecklist_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
//        {
//            GvGrindingMachineChecklist.EditIndex = -1;
//            LoadGrindingMachineIncidentDetails();
//        }

//        protected void GvGrindingMachineChecklist_RowUpdating(object sender, GridViewUpdateEventArgs e)
//        {
//            int id = Convert.ToInt32(GvGrindingMachineChecklist.DataKeys[e.RowIndex].Value);
//            GridViewRow row = GvGrindingMachineChecklist.Rows[e.RowIndex];

//            string site = ((TextBox)row.Cells[0].Controls[0]).Text;
//            DateTime dateOfInspection = DateTime.ParseExact(
//    ((TextBox)row.Cells[1].Controls[0]).Text,
//    "yyyy-MM-dd",   // or change to match your textbox format
//    System.Globalization.CultureInfo.InvariantCulture);

//          //  string dateOfInspection = ((TextBox)row.Cells[1].Controls[0]).Text;
//            string inspectedBy = ((TextBox)row.Cells[2].Controls[0]).Text;
//            string serialNo = ((TextBox)row.Cells[3].Controls[0]).Text;
//            string identificationNo = ((TextBox)row.Cells[4].Controls[0]).Text;
//            string location = ((TextBox)row.Cells[5].Controls[0]).Text;
//            //string checklistQuestion = ((TextBox)row.Cells[6].Controls[0]).Text;
//            //string isYes = ((TextBox)row.Cells[7].Controls[0]).Text;
//            //string remarks = ((TextBox)row.Cells[8].Controls[0]).Text;
//            //string photoPath = ((TextBox)row.Cells[9].Controls[0]).Text;

//            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

//            using (SqlConnection conn = new SqlConnection(connectionString))
//            {
//                conn.Open();




//                string updateQuery = @"
//UPDATE GrindingMachine_Header 
//SET Site = @Site, DateOfInspection = @DateOfInspection, InspectedBy = @InspectedBy, 
//    SerialNo = @SerialNo, IdentificationNumber = @IdentificationNumber, Location = @Location 
//WHERE HeaderID = @HeaderID";

//                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
//                {
//                    cmd.Parameters.AddWithValue("@HeaderID", id);
//                    cmd.Parameters.AddWithValue("@Site", site);
//                    cmd.Parameters.AddWithValue("@DateOfInspection", dateOfInspection);
//                    cmd.Parameters.AddWithValue("@InspectedBy", inspectedBy);
//                    cmd.Parameters.AddWithValue("@SerialNo", serialNo);
//                    cmd.Parameters.AddWithValue("@IdentificationNumber", identificationNo);
//                    cmd.Parameters.AddWithValue("@Location", location);
//                    //    cmd.Parameters.AddWithValue("@ChecklistQuestion", checklistQuestion);
//                    //  cmd.Parameters.AddWithValue("@IsYes", isYes);
//                    //   cmd.Parameters.AddWithValue("@Remarks", remarks);
//                    //   cmd.Parameters.AddWithValue("@PhotoPath", photoPath);

//                    cmd.ExecuteNonQuery();
//                }
//            }

//            GvGrindingMachineChecklist.EditIndex = -1;
//            LoadGrindingMachineIncidentDetails();
//        }
//        protected void GvGrindingMachineChecklist_RowDeleting(object sender, GridViewDeleteEventArgs e)
//        {
//            int id = Convert.ToInt32(GvGrindingMachineChecklist.DataKeys[e.RowIndex].Value);
//            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

//            using (SqlConnection conn = new SqlConnection(connectionString))
//            {
//                conn.Open();
//                using (SqlCommand cmd = new SqlCommand(@"
//            DELETE FROM GrindingMachine_Checklist WHERE HeaderID = @HeaderID;
//            DELETE FROM GrindingMachine_Header WHERE HeaderID = @HeaderID;", conn))
//                {
//                    cmd.Parameters.AddWithValue("@HeaderID", id);
//                    cmd.ExecuteNonQuery();
//                }
//            }

//            LoadGrindingMachineIncidentDetails();
//        }
//    }
//}


using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.SqlTypes;

namespace AnmolDristi
{
    public partial class Grinding_Machine_View : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadGrindingMachineIncidentDetails();
            }
        }

        private void LoadGrindingMachineIncidentDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                SELECT 
                    gh.HeaderID, gh.Site, gh.DateOfInspection, gh.InspectedBy, gh.SerialNo, 
                    gh.IdentificationNumber, gh.Location, gh.Final_Remarks,
                    gc.Question AS ChecklistQuestion, gc.IsYes, gc.Remarks, gc.PhotoPath, gc.EntryDate
                FROM GrindingMachine_Header gh
                LEFT JOIN GrindingMachine_Checklist gc ON gh.HeaderID = gc.HeaderID
                ORDER BY gh.HeaderID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GvGrindingMachineChecklist.DataSource = dt;
                        GvGrindingMachineChecklist.DataBind();
                    }
                }
            }
        }

        protected void GvGrindingMachineChecklist_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GvGrindingMachineChecklist.EditIndex = e.NewEditIndex;
            LoadGrindingMachineIncidentDetails();
        }

        protected void GvGrindingMachineChecklist_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GvGrindingMachineChecklist.EditIndex = -1;
            LoadGrindingMachineIncidentDetails();
        }

        protected void GvGrindingMachineChecklist_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(GvGrindingMachineChecklist.DataKeys[e.RowIndex].Value);
            GridViewRow row = GvGrindingMachineChecklist.Rows[e.RowIndex];

            string site = ((TextBox)row.Cells[0].Controls[0]).Text;

            // Safely parse the DateOfInspection
            DateTime dateOfInspection;
            bool isValidDate = DateTime.TryParseExact(
                ((TextBox)row.Cells[1].Controls[0]).Text,
                "yyyy-MM-dd",
                System.Globalization.CultureInfo.InvariantCulture,
                System.Globalization.DateTimeStyles.None,
                out dateOfInspection);

            if (!isValidDate || dateOfInspection < (DateTime)SqlDateTime.MinValue.Value)
            {
                // Set to current date or SQL valid minimum date if parsing fails
                dateOfInspection = DateTime.Now;
            }

            string inspectedBy = ((TextBox)row.Cells[2].Controls[0]).Text;
            string serialNo = ((TextBox)row.Cells[3].Controls[0]).Text;
            string identificationNo = ((TextBox)row.Cells[4].Controls[0]).Text;
            string location = ((TextBox)row.Cells[5].Controls[0]).Text;

            // Safely parse the EntryDate
            DateTime entryDate;
            if (!DateTime.TryParse(((TextBox)row.Cells[6].Controls[0]).Text, out entryDate) ||
                entryDate < (DateTime)SqlDateTime.MinValue.Value)
            {
                // If invalid, use current date as a safe default
                entryDate = DateTime.Now;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string updateQuery = @"
        UPDATE GrindingMachine_Header 
        SET Site = @Site, DateOfInspection = @DateOfInspection, InspectedBy = @InspectedBy, 
            SerialNo = @SerialNo, IdentificationNumber = @IdentificationNumber, Location = @Location
        WHERE HeaderID = @HeaderID";

                using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", id);
                    cmd.Parameters.AddWithValue("@Site", site);
                    cmd.Parameters.AddWithValue("@DateOfInspection", dateOfInspection);
                    cmd.Parameters.AddWithValue("@InspectedBy", inspectedBy);
                    cmd.Parameters.AddWithValue("@SerialNo", serialNo);
                    cmd.Parameters.AddWithValue("@IdentificationNumber", identificationNo);
                    cmd.Parameters.AddWithValue("@Location", location);
                    cmd.Parameters.AddWithValue("@EntryDate", entryDate);

                    cmd.ExecuteNonQuery();
                }
            }

            GvGrindingMachineChecklist.EditIndex = -1;
            LoadGrindingMachineIncidentDetails();
        }


        protected void GvGrindingMachineChecklist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GvGrindingMachineChecklist.DataKeys[e.RowIndex].Value);
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(@"
                    DELETE FROM GrindingMachine_Checklist WHERE HeaderID = @HeaderID;
                    DELETE FROM GrindingMachine_Header WHERE HeaderID = @HeaderID;", conn))
                {
                    cmd.Parameters.AddWithValue("@HeaderID", id);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadGrindingMachineIncidentDetails();
        }
    }
}






