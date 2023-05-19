using CMS.ApplicationHelpers;
using CMS.Models;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using RestSharp;
using System.Data;
using System.Net;

namespace CMS.Controllers
{
	/*[Authorize]*/
	[Authorize(Roles = "Interviewer,Admin")]
	public class InterviewerController : Controller
	{
		/*private readonly Interviewer _interviewerService;*/
		private readonly IInterviewer _interviewer_Interface;



		public InterviewerController(IInterviewer interviewer_Interface)
		{
			_interviewer_Interface = interviewer_Interface;
		}

		[HttpGet]
		public IActionResult InterviewerList(int pageNumber = 1, int pageSize = 5)
		{
			var jsonData = HttpContext.Session.GetString("InterviewerList");
			AllPaginationModel data;

			var response = _interviewer_Interface.Interviewerlist(pageNumber, pageSize, out int totalItems);

			if (jsonData == null)
			{
				if (response.StatusCode == HttpStatusCode.OK)
				{
					data = JsonConvert.DeserializeObject<AllPaginationModel>(response.Content);
					var interviewerData = JsonConvert.SerializeObject(data);
					HttpContext.Session.SetString("InterviewerList", interviewerData);
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

			var interviewerList = data.interviewerModel;

			var viewModel = new InterviewerViewModel
			{
				Interviewers = interviewerList,
				PaginationModel = data
			};

			var jsonData1 = HttpContext.Session.GetString("DesignationList");
			var designationList = JsonConvert.DeserializeObject(jsonData1);

			var jsonData2 = HttpContext.Session.GetString("TechnologyList");
			var technologyList = JsonConvert.DeserializeObject(jsonData2);

			if (interviewerList != null)
			{
				ViewBag.DesignationList = designationList;
				ViewBag.TechnologyList = technologyList;
				return View(viewModel);
			}

			return BadRequest(new { message = "Failed to retrieve interviewer list" });
		}

		[HttpPost]
		public IActionResult AddInterviewerlist(InterviewerModel interviewerData)
		{
			var response = _interviewer_Interface.AddInterviewerlist(interviewerData);
			if (response.Content == "\"SUCCESS\"")
			{
				HttpContext.Session.Remove("InterviewerList");
				return Json(new { success = true, message = "Interviewer added successfully." });
			}
			else
			{
				var errorMessage = "An error occurred while saving the interviewer.";
				// Modify the error message based on the response content
				if (response.Content == "\"Unsuccessful\"")
				{
					errorMessage = "The email address already exists.";
				}
				return Json(new { success = false, message = errorMessage });
			}
		}



		[HttpPut]
		public IActionResult UpdateInterviewerlist(InterviewerModel updateInterviewerData)
		{
			var response = _interviewer_Interface.UpdateInterviewerlist(updateInterviewerData);
			/*if (response != null)
            {
                return Json(new { });
            }
            else
            {
                return BadRequest(response);
            }*/
			if (!response.IsSuccessful)
			{
				//return Json(new {response});
				return BadRequest(response);
			}
			if (response.Content == "\"SUCCESS\"")
			{
				HttpContext.Session.Remove("InterviewerList");
				//HttpContext.Session.Remove("masterDatalist");
				return Json(new { success = true, message = "Interviewer updated successfully." });
			}
			if (response != null)
			{
				return Json(new { success = false/*, message = "Designation updated successfully."*/ });
			}
			else
			{
				return BadRequest(response);
			}
		}

		[HttpPut]
		public IActionResult DeleteIntervieweritem(InterviewerModel Interviewer_Id)
		{
			var response = _interviewer_Interface.DeleteIntervieweritem(Interviewer_Id);
			if (response != null)
			{
				HttpContext.Session.Remove("InterviewerList");
				return Json(new { success = true, message = "Interviewer deleted successfully." });
			}
			else
			{
				return BadRequest(response);
			}
		}
	}
}
