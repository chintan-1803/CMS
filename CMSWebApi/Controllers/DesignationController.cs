using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
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
		public IActionResult Designation()
		{
			try
			{
				var responseTask = _designationService.GetAllDesignation();
				//responseTask.Wait();
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
		//public IActionResult AddDesigantion(DesignationModel designationmodel)
		//{
		//	var response = _designationService.AddDesignation(designationmodel);


		//	//if (response == null)  //check this
		//	//{
		//	//	return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
		//	//}
		//	if (response == "Unsuccessful")
		//	{
		//		var error = new { errorcode = 1, errormessage = "DESIGNATION IS ALREADY EXISTS" };
		//		return BadRequest(error);
		//	}
		//	else
		//	{
		//		var success = new { errorcode = 0, errormessage = "SUCCESS" };
		//		return Ok(success);
		//	}

		//	//return Ok("SUCCESS");

		//}
          //#endregion
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

		//#region  UpdateDesignation
		//[HttpPut("UpdateDesignation")]
		//public IActionResult UpdateDesignation(DesignationModel designationmodel)
		//{
		//	try
		//	{
		//		var response = _designationService.UpdateDesignation(designationmodel);

		//		if (response == 0 )
		//		{
		//			return BadRequest(new { message = "FAILED TO ADD DESIGNATION" });
		//		}
		//		else if(response < 0)
		//		{
		//                  return Ok("Data already exists");
		//              }
		//		else if (response > 0)
		//		{
		//			return Ok("SUCCESS");
		//		}
		//		else
		//		{
		//			return Ok("Something went wrong");
		//		}

		//	}
		//	catch (Exception ex)
		//	{
		//		return BadRequest(new { message = ex.Message });
		//	}
		//}
		//#endregion

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
