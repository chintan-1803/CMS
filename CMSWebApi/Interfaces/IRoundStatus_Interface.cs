using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
    public interface IRoundStatus_Interface
    {
        Task<List<RoundStatusModel>> GetAllRoundStatusData();
        public string AddRoundStatusData([FromBody] RoundStatusModel roundStatusModel);
        public int UpdateRoundStatusData(RoundStatusModel roundStatusModel);
        public int DeleteRoundStatusDataById(RoundStatusModel roundStatus_Id);
    }
}
