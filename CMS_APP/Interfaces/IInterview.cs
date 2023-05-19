using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
    public interface IInterview
    {
        public RestResponse GetInterviewList(int pageNumber, int pageSize, out int totalItems);

        public RestResponse AddInterview(InterviewModel interviewData);

        public RestResponse UpdateInterview(InterviewModel updateInterviewData);

        public RestResponse DeleteInterview(InterviewModel interviewId);

		public RestResponse AddInterviewRound(InterviewRoundModel interviewRoundData);

		public RestResponse ViewInterviewRound(int interviewId);
	}
}
