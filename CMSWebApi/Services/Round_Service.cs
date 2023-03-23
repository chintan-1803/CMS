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
    public class Round_Service : IRound_Interface
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;
        private readonly ICipherService _cipherService;

        public Round_Service(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
            _cipherService = cipherService;
        }

        #region GetRound
        public Task<List<RoundModel>> GetAllRound()
        {
            var model = _dapper.GetAll<RoundModel>(StoreProcedureName.RoundMasterData, null, System.Data.CommandType.StoredProcedure);
            return Task.FromResult(model);
        }
        #endregion

        #region AddRound
        public string AddRound([FromBody] RoundModel roundModel)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@Round_Name", roundModel.Round_Name, DbType.String);
            parameters.Add("@create_user", roundModel.create_User, DbType.String);

            var result = _dapper.Insert<string>(StoreProcedureName.InsertRound, parameters, CommandType.StoredProcedure);
            if (result == null)
            {
                throw new Exception("Failed to insert designation.");
            }

            return result;
        }
        #endregion

        #region UpdateRound
        public int UpdateRound(RoundModel roundModel)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@RoundID", roundModel.RoundID, DbType.Int32);
            parameters.Add("@Round_Name", roundModel.Round_Name, DbType.String);
            parameters.Add("@change_user", roundModel.Change_user, DbType.String);

            var result = _dapper.Execute(StoreProcedureName.UpdateRound, parameters, CommandType.StoredProcedure);
            return result;
        }
		#endregion


		#region DeleteRoundByid
		public int DeleteRoundByid(RoundModel Round_ID)
		{
			var parameters = new DynamicParameters();
			parameters.Add("@RoundID", Round_ID.RoundID, DbType.Int32);

			var result = _dapper.Execute(StoreProcedureName.DeleteRound, parameters, CommandType.StoredProcedure);
			return result;
		}
		#endregion
	}
}
