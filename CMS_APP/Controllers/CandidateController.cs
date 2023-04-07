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
		public CandidateController(IMasterData masterdata)
		{
			_masterdata = masterdata;
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
        public IActionResult CandidateRegistration(CandidateMasterEntity candidateMasterEntity)
        {


            return View();
        }
    }
}
