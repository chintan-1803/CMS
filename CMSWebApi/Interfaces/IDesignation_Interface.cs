using CMSWebApi.Models;
using Microsoft.AspNetCore.Mvc;

namespace CMSWebApi.Interfaces
{
	public interface IDesignation_Interface
    {
        Task<List<DesignationModel>> GetAllDesignation(int pageNumber, int pageSize, out int totalItems);
        string AddDesignation([FromBody] DesignationModel designationModel);
        public int UpdateDesignation(DesignationModel designationModel);
        public int DeleteDesignationByid(DesignationModel Designation_ID);

    }
}
