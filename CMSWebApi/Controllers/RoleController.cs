using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class RoleController : Controller
    {
        private readonly IRole_Interface _roleService;
        private readonly IDapper _dapper;
        public RoleController(IRole_Interface roleService, IDapper dapper)
        {
            _roleService = roleService;
            _dapper = dapper;

        }

        #region Get Role Without Async
        [HttpGet("Role")]
        public IActionResult Role()
        {
            try
            {
                var responseTask = _roleService.GetAllRole();
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

        #region  AddDesignation
        [HttpPost("AddDesignation")]
        public IActionResult AddRole(RoleModel roleModel)
        {
            try
            {
                var response = _roleService.AddRole(roleModel);

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

        #region  UpdateRole
        [HttpPut("UpdateRole")]
        public IActionResult UpdateRole(RoleModel roleModel)
        {
            try
            {
                var response = _roleService.UpdateRole(roleModel);

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

        #region  DeleteRole
        [HttpPut("RoleID")]
        public IActionResult DeleteRole(int RoleID)
        {
            try
            {
                var response = _roleService.DeleteRoleByid(RoleID);
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
