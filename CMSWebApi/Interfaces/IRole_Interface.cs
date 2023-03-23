using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
    public interface IRole_Interface
    {
        Task<List<RoleModel>> GetAllRole();
        public string AddRole([FromBody] RoleModel roleModel);

		public int UpdateRole(RoleModel roleModel);
        public int DeleteRoleByid(RoleModel Role_ID);
    }
}
