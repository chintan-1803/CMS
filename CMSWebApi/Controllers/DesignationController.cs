using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;
using System.Reflection;

namespace CMSWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DesignationController : Controller
    {
        private readonly IUserApiService _userApiService;
        //private readonly ILogger _logger;
        private readonly IDapper _dapper;
        public DesignationController(IUserApiService userApiService,  IDapper dapper)
        {
            _userApiService = userApiService;
           // _logger = logger;
            _dapper = dapper;
        }

        [HttpGet("Index")]
        public async Task<IActionResult> Index()
        {

            try
            {
                var response = await _userApiService.GetAllDesignation();

                if (response == null)
                {
                    return BadRequest(new { message = "NULL VALUE" });
                }

                return Ok(response);
            }
            catch (Exception ex)
            {
                //_logger.Error(ex, "Post UsersController Authenticate");
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}
