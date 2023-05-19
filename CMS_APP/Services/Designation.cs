using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;
using System.Data;
using System.Data.SqlClient;
using System.Net;

namespace CMS.Services
{
    public class Designation : IDesignation
    {
		public RestResponse Designationlist(int pageNumber, int pageSize, out int totalItems)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DesignationPath);
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
					throw new Exception("Failed to retrieve the designation list from the Web API.");
				}
			}
			catch (Exception ex)
			{
				throw new ArgumentNullException("FAILED TO VIEW DESIGNATION", ex);
			}
		}


        public RestResponse AddDesignationlist(DesignationModel designationData)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.AddDesignation);
            RestRequest request = new RestRequest() { Method = Method.Post };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(designationData), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<DesignationModel>(request);
            return response;

        }

        public RestResponse UpdateDesignationlist(DesignationModel updatedesignationData)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.UpdateDesignation);
            RestRequest request = new RestRequest() { Method = Method.Put };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(updatedesignationData), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<DesignationModel>(request);
            return response;

        }

		public RestResponse DeleteDesignationitem(DesignationModel Designation_ID)
		{
			var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DeleteDesignation);
			RestRequest request = new RestRequest() { Method = Method.Put };
			request.AddHeader("Content-Type", "application/json");
			request.AddParameter("application/json", JsonConvert.SerializeObject(Designation_ID), ParameterType.RequestBody);
			// Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
			var response = client.Execute<DesignationModel>(request);
			return response;
		}
	}
}
