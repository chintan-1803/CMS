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
                    return BadRequest(new { message = "FAILED TO ADD Reason" });
                }
				else if (response == "Unsuccessful")
				{
					return BadRequest(new { message = "Reason IS ALREADY EXISTS" });
				}
				return Ok("SUCCESS");
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

				if (response == 0 || response < 0)
				{
                    return BadRequest(new { message = "FAILED TO ADD REASON" });
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

		#region  DeleteReason
		[HttpPut("DeleteReason")]
		public IActionResult DeleteReason(ReasonModel Reason_ID)
		{
			try
			{
				var response = _reasonService.DeleteReasonByid(Reason_ID);

				
				if (response == 0)
				{
					return BadRequest(new { message = "FAILED TO DELETE REASON" });
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
