﻿using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
    public interface ITechnology_Interface
    {
        Task<List<TechnologyModel>> GetAllTechnology();
		public string AddTechnology([FromBody] TechnologyModel technologyModel);
        public int UpdateTechnology(TechnologyModel technologyModel);
        public int DeleteTechnology(TechnologyModel Technology_ID);

    }
}
