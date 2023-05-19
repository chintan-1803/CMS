using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
    public interface ITechnology
    {
        public RestResponse Technologylist(int pageNumber, int pageSize, out int totalItems);

        public RestResponse AddTechnology(TechnologyModel technologyModel);

        public RestResponse UpdateTechnologylist(TechnologyModel technologyModel);

        public RestResponse DeleteTechnologyitem(TechnologyModel Technology_ID);
    }
}
