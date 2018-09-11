using CheckSkills.DAL;
using CheckSkills.Domain;
using CheckSkills.Domain.Entities;
using CheckSkills.WebSite.ViewModels;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;

namespace CheckSkills.WebSite.Controllers
{

    public class ExploreSurveyController : Controller
    {
        private ISurvey_QuestionDao _surveyQuestionDao;

        public ExploreSurveyController()
        {
            _surveyQuestionDao = new Survey_QuestionDao();
        }

        public IActionResult List()
        {
            return View();
        }
    }
  
}