using CMS.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Data;

namespace CMS.Controllers
{
    /*[Authorize]*/
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
            var response = _interviewer_Interface.Interviewerlist();
            var data = JsonConvert.DeserializeObject<List<InterviewerModel>>(response.Content);

            // Get the list of designations from the session

            var jsonData = HttpContext.Session.GetString("DesignationList");
            var designationList = JsonConvert.DeserializeObject(jsonData);

            var jsonData1 = HttpContext.Session.GetString("TechnologyList");
            var technologyList = JsonConvert.DeserializeObject(jsonData1);
            // Get the list of technologies from the session

            //var jsonData1 = HttpContext.Session.GetString("technologyList");
            //var technologyList = JsonConvert.DeserializeObject<List<TechnologyModel>>(jsonData1);

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
        }


        [HttpPost]
		public IActionResult AddInterviewerlist(InterviewerModel interviewerData)
		{
			var response = _interviewer_Interface.AddInterviewerlist(interviewerData);
			if (response.Content == "{\"message\":\"SUCCESS\"}")
			{
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

		/*public IActionResult AddInterviewerlist(InterviewerModel interviewerData)
        {

            var response = _interviewer_Interface.AddInterviewerlist(interviewerData);
            *//*if (!response.IsSuccessful)
			{
				return Json(new { response.Content });

			}
			if (response != null)
			{
				return Json(new { });
			}
			else
			{
				return BadRequest(response);
			}*/
		/*if (!response.IsSuccessful)
		{
			//return Json(new {response});
			return BadRequest(response);
		}*//*
		if (response.Content == "\"SUCCESS\"")
		{
			//HttpContext.Session.Remove("masterDatalist");
			return Json(new { success = true, message = "Interviewer saved successfully." });
		}
		if (response.Content == "\"Unsuccessful\"")
		{
			return Json(new { success = false*//*, message = "Designation updated successfully."*//* });
		}
		else
		{
			return BadRequest(response);
		}
	}*/

		/*private bool IsValidEmail(string email)
		{
			try
			{
				var addr = new System.Net.Mail.MailAddress(email);
				return addr.Address == email;
			}
			catch
			{
				return false;
			}
		}*/

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
                return Json(new { success = true, message = "Interviewer deleted successfully." });
            }
            else
            {
                return BadRequest(response);
            }
        }
    }
}
