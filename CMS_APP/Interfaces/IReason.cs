using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
    public interface IReason
    {
        public RestResponse Reasonlist();

        public RestResponse AddDesignationlist(ReasonModel reasonModel);

		public RestResponse UpdateReasonlist(ReasonModel reasonModel);

        public RestResponse DeleteReasonitem(ReasonModel Reason_ID);
	}
}
