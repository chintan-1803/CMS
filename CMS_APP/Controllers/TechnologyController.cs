using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CMS.Controllers
{
  /*  [Authorize]*/
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

			//pass the session
			var jsonData = HttpContext.Session.GetString("TechnologyList");

			List<TechnologyModel> data;
			if (jsonData == null)
			{
				var response = _technology_Interface.Technologylist();
				data = JsonConvert.DeserializeObject<List<TechnologyModel>>(response.Content);
				var TechnologyData = JsonConvert.SerializeObject(data);
				HttpContext.Session.SetString("TechnologyList", TechnologyData);
			}
			else
			{
				data = JsonConvert.DeserializeObject<List<TechnologyModel>>(jsonData);
			}
			return View(data);

			//var response = _technology_Interface.Technologylist();
			//var data = JsonConvert.DeserializeObject<List<TechnologyModel>>(response.Content);

			//if (data != null)
			//{

			//	return View(data);
			//}
			//else
			//{
			//	return View();
			//}
		}

		[HttpPost]
		public IActionResult AddTechnologylist(TechnologyModel technologyData)
		{
            technologyData.create_User = HttpContext.Session.GetString("Username");
            var response = _technology_Interface.AddTechnology(technologyData);
			if (!response.IsSuccessful)
			{
				return BadRequest(response);
			}
			if (response != null)
			{
				HttpContext.Session.Remove("TechnologyList");
				return Json(new { success = true, message = "Technology added successfully." });
			}
			else
			{
				return BadRequest(response);
			}

		}

		[HttpPut]
		public IActionResult UpdateTechnologylist(TechnologyModel updatetechnologyData)
		{
            updatetechnologyData.change_user = HttpContext.Session.GetString("Username");
            var response = _technology_Interface.UpdateTechnologylist(updatetechnologyData);
            if (response.Content == "\"SUCCESS\"")
            {
				HttpContext.Session.Remove("TechnologyList");
				return Json(new { success = true, message = "Technology updated successfully." });
            }
            if (response != null)
            {
                return Json(new { success = false });
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
				HttpContext.Session.Remove("TechnologyList");
				return Json(new { success = true, message = "Technology deleted successfully." });
			}
			else
			{
				return BadRequest(response);
			}
		}
	}
}
