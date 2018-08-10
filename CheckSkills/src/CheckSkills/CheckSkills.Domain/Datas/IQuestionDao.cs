﻿using CheckSkills.Domain.Entities;
using System.Collections.Generic;

namespace CheckSkills.Domain
{
    public interface IQuestionDao
    {
        IEnumerable<Question> GetAll();

        int CreateQuestion(Question q);

        int UpdateQuestion(Question q);

        void DeleteQuestion(int questionId);
    }
}