using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Data;

namespace CMS.Controllers
{
	/*[Authorize]*/
	public class InterviewController : Controller
	{
		private readonly IInterview _interviewInterface;

		public InterviewController(IInterview interviewInterface)
		{
			_interviewInterface = interviewInterface;
		}

		[HttpGet]
		public IActionResult InterviewList()
		{
			var response = _interviewInterface.GetInterviewList();
			var data = JsonConvert.DeserializeObject<List<InterviewModel>>(response.Content);
			
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
		public IActionResult AddInterview(InterviewModel interviewData)
		{
			var response = _interviewInterface.AddInterview(interviewData);

			if (response.Content == "\"SUCCESS\"")
			{
				return Json(new { success = true, message = "Interview added successfully." });
			}
			else
			{
				var errorMessage = "An error occurred while saving the interview.";
				// Modify the error message based on the response content
				if (response.Content == "\"Unsuccessful\"")
				{
					errorMessage = "The email address already exists.";
				}
				return Json(new { success = false, message = errorMessage });
			}
		}

		[HttpPut]
		public IActionResult UpdateInterview(InterviewModel updateInterviewData)
		{
			var response = _interviewInterface.UpdateInterview(updateInterviewData);

			if (!response.IsSuccessful)
			{
				return BadRequest(response);
			}
			if (response.Content == "\"SUCCESS\"")
			{
				return Json(new { success = true, message = "Interview updated successfully." });
			}
			if (response != null)
			{
				return Json(new { success = false });
			}
			else
			{
				return BadRequest(response);
			}
		}

		[HttpDelete]
		public IActionResult DeleteInterview(InterviewModel interviewId)
		{
			var response = _interviewInterface.DeleteInterview(interviewId);

			if (response != null)
			{
				return Json(new { success = true, message = "Interview deleted successfully." });
			}
			else
			{
				return BadRequest(response);
			}
		}
	}
}
