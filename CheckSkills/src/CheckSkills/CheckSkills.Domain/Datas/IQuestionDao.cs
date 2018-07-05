using CheckSkills.Domain.Entities;
using System.Collections.Generic;

namespace CheckSkills.Domain
{
    public interface IQuestionDao
    {
        IEnumerable<Question> GetAll();

        int CreateQuestion(Question q);
    }
}