using CMS.Interfaces;
using CMS.Models;
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
			// Get the list of designations from the API
			var response = _designation_Interface.Designationlist();
			var data = JsonConvert.DeserializeObject<List<DesignationModel>>(response.Content);

			var data1 = JsonConvert.DeserializeObject<List<DesignationModel>>(response.Content);
			var jsonData = JsonConvert.SerializeObject(data1);
			HttpContext.Session.SetString("designationList", jsonData);

			// Serialize the data to a string
			//var serializedData = JsonConvert.SerializeObject(data);

			//// Store the serialized data in session
			//HttpContext.Session.SetString("DesignationList", serializedData);

			// Return the view with the list of designations
			return View(data);
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
