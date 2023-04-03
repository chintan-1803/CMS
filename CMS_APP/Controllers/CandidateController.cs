using CMS.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CMS.Controllers
{
    /*[Authorize]*/
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
