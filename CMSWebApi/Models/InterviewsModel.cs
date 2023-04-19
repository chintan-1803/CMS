namespace CMSWebApi.Models
{
    public class InterviewsModel
    {
		public int InterviewId { get; set; }
		public int CandidateId { get; set; }
		public string? CandidateFName { get; set; }
		public string? CandidateLName { get; set; }
		public int InterviewerId { get; set; }
		public string? InterviewerFName { get; set; }
		public string? InterviewerLName { get; set; }
		public int TechnologyId { get; set; }
		public string? TechnologyName { get; set; }
		public bool? IsOnline { get; set; }
		public string? InterviewURL { get; set; }
		public DateTime ScheduledTime { get; set; }
		public int StatusID { get; set; }
		public string? Status { get; set; }
		public string? Description { get; set; }
		public int ?ReasonID { get; set; }
		public string? Reason { get; set; }
		public string? create_user { get; set; }
		public DateTime? create_date { get; set; }
		public string? change_user { get; set; }
		public DateTime? change_date { get; set; }
		public bool? IsDeleted { get; set; } = false;
	}
}
