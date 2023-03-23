using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CMS.Controllers
{
	public class TechnologyController : Controller
	{
		private readonly ITechnology _technology_Interface;
		public TechnologyController(ITechnology technology_Interface)
		{
			_technology_Interface = technology_Interface;
		}
		[HttpGet]
		public IActionResult Technologylist()
		{
			var response = _technology_Interface.Technologylist();
			var data = JsonConvert.DeserializeObject<List<TechnologyModel>>(response.Content);

			if (data != null)
			{

				return View(data);
			}
			else
			{
				return View();
			}
		}

		[HttpPost]
		public IActionResult AddTechnologylist(TechnologyModel technologyData)
		{
			var response = _technology_Interface.AddTechnology(technologyData);
			if (!response.IsSuccessful)
			{
				return BadRequest(response);
			}
			if (response != null)
			{
				return Json(new { });
			}
			else
			{
				return BadRequest(response);
			}

		}

		[HttpPut]
		public IActionResult UpdateTechnologylist(TechnologyModel technologyData)
		{
			var response = _technology_Interface.UpdateTechnologylist(technologyData);
			if (!response.IsSuccessful)
			{
				return BadRequest(response);
			}
			if (response != null)
			{
				return Json(new { });
			}
			else
			{
				return BadRequest(response);
			}
		}

		[HttpPut]
		public IActionResult DeleteTechnologylist(TechnologyModel Technology_ID)
		{
			var response = _technology_Interface.DeleteTechnologyitem(Technology_ID);
			if (response != null)
			{
				return Json(new { });
			}
			else
			{
				return BadRequest(response);
			}
		}
	}
}
