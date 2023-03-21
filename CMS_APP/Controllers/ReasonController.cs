using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace CMS.Controllers
{
    public class ReasonController : Controller
    {
        private readonly IReason _reason_Interface;
        public ReasonController(IReason reason_Interface)
        {
            _reason_Interface = reason_Interface;
        }


        [HttpGet]
        public IActionResult Reasonlist()

        {
            if (ModelState.IsValid)
            {
                var response = _reason_Interface.Reasonlist();
                var data = JsonConvert.DeserializeObject<List<ReasonModel>>(response.Content);

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
        public IActionResult AddReasonlist(ReasonModel reasonData)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors);
            if (ModelState.IsValid)
            {
                reasonData.create_Date = DateTime.Now;

                var response = _reason_Interface.AddDesignationlist(reasonData);

                if (response != null)
                {
                    return RedirectToAction("Reasonlist","Reason");
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
		public IActionResult UpdateReasonlist(ReasonModel reasonmodel)
		{
			var errors = ModelState.Values.SelectMany(v => v.Errors);
			if (ModelState.IsValid)
			{
				reasonmodel.change_Date = DateTime.Now;

				var response = _reason_Interface.UpdateReasonlist(reasonmodel);


				if (response != null)
				{
					return RedirectToAction("Reasonlist", " Reason");
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
		public IActionResult DeleteReasonlist(ReasonModel Reason_ID)
		{
			var errors = ModelState.Values.SelectMany(v => v.Errors);
			if (ModelState.IsValid)
			{


				var response = _reason_Interface.DeleteReasonitem(Reason_ID);


				if (response != null)
				{
					return RedirectToAction("Reasonlist", " Reason");
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
