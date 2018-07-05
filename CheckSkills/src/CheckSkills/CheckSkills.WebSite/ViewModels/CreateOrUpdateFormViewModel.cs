using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace CheckSkills.WebSite.ViewModels
{
    public class CreateOrUpdateFormViewModel
    {
        public int? Id { get; set; }

        public string Content { get; set; }

        [Display(Name = "Categorie de question")]
        [Required(ErrorMessage = "categorie est obligatoire")]
        public int? CategoryId { get; set; }

        public int? DifficultyId { get; set; }


        [Display(Name = "Type de question")]
        [Required(ErrorMessage = "Le type de question est obligatoire")]
        public int? QuestionTYpeId { get; set; }

        public IEnumerable<SelectListItem> Questions { get; set; }
        public IEnumerable<SelectListItem> Categories { get; set; }
        public IEnumerable<SelectListItem> QuestionTypes { get; set; }
    }
}
