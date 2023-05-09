using CMSWebApi.Models;

namespace CMSWebApi.Interfaces
{
	public interface IAllMsaterData_Interface
	{
		public Task<(List<DesignationModel>, List<ReasonModel>, List<RoleModel>, List<RoundModel>, List<TechnologyModel>, List<InterviewStatusModel>, List<InterviewerModel>, List<CandidateMasterEntity>, List<RoundStatusModel>)> GetAllModels();
	}
}
