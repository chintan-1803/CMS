using Azure;
using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TechnologyController : Controller
    {
        private readonly ITechnology_Interface _TechnologyService;
        private readonly IDapper _dapper;
        public TechnologyController(ITechnology_Interface TechnologyService, IDapper dapper)
        {
            _TechnologyService = TechnologyService;
            _dapper = dapper;

        }

        #region Get Technology Without Async
        [HttpGet("Technology")]
        public IActionResult Technology()
        {
            try
            {
                var responseTask = _TechnologyService.GetAllTechnology();
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

        #region  AddTechnology
        [HttpPost("AddTechnology")]
        public IActionResult AddTechnology(TechnologyModel technologyModel)
        {
            try
            {
                var result = _TechnologyService.AddTechnology(technologyModel);
           
                if (result == null)
                {
                    return BadRequest(new { message = "FAILED TO ADD Technology" });
                }
                else if (result == "Unsucessfull")
                {
                    return BadRequest(new { message = "Technology IS ALREADY EXISTS" });
                }
                return Ok("Sucess");
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        #endregion

        #region  UpdateTechnology
        [HttpPut("UpdateTechnology")]
        public IActionResult UpdateTechnology(TechnologyModel technologyModel)
        {
            try
            {
                var response = _TechnologyService.UpdateTechnology(technologyModel);

				if (response == 0 || response < 0)
				{
                    return BadRequest(new { message = "FAILED TO ADD Technology" });
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

        #region  DeleteTechnology
        [HttpPut("DeleteTechnology")]
        public IActionResult DeleteTechnology(TechnologyModel Technology_Id)
        {
            try
            {
                var response = _TechnologyService.DeleteTechnology(Technology_Id);

                if (response == 0)
                {
                    return BadRequest(new { message = "FAILED TO ADD Technology" });
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
