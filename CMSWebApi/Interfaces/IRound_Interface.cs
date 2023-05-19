using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
    public interface IRound_Interface
    {
        public Task<List<RoundModel>> GetAllRound(int pageNumber, int pageSize, out int totalItems);
		string AddRound([FromBody] RoundModel roundModel);
        public int UpdateRound(RoundModel roundModel);
        public int DeleteRoundByid(RoundModel Round_ID);

    }
}
