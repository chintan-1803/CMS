using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
	public interface IDesignation_Interface
    {
        Task<List<DesignationModel>> GetAllDesignation();
        string AddDesignation([FromBody] DesignationModel designationModel);
        public int UpdateDesignation(DesignationModel designationModel);
        public int DeleteDesignationByid(DesignationModel Designation_ID);

        /* List<DesignationModel> designations = await designationService.GetDesignationsByPage(pageNumber, rowsOfPage);*/
        Task<List<DesignationModel>> GetDesignationsByPage(int pageNumber, int rowsOfPage);
    }
}
