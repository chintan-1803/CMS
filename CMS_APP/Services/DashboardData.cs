using CMS.ApplicationHelpers;
using CMS.Interfaces;
using RestSharp;

namespace CMS.Services
{
    public class DashboardDatalist : IDashboardDatalist
    {
        public RestResponse DashboardData()
        {
            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.Dashboarddata);
            RestRequest request = new RestRequest() { Method = Method.Get };
            request.AddHeader("Content-Type", "application/json");
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            RestResponse response = client.Execute(request);
            return response;

        }
    }
}
