using CMSWebApi.Models;

namespace CMSWebApi.Interfaces
{
    public interface IGetAllDashboardData_Interface
    {
        public Task<DashboardData> GetDashboardData();
    }
}
