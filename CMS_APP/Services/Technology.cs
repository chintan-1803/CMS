using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;
using System.Net;

namespace CMS.Services
{
    public class Technology : ITechnology
    {
		public RestResponse Technologylist(int pageNumber, int pageSize, out int totalItems)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.TechnologyPath);
				RestRequest request = new RestRequest() { Method = Method.Get };
				request.AddHeader("Content-Type", "application/json");
				request.AddParameter("pageNumber", pageNumber);
				request.AddParameter("pageSize", pageSize);
				var response = client.Execute(request);

				if (response.StatusCode == HttpStatusCode.OK)
				{
					var responseBody = response.Content;
					var data = JsonConvert.DeserializeObject<AllPaginationModel>(responseBody);

					totalItems = data.TotalItems;

					return response;
				}
				else
				{
					throw new Exception("Failed to retrieve the round list from the Web API.");
				}
			}
			catch (Exception ex)
			{
				throw new ArgumentNullException("FAILED TO VIEW ROUNDS", ex);
			}
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
