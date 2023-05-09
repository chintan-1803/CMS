namespace CMSWebApi.Models
{
    public class DashboardData
    {
        public int totalCandidates { get; set; }

        public int totalInterview { get; set; }
        public int completeInterview { get; set; }
        public int pendingInterview { get; set; }
        public int cancleInterview { get; set; }
        public int scheduledInterview { get; set; }
    }
}
