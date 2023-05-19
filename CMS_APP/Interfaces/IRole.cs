using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
    public interface IRole
    {
        public RestResponse Rolelist(int pageNumber, int pageSize, out int totalItems);

        public RestResponse AddRolelist(RoleModel roleModel);

        public RestResponse UpdateRolelist(RoleModel roleModel);

        public RestResponse DeleteRoleitem(RoleModel Role_ID);
    }
}
