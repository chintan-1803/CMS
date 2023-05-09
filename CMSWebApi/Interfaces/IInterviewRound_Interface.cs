using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
    public interface IInterviewRound_Interface
    {
        public Task<List<InterviewRoundModel>> GetAllInterviewRoundData(int interviewRoundId);
        public string AddInterviewRoundData([FromBody] InterviewRoundModel interviewRoundModel);
        public int UpdateInterviewRoundData(InterviewRoundModel interviewRoundModel);
        public int DeleteInterviewRoundDataById(InterviewRoundModel InterviewRound_Id);

    }
}
