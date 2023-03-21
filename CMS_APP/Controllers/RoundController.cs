using CMS.Interfaces;
using CMS.Models;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using RoundModel = CMS.Models.RoundModel;

namespace CMS.Controllers
{
    public class RoundController : Controller
    {
        private readonly IRound _round_Interface;
        public RoundController(IRound round_Interface)
        {
            _round_Interface = round_Interface;
        }
        [HttpGet]
        public IActionResult Roundlist()

        {
            if (ModelState.IsValid)
            {
                var response = _round_Interface.Roundlist();
                var data = JsonConvert.DeserializeObject<List<RoundModel>>(response.Content);

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
        public IActionResult AddRoundlist(RoundModel roundData)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors);
            if (ModelState.IsValid)
            {
                roundData.create_Date = DateTime.Now;

                var response = _round_Interface.AddRound(roundData);
                if (response != null)
                {
                    return RedirectToAction("Roundlist","Round");
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
        public IActionResult UpdateRoundlist(RoundModel roundData)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors);
            if (ModelState.IsValid)
            {
                roundData.change_Date = DateTime.Now;

                var response = _round_Interface.UpdateRoundlist(roundData);


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
		public IActionResult DeleteRoundlist(RoundModel Round_ID)
		{
			var errors = ModelState.Values.SelectMany(v => v.Errors);
			if (ModelState.IsValid)
			{


				var response = _round_Interface.DeleteRounditem(Round_ID);


				if (response != null)
				{
					return RedirectToAction("Roundlist", "Round");
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
