using CMS.Interfaces;
using CMS.Models;
using CMS.Services;
using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CMS.Controllers
{
    /*[Authorize]*/
    public class CandidateController : Controller
    {
		private readonly IMasterData _masterdata;
		private readonly ICandidate _candidateData;
		public CandidateController(IMasterData masterdata, ICandidate candidateData)
		{
			_masterdata = masterdata;
			_candidateData = candidateData;
		}
		[HttpGet]
        public IActionResult CandidateRegistration()
        {
			var masterDataResponse = _masterdata.AllMasterDatalist();
			var masterDataList = JsonConvert.DeserializeObject<AllMasterDataModel>(masterDataResponse.Content);
			ViewBag.TechnologyList = masterDataList.TechnologyData;
			return View();
        }

        [HttpPost]
        public IActionResult CandidateRegistration(CandidateMasterEntity candidateModel)
        {
			
			//reasonData.create_User = HttpContext.Session.GetString("Username");
			var response = _candidateData.AddCandidate(candidateModel);
			if (!response.IsSuccessful)
			{
				return BadRequest(response);
			}
			if (response != null)
			{
				//HttpContext.Session.Remove("ReasonDataList");
				return Json(new { success = true, message = "added successfully." });
			}
			else
			{
				return BadRequest(response);
			}



			//return View();
        }
    }
}
