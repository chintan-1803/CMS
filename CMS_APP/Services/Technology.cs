using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;

namespace CMS.Services
{
    public class Technology : ITechnology
    {
        public RestResponse Technologylist()
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.TechnologyPath);
            RestRequest request = new RestRequest() { Method = Method.Get };
            request.AddHeader("Content-Type", "application/json");
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            RestResponse response = client.Execute(request);
            return response;

        }
        public RestResponse AddTechnology(TechnologyModel technologyModel)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.AddTechnology);
            RestRequest request = new RestRequest() { Method = Method.Post };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(technologyModel), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<TechnologyModel>(request);
            return response;

        }
        public RestResponse UpdateTechnologylist(TechnologyModel technologyModel)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.UpdateTechnology);
            RestRequest request = new RestRequest() { Method = Method.Put };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(technologyModel), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<TechnologyModel>(request);
            return response;

        }

        public RestResponse DeleteTechnologyitem(TechnologyModel Technology_ID)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DeleteTechnology);
            RestRequest request = new RestRequest() { Method = Method.Put };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(Technology_ID), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<TechnologyModel>(request);
            return response;

        }
    }
}
