using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CMS.Controllers
{
	public class ReasonController : Controller
	{
		private readonly IReason _reason_Interface;
		public ReasonController(IReason reason_Interface)
		{
			_reason_Interface = reason_Interface;
		}


		[HttpGet]
		public IActionResult Reasonlist()

		{
			var response = _reason_Interface.Reasonlist();
			var data = JsonConvert.DeserializeObject<List<ReasonModel>>(response.Content);

			//var jsonData = HttpContext.Session.GetString("designationList");
			//var designationList = JsonConvert.DeserializeObject<List<DesignationModel>>(jsonData);
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
		public IActionResult AddReasonlist(ReasonModel reasonData)
		{
			//var errors = ModelState.Values.SelectMany(v => v.Errors);
			reasonData.create_User = HttpContext.Session.GetString("Username");
			var response = _reason_Interface.AddDesignationlist(reasonData);
			if (!response.IsSuccessful)
			{
				return BadRequest(response);
			}
			if (response != null)
			{
				return Json(new { success = true, message = "Reason added successfully." });
			}
			else
			{
				return BadRequest(response);
			}
		}

		[HttpPut]
		public IActionResult UpdateReasonlist(ReasonModel reasonmodel)
		{
			//var errors = ModelState.Values.SelectMany(v => v.Errors);
			reasonmodel.Change_user = HttpContext.Session.GetString("Username");
			var response = _reason_Interface.UpdateReasonlist(reasonmodel);
			if (!response.IsSuccessful)
			{
				//return Json(new {response});
				return BadRequest(response);
			}
			if (response.Content == "\"SUCCESS\"")
			{
				return Json(new { success = true, message = "Reason updated successfully."});
			}
			if (response != null)
			{
				return Json(new { success = false/*, message = "Reason updated successfully."*/});
			}
			else
			{
				return BadRequest(response);
			}
		}

		[HttpPut]
		public IActionResult DeleteReasonlist(ReasonModel Reason_ID)
		{
			//var errors = ModelState.Values.SelectMany(v => v.Errors);
			var response = _reason_Interface.DeleteReasonitem(Reason_ID);
			if (response != null)
			{
				return Json(new { success = true, message = "Reason deleted successfully."});
			}
			else
			{
				return BadRequest(response);
			}
		}
	}
}
