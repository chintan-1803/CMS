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
			var response = _role_Interface.Rolelist();
			var data = JsonConvert.DeserializeObject<List<RoleModel>>(response.Content);

			if (data != null)
			{
				//return RedirectToAction("DesignationPage", "Designation",new { data });
				return View(data);
			}
			else
			{
				return View();
			}

		}

		[HttpPost]
		public IActionResult AddRolelist(RoleModel roleModel)
		{
			//var errors = ModelState.Values.SelectMany(v => v.Errors);
			var response = _role_Interface.AddRolelist(roleModel);
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
		public IActionResult UpdateRolelist(RoleModel rolemodel)
		{
			//var errors = ModelState.Values.SelectMany(v => v.Errors);
			var response = _role_Interface.UpdateRolelist(rolemodel);
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
		public IActionResult DeleteRolelist(RoleModel Role_ID)
		{
			//var errors = ModelState.Values.SelectMany(v => v.Errors);

			var response = _role_Interface.DeleteRoleitem(Role_ID);

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
