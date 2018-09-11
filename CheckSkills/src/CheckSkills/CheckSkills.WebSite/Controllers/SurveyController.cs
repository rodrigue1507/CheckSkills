using System;
using System.Collections.Generic;
using System.Linq;
using CheckSkills.DAL;
using CheckSkills.Domain;
using CheckSkills.Domain.Entities;
using CheckSkills.WebSite.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Rotativa.AspNetCore;

namespace CheckSkills.WebSite.Controllers
{
    public class SurveyController : Controller
    {
        private ISurveyDao _surveyDao;
        private IQuestionDao _questionDao;
        private IQuestionCategoryDao _categoryDao;
        private IQuestionDifficultyDao _difficultyDao;
        private IQuestionTypeDao _questionTypeDao;
        private IAnswerDao _answerDao;
     

        private const int CATEGORY_ID = 0;
        private const int TYPE_ID = 0;
        private const int DIFFICULTY_ID = 0;

        public SurveyController()
        {
            _surveyDao = new SurveyDao();
            _questionDao = new QuestionDao();
            _categoryDao = new QuestionCategoryDao();
            _difficultyDao = new QuestionDifficultyDao();
            _questionTypeDao = new QuestionTypeDao();
            _answerDao = new AnswerDao();
          
        }


   
        
        // actions permettant de creer le formulaire.
        [HttpGet]
        public IActionResult Create()
        {
            var model = BuildSurveyViewModel();
            return View(model);
        }
        [HttpPost]
        public IActionResult Create(IEnumerable<SurveySelectedQuestionViewModel> surveySelectedQuestions)
        {
            var selectedQuestionIds = surveySelectedQuestions.Where(q => q.IsChecked).Select(ssq => ssq.Id);
            var model = GetConfirmationSurveyModel(selectedQuestionIds);
            model.OriginalSurveySelectedQuestions = selectedQuestionIds;
            return View("List", model);
        }



        //action permettant d'imprimer le formulaire generer.
        [HttpGet]
        public IActionResult PrintSurvey(IEnumerable<int>surveySelectedQuestions)
        {
            var model = GetConfirmationSurveyModel(surveySelectedQuestions);
            return new ViewAsPdf("PrintSurvey", model);
        }
        [HttpPost]
        public IActionResult SaveSurvey(CreateConfirmationSurveyViewModel surveyModel)
        {
            var survey = new Survey
            {
                Name = surveyModel.Name
            };

            try
            {
                _surveyDao.CreateSurvey(surveyModel.Name, surveyModel.OriginalSurveySelectedQuestions.ToList());
            }
            catch(Exception exception)
            {

            }

            var model = GetConfirmationSurveyModel(surveyModel.OriginalSurveySelectedQuestions);
            model.Name = surveyModel.Name;

            return View("SaveSurvey", model);
        }

      

        //action permettant d'afficher la liste les formulaire creer
        public IActionResult ShowSurveyByName(string name)
        {
            var model = GetConfirmationSurveyModelByName(name);
            return View("ShowSaveSurvey", model);
        }

        private CreateConfirmationSurveyViewModel GetConfirmationSurveyModelByName(string name)
        {
            return new CreateConfirmationSurveyViewModel();
        }



        private CreateConfirmationSurveyViewModel GetConfirmationSurveyModel(IEnumerable<int> selectedQuestionIds)
        {
            //récupérer la liste des questions selectionnés
            var questions = _questionDao.GetAll().Where(q => selectedQuestionIds.Contains(q.Id));
            var questionListViewModels = new List<QuestionViewModel>();
            var answers = _answerDao.GetAll();

            if (questions != null && questions.Any())
            {
                foreach (var question in questions)
                {
                    questionListViewModels.Add(
                        new QuestionViewModel()
                        {
                            Id = question.Id,
                            CategoryName = question.Category.Name,
                            TypeName = question.Type.Name,
                            DifficultyLevel = question.Difficulty.DifficultyLevel,
                            Content = question.Content,
                            QuestionAnswerList = answers.Where(r => r.QuestionId == question.Id).Select(r => new CreateOrUpdateQuestionAnswerViewModel
                            {
                                Id = r.Id,
                                QuestionId = r.QuestionId,
                                QuestionContent = question.Content,
                                AnswerContent = r.Content
                            }).ToList()
                        });
                }
            }

            // create confirmation survey viewModel
            return new CreateConfirmationSurveyViewModel
            {
                Id = null,
                Name = null,
                SurveySelectedQuestions = questionListViewModels
            };
        }



        //methode permettant de filtrer les questions en fonction des preferences (SurveyFilterInfo)
        [HttpPost]
        public IActionResult FilterQuestions(SurveyFilterInfoViewModel surveyFilterInfo)
        {
            var model = BuildSurveyViewModel(surveyFilterInfo);
 
            return View("Create", model);
            
        }



        //cette methode prend en parametre le filtre de l'utilisateur et retourne le model associé
        private CreateSurveyViewModel BuildSurveyViewModel(SurveyFilterInfoViewModel surveyFilterInfo = null)
        {
            var model = surveyFilterInfo == null ? new CreateSurveyViewModel()
            {
                CategoryId = CATEGORY_ID,
                DifficultyId = DIFFICULTY_ID,
                TypeId = TYPE_ID
            } :
            new CreateSurveyViewModel()
            {
                CategoryId = surveyFilterInfo.CategoryId,
                DifficultyId = surveyFilterInfo.DifficultyId,
                TypeId = surveyFilterInfo.TypeId
            };

            //dans le selectlistItem nous avons  
            model.Categories = _categoryDao.GetAllQuestionCategory().Select(o => new Microsoft.AspNetCore.Mvc.Rendering.SelectListItem
            {
                Text = o.Name,
                Value = o.Id.ToString(),
                // Put default categoryId qs const
                Selected = o.Id == model.CategoryId
            });
            model.Difficulties = _difficultyDao.GetAll().Select(o => new Microsoft.AspNetCore.Mvc.Rendering.SelectListItem
            {
                Text = o.DifficultyLevel,
                Value = o.Id.ToString(),
                Selected = o.Id == model.DifficultyId
            });
            model.QuestionTypes = _questionTypeDao.GetAll().Select(o => new Microsoft.AspNetCore.Mvc.Rendering.SelectListItem
            {
                Text = o.Name,
                Value = o.Id.ToString(),
                Selected = o.Id == model.TypeId
            });

            //on recupère les questions depuis la base de donnée en fonction des différents paramètres
            var questions = _questionDao.GetAll();
            var questionListViewModels = new List<QuestionViewModel>();
            if (questions != null && questions.Any())
            {
                foreach (var question in questions.Where(q => surveyFilterInfo == null || (
                                                                  (surveyFilterInfo.CategoryId == 0 || q.Category.Id == surveyFilterInfo.CategoryId)
                                                               && (surveyFilterInfo.TypeId == 0 || q.Type.Id == surveyFilterInfo.TypeId)
                                                               && (surveyFilterInfo.DifficultyId == 0 || q.Difficulty.Id == surveyFilterInfo.DifficultyId)
                                                               )))
                {
                    questionListViewModels.Add(
                        new QuestionViewModel()
                        {
                            Id = question.Id,
                            CategoryName = question.Category.Name,
                            TypeName = question.Type.Name,
                            DifficultyLevel = question.Difficulty.DifficultyLevel,
                            Content = question.Content,
                            IsChecked = surveyFilterInfo != null && surveyFilterInfo.SurveySelectedQuestions != null && surveyFilterInfo.SurveySelectedQuestions.Any()
                            && surveyFilterInfo.SurveySelectedQuestions.Any(sq => sq.Id == question.Id && sq.IsChecked)
                        });
                }
            }

            model.SurveySelectedQuestions = questionListViewModels;

            return model;
        }

        // methode permettant de recupérer les données formulaires depuis la base.

    }
}













