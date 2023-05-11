namespace CMS.Models
{
    public class InterviewRoundModel
    {
        public int interviewRoundId { get; set; }
        public int interviewId { get; set; }
        public int? roundNumberId { get; set; }
        public string? Round_Name { get; set; }
        public int? roundStatusId { get; set; }
        public string? StatusName { get; set; }
        public DateTime? scheduledAt { get; set; }
        public string? roundFeedback { get; set; }
        public string? create_user { get; set; }
        public DateTime? create_date { get; set; }
        public string? change_user { get; set; }
        public DateTime? change_date { get; set; }
        public bool? IsDeleted { get; set; } = false;
    }
}
