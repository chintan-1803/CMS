using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CMS.Controllers
{
	public class RoleController : Controller
	{
		private readonly IRole _role_Interface;
		public RoleController(IRole role_Interface)
		{
			_role_Interface = role_Interface;
		}

		[HttpGet]
		public IActionResult Rolelist()

		{
			//pass the session
			var jsonData = HttpContext.Session.GetString("RoleDataList");

			List<RoleModel> data;

			if (jsonData == null)
			{
				var response = _role_Interface.Rolelist();
				data = JsonConvert.DeserializeObject<List<RoleModel>>(response.Content);
				var RoleData = JsonConvert.SerializeObject(data);
				HttpContext.Session.SetString("RoleDataList", RoleData);
			}
			else
			{
				data = JsonConvert.DeserializeObject<List<RoleModel>>(jsonData);
			}
			return View(data);
			//var response = _role_Interface.Rolelist();
			//var data = JsonConvert.DeserializeObject<List<RoleModel>>(response.Content);

			//if (data != null)
			//{
			//	//return RedirectToAction("DesignationPage", "Designation",new { data });
			//	return View(data);
			//}
			//else
			//{
			//	return View();
			//}

		}

		[HttpPost]
		public IActionResult AddRolelist(RoleModel roleModel)
		{
			//var errors = ModelState.Values.SelectMany(v => v.Errors);

			roleModel.create_User = HttpContext.Session.GetString("Username");
			var response = _role_Interface.AddRolelist(roleModel);
			if (!response.IsSuccessful)
			{
				return BadRequest(response);
			}
			if (response != null)
			{
				HttpContext.Session.Remove("RoleDataList");
				return Json(new { success = true, message = "Role Added successfully." });
			}
			else
			{
				return BadRequest(response);
			}

		}

		[HttpPut]
		public IActionResult UpdateRolelist(RoleModel rolemodel)
		{
            //var errors = ModelState.Values.SelectMany(v => v.Errors);

            rolemodel.Change_user = HttpContext.Session.GetString("Username");
            var response = _role_Interface.UpdateRolelist(rolemodel);
			if (!response.IsSuccessful)
			{
				return BadRequest(response);
			}
			else if (response.Content == "\"SUCCESS\"")
			{
				HttpContext.Session.Remove("RoleDataList");
				return Json(new { success = true, message = "Role updated successfully." });
			}
			else if (response != null)
			{
				return Json(new { success = false/*, message = "Role updated successfully."*/ });
			}
			else
			{
				return BadRequest(response);
			}
		}

		[HttpPut]
		public IActionResult DeleteRolelist(RoleModel Role_ID)
		{
			//var errors = ModelState.Values.SelectMany(v => v.Errors);

			var response = _role_Interface.DeleteRoleitem(Role_ID);

			if (response != null)
			{
				HttpContext.Session.Remove("RoleDataList");
				return Json(new { success = true, message = "Role deleted successfully." });
			}
			else
			{
				return BadRequest(response);
			}
		}

	}
}
