using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
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
                var resultmessage = _TechnologyService.AddTechnology(technologyModel);
           
                if (resultmessage == null)
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

        #region  UpdateTechnology
        [HttpPut("UpdateTechnology")]
        public IActionResult UpdateDesignation(TechnologyModel technologyModel)
        {
            try
            {
                var response = _TechnologyService.UpdateTechnology(technologyModel);
          
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
        public IActionResult DeleteDesignation(int TechnologyId)
        {
            try
            {
                var response = _TechnologyService.DeleteTechnologyByid(TechnologyId);
          
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
