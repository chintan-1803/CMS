using CMSWebApi.Models;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System;
using CMSWebApi.Services;

namespace CMSWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class InterviewRoundController : ControllerBase
    {
        private readonly IInterviewRound_Interface _interviewRoundService;

        public InterviewRoundController(IInterviewRound_Interface interviewRoundService)
        {
            _interviewRoundService = interviewRoundService;
        }

        #region Interview Round
        [HttpGet("InterviewRound/{id}")]
        public IActionResult GetInterviewRound(int id)
        {
            try
            {
                var responseTask = _interviewRoundService.GetAllInterviewRoundData(id);
                responseTask.Wait();
                var response = responseTask.Result;

                if (response == null)
                {
                    return NotFound();
                }

                return Ok(response);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        #endregion

        #region AddInterviewRound
        [HttpPost("AddInterviewRound")]
        public IActionResult AddInterviewRoundData(InterviewRoundModel interviewRoundModel)
        {
            var response = _interviewRoundService.AddInterviewRoundData(interviewRoundModel);

            if (response == null)
            {
                return BadRequest(new { message = "FAILED TO ADD INTERVIEW ROUND" });
            }
            else if (response == "Unsuccessful")
            {
                return BadRequest(response);
            }

            return Ok("SUCCESS");
        }
        #endregion

        #region UpdateInterviewRound
        [HttpPut("UpdateInterviewRound")]
        public IActionResult UpdateInterviewRoundData(InterviewRoundModel interviewRoundModel)
        {
            var response = _interviewRoundService.UpdateInterviewRoundData(interviewRoundModel);

            if (response == 0)
            {
                return BadRequest(new { message = "FAILED TO ADD INTERVIEW ROUND" });
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

        #region DeleteInterviewRound
        [HttpPut("DeleteInterviewRound")]
        public IActionResult DeleteInterviewRoundDataById(InterviewRoundModel interviewRoundModel)
        {
            var response = _interviewRoundService.DeleteInterviewRoundDataById(interviewRoundModel);

            if (response == 0)
            {
                return BadRequest(new { message = "FAILED TO ADD INTERVIEW ROUND" });
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
