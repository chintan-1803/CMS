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
	public class RoleController : Controller
	{
		private readonly IRole _role_Interface;
		public RoleController(IRole role_Interface)
		{
			_role_Interface = role_Interface;
		}
		[HttpGet]
		public IActionResult RoleList(int pageNumber = 1, int pageSize = 5)
		{
			var jsonData = HttpContext.Session.GetString("RoleDataList");
			AllPaginationModel data;
			var response = _role_Interface.Rolelist(pageNumber, pageSize, out int totalItems);

			if (jsonData == null)
			{
				if (response.StatusCode == HttpStatusCode.OK)
				{
					data = JsonConvert.DeserializeObject<AllPaginationModel>(response.Content);
					var roleData = JsonConvert.SerializeObject(data);
					HttpContext.Session.SetString("RoleDataList", roleData);
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

			var roleList = data.roleModel;

			var viewModel = new RoleViewModel
			{
				Roles = roleList,
				PaginationModel = data
			};

			return View(viewModel);
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
