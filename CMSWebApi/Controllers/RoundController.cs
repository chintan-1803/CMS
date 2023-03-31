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

        #endregion

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


                return Ok("SUCCESS");
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
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

        #region  DeleteRound
        [HttpPut("DeleteRound")]
        public IActionResult DeleteRound(RoundModel Round_ID)
        {
            try
            {
                var response = _roundService.DeleteRoundByid(Round_ID);
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

        #region GetRoundsByPage
        [HttpGet("paged")]
        public async Task<IActionResult> GetRoundsByPage(int pageNumber = 1, int rowsOfPage = 5)
        {
            var rounds = await _roundService.GetRoundsByPage(pageNumber, rowsOfPage);
            return Ok(rounds);
        }
        #endregion
    }
}
