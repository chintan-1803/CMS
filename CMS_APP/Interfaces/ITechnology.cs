using CMS.Models;
using RestSharp;

namespace CMS.Interfaces
{
    public interface ITechnology
    {
        public RestResponse Technologylist();

        public RestResponse AddTechnology(TechnologyModel technologyModel);

        public RestResponse UpdateTechnologylist(TechnologyModel technologyModel);

        public RestResponse DeleteTechnologyitem(TechnologyModel Technology_ID);
    }
}
