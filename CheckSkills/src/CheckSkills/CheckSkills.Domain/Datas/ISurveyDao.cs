using CheckSkills.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace CheckSkills.Domain
{
    public interface ISurveyDao
    {
        IEnumerable<Question> GetAll();
        IEnumerable<Question> GetByPreferencies(int categoryId, int typeId, int difficultyId);
        IEnumerable<Survey> GetAllSurvey();
        IEnumerable<QuestionCategory> GetAllQuestionCategory();
        IEnumerable<QuestionType> GetAllQuestionType();
        IEnumerable<QuestionDifficulty> GetAllQuestionDifficulty();
        int CreateSurvey(Survey q);

        int UpdateSurvey(Survey q);

        void DeleteSurvey(Survey q);
    }
}
