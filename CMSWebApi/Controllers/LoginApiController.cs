using CMSWebApi.Interfaces;
using CMS.Models;
using CMSWebApi.Dapper;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using ILogger = Serilog.ILogger;
using Microsoft.AspNetCore.Authorization;
using Newtonsoft.Json;
using System.Runtime.InteropServices;
using CMSWebApi.Models;
using Azure;

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

				if (response.ResultMessage == "Successful")
				{
					return Ok(response);
				}
				else
				{
					return BadRequest(response);
				}
			}
			catch (Exception ex)
			{
				_logger.Error(ex, "Post UsersController Authenticate");
				return BadRequest(new { message = ex.Message });
			}
		}

		[HttpPost("SendResetPasswordLinkToUser")]
		public IActionResult SendResetPasswordLinkToUser(string email)
		{
			try
			{
				AuthenticateResponse customerUserModel = new AuthenticateResponse();
				customerUserModel = _userApiService.UserByEmail(email);   //service file
				EmailConfiguration emailConfiguration = new EmailConfiguration();
				if (customerUserModel.ResultMessage == "Successful")
				{
					var rootPath = "https://localhost:7129";
					var body = "";
					string userId = Uri.EscapeDataString(Encryption.EncryptString(customerUserModel.EmailId.ToString()));
					//string timeStemp = Uri.EscapeDataString(Encryption.EncryptString(DateTime.UtcNow.ToString()));
					var url = rootPath + "/Login/ResetPassword?i=" + userId;
					body += "To reset your CMS password please click the following link: " + url;
					_userApiService.SendEmail(customerUserModel.EmailId, "CMS - Reset Password URL", body, emailConfiguration);
					return Ok(new { isSuccess = true });
				}
				else
				{
					return BadRequest("Invalid EmailId");
				}

			}
			catch (Exception ex)
			{
				_logger.Error(ex, "Post UsersController Authenticate");
				return BadRequest(new { message = ex.Message });
			}
			return BadRequest(new { isSuccess = false });
		}

        [HttpPost("ResetPassword")]
        public IActionResult ResetPassword (ForgotPassword forgotPassworddata)
		{

            var response = _userApiService.ResetPasswordData(forgotPassworddata);
            if (response < 0)
            {
                return Ok("Unsuccessful");
            }
            else if (response > 0)
            {
                return Ok(" Password has been changed successfully.");
            }
            return Ok(new { isSuccess = true });
        }

	}


}
