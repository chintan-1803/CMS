using System.Collections.Generic;

namespace CMS.Models
{
	public class InterviewerModel
	{
		public int InterviewerId { get; set; }

		public string? FirstName { get; set; }

		public string ?LastName { get; set; }
		public int ?TechnologyId { get; set; }
		public string? TechnologyName { get; set; }
		public string ?Email { get; set; }
		public string? Password { get; set; }
		public float ?YearOfExperience { get; set; }
		public int ?DesignationId { get; set; }
		public string? Designation { get; set; }
		public int ?TotalInterviewsConducted { get; set; }

		public string? create_User { get; set; }
		public DateTime? create_Date { get; set; }
		public string? change_user { get; set; }
		public DateTime? change_Date { get; set; }
		public bool IsDeleted { get; set; } = false;
	}

    public class InterviewerViewModel
    {
        public List<InterviewerModel>? Interviewers { get; set; }
        public AllPaginationModel? PaginationModel { get; set; }
    }
}
