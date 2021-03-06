﻿using CheckSkills.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Text;


namespace CheckSkills.Domain
{
    public interface IResponseDao
    {
        IEnumerable<Response> GetAll();
        int CreateResponse(Response r);
        int UpdateResponse(Response r);
        void DeleteResponse(int reponseId);
    }
}
