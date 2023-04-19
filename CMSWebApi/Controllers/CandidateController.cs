using CMS.Models;
using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
	[ApiController]
	[Route("[controller]")]
	public class CandidateController : Controller
	{
		private readonly ICandidate_Interface _candidateService;
		private readonly IDapper _dapper;
		public CandidateController(ICandidate_Interface candidateService, IDapper dapper)
		{
			_candidateService = candidateService;
			_dapper = dapper;

		}

		[HttpPost("AddCandidates")]
		public IActionResult AddCandidates(CandidateMasterEntity candidatedata)
		{
			var response = _candidateService.addCandidate(candidatedata);

			//if (response == null)
			//{
			//    return BadRequest(new { message = "FAILED TO ADD Reason" });
			//}
			if (response == "Unsuccessful")
			{
				return BadRequest(response);
			}
			return Ok("SUCCESS");
		}


		[HttpGet("Candidatelist")]
		public IActionResult Candidatelist()
		{
			try
			{
				var responseTask = _candidateService.GetAllCandidates();
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


		//public IActionResult Index()
		//{
		//	return View();
		//}
	}
}
