using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
    public interface IRound
    {
        public RestResponse Roundlist();

        public RestResponse AddRound(RoundModel roundModel);

        public RestResponse UpdateRoundlist(RoundModel roundModel);

        public RestResponse DeleteRounditem(RoundModel Round_ID);

	}
}
