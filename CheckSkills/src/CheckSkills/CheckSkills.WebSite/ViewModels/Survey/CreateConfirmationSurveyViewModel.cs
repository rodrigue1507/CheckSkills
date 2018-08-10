using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CheckSkills.WebSite.ViewModels
{
    public class CreateConfirmationSurveyViewModel
    {
        public int? Id { get; set; }

        [Display(Name="Le nom du formulaire")]
        public string Name { get; set; }
        public IEnumerable<QuestionViewModel> SurveySelectedQuestions { get; set; }

    }
}
