using System.Runtime.CompilerServices;

namespace CMSWebApi.Models
{
    public class CandidateMasterEntity
	{
		public int CandidateId { set; get; } // This is Primary Key of Candidate Master.
		public string ?firstName { set; get; }
		public string ?lastName { set; get; }
		public string ?Email { set; get; }
		public string? ContactNo { set; get; }
		public int ?TechnologyId { set; get; }

		public string ? TechnologyName { set; get; }//Select multiple dropdown of all technology.
		public string ?Skills { set; get; }  //Select multiple dropdown of all skills based on technology.
											//public string? PrimaryLocation { set; get; }//This property is required when PrimaryLocation is not Ahmedabad.
		public bool ?AgreeForChangeLocation { set; get; }
		public string ?City { set; get; }
		public string? State { set; get; }
		public string ?Address { set; get; }
		public decimal ?PR_10 { set; get; }
		public decimal? PR_12 { set; get; }
		public string ?areaofstudy { set; get; }
		public decimal? College_CGPA { set; get; }
		public bool backlog { set; get; }
		//This property is required when candidate is not fresher.
		public bool IsExperience { set; get; }
		public decimal? TotalExperience { set; get; }
		//public string? NoticePeriod { set; get; }
		public decimal? CurrentCTC { set; get; }
		public decimal? ExpectedCTC { set; get; }
		public string? ReasoneForChange { set; get; }
		public string? file_type { set; get; }
		public string? Reference { set; get; }
		public string ?resume { set; get; }

		//This 4 property is Comman for all model.
		public string? create_User { get; set; }
		public DateTime? create_Date { get; set; }
		public string? Change_user { get; set; }
		public DateTime? change_Date { get; set; }
		public bool IsDeleted { get; set; } = false;
	}
}
