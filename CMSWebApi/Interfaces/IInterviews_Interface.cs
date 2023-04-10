using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
    public interface IInterviews_Interface
    {
        Task<List<InterviewsModel>> GetAllInterviewsData();
        public string AddInterviewData([FromBody] InterviewsModel interviewsModel);
        public int UpdateInterviewData(InterviewsModel interviewsModel);
        public int DeleteInterviewDataById(InterviewsModel InterviewId);
    }
}
