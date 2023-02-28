using CMS.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMS.Controllers
{
    public class CandidateController : Controller
    {
        [HttpGet]
        public IActionResult CandidateRegistration()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CandidateRegistration(CandidateMasterEntity candidateMasterEntity)
        {
            return View();
        }
    }
}
