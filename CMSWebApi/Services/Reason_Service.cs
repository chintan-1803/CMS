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
    public class Reason_Service : IReason_Interface
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;
        private readonly ICipherService _cipherService;

        public Reason_Service(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
            _cipherService = cipherService;
        }

        #region GetReasons 
        public Task<List<ReasonModel>> GetAllReason()
        {           
            var model = _dapper.GetAll<ReasonModel>(StoreProcedureName.ReasonMasterData, null, System.Data.CommandType.StoredProcedure);
            return Task.FromResult(model);
        }
        #endregion

        #region AddReason
        public string AddReason(ReasonModel reasonModel)
        {
            var parameters = new DynamicParameters();
            //parameters.Add("@ReasonID", reasonModel.ReasonID, DbType.Int32);
            parameters.Add("@Reason", reasonModel.Reason, DbType.String);
            parameters.Add("@create_user", reasonModel.create_User, DbType.String);

            var result = _dapper.Insert<string>(StoreProcedureName.InsertReason, parameters, CommandType.StoredProcedure);
            if (result == null)
            {
                throw new Exception("Failed to insert Reason.");
            }
            return result;
        }
        #endregion

        #region UpdateReason
        public int UpdateReason(ReasonModel reasonModel)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@ReasonID", reasonModel.ReasonID, DbType.Int32);
            parameters.Add("@Reason", reasonModel.Reason, DbType.String);
            parameters.Add("@change_user", reasonModel.Change_user, DbType.String);
            // parameters.Add("@IsDelete", designationModel.IsDelete=false, DbType.String);
            var result = _dapper.Execute(StoreProcedureName.UpdateReason, parameters, CommandType.StoredProcedure);
            return result;
        }
		#endregion

		#region DeleteReasonByid
		public int DeleteReasonByid(ReasonModel Reason_ID)
		{
			var parameters = new DynamicParameters();
			parameters.Add("@ReasonID", Reason_ID.ReasonID, DbType.Int32);

			var result = _dapper.Execute(StoreProcedureName.DeleteReason, parameters, CommandType.StoredProcedure);

			return result;
		}
		#endregion
	}
}
