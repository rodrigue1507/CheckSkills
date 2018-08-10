using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace CheckSkills.WebSite.ViewModels.Response
{
    public class QuestionResponseViewModel
    {
        public int? ResponseId { get; set; }

        public int QuestionId { get; set; }

        [Display(Name="Question")]
        public string QuestionContent { get; set; }

        [Display(Name = "Réponse")]

        public string ResponseContent { get; set; }
    }
}
