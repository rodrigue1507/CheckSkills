using CheckSkills.Domain.Entities;
using System.Collections.Generic;

namespace CheckSkills.Domain
{
    public interface ICategoryDao
    {
        IEnumerable<Category> GetAll();
    }
}