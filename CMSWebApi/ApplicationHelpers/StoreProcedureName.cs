namespace CMS.ApplicationHelpers
{
    public class StoreProcedureName
    {
        public readonly static string AuthenticateUserExistsORNot = "sp_AuthenticateUserLogin";

        //add stored procedure name

        public readonly static string DesignationMasterData = "GetAllDesignationMasterData";

        public readonly static string ReasonMasterData = "GetAllReasonMasterData";

        public readonly static string TechnologyMasterData = "GetAllTechnologyMasterData";

        public readonly static string RoleMasterData = "GetAllRoleMasterData";

        public readonly static string RoundMasterData = "GetAllRoundMasterData";

        //Designation

        public readonly static string InsertDesignation = "sp_Insert_DesignationMaster";

        public readonly static string UpdateDesignation = "sp_Update_DesignationMaster";

        public readonly static string DeleteDesignation = "sp_Delete_DesignationMaster";

        // Reason
        public readonly static string InsertReason = "sp_Insert_ReasonMaster";

        public readonly static string UpdateReason = "sp_Update_ReasonMaster";

        public readonly static string DeleteReason = "sp_Delete_ReasonMaster";

        //Technology
        public readonly static string InsertTechnology = "sp_Insert_TechnologyMaster";

        public readonly static string UpdateTechnology = "sp_Update_TechnologyMaster";

        public readonly static string DeleteTechnology = "sp_Delete_TechnologyMaster";

        //Role
        public readonly static string InsertRole = "sp_Insert_RoleMaster";

        public readonly static string UpdateRole = "sp_Update_RoleMaster";

        public readonly static string DeleteRole = "sp_Delete_RoleMaster";

        //Round
        public readonly static string InsertRound = "sp_Insert_RoundMaster";

        public readonly static string UpdateRound = "sp_Update_RoundMaster";

        public readonly static string DeleteRound = "sp_Delete_RoundMaster";




    }
}
