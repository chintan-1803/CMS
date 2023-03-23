using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using RoundModel = CMS.Models.RoundModel;

namespace CMS.Controllers
{
	public class RoundController : Controller
	{
		private readonly IRound _round_Interface;
		public RoundController(IRound round_Interface)
		{
			_round_Interface = round_Interface;
		}
		[HttpGet]
		public IActionResult Roundlist()
		{
			var response = _round_Interface.Roundlist();
			var data = JsonConvert.DeserializeObject<List<RoundModel>>(response.Content);
			if (data != null)
			{
				return View(data);
			}
			else
			{
				return View();
			}
		}

		[HttpPost]
		public IActionResult AddRoundlist(RoundModel roundData)
		{
			var response = _round_Interface.AddRound(roundData);
			if (!response.IsSuccessful)
			{
				return BadRequest(response);
			}
			if (response != null)
			{
				return Json(new { });
			}
			else
			{
				return BadRequest(response);
			}
		}

		[HttpPut]
		public IActionResult UpdateRoundlist(RoundModel roundData)
		{
			var response = _round_Interface.UpdateRoundlist(roundData);
			if (!response.IsSuccessful)
			{
				//return Json(new {response});
				return BadRequest(response);
			}
			if (response != null)
			{
				return Json(new { });
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
				return Json(new { });
			}
			else
			{
				return BadRequest(response);
			}
		}
	}
}
