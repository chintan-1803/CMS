namespace CMSWebApi.Models
{
    public class InterviewerModel
    {
        public int InterviewerId { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string Technology { get; set; }
        public string Email { get; set; }

        public int YearOfExperiance { get; set; }
        public string Designation { get; set; }
        public int TotalInterviewsConducted { get; set; }

        public string create_User { get; set; }
        public DateTime create_Date { get; set; }
        public string Change_user { get; set; }
        public DateTime change_Date { get; set; }
        public bool IsDelete { get; set; }
    }
}
