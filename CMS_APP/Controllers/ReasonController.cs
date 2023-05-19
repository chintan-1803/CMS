using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Drawing.Drawing2D;
using System.Net;

namespace CMS.Controllers
{
	[Authorize(Roles = "Admin")]
	public class ReasonController : Controller
	{
		private readonly IReason _reason_Interface;
		public ReasonController(IReason reason_Interface)
		{
			_reason_Interface = reason_Interface;
		}

		[HttpGet]
		public IActionResult Reasonlist(int pageNumber = 1, int pageSize = 5)
		{
			var jsonData = HttpContext.Session.GetString("ReasonDataList");
			AllPaginationModel data;

			var response = _reason_Interface.Reasonlist(pageNumber, pageSize, out int totalItems);

			if (jsonData == null)
			{
				if (response.StatusCode == HttpStatusCode.OK)
				{
					data = JsonConvert.DeserializeObject<AllPaginationModel>(response.Content);
					var reasonData = JsonConvert.SerializeObject(data);
					HttpContext.Session.SetString("ReasonDataList", reasonData);
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

			var reasonList = data.reasonModel;

			var viewModel = new ReasonViewModel
			{
				Reasons = reasonList,
				PaginationModel = data
			};

			return View(viewModel);
		}

		[HttpPost]
		public IActionResult AddReasonlist(ReasonModel reasonData)
		{
			//var errors = ModelState.Values.SelectMany(v => v.Errors);
			reasonData.create_User = HttpContext.Session.GetString("Username");
			var response = _reason_Interface.AddReasonlist(reasonData);
			if (!response.IsSuccessful)
			{
				return BadRequest(response);
			}
			if (response != null)
			{
				HttpContext.Session.Remove("ReasonDataList");
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
				HttpContext.Session.Remove("ReasonDataList");
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
				HttpContext.Session.Remove("ReasonDataList");
				return Json(new { success = true, message = "Reason deleted successfully."});
			}
			else
			{
				return BadRequest(response);
			}
		}
	}
}
