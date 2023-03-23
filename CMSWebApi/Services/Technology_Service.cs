﻿using CMS.ApplicationHelpers;
using CMSWebApi.Dapper;
using CMSWebApi.DataHelper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using System.Data;

namespace CMSWebApi.Services
{
    public class Technology_Service : ITechnology_Interface
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;
        private readonly ICipherService _cipherService;

        public Technology_Service(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
            _cipherService = cipherService;
        }

        #region GetTechnology 
        public Task<List<TechnologyModel>> GetAllTechnology()
        {
            //List<model> GetAll<model>(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure)
            var model = _dapper.GetAll<TechnologyModel>(StoreProcedureName.TechnologyMasterData, null, System.Data.CommandType.StoredProcedure);
            return Task.FromResult(model);
        }
        #endregion

        #region AddTechnology
        public string AddTechnology([FromBody] TechnologyModel technologyModel)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@TechnologyName", technologyModel.TechnologyName, DbType.String);
            parameters.Add("@Discription", technologyModel.Discription, DbType.String);
            parameters.Add("@create_user", technologyModel.create_User, DbType.String);

            var result = _dapper.Insert<string>(StoreProcedureName.InsertTechnology, parameters, CommandType.StoredProcedure);
            if (result == null)
            {
                throw new Exception("Failed to insert Technology.");
            }

            return result;
        }
        #endregion

        #region UpdateTechnology
        public int UpdateTechnology(TechnologyModel technologyModel)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@TechnologyId", technologyModel.TechnologyId, DbType.Int32);
            parameters.Add("@TechnologyName", technologyModel.TechnologyName, DbType.String);
            parameters.Add("@Discription", technologyModel.Discription, DbType.String);
           // parameters.Add("@IsActive", technologyModel.IsActive, DbType.Boolean);
            parameters.Add("@change_user", technologyModel.Change_user, DbType.String);

            var result = _dapper.Execute(StoreProcedureName.UpdateTechnology, parameters, CommandType.StoredProcedure);
            return result;
        }
        #endregion

        #region DeleteTechnologyByid
        public int DeleteTechnology(TechnologyModel Technology_ID)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@TechnologyId", Technology_ID.TechnologyId, DbType.Int32);

            var result = _dapper.Execute(StoreProcedureName.DeleteTechnology, parameters, CommandType.StoredProcedure);

            return result;
        }
        #endregion
    }
}
