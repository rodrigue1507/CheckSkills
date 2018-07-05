using System;
using System.Collections.Generic;
using System.Text;

namespace CheckSkills.Domain.Entities
    {
        public class Question
        {
            public int Id { get; set; }
            public string Content { get; set; }
             
            public Category Category  { get; set; }
            public Difficulty Difficulty { get; set; }
            public QuestionType QuestionType { get; set; }
        }
    }
