using CMS.ApplicationHelpers;
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
    public class RoundStatus_Service : IRoundStatus_Interface
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;
        private readonly ICipherService _cipherService;
        public RoundStatus_Service(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
            _cipherService = cipherService;
        }

        public Task<List<RoundStatusModel>> GetAllRoundStatusData()
        {
            var model = _dapper.GetAll<RoundStatusModel>(StoreProcedureName.RoundStatusData, null, CommandType.StoredProcedure);
            return Task.FromResult(model);
        }

        public string AddRoundStatusData([FromBody] RoundStatusModel roundStatusModel)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@StatusName", roundStatusModel.StatusName, DbType.String);
                parameters.Add("@create_user", roundStatusModel.create_user, DbType.String);
                //parameters.Add("@IsDeleted", roundStatusModel.IsDeleted, DbType.Boolean);
                var result = _dapper.Insert<string>(StoreProcedureName.InsertRoundStatus, parameters, CommandType.StoredProcedure);
                
                return result;
            }
            catch (ArgumentNullException ex)
            {
                throw new ArgumentNullException("FAILED TO INSERT ROUND STATUS.", ex);
            }
        }

        public int UpdateRoundStatusData(RoundStatusModel roundStatusModel)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@RoundStatusId", roundStatusModel.roundStatusId, DbType.Int32);
                parameters.Add("@StatusName", roundStatusModel.StatusName, DbType.String);
                parameters.Add("@change_user", roundStatusModel.change_user, DbType.String);
                //parameters.Add("@IsDeleted", roundStatusModel.IsDeleted, DbType.Boolean);

                var result = _dapper.Execute(StoreProcedureName.UpdateRoundStatus, parameters, CommandType.StoredProcedure);

                return result;
            }
            catch (ArgumentNullException ex)
            {
                throw new ArgumentNullException("FAILED TO UPDATE ROUND STATUS.", ex);
            }
        }

        public int DeleteRoundStatusDataById(RoundStatusModel roundStatus_Id)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@RoundStatusId", roundStatus_Id.roundStatusId, DbType.Int32);

                var result = _dapper.Execute(StoreProcedureName.DeleteRoundStatus, parameters, CommandType.StoredProcedure);

                return result;
            }
            catch (ArgumentNullException ex)
            {
                throw new ArgumentNullException("FAILED TO DELETE ROUND STATUS.", ex);
            }
        }
    }
}