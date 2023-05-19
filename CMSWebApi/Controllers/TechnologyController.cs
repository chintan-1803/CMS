﻿using Azure;
using CMSWebApi.Dapper;
using CMSWebApi.Interfaces;
using CMSWebApi.Models;
using CMSWebApi.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Controllers
{
   
    [ApiController]
    [Route("[controller]")]
    public class TechnologyController : Controller
    {
        private readonly ITechnology_Interface _TechnologyService;
        private readonly IDapper _dapper;
        public TechnologyController(ITechnology_Interface TechnologyService, IDapper dapper)
        {
            _TechnologyService = TechnologyService;
            _dapper = dapper;

        }

		#region Get Technology Without Async
		
		[HttpGet("Technology")]
		public IActionResult Technology(int pageNumber = 1, int pageSize = 5)
		{
			try
			{
				var responseTask = _TechnologyService.GetAllTechnology(pageNumber, pageSize, out int totalItems);
				var response = responseTask.Result;

				if (response == null)
				{
					return BadRequest(new { message = "NULL VALUE" });
				}

				var totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

				var model = new AllPaginationModel
				{
					technologyModel = response,
					TotalItems = totalItems,
					PageSize = pageSize,
					CurrentPage = pageNumber,
					TotalPages = totalPages
				};

				return Ok(model);
			}
			catch (Exception ex)
			{
				return BadRequest(new { message = ex.Message });
			}
		}

		#endregion

		#region  AddTechnology
		[HttpPost("AddTechnology")]
        public IActionResult AddTechnology(TechnologyModel technologyModel)
        {
            var result = _TechnologyService.AddTechnology(technologyModel);

            //if (result == null)
            //{
            //    return BadRequest(new { message = "FAILED TO ADD Technology" });
            //}
            if (result == "Unsucessfull")
            {
                return BadRequest(new { message = "TECHNOLOGY IS ALREADY EXISTS" });
            }
            return Ok("SUCCESS");
        }
        #endregion

        #region  UpdateTechnology
        [HttpPut("UpdateTechnology")]
        public IActionResult UpdateTechnology(TechnologyModel technologyModel)
        {
            var response = _TechnologyService.UpdateTechnology(technologyModel);

            //if (response == 0 || response < 0)
            //{
            //    return BadRequest(new { message = "FAILED TO ADD TECHNOLOGY" });
            //}
            if (response < 0)
            {
                return Ok("Data already exists");
            }
            else if (response > 0)
            {
                return Ok("SUCCESS");
            }
            else
            {
                return Ok("Something went wrong");
            }
        }
        #endregion

        #region  DeleteTechnology
        [HttpPut("DeleteTechnology")]
        public IActionResult DeleteTechnology(TechnologyModel Technology_Id)
        { 
            var response = _TechnologyService.DeleteTechnology(Technology_Id);

                //if (response == 0)
                //{
                //    return BadRequest(new { message = "FAILED TO ADD TECHNOLOGY" });
                //}
                if (response > 0)
                {
                    return Ok("SUCESS");
                }
                else
                {
                    return Ok("Something went wrong");
                }
            }
        #endregion
    }
}
