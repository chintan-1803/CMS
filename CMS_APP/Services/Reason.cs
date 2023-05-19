using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;
using System.Net;

namespace CMS.Services
{
    public class Reason : IReason
    {
		public RestResponse Reasonlist(int pageNumber, int pageSize, out int totalItems)
		{
			try
			{
				var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.ReasonPath);
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
					throw new Exception("Failed to retrieve the interviewer list from the Web API.");
				}
			}
			catch (Exception ex)
			{
				throw new ArgumentNullException("FAILED TO VIEW INTERVIEWER", ex);
			}
		}
		
		public RestResponse AddReasonlist(ReasonModel reasonModel)
		{

        var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.AddReason);
        RestRequest request = new RestRequest() { Method = Method.Post };
        request.AddHeader("Content-Type", "application/json");
        request.AddParameter("application/json", JsonConvert.SerializeObject(reasonModel), ParameterType.RequestBody);
        // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
        var response = client.Execute<ReasonModel>(request);
        return response;

    }
		public RestResponse UpdateReasonlist(ReasonModel reasonModel)
		{

			var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.UpdateReason);
			RestRequest request = new RestRequest() { Method = Method.Put };
			request.AddHeader("Content-Type", "application/json");
			request.AddParameter("application/json", JsonConvert.SerializeObject(reasonModel), ParameterType.RequestBody);
			// Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
			var response = client.Execute<ReasonModel>(request);
			return response;

		}
		public RestResponse DeleteReasonitem(ReasonModel Reason_ID)
		{

			var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DeleteReason);
			RestRequest request = new RestRequest() { Method = Method.Put };
			request.AddHeader("Content-Type", "application/json");
			request.AddParameter("application/json", JsonConvert.SerializeObject(Reason_ID), ParameterType.RequestBody);
			// Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
			var response = client.Execute<ReasonModel>(request);
			return response;

		}

	}
}
