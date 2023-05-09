using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
    public class DashboardController : Controller
    {
        private readonly IGetAllDashboardData_Interface _GetAllDashboardData;
        private readonly IDapper _dapper;
        public DashboardController(IGetAllDashboardData_Interface GetAllDashboardData, IDapper dapper)
        {
            _GetAllDashboardData = GetAllDashboardData;
            _dapper = dapper;
        }

        [HttpGet("Dashboard")]
        public IActionResult Dashboard()
        {
            try
            {
                var responseTask = _GetAllDashboardData.GetDashboardData();
                //responseTask.Wait();
                var response = responseTask.Result;

                if (response == null)
                {
                    return BadRequest(new { message = "NULL VALUE" });
                }

                return Ok(response);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}
