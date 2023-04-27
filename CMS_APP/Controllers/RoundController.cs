using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using RoundModel = CMS.Models.RoundModel;

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
		public IActionResult Roundlist()
		{
            //pass the session
            var jsonData = HttpContext.Session.GetString("RoundList");

			List<RoundModel> data;
			if (jsonData == null)
			{
				var response = _round_Interface.Roundlist();
				data = JsonConvert.DeserializeObject<List<RoundModel>>(response.Content);
				var RoundData = JsonConvert.SerializeObject(data);
				HttpContext.Session.SetString("RoundList",RoundData);
			}
			else
			{
				data = JsonConvert.DeserializeObject<List<RoundModel>>(jsonData);
			}
			return View(data);
			//var response = _round_Interface.Roundlist();
			//var data = JsonConvert.DeserializeObject<List<RoundModel>>(response.Content);
			//if (data != null)
			//{
			//	return View(data);
			//}
			//else
			//{
			//	return View();
			//}
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
