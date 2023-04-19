using CMSWebApi.Models;

namespace CMS.Models
{
	public class AllMasterDataModel
	{
        public List<DesignationModel>? DesignationData { get; set; }
        public List<ReasonModel> ReasonData { get; set; }
        public List<RoleModel> RoleData { get; set; }
        public List<RoundModel> RoundData { get; set; }
        public List<TechnologyModel> TechnologyData { get; set; }
        public List<InterviewStatusModel> InterviewStatusData { get; set; }
        public List<InterviewerModel> InterviewerData { get; set; }
        public List<CandidateMasterEntity> CandidateMasterData { get; set; }
    }
}
