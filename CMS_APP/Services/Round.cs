using CMS.ApplicationHelpers;
using CMS.Interfaces;
using CMS.Models;
using Newtonsoft.Json;
using RestSharp;

namespace CMS.Services
{
    public class Round : IRound
    {
        public RestResponse Roundlist()
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.RoundPath);
            RestRequest request = new RestRequest() { Method = Method.Get };
            request.AddHeader("Content-Type", "application/json");
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            RestResponse response = client.Execute(request);
            return response;

        }
        public RestResponse AddRound(RoundModel roundModel)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.AddRound);
            RestRequest request = new RestRequest() { Method = Method.Post };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(roundModel), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<RoundModel>(request);
            return response;

        }

        public RestResponse UpdateRoundlist(RoundModel roundModel)
        {

            var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.UpdateRound);
            RestRequest request = new RestRequest() { Method = Method.Put };
            request.AddHeader("Content-Type", "application/json");
            request.AddParameter("application/json", JsonConvert.SerializeObject(roundModel), ParameterType.RequestBody);
            // Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
            var response = client.Execute<RoundModel>(request);
            return response;

        }
		public RestResponse DeleteRounditem(RoundModel Round_ID)
		{

			var client = new RestClient(WebApiRelativeURLs.BaseURL + WebApiRelativeURLs.DeleteRound);
			RestRequest request = new RestRequest() { Method = Method.Put };
			request.AddHeader("Content-Type", "application/json");
			request.AddParameter("application/json", JsonConvert.SerializeObject(Round_ID), ParameterType.RequestBody);
			// Add any query string parameters to the URL, e.g. client.AddQueryParameter("paramName", "paramValue")
			var response = client.Execute<RoundModel>(request);
			return response;

		}
	}
}
