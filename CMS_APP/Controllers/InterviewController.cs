using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using CMS.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;

namespace CMS.Controllers
{
    [Authorize(Roles = "Interviewer,Admin")]
	public class InterviewController : Controller
	{
		private readonly IInterview _interviewInterface;
		public InterviewController(IInterview interviewInterface)
		{
			_interviewInterface = interviewInterface;
		}

        [HttpGet]
        public IActionResult InterviewList(int pageNumber = 1, int pageSize = 5)
        {
			var response = _interviewInterface.GetInterviewList(pageNumber, pageSize, out int totalItems);

			if (response.StatusCode == HttpStatusCode.OK)
            {
                var responseBody = response.Content;
                var data = JsonConvert.DeserializeObject<AllPaginationModel>(responseBody);

                var totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

                data.TotalItems = totalItems;
                data.PageSize = pageSize;
                data.CurrentPage = pageNumber;
                data.TotalPages = totalPages;

                var interviewList = data.interviewModel;

                var interviewRoundList = new List<InterviewRoundModel>();
                foreach (var interview in interviewList)
                {
                    var interviewId = interview.InterviewId;
                    var interviewRoundResponse = _interviewInterface.ViewInterviewRound(interviewId);
                    var interviewRound = JsonConvert.DeserializeObject<List<InterviewRoundModel>>(interviewRoundResponse.Content);

                    interviewRoundList.AddRange(interviewRound);
                }

                var viewModel = new InterviewViewModel
                {
                    Interview = interviewList,
                    InterviewRounds = interviewRoundList,
                    PaginationModel = data
                };

                var jsonData = HttpContext.Session.GetString("ReasonDataList");
                var reasonList = JsonConvert.DeserializeObject<List<ReasonModel>>(jsonData);

                var jsonData1 = HttpContext.Session.GetString("TechnologyList");
                var technologyList = JsonConvert.DeserializeObject<List<TechnologyModel>>(jsonData1);

                var jsonData2 = HttpContext.Session.GetString("InterviewStatusList");
                var interviewStatusList = JsonConvert.DeserializeObject<List<InterviewStatusModel>>(jsonData2);

                var jsonData3 = HttpContext.Session.GetString("InterviewerList");
                var interviewerList = JsonConvert.DeserializeObject<List<InterviewerModel>>(jsonData3);

                var jsonData4 = HttpContext.Session.GetString("CandidateMasterList");
                var candidateMasterList = JsonConvert.DeserializeObject<List<CandidateMasterEntity>>(jsonData4);

                var jsonData5 = HttpContext.Session.GetString("RoundList");
                var roundList = JsonConvert.DeserializeObject<List<RoundModel>>(jsonData5);

                var jsonData6 = HttpContext.Session.GetString("RoundStatusList");
                var roundStatusList = JsonConvert.DeserializeObject<List<RoundStatusModel>>(jsonData6);

                ViewBag.ReasonList = reasonList;
                ViewBag.TechnologyList = technologyList;
                ViewBag.InterviewStatusList = interviewStatusList;
                ViewBag.InterviewerList = interviewerList;
                ViewBag.CandidateMasterList = candidateMasterList;
                ViewBag.RoundList = roundList;
                ViewBag.RoundStatusList = roundStatusList;

                // Pass the view model to the view
                return View(viewModel);
            }
            else
            {
                return BadRequest(new { message = "Failed to retrieve interview list" });
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
				if (response.Content == "\"Interviewer is occupied\"")
				{
					errorMessage = "Interviewer is occupied.";
				}
				if (response.Content == "\"Candidate is occupied\"")
				{
					errorMessage = "Candidate is occupied.";
				}
				if (response.Content == "\"Data already exists\"")
				{
					errorMessage = "Data already exists";
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
				var errorMessage = "An error occurred while saving the interview.";
				if (response.Content == "\"Interviewer is occupied\"")
				{
					errorMessage = "Interviewer is occupied.";
				}
				return Json(new { success = false, message = errorMessage });
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

		[HttpPut]
		public IActionResult DeleteInterview(InterviewModel interviewData)
		{
			var response = _interviewInterface.DeleteInterview(interviewData);

			if (response.Content == "\"SUCCESS\"")
			{
				return Json(new { success = true, message = "Interview deleted successfully." });
			}
			else
			{
				return Json(new { success = false });
			}
		}

		[HttpPost]
		public IActionResult AddInterviewRound(InterviewRoundModel interviewRoundData)
		{
			// Check if the round number already exists for this interview
			var response = _interviewInterface.ViewInterviewRound(interviewRoundData.interviewId);
			if (!response.IsSuccessful)
			{
				return BadRequest(new { message = response.ErrorMessage });
			}



			var rounds = JsonConvert.DeserializeObject<List<InterviewRoundModel>>(response.Content);
			if (rounds.Any(r => r.roundNumberId == interviewRoundData.roundNumberId))
			{
				return BadRequest(new { message = "Round name already exists for this interview." });
			}

			// If the round number doesn't already exist, proceed with saving the data
			response = _interviewInterface.AddInterviewRound(interviewRoundData);

			if (!response.IsSuccessful)
			{
				return BadRequest(new { message = response.ErrorMessage });
			}
			else if (response.Content == "\"SUCCESS\"")
			{
				return Json(new { success = true, message = "Interview Round added successfully." });
			}
			else
			{
				return BadRequest(new { message = response.Content });
			}
		}

		[HttpGet]
		/*[Produces("application/json")]*/
		public IActionResult ViewInterviewRoundById(int interviewId)
		{
			var response = _interviewInterface.ViewInterviewRound(interviewId);

			var interviewRoundList = JsonConvert.DeserializeObject<List<InterviewRoundModel>>(response.Content);

			if (interviewRoundList != null)
			{
				return Json(interviewRoundList);
			}
			else
			{
				return NotFound();
			}
		}
	}
}
