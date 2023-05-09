using Dapper;
using System.Collections.Generic;
using System.Data.Common;
using System.Data;
using CMSWebApi.Models;

namespace CMSWebApi.Dapper
{
    public interface IDapper
    {
        DbConnection GetDbconnection();
        T Get<T>(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure);
        List<T> GetAll<T>(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure);
        int Execute(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure);
        T Insert<T>(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure);

		public (List<DesignationModel>, List<ReasonModel>, List<RoleModel>, List<RoundModel>, List<TechnologyModel>, List<InterviewStatusModel>, List<InterviewerModel>, List<CandidateMasterEntity>, List<RoundStatusModel>) GetAllMasterData(string sp, DynamicParameters parms, CommandType commandType = CommandType.StoredProcedure);

	}
}
