using Azure;
using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CMSWebApi.Controllers
{
	[ApiController]
	[Route("[controller]")]
	public class MasterDataController : Controller
	{
		private readonly IAllMsaterData_Interface _masterdataService;
		private readonly IDapper _dapper;

        public MasterDataController(IAllMsaterData_Interface masterdataService, IDapper dapper)
        {
			_masterdataService = masterdataService;
			_dapper = dapper;

		}

		[HttpGet("AllMasterDatalist")]
		public IActionResult AllMasterDatalist()
		{
			try
			{
				var responseTask = _masterdataService.GetAllModels();
				//responseTask.Wait();
				var response = responseTask.Result;

				if (responseTask == default)
				{
					return BadRequest(new { message = "NULL VALUE" });
				}
				//var json = JsonConvert.SerializeObject(response);
				//return Ok(json);


				return Ok(new { DesignationData = response.Item1, ReasonData = response.Item2, RoleData = response.Item3, RoundData = response.Item4, TechnologyData = response.Item5 });;
				//return Json(response);
			}
			catch (Exception ex)
			{
				return BadRequest(new { message = ex.Message });
			}
		}
		//public IActionResult Index()
		//{
		//	return View();
		//}
	}
}
