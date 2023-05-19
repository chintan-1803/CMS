using CMS.Interfaces;
using CMS.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Net;

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
        public IActionResult AllCandidateList(int pageNumber = 1, int pageSize = 5)
        {
            try
            {
                int totalItems;
                var response = _candidateDatamodal.GetCandidateList(pageNumber, pageSize, out totalItems);

                if (response.StatusCode == HttpStatusCode.OK)
                {
                    var responseBody = response.Content;
                    var model = JsonConvert.DeserializeObject<AllPaginationModel>(responseBody);

                    var totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

                    model.TotalItems = totalItems;
                    model.PageSize = pageSize;
                    model.CurrentPage = pageNumber;
                    model.TotalPages = totalPages;

                    var candidateMasterEntities = model.candidateMasterEntities;

                    var viewModel = new CandidateListViewModel
                    {
                        PaginationModel = model,
                        Candidates = candidateMasterEntities
                    };

                    return View(viewModel);
                }
                else
                {
                    return BadRequest(new { message = "Failed to retrieve candidate list" });
                }
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
    }
}
