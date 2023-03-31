using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CMS.Controllers
{
    public class TechnologyController : Controller
    {
        private readonly ITechnology _technology_Interface;
        public TechnologyController(ITechnology technology_Interface)
        {
            _technology_Interface = technology_Interface;
        }
        [HttpGet]
        public IActionResult Technologylist()

        {
            if (ModelState.IsValid)
            {
                var response = _technology_Interface.Technologylist();
                var data = JsonConvert.DeserializeObject<List<TechnologyModel>>(response.Content);

				var data1 = JsonConvert.DeserializeObject<List<TechnologyModel>>(response.Content);
				var jsonData1 = JsonConvert.SerializeObject(data1);
				HttpContext.Session.SetString("technologyList", jsonData1);

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
        public IActionResult AddTechnologylist(TechnologyModel technologyData)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors);
            if (ModelState.IsValid)
            {
                technologyData.create_Date = DateTime.Now;

                var response = _technology_Interface.AddTechnology(technologyData);
                if (response != null)
                {
                    return RedirectToAction("Technologylist", "Technology");
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
        public IActionResult UpdateTechnologylist(TechnologyModel technologyData)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors);
            if (ModelState.IsValid)
            {
                technologyData.change_Date = DateTime.Now;

                var response = _technology_Interface.UpdateTechnologylist(technologyData);


                if (response != null)
                {
                    return RedirectToAction("Technologylist", "Technology");
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
        public IActionResult DeleteTechnologylist(TechnologyModel Technology_ID)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors);
            if (ModelState.IsValid)
            {


                var response = _technology_Interface.DeleteTechnologyitem(Technology_ID);


                if (response != null)
                {
                    return RedirectToAction("Technologylist", "Technology");
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
