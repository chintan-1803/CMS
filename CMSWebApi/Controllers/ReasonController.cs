using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ReasonController : Controller
    {
        private readonly IReason_Interface _reasonService;
        private readonly IDapper _dapper;
        public ReasonController(IReason_Interface reasonService, IDapper dapper)
        {
            _reasonService = reasonService;
            _dapper = dapper;

        }

        #region Get method Of Reason wothout async
        [HttpGet("Reason")]
        public IActionResult Reason()
        {
            try
            {
                var responseTask = _reasonService.GetAllReason();
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

        #region  AddReason
        [HttpPost("AddReason")]
        public IActionResult AddReason(ReasonModel reasonModel)
        {
            try
            {
                var response = _reasonService.AddReason(reasonModel);

                if (response == null)
                {
                    return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
                }
                return Ok("Sucess");
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        #endregion

        #region  UpdateReason
        [HttpPut("UpdateReason")]
        public IActionResult UpdateReason(ReasonModel reasonModel)
        {
            try
            {
                var response = _reasonService.UpdateReason(reasonModel);
   
                if (response == 0)
                {
                    return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
                }
                else if (response > 0)
                {
                    return Ok("SUCESS");
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

        #region  DeleteDesignation
        [HttpPut("DesignationID")]
        public IActionResult DeleteReason(int ReasonID)
        {
            try
            {
                var response = _reasonService.DeleteReasonByid(ReasonID);
    
                if (response == 0)
                {
                    return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
                }
                else if (response > 0)
                {
                    return Ok("SUCESS");
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
