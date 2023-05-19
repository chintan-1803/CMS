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
    public class DesignationController : Controller
    {
        private readonly IDesignation_Interface _designationService;
        //private readonly ILogger _logger;
        private readonly IDapper _dapper;
        public DesignationController(IDesignation_Interface designatoinService, IDapper dapper)
        {
            _designationService = designatoinService;
            // _logger = logger;
            _dapper = dapper;
        }

		#region Get Designation WithOut Async
		[HttpGet("Designation")]
		public IActionResult Designation(int pageNumber = 1, int pageSize = 5)
		{
			var responseTask = _designationService.GetAllDesignation(pageNumber, pageSize, out int totalItems);
			var response = responseTask.Result;

			if (response == null)
			{
				return BadRequest(new { message = "NULL VALUE" });
			}

			var totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

			var model = new AllPaginationModel
			{
				designationModel = response,
				TotalItems = totalItems,
				PageSize = pageSize,
				CurrentPage = pageNumber,
				TotalPages = totalPages
			};

			return Ok(model);
		}

		#endregion

		#region  AddDesignation
		[HttpPost("AddDesignation")]
		public IActionResult AddDesigantion(DesignationModel designationmodel)
		{
			var response = _designationService.AddDesignation(designationmodel);


			//if (response == null)  //check this
			//{
			//	return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
			//}
			if (response == "Unsuccessful")
			{
				return BadRequest(new { message = "DESIGNATION IS ALREADY EXISTS" });
			}

			return Ok("SUCCESS");

		}
		#endregion
		
		#region  UpdateDesignation
		[HttpPut("UpdateDesignation")]
		public IActionResult UpdateDesignation(DesignationModel designationmodel)
		{
				var response = _designationService.UpdateDesignation(designationmodel);

				//if (response == 0)
				//{
				//	return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
				//}
				if (response < 0)
				{
					return Ok("Data already exists");
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

		

		#region  DeleteDesignation
		[HttpPut("DeleteDesignation")]
		public IActionResult DeleteDesignation(DesignationModel Designation_ID)
		{
			var response = _designationService.DeleteDesignationByid(Designation_ID);

			//if (response == 0)
			//{
			//	return BadRequest(new { message = "FAILED TO DELETE DESIGNATION" });
			//}
			if (response > 0)
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
