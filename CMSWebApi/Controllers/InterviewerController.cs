using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
    /*[Authorize]*/
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
        public IActionResult GetInterviewer(int pageNumber = 1, int pageSize = 5)
        {
            var responseTask = _InterviewerService.GetAllInterviewerDetails(pageNumber, pageSize, out int totalItems);
            var response = responseTask.Result;

            if (response == null)
            {
                return BadRequest(new { message = "NULL VALUE" });
            }

            var totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

            var model = new AllPaginationModel
            {
                interviewerModel = response,
                TotalItems = totalItems,
                PageSize = pageSize,
                CurrentPage = pageNumber,
                TotalPages = totalPages
            };

            return Ok(model);
           
        }
        #endregion

        #region  AddInterviewer
        [HttpPost("AddInterviewer")]
        public IActionResult AddInterviewer(InterviewerModel interviewermodel)
        {
            var response = _InterviewerService.AddInterviewer(interviewermodel);

                if (response == null)
                {
                    return BadRequest(new { message = "FAILED TO ADD Interviewer" });
                }
                else if (response == "Unsuccessful")
                {
                    return BadRequest(response);
                }

            return Ok("SUCCESS");
        }
        #endregion

        #region  UpdateInterviewer
        [HttpPut("UpdateInterviewer")]
        public IActionResult UpdateInterviewer(InterviewerModel interviewermodel)
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
        #endregion

        #region  DeleteInterviewer
        [HttpPut("DeleteInterviewer")]
        public IActionResult DeleteInterviewer(InterviewerModel Interviewer_Id)
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
        #endregion

    }
}
