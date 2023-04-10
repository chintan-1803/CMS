using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
	[Authorize]
	[ApiController]
	[Route("[controller]")]
	public class ReasonController : Controller
	{
		private readonly IReason_Interface _reasonService;
		private readonly IDapper _dapper;
		public ReasonController(IReason_Interface reasonService, IDapper dapper)
		{
			_reasonService = reasonService;
			_dapper = dapper;

		}

		#region Get method Of Reason wothout async
		[HttpGet("Reason")]
		public IActionResult Reason()
		{
			var responseTask = _reasonService.GetAllReason();
			//responseTask.Wait();
			var response = responseTask.Result;
			//if (response == null)
			//{
			//	return BadRequest(new { message = "NULL VALUE" });
			//}
			return Ok(response);
		}
		#endregion

		#region  AddReason
		[HttpPost("AddReason")]
		public IActionResult AddReason(ReasonModel reasonModel)
		{
			var response = _reasonService.AddReason(reasonModel);

			//if (response == null)
			//{
			//    return BadRequest(new { message = "FAILED TO ADD Reason" });
			//}
			if (response == "Unsuccessful")
			{
				return BadRequest(new { message = "Reason IS ALREADY EXISTS" });
			}
			return Ok("SUCCESS");
		}
		#endregion

		#region  UpdateReason
		[HttpPut("UpdateReason")]
		public IActionResult UpdateReason(ReasonModel reasonModel)
		{
			var response = _reasonService.UpdateReason(reasonModel);
			//if (response == 0 || response < 0)
			//{
			//  return BadRequest(new { message = "FAILED TO ADD REASON" });
			//}
			if (response < 0)
			{
				return Ok("Data already exists");
			}
			else if (response > 0)
			{
				return Ok("SUCCESS");
			}
			else
			{
				return Ok("Something went wrong");
			}
		}
		#endregion

		#region  DeleteReason
		[HttpPut("DeleteReason")]
		public IActionResult DeleteReason(ReasonModel Reason_ID)
		{
			var response = _reasonService.DeleteReasonByid(Reason_ID);

			//if (response == 0)
			//{
			//	return BadRequest(new { message = "FAILED TO DELETE REASON" });
			//}
			if (response > 0)
			{
				return Ok("SUCCESS");
			}
			else
			{
				return Ok("Something went wrong");
			}
		}
        #endregion

        #region GetReasonsByPage
        [HttpGet("paged")]
        public async Task<IActionResult> GetReasonsByPage(int pageNumber = 1, int rowsOfPage = 5)
        {
            var reasons = await _reasonService.GetReasonsByPage(pageNumber, rowsOfPage);
            return Ok(reasons);
        }
        #endregion
    }
}
