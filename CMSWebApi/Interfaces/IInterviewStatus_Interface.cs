using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CMSWebApi.Interfaces
{
    public interface IInterviewStatus_Interface
    {
        Task<List<InterviewStatusModel>> GetAllInterviewStatus();
        public string AddInterviewStatus([FromBody] InterviewStatusModel interviewStatusModel);
        public int UpdateInterviewStatus(InterviewStatusModel interviewStatusModel);
        public int DeleteInterviewStatusById(InterviewStatusModel StatusID);
    }
}
