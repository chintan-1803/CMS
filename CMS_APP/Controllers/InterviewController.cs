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

            if (data != null)
            {
                ViewBag.ReasonList = reasonList;
                ViewBag.TechnologyList = technologyList;
                ViewBag.InterviewStatusList = interviewStatusList;
                ViewBag.InterviewerList = interviewerList;
                ViewBag.CandidateMasterList = candidateMasterList;
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
    }
}
