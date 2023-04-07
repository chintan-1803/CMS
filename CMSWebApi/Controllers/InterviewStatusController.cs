using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
    /*[Authorize]*/
    [ApiController]
    [Route("[controller]")]
    public class InterviewStatusController : Controller
    {
        private readonly IInterviewStatus_Interface _interviewStatusService;
        private readonly IDapper _dapper;

        public InterviewStatusController(IInterviewStatus_Interface interviewStatusService, IDapper dapper)
        {
            _interviewStatusService = interviewStatusService;
            _dapper = dapper;
        }

        #region Get Interview Status WithOut Async
        [HttpGet("InterviewStatus")]
        public IActionResult GetInterviewStatus()
        {
            try
            {
                var responseTask = _interviewStatusService.GetAllInterviewStatus();
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

        #region  Add Interview Status
        [HttpPost("AddInterviewStatus")]
        public IActionResult AddInterviewStatus(InterviewStatusModel interviewStatusModel)
        {
           var response = _interviewStatusService.AddInterviewStatus(interviewStatusModel);

            if (response == "Unsuccessful")
            {
                return BadRequest(new { message = "FAILED TO ADD Interview Status" });
            }

            return Ok(new { message = "SUCCESS" });
            
        }
        #endregion

        #region  Update Interview Status
        [HttpPut("UpdateInterviewStatus")]
        public IActionResult UpdateInterviewStatus(InterviewStatusModel interviewStatusModel)
        {
            var response = _interviewStatusService.UpdateInterviewStatus(interviewStatusModel);

            if (response == 0)
            {
                return BadRequest(new { message = "FAILED TO UPDATE Interview Status" });
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

        #region  Delete Interview Status
        [HttpPut("DeleteInterviewStatus")]
        public IActionResult DeleteInterviewStatus(InterviewStatusModel StatusID)
        {
            var response = _interviewStatusService.DeleteInterviewStatusById(StatusID);

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