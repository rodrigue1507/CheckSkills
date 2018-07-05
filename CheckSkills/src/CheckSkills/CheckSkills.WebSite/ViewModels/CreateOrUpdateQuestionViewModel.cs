using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace CheckSkills.WebSite.ViewModels
{
    //methode contenant tous les éléments pour la creation de formulaire
    public class CreateOrUpdateQuestionViewModel
    {
        public int? Id  { get; set; }

        [Required(ErrorMessage ="Le contenu est obligatoire")]
        [Display(Name ="Contenu")]
        public string Content { get; set; }

        [Display(Name = "Categorie")]
        public int CategoryId { get; set; }

        [Display(Name = "Difficulté")]
        public int DifficultyId { get; set; }

        [Display(Name ="Type")]
        public int QuestionTypeId { get; set;  }

        public IEnumerable<SelectListItem> Categories { get; set; }
        public IEnumerable<SelectListItem> Difficulties { get; set; }
        public IEnumerable<SelectListItem> QuestionTypes { get; set; }

    }
}
