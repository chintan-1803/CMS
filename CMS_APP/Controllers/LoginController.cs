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

                if (response != null)
                {

                }
                else
                {

                }
            }

            return View();
        }
    }
}
