using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
    public interface IRound
    {
        public RestResponse Roundlist(int pageNumber, int pageSize, out int totalItems);

        public RestResponse AddRound(RoundModel roundModel);

        public RestResponse UpdateRoundlist(RoundModel roundModel);

        public RestResponse DeleteRounditem(RoundModel Round_ID);

	}
}
