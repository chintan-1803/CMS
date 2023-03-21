namespace CMS.Models
{
    public class TechnologyModel
    {
        public int TechnologyId { get; set; }
        public string? TechnologyName { get; set; }
        public bool ?IsActive { get; set; }
        public string? Discription { get; set; }
        public string? create_User { get; set; }
        public DateTime? create_Date { get; set; }
        public string? change_user { get; set; }
        public DateTime? change_Date { get; set; }
        public bool ?IsDelete { get; set; } = false;
    }
}
