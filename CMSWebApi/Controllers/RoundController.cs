﻿	using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
   
    [ApiController]
	[Route("[controller]")]
	public class RoundController : Controller
	{
		private readonly IRound_Interface _roundService;
		private readonly IDapper _dapper;
		public RoundController(IRound_Interface roundService, IDapper dapper)
		{
			_roundService = roundService;
			_dapper = dapper;
		}

		#region Get Round Without ASYNC
		[HttpGet("Round")]
		public IActionResult Round(int pageNumber = 1, int pageSize = 5)
		{
			try
			{
				var responseTask = _roundService.GetAllRound(pageNumber, pageSize, out int totalItems);
				var response = responseTask.Result;

				if (response == null)
				{
					return BadRequest(new { message = "NULL VALUE" });
				}

				var totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

				var model = new AllPaginationModel
				{
					roundModel = response,
					TotalItems = totalItems,
					PageSize = pageSize,
					CurrentPage = pageNumber,
					TotalPages = totalPages
				};

				return Ok(model);
			}
			catch (Exception ex)
			{
				return BadRequest(new { message = ex.Message });
			}
		}
		#endregion

		#region  AddRound
		[HttpPost("AddRound")]
		public IActionResult AddRound(RoundModel roundmodel)
		{
			var response = _roundService.AddRound(roundmodel);

			//if (response == null)
			//{
			//    return BadRequest(new { message = "FAILED TO ADD ROUND" });
			//}
			if (response == "Unsuccessful")
			{
				return BadRequest(new { message = "Round IS ALREADY EXISTS" });
			}

			return Ok("SUCCESS");
		}
		#endregion


		#region  UpdateRound
		[HttpPut("UpdateRound")]
		public IActionResult UpdateRound(RoundModel roundmodel)
		{
				var response = _roundService.UpdateRound(roundmodel);

				//if (response == 0 || response < 0)
				//{
				//	return BadRequest(new { message = "FAILED TO ADD Round" });
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

        #region  DeleteRound
        [HttpPut("DeleteRound")]
        public IActionResult DeleteRound(RoundModel Round_ID)
        {
            try
            {
                var response = _roundService.DeleteRoundByid(Round_ID);
                if (response == 0)
                {
                    return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
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
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        #endregion
    }
}
