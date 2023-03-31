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
            try
            {
                //var model = _dapper.GetAll<ReasonModel>(StoreProcedureName.ReasonMasterData, null, System.Data.CommandType.StoredProcedure);

                //change this
				var model = _dapper.GetAll<ReasonModel>(StoreProcedureName.ReasonMasterData, null, System.Data.CommandType.StoredProcedure);
				return Task.FromResult(model);
            }
            catch (ArgumentNullException ex)
            {

				throw new ArgumentNullException("NULL VALUE", ex);
			}
        }
        #endregion

        #region AddReason
        public string AddReason(ReasonModel reasonModel)
        {
            try
            {
                var parameters = new DynamicParameters();
                //parameters.Add("@ReasonID", reasonModel.ReasonID, DbType.Int32);
                parameters.Add("@Reason", reasonModel.Reason, DbType.String);
                parameters.Add("@create_user", reasonModel.create_User, DbType.String);

                var result = _dapper.Insert<string>(StoreProcedureName.InsertReason, parameters, CommandType.StoredProcedure);
                return result;
            }
            catch (ArgumentNullException ex)
            {
				throw new ArgumentNullException("FAILED TO INSERT REASON.", ex);
			}
        }
        #endregion

        #region UpdateReason
        public int UpdateReason(ReasonModel reasonModel)
        {
            try
            {
				var parameters = new DynamicParameters();
				parameters.Add("@ReasonID", reasonModel.ReasonID, DbType.Int32);
				parameters.Add("@Reason", reasonModel.Reason, DbType.String);
				parameters.Add("@change_user", reasonModel.Change_user, DbType.String);
				// parameters.Add("@IsDelete", designationModel.IsDelete=false, DbType.String);
				var result = _dapper.Execute(StoreProcedureName.UpdateReason, parameters, CommandType.StoredProcedure);
				return result;

			}
            catch (ArgumentNullException ex)
            {
				throw new ArgumentNullException("FAILED TO UPDATE REASON.", ex);
			}
            
        }
        #endregion

		#region DeleteReasonByid
		public int DeleteReasonByid(ReasonModel Reason_ID)
		{
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@ReasonID", Reason_ID.ReasonID, DbType.Int32);

                var result = _dapper.Execute(StoreProcedureName.DeleteReason, parameters, CommandType.StoredProcedure);

                return result;
            }
            catch (ArgumentNullException ex) { 
                throw new ArgumentNullException("FAILED TO DELETE REASON.", ex); 
            }
		}
		#endregion

		#region GetReasonsByPage
		public async Task<List<ReasonModel>> GetReasonsByPage(int pageNumber, int rowsOfPage)
		{
			var parameters = new DynamicParameters();
			parameters.Add("@PageNumber", pageNumber, DbType.Int32);
			parameters.Add("@RowsOfPage", rowsOfPage, DbType.Int32);

			var result = _dapper.GetAll<ReasonModel>("PageReasonMaster", parameters, CommandType.StoredProcedure);
			return result;
		}
		#endregion
	}

}
