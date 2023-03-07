using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
    public interface IRound_Interface
    {
        Task<List<RoundModel>> GetAllRound();
        Task<RoundModel> AddRound([FromBody] RoundModel roundModel);
        public int UpdateRound(RoundModel roundModel);
        public int DeleteRoundByid(int RoundID);
    }
}
