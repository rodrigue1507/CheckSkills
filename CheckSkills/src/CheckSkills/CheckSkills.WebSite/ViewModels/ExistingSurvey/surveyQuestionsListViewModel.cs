using CheckSkills.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
//renvoie la liste des formuliare creé depui la base de donnée
namespace CheckSkills.WebSite.ViewModels
{
        public class SurveyQuestionsListViewModel
        {
            public IEnumerable<Survey_Question> SurveyQuestion { get; set; }
        }
}
