using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
    public interface IDesignation
    {
        public RestResponse Designationlist(int pageNumber, int pageSize, out int totalItems);

        public RestResponse AddDesignationlist(DesignationModel designationData);

        public RestResponse UpdateDesignationlist( DesignationModel updatedesignationData);

		public RestResponse DeleteDesignationitem(DesignationModel Designation_ID);

	}
}
