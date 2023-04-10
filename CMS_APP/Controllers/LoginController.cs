using CMS.Interfaces;
using CMS.Models;
using CMS.Services;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json;


namespace CMS.Controllers
{
    public class LoginController : Controller
    {
		private readonly IUserService _userService; 
        private readonly IMasterData _masterdata;
		private readonly IWebHostEnvironment _hostEnvironment;
        public LoginController(IUserService userService, IWebHostEnvironment hostEnvironment, IMasterData masterdata)
        {
            _userService = userService;
            _hostEnvironment = hostEnvironment;
            _masterdata = masterdata;
		}
        [AllowAnonymous]
        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Login(UserLoginEntity objUserLogin)
        {
            if(ModelState.IsValid)
            {
                var response = _userService.AuthenticateLogin(objUserLogin);
				string Username = objUserLogin.Email;
				
				if (response != null)
                {
					HttpContext.Session.SetString("Username", Username);
					var masterDataResponse = _masterdata.AllMasterDatalist();

                    //do for all the master table .
					var masterDataList = JsonConvert.DeserializeObject<AllMasterDataModel>(masterDataResponse.Content);

					var DesignationData = JsonConvert.SerializeObject(masterDataList.DesignationData);
					HttpContext.Session.SetString("DesignationList",DesignationData);

					var TechnologyData = JsonConvert.SerializeObject(masterDataList.TechnologyData);
					HttpContext.Session.SetString("TechnologyList",TechnologyData);

					var ReasonData = JsonConvert.SerializeObject(masterDataList.ReasonData);
					HttpContext.Session.SetString("ReasonDataList",ReasonData);

					var RoleData = JsonConvert.SerializeObject(masterDataList.RoleData);
					HttpContext.Session.SetString("RoleDataList",RoleData);

					var RoundData = JsonConvert.SerializeObject(masterDataList.RoundData);
					HttpContext.Session.SetString("RoundList",RoundData);

/*                    var InterviewerData = JsonConvert.SerializeObject(masterDataList.InterviewerData);
                    HttpContext.Session.SetString("DesignationList", InterviewerData);

                    var InterviewData = JsonConvert.SerializeObject(masterDataList.InterviewData);
                    HttpContext.Session.SetString("DesignationList", InterviewData);*/

                    return RedirectToAction("HomePage", "Home");
                }
                else
                {
                    return View();
                }
            }
            else
            {
                return View();
            }
        }

        [AllowAnonymous]
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            TempData["Message"] = "You have been successfully logged out.";
            return RedirectToAction("Login", "Login");
        }
    }
}
