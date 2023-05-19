using CMS.Interfaces;
using CMS.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Net;

namespace CMS.Controllers
{
    [Authorize(Roles = "Admin")]
	public class RoundController : Controller
	{
		private readonly IRound _round_Interface;
		public RoundController(IRound round_Interface)
		{
			_round_Interface = round_Interface;
		}
		[HttpGet]
		public IActionResult RoundList(int pageNumber = 1, int pageSize = 5)
		{
			var jsonData = HttpContext.Session.GetString("RoundList");
			AllPaginationModel data;
			var response = _round_Interface.Roundlist(pageNumber, pageSize, out int totalItems);

			if (jsonData == null)
			{
				if (response.StatusCode == HttpStatusCode.OK)
				{
					data = JsonConvert.DeserializeObject<AllPaginationModel>(response.Content);
					var roundData = JsonConvert.SerializeObject(data);
					HttpContext.Session.SetString("RoundList", roundData);
				}
				else
				{
					return View("Error"); // Return an error view or handle the error appropriately
				}
			}
			else
			{
				data = JsonConvert.DeserializeObject<AllPaginationModel>(response.Content);
			}

			var totalPages = (int)Math.Ceiling((double)data.TotalItems / pageSize);

			data.PageSize = pageSize;
			data.CurrentPage = pageNumber;
			data.TotalPages = totalPages;

			var roundList = data.roundModel;

			var viewModel = new RoundViewModel
			{
				Rounds = roundList,
				PaginationModel = data
			};

			return View(viewModel);
		}

		[HttpPost]
		public IActionResult AddRoundlist(RoundModel roundData)
		{
            roundData.create_User = HttpContext.Session.GetString("Username");
            var response = _round_Interface.AddRound(roundData);
			
			if (!response.IsSuccessful)
			{
				return BadRequest(response);
			}
			if (response != null)
			{
				HttpContext.Session.Remove("RoundList");
				return Json(new { success = true, message = "Round added successfully." });
			}
			else
			{
				return BadRequest(response);
			}
		}
		[HttpPut]
		public IActionResult UpdateRoundlist(RoundModel roundData)
		{
            roundData.Change_user = HttpContext.Session.GetString("Username");
            var response = _round_Interface.UpdateRoundlist(roundData);
			if (!response.IsSuccessful)
			{
				//return Json(new {response});
				return BadRequest(response);
			}
			if (response.Content == "\"SUCCESS\"")
			{
				HttpContext.Session.Remove("RoundList");
				return Json(new { success = true, message = "Round updated successfully." });
			}
			if (response != null)
			{
				return Json(new { success = false/*, message = "Round updated successfully."*/ });
			}
			else
			{
				return BadRequest(response);
			}
		}
		[HttpPut]
		public IActionResult DeleteRoundlist(RoundModel Round_ID)
		{
			var response = _round_Interface.DeleteRounditem(Round_ID);
			if (response != null)
			{
				HttpContext.Session.Remove("RoundList");
				return Json(new { success = true, message = "Round deleted successfully." });
			}
			else
			{
				return BadRequest(response);
			}
		}
	}
}
