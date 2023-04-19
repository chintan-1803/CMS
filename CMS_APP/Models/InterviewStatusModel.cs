namespace CMS.Models
{
    public class InterviewStatusModel
    {
        public int StatusID { get; set; }
        public string? Name { get; set; }
        public string? create_user { get; set; }
        public DateTime? create_date { get; set; }
        public string? change_user { get; set; }
        public DateTime? change_date { get; set; }
        public bool? IsDeleted { get; set; }
    }
}
