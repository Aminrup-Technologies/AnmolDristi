using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace AnmolDristi
{
    public partial class Line_Walk_Status : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
//        protected void BtnSubmit_Click(object sender, EventArgs e)
//        {

//            try
//            {
//                using (SqlConnection connection = new SqlConnection(connectionString))
//                {
//                    connection.Open();
//                    using (SqlCommand command = new SqlCommand("SP_Workers_PPE_Checklist", connection))
//                    {
//                        command.CommandType = CommandType.StoredProcedure;
//        //Execute the query
//        command.ExecuteNonQuery();



//                    }
//    connection.Close();
//                }
////Show SweetAlert2 after successful submission
//string script = "Swal.fire({ title: 'Success!', text: 'Data submitted successfully.', icon: 'success' });";
//        ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitSuccess", script, true);

//        }

//          catch (Exception ex)
//            {
//                lbl_msg.Text = "Error: " + ex.Message;
//                lbl_msg.ForeColor = System.Drawing.Color.Red;

//                // ❌ Show SweetAlert2 on error
//                string errorScript = $"Swal.fire({{ title: 'Error!', text: '{ex.Message}', icon: 'error' }});";
//        ScriptManager.RegisterStartupScript(this, this.GetType(), "SubmitError", errorScript, true);
//        }
//        }
        protected void BtnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("Line_Walk_Status.aspx");
        }
    }
}

    

