using CheckSkills.Domain;
using CheckSkills.Domain.Entities;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CheckSkills.WebSite.ViewModels
{
    public class SurveyViewModel
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public IEnumerable<Survey_Question> SurveyQuestion { get; set; }

    }
}
