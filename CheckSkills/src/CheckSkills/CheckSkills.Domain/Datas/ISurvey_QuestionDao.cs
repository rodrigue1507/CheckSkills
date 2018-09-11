using System.Collections.Generic;

namespace CheckSkills.Domain
{
    public interface ISurvey_QuestionDao
    {
      IEnumerable<Survey> GetAllSurvey();
      void DeleteQuestionSurvey(int questionId);
      IEnumerable<Survey_Question> GetSurvey_Questions(Survey s);
    }
}
