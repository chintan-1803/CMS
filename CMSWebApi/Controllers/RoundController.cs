﻿using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RoundController : Controller
    {
        private readonly IUserApiService _userApiService;
        //private readonly ILogger _logger;
        private readonly IDapper _dapper;
        public RoundController(IUserApiService userApiService, IDapper dapper)
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
                var response = await _userApiService.GetAllRole();

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
