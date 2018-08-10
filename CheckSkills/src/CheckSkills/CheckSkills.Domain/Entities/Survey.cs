using System;
using System.Collections.Generic;
using System.Text;

namespace CheckSkills.Domain
{
    public class Survey
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Content { get; set; }
        public string SurveyEvaluation  { get; set; }
    }
}
