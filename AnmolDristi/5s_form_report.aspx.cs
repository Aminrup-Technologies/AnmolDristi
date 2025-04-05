using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AnmolDristi
{
    public partial class _5s_form_report : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Simulated data source (using a custom class instead of tuples)
                Dictionary<string, QuestionData> questionData = new Dictionary<string, QuestionData>
                {
                    { "p6", new QuestionData { IsCorrect = true, Remarks = "" } },
                    { "p7", new QuestionData { IsCorrect = false, Remarks = "Labels are missing on some equipment." } },
                    { "p8", new QuestionData { IsCorrect = true, Remarks = "" } },
                    { "p9", new QuestionData { IsCorrect = true, Remarks = "" } },
                    { "p10", new QuestionData { IsCorrect = true, Remarks = "" } },
                    { "p11", new QuestionData { IsCorrect = false, Remarks = "Wires are not neatly arranged." } }
                };

                LoadQuestionStatus(questionData);
            }
        }

        private void LoadQuestionStatus(Dictionary<string, QuestionData> questionData)
        {
            foreach (KeyValuePair<string, QuestionData> item in questionData)
            {
                var tickControl = FindControl(item.Key + "_tick") as System.Web.UI.HtmlControls.HtmlGenericControl;
                var crossControl = FindControl(item.Key + "_cross") as System.Web.UI.HtmlControls.HtmlGenericControl;
                var remarksControl = FindControl("lbl_" + item.Key + "_rmrks") as Label;

                if (item.Value.IsCorrect)
                {
                    if (tickControl != null) tickControl.Visible = true;
                    if (crossControl != null) crossControl.Visible = false;
                    if (remarksControl != null) remarksControl.Text = "";
                }
                else
                {
                    if (tickControl != null) tickControl.Visible = false;
                    if (crossControl != null) crossControl.Visible = true;
                    if (remarksControl != null) remarksControl.Text = item.Value.Remarks;
                }
            }
        }
    }

    public class QuestionData
    {
        public bool IsCorrect { get; set; }
        public string Remarks { get; set; }
    }
}