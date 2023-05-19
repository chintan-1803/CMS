using Azure;
using CMS.Interfaces;
using CMS.Models;
using CMS.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Net;

namespace CMS.Controllers
{
	[Authorize(Roles = "Admin")]
	public class DesignationController : Controller
	{
		private readonly IDesignation _designation_Interface;
		private readonly IMasterData _masterdata;
		public DesignationController(IDesignation designation_Interface, IMasterData masterdata)
		{
			_designation_Interface = designation_Interface;
			_masterdata = masterdata;
		}

		[HttpGet]
		public IActionResult DesignationList(int pageNumber = 1, int pageSize = 5)
		{
			var jsonData = HttpContext.Session.GetString("DesignationList");
			AllPaginationModel data;
			var response = _designation_Interface.Designationlist(pageNumber, pageSize, out int totalItems);
			if (jsonData == null)
			{
				if (response.StatusCode == HttpStatusCode.OK)
				{
					data = JsonConvert.DeserializeObject<AllPaginationModel>(response.Content);
					var designationData = JsonConvert.SerializeObject(data);
					HttpContext.Session.SetString("DesignationList", designationData);
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

			var designationList = data.designationModel;

			var viewModel = new DesignationViewModel
			{
				Designations = designationList,
				PaginationModel = data
			};

			return View(viewModel);
		}

		
		[HttpPost]
		public IActionResult AddDesignationlist(DesignationModel designationData)
		{
			//var create_User = HttpContext.Session.GetString("create_User");
			designationData.create_User = HttpContext.Session.GetString("Username");

			var response = _designation_Interface.AddDesignationlist(designationData);
			if(!response.IsSuccessful){
				return BadRequest(response);
			}
			if (response != null)
			{
				HttpContext.Session.Remove("DesignationList");
				return Json(new { success = true, message = "Designation added successfully." });
			}
			else
			{
				return BadRequest(response);
			}
		}

		[HttpPut]
		public IActionResult UpdateDesignationlist(DesignationModel updatedesignationData)
		{
			updatedesignationData.Change_user = HttpContext.Session.GetString("Username");

			var response = _designation_Interface.UpdateDesignationlist(updatedesignationData);

			//updatedesignationData.create_User = create_User;

			if (!response.IsSuccessful)
			{
				//return Json(new {response});
				return BadRequest(response);
			}
			if(response.Content == "\"SUCCESS\""){
				HttpContext.Session.Remove("DesignationList");
				return Json(new { success = true, message = "Designation updated successfully." });
			}
			if (response != null)
			{
				return Json(new { success = false/*, message = "Designation updated successfully."*/ });
			}
			else
			{
				return BadRequest(response);
			}	
		}

		[HttpPut]
		public IActionResult DeleteDesignationlist(DesignationModel Designation_ID)
		{ 
			var response = _designation_Interface.DeleteDesignationitem(Designation_ID);
			if (response != null)
			{
				HttpContext.Session.Remove("DesignationList");
				return Json(new { success = true, message = "Designation deleted successfully." });
			}
			else
			{
				return BadRequest(response);
			}
		}
    }
}
