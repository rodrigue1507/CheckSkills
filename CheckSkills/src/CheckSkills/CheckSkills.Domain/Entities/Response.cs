﻿using System;
using System.Collections.Generic;
using System.Text;

namespace CheckSkills.Domain
{
    public class Response
    {
        public int Id { get; set; }
        public string Content { get; set; }
        public bool IsCorrect { get; set; }
    }
}
