using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RoundStatusController : ControllerBase
    {
        private readonly IRoundStatus_Interface _roundStatusService;
        private readonly IDapper _dapper;

        public RoundStatusController(IRoundStatus_Interface roundStatusService, ILogger<RoundStatusController> logger)
        {
            _roundStatusService = roundStatusService;
        }

        [HttpGet("RoundStatus")]
        public IActionResult GetRoundStatusData()
        {
            try
            {
                var responseTask = _roundStatusService.GetAllRoundStatusData();
                responseTask.Wait();
                var response = responseTask.Result;

                if (response == null)
                {
                    return NotFound(new { message = "NO ROUND STATUS FOUND" });
                }

                return Ok(response);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpPost("AddRoundStatus")]
        public IActionResult AddRoundStatusData([FromBody] RoundStatusModel roundStatusModel)
        {
            try
            {
                var response = _roundStatusService.AddRoundStatusData(roundStatusModel);

                if (string.IsNullOrWhiteSpace(response))
                {
                    return BadRequest(new { message = "FAILED TO ADD ROUND STATUS" });
                }

                return Ok("SUCCESS");
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpPut("UpdateRoundStatus")]
        public IActionResult UpdateRoundStatusData(RoundStatusModel roundStatusModel)
        {
            try
            {
                var response = _roundStatusService.UpdateRoundStatusData(roundStatusModel);

                if (response == 0)
                {
                    return BadRequest(new { message = "FAILED TO UPDATE ROUND STATUS" });
                }

                return Ok("SUCCESS");
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [HttpPut("DeleteRoundStatus")]
        public IActionResult DeleteRoundStatusDataById(RoundStatusModel roundStatus_Id)
        {
            try
            {
                var response = _roundStatusService.DeleteRoundStatusDataById(roundStatus_Id);

                if (response == 0)
                {
                    return BadRequest(new { message = "FAILED TO DELETE ROUND STATUS" });
                }

                return Ok("SUCCESS");
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}
