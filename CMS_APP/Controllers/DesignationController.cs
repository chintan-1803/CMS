using Azure;
using CMS.Interfaces;
using CMS.Models;
using CMS.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CMS.Controllers
{
    /*[Authorize]*/
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
		public IActionResult Designationlist()
		{
			// Get the list of designations from the API
			var jsonData = HttpContext.Session.GetString("DesignationList");

			if(jsonData == null) {
				var response = _designation_Interface.Designationlist();
				var data = JsonConvert.DeserializeObject<List<DesignationModel>>(response.Content);
			}
			

			//var masterDatalist = HttpContext.Session.GetString("masterDatalist");
			//add designation list into session
			//var data1 = JsonConvert.DeserializeObject<List<DesignationModel>>(response.Content);
			//var jsonData = JsonConvert.SerializeObject(data1);
			//HttpContext.Session.SetString("designationList", jsonData);

			if(jsonData == null){
				var masterDataResponse = _masterdata.AllMasterDatalist();
				var masterDataList = JsonConvert.DeserializeObject<AllMasterDataModel>(masterDataResponse.Content);
				//var designation = masterDataList.DesignationData;
				//var designation 
				var DesignationData = JsonConvert.SerializeObject(masterDataList.DesignationData);
				HttpContext.Session.SetString("DesignationList", DesignationData);

			}

			//var jsonData = JsonConvert.SerializeObject(jsonData1);
			
			var designationList = JsonConvert.DeserializeObject<List<DesignationModel>>(jsonData);

			//var masterDataResponse = _masterdata.AllMasterDatalist();
			//var masterDataList = JsonConvert.DeserializeObject<AllMasterDataModel>(masterDataResponse.Content);
			//var DesignationData = JsonConvert.SerializeObject(masterDataList.DesignationData);
			//var data = JsonConvert.DeserializeObject(DesignationData);
			//if (masterDataList.DesignationData == null) {

			//	HttpContext.Session.SetString("DesignationList", DesignationData);
			//}




			//if (data != null)
			//{
			//	var masterDataResponse = _masterdata.AllMasterDatalist();
			//	var jsonData = JsonConvert.SerializeObject(masterDataResponse);
			//	HttpContext.Session.SetString("masterDatalist", jsonData);
			//	return View(data);
			//}
			if (designationList != null)
			{
				////var masterDataResponse = _masterdata.AllMasterDatalist();
				//var jsonData = JsonConvert.SerializeObject(masterDataResponse);
				//HttpContext.Session.SetString("masterDatalist", jsonData);
				return View(designationList);
			}
			else
			{
				return View();
			}
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
				HttpContext.Session.Remove("masterDatalist");
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
				HttpContext.Session.Remove("masterDatalist");
				return Json(new { success = true, message = "Designation deleted successfully." });
			}
			else
			{
				return BadRequest(response);
			}
		}
    }
}
