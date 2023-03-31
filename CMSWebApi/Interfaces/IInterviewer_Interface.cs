using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
    public interface IInterviewer_Interface
    {
        Task<List<InterviewerModel>> GetAllInterviewerDetails();
        public string AddInterviewer([FromBody] InterviewerModel interviewerModel);

		public int UpdateInterviewer(InterviewerModel interviewerModel);
        public int DeleteInterviewerByid(InterviewerModel Interviewer_Id);

    }
}
