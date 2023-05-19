namespace CMS.Models
{
    public class TechnologyModel
    {
        public int TechnologyId { get; set; }
        public string? TechnologyName { get; set; }
        public bool? IsActive { get; set; } = true;
        public string? Description { get; set; }
        public string? create_User { get; set; }
        public DateTime? create_Date { get; set; }
        public string? change_user { get; set; }
        public DateTime? change_Date { get; set; }
        public bool ?IsDelete { get; set; } = false;
    }
	public class TechnologyViewModel
	{
		public List<TechnologyModel>? Technologies { get; set; }
		public AllPaginationModel? PaginationModel { get; set; }
	}
}
