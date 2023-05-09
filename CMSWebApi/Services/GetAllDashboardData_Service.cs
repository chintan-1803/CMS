using CMS.ApplicationHelpers;
using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;

namespace CMSWebApi.Services
{
    public class GetAllDashboardData_Service: IGetAllDashboardData_Interface
    {
        private readonly IDapper _dapper;
        public GetAllDashboardData_Service(IDapper dapper)
        {
            _dapper = dapper;
        }

        public Task<DashboardData> GetDashboardData()
        {
            var model = _dapper.Get<DashboardData>(StoreProcedureName.GetAllDashboardData, null, System.Data.CommandType.StoredProcedure);
            return Task.FromResult(model);
        }
    }
}
