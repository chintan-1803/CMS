using CMSWebApi.Interfaces;
using CMS.Models;
using CMSWebApi.Dapper;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using ILogger = Serilog.ILogger;
using Microsoft.AspNetCore.Authorization;

namespace CMSWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class LoginApiController : ControllerBase
    {
        private readonly IUserApiService _userApiService;
        private readonly ILogger _logger;
        private readonly IDapper _dapper;

        public LoginApiController(IUserApiService userApiService, ILogger logger, IDapper dapper)
        {
            _userApiService = userApiService;
            _logger = logger;
            _dapper = dapper;
        }

        /*[AllowAnonymous]*/
        [HttpPost("authenticate")]
        public IActionResult Authenticate(WebApiUserLoginEntity model)
        {
            try
            {
                var response = _userApiService.AuthenticateUser(model);

                if (response == null)
                {
                    return BadRequest(new { message = "Username or password is incorrect" });
                }

                return Ok(response);
            }
            catch (Exception ex)
            {
                _logger.Error(ex, "Post UsersController Authenticate");
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}
