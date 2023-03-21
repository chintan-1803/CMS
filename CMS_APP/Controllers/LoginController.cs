using CMS.Interfaces;
using CMS.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Hosting;

namespace CMS.Controllers
{
    public class LoginController : Controller
    {
        private readonly IUserService _userService;
        private readonly IWebHostEnvironment _hostEnvironment;

        public LoginController(IUserService userService, IWebHostEnvironment hostEnvironment)
        {
            _userService = userService;
            _hostEnvironment = hostEnvironment;
        }

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
				string create_User = objUserLogin.Email;
				//string change_user = objUserLogin.Email;

                HttpContext.Session.SetString("create_User", create_User);
				//HttpContext.Session.SetString("change_user", change_user);

				if (response != null)
                {
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
    }
}
