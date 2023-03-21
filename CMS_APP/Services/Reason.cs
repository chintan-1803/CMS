using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;

namespace CMS.Services
{
    public class Reason : IReason
    {
        public RestResponse Reasonlist()
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.ReasonPath);
            RestRequest request = new RestRequest() { Method = Method.Get };
            request.AddHeader("Content-Type", "application/json");
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            RestResponse response = client.Execute(request);
            return response;

        }
    public RestResponse AddDesignationlist(ReasonModel reasonModel)
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
