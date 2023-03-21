using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
    public interface IRole
    {
        public RestResponse Rolelist();

        public RestResponse AddRolelist(RoleModel roleModel);

        public RestResponse UpdateRolelist(RoleModel roleModel);

        public RestResponse DeleteRoleitem(RoleModel Role_ID);
    }
}
