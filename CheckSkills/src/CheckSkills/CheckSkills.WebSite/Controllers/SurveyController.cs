using System.Collections.Generic;
using System.Linq;
using CheckSkills.DAL;
using CheckSkills.Domain;
using CheckSkills.Domain.Entities;
using CheckSkills.WebSite.ViewModels;
using Microsoft.AspNetCore.Mvc;

namespace CheckSkills.WebSite.Controllers
{
    public class SurveyController : Controller
    {
        private ISurveyDao _surveyDao;
        private IQuestionDao _questionDao;
        private IQuestionCategoryDao _categoryDao;
        private IQuestionDifficultyDao _difficultyDao;
        private IQuestionTypeDao _questionTypeDao;
        private IResponseDao _responseDao;
        private const int CATEGORY_ID = 1;
        private const int TYPE_ID = 1;
        private const int DIFFICULTY_ID = 1;

        public SurveyController()
        {
            _surveyDao = new SurveyDao();
            _questionDao = new QuestionDao();
            _categoryDao = new QuestionCategoryDao();
            _difficultyDao = new QuestionDifficultyDao();
            _questionTypeDao = new QuestionTypeDao();
            _responseDao = new ResponseDao();
        }


        [HttpGet]
        public IActionResult QuestionList()
        {
            var questions = _questionDao.GetAll();

            // Convertir en view models, 
            // en recuperant seulement les données dont la vue a besoin
            var QuestionListViewModels = new List<QuestionViewModel>();
            if (questions != null && questions.Any())
            {
                foreach (var question in questions)
                {
                    QuestionListViewModels.Add(
                        new QuestionViewModel()
                        {
                            Id = question.Id,
                            CategoryName = question.Category.Name,
                            TypeName = question.Type.Name,
                            DifficultyLevel = question.Difficulty.DifficultyLevel,
                            Content = question.Content,
                        });
                }
            }
            return View(QuestionListViewModels); // return des objets questions
        }


        [HttpGet]
        public IActionResult Create()
        {
            var model = BuildSurveyViewModel();

            return View(model);
        }


        [HttpPost]
        public IActionResult Create(IEnumerable<SurveySelectedQuestionViewModel> surveySelectedQuestions)
        {

            // la liste des id questions selectionnées
            var selectedQuestionIds = surveySelectedQuestions.Where(s => s.IsChecked).Select(ssq => ssq.Id);
            //récupérer la liste des questions selectionnés
            var questions = _questionDao.GetAll().Where(q => selectedQuestionIds.Contains(q.Id));
            var questionListViewModels = new List<QuestionViewModel>();
            var responses = _responseDao.GetAll();

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
                            QuestionResponseList = responses.Where(r=> r.QuestionId == question.Id).Select(r=> new CreateOrUpdateQuestionResponseViewModel
                            {
                                Id = r.Id,
                                QuestionId = r.QuestionId,
                                QuestionContent = question.Content,
                                ResponseContent = r.Content
                            }).ToList()

                        });
                }
            }

            // create confirmation survey viewModel
            var model = new CreateConfirmationSurveyViewModel
            {
                Id = null,
                Name ="Formulaire XXX" ,
                SurveySelectedQuestions = questionListViewModels
            };

            return View("List", model);
        }


        //methode permettant de filtrer les questions en fonction des preferences (SurveyFilterInfo)
        [HttpPost]
        public IActionResult FilterQuestions(SurveyFilterInfoViewModel surveyFilterInfo)
        {
            var model = BuildSurveyViewModel(surveyFilterInfo);

            return View("Create", model);
            // return new RazorPDF.PdfResult(model, "Create");
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
    }
}












//public IActionResult Category()
//{
//    var categories = _surveyDao.GetAllQuestionCategory();
//    var Types = _surveyDao.GetAllQuestionType();

//    var CategoriesListViewModels = new List<CreateSurveyViewModels>();
//    var TypesListViewModels = new List<CreateSurveyViewModels>();

//    if (categories != null && categories.Any())
//    {
//        foreach (var category in categories)
//        {
//            CategoriesListViewModels.Add(
//                new CreateSurveyViewModels
//                {
//                    categoryId = category.Id,
//                    CategoryName = category.Name
//                });

//        }
//    }

//return 
//    if (Types != null && Types.Any())
//    {
//        foreach (var Type in Types)
//        {
//            TypesListViewModels.Add(
//                new CreateSurveyViewModels
//                {
//                    TypeId = Type.Id,
//                    TypeName = Type.Name
//                });

//        }
//    }

//    return View(Create); // return des objets questions
//}


//public IActionResult SurveyList()
//{
//    var questions = 
//}
//    }
//}


