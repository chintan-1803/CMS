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
    
    public class CandidateController : Controller
    {
		private readonly IMasterData _masterdata;
		private readonly ICandidate _candidateDatamodal;
		public CandidateController(IMasterData masterdata, ICandidate candidateDatamodal)
		{
			_masterdata = masterdata;
			_candidateDatamodal = candidateDatamodal;
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
			var response = _candidateDatamodal.AddCandidate(candidateModel);
			if (!response.IsSuccessful)
			{
				if (response.Content == "\"Unsuccessful\"")
				{
					return BadRequest(new { message = "Email already registered. Please try again." });
				}
				//return BadRequest(new { message = errorMessage });
				return BadRequest(response);
				
			}
			else
			{
				//HttpContext.Session.Remove("ReasonDataList");
				return Json(new { success = true, message = "Congratulations! Your form has been successfully submitted!" });
			}
		}

		//Admin

		[HttpGet]
		[Authorize(Roles = "Interviewer,Admin")]
		public IActionResult AllCandidatelist()
		{
            // Get the list of designations from the API
            var response = _candidateDatamodal.GetCandidateList();
			var data = JsonConvert.DeserializeObject<List<CandidateMasterEntity>>(response.Content);
			if (data != null)
			{
				return View(data);
			}
			else
			{
				return View();
			}
		}

		//public FileResult GetResume(string base64String)
		//{
		//	// Convert the Base64 string to a byte array
		//	var bytes = Convert.FromBase64String(base64String);

		//	// Return the byte array as a PDF file
		//	return File(bytes, "application/pdf");
		//}

	}
}
