namespace CMS.Models
{
    public class ReasonModel
    {
        public int ReasonID { get; set; }
        public string? Reason { get; set; }
        public string? create_User { get; set; }
        public DateTime? create_Date { get; set; }
        public string? Change_user { get; set; }
        public DateTime? change_Date { get; set; }
        public bool IsDelete { get; set; }
    }
	public class ReasonViewModel
	{
		public List<ReasonModel>? Reasons { get; set; }
		public AllPaginationModel? PaginationModel { get; set; }
	}
}
