using CMSWebApi.Models;

namespace CMSWebApi.Interfaces
{
    public interface IDesignation_Interface
    {
        Task<List<DesignationModel>> GetAllDesignation();
        string AddDesignation(DesignationModel designationModel);
        public int UpdateDesignation(DesignationModel designationModel);
        public int DeleteDesignationByid(DesignationModel Designation_ID);
    }
}
