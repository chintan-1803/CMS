using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
    public interface IInterview
    {
        public RestResponse GetInterviewList();

        public RestResponse AddInterview(InterviewModel interviewData);

        public RestResponse UpdateInterview(InterviewModel updateInterviewData);

        public RestResponse DeleteInterview(InterviewModel interviewId);
    }
}
