﻿
using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class InterviewController : Controller
    {
        private readonly IInterviews_Interface _interviewsService;
        private readonly IDapper _dapper;

        public InterviewController(IInterviews_Interface interviewsService, IDapper dapper)
        {
            _interviewsService = interviewsService;
            _dapper = dapper;
        }

        #region Interview
        [HttpGet("Interview")]
        public IActionResult GetInterview(int pageNumber = 1, int pageSize = 5)
        {
            var responseTask = _interviewsService.GetAllInterviewsData(pageNumber, pageSize, out int totalItems);
            var response = responseTask.Result;

            if (response == null)
            {
                return BadRequest(new { message = "NULL VALUE" });
            }

            var totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

            var model = new AllPaginationModel
            {
                interviewModel = response,
                TotalItems = totalItems,
                PageSize = pageSize,
                CurrentPage = pageNumber,
                TotalPages = totalPages
            };

            return Ok(model);
            
        }
        #endregion

        #region AddInterview
        [HttpPost("AddInterviewData")]
        public IActionResult AddInterviewData(InterviewsModel interviewsModel)
        {
            interviewsModel.StatusID = 1;
            interviewsModel.ReasonID = 38;
            var response = _interviewsService.AddInterviewData(interviewsModel);

            if (response == "Candidate is occupied")
            {
                return BadRequest(response);
            }
            if(response== "Interviewer is occupied")
            {
				return BadRequest(response);
			}
            if(response== "Data already exists")
            {
				return BadRequest(response);
			}

            return Ok("SUCCESS");
        }
        #endregion

        #region UpdateInterview
        [HttpPut("UpdateInterviewData")]
        public IActionResult UpdateInterviewData(InterviewsModel interviewsModel)
        {
            var response = _interviewsService.UpdateInterviewData(interviewsModel);

            if (response == 0)
            {
                return BadRequest(new { message = "FAILED TO UPDATE Interview" });
            }

            else if (response < 0)
            {
				return BadRequest("Interviewer is occupied");
			}
            
            else if (response > 0)
            {
                return Ok("SUCCESS");
            }
            else
            {
                return BadRequest("Something went wrong");
            }
        }
        #endregion

        #region DeleteInterview
        [HttpPut("DeleteInterviewData")]
        public IActionResult DeleteInterviewDataById(InterviewsModel InterviewId)
        {
            var response = _interviewsService.DeleteInterviewDataById(InterviewId);

            if (response == 0)
            {
                return BadRequest(new { message = "FAILED TO DELETE Interview Status" });
            }
            else if (response > 0)
            {
                return Ok("SUCCESS");
            }
            else
            {
                return Ok("Something went wrong");
            }
        }
        #endregion
    }
}

