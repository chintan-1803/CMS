using CMS.Models;
using CMSWebApi.Models;

namespace CMSWebApi.Interfaces
{
    public interface IUserApiService
    {
        AuthenticateResponse AuthenticateUser(UserLoginEntity loginRequest);
        LoginResponse GetById(int userId);

        //Designation
        Task<List<DesignationModel>> GetAllDesignation();

        //Reason
        Task<List<ReasonModel>> GetAllReason();

        //Technology
        Task<List<TechnologyModel>> GetAllTechnology();

        //Role
        Task<List<RoleModel>> GetAllRole();

        //Round
        Task<List<RoundModel>> GetAllRound();
    }
}
