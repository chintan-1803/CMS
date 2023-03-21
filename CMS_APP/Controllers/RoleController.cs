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
            if (ModelState.IsValid)
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
            else
            {
                return View();
            }

        }

        [HttpPost]
        public IActionResult AddRolelist(RoleModel roleModel)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors);
            if (ModelState.IsValid)
            {
                roleModel.create_Date = DateTime.Now;

                var response = _role_Interface.AddRolelist(roleModel);

                if (response != null)
                {
                    return RedirectToAction("Rolelist", "Role");
                }
                else
                {
                    return View();
                }
            }
            else
            {
                return View();
            }


        }

        [HttpPut]
        public IActionResult UpdateRolelist(RoleModel rolemodel)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors);
            if (ModelState.IsValid)
            {
                rolemodel.change_Date = DateTime.Now;

                var response = _role_Interface.UpdateRolelist(rolemodel);


                if (response != null)
                {
                    return RedirectToAction("Rolelist", " Role");
                }
                else
                {
                    return View();
                }
            }
            else
            {
                return View();
            }


        }

        [HttpPut]
        public IActionResult DeleteRolelist(RoleModel Role_ID)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors);
            if (ModelState.IsValid)
            {


                var response = _role_Interface.DeleteRoleitem(Role_ID);


                if (response != null)
                {
                    return RedirectToAction("Rolelist", "Role");
                }
                else
                {
                    return View();
                }
            }
            else
            {
                return View();
            }


        }

        public IActionResult Index()
        {
            return View();
        }
    }
}
