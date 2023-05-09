namespace CMSWebApi.Models
{
    public class RoundStatusModel
    {
        public int roundStatusId { get; set; }
        public string? StatusName { get; set; }
        public string? create_user { get; set; }
        public DateTime? create_date { get; set; }
        public string? change_user { get; set; }
        public DateTime? change_date { get; set; }
        public bool? IsDeleted { get; set; } = false;
    }
}
