using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class InterviewerController : Controller
    {
        private readonly IInterviewer_Interface _InterviewerService;
        //private readonly ILogger _logger;
        private readonly IDapper _dapper;
        public InterviewerController(IInterviewer_Interface interviewerServiece, IDapper dapper)
        {
            _InterviewerService = interviewerServiece;
            // _logger = logger;
            _dapper = dapper;
        }

        #region Get Designation WithOut Async
        [HttpGet("Interviewer")]
        public IActionResult Interviewer()
        {
            try
            {
                var responseTask = _InterviewerService.GetAllInterviewerDetails();
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
                //_logger.Error(ex, "Post UsersController Authenticate");
                return BadRequest(new { message = ex.Message });
            }
        }
        #endregion

        #region  AddInterviewer
        [HttpPost("AddInterviewer")]
        public IActionResult AddInterviewer(InterviewerModel interviewermodel)
        {
            try
            {
                var response = _InterviewerService.AddInterviewer(interviewermodel);

                if (response == null)
                {
                    return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
                }

                return Ok("SUCCESS");
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        #endregion

        #region  UpdateInterviewer
        [HttpPut("UpdateInterviewer")]
        public IActionResult UpdateInterviewer(InterviewerModel interviewermodel)
        {
            try
            {
                var response = _InterviewerService.UpdateInterviewer(interviewermodel);

                if (response == 0)
                {
                    return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
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
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        #endregion

        #region  DeleteInterviewer
        [HttpPut("DeleteInterviewer")]
        public IActionResult DeleteInterviewer(InterviewerModel Interviewer_Id)
        {
            try
            {
                var response = _InterviewerService.DeleteInterviewerByid(Interviewer_Id);

                if (response == 0)
                {
                    return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
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
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        #endregion

    }
}
