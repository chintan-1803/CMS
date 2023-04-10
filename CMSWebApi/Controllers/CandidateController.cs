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
			var response = _candidateService.AddCandidate(candidatedata);

			//if (response == null)
			//{
			//    return BadRequest(new { message = "FAILED TO ADD Reason" });
			//}
			if (response == "Unsuccessful")
			{
				return BadRequest(new { message = "Reason IS ALREADY EXISTS" });
			}
			return Ok("SUCCESS");
		}
		public IActionResult Index()
		{
			return View();
		}
	}
}
