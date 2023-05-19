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
    public class Designation_Service : IDesignation_Interface
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;
        private readonly ICipherService _cipherService;

        public Designation_Service(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
            _cipherService = cipherService;
        }

        #region GetDesignation
		public Task<List<DesignationModel>> GetAllDesignation(int pageNumber, int pageSize, out int totalItems)
		{
			try
			{
				var parameters = new DynamicParameters();
				parameters.Add("@PageNumber", pageNumber);
				parameters.Add("@PageSize", pageSize);
				parameters.Add("@TotalItems", dbType: DbType.Int32, direction: ParameterDirection.Output);

				var model = _dapper.GetAll<DesignationModel>(StoreProcedureName.DesignationMasterData, parameters, CommandType.StoredProcedure);
				totalItems = parameters.Get<int>("@TotalItems");

				return Task.FromResult(model);
			}
			catch (Exception ex)
			{
				throw new Exception("Error occurred while retrieving all designations.", ex);
			}
		}
		#endregion

        #region AddDesignation
        public string AddDesignation([FromBody] DesignationModel designationModel)
        {
            try
            {
				var parameters = new DynamicParameters();
				parameters.Add("@Designation", designationModel.Designation, DbType.String);
				parameters.Add("@create_user", designationModel.create_User, DbType.String);

				var result = _dapper.Insert<string>(StoreProcedureName.InsertDesignation, parameters, CommandType.StoredProcedure);

				return result;

			}
            catch (ArgumentNullException ex)
            {

				throw new ArgumentNullException("FAILED TO INSERT DESIGNATION.", ex);
			}
           
        }
        #endregion

       #region UpdateDesignation
       public int UpdateDesignation(DesignationModel designationModel)
       {
            try
            {
				var parameters = new DynamicParameters();
				parameters.Add("@DesignationID", designationModel.DesignationID, DbType.Int32);
				parameters.Add("@Designation", designationModel.Designation, DbType.String);
				parameters.Add("@change_user", designationModel.Change_user, DbType.String);
				// parameters.Add("@IsDelete", designationModel.IsDelete=false, DbType.String);

				//var result = _dapper.Execute(StoreProcedureName.UpdateDesignation, parameters, CommandType.StoredProcedure);
				var result = _dapper.Execute(StoreProcedureName.UpdateDesignation, parameters, CommandType.StoredProcedure); //change
				return result;

			}
            catch (ArgumentNullException ex)
            {

				throw new ArgumentNullException("FAILED TO UPDATE DESIGNATION.", ex);
			} 
       }
        #endregion

        #region DeleteDesignationByid
        public int DeleteDesignationByid(DesignationModel Designation_ID)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@DesignationID", Designation_ID.DesignationID, DbType.Int32);

                var result = _dapper.Execute(StoreProcedureName.DeleteDesignation, parameters, CommandType.StoredProcedure);

                return result;
            }
            catch (ArgumentNullException ex)
            {

				throw new ArgumentNullException("FAILED TO DELETE DESIGNATION.", ex);
			}
        }
        #endregion
    }
}
