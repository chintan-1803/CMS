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
            if (ModelState.IsValid)
            {
                var response = _designation_Interface.Designationlist();
                var data = JsonConvert.DeserializeObject<List<DesignationModel>>(response.Content);

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
        public IActionResult AddDesignationlist(DesignationModel designationData)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors);
            if (ModelState.IsValid)
            {
                designationData.create_Date = DateTime.Now;
                
                var response = _designation_Interface.AddDesignationlist(designationData);

                if (response != null)
                {
                    return RedirectToAction("Designationlist", " Designation");
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
        public IActionResult UpdateDesignationlist(DesignationModel updatedesignationData)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors);
            if (ModelState.IsValid)
            {
                updatedesignationData.change_Date = DateTime.Now;

                var response = _designation_Interface.UpdateDesignationlist(updatedesignationData);


                if (response != null)
                {
                    return RedirectToAction("Designationlist", " Designation");
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
		public IActionResult DeleteDesignationlist(DesignationModel Designation_ID)
		{
			var errors = ModelState.Values.SelectMany(v => v.Errors);
			if (ModelState.IsValid)
			{
				var response = _designation_Interface.DeleteDesignationitem(Designation_ID);
				if (response != null)
				{
					return RedirectToAction("Designationlist", " Designation");
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
	}
}
