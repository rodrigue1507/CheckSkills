using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using CheckSkills.WebSite.ViewModels;
using CheckSkills.DAL;
using CheckSkills.Domain;
using CheckSkills.Domain.Entities;
using CheckSkills.WebSite.ViewModels.Response;

namespace CheckSkills.WebSite.Controllers
{
    public class QuestionController : Controller
    {
        //proprieté du controller question en private donc accessible que dans cette class
        private IQuestionDao _questionDao;
        private IQuestionCategoryDao _categoryDao;
        private IQuestionDifficultyDao _difficultyDao;
        private IQuestionTypeDao _questionTypeDao;
        private IResponseDao _responseDao;
        //constructeur de questions 
        public QuestionController()
        {
            _questionDao = new QuestionDao(); //
            _categoryDao = new QuestionCategoryDao();
            _difficultyDao = new QuestionDifficultyDao();
            _questionTypeDao = new QuestionTypeDao();
            _responseDao = new ResponseDao();
        }


        // methode retournant la liste totale de question
        [HttpGet]
        public IActionResult List()
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



        [HttpPost]
        public IActionResult Create(CreateOrUpdateQuestionViewModel model)
        {

            if (ModelState.IsValid)
            {
                // Traitement pour sauvegarder les questions

                //transformer le viewModel en une entité Question

                var question = new Question
                {
                    Category = new QuestionCategory { Id = model.CategoryId }, //
                    Content = model.Content,
                    Difficulty = new QuestionDifficulty { Id = model.DifficultyId },
                    Type = new QuestionType { Id = model.TypeId }
                };

                var questionId = _questionDao.CreateQuestion(question);

                if (questionId > 0)
                    return RedirectToAction("Details", new { questionId = questionId });
                else
                    ModelState.AddModelError("CategoryId", "La question n'a pas été ajoutée!");
            }

            AddReferenceDataToModel(model);
            return View(model);
        }


        [HttpGet]
        public IActionResult Create()
        {

            var model = new CreateOrUpdateQuestionViewModel();
            AddReferenceDataToModel(model);
            return View(model);
        }


        [HttpPost]
        public IActionResult Edit(CreateOrUpdateQuestionViewModel model)
        {

            if (ModelState.IsValid)
            {
                // Traitement pour sauvegarder les questions

                //transformer le viewModel en une entité Question

                var question = new Question
                {
                    Id = model.Id.Value,
                    Category = new QuestionCategory { Id = model.CategoryId }, //
                    Content = model.Content,
                    Difficulty = new QuestionDifficulty { Id = model.DifficultyId },
                    Type = new QuestionType { Id = model.TypeId }
                };

                var questionId = _questionDao.UpdateQuestion(question);
                if (questionId > 0)
                    return RedirectToAction("Details", new { questionId = questionId });
                else
                    ModelState.AddModelError("CategoryId", "La question n'a pas été mise à jour!");
            }

            AddReferenceDataToModel(model);
            return View(model);
        }


        [HttpGet]
        public IActionResult Edit(int questionId)
        {
            var question = _questionDao.GetAll().FirstOrDefault(q => q.Id == questionId);

            if (question != null)
            {
                var model = new CreateOrUpdateQuestionViewModel()
                {
                    Id = question.Id,
                    Content = question.Content,
                    DifficultyId = question.Difficulty.Id,
                    TypeId = question.Type.Id,
                    CategoryId = question.Category.Id,
                };
                AddReferenceDataToModel(model);
                return View(model);
            }

            return RedirectToAction("Edit");

        }




        [HttpGet]
        public IActionResult Delete(int questionId)
        {

            _questionDao.DeleteQuestion(questionId);

            return RedirectToAction("List");
        }
        
        [HttpGet]
        public IActionResult ConfirmDeleteOrNo(int questionId)
        {
            var question = _questionDao.GetAll().FirstOrDefault(q => q.Id == questionId);

            if (question != null)
            {
                var model = new QuestionViewModel()
                {
                    Id = question.Id,
                    Content = question.Content,
                    DifficultyLevel = question.Difficulty.DifficultyLevel,
                    CategoryName = question.Category.Name,
                    QuestionTypeName = question.Type.Name,
                };
                return View("ConfirmDeleteOrNo",model);
            }

            return RedirectToAction("DeleteError");
        }
         

        public IActionResult DeleteError()
        {
            return View();
        }


        [HttpGet]
        public IActionResult Details(int questionId)
        {
            var question = _questionDao.GetAll().FirstOrDefault(q => q.Id == questionId);

            if (question != null)
            {
                List<CreateOrUpdateQuestionResponseViewModel> responses = null;
                if (question.Type.Name == "QCM")
                {
                    var responseDtos = _responseDao.GetAll().Where(r => r.QuestionId == questionId);
                    responses = responseDtos.Select(r => new CreateOrUpdateQuestionResponseViewModel
                    {
                        Id = r.Id,
                        QuestionId = r.QuestionId,
                        ResponseContent = r.Content,
                        QuestionContent = question.Content
                    }).ToList();
                }

                var model = new QuestionViewModel()
                {
                    Id = question.Id,
                    Content = question.Content,
                    DifficultyLevel = question.Difficulty.DifficultyLevel,
                    CategoryName = question.Category.Name,
                    QuestionTypeName = question.Type.Name,
                    QuestionResponseList = responses,
                    TypeName = question.Type.Name

                };

                return View(model);
            }
            return RedirectToAction("List");
        }


        [HttpGet]
        public IActionResult AddQuestionResponse(int questionId)
        {
            var question = _questionDao.GetAll().FirstOrDefault(q => q.Id == questionId);
            if (question != null)
            {
                var responseViewModel = new QuestionResponseViewModel()
                {
                    QuestionId = question.Id,
                    QuestionContent = question.Content
                };
                return View("AddOrUpdateQuestionResponse", responseViewModel);
            }

            return RedirectToAction("Details", new { questionId });
        }

        [HttpGet]
        public IActionResult EditQuestionResponse(int responseId)
        {
            var response = _responseDao.GetAll().FirstOrDefault(r => r.Id == responseId);

            if (response != null)
            {
                var question = _questionDao.GetAll().FirstOrDefault(q => q.Id == response.QuestionId);
                var responseViewModel = new QuestionResponseViewModel()
                {
                    QuestionId = question.Id,
                    QuestionContent = question.Content,
                    ResponseContent = response.Content,
                    ResponseId = response.Id
                };
                return View("AddOrUpdateQuestionResponse", responseViewModel);
            }

            return RedirectToAction("List");

        }

        [HttpPost]
        public IActionResult AddOrUpdateQuestionResponse(QuestionResponseViewModel responseviewModel)
        {

            var response = new Response
            {
                Id = responseviewModel.ResponseId ?? 0,
                QuestionId = responseviewModel.QuestionId,
                Content = responseviewModel.ResponseContent
            };

            if (responseviewModel.ResponseId.HasValue && responseviewModel.ResponseId.Value > 0)
            {
                _responseDao.UpdateResponse(response);
            }
            else
            {
                var responseId = _responseDao.CreateResponse(response);
            }

            return RedirectToAction("Details", new { questionId = responseviewModel.QuestionId });

        }


        [HttpGet]
        public IActionResult DeleteQuestionResponse(int responseId)
        {
            var response = _responseDao.GetAll().FirstOrDefault(q => q.Id == responseId);
            if (response != null)
            {
                _responseDao.DeleteResponse(responseId);
            }
            return RedirectToAction("Details", new { questionId = response.QuestionId });

        }


        private void AddReferenceDataToModel(CreateOrUpdateQuestionViewModel model)
        {
            if (model == null)
                model = new CreateOrUpdateQuestionViewModel();

            model.Categories = _categoryDao.GetAllQuestionCategory().Select(o => new Microsoft.AspNetCore.Mvc.Rendering.SelectListItem
            {
                Text = o.Name,
                Value = o.Id.ToString()
            });
            model.Difficulties = _difficultyDao.GetAll().Select(o => new Microsoft.AspNetCore.Mvc.Rendering.SelectListItem
            {
                Text = o.DifficultyLevel,
                Value = o.Id.ToString()
            });
            model.QuestionTypes = _questionTypeDao.GetAll().Select(o => new Microsoft.AspNetCore.Mvc.Rendering.SelectListItem
            {
                Text = o.Name,
                Value = o.Id.ToString()
            });
            model.Responses = _responseDao.GetAll().Select(o => new Microsoft.AspNetCore.Mvc.Rendering.SelectListItem
            {
                Text = o.Content,
                Value = o.Id.ToString()
            });
        }


    }
}
