namespace CMS.Models
{
    public class AllPaginationModel
    {
        public List<CandidateMasterEntity>? candidateMasterEntities { get; set; }
        public List<InterviewModel>? interviewModel { get; set; }
        public List<InterviewerModel>? interviewerModel { get; set; }
		public List<DesignationModel>? designationModel { get; set; }
		public List<ReasonModel>? reasonModel { get; set; }
		public List<RoleModel>? roleModel { get; set; }
		public List<RoundModel>? roundModel { get; set; }
		public List<TechnologyModel>? technologyModel { get; set; }
		public int TotalItems { get; set; }
        public int PageSize { get; set; }
        public int CurrentPage { get; set; }
        public int TotalPages { get; set; }
        public int FirstPage
        {
            get { return 1; }
        }
        public int LastPage
        {
            get { return TotalPages; }
        }
        
    }
}
