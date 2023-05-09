using CMS.Interfaces;
using CMS.Models;
using CMS.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CMS.Controllers
{
    [Authorize(Roles = "Interviewer,Admin")]

    public class HomeController : Controller
    {
        private readonly IDashboardDatalist _dashboardData;
        public HomeController(IDashboardDatalist dashboardData)
        {
            _dashboardData = dashboardData;
        }
        public IActionResult Index()
        {
           
            return View();
        }

        public IActionResult HomePage()
        {
            var response = _dashboardData.DashboardData();
            var designationList = JsonConvert.DeserializeObject<DashboardData>(response.Content);
            return View(designationList);
        }
    }
}
