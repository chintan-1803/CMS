using CMS.Models;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Data;



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
		public IActionResult Interviewerlist()
		{
			//var InterviewerData = JsonConvert.SerializeObject(masterDataList.InterviewerData);
			var jsonData = HttpContext.Session.GetString("InterviewerList");



			List<InterviewerModel> data;
			if (jsonData == null)
			{
				var response = _interviewer_Interface.Interviewerlist();
				data = JsonConvert.DeserializeObject<List<InterviewerModel>>(response.Content);
				var InterviewerData = JsonConvert.SerializeObject(data);
				HttpContext.Session.SetString("InterviewerList", InterviewerData);
			}
			else
			{
				data = JsonConvert.DeserializeObject<List<InterviewerModel>>(jsonData);
			}
			var jsonData1 = HttpContext.Session.GetString("DesignationList");
			var designationList = JsonConvert.DeserializeObject(jsonData1);



			var jsonData2 = HttpContext.Session.GetString("TechnologyList");
			var technologyList = JsonConvert.DeserializeObject(jsonData2);

			if (data != null)
			{
				ViewBag.DesignationList = designationList;
				ViewBag.TechnologyList = technologyList;
				return View(data);
			}
			else
			{
				return View();
			}




			// Get the list of designations from the session




			// Get the list of technologies from the session



			//var jsonData1 = HttpContext.Session.GetString("technologyList");
			//var technologyList = JsonConvert.DeserializeObject<List<TechnologyModel>>(jsonData1);




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