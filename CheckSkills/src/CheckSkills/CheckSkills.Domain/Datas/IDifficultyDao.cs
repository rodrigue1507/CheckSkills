using CheckSkills.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace CheckSkills.Domain
{
    public interface IDifficultyDao
    {
        IEnumerable<Difficulty> GetAll();
    }
}
