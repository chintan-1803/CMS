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
    public class Role_Service : IRole_Interface
    {
        private readonly AppSettings _appSettings;
        private readonly IDapper _dapper;
        private readonly ICipherService _cipherService;

        public Role_Service(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService)
        {
            _appSettings = appSettings.Value;
            _dapper = dapper;
            _cipherService = cipherService;
        }

        #region GetRole
        public Task<List<RoleModel>> GetAllRole()
        {
            //List<model> GetAll<model>(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure)
            var model = _dapper.GetAll<RoleModel>(StoreProcedureName.RoleMasterData, null, System.Data.CommandType.StoredProcedure);
            return Task.FromResult(model);
        }
        #endregion

        #region AddRole
        public Task<RoleModel> AddRole([FromBody] RoleModel roleModel)
        {
            var parameters = new DynamicParameters();
           // parameters.Add("@RoleId", roleModel.RoleId, DbType.Int32);
            parameters.Add("@RoleName", roleModel.RoleName, DbType.String);
            parameters.Add("@create_user", roleModel.create_User, DbType.String);

            var result = _dapper.Insert<RoleModel>(StoreProcedureName.InsertRole, parameters, CommandType.StoredProcedure);

            if (result == null)
            {
                throw new Exception("Failed to insert designation.");
            }

            return Task.FromResult(result);
        }
        #endregion

        #region UpdateRole
        public int UpdateRole(RoleModel roleModel)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@RoleId", roleModel.RoleId, DbType.Int32);
            parameters.Add("@RoleName", roleModel.RoleName, DbType.String);
            parameters.Add("@change_user", roleModel.Change_user, DbType.String);
            // parameters.Add("@IsDelete", designationModel.IsDelete=false, DbType.String);

            var result = _dapper.Execute(StoreProcedureName.UpdateRole, parameters, CommandType.StoredProcedure);
         
            return result;
        }
        #endregion

        #region DeleteRoleByid
        public int DeleteRoleByid(RoleModel Role_ID)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@RoleId", Role_ID.RoleId, DbType.Int32);

            var result = _dapper.Execute(StoreProcedureName.DeleteRole, parameters, CommandType.StoredProcedure);

            if (result == 0)
            {
                throw new Exception("Failed to insert designation.");
            }
            return result;
        }
        #endregion
    }
}
