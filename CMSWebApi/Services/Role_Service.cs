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

		public Task<List<RoleModel>> GetAllRole(int pageNumber, int pageSize, out int totalItems)
		{
			try
			{
				var parameters = new DynamicParameters();
				parameters.Add("@PageNumber", pageNumber);
				parameters.Add("@PageSize", pageSize);
				parameters.Add("@TotalItems", dbType: DbType.Int32, direction: ParameterDirection.Output);

				var model = _dapper.GetAll<RoleModel>(StoreProcedureName.RoleMasterData, parameters, CommandType.StoredProcedure);
				totalItems = parameters.Get<int>("@TotalItems");

				return Task.FromResult(model);
			}
			catch (Exception ex)
			{
				throw new Exception("Error occurred while retrieving all roles.", ex);
			}
        }
        #endregion

        #region AddRole
        public string AddRole([FromBody] RoleModel roleModel)
        {
            try
            {
                var parameters = new DynamicParameters();
                // parameters.Add("@RoleId", roleModel.RoleId, DbType.Int32);
                parameters.Add("@RoleName", roleModel.RoleName, DbType.String);
                parameters.Add("@create_user", roleModel.create_User, DbType.String);

                var result = _dapper.Insert<string>(StoreProcedureName.InsertRole, parameters, CommandType.StoredProcedure);

                //if (result == null)
                //{
                //    throw new Exception("Failed to insert designation.");
                //}

                return result;
            }
            catch (ArgumentNullException ex)
            {
				throw new ArgumentNullException("FAILED TO INSERT Role.", ex);
			}
        }
        #endregion

        #region UpdateRole
        public int UpdateRole(RoleModel roleModel)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@RoleId", roleModel.RoleId, DbType.Int32);
                parameters.Add("@RoleName", roleModel.RoleName, DbType.String);
                parameters.Add("@change_user", roleModel.Change_user, DbType.String);
                // parameters.Add("@IsDelete", designationModel.IsDelete=false, DbType.String);

                var result = _dapper.Execute(StoreProcedureName.UpdateRole, parameters, CommandType.StoredProcedure);

                return result;
            }
            catch (ArgumentNullException ex)
            {
				throw new ArgumentNullException("FAILED TO UPDATE Role.", ex);
			}
        }
        #endregion

        #region DeleteRoleByid
        public int DeleteRoleByid(RoleModel Role_ID)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@RoleId", Role_ID.RoleId, DbType.Int32);

                var result = _dapper.Execute(StoreProcedureName.DeleteRole, parameters, CommandType.StoredProcedure);

                //if (result == 0)
                //{
                //    throw new Exception("Failed to DELETE ROLE.");
                //}
                return result;
            }
            catch (ArgumentNullException ex)
            {
				throw new ArgumentNullException("FAILED TO DELETE REASON.", ex);
			}
        }
        #endregion
    }
}
