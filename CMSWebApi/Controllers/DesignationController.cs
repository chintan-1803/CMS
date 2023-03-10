using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Mvc;
using System.Reflection;

namespace CMSWebApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DesignationController : Controller
    {
        private readonly IDesignation_Interface _designationService;
        //private readonly ILogger _logger;
        private readonly IDapper _dapper;
        public DesignationController(IDesignation_Interface designatoinService,  IDapper dapper)
        {
            _designationService = designatoinService;
           // _logger = logger;
            _dapper = dapper;
        }

        #region Get Designation WithOut Async
        [HttpGet("Designation")]
        public IActionResult Designation()
        {
            try
            {
                var responseTask = _designationService.GetAllDesignation();
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

        #region  AddDesignation
        [HttpPost("AddDesignation")]
        public IActionResult AddDesigantion(DesignationModel designationmodel)
        {
            try
            {
                var response = _designationService.AddDesignation(designationmodel);

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

        #region  UpdateDesignation
        [HttpPut("UpdateDesignation")]
        public IActionResult UpdateDesignation(DesignationModel designationmodel)
        {
            try
            {
                var response = _designationService.UpdateDesignation(designationmodel);

                if (response == 0)
                {
                    return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
                }
                else if(response > 0)
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
        public IActionResult DeleteDesignation(int DesignationID)
        {
            try
            {
                var response = _designationService.DeleteDesignationByid(DesignationID);

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
