using System.Runtime.CompilerServices;

namespace CMS.Models
{
    public class CandidateMasterEntity
    {
        public int CandidateId { set; get; } // This is Primary Key of Candidate Master.
        public string? FirstName { set; get; }
        public string? LastName { set; get; }
        public double? ContactNo { set; get; }
        public string? CandidateImage { set; get; }

        public string? Technology { set; get; } //Select multiple dropdown of all technology.

        public string? SkillsId { set; get; }  //Select multiple dropdown of all skills based on technology.


        public string? PrimaryLocation { set; get; }

        //This property is required when PrimaryLocation is not Ahmedabad.
        public string? AgreeForChangeLocation { set; get; }


        public int CityId { set; get; }
        public int StateId { set; get; }
        public string? Address { set; get; }


        //This property is required when candidate is not fresher.
        public bool IsExperience { set; get; }
        public int TotalExperience { set; get; }
        public string? NoticePeriod { set; get; }
        public double CurrentCTC { set; get; }
        public double ExpectedCTC { set; get; }
        public string? ReasoneForChange { set; get; }


        //This property is required when candidate by Any Employee Refrence.
        public bool AnyRefrence  { set; get; }
        public int RefrenceId { set; get; }


        //This 4 property is Comman for all model.
        public int CreatedBy { set; get; }
        public DateTime CreatedDate { set; get; }
        public int UpdatedBy { set; get; }
        public DateTime UpdatedDate { set; get; }
    }
}
