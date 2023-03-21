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
        public Task<List<DesignationModel>> GetAllDesignation()
        {
            var model = _dapper.GetAll<DesignationModel>(StoreProcedureName.DesignationMasterData, null, System.Data.CommandType.StoredProcedure);
            return Task.FromResult(model);
        }
        #endregion

        #region AddDesignation
        public Task<DesignationModel> AddDesignation([FromBody] DesignationModel designationModel)
        {
            var parameters = new DynamicParameters();
           // parameters.Add("@DesignationID", designationModel.DesignationID, DbType.Int32);
            parameters.Add("@Designation", designationModel.Designation, DbType.String);
            parameters.Add("@create_user", designationModel.create_User, DbType.String);
            
            var result = _dapper.Insert<DesignationModel>(StoreProcedureName.InsertDesignation, parameters, CommandType.StoredProcedure);

            if (result == null)
            {
                throw new Exception("Failed to insert designation.");
            }

            return Task.FromResult(result);
        }
        #endregion

       #region UpdateDesignation
       public int UpdateDesignation(DesignationModel designationModel)
       {
            var parameters = new DynamicParameters();
            parameters.Add("@DesignationID",  designationModel.DesignationID, DbType.Int32);
            parameters.Add("@Designation", designationModel.Designation, DbType.String);
            parameters.Add("@change_user", designationModel.Change_user, DbType.String);
           // parameters.Add("@IsDelete", designationModel.IsDelete=false, DbType.String);

            var result =_dapper.Execute(StoreProcedureName.UpdateDesignation, parameters, CommandType.StoredProcedure);
          
            
            return result;
        }
        #endregion

        #region DeleteDesignationByid
        public int DeleteDesignationByid(DesignationModel Designation_ID)
        {   
            var parameters = new DynamicParameters();
            parameters.Add("@DesignationID", Designation_ID.DesignationID,  DbType.Int32);
 
            var result = _dapper.Execute(StoreProcedureName.DeleteDesignation, parameters, CommandType.StoredProcedure);

            if (result == 0)
            {
                throw new Exception("Failed to insert designation.");
            }
            return result; 
        }
        #endregion
    }
}
