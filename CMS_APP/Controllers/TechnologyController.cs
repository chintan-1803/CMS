using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Net;

namespace CMS.Controllers
{
	[Authorize(Roles = "Admin")]
	public class TechnologyController : Controller
	{
		private readonly ITechnology _technology_Interface;
		public TechnologyController(ITechnology technology_Interface)
		{
			_technology_Interface = technology_Interface;
		}
		[HttpGet]
		public IActionResult TechnologyList(int pageNumber = 1, int pageSize = 5)
		{
			var jsonData = HttpContext.Session.GetString("TechnologyList");
			AllPaginationModel data;
			var response = _technology_Interface.Technologylist(pageNumber, pageSize, out int totalItems);

			if (jsonData == null)
			{
				if (response.StatusCode == HttpStatusCode.OK)
				{
					data = JsonConvert.DeserializeObject<AllPaginationModel>(response.Content);
					var technologyData = JsonConvert.SerializeObject(data);
					HttpContext.Session.SetString("TechnologyList", technologyData);
				}
				else
				{
					return View("Error"); // Return an error view or handle the error appropriately
				}
			}
			else
			{
				data = JsonConvert.DeserializeObject<AllPaginationModel>(response.Content);
			}

			var totalPages = (int)Math.Ceiling((double)data.TotalItems / pageSize);

			data.PageSize = pageSize;
			data.CurrentPage = pageNumber;
			data.TotalPages = totalPages;

			var technologyList = data.technologyModel;

			var viewModel = new TechnologyViewModel
			{
				Technologies = technologyList,
				PaginationModel = data
			};

			return View(viewModel);
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
