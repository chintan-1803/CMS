using CMS.ApplicationHelpers;
using CMSWebApi.Dapper;
using CMSWebApi.DataHelper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Microsoft.Extensions.Options;

namespace CMSWebApi.Services
{
	public class AllMasterData_Service : IAllMsaterData_Interface
	{

		private readonly AppSettings _appSettings;
		private readonly IDapper _dapper;
		private readonly ICipherService _cipherService;

        public AllMasterData_Service(IOptions<AppSettings> appSettings, IDapper dapper, ICipherService cipherService)
        {
			_appSettings = appSettings.Value;
			_dapper = dapper;
			_cipherService = cipherService;
		}

        public Task<(List<DesignationModel>, List<ReasonModel>, List<RoleModel>, List<RoundModel>, List<TechnologyModel>, List<InterviewStatusModel>, List<InterviewerModel>, List<CandidateMasterEntity>)> GetAllModels()
        {
            var result = _dapper.GetAllMasterData(StoreProcedureName.GetAllMasterData, null, System.Data.CommandType.StoredProcedure);
            return Task.FromResult(result);
        }

    }
}
