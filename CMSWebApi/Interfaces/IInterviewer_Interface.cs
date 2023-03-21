using CMSWebApi.Models;

namespace CMSWebApi.Interfaces
{
    public interface IInterviewer_Interface
    {
        Task<List<InterviewerModel>> GetAllInterviewerDetails();
        Task<InterviewerModel> AddInterviewer(InterviewerModel interviewerModel);
        public int UpdateInterviewer(InterviewerModel interviewerModel);
        public int DeleteInterviewerByid(int InterviewerId);

    }
}
