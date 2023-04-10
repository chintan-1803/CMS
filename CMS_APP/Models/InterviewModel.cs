namespace CMS.Models
{
    public class InterviewModel
    {
        public int InterviewId { get; set; }
        public int CandidateId { get; set; }
        public int InterviewerId { get; set; }
        public int TechnologyId { get; set; }
        public bool? IsOnline { get; set; }
        public string? InterviewURL { get; set; }
        public DateTime ScheduledTime { get; set; }
        public int StatusID { get; set; }
        public string? Description { get; set; }
        public int ReasonID { get; set; }
        public string? create_user { get; set; }
        public DateTime? create_date { get; set; }
        public string? change_user { get; set; }
        public DateTime? change_date { get; set; }
        public bool? IsDeleted { get; set; }
    }
}
