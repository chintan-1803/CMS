using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RoundController : Controller
    {
        private readonly IRound_Interface _roundService;
        private readonly IDapper _dapper;
        public RoundController(IRound_Interface roundService, IDapper dapper)
        {
            _roundService = roundService;
            _dapper = dapper;
        }

        #region Get Round Without ASYNC
        [HttpGet("Round")]
        public IActionResult Round()
        {
            try
            {
                var responseTask = _roundService.GetAllRound();
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

        #region  AddRound
        [HttpPost("AddRound")]
        public IActionResult AddRound(RoundModel roundmodel)
        {
            try
            {
                var response = _roundService.AddRound(roundmodel);
            
                if (response == null)
                {
                    return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
                }


                return Ok("SUCESS");
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        #endregion

        #endregion
        #region  UpdateRound
        [HttpPut("UpdateRound")]
        public IActionResult UpdateRound(RoundModel roundmodel)
        {
            try
            {
                var response = _roundService.UpdateRound(roundmodel);

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

        #region  DeleteRound
        [HttpPut("RoundID")]
        public IActionResult DeleteRound(int RoundID)
        {
            try
            {
                var response = _roundService.DeleteRoundByid(RoundID);
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
