using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class Safety_audit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //pnlRadioButtons.Controls.Clear();
                //if(ViewState["SelectedDDLValue"]!= null)
                //{
                //    ddlDescriptionFields.SelectedValue = ViewState["SelectedDDLValue"].ToString();
                //}
                LoadSafetyAuditDetails();// Clear existing controls
            }
        }

        protected void DdlGoodCitizens_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl != null)
            {
                string selectedValue = ddl.SelectedValue;
                Console.WriteLine(selectedValue); // Example of using the variable
            }


        }

        protected void ShowRadioButtons(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl != null)
            {
                // Use 'selectedValue' only if needed
                string selectedValue = ddl.SelectedValue;

                // Perform any action based on the selected value
                if (!string.IsNullOrEmpty(selectedValue))
                {
                    // Example: Show or enable certain radio buttons based on selection
                    Console.WriteLine(selectedValue);  // Remove if unnecessary
                }
            }
        }


        protected void DdlUnsafeAct_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl != null)
            {
                string selectedValue = ddl.SelectedValue;

                if (!string.IsNullOrEmpty(selectedValue))
                {
                    Console.WriteLine(selectedValue);
                }
            }
        }


        protected void DdlDescriptionFields_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            //pnlRadioButtons.Controls.Clear(); // Clear previous radio buttons

            string selectedValue = ddlDescriptionFields.SelectedValue;
            ViewState["SelectedDDLValue"] = selectedValue;


            if (selectedValue == "GoodCitizens")
            {
                pnlRadioButtons.Controls.Add(new Literal { Text = "<b>Good Citizens:</b><br/>" });
                pnlRadioButtons.Controls.Add(CreateRadioButton("GoodCitizens", "Yes", "Yes"));
                pnlRadioButtons.Controls.Add(new Literal { Text = "&nbsp;&nbsp;" }); // Adding space
                pnlRadioButtons.Controls.Add(CreateRadioButton("GoodCitizens", "No", "No"));
            }
            else if (selectedValue == "NoOfViolations" || selectedValue == "Severity" || selectedValue == "ViolationSeverity" || selectedValue == "FourAndFive")
            {
                pnlRadioButtons.Controls.Add(new Literal { Text = "<b>Choose a Value:</b><br/>" });
                for (int i = 0; i <= 6; i++)
                {
                    pnlRadioButtons.Controls.Add(CreateRadioButton(selectedValue, i.ToString(), i.ToString()));
                    pnlRadioButtons.Controls.Add(new Literal { Text = "&nbsp;&nbsp;" }); // Add space between buttons
                }
            }
            else if (selectedValue == "UnsafeAct")
            {
                pnlRadioButtons.Controls.Add(new Literal { Text = "<b>Unsafe Act & Condition:</b><br/>" });
                pnlRadioButtons.Controls.Add(CreateRadioButton("UnsafeAct", "Good", "Good"));
                pnlRadioButtons.Controls.Add(new Literal { Text = "&nbsp;&nbsp;" }); // Add space
                pnlRadioButtons.Controls.Add(CreateRadioButton("UnsafeAct", "Bad", "Bad"));
            }
        }


        private RadioButton CreateRadioButton(string groupName, string value, string text)
        {
            RadioButton rb = new RadioButton
            {
                GroupName = groupName,
                Text = text,
                ID = "rb_" + groupName + "_" + value
            };
            return rb;
        }





        private void LoadSafetyAuditDetails()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = @"
            SELECT 
                sa.AuditID, sa.Department, sa.Section, sa.Date, sa.Time, 
                sa.ContractorVendorCode, sa.TotalContractorPeople, 
                sev.SeverityLevel, sev.TeamMembers,
                sdesc.Description, sdesc.SelectField, sdesc.Options
            FROM SafetyAuditRecords sa
            LEFT JOIN SafetyAuditSeverity sev ON sa.AuditID = sev.AuditID
            LEFT JOIN SafetyAuditDescription sdesc ON sa.AuditID = sdesc.AuditID
            ORDER BY sa.Date DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                        }
                    }
                }
                catch (SqlException ex)
                {
                    Console.WriteLine("SQL Error: " + ex.Message);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error: " + ex.Message);
                }
            }
        }





        protected void SubmitSafetyAudit_Click(object sender, EventArgs e)
        {
            try
            {
                SaveSafetyAuditData();
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Safety Audit Report saved successfully!";
                btnSubmit.Enabled = false;
                btnSubmit.Text = "Saved";
                btnSubmit.CssClass = "btn btn-success";
                LoadSafetyAuditDetails();
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        private void SaveSafetyAuditData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;
            int auditID;

            // Fetching values from ASPX page controls
            string department = txtDepartment.Text;
            string section = txtSection.Text;
            string date = txtDate.Text;
            string time = txtTime.Text;
            string vendorCode = txtContractorVendorCode.Text;
            int totalPeople = Convert.ToInt32(txtTotalContractorPeople.Text);

            string severityLevel = ddlSeverityLevel.SelectedValue;
            string teamMembers = txtTeamMember1.Text;

            string description = txtDescription.Text;
            string selectField = ddlDescriptionFields.SelectedValue;
            string options = "";
            foreach (Control control in pnlRadioButtons.Controls)
            {
                RadioButton rb = control as RadioButton;
                if (rb != null && rb.Checked)
                {
                    options = rb.Text;
                }
            }

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();
                try
                {
                    // Call stored procedure for main table
                    using (SqlCommand cmd = new SqlCommand("[MahimaGupta_CSMS].usp_InsertSafetyAuditMain", conn, transaction))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Add only the parameters that exist in the stored procedure
                        cmd.Parameters.AddWithValue("@Department", department);
                        cmd.Parameters.AddWithValue("@Section", section);
                        cmd.Parameters.AddWithValue("@Date", date);
                        cmd.Parameters.AddWithValue("@Time", time);
                        cmd.Parameters.AddWithValue("@ContractorVendorCode", vendorCode); // Use the correct param name
                        cmd.Parameters.AddWithValue("@TotalContractorPeople", totalPeople);

                        // Add the output parameter to capture the generated AuditID
                        SqlParameter outputIdParam = new SqlParameter("@AuditID", SqlDbType.Int)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputIdParam);

                        cmd.ExecuteNonQuery();
                        auditID = (int)outputIdParam.Value; // Retrieve the output value
                    }

                    // Call stored procedure for severity table
                    using (SqlCommand cmd = new SqlCommand("[MahimaGupta_CSMS].usp_InsertSafetyAuditSeverity", conn, transaction))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@AuditID", auditID);
                        cmd.Parameters.AddWithValue("@SeverityLevel", severityLevel);
                        cmd.Parameters.AddWithValue("@TeamMembers", teamMembers);
                        cmd.ExecuteNonQuery();
                    }

                    // Call stored procedure for description table
                    //    using (SqlCommand cmd = new SqlCommand("[MahimaGupta_CSMS].usp_InsertSafetyAuditDescription", conn, transaction))
                    //    {
                    //        cmd.CommandType = CommandType.StoredProcedure;
                    //        cmd.Parameters.AddWithValue("@AuditID", auditID);
                    //        cmd.Parameters.AddWithValue("@Description", description);
                    //        cmd.Parameters.AddWithValue("@SelectField", selectField);
                    //        cmd.Parameters.AddWithValue("@Options", options);
                    //        cmd.ExecuteNonQuery();
                    //    }

                    //    transaction.Commit();
                    //}

                    using (SqlCommand cmd = new SqlCommand("MahimaGupta_CSMS.usp_InsertSafetyAuditDescription", conn, transaction))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.Add("@AuditID", SqlDbType.Int).Value = auditID;
                        cmd.Parameters.Add("@Description", SqlDbType.NVarChar, 1000).Value = description;
                        cmd.Parameters.Add("@SelectField", SqlDbType.NVarChar, 255).Value = selectField;
                        cmd.Parameters.Add("@Options", SqlDbType.NVarChar, 255).Value = string.IsNullOrEmpty(options) ? (object)DBNull.Value : options;

                        Console.WriteLine($"AuditID: {auditID}, Description: {description}, SelectField: {selectField}, Options: {options}");
                        cmd.ExecuteNonQuery();
                    }


                    transaction.Commit();
                }



                catch (Exception ex)
                {
                    transaction.Rollback();
                    throw new Exception("Transaction failed: " + ex.Message);
                }
            }
        }

        protected void BtnReset_Click(object sender, EventArgs e)
        {
            txtDepartment.Text = "";
            txtSection.Text = "";
            txtDate.Text = "";
            txtTime.Text = "";
            txtContractorVendorCode.Text = "";
            txtTotalContractorPeople.Text = "";
            txtTeamMember1.Text = "";
            ddlSeverityLevel.SelectedIndex = 0;
            txtDescription.Text = "";
            ddlDescriptionFields.SelectedIndex = 0;
            foreach (Control control in pnlRadioButtons.Controls)
            {
                RadioButton rb = control as RadioButton;
                if (rb != null)
                {
                    rb.Checked = false; // Uncheck each radio button
                }
            }

            lblMessage.Text = "Form reset successfully!";
            lblMessage.ForeColor = System.Drawing.Color.Blue;
        }
    }
}