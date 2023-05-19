using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
    public interface IReason
    {
        public RestResponse Reasonlist(int pageNumber, int pageSize, out int totalItems);

        public RestResponse AddReasonlist(ReasonModel reasonModel);

		public RestResponse UpdateReasonlist(ReasonModel reasonModel);

        public RestResponse DeleteReasonitem(ReasonModel Reason_ID);
	}
}
