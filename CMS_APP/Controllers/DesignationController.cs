using CMS.Interfaces;
using CMS.Models;
using CMS.Services;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CMS.Controllers
{
	public class DesignationController : Controller
	{
		private readonly IDesignation _designation_Interface;
		public DesignationController(IDesignation designation_Interface)
		{
			_designation_Interface = designation_Interface;

		}

		[HttpGet]
		public IActionResult Designationlist()
		{
			var response = _designation_Interface.Designationlist();
			var data = JsonConvert.DeserializeObject<List<DesignationModel>>(response.Content);
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
		public IActionResult AddDesignationlist(DesignationModel designationData)
		{
			var response = _designation_Interface.AddDesignationlist(designationData);
			if(!response.IsSuccessful){
				return Json(new {response.Content});

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
		public IActionResult UpdateDesignationlist(DesignationModel updatedesignationData)
		{
			var response = _designation_Interface.UpdateDesignationlist(updatedesignationData);
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
		public IActionResult DeleteDesignationlist(DesignationModel Designation_ID)
		{
			var response = _designation_Interface.DeleteDesignationitem(Designation_ID);
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
