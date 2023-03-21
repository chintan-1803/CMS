using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
    public interface IReason_Interface
    {
        Task<List<ReasonModel>> GetAllReason();
        Task<ReasonModel> AddReason(ReasonModel reasonModel);
        public int UpdateReason(ReasonModel reasonModel);
        public int DeleteReasonByid(ReasonModel Reason_ID);

	}
}
