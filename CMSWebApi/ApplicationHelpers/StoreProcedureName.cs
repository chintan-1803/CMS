namespace CMS.ApplicationHelpers
{
    public class StoreProcedureName
    {
        public readonly static string AuthenticateUserExistsORNot = "sp_AuthenticateUserLogin";

        public readonly static string GetUserByEmail = "sp_GetUserByEmail";
        public readonly static string ResetPassword = "sp_ResetPassword";


        //add stored procedure name

        public readonly static string DesignationMasterData = "GetAllDesignationMasterData";

        public readonly static string ReasonMasterData = "GetAllReasonMasterData";

        public readonly static string TechnologyMasterData = "GetAllTechnologyMasterData";

        public readonly static string RoleMasterData = "GetAllRoleMasterData";

        public readonly static string RoundMasterData = "GetAllRoundMasterData";

        public readonly static string InterviewerData = "GetAllInterviewersData";

        public readonly static string InterviewsData = "GetAllInterviewsData";

        public readonly static string InterviewStatusData = "GetAllInterviewStatusData";

		public readonly static string InterviewRoundsData = "GetAllInterviewRoundsData";

		public readonly static string RoundStatusData = "GetAllRoundStatusData";

		//Designation
		public readonly static string PageDesignationMasterData = "PageDesignationMaster";

        public readonly static string InsertDesignation = "sp_Insert_DesignationMaster";

        public readonly static string UpdateDesignation = "sp_Update_DesignationMaster";

        public readonly static string DeleteDesignation = "sp_Delete_DesignationMaster";

        // Reason
        public readonly static string PageReasonMasterData = "PageReasonMaster";

        public readonly static string InsertReason = "sp_Insert_ReasonMaster";

        public readonly static string UpdateReason = "sp_Update_ReasonMaster";

        public readonly static string DeleteReason = "sp_Delete_ReasonMaster";

        //Technology
        public readonly static string PageTechnologyMasterData = "PageTechnologyMaster";

        public readonly static string InsertTechnology = "sp_Insert_TechnologyMaster";

        public readonly static string UpdateTechnology = "sp_Update_TechnologyMaster";

        public readonly static string DeleteTechnology = "sp_Delete_TechnologyMaster";

        //Role
        public readonly static string PageRoleMasterData = "PageRoleMaster";

        public readonly static string InsertRole = "sp_Insert_RoleMaster";

        public readonly static string UpdateRole = "sp_Update_RoleMaster";

        public readonly static string DeleteRole = "sp_Delete_RoleMaster";

        //Round
        public readonly static string PageRoundMasterData = "PageRoundMaster";

        public readonly static string InsertRound = "sp_Insert_RoundMaster";

        public readonly static string UpdateRound = "sp_Update_RoundMaster";

        public readonly static string DeleteRound = "sp_Delete_RoundMaster";

        //Interviewer
        public readonly static string InsertInterviewer = "sp_Insert_Interviewers";

        public readonly static string UpdateInterviewer = "sp_Update_Interviewers";

        public readonly static string DeleteInterviewer = "sp_Delete_Interviewer";

        // Sp for GetAllMasterData 

		public readonly static string GetAllMasterData = "GetAllMasterData";

        // Interviews
        public readonly static string InsertInterview = "sp_Insert_Interviews";

        public readonly static string UpdateInterview = "sp_Update_Interviews";

        public readonly static string DeleteInterview = "sp_Delete_Interviews";


        // Interview Status
        public readonly static string InsertInterviewStatus = "sp_Insert_InterviewStatus";

        public readonly static string UpdateInterviewStatus = "sp_Update_InterviewStatus";

        public readonly static string DeleteInterviewStatus = "sp_Delete_InterviewStatus";

        public readonly static string insertCandidateData = "sp_Insert_Candidate";

		public readonly static string CandidateData = "GetAllCandidatesData";

        //AllDashboarddata
        public readonly static string GetAllDashboardData = "GetAllDashboardData";


		//Interview Rounds
		public readonly static string InsertInterviewRound = "sp_Insert_interviewRounds";

		public readonly static string UpdateInterviewRound = "sp_Update_InterviewRound";

		public readonly static string DeleteInterviewRound = "sp_Delete_InterviewRound";

		//Round Status
		public readonly static string InsertRoundStatus = "sp_Insert_RoundStatus";

		public readonly static string UpdateRoundStatus = "sp_Update_RoundStatus";

		public readonly static string DeleteRoundStatus = "sp_Delete_RoundStatus";

	}
}
