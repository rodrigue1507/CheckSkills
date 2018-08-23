using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CheckSkills.WebSite.ViewModels
{
    public class CreateSurveyViewModel
    {
        public int? Id { get; set; }

       
        [Display(Name = "Donner un nom au Formulaire")]
        public string Name { get; set; }
        public string SurveyEvaluation { get; set; }

        public int CategoryId { get; set; }
        public int DifficultyId { get; set; }
        public int TypeId { get; set; }

        public IEnumerable<QuestionViewModel> SurveySelectedQuestions { get; set; }

        public IEnumerable<SelectListItem> Categories { get; set; }
        public IEnumerable<SelectListItem> Difficulties { get; set; }
        public IEnumerable<SelectListItem> QuestionTypes { get; set; }
    }
}
