using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
    public interface IRound_Interface
    {
        Task<List<RoundModel>> GetAllRound();
        public string AddRound([FromBody] RoundModel roundModel);

		public int UpdateRound(RoundModel roundModel);
		public int DeleteRoundByid(RoundModel Round_ID);
    }
}
