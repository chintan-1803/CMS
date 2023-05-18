using CMS.Interfaces;
using CMS.Models;
using CMS.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Identity;
using System.Threading.Channels;


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
            if (ModelState.IsValid)
            {
                var response = _userService.AuthenticateLogin(objUserLogin);

                if (response.ResultMessage == "Successful")
                {
                    //authorization code

                    ClaimsIdentity identity = null;
                    bool isAuthenticate = false;
                    if (response.UserRoleName == "Admin")
                    {
                        identity = new ClaimsIdentity(new[]
                        {
                            new Claim(ClaimTypes.Name,response.UserFullName),
                              new Claim(ClaimTypes.Role, "Admin")
                             }, CookieAuthenticationDefaults.AuthenticationScheme);
                        isAuthenticate = true;
                    }
                    if ((response.UserRoleName == "Interviewer"))
                    {
                        identity = new ClaimsIdentity(new[]
                        {
                            new Claim(ClaimTypes.Name, response.UserFullName),
                             new Claim(ClaimTypes.Role,"Interviewer")
                             }, CookieAuthenticationDefaults.AuthenticationScheme);
                        isAuthenticate = true;
                    }

                    if (isAuthenticate)
                    {
                        var principal = new ClaimsPrincipal(identity);
                        var login = HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal);


                        string Username = objUserLogin.Email;
                        HttpContext.Session.SetString("Username", Username);
                        var masterDataResponse = _masterdata.AllMasterDatalist();

                        //do for all the master table .
                        var masterDataList = JsonConvert.DeserializeObject<AllMasterDataModel>(masterDataResponse.Content);

                        var DesignationData = JsonConvert.SerializeObject(masterDataList.DesignationData);
                        HttpContext.Session.SetString("DesignationList", DesignationData);

                        var TechnologyData = JsonConvert.SerializeObject(masterDataList.TechnologyData);
                        HttpContext.Session.SetString("TechnologyList", TechnologyData);

                        var ReasonData = JsonConvert.SerializeObject(masterDataList.ReasonData);
                        HttpContext.Session.SetString("ReasonDataList", ReasonData);

                        var RoleData = JsonConvert.SerializeObject(masterDataList.RoleData);
                        HttpContext.Session.SetString("RoleDataList", RoleData);

                        var RoundData = JsonConvert.SerializeObject(masterDataList.RoundData);
                        HttpContext.Session.SetString("RoundList", RoundData);

                        var InterviewStatusData = JsonConvert.SerializeObject(masterDataList.InterviewStatusData);
                        HttpContext.Session.SetString("InterviewStatusList", InterviewStatusData);

                        var InterviewerData = JsonConvert.SerializeObject(masterDataList.InterviewerData);
                        HttpContext.Session.SetString("InterviewerList", InterviewerData);

                        var CandidateMasterData = JsonConvert.SerializeObject(masterDataList.CandidateMasterData);
                        HttpContext.Session.SetString("CandidateMasterList", CandidateMasterData);

						var RoundStatusData = JsonConvert.SerializeObject(masterDataList.RoundStatusData);
						HttpContext.Session.SetString("RoundStatusList", RoundStatusData);

						return RedirectToAction("HomePage", "Home");
                    }
                    else
                    {
                        return View();
                    }
                }
                else
                {
                    TempData["Message"] = "Login unsuccessful";
                    return View();
                }
            }
            else
            {
                return View();
            }
        }

		[AllowAnonymous]
		[HttpGet]
        public IActionResult ForgotPassword()
        {
            return View();
        }

	
		[HttpPost]
        public IActionResult ForgotPassword(string email)
        {
            if (!string.IsNullOrEmpty(email))
            {
                var response = _userService.UserEmail(email);

                if (!response.IsSuccessful)
                {
                    TempData["error-message"] = "User is not authenticated. Please provide a valid email address.";
					return View();
				}

            }

            return RedirectToAction(nameof(ResetPasswordConfirmation));
        }
		[HttpGet]
        public IActionResult ResetPasswordConfirmation()
        {
            return View();
        }

		//  reset  Password

		[AllowAnonymous]
		[HttpGet]
        public IActionResult ResetPassword(string i)
		{
			try
			{
                var userId = (Encryption.DecryptString(i));
                
                var forgotPassword = new ForgotPassword
                {
                    EmailId = userId
                };
                return View(forgotPassword);

            }
			catch (Exception ex)
			{
				
				return BadRequest(new { message = ex.Message });
			}
			

		}

		[HttpPost]
        public IActionResult ResetPassword(ForgotPassword resetPassword)
        {
            try
            {
               
                var response = _userService.ResetPassword(resetPassword);
                if (response.Content == "\" Password has been changed successfully.\"")
                {
                    TempData["Success-Message"] = "Congratulations!Your password has been changed successfully.";
                    return View(resetPassword);
                    //return Json(new { success = true, message = "Password has been changed successfully." });
                }

                if (response != null)
                {
                    return Json(new { success = false});
                }
                
            }
            catch (Exception ex)
            {

                return BadRequest(new { message = ex.Message });
            }
            return BadRequest(new { isSuccess = false });

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
