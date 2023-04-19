
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
        public IActionResult GetInterviewStatus()
        {
            try
            {
                var responseTask = _interviewsService.GetAllInterviewsData();
                responseTask.Wait();
                var response = responseTask.Result;

                if (response == null)
                {
                    return BadRequest(new { message = "NULL VALUE" });
                }

                return Ok(response);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        #endregion

        #region AddInterview
        [HttpPost("AddInterviewData")]
        public IActionResult AddInterviewData(InterviewsModel interviewsModel)
        {
            interviewsModel.StatusID = 1;
            interviewsModel.ReasonID = 38;
            var response = _interviewsService.AddInterviewData(interviewsModel);

            if (response == "Unsuccessful")
            {
                return BadRequest(new { message = "FAILED TO ADD Interview" });
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

