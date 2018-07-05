using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using CheckSkills.WebSite.Models;
using CheckSkills.DAL;
using CheckSkills.WebSite.ViewModels;
using CheckSkills.Domain;
using CheckSkills.Domain.Entities;

namespace CheckSkills.WebSite.Controllers
{
    public class QuestionController : Controller
    {
        //proprieté du controller question en private donc accessible que dans cette class
        private QuestionDao _questionDao;
        private CategoryDao _categoryDao;
        private DifficultyDao _difficultyDao;
        private QuestionTypeDao _questionTypeDao;

        //constructeur de questions 
        public QuestionController()
        {
            _questionDao = new QuestionDao(); //
            _categoryDao = new CategoryDao();
            _difficultyDao = new DifficultyDao();
            _questionTypeDao = new QuestionTypeDao();

        }


        // methode retournant la liste totale de question
        [HttpGet]
        public IActionResult List()
        {
            // Recuperer la liste des questions depuis la base
            var questions = _questionDao.GetAll();

            // Convertir en view models, 
            // en recuperant seulement les données dont la vue à besoin
            var QuestionListViewModels = new List<QuestionViewModel>();
            if (questions != null && questions.Any())
            {
                foreach (var question in questions)
                {
                    QuestionListViewModels.Add(
                        new QuestionViewModel()
                        {
                            Id = question.Id,
                            Content = question.Content
                        });
                }
            }
            return View(QuestionListViewModels);
        }




        //
        [HttpPost]
        public IActionResult Create(CreateOrUpdateQuestionViewModel model)
        {

            if (ModelState.IsValid)
            {
                // Traitement pour sauvegarder les questions

                //transformer le viewModel en une entité Question

                var question = new Question
                {
                    Category = new Category { Id = model.CategoryId }, //
                    Content = model.Content,
                    Difficulty = new Difficulty { Id = model.DifficultyId },
                    QuestionType = new QuestionType { Id = model.QuestionTypeId }
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


        [HttpGet]
        public IActionResult Details(int questionId)
        {
            var question = _questionDao.GetAll().FirstOrDefault(q => q.Id == questionId);

            if (question != null)
            {
                var model = new QuestionViewModel()
                {
                    Id = question.Id,
                    Content = question.Content
                };

                return View(model);
            }
            return RedirectToAction("List");
        }

        private void AddReferenceDataToModel(CreateOrUpdateQuestionViewModel model)
        {
            if (model == null)
                model = new CreateOrUpdateQuestionViewModel();

            model.Categories = _categoryDao.GetAll().Select(o => new Microsoft.AspNetCore.Mvc.Rendering.SelectListItem
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

        }



        //private IEnumerable<dynamic> Getcategories()
        //{
        //    yield return new { Id = -1, Name = "Choisir" };
        //    yield return new { Id = 1, Name = "Html" };
        //    yield return new { Id = 2, Name = "C#" };
        //    yield return new { Id = 3, Name = "Javascript" };
        //}

        //private IEnumerable<dynamic> GetDifficulties()
        //{
        //    yield return new { Id = -1, Name = "Choisir" };
        //    yield return new { Id = 1, Name = "1" };
        //    yield return new { Id = 2, Name = "2" };
        //    yield return new { Id = 3, Name = "3" };
        //}

        //private IEnumerable<dynamic> GetQuestionTypes()
        //{
        //    yield return new { Id = -1, Name = "Choisir" };
        //    yield return new { Id = 1, Name = "QCM" };
        //    yield return new { Id = 2, Name = "Question-Reponse" };
        //}

    }
}
