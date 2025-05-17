using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace AnmolDristi
{
    public partial class Grinding_Report : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                BindGrindingMachineReport();
            }
        }

        private void BindGrindingMachineReport()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string query = @"
            SELECT
                gh.HeaderID,
                gh.Site,
                gh.DateOfInspection,
                gh.InspectedBy,
                gh.SerialNo,
                gh.IdentificationNumber,
                gh.Location,
                gh.Final_Remarks,
                MAX(CASE WHEN gc.Question = '1. Fore handle without damage' THEN gc.IsYes ELSE 0 END) AS ForeHandle,
                MAX(CASE WHEN gc.Question = '2. Wheel guard (covered 3/4th area)' THEN gc.IsYes ELSE 0 END) AS WheelGuard,
                MAX(CASE WHEN gc.Question = '3. Grinding wheel without any crack' THEN gc.IsYes ELSE 0 END) AS GrindingWheelCondition,
                MAX(CASE WHEN gc.Question = '4. Rear handles without damage' THEN gc.IsYes ELSE 0 END) AS RearHandles,
                MAX(CASE WHEN gc.Question = '5. Presence of cord strain reliever' THEN gc.IsYes ELSE 0 END) AS CordStrainReliever,
                MAX(CASE WHEN gc.Question = '6. Trigger switch in working condition' THEN gc.IsYes ELSE 0 END) AS TriggerSwitch,
                MAX(CASE WHEN gc.Question = '7. Presence of switch lock' THEN gc.IsYes ELSE 0 END) AS SwitchLock,
                MAX(CASE WHEN gc.Question = '8. Power cable without cut' THEN gc.IsYes ELSE 0 END) AS PowerCable
            FROM GrindingMachine_Header gh
            LEFT JOIN GrindingMachine_Checklist gc ON gh.HeaderID = gc.HeaderID
            GROUP BY
                gh.HeaderID,
                gh.Site,
                gh.DateOfInspection,
                gh.InspectedBy,
                gh.SerialNo,
                gh.IdentificationNumber,
                gh.Location,
                gh.Final_Remarks
            ORDER BY gh.DateOfInspection DESC;
        ";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvChecklistReport.DataSource = dt;
                        gvChecklistReport.DataBind();
                    }
                }
            }
        }
    }
}

