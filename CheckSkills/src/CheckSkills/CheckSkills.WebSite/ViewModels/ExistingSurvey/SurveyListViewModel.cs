using CheckSkills.Domain;
using CheckSkills.Domain.Entities;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CheckSkills.WebSite.ViewModels
{
    public class SurveyListViewModel
    {
        public IEnumerable<SurveyViewModel> SurveyQuestionList { get; set; }
    }
}
