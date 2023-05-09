using CMS.Models;

namespace CMS.ApplicationHelpers
{
    public class WebApiRelativeURLs
    {
        /// <summary>
        /// Base URL based on environment is set here: Refer program.cs for set or change 
        /// </summary>
        public static string BaseURL = string.Empty;

        public const string LoginPath = "/LoginApi/authenticate";

        public const string DesignationPath = "/Designation/Designation";

        public const string AddDesignation = "/Designation/AddDesignation";

        public const string UpdateDesignation = "/Designation/UpdateDesignation";

		public const string DeleteDesignation = "/Designation/DeleteDesignation";

		//Reason

		public const string ReasonPath = "/Reason/Reason";

        public const string AddReason = "/Reason/AddReason";

        public const string UpdateReason = "/Reason/UpdateReason";

		public const string DeleteReason = "/Reason/DeleteReason";


		//Role

		public const string RolePath = "/Role/Role";

        public const string AddRole = "/Role/AddRole";

        public const string UpdateRole = "/Role/UpdateRole";

		public const string DeleteRole = "/Role/DeleteRole";

		//Round

		public const string RoundPath = "/Round/Round";

        public const string AddRound = "/Round/AddRound";

        public const string UpdateRound = "/Round/UpdateRound";

		public const string DeleteRound = "/Round/DeleteRound";

		//Technology

		public const string TechnologyPath = "/Technology/Technology";

        public const string AddTechnology = "/Technology/AddTechnology";

        public const string UpdateTechnology = "/Technology/UpdateTechnology";

		public const string DeleteTechnology = "/Technology/DeleteTechnology";

        //MasterData Api
		public const string MasterDatalist = "/MasterData/AllMasterDatalist";

	
        //Interviewer

        public const string InterviewerPath = "/Interviewer/Interviewer";

        public const string AddInterviewer = "/Interviewer/AddInterviewer";

        public const string UpdateInterviewer = "/Interviewer/UpdateInterviewer";

        public const string DeleteInterviewer = "/Interviewer/DeleteInterviewer";

        //Candidate

		public const string insertCandidates = "/Candidate/AddCandidates";

        public const string candidateList = "/Candidate/Candidatelist";

		//Interview

		public const string InterviewPath = "/Interview/Interview";

		public const string AddInterview = "/Interview/AddInterviewData";

		public const string UpdateInterview = "/Interview/UpdateInterviewData";

		public const string DeleteInterview = "/Interview/DeleteInterviewData";

        //Dashboard

        public const string Dashboarddata = "/Dashboard";

		//Interview Round

		public const string InterviewRoundPath = "/InterviewRound/InterviewRound";

		public const string AddInterviewRound = "/InterviewRound/AddInterviewRound";

		public const string UpdateInterviewRound = "/InterviewRound/UpdateInterviewRound";

		public const string DeleteInterviewRound = "/InterviewRound/DeleteInterviewRound";

		//Round Status

		public const string RoundStatusPath = "/RoundStatus/RoundStatus";

		public const string AddRoundStatus = "/RoundStatus/AddRoundStatus";

		public const string UpdateRoundStatus = "/RoundStatus/UpdateRoundStatus";

		public const string DeleteRoundStatus = "/RoundStatus/DeleteRoundStatus";

	}
}
