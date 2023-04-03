﻿using CMS.Interfaces;
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

	/*	[AllowAnonymous]*/
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
				//string change_user = objUserLogin.Email;

               // HttpContext.Session.SetString("Username", Username);
				//HttpContext.Session.SetString("change_user", change_user);

				if (response != null)
                {
 
					HttpContext.Session.SetString("Username", Username);

					var masterDataResponse = _masterdata.AllMasterDatalist();
					//var masterDataList = JsonConvert.DeserializeObject<AllMasterDataModel>(masterDataResponse.Content);

                    //do for all the master table .
					var masterDataList = JsonConvert.DeserializeObject<AllMasterDataModel>(masterDataResponse.Content);
                    //var designation = masterDataList.DesignationData;
					//var designation 
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

					// Store the serialized list of MasterData objects in the session
					//var jsonData = JsonConvert.SerializeObject(masterDataResponse.Content);
					//var masterDataList = JsonConvert.DeserializeObject<AllMasterDataModel>(jsonData.);
					//HttpContext.Session.SetString("masterDatalist", jsonData);

					//var masterDataResponse = _masterdata.AllMasterDatalist();
					//var jsonData = JsonConvert.SerializeObject(masterDataResponse.Content);
					//HttpContext.Session.SetString("masterDatalist", jsonData);

					//var masterDatalist = HttpContext.Session.GetString("masterDatalist");
					//// If the session variable is not null or empty, deserialize it into a list of objects
					//if (!string.IsNullOrEmpty(masterDatalist))
					//{
					//	var masterDatalistObj = JsonConvert.DeserializeObject<List<MasterData>>(masterDatalist);
					//	// Do something with the masterDatalistObj here
					//}

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

        /*[AllowAnonymous]*/
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            TempData["Message"] = "You have been successfully logged out.";
            return RedirectToAction("Login", "Login");
        }
    }
}
